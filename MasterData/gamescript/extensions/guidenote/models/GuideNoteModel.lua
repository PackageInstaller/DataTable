local GuideNoteModel = NewClass("GuideNoteModel", BaseModel)
local ModuleType = GuideNoteDefine.ModuleType
local GuideNotePage = GuideNoteDefine.Page
local TaskServerIndex = CommonDefine.TaskServerIndex
local LevelType = GuideNoteDefine.LevelType
local FeatureId = CommonDefine.FeatureId
local WEEKLY_TIER_REWARD_CONST_KEY = "GuideNoteWeeklyActivityTierRewards"
local AWAKER_STRENGTH_SELECTED_SAVE_KEY = "GuideNote_AwakerStrength_SelectedAwakerTid"

function GuideNoteModel:OnInit()
  self.curPage = nil
  self.lastPage = nil
  self._awakerStrengthSelectedAwakerTid = nil
  self._sidebarRedDot = {}
  self._guideNoteData = nil
end

function GuideNoteModel:OnReset()
  self._awakerStrengthSelectedAwakerTid = nil
  self._guideNoteData = nil
end

function GuideNoteModel:_LoadAwakerStrengthSelectedAwakerTid()
  local tid = 0
  if MobileFileDataManager and MobileFileDataManager.Instance then
    tid = MobileFileDataManager.Instance:GetPlayerFileValue(AWAKER_STRENGTH_SELECTED_SAVE_KEY, 0)
  end
  tid = tonumber(tid) or 0
  if tid < 0 then
    tid = math.abs(tid)
  end
  self._awakerStrengthSelectedAwakerTid = tid
end

function GuideNoteModel:UpdateGuideNoteData(data)
  self._guideNoteData = self._guideNoteData or {}
  if data.dailyExp then
    self._guideNoteData.dailyExp = data.dailyExp
  end
  if data.weeklyExp then
    self._guideNoteData.weeklyExp = data.weeklyExp
  end
  if data.dailyRewardMap then
    self._guideNoteData.dailyRewardMap = data.dailyRewardMap
  end
  if data.weeklyRewardMap then
    self._guideNoteData.weeklyRewardMap = data.weeklyRewardMap
  end
  if data.rewardMapChange then
    if data.rewardMapChange.dailyRewardMap then
      self._guideNoteData.dailyRewardMap = data.rewardMapChange.dailyRewardMap
    end
    if data.rewardMapChange.weeklyRewardMap then
      self._guideNoteData.weeklyRewardMap = data.rewardMapChange.weeklyRewardMap
    end
  end
  self:RefreshSidebarRedDotMap()
  self:LocalNotify(NotifyId.OnGuideNoteDataChanged)
end

function GuideNoteModel:HasGuideNoteData()
  return self._guideNoteData and table.next(self._guideNoteData) ~= nil
end

function GuideNoteModel:GetGuideNoteData()
  return self._guideNoteData
end

function GuideNoteModel:GetActivityExp(levelType)
  local data = self._guideNoteData or {}
  if levelType == LevelType.Weekly then
    return tonumber(data.weeklyExp) or 0
  end
  return tonumber(data.dailyExp) or 0
end

function GuideNoteModel:GetRewardMap(levelType)
  local data = self._guideNoteData or {}
  if levelType == LevelType.Weekly then
    return data.weeklyRewardMap or {}
  end
  return data.dailyRewardMap or {}
end

function GuideNoteModel:IsRewardReceived(levelType, level)
  level = tonumber(level)
  if not level then
    return false
  end
  local rewardMap = self:GetRewardMap(levelType)
  return true == rewardMap[level]
end

function GuideNoteModel:_GetActivityTierRawPairArray(levelType)
  if levelType == LevelType.Weekly then
    local c = DT.Constant[WEEKLY_TIER_REWARD_CONST_KEY]
    return c and c.Data or {}
  end
  return DT.GetOriginalConstant("GuideNoteDailyActivityTierRewards", {}) or {}
end

local function GetActivityExpMaxNeed(self, levelType)
  local maxNeed = 0
  local raw = self:_GetActivityTierRawPairArray(levelType)
  for i = 1, #raw, 2 do
    local need = tonumber(raw[i]) or 0
    if maxNeed < need then
      maxNeed = need
    end
  end
  return maxNeed
