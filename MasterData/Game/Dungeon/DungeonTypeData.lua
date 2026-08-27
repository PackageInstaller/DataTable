local DungeonTypeData = class("DungeonTypeData")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local DungeonData = require("Game.Dungeon.DungeonData")

function DungeonTypeData.CreateDungeonTypeData(eDungeonType)
  local systemFuncId = eDungeonEnum.systemFunctionID4DungeonType[eDungeonType]
  local isUnlock, unlockDes
  isUnlock = FunctionUnlockMgr:ValidateUnlock(systemFuncId)
  if not isUnlock then
    unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(systemFuncId)
  end
  local data = DungeonTypeData.New()
  data.dungeonType = eDungeonType
  data.isUnlock = isUnlock
  data.unlockDes = unlockDes
  data.systemFuncId = systemFuncId
  if eDungeonType == eDungeonEnum.eDungeonType.fragDungeon then
    local dungeonCfg = ConfigData.material_dungeon[1400]
    for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
      local friendShipCfg = ConfigData.friendship_hero[heroData.dataId]
      if friendShipCfg ~= nil and #friendShipCfg.plot_stage > 0 then
        local dungeonData = DungeonData.CreateDungeonData4Frage(data, heroData, dungeonCfg)
        table.insert(data.dungeonDataList, dungeonData)
      end
    end
    table.sort(data.dungeonDataList, function(dungeonA, dungeonB)
      local heroIdA = dungeonA.itemId
      local heroIdB = dungeonB.itemId
      local isUnlockA = dungeonA:GetIsUnlock()
      local isUnlockB = dungeonB:GetIsUnlock()
      if isUnlockA == isUnlockB then
        return heroIdA < heroIdB
      else
        return isUnlockA
      end
    end)
  else
    for dungeonId, cfg in pairs(ConfigData.material_dungeon) do
      if cfg.ui_type == eDungeonType then
        local dungeonData = DungeonData.CreateDungeonData(data, cfg)
        table.insert(data.dungeonDataList, dungeonData)
      end
    end
    table.sort(data.dungeonDataList, function(dungeonA, dungeonB)
      local IdA = dungeonA:GetDungeonId()
      local IdB = dungeonB:GetDungeonId()
      return IdA < IdB
    end)
  end
  return data
end

function DungeonTypeData:ctor()
  self.dungeonType = eDungeonEnum.eDungeonType.none
  self.systemFuncId = nil
  self.isUnlock = false
  self.unlockDes = nil
  self.dungeonDataList = {}
end

function DungeonTypeData:Update()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(self.systemFuncId)
  self.isUnlock = isUnlock
  if isUnlock and self.unlockDes ~= nil then
    self.unlockDes = nil
  end
end

function DungeonTypeData:UpdateDungeonAndStageUnlock()
  for _, dungeonData in pairs(self.dungeonDataList) do
    dungeonData:__UpdateIsUnlock()
    dungeonData:CleanCacheData()
    if dungeonData:GetIsUnlock() then
      for _, dungeonStageData in pairs(dungeonData:GetDungeonStageList()) do
        dungeonStageData:__UpdateStage()
      end
    end
  end
end

function DungeonTypeData:GetDungeonType()
  return self.dungeonType
end

function DungeonTypeData:GetDungeonTypeSystemFuncId()
  return self.systemFuncId
end

function DungeonTypeData:GetDungeonTypeIsUnlock()
  return self.isUnlock
end

function DungeonTypeData:GetDungeonTypeUnlockDes()
  return self.unlockDes
end

function DungeonTypeData:GetDungeonDataList()
  return self.dungeonDataList
end

function DungeonTypeData:GetDungeonTypePlayLimit()
  local limit = 0
  local systemFunctionID = self.systemFuncId
  if self.dungeonType == eDungeonEnum.eDungeonType.fragDungeon then
    local cfgLimit = ConfigData.material_dungeon[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship].frequency_day
    if cfgLimit == -1 then
      return -1
    end
    limit = limit + cfgLimit
    limit = limit + (PlayerDataCenter.playerBonus:GetDungeonCountAdd(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship) or 0)
  else
    for _, dungeonData in ipairs(self.dungeonDataList) do
      local dungeonLimit = dungeonData:GetDungeonPlayLimit()
      if dungeonLimit == -1 then
        return -1
      end
      limit = limit + dungeonLimit
    end
    limit = limit + (PlayerDataCenter.playerBonus:GetDungeonCountAdd(systemFunctionID) or 0)
  end
  return limit
end

function DungeonTypeData:GetDungeonTypePlayedNum()
  local playedNums = 0
  local systemFunctionID = self.systemFuncId
  if self.dungeonType == eDungeonEnum.eDungeonType.fragDungeon then
    if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and PlayerDataCenter.dungeonDailyBattleTimes[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship] ~= nil then
      local usedData = PlayerDataCenter.dungeonDailyBattleTimes[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship].data
      for k, v in pairs(usedData) do
        if v ~= nil then
          playedNums = playedNums + v
        end
      end
    end
  else
    for _, dungeonData in ipairs(self.dungeonDataList) do
      local dungeonPlayedNums = dungeonData:GetDungeonPlayedNum()
      playedNums = playedNums + dungeonPlayedNums
    end
  end
  return playedNums
end

function DungeonTypeData:GetDungeonTypePlayLeftLimitNum()
  local totaleLimit = self:GetDungeonTypePlayLimit()
  if totaleLimit == -1 then
    return -1
  end
  local playedNums = self:GetDungeonTypePlayedNum()
  return totaleLimit - playedNums, totaleLimit, playedNums
end

function DungeonTypeData:GetIsDungeonTypeHaveMultReward()
  for _, dungeonData in ipairs(self.dungeonDataList) do
    if dungeonData:GetIsHaveMultReward() then
      return true
    end
  end
  return false
end

function DungeonTypeData:GetDungeonTypeMultRewardIsOnlyDouble()
  local isOnlyDouble = true
  for _, dungeonData in ipairs(self.dungeonDataList) do
    if dungeonData:GetIsHaveMultReward() then
      local multAddRate = dungeonData:GetActivityMultRewardRate()
      if multAddRate ~= 1 then
        isOnlyDouble = false
      end
    end
  end
  return isOnlyDouble
end

function DungeonTypeData:Delete()
end

return DungeonTypeData
