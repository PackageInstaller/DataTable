local UINCommonRankPanel = class("UINCommonRankPanel", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local UINCommonRankPanelItem = require("Game.CommonUI.Rank.UINCommonRankPanelItem")
local UINCardSetRankPanelItem = require("Game.CommonUI.Rank.CardSetRank.UINCardSetRankPanelItem")
local BattleUtil = require("Game.Battle.BattleUtil")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINCommonRankPanel.eRankDragWay = {Down = 1, Up = 2}

function UINCommonRankPanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_ErrorIcon, self, self.__OnBtnErrorIcon)
  UIUtil.AddButtonListener(self.ui.btn_FloatingBG, self, self.__OnBtnFloatingBG)
  UIUtil.AddButtonListener(self.ui.btn_Details, self, self.__OnClickMyDetail)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.loop_scroll.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.ui.loop_scroll.onValueChanged:AddListener(BindCallback(self, self.__OnValueChange))
  self.itemDic = {}
  self.myHeadNode = UINUserHead.New()
  self.myHeadNode:Init(self.ui.my_uINBaseHead)
  self.__rankPageNum = ConfigData.buildinConfig.CommonRankPageNum
  self.ui.tex_MyRank.text.text = ""
end

function UINCommonRankPanel:InitCommonRankPanel(rankCfg)
  self.__rankCfg = rankCfg
  self.ui.tex_ScoureTitle.text = LanguageUtil.GetLocaleText(rankCfg.option_name)
  local myInfoData = PlayerDataCenter.inforData
  self.myHeadNode:InitUserHeadUI(myInfoData:GetAvatarId(), myInfoData:GetAvatarFrameId(), self.__resloader)
  self.ui.loop_scroll:ClearCells()
  self.maxShowRankNum = rankCfg.precise_max
  local precis_show = self.__rankCfg.precise_show
  if precis_show ~= 0 then
    self.maxShowRankNum = precis_show
  end
  self.__maxPageNum = math.ceil(self.maxShowRankNum / self.__rankPageNum) - 1
  self.__curRankPage = 0
  self.__rankDragWay = UINCommonRankPanel.eRankDragWay.Down
  self.__cannotDragDown = false
  self:ReqGetRankPageData(0)
end

function UINCommonRankPanel:_TryInitCardSetRank()
  if self._isCardSetRank then
    return
  end
  self._isCardSetRank = true
  self.ui.obj_texDiff:SetActive(true)
  self.ui.obj_texBattleDetails:SetActive(true)
  self.ui.obj_texDiff.gameObject:SetActive(true)
  
  function self._detailFunc(rankAvatar, cardMsg)
    UIManager:ShowWindowAsync(UIWindowTypeID.CardRankBattleDetails, function(win)
      if win == nil then
        return
      end
      win:InitCardRankBattleDetails(rankAvatar, cardMsg, self.__rankCfg.id)
    end)
  end
end

function UINCommonRankPanel:__OnNewItem(go)
  local rankItem
  if self._isCardSetRank then
    rankItem = UINCardSetRankPanelItem.New()
  else
    rankItem = UINCommonRankPanelItem.New()
  end
  rankItem:Init(go)
  if self._isCardSetRank then
    rankItem:InitCardSetRankItem(self._detailFunc)
  end
  self.itemDic[go] = rankItem
end

function UINCommonRankPanel:__OnChangeItem(go, index)
  local rankItem = self.itemDic[go]
  if rankItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  local rankElemData = self.__rankDataDic[index + 1 + self.__curRankPage * self.__rankPageNum]
  if rankElemData ~= nil then
    rankItem:RefeshCommonRankItem(self.__rankCfg, rankElemData, self.__resloader, self.hasTimer, self.showHeroNum)
    rankItem:SetDownTransform(self.ui.tex_MyHeroCount.transform)
    rankItem.o_index = index
  end
  if index == 0 then
    self.__isHasFirstElement = true
    self.__firstElementGo = go
  elseif index == self.ui.loop_scroll.totalCount - 1 then
    self.__isHasLastElement = true
    self.__lastElementGo = go
  end
end

function UINCommonRankPanel:__OnReturnItem(go)
  local rankItem = self.itemDic[go]
  if rankItem == nil then
    error("Can't find item by gameObject")
    return
  end
  local index = rankItem.o_index
  if index == 0 then
    self.__isHasFirstElement = false
  elseif index == self.ui.loop_scroll.totalCount - 1 then
    self.__isHasLastElement = false
  end
end

function UINCommonRankPanel:__OnValueChange(pos)
  local isHasFirstElement = self.__isHasFirstElement
  local isHasLastElement = self.__isHasLastElement
  if isHasFirstElement or isHasLastElement then
    local overValue = math.abs(self.ui.float_overRate)
    if isHasFirstElement then
      local viewTopPos = self.ui.goTop_view.position.y
      local contentTopPos = self.__firstElementGo.transform.position.y
      if overValue < viewTopPos - contentTopPos then
        self:__OnDragOverTop()
      end
    end
    if isHasLastElement then
      local viewDownPos = self.ui.goBotton_view.position.y
      local contentDownPos = self.__lastElementGo.transform.position.y
      if overValue < contentDownPos - viewDownPos then
        self:__OnDragOverBottle()
      end
    end
  end
