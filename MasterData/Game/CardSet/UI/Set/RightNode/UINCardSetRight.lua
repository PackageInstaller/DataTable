local UINCardSetRight = class("UINCardSetRight", UIBaseNode)
local base = UIBaseNode
local UINCSRightTagItem = require("Game.CardSet.UI.Set.RightNode.UINCSRightTagItem")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local UINCSRightDetailPanel = require("Game.CardSet.UI.Set.RightNode.DetailPanel.UINCSRightDetailPanel")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")

function UINCardSetRight:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Title, self, self.__OnClickTitleBtn)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickBG)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.__OnClickRank)
  UIUtil.AddButtonListener(self.ui.btn_ResetAll, self, self.__OnClickResetAll)
  self.resourceGroup = UINResourceGroup.New()
  self.resourceGroup:Init(self.ui.gameResourceGroup)
  self.__tagDic = {}
  self.__rightState = nil
  self.detailNode = UINCSRightDetailPanel.New()
  self.detailNode:Init(self.ui.obj_DetailPanel)
  self.tagPool = UIItemPool.New(UINCSRightTagItem, self.ui.obj_tagItem)
  self.ui.obj_tagItem.gameObject:SetActive(false)
  self.__onCardSetCardChange = BindCallback(self, self.__OnCardSetCardChange)
  MsgCenter:AddListener(eMsgEventId.OnCardSetCardChange, self.__onCardSetCardChange)
  self.__onEffectSwitch = BindCallback(self, self.__OnEffectSwitch)
  MsgCenter:AddListener(eMsgEventId.OnCardSetCardEffectIdChange, self.__onEffectSwitch)
  self._defaultTagInfoPosX = self.ui.tagInfoList.anchoredPosition.x
  local tagColor = self.ui.obj_TagMask.color
  tagColor.a = 0
  self.ui.obj_TagMask.color = tagColor
end

function UINCardSetRight:InitCardSetRight(cardSetCtrl)
  self.cardSetCtrl = cardSetCtrl
  self:InitCardSetRightTags()
  self.detailNode:InitCSRightDetailPanel(cardSetCtrl)
  self.detailNode:Hide()
  self.__rightState = CardSetEnum.eRightState.tags
  self:RefreshTopTitle()
  local setPlayType = cardSetCtrl:GetCardSetPlayType()
  local isRank = setPlayType == CardSetEnum.eSetType.rank
  self.ui.obj_Rank:SetActive(isRank)
  self.ui.obj_NormalTips:SetActive(not isRank)
  if isRank then
    local bestRankScore = cardSetCtrl:GetCdStActData():GetActCardSetRankHighestScore()
    self.ui.tex_BestRank:SetIndex(0, tostring(bestRankScore))
  end
  self:_InitTicked()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  self._cardSetData = cardSetData
  self._effectCardTotalNumDic = cardSetData:GetCardSetCardEffectTotalNumDic()
  self:_UpdEffectCardLimit()
  for index, tagItem in pairs(self.tagPool.listItem) do
    tagItem:PlayInitTween(index)
  end
end

function UINCardSetRight:_InitTicked()
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  if playType == CardSetEnum.eSetType.rank then
    self.resourceGroup:Hide()
    return
  end
  local actCardData = self.cardSetCtrl:GetCdStActData()
  local ticketsId = actCardData:GetActCardSetTicketsId()
  self.resourceGroup:SetResourceIds({ticketsId}, true)
end

function UINCardSetRight:InitCardSetRightTags()
  self.tagPool:HideAll()
  for index, eCardType in ipairs(CardSetEnum.showOrder) do
    local tagItem = self.tagPool:GetOne()
    tagItem:InitCSRightTagItem(self.cardSetCtrl, eCardType)
    self.__tagDic[eCardType] = tagItem
  end
end

function UINCardSetRight:_UpdEffectCardLimit()
  self.ui.tex_EffectLimit:SetIndex(0)
  local selectedCardNumDic = self._cardSetData:GetCardSetCardEffectSelectedlNumDic()
  for effectId = 1, CardSetEnum.eCardTive.max - 1 do
    local totalNum = self._effectCardTotalNumDic[effectId]
    local selectedNum = selectedCardNumDic[effectId]
    if 0 < totalNum then
      self.ui.limitItems[effectId]:SetActive(true)
      self.ui.tex_limitNum[effectId]:SetIndex(0, tostring(selectedNum), tostring(totalNum))
    else
      self.ui.limitItems[effectId]:SetActive(false)
    end
  end
end

