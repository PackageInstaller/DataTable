local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivitySeasonData = class("ActivitySeasonData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Season
local ActivityFrameData = require("Game.ActivityFrame.ActivityFrameData")
local ActivitySeasonEnum = require("Game.ActivitySeason.ActivitySeasonEnum")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local ActTermTaskDataOne = require("Game.ActivityFrame.ActTermTaskDataOne")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ActivitySeasonDungeonDataI = require("Game.ActivitySeason.Data.ActivitySeasonDungeonDataI")
local ActDungeonLevelCollect = require("Game.ActivityFrame.ActDungeonLevelCollect")
local ActInternalUnlockInfo = require("Game.Common.Activity.ActInternalUnlockInfo")
local ActTechTree = require("Game.ActivityFrame.ActTechTree")
local WarChessSeasonAddtionData = require("Game.WarChessSeason.WarChessSeasonAddtionData")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function ActivitySeasonData:InitSeasonData(msg)
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ActivitySeason)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_season_main[msg.actId]
  self:__InitTechData()
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self:__InitSeasonDungeon()
  self:__GenSectorAvgDic()
  self._rewardCfg = ConfigData.activity_season_reward[msg.actId]
  local count = #self._rewardCfg
  self._maxLevel = count
  self._cycleExp = self._rewardCfg[count].need_exp
  self._fixExpMax = self._rewardCfg[self._maxLevel].total_exp
  self._rewardMaskDic = {}
  self:UpdateSeasonData(msg)
  self._termTaskData:RegisterActTermRefresh()
  self:RefreshRedSeasonDailyTask()
  self:RefreshRedSeasonOnceTask()
  self:RefreshRedSeasonMainStory()
  self:RefreshRedSeasonTech()
  self:__InitUnlockInfo()
end

function ActivitySeasonData:__InitTechData()
  self._actTechTree = ActTechTree.New()
  self._actTechTree:InitTechTree(self._mainCfg.tech_id, self)
  local RefreshRedTechCallback = BindCallback(self, self.RefreshRedSeasonTech)
  self._actTechTree:BindActTechUpdateFunc(RefreshRedTechCallback)
  self._actTechTree:BindActTechAllResetFunc(RefreshRedTechCallback)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  actFrameCtrl:AddActivityTech(self._actTechTree)
end