end

function UINCommonRankPanel:__OnDragOverTop()
  if self.__curRankPage == 0 then
    return
  end
  if self.__isDragOverFreshing then
    return
  end
  self.__curRankPage = self.__curRankPage - 1
  self.__rankDragWay = UINCommonRankPanel.eRankDragWay.Up
  self:ReqGetRankPageData(self.__curRankPage)
end

function UINCommonRankPanel:__OnDragOverBottle()
  if self.__curRankPage == self.__maxPageNum then
    return
  end
  if self.__isDragOverFreshing then
    return
  end
  if self.__cannotDragDown then
    return
  end
  self.__curRankPage = self.__curRankPage + 1
  self.__rankDragWay = UINCommonRankPanel.eRankDragWay.Down
  self:ReqGetRankPageData(self.__curRankPage)
end

function UINCommonRankPanel:ReqGetRankPageData(pageNum)
  local objNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  objNetwork:CS_Rank_Detail(self.__rankCfg.id, pageNum)
  self.__isDragOverFreshing = true
end

function UINCommonRankPanel:GetCommonRankPageMsg(msg, hasTime, isShowNum)
  local rankKeyDic = {}
  for index, rankElem in ipairs(msg.rank) do
    if not (self.maxShowRankNum < rankElem.rankIdx) then
      local score, frame = self:_CalculateScoreAndFrame(rankElem.entry.score1)
      rankElem.entry.score1 = score
      rankElem.entry.frame = frame
      rankKeyDic[rankElem.rankIdx] = rankElem
      if rankElem.entry.extraData and rankElem.entry.extraData.card ~= nil then
        self:_TryInitCardSetRank()
      end
    end
  end
  local num = table.count(rankKeyDic)
  if msg.myRank ~= nil then
    local score, frame = self:_CalculateScoreAndFrame(msg.myRank.score)
    msg.myRank.score = score
    msg.myRank.frame = frame
  end
  self._msg = msg
  local timeTextIndex = self.__rankCfg.time_text_index
  self:SetHasTime(hasTime, timeTextIndex)
  self:SetHeroShow(isShowNum)
  self:RefeshCommonRankPage(rankKeyDic, num)
  self:RefreshCommonMyRank(msg.myRank, hasTime, isShowNum)
end

function UINCommonRankPanel:SetHasTime(has, texIndex)
  self.hasTimer = has
  self.ui.tex_Time.gameObject:SetActive(has)
  self.ui.texInfo_Time:SetIndex(texIndex)
end

function UINCommonRankPanel:SetHeroShow(isShowNum)
  self.showHeroNum = isShowNum
  self.ui.obj_heroNum:SetActive(isShowNum)
  self.ui.obj_heroList:SetActive(not isShowNum and not self._isCardSetRank)
end

function UINCommonRankPanel:RefeshCommonRankPage(rankKeyDic, num)
  self.__rankDataDic = rankKeyDic
  self.ui.loop_scroll:ClearCells()
  self.ui.loop_scroll.totalCount = num
  self.__cannotDragDown = num < self.__rankPageNum
  self.__isHasFirstElement = false
  self.__isHasLastElement = false
  if self.__rankDragWay == UINCommonRankPanel.eRankDragWay.Up then
    self.ui.loop_scroll:RefillCellsFromEnd()
  else
    self.ui.loop_scroll:RefillCells()
  end
  self.ui.loop_scroll:StopMovement()
  self.__isDragOverFreshing = false
end

