local UICardSet = class("UICardSet", UIBaseWindow)
local base = UIBaseWindow
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local UINCardSetHeadItem = require("Game.CardSet.UI.Set.UINCardSetHeadItem")
local UINCardSetCardItem = require("Game.CardSet.UI.Set.UINCardSetCardItem")
local UINCardStBaseItem = require("Game.CardSet.UI.Set.UINCardStBaseItem")
local UINCardSetDot = require("Game.CardSet.UI.Set.UINCardSetDot")
local UINCardSetLine = require("Game.CardSet.UI.Set.UINCardSetLine")
local UINCardSetRight = require("Game.CardSet.UI.Set.RightNode.UINCardSetRight")
local UINCardSetDown = require("Game.CardSet.UI.Set.DownNode.UINCardSetDown")
local LINE_SIZE_HEAD = 34
local LINE_SIZE_MID = 44
local cs_Ease = CS.DG.Tweening.Ease
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UICardSet:OnInit()
  self.__cardHolderDic = {}
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BcakAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self._OnClickReset)
  self.headItemPool = UIItemPool.New(UINCardSetHeadItem, self.ui.obj_HeadItem)
  self.ui.obj_HeadItem.gameObject:SetActive(false)
  self.cardItemPool = UIItemPool.New(UINCardSetCardItem, self.ui.obj_cardItem)
  self.ui.obj_cardItem.gameObject:SetActive(false)
  self.ui.cardStBaseItem.transform:SetParent(self.ui.obj_cardItem.transform.parent)
  self._cardBaseItemPool = UIItemPool.New(UINCardStBaseItem, self.ui.cardStBaseItem, false)
  self.dotPool = UIItemPool.New(UINCardSetDot, self.ui.obj_dot)
  self.ui.obj_dot.gameObject:SetActive(false)
  self.linePool = UIItemPool.New(UINCardSetLine, self.ui.obj_line)
  self.ui.obj_line.gameObject:SetActive(false)
  self.rightNode = UINCardSetRight.New()
  self.rightNode:Init(self.ui.node_right)
  self.downNode = UINCardSetDown.New()
  self.downNode:Init(self.ui.node_down)
  self.ui.obj_Arrow:SetActive(false)
  self.__onCardChange = BindCallback(self, self.__OnCardChange)
  MsgCenter:AddListener(eMsgEventId.OnCardSetCardChange, self.__onCardChange)
  self.__onDiffChange = BindCallback(self, self.__OnDiffChange)
  MsgCenter:AddListener(eMsgEventId.OnCardSetDiffChange, self.__onDiffChange)
  self._OnDelayUpdateFunc = BindCallback(self, self._OnDelayUpdate)
  MsgCenter:AddListener(eMsgEventId.OnCardSetDelayUpd, self._OnDelayUpdateFunc)
end

function UICardSet:InitCardSet(cardSetCtrl, closeCallback)
  self.cardSetCtrl = cardSetCtrl
  self.closeCallback = closeCallback
  self.rightNode:InitCardSetRight(cardSetCtrl)
  self.downNode:InitCardDownNode(cardSetCtrl)
  self:GenDiffCardTypeHolder()
  self:RefreshAllCard(true)
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  self._cardSetData = cardSetData
  self._actCardSetData = self.cardSetCtrl:GetCdStActData()
  local itemCfg = cardSetData:GetCurCardSetScoreItemCfg()
  local scoreIcon = CRH:GetSprite(itemCfg.small_icon)
  self.ui.img_ScoreIcon.sprite = scoreIcon
  self.ui.img_BestScoreIcon.sprite = scoreIcon
  self:_UpdState()
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  if playType == CardSetEnum.eSetType.rank then
    self.cardSetCtrl:TryShowCardSetNewDiffUnlcok(CardSetEnum.eSetType.rank)
  end
end

function UICardSet:_UpdState()
  self.ui.obj_progress:SetActive(false)
  self.ui.obj_reset:SetActive(false)
  self.ui.obj_point:SetActive(false)
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  if playType == CardSetEnum.eSetType.rank then
    local curRoundData = self._cardSetData:GetCsRankCurRoundData()
    if curRoundData:CardSetRankRoundIsInVerify() then
      self.ui.tex_TitleBestPoint:SetIndex(3)
    else
      self.ui.tex_TitleBestPoint:SetIndex(2)
    end
    local bestScore = self._cardSetData:GetCsRankCurRoundHighestScore()
    self.ui.tex_BestPoint.text = tostring(bestScore)
    return
  end
  self.ui.obj_progress:SetActive(true)
  self.ui.obj_reset:SetActive(true)
  self.ui.obj_point:SetActive(true)
  local curRound = self._cardSetData:GetCardSetCurRound()
  local curBattleNum = self._cardSetData:GetCardSetCurBattleNum()
  self.ui.tex_Progress:SetIndex(0, tostring(curRound), tostring(curBattleNum + 1))
  local resNum = self._cardSetData:GetCardSetRoundResource()
  self.ui.tex_ResPoint.text = tostring(resNum)
  if playType == CardSetEnum.eSetType.rewind then
    self.ui.tex_TitleBestPoint:SetIndex(0)
  elseif playType == CardSetEnum.eSetType.normal then
    self.ui.tex_TitleBestPoint:SetIndex(1)
  end
  local bestScore = self._actCardSetData:GetActCardSetRoundBestScore(curRound)
  self.ui.tex_BestPoint.text = tostring(bestScore)
