local UINRealDailyEntry = class("UINRealDailyEntry", UIBaseNode)
local base = UIBaseNode
local UINPeriodicInfoItem = require("Game.PeriodicChallenge.UI.UINPeriodicInfoItem")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local cs_MessageCommon = CS.MessageCommon

function UINRealDailyEntry:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_node, self, self.OnClickDetail)
  self.targetScore = ConfigData.game_config.weeklyChallengeDailyUnlockScore
end

function UINRealDailyEntry:InitRealDailyEntry(realDailySectorId, parentNode)
  self.sectorId = realDailySectorId
  self.parentNode = parentNode
  self.isSelected = false
end

function UINRealDailyEntry:SetDungeonId(dungeonId)
  self.dungeonId = dungeonId
end

function UINRealDailyEntry:OnClickDetail()
  local has, dungeonId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  if has and self.dungeonId ~= dungeonId then
    SectorStageDetailHelper.TryToShowCurrentLevelTips(SectorStageDetailHelper.PlayMoudleType.Ep)
    return
  end
  if self.parentNode.selectedItem == self then
    return
  end
  self:OnClickItemCallback(true)
end

function UINRealDailyEntry:SetSelectState(flag)
  self.ui.img_Select:SetActive(flag)
  self.isSelected = flag
  if flag then
    self.ui.wave:DOPlayForward()
    AudioManager:PlayAudioById(1107)
  else
    self.ui.wave:DOPlayBackwards()
    AudioManager:PlayAudioById(1108)
  end
end

function UINRealDailyEntry:OnClickItemCallback(flag)
  if not self:GetCanShowStageInfo() or self.dungeonId == nil then
    local tip = string.format(ConfigData:GetTipContent(TipContent.WeeklyChallenge_DailyChallengeScoreRequire), self.targetScore)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(tip)
    return
  end
  if flag then
    if self.parentNode.selectedItem ~= nil then
      self.parentNode.selectedItem:SetSelectState(false)
    end
    self.parentNode.selectedItem = self
    self:OnSelectSectorLevel()
  else
    self.parentNode.selectedItem = nil
  end
end

function UINRealDailyEntry:__CloseLevelDetailWindow()
  if self.parentNode.selectedItem ~= nil then
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UINRealDailyEntry:OnSelectSectorLevel()
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
    window:SetLevelDetaiHideStartEvent(function()
      self.parentNode:PlayMoveLeftTween(false)
      self:SetSelectState(false)
      self:OnClickItemCallback(false)
    end)
    local width, duration = window:GetLevelDetailWidthAndDuration()
    self.parentNode:PlayMoveLeftTween(false, width, duration)
    self:SetSelectState(true, width, duration)
    window:InitSectorLevelDetail(self.sectorId, self.dungeonId)
  end)
end

function UINRealDailyEntry:GetCanShowStageInfo()
  local weelyNodeBestScore = PlayerDataCenter.allWeeklyChallengeData:GetWeelyNodeMaxScore()
  local specNodeBestScore = PlayerDataCenter.allWeeklyChallengeData:GetSpecNodeMaxScore()
  return weelyNodeBestScore >= self.targetScore or specNodeBestScore >= self.targetScore
end

return UINRealDailyEntry