function ActivitySeasonData:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedSeasonDailyTaskCallback = BindCallback(self, self.RefreshRedSeasonDailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedSeasonDailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedSeasonDailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedSeasonDailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function ActivitySeasonData:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataOne.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedSeasonOnceTaskCallback = BindCallback(self, self.RefreshRedSeasonOnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedSeasonOnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedSeasonOnceTaskCallback)
end

function ActivitySeasonData:__InitSeasonDungeon()
  local dungeonCfgs = ConfigData.activity_season_battle_ex[self:GetActId()]
  local dungeonCfgList = {}
  for _, dungeonCfg in pairs(dungeonCfgs) do
    table.insert(dungeonCfgList, dungeonCfg)
  end
  table.sort(dungeonCfgList, function(a, b)
    return a.dungeon_id < b.dungeon_id
  end)
  local dungeonLevelDataList = {}
  for i, dungeonCfg in ipairs(dungeonCfgList) do
    local dungeonLevelData = ActivitySeasonDungeonDataI.New(dungeonCfg.dungeon_id, dungeonCfg, self._mainCfg.warchess_season_id, i)
    table.insert(dungeonLevelDataList, dungeonLevelData)
  end
  self._dungeonCollect = ActDungeonLevelCollect.New()
  self._dungeonCollect:InitActDungeonLevelCollect(dungeonLevelDataList, self)
  self._dungeonCollect:SetDungeonLevelCollectName(LanguageUtil.GetLocaleText(self._mainCfg.battle_title), self._mainCfg.battle_title_en)
end

function ActivitySeasonData:__InitUnlockInfo()
  self._unlockInfo = ActInternalUnlockInfo.New()
end

function ActivitySeasonData:__InitSeasonUnlockRepeat()
  if self._settedUnlockRepeat then
    return
  end
  self._settedUnlockRepeat = true
  local dunLockDic = {}
  for _, dungeonLevelData in ipairs(self._dungeonCollect:GetActDungeonSortList()) do
    local stageId = dungeonLevelData:GetDungeonLevelStageId()
    if not dungeonLevelData:GetIsLevelUnlock() then
      dunLockDic[stageId] = dungeonLevelData
    end
  end
  self._unlockInfo:InitActDunRepeatUnlockInfo(dunLockDic)
end

function ActivitySeasonData:__InitSeasonUnlockAvg()
  if self._settedUnlockAvg then
    return
  end
  self._settedUnlockAvg = true
  self._unlockInfo:InitActAvgUnlockInfo(self._mainCfg.story_stage)
end

function ActivitySeasonData:RefreshRedSeasonTech()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySeasonEnum.reddotType.Tech)
  local spBranch = self._mainCfg.tech_special_branch
  local flag = ActivityFrameUtil.CalActTechRedWithSpBranchAndItem(self, self._actTechTree, spBranch, 16000)
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySeasonData:RefreshRedSeasonDailyTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if self._dailyTaskData == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySeasonEnum.reddotType.DailyTask)
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySeasonData:RefreshRedSeasonOnceTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySeasonEnum.reddotType.OnceTask)
  local flag = self._termTaskData:IsExistTermCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySeasonData:RefreshRedSeasonMainStory()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActivitySeasonEnum.reddotType.mainStory)
  if self._avgIdDic == nil then
    self:__GenSectorAvgDic()
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  for k, v in pairs(self._avgIdDic) do
    local played = avgPlayCtrl:IsAvgPlayed(k)
    local unlock = avgPlayCtrl:IsAvgUnlock(k)
    if not played and unlock then
      flag = true
      break
    end
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySeasonData:RefreshRedSeasonBonus()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local canReceive = self:HasSeasonRewardExpCanReceive()
  local childReddot = reddot:AddChild(ActivitySeasonEnum.reddotType.Bonus)
  local redCount = canReceive and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySeasonData:UpdateSeasonData(msg)
  if msg and msg.tech then
    self._actTechTree:UpdateActTechTree(msg.tech)
  end
  local lastLevel = self._level
  self._level = msg.level
  self._exp = msg.exp
  if lastLevel ~= nil and self._level ~= lastLevel then
    self:UpdateSeasonUnlockAvg()
  end
  for level = 1, self._level do
    if not self._rewardMaskDic[level] then
      local index = math.floor(level / 32)
      local mask = msg.rewardsMask[index + 1]
      if mask ~= nil then
        self._rewardMaskDic[level] = 0 ~= mask & 1 << level % 32
      else
        self._rewardMaskDic[level] = false
      end
    end
  end
  self._cycleRewardPickedCount = msg.extraPickLevel
  self:RefreshRedSeasonBonus()
  self:RefreshRedSeasonMainStory()
  local bonusUI = UIManager:GetWindow(UIWindowTypeID.ActivitySeasonBonus)
  if bonusUI ~= nil then
    bonusUI:RefreshActivitySeasonBouns()
  end
end

function ActivitySeasonData:UpdateSeasonUnlockAvg()
  if self._unlockInfo ~= nil then
    self:__InitSeasonUnlockAvg()
    self._unlockInfo:UpdateActAvgUnlockInfo()
  end
end

function ActivitySeasonData:UpdateSeasonUnlockRepeat()
  if self._unlockInfo ~= nil then
    self:__InitSeasonUnlockRepeat()
    self._unlockInfo:UpdateActDunRepeatUnlockInfo()
  end
end

function ActivitySeasonData:__GenSectorAvgDic()
  self._avgIdDic = {}
  local avgIds = ConfigData.story_avg.sectorAvgDic[self._mainCfg.story_stage]
  if avgIds == nil then
    return
  end
  for i, v in ipairs(avgIds) do
    self._avgIdDic[v] = true
  end