function UINCommonRankPanel:RefreshCommonMyRank(myRank, hasTime, isShowNum)
  self.ui.tex_MyName.text = PlayerDataCenter.playerName
  self.ui.tex_MyTime.gameObject:SetActive(hasTime)
  local isCardSet = self._isCardSetRank and myRank and myRank.extraData and myRank.extraData.card ~= nil
  local heightestMsg
  if myRank == nil then
    self.ui.tex_MyRank:SetIndex(2)
    if self.__rankCfg.option_show_type == 1 then
      self.ui.tex_MyScore.text = ""
    else
      self.ui.tex_MyScore.text = "0"
    end
    self.ui.tex_MyTime.text = ""
    if isShowNum then
      self.ui.tex_MyHeroCount.gameObject:SetActive(true)
      self.ui.tex_MyHeroCount.text = "0"
    else
      self.ui.tex_MyHeroCount.gameObject:SetActive(false)
    end
    return
  end
  if self.__rankCfg.option_show_type == 1 then
    self.ui.tex_MyScore.text = BattleUtil.FrameToTimeString(myRank.score, true)
  else
    local score = myRank.score
    if isCardSet then
      local totalScore = 0
      local heightScore = 0
      for index, actCardMsg in pairs(myRank.extraData.card) do
        local __score = actCardMsg.score
        totalScore = totalScore + __score
        if heightScore < __score then
          heightestMsg = actCardMsg
          heightScore = score
        end
      end
      score = totalScore
    end
    local scoreMsg
    if score >= BattleUtil.CheatFrame then
      scoreMsg = ConfigData:GetTipContent(1020)
    else
      scoreMsg = tostring(score)
    end
    self.ui.tex_MyScore.text = scoreMsg
  end
  if hasTime then
    self.ui.tex_MyTime.text = BattleUtil.FrameToTimeString(myRank.frame, true)
  end
  local isInRank = myRank.inRank
  if myRank.rankParam > self.maxShowRankNum then
    isInRank = false
  end
  if isInRank then
    self.ui.tex_MyRank:SetIndex(0, tostring(myRank.rankParam))
  elseif 0 < self.__rankCfg.percent_show and myRank.rankParam <= self.__rankCfg.percent_show then
    self.ui.tex_MyRank:SetIndex(1, GetPreciseDecimalStr(myRank.rankPercent / 100, 1))
  else
    self.ui.tex_MyRank:SetIndex(3)
  end
  if isShowNum then
    self.ui.tex_MyHeroCount.gameObject:SetActive(true)
    self.ui.tex_MyHeroCount.text = myRank.params[1]
  else
    self.ui.tex_MyHeroCount.gameObject:SetActive(false)
  end
  self.myRankStatus = myRank.rankStatus
  self.ui.btn_FloatingBG.gameObject:SetActive(false)
  if myRank.rankStatus then
    if myRank.rankStatus == 0 then
      self.ui.obj_Error:SetActive(false)
    elseif myRank.rankStatus == 1 then
      self.ui.obj_Error:SetActive(true)
      self.ui.tex_Error:SetIndex(0)
      self.ui.img_Error.color = self.ui.color_inCheck
    else
      self.ui.obj_Error:SetActive(true)
      self.ui.tex_Error:SetIndex(1)
      self.ui.img_Error.color = self.ui.color_checkFail
    end
  end
  self.ui.btn_Details.transform.parent.gameObject:SetActive(isCardSet)
  if isCardSet then
    local CardSetUtil = require("Game.CardSet.CardSetUtil")
    self.ui.tex_Diff.text = CardSetUtil.GetCardSetDiffName(self.__rankCfg.id, heightestMsg.difficulty)
    self.ui.tex_Diff.gameObject:SetActive(true)
  end
end

function UINCommonRankPanel:__OnClickMyDetail()
  local myInfoData = PlayerDataCenter.inforData
  self._rankAvatar = self._rankAvatar or {
    name = PlayerDataCenter.playerName,
    avatarId = myInfoData:GetAvatarId(),
    avatarFrame = myInfoData:GetAvatarFrameId(),
    title = myInfoData:GetAvatarTitleId()
  }
  if self._detailFunc then
    self._detailFunc(self._rankAvatar, self._msg.myRank.extraData.card)
  end
end

function UINCommonRankPanel:_CalculateScoreAndFrame(score1)
  if score1 == nil then
    return
  end
  local score, frame
  if self.__rankCfg.option_show_type == 1 then
    score = 4294967295 - score1
  elseif self.__rankCfg.time_switch then
    score = score1 >> 32
    local f = 4294967295
    frame = f - (score1 & f)
  else
    score = score1
  end
  return score, frame
end

function UINCommonRankPanel:__OnBtnErrorIcon()
  self.isShowFloatingFrame = not self.isShowFloatingFrame
  self:ControllerFloatFrameShow()
  self.ui.btn_FloatingBG.gameObject:SetActive(self.isShowFloatingFrame)
end

function UINCommonRankPanel:__OnBtnFloatingBG()
  self.isShowFloatingFrame = false
  self:ControllerFloatFrameShow()
  self.ui.btn_FloatingBG.gameObject:SetActive(self.isShowFloatingFrame)
end

function UINCommonRankPanel:ControllerFloatFrameShow()
  if self.isShowFloatingFrame then
    local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
    local titleTex, contentTex = ConfigData:GetTipContent(8801), ConfigData:GetTipContent(8802)
    if self.myRankStatus == 2 then
      titleTex, contentTex = ConfigData:GetTipContent(8803), ConfigData:GetTipContent(8804)
    end
    win:SetTitleAndContext(titleTex, contentTex)
    win:FloatTo(self.ui.obj_Error.transform, HAType.left, VAType.up)
  else
    local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
    if win ~= nil then
      win:Hide()
      win:Clean3DModifier()
    end
  end
end

function UINCommonRankPanel:OnDelete()
  self.isShowFloatingFrame = false
  self:ControllerFloatFrameShow()
  if self.__resloader ~= nil then
    self.__resloader:Put2Pool()
    self.__resloader = nil
  end
  base.OnDelete(self)
end

return UINCommonRankPanel
