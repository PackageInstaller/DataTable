local DungeonData = class("DungeonData")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local DungeonStageData = require("Game.Dungeon.DungeonStageData")

local function SortFunc(a, b)
  return a:GetDungeonStageId() < b:GetDungeonStageId()
end

function DungeonData.CreateDungeonData(dungeonTypeData, dungeonCfg)
  local data = DungeonData.New()
  data.dungeonId = dungeonCfg.id
  data.systemFunctionId = dungeonCfg.id
  data.dungeonTypeData = dungeonTypeData
  data.dungeonCfg = dungeonCfg
  if dungeonCfg.stage_type ~= 0 then
    data.subTitleId = dungeonCfg.stage_type
  end
  data:__UpdateIsUnlock()
  if data:GetIsUnlock() then
    data.dungeonStageList = {}
    for _, dungeonStageId in ipairs(dungeonCfg.stage_id) do
      local cfg = ConfigData.battle_dungeon[dungeonStageId]
      if cfg == nil then
        error("read battle_dungeon error stageId:" .. dungeonStageId)
      else
        local dungeonStageData = DungeonStageData.CreateDungeonStageData(data, cfg)
        table.insert(data.dungeonStageList, dungeonStageData)
      end
    end
    table.sort(data.dungeonStageList, SortFunc)
  end
  return data
end

function DungeonData.CreateDungeonData4Frage(dungeonTypeData, heroData, dungeonCfg)
  local data = DungeonData.New()
  data.isFrageDungeon = true
  data.dungeonId = proto_csmsg_SystemFunctionID.SystemFunctionID_friendship
  data.systemFunctionId = proto_csmsg_SystemFunctionID.SystemFunctionID_friendship
  data.dungeonTypeData = dungeonTypeData
  data.dungeonCfg = dungeonCfg
  data.heroData = heroData
  data.itemId = heroData.dataId
  data.sortParam = heroData.career
  data:__UpdateIsUnlock()
  if data:GetIsUnlock() then
    data.dungeonStageList = {}
    for _, dungeonStageId in ipairs(ConfigData.friendship_hero[heroData.dataId].plot_stage) do
      local cfg = ConfigData.battle_dungeon[dungeonStageId]
      if cfg == nil then
        error("read battle_dungeon error stageId:" .. dungeonStageId)
      else
        local dungeonStageData = DungeonStageData.CreateDungeonStageData(data, cfg)
        table.insert(data.dungeonStageList, dungeonStageData)
      end
    end
  end
  return data
end

function DungeonData:ctor()
  self.dungeonTypeData = nil
  self.dungeonId = nil
  self.systemFunctionId = nil
  self.dungeonCfg = nil
  self.isUnlock = false
  self.dungeonStageList = {}
  self.subTitleId = nil
  self.__isHaverewardRateChange = nil
  self.__rewardCahangeRate = nil
  self.__rewardRateCahangeTotalNum = nil
  self.__rewardRateCahangeExpiredTm = nil
  self.isFrageDungeon = nil
  self.heroData = nil
  self.itemId = nil
  self.sortParam = nil
end

function DungeonData:__UpdateIsUnlock()
  if self.isFrageDungeon then
    local friendshipHeroCfg = ConfigData.friendship_hero[self.heroData.dataId]
    if friendshipHeroCfg == nil then
      error("can't reda friendshipHeroCfg with HeroId:" .. tostring(self.heroData.dataId))
      self.isUnlock = false
      return
    end
    self.isUnlock = #friendshipHeroCfg.plot_stage > 0
    return
  end
  self.isUnlock = FunctionUnlockMgr:ValidateUnlock(self.systemFunctionId)
end

function DungeonData:UnlockAndHasStageOpen()
  local unlock = self:GetIsUnlock()
  local hasStageOpen = self:__HasStageOpen()
  return unlock and hasStageOpen
end

function DungeonData:__HasStageOpen()
  local isOpen = false
  for index, dungeonStage in ipairs(self.dungeonStageList) do
    if dungeonStage:GetDungeonStageIsUnlock() then
      isOpen = true
      break
    end
  end
  return isOpen
end

function DungeonData:GetNewLockStage()
  local stageCfg
  for index, dungeonStage in ipairs(self.dungeonStageList) do
    if not dungeonStage:GetDungeonStageIsUnlock() then
      stageCfg = dungeonStage:GetDungeonStageCfg()
      break
    end
  end
  return stageCfg
end

function DungeonData:CleanCacheData()
  self.__isHaverewardRateChange = nil
end

function DungeonData:CalUnLockedAndProgress()
  for index, dungeonStageData in ipairs(self.dungeonStageList) do
    dungeonStageData:__UpdateStage()
  end
end

function DungeonData:GetDungeonSystemFunctionId()
  return self.systemFunctionId
end

function DungeonData:GetDungeonId()
  return self.dungeonId
end

