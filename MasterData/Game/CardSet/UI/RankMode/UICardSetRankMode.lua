local base = UIBaseWindow
local UICardSetRankMode = class("UICardSetRankMode", base)
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")
local UINCSRankRoundTogItem = require("Game.CardSet.UI.RankMode.UINCSRankRoundTogItem")
local UINCSRankEmptyItem = UIBaseNode
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function UICardSetRankMode:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Reward, self, self._OnClickShowReward)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self._OnClickShowRank)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self._OnClickReset)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self._OnClickJump)
  self._heroItemPool = UIItemPool.New(UINHeroHeadWithStarItem, self.ui.uINHeroHeadWithStar, false)
  self._fairyItem = UINFairyHeadItem.New()
  self._fairyItem:Init(self.ui.fairyHeadItem)
  self._fairyItem:SetFairyHeadItemLvShow(true)
  self._resLoader = CS.ResLoader.Create()
  self._roundItemPool = UIItemPool.New(UINCSRankRoundTogItem, self.ui.tog_Round, false)
  self._emptyItemPool = UIItemPool.New(UINCSRankEmptyItem, self.ui.emptyItem, false)
  self.__OnSelectRoundFunc = BindCallback(self, self._OnSelectRound)
  self._OnDelayUpdateFunc = BindCallback(self, self._OnDelayUpdate)
  MsgCenter:AddListener(eMsgEventId.OnCardSetDelayUpd, self._OnDelayUpdateFunc)
end

function UICardSetRankMode:InitCardSetRankMode(cardSetCtrl, isReturn)
  self.cardSetCtrl = cardSetCtrl
  self._cardSetActData = cardSetCtrl:GetCdStActData()
  local cardSetData = cardSetCtrl:GetCardSetData(CardSetEnum.eSetType.rank)
  self._cardSetData = cardSetData
  local roundDataList = cardSetData:GetCsRankRoundDataList()
  self._roundItemPool:HideAll()
  for k, roundData in ipairs(roundDataList) do
    local roundItem = self._roundItemPool:GetOne()
    roundItem:InitCSRankRoundTogItem(roundData, self.__OnSelectRoundFunc)
  end
  self.ui.toggleGroup:SetAllTogglesOff()
  local selectRoundId = cardSetData:GetCsRankRoundId()
  self._roundItemPool.listItem[selectRoundId]:SetCSRankRoundTogItemOn()
  self:_UpdTotal()
  if isReturn then
    self:_OnClickJump()
  end
  self:__InitReddotListern()
  self:__RefreshRewardBtn()
end

function UICardSetRankMode:_UpdTotal()
  self.ui.tex_HistoryTotalPoint.text = tostring(self._cardSetActData:GetActCardSetRankHighestScore())
  local roundDataList = self._cardSetData:GetCsRankRoundDataList()
  local anyRoundInVerify = false
  for k, roundData in ipairs(roundDataList) do
    if roundData:CardSetRankRoundIsInVerify() then
      anyRoundInVerify = true
    end
  end
  self.ui.obj_InVerify:SetActive(anyRoundInVerify)
end

function UICardSetRankMode:_UpdRound(roundData)
  self.ui.tex_RoundNum.text = tostring(roundData:GetCsRankRoundId())
  self.ui.tex_Des.text = roundData:GetCsRankRoundDes()
  self.ui.tex_NowPoint.text = tostring(roundData:GetCsRankRoundScore())
  self.ui.tex_NowTotalPoint.text = tostring(self._cardSetData:GetCsRankAllRoundScore())
  self._emptyItemPool:HideAll()
  self._heroItemPool:HideAll()
  local heroDataList = roundData:GetCsRankRoundHeroList()
  for k, heroData in ipairs(heroDataList) do
    local heroItem = self._heroItemPool:GetOne()
    heroItem:InitHead(heroData, true)
  end
  local fairyData = roundData:GetCsRankRoundFairyData()
  if fairyData then
    self._fairyItem:InitFairyHeadItem(fairyData, self._resLoader)
    self._fairyItem:Show()
    self._fairyItem.transform:SetAsLastSibling()
  else
    self._fairyItem:Hide()
    self._emptyItemPool:GetOne()
  end
  for i = #heroDataList + 1, 8 do
    self._emptyItemPool:GetOne()
  end
  local isInVerify = roundData:CardSetRankRoundIsInVerify()
  self.ui.obj_InVerifyCur:SetActive(isInVerify)