end

function ActivitySeasonData:IsSeasonSectorAvg(avgId)
  if self._avgIdDic == nil then
    self:__GenSectorAvgDic()
  end
  return self._avgIdDic[avgId]
end

function ActivitySeasonData:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivitySeasonEnum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivitySeasonData:GetSeasonTechTree()
  return self._actTechTree
end

function ActivitySeasonData:GetSeasonDailyTaskData()
  return self._dailyTaskData
end

function ActivitySeasonData:GetSeasonTermTaskData()
  return self._termTaskData
end

function ActivitySeasonData:GetSeasonUnlockInfo()
  return self._unlockInfo
end

function ActivitySeasonData:GetSeasonMainCfg()
  return self._mainCfg
end

function ActivitySeasonData:GetSeasonRewardCfg()
  return self._rewardCfg
end

function ActivitySeasonData:GetSeasonTokenItemId()
  return self._mainCfg.token_item
end

function ActivitySeasonData:GetSeasonRewardCurLv()
  return self._level
end

function ActivitySeasonData:GetSeasonRewardLvLimit()
  return self._maxLevel
end

function ActivitySeasonData:GetSeasonRewardAllExp()
  return PlayerDataCenter:GetItemCount(self:GetSeasonTokenItemId())
end

function ActivitySeasonData:GetSeasonRewardCurExp()
  return self._exp
end

function ActivitySeasonData:GetSeasonRewardCurExpLimit()
  local cfg = self._rewardCfg[self:GetSeasonRewardCurLv()]
  if cfg == nil then
    return 0
  end
  return cfg.need_exp
end

function ActivitySeasonData:GetSeasonRewardCycleExpLimit()
  return self._cycleExp
end

function ActivitySeasonData:GetSeasonDungeonCollect()
  return self._dungeonCollect
end

function ActivitySeasonData:GeSeasonTechTree()
  return self._actTechTree
end

function ActivitySeasonData:IsSeasonRewardLevelCanPick(level)
  if self._rewardMaskDic[level] then
    return false
  end
  return level <= self._level
end

function ActivitySeasonData:IsSeasonRewardLevelReceived(level)
  return self._rewardMaskDic[level]
end

function ActivitySeasonData:IsSeasonRewardCycleCanPick()
  if self._level < self._maxLevel then
    return false
  end
  return self._exp >= self._cycleExp
end

function ActivitySeasonData:HasSeasonRewardExpCanReceive()
  for _, isPicked in ipairs(self._rewardMaskDic) do
    if not isPicked then
      return true
    end
  end
  return self:IsSeasonRewardCycleCanPick()
end

function ActivitySeasonData:ReqSeasonRewardExpReceive(level, callback)
  if not self:IsSeasonRewardLevelCanPick(level) then
    return
  end
  self._net:CS_ACTIVITY_Season_PickLevelReward(self:GetActId(), level, callback)
end

function ActivitySeasonData:ReqSeasonRewardExpCycle(callback)
  if not self:IsSeasonRewardCycleCanPick() then
    return
  end
  self._net:CS_ACTIVITY_Season_PickCirCleReward(self:GetActId(), callback)
end

function ActivitySeasonData:ReqSeasonRewardAllExp(callback)
  if not self:HasSeasonRewardExpCanReceive() then
    return
  end
  self._net:CS_ACTIVITY_Season_PickAllLevelReward(self:GetActId(), callback)
end

function ActivitySeasonData:GetSeasonId()
  return self._mainCfg.warchess_season_id
end

function ActivitySeasonData:GetGreenHandSectorId()
  return self._mainCfg.warchess_guide_sector
end

function ActivitySeasonData:GetSeasonAddtion()
  if self._seasonAddtionData == nil then
    self._seasonAddtionData = WarChessSeasonAddtionData.New()
  end
  return self._seasonAddtionData
end

return ActivitySeasonData