function DungeonData:GetDungeonId4SaveFragFormation()
  return self.dungeonId * 100 + self.itemId
end

function DungeonData:GetIsUnlock()
  return self.isUnlock
end

function DungeonData:GetDungeonUnlockDes()
  return FunctionUnlockMgr:GetFuncUnlockDecription(self.systemFunctionId, true)
end

function DungeonData:GetDungeonCfg()
  return self.dungeonCfg
end

function DungeonData:GetDungeonName()
  local panelName = LanguageUtil.GetLocaleText(self.dungeonCfg.name_panel)
  if string.IsNullOrEmpty(panelName) then
    panelName = LanguageUtil.GetLocaleText(self.dungeonCfg.name)
  end
  return panelName
end

function DungeonData:GetDgDataDropCfg()
  local dungeonCfg = self.dungeonCfg
  local dropId = ConfigData.battle_dungeon_period_drop.dgTypeDic[dungeonCfg.dungeon_type]
  if dropId == nil then
    return nil
  end
  local dropCfg = ConfigData.battle_dungeon_period_drop[dropId]
  return dropCfg
end

function DungeonData:IsHideDg()
  return self.dungeonCfg.is_hide
end

function DungeonData:GetSubTitleId()
  return self.subTitleId
end

function DungeonData:GetDungeonHeroData()
  return self.heroData
end

function DungeonData:GetDungeonName()
  if self.isFrageDungeon then
    return self.heroData:GetName(), self.heroData:GetEnName()
  else
    return LanguageUtil.GetLocaleText(self.dungeonCfg.name), LanguageUtil.GetLocaleText(self.dungeonCfg.name_en)
  end
end

function DungeonData:GetDungeonStageList()
  return self.dungeonStageList
end

function DungeonData:GetDungeonStageCount()
  return #self.dungeonStageList
end

function DungeonData:GetDungeonStageCompletedCount()
  local completedCount = 0
  for index, dungeonStageData in ipairs(self.dungeonStageList) do
    if dungeonStageData:GetDungeonStageIsCompleted() then
      completedCount = completedCount + 1
    end
  end
  return completedCount
end

function DungeonData:GetDungeonPlayLimit()
  local limit = 0
  local cfgLimit = ConfigData.material_dungeon[self.dungeonId].frequency_day
  if cfgLimit == -1 then
    return -1
  end
  limit = limit + cfgLimit
  limit = limit + (PlayerDataCenter.playerBonus:GetDungeonCountAdd(self.systemFunctionId) or 0)
  return limit
end

function DungeonData:GetDungeonDropInfo()
  local matCfg = ConfigData.material_dungeon[self.dungeonId]
  if matCfg == nil then
    error("Cant get material_dungeon,dungeonId = " .. tostring(self.dungeonId))
    return
  end
  return ConfigData:GetTipContent(matCfg.drop_info)
end

function DungeonData:GetDungeonPlayedNum()
  local playedNums = 0
  if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and PlayerDataCenter.dungeonDailyBattleTimes[self.systemFunctionId] ~= nil then
    local usedData = PlayerDataCenter.dungeonDailyBattleTimes[self.systemFunctionId].data
    for k, v in pairs(usedData) do
      if v ~= nil then
        playedNums = playedNums + v
      end
    end
  end
  return playedNums
end

function DungeonData:GetDungeonPlayLeftLimitNum()
  local totaleLimit = self:GetDungeonPlayLimit()
  if totaleLimit == -1 then
    return -1
  end
  local playedNums = self:GetDungeonPlayedNum()
  return totaleLimit - playedNums, totaleLimit, playedNums
end

function DungeonData:GetIsHaveMultReward()
  return self:GetIsDungeonDoubleWithLimit() or self:GetIsDungeonHaveMultReward()
end

function DungeonData:IsDungeonHasDoubleReward()
  for _, dungeonStage in ipairs(self.dungeonStageList) do
    return PlayerDataCenter.playerBonus:IsDungeonHasMultReward(dungeonStage:GetDungeonSeverType())
  end
  return false
end

function DungeonData:GetLeftActivityMultRewardNum()
  if self.__rewardRateCahangeTotalNum == nil then
    return 0, 0
  end
  if self.__rewardRateCahangeTotalNum == 0 then
    return 0, -1
  end
  return self.__rewardRateCahangeTotalNum - self:GetDungeonThisCycleMultRewardNumPlayedNum(), self.__rewardRateCahangeTotalNum
end

function DungeonData:GetActivityMultRewardRate()
  return self.__rewardCahangeRate or 0
end

function DungeonData:GetActivityMultRewardExpiredTm()
  return self.__rewardRateCahangeExpiredTm or 0
end