function UINCardSetRight:RefreshTopTitle()
  local isTags = self.__rightState == CardSetEnum.eRightState.tags
  if isTags then
    self.ui.tex_TitleText:SetIndex(0)
  else
    self.ui.tex_TitleText:SetIndex(1)
  end
  self.ui.obj_LeftArrow:SetActive(isTags)
  self.ui.obj_RightArrow:SetActive(not isTags)
end

function UINCardSetRight:__ShowCardDetail(cardData, selected)
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  self.__rightState = CardSetEnum.eRightState.detail4AllCard
  if self.detailNode.active == false then
    self:_ShowDetailNode()
  end
  if selected then
    self._selectedCardData = cardData
  else
    self._selectedCardData = nil
  end
  self.detailNode:RefreshDetailAllCardData(cardSetData, self._selectedCardData)
  self:RefreshTopTitle()
end

function UINCardSetRight:__OnCardSetCardChange(cardData, selected)
  local eCardType = cardData:GetCardSetCardType()
  if self.__tagDic[eCardType] == nil then
    return
  end
  self.__tagDic[eCardType]:RefreshCSRightTag()
  self:__ShowCardDetail(cardData, selected)
  self:_UpdEffectCardLimit()
end

function UINCardSetRight:__OnClickTitleBtn()
  if self.__rightState == CardSetEnum.eRightState.tags then
    self.__rightState = CardSetEnum.eRightState.detail4AllCard
    local cardSetData = self.cardSetCtrl:GetCardSetData()
    self.detailNode:RefreshDetailAllCardData(cardSetData, self._selectedCardData)
    self:RefreshTopTitle()
    self:_ShowDetailNode()
  else
    self:__ReturnShowAllTag()
  end
end

function UINCardSetRight:__ReturnShowAllTag(isReset)
  if self.__rightState == CardSetEnum.eRightState.tags then
    return
  end
  self:_HideDetailNode()
  if isReset then
    self.detailNode:Hide()
  end
  self.__rightState = CardSetEnum.eRightState.tags
  self:RefreshTopTitle()
end

function UINCardSetRight:_ShowDetailNode()
  self.ui.tagInfoList:DOComplete()
  self.ui.tagInfoList:DOLocalMoveX(self._defaultTagInfoPosX - 130, 0.33):SetLink(self.gameObject)
  self.ui.obj_TagMask:DOComplete()
  self.ui.obj_TagMask:DOFade(1, 0.33):SetLink(self.gameObject)
  self.detailNode:PlayShowTweenCSRightDt(true)
  for index, tagItem in pairs(self.tagPool.listItem) do
    tagItem:ShowTopCSRightTagItem(false)
  end
end

function UINCardSetRight:_HideDetailNode()
  self.ui.tagInfoList:DOComplete(true)
  self.ui.tagInfoList:DOLocalMoveX(self._defaultTagInfoPosX, 0.33):OnComplete(function()
    for index, tagItem in pairs(self.tagPool.listItem) do
      tagItem:ShowTopCSRightTagItem(true)
    end
  end):SetLink(self.gameObject)
  self.ui.obj_TagMask:DOComplete()
  self.ui.obj_TagMask:DOFade(0, 0.33):SetLink(self.gameObject)
  self.detailNode:PlayShowTweenCSRightDt(false)
end

function UINCardSetRight:__OnClickBG()
  if self.__rightState ~= CardSetEnum.eRightState.tags then
    self:_HideDetailNode()
    self.__rightState = CardSetEnum.eRightState.tags
  end
  self:RefreshTopTitle()
end

function UINCardSetRight:__OnClickRank()
  local rankId = self.cardSetCtrl:GetCardSetData():GetCardSetRankId()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId)
  end)
end

function UINCardSetRight:__OnClickResetAll()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  cardSetData:ResetCardSetSelected()
  self:__ReturnShowAllTag(true)
  local cardSetWin = UIManager:GetWindow(UIWindowTypeID.CardSet)
  if cardSetWin ~= nil then
    cardSetWin:ResetCardSet()
  end
end

function UINCardSetRight:UpdCardSetRight()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  self.detailNode:RefreshDetailAllCardData(cardSetData, self._selectedCardData)
end

function UINCardSetRight:__OnEffectSwitch(cardData)
  self:__ShowCardDetail(cardData, true)
  self:_UpdEffectCardLimit()
end

function UINCardSetRight:OnDelete()
  TimerManager:StopTimer(self._changePageTimer)
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetCardChange, self.__onCardSetCardChange)
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetCardEffectIdChange, self.__onEffectSwitch)
  self.resourceGroup:Delete()
  self.detailNode:Delete()
  self.tagPool:DeleteAll()
  base.OnDelete(self)
end

return UINCardSetRight
