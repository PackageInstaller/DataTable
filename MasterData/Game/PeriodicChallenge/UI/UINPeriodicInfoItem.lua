local UINPeriodicInfoItem = class("UINPeriodicInfoItem", UIBaseNode)
local base = UIBaseNode
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINPeriodicInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINPeriodicInfoItem:InitPeriodicInfoItem(id, eChallenge, titleIndex)
  self.detailType = SectorLevelDetailEnum.eDetailType.PeriodicChallenge
  self.eChallenge = eChallenge
  self.dungeonId = id
  local cfg = ConfigData.daily_challenge[self.dungeonId]
  self.ui.text_LevelName.text = LanguageUtil.GetLocaleText(cfg.name)
  self:RefreshPeriodicInfoItem()
  self:RefreshTitle(titleIndex)
end

function UINPeriodicInfoItem:InitWeeklyInfoItem(id, titleIndex)
  self.detailType = SectorLevelDetailEnum.eDetailType.WeeklyChallenge
  self.dungeonId = id
  local cfg = ConfigData.weekly_challenge[self.dungeonId]
  self.ui.text_LevelName.text = LanguageUtil.GetLocaleText(cfg.name)
  self.ui.tex_Info.text = LanguageUtil.GetLocaleText(cfg.short_intro)
  local isHasMult = cfg.score_ratio ~= 0
  self.ui.obj_img_ScoreMult:SetActive(isHasMult)
  if isHasMult then
    self.ui.tex_ScoreMult:SetIndex(0, tostring(1 + cfg.score_ratio / 1000))
  end
  self:RefreshWeeklyInfoItem()
  self:RefreshTitle(titleIndex)
end

function UINPeriodicInfoItem:RefreshInfoItem()
  if self.detailType == SectorLevelDetailEnum.eDetailType.PeriodicChallenge then
    self:RefreshPeriodicInfoItem()
  elseif self.detailType == SectorLevelDetailEnum.eDetailType.WeeklyChallenge then
    self:RefreshWeeklyInfoItem()
  end
end

function UINPeriodicInfoItem:RefreshTitle(titleIndex)
  self.ui.tex_TypeTile:SetIndex(titleIndex)
  self.ui.tex_TypeTile_En:SetIndex(titleIndex)
end

function UINPeriodicInfoItem:RefreshPeriodicInfoItem()
  local _, dungeonId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  self.ui.obj_Continue:SetActive(isInEp)
end

function UINPeriodicInfoItem:RefreshWeeklyInfoItem()
  local _, dungeonId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  self.ui.obj_Continue:SetActive(isInEp and dungeonId == self.dungeonId)
  local data = PlayerDataCenter.allWeeklyChallengeData.dataDic[self.dungeonId]
  local isunlock = data ~= nil and data:IsUnlockWeeklyChallenge()
  if isunlock then
    self.ui.lock:SetActive(false)
  else
    self.ui.lock:SetActive(true)
    self.ui.text_lock.text = CheckCondition.GetUnlockInfoLua(data.cfg.pre_condition, data.cfg.pre_para1, data.cfg.pre_para2)
  end
end

return UINPeriodicInfoItem