end

function UICardSetRankMode:__RefreshRewardBtn()
  local taskList = self._cardSetActData:GetActCardSetRewardTaskIdList()
  if taskList == nil or #taskList <= 0 then
    self.ui.btn_Reward.gameObject:SetActive(false)
  end
end

function UICardSetRankMode:_OnDelayUpdate()
  self:_UpdTotal()
  local roundData = self._cardSetData:GetCsRankCurRoundData()
  self:_UpdRound(roundData)
end

function UICardSetRankMode:_OnSelectRound(roundData)
  self._cardSetData:SetCsRankRoundId(roundData:GetCsRankRoundId())
  self:_UpdRound(roundData)
end

function UICardSetRankMode:_OnClickShowReward()
  UIManager:ShowWindowAsync(UIWindowTypeID.CardSetMEReward, function(win)
    if win == nil then
      return
    end
    win:InitCSMERewardNode(self._cardSetActData)
  end)
end

function UICardSetRankMode:_OnClickShowRank()
  local rankId = self._cardSetActData:GetActCardSetRankId()
  UIManager:HideWindow(UIWindowTypeID.CardSetEntrance)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CardSetEntrance)
    end)
  end)
end

function UICardSetRankMode:_OnClickReset()
  local function confimFunc()
    self.cardSetCtrl:ReqCardSetRewindRoundReset(self._cardSetData, function()
      local roundData = self._cardSetData:GetCsRankCurRoundData()
      
      self:_UpdRound(roundData)
    end)
  end
  
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(2221), confimFunc)
end

function UICardSetRankMode:_OnClickJump()
  UIManager:HideWindow(UIWindowTypeID.CardSetEntrance)
  UIManager:HideWindow(UIWindowTypeID.CardSetRankMode)
  self.cardSetCtrl:OpenCardSetUI(CardSetEnum.eSetType.rank, function()
    UIManager:ShowWindowOnly(UIWindowTypeID.CardSetEntrance)
    UIManager:ShowWindowOnly(UIWindowTypeID.CardSetRankMode)
  end)
end

function UICardSetRankMode:__InitReddotListern()
  self.redDotRoot = self._cardSetActData:GetActivityReddot()
  if self.redDotRoot ~= nil then
    self._reddotFunc = BindCallback(self, self.__RefreshReddot)
    RedDotController:AddListener(self.redDotRoot.nodePath, self._reddotFunc)
    self:__RefreshReddot()
  end
end

function UICardSetRankMode:__RefreshReddot()
  self:__RefreshRewardBlueOrRedDot()
end

function UICardSetRankMode:__RefreshRewardBlueOrRedDot()
  local redDotRoot = self.redDotRoot
  local taskCompleteNode = redDotRoot:GetChild(CardSetEnum.reddotType.rankTask)
  if taskCompleteNode ~= nil and taskCompleteNode:GetRedDotCount() > 0 then
    self.ui.reward_RedDot:SetActive(true)
    self.ui.reward_BlueDot:SetActive(false)
    return
  end
  local taskfirstNode = redDotRoot:GetChild(CardSetEnum.reddotType.firstEnterTaskBlue)
  if taskfirstNode ~= nil and taskfirstNode:GetRedDotCount() > 0 then
    self.ui.reward_RedDot:SetActive(false)
    self.ui.reward_BlueDot:SetActive(true)
    return
  end
  self.ui.reward_RedDot:SetActive(false)
  self.ui.reward_BlueDot:SetActive(false)
end

function UICardSetRankMode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetDelayUpd, self._OnDelayUpdateFunc)
  self._heroItemPool:DeleteAll()
  self._fairyItem:Delete()
  self._roundItemPool:DeleteAll()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  if self.redDotRoot ~= nil then
    RedDotController:RemoveListener(self.redDotRoot.nodePath, self._reddotFunc)
    self.redDotRoot = nil
  end
  base.OnDelete(self)
end

return UICardSetRankMode
