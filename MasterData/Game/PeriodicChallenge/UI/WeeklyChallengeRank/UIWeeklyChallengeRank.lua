local UIWeeklyChallengeRank = class("UIWeeklyChallengeRank", UIBaseWindow)
local base = UIBaseWindow
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local UINWCRankRewardPanel = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankRewardPanel")
local UINWCRankPanel = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankPanel")
local UINWCRankTogItem = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankTogItem")
local cs_ResLoader = CS.ResLoader
UIWeeklyChallengeRank.ePanelType = {
  curRank = 1,
  oldRank = 2,
  reward = 3,
  activityOldRank = 4
}

function UIWeeklyChallengeRank:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.rewardPanel = UINWCRankRewardPanel.New()
  self.rewardPanel:Init(self.ui.awardNode)
  self.listPanel = UINWCRankPanel.New()
  self.listPanel:Init(self.ui.rankNode)
  self.showingType = nil
  self.pageTogPool = UIItemPool.New(UINWCRankTogItem, self.ui.obj_Page)
  self.ui.obj_Page:SetActive(false)
  self.__ShowCurTermRanklist = BindCallback(self, self.ShowCurTermRanklist)
  self.__ShowPreviousTermRanklist = BindCallback(self, self.ShowPreviousTermRanklist)
  self.__ShowRanklistReward = BindCallback(self, self.ShowRanklistReward)
  self.__ShowLastActivityRanklist = BindCallback(self, self.ShowLastActivityRanklist)
  UIUtil.SetTopStatus(self, self.Delete, nil, function()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
      if window == nil then
        return
      end
      window:InitCommonInfo(ConfigData:GetTipContent(8806), ConfigData:GetTipContent(8805), nil, true)
    end)
  end, nil, nil)
  self.selfRangeDataDic = {}
end

function UIWeeklyChallengeRank:GenWCRPageTogs(challengeId)
  self.challengeId = challengeId
  self.challengeData = PlayerDataCenter.allWeeklyChallengeData:GetWeeklyChallengeDataByDungeonId(challengeId)
  self.pageTogPool:HideAll()
  local curTermRanklistTog = self.pageTogPool:GetOne()
  curTermRanklistTog:InitWCRankTogItem(UINWCRankTogItem.eTogType.curTermRankList, self.__ShowCurTermRanklist)
  local previousTermRanklistTog = self.pageTogPool:GetOne()
  previousTermRanklistTog:InitWCRankTogItem(UINWCRankTogItem.eTogType.previousTermRankList, self.__ShowPreviousTermRanklist)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if self.challengeData:GetIsHaveRankReward() then
    local RanklistRewardTog = self.pageTogPool:GetOne()
    RanklistRewardTog:InitWCRankTogItem(UINWCRankTogItem.eTogType.rankRewardList, self.__ShowRanklistReward)
    self:RefreshRemaindTime()
    self.timerId = TimerManager:StartTimer(1, self.RefreshRemaindTime, self, false, false, false)
    self.ui.obj_timer:SetActive(true)
  else
    self.ui.obj_timer:SetActive(false)
  end
  if PlayerDataCenter.allWeeklyChallengeData:GetIsHaveLastActivityWCRank() then
    local lastActivityWC = self.pageTogPool:GetOne()
    lastActivityWC:InitWCRankTogItem(UINWCRankTogItem.eTogType.activityOldRankList, self.__ShowLastActivityRanklist)
  end
  curTermRanklistTog.ui.tog_Page.isOn = true
end

function UIWeeklyChallengeRank:ShowCurTermRanklist()
  self.showingType = UIWeeklyChallengeRank.ePanelType.curRank
  self.rewardPanel:Hide()
  self.listPanel:Show()
  local rankType = self.challengeData:GetRankType()
  self.listPanel:ShowRankPlayers(UINWCRankPanel.eRankListType.cur, self.challengeData, self.challengeData.wc_cfg, self.resloader, rankType)
end

function UIWeeklyChallengeRank:ShowPreviousTermRanklist()
  self.showingType = UIWeeklyChallengeRank.ePanelType.oldRank
  self.rewardPanel:Hide()
  self.listPanel:Show()
  local clgId = self.challengeData.cfg.challenge_id
  local lastWCEndTime = PlayerDataCenter.allWeeklyChallengeData.lastTm
  local rankType = self.challengeData:GetRankType()
  self.listPanel:ShowRankPlayers(UINWCRankPanel.eRankListType.old, self.challengeData, ConfigData.weekly_challenge_config[clgId][lastWCEndTime], self.resloader, rankType)
end

function UIWeeklyChallengeRank:ShowRanklistReward()
  self.showingType = UIWeeklyChallengeRank.ePanelType.reward
  self.rewardPanel:Show()
  self.listPanel:Hide()
  if self.selfRangeDataDic[self.challengeData:GetRankType()] == nil then
    NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_WEEKLYCHALLENGE_RankPage(false, 0, self.challengeData:GetRankType(), function()
      self:CalAndShowRanklistReward()
    end)
  else
    self:CalAndShowRanklistReward()
  end
end

function UIWeeklyChallengeRank:ShowLastActivityRanklist()
  self.showingType = UIWeeklyChallengeRank.ePanelType.activityOldRank
  self.rewardPanel:Hide()
  self.listPanel:Show()
  local clgId = self.challengeData.cfg.challenge_id
  local lastWCEndTime = PlayerDataCenter.allWeeklyChallengeData.lastTm
  local rankType = 2
  self.listPanel:ShowRankPlayers(UINWCRankPanel.eRankListType.old, self.challengeData, ConfigData.weekly_challenge_config[clgId][lastWCEndTime], self.resloader, rankType)
end

function UIWeeklyChallengeRank:CalAndShowRanklistReward()
  self.rewardPanel:InitRankRewardPanel(self.challengeData:GetRankRewardId(), self.selfRangeDataDic[self.challengeData:GetRankType()], self.resloader)
end

function UIWeeklyChallengeRank:OnReceiveRankMsg(msg)
  local isOld = msg.history
  if self.listPanel ~= nil then
    self.listPanel:GetRankPageMsg(msg)
  end
  if not isOld then
    self.selfRangeDataDic[msg.rankCat] = msg.selfRange
  end
end

function UIWeeklyChallengeRank:RefreshRemaindTime()
  local isRankOutof = PlayerDataCenter.timestamp > PlayerDataCenter.allWeeklyChallengeData.rankTm
  self.ui.title_Timer:SetIndex(isRankOutof and 1 or 0)
  local nextTime
  if isRankOutof then
    local counterElem = PlayerDataCenter.allWeeklyChallengeData:GetCounterElem()
    nextTime = counterElem ~= nil and counterElem.nextExpiredTm or 0
  else
    nextTime = PlayerDataCenter.allWeeklyChallengeData.rankTm
  end
  local remaindTime = math.max(math.floor(nextTime - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if 0 < d then
    self.ui.tex_Timer:SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    self.ui.tex_Timer:SetIndex(1, hStr, mStr, sStr)
  end
  if remaindTime <= 0 and isRankOutof and self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

function UIWeeklyChallengeRank:OnDelete()
  self.rewardPanel:Delete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnDelete(self)
end

return UIWeeklyChallengeRank