end

local function IsActivityExpFull(self, levelType)
  local maxNeed = GetActivityExpMaxNeed(self, levelType)
  return maxNeed > 0 and maxNeed <= self:GetActivityExp(levelType)
end

function GuideNoteModel:HasClaimableActivityTierReward(levelType)
  if not self:HasGuideNoteData() then
    return false
  end
  local activityValue = self:GetActivityExp(levelType)
  local raw = self:_GetActivityTierRawPairArray(levelType)
  for i = 1, #raw, 2 do
    local need = raw[i]
    if need and activityValue >= need and not self:IsRewardReceived(levelType, need) then
      return true
    end
  end
  return false
end

function GuideNoteModel:SetCurPage(page)
  if nil == page then
    return false
  end
  if self.curPage == page then
    return false
  end
  self.lastPage = self.curPage
  self.curPage = page
  if page ~= GuideNotePage.StoryGuide and CopyStoryGuideModel and CopyStoryGuideModel.Instance then
    CopyStoryGuideModel.Instance:ClearPendingReturnStageGroupTid()
  end
  self:LocalNotify(NotifyId.OnGuideNoteMainModuleChanged, page)
  return true
end

function GuideNoteModel:GetCurPage()
  return self.curPage
end

function GuideNoteModel:SetSidebarRedDotMap(map)
  if type(map) ~= "table" then
    self._sidebarRedDot = {}
    return
  end
  self._sidebarRedDot = map
end

function GuideNoteModel:SetSidebarRedDot(moduleType, show)
  self._sidebarRedDot[moduleType] = show and true or false
end

function GuideNoteModel:ShouldShowSidebarRedDot(moduleType)
  return self._sidebarRedDot[moduleType] == true
end

function GuideNoteModel:SetAwakerStrengthSelectedAwakerTid(tid)
  tid = tonumber(tid) or 0
  if tid < 0 then
    tid = math.abs(tid)
  end
  self._awakerStrengthSelectedAwakerTid = tid
  if MobileFileDataManager and MobileFileDataManager.Instance then
    MobileFileDataManager.Instance:SetPlayerFileValue(AWAKER_STRENGTH_SELECTED_SAVE_KEY, tid, true)
  end
end

function GuideNoteModel:GetAwakerStrengthSelectedAwakerTid()
  if self._awakerStrengthSelectedAwakerTid == nil then
    self:_LoadAwakerStrengthSelectedAwakerTid()
  end
  return self._awakerStrengthSelectedAwakerTid or 0
end

function GuideNoteModel:_IsFeatureUnlocked(featureId, featureKey)
  if not featureId then
    return true
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(featureId, featureKey or 0)
  return true == unlocked
end

function GuideNoteModel:RefreshSidebarRedDotMap()
  local map = {}
  map[ModuleType.DailyActivity] = false
  map[ModuleType.WeeklyActivity] = false
  map[ModuleType.AwakerStrength] = false
  map[ModuleType.PermTrain] = false
  map[ModuleType.StoryGuide] = false
  if not self:_IsFeatureUnlocked(FeatureId.GuideNote, 0) then
    self:SetSidebarRedDotMap(map)
    return
  end
  if self:_IsFeatureUnlocked(FeatureId.GuideNote_DailyTask, 0) then
    local hasTaskReceive = false
    if not IsActivityExpFull(self, LevelType.Daily) then
      hasTaskReceive = RedPointDataUtils.IsShowTaskReceiveRedDot({
        TaskServerIndex.Daily
      }) and true or false
    end
    map[ModuleType.DailyActivity] = hasTaskReceive or self:HasClaimableActivityTierReward(LevelType.Daily)
  end
  if self:_IsFeatureUnlocked(FeatureId.GuideNote_WeekTask, 0) then
    local hasTaskReceive = false
    if not IsActivityExpFull(self, LevelType.Weekly) then
      hasTaskReceive = RedPointDataUtils.IsShowTaskReceiveRedDot({
        TaskServerIndex.Weekly
      }) and true or false
    end
    map[ModuleType.WeeklyActivity] = hasTaskReceive or self:HasClaimableActivityTierReward(LevelType.Weekly)
  end
  map[ModuleType.PermTrain] = false
  self:SetSidebarRedDotMap(map)
end

return GuideNoteModel