end

function UICardSet:_OnDelayUpdate()
  self:_UpdState()
end

function UICardSet:GenDiffCardTypeHolder()
  for index, eCardType in ipairs(CardSetEnum.showOrder) do
    if index == 1 then
      self.__cardHolderDic[eCardType] = self.ui.itemScroll
    else
      local go = self.ui.itemScroll:Instantiate()
      self.__cardHolderDic[eCardType] = go
    end
  end
end

function UICardSet:RefreshAllCard(needAnim)
  self.headItemPool:HideAll()
  self.cardItemPool:HideAll()
  self._cardBaseItemPool:HideAll()
  self.dotPool:HideAll()
  self.linePool:HideAll()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  if cardSetData == nil then
    return
  end
  local endLineList = {}
  local IntroTweenLineList = {}
  for index, eCardType in ipairs(CardSetEnum.showOrder) do
    local parentTrans = self.__cardHolderDic[eCardType].content
    local headItem = self.headItemPool:GetOne()
    headItem.transform:SetParent(self.ui.headItemList)
    headItem:InitCardSetHeadItem(self.cardSetCtrl, eCardType)
    local cardList = cardSetData:GetCardSetCardList4Type(eCardType, true)
    self.dotPool:GetOne().transform:SetParent(parentTrans)
    local line = self.linePool:GetOne()
    line.transform:SetParent(parentTrans)
    if #cardList == 0 then
      line:SetCardSetLineWidth(10000)
    else
      line:SetCardSetLineWidth(LINE_SIZE_HEAD)
      table.insert(IntroTweenLineList, line)
      self.dotPool:GetOne().transform:SetParent(parentTrans)
    end
    for index, cardData in ipairs(cardList) do
      local item = self.cardItemPool:GetOne()
      item:InitCSCardItem(self.cardSetCtrl, cardSetData, cardData, self._cardBaseItemPool)
      item.transform:SetParent(parentTrans, false)
      self.dotPool:GetOne().transform:SetParent(parentTrans)
      local line = self.linePool:GetOne()
      line:SetCardSetLineWidth(LINE_SIZE_MID)
      line.transform:SetParent(parentTrans)
      if index == #cardList then
        line:SetCardSetLineWidth(10000)
        table.insert(endLineList, line)
        cs_LayoutRebuilder.ForceRebuildLayoutImmediate(parentTrans)
      else
        self.dotPool:GetOne().transform:SetParent(parentTrans)
      end
    end
  end
  if needAnim then
    for k, cardHolder in ipairs(self.__cardHolderDic) do
      cardHolder.horizontalNormalizedPosition = 0
    end
    for k, line in pairs(IntroTweenLineList) do
      line:PlayIntroTween(k)
    end
    for k, headItem in pairs(self.headItemPool.listItem) do
      headItem:PlayHeadItemTween(k)
    end
  end
  for k, line in ipairs(endLineList) do
    line:SetCardSetLineEnd()
  end
end

function UICardSet:ResetCardSet()
  self.rightNode:InitCardSetRight(self.cardSetCtrl)
  self.downNode:InitCardDownNode(self.cardSetCtrl)
  self.ui.obj_Arrow:SetActive(false)
  self:RefreshAllCard(true)
  self:_UpdState()
end

function UICardSet:__OnCardChange(cardData)
  for key, item in pairs(self.headItemPool.listItem) do
    if item.eCardType == cardData:GetCardSetCardType() then
      item:RefreshCardHead()
      break
    end
  end
  for key, item in pairs(self.cardItemPool.listItem) do
    if item.cardData == cardData then
      item:RefreshCardSetCardItem()
      return
    end
  end
end

function UICardSet:__OnDiffChange()
  self:RefreshAllCard(false)
  self.ui.obj_Arrow:SetActive(false)
end

function UICardSet:_OnClickReset()
  local function reqFunc()
    self.cardSetCtrl:ReqCardSetRewindRoundReset(self._cardSetData)
  end
  
  if PlayerDataCenter.cacheSaveData:GetEnableActivityCardSetResetRoundConfirm() then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(2217), reqFunc)
    window:ShowDontRemindTog(function(flag)
      PlayerDataCenter.cacheSaveData:SetEnableActivityCardSetResetRoundConfirm(not flag)
    end, false)
    return
  end
  reqFunc()
end

function UICardSet:__BcakAction(isToHome)
  if self.closeCallback ~= nil then
    self.closeCallback(isToHome)
  end
  self:Delete()
end

function UICardSet:OnDelete()
  if self._cardSetData then
    self._cardSetData:SaveCardSetSelectedInfo()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetCardChange, self.__onCardChange)
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetDiffChange, self.__onDiffChange)
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetDelayUpd, self._OnDelayUpdateFunc)
  self.headItemPool:DeleteAll()
  self.cardItemPool:DeleteAll()
  self._cardBaseItemPool:DeleteAll()
  self.dotPool:DeleteAll()
  self.linePool:DeleteAll()
  self.rightNode:Delete()
  self.downNode:Delete()
  base.OnDelete(self)
end

return UICardSet