function DungeonData:GetIsDungeonHaveMultReward()
  if self.__isHaverewardRateChange == nil then
    local stageDungeonStypDic = {}
    for _, dungeonStage in ipairs(self.dungeonStageList) do
      stageDungeonStypDic[dungeonStage:GetDungeonSeverType()] = true
    end
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
    local weekNum, nextExpiredTm = timePassCtrl:GetLogicWeekNum()
    if weekNum == nil then
      self.__isHaverewardRateChange = false
      return self.__isHaverewardRateChange
    else
      self.__isHaverewardRateChange = false
      local num = 0
      local numAll = 0
      for dungeonServerType, _ in pairs(stageDungeonStypDic) do
        num = math.max(PlayerDataCenter.playerBonus:GetDungeonMultReward(dungeonServerType, weekNum), num)
        numAll = math.max(PlayerDataCenter.playerBonus:GetDungeonMultReward(dungeonServerType, 0), numAll)
      end
      if num == 0 and numAll == 0 then
        return false
      end
      local realNum = math.max(num, numAll)
      self.__rewardCahangeRate = realNum // 10000
      self.__rewardRateCahangeTotalNum = realNum % 10000
      if self.__rewardCahangeRate == 0 or self.__rewardRateCahangeTotalNum == 0 then
        return false
      end
      self.__isHaverewardRateChange = true
      if num < numAll then
        self.__rewardRateCahangeExpiredTm = -1
      else
        self.__rewardRateCahangeExpiredTm = nextExpiredTm
      end
      local dungeonType
      for dungeonServerType, _ in pairs(stageDungeonStypDic) do
        dungeonType = dungeonServerType
        break
      end
      local curActivityDic = PlayerDataCenter.playerBonus:GetDungeonMultRewardCurActivityIdDic(dungeonType)
      local activityId
      for id, _ in pairs(curActivityDic) do
        activityId = id
        break
      end
      if activityId ~= nil then
        local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
        local actData = activivityCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.DungeonDouble, activityId)
        if actData ~= nil then
          self.__rewardRateCahangeExpiredTm = actData:GetActivityDestroyTime()
        end
      end
      return self.__isHaverewardRateChange and (PlayerDataCenter.timestamp < self.__rewardRateCahangeExpiredTm or 0 > self.__rewardRateCahangeExpiredTm) and 0 < self:GetLeftActivityMultRewardNum()
    end
  end
  return self.__isHaverewardRateChange and (PlayerDataCenter.timestamp < self.__rewardRateCahangeExpiredTm or 0 > self.__rewardRateCahangeExpiredTm) and 0 < self:GetLeftActivityMultRewardNum()
end

function DungeonData:GetIsDungeonDoubleWithLimit()
  local double = self:GetDungeonDoubleWithLimit()
  if double == -1 then
    return true
  end
  return double > self:GetDungeonThisCycleMultRewardNumPlayedNum()
end

function DungeonData:GetDungeonDoubleWithLimit()
  if self.isFrageDungeon then
    return 0
  end
  return self.dungeonCfg.double
end

function DungeonData:IsFrageDungeon()
  return self.isFrageDungeon
end

function DungeonData:GetDungeonThisCyclePlayedNum()
  local dailyPlayedNum = 0
  for _, dungeonStage in ipairs(self.dungeonStageList) do
    dailyPlayedNum = dailyPlayedNum + dungeonStage:GetThisCyclePlayedNum()
  end
  return dailyPlayedNum
end

function DungeonData:GetDungeonThisCycleMultRewardNumPlayedNum()
  local dgCfg = ConfigData.battle_dungeon_dungeon[self.dungeonCfg.dungeon_type]
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  if dgCfg ~= nil and dgCfg.share_twice > 0 then
    return timePassCtrl:GetDungeonShareRateEnterNum(dgCfg.share_twice)
  end
  return timePassCtrl:GetDungeonRateEnterNum(self.systemFunctionId)
end

function DungeonData:GetDungeonAutoBattleMaxLimit()
  local total = 0
  local limitCount = self:GetDungeonPlayLeftLimitNum()
  for i, dungeonStage in ipairs(self.dungeonStageList) do
    if PlayerDataCenter:IsDungeonCompletedWithoutSupport(dungeonStage:GetDungeonStageId()) and not dungeonStage:GetIsReach2Limit() then
      local remainCount = dungeonStage:GetCurDungeonDailyLimit()
      if remainCount < 0 then
        return false, -1
      end
      total = total + remainCount
    end
  end
  if 0 <= limitCount then
    total = math.min(total, limitCount)
  end
  return true, total
end

function DungeonData:GetDungeonAutoBattleMaxStage()
  for i = #self.dungeonStageList, 1, -1 do
    local dungeonStage = self.dungeonStageList[i]
    if PlayerDataCenter:IsDungeonCompletedWithoutSupport(dungeonStage:GetDungeonStageId()) and not dungeonStage:GetIsReach2Limit() then
      return dungeonStage
    end
  end
  return nil
end

function DungeonData:GetDgDgTypeData()
  return self.dungeonTypeData
end

function DungeonData:Update()
end

function DungeonData:Delete()
end

return DungeonData
