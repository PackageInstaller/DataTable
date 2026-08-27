local DungeonTowerDynData = class("DungeonTowerDynData")

function DungeonTowerDynData:ctor()
  self.__towerData = {}
  self.__newTower = {}
  self.__inited = false
end

function DungeonTowerDynData:InitTowerServerData(msg)
  if msg == nil then
    self:__RefreshAllNewTwinTower()
    return
  end
  for k, v in pairs(msg.towers) do
    self.__towerData[v.towerId] = v
    self:_OnDungeTowerDataUpdate(v.towerId, v)
  end
  self:__RefreshAllNewTwinTower()
end

function DungeonTowerDynData:UpdateTowerServerData(msg)
  for k, v in pairs(msg.update) do
    self.__towerData[v.towerId] = v
    self:_OnDungeTowerDataUpdate(v.towerId, v)
  end
  if not self:__RefreshAllNewTwinTower() then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    for k, v in pairs(msg.update) do
      self:__RefreshNewTwinTower(v.towerId, userDataCache)
    end
  end
end

function DungeonTowerDynData:__RefreshAllNewTwinTower()
  if self.__inited then
    return false
  end
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for _, towerId in pairs(ConfigData.dungeon_tower_type.twin_towers) do
    self:__RefreshNewTwinTower(towerId, userDataCache)
  end
  local towerId = self:GetDefaultTowerId()
  local normalTowerCfg = ConfigData.dungeon_tower_type[towerId]
  local lastLevel = userDataCache:GetNormalTowerLevel()
  if lastLevel < normalTowerCfg.total_level then
    local normalTower = self:GetDynTowerDataById(towerId)
    local lastTowerNum = math.min(normalTowerCfg.total_level, normalTowerCfg.total_level - ConfigData.game_config.towerLastUpdate + 1)
    if normalTower == nil or lastTowerNum > normalTower.currentCompletedId then
      self.__newTower[towerId] = true
    else
      userDataCache:SetNormalTowerLevel(normalTowerCfg.total_level)
    end
  end
  self.__inited = true
  return true
end

function DungeonTowerDynData:__RefreshNewTwinTower(towerId, userDataCache)
  if self.__towerData[towerId] ~= nil then
    userDataCache:SetTwinTowerNewReaded(towerId)
    self.__newTower[towerId] = nil
  elseif not userDataCache:GetTwinTowerNewReaded(towerId) then
    self.__newTower[towerId] = true
  end
end

function DungeonTowerDynData:HasNewDunTower()
  return not table.IsEmptyTable(self.__newTower)
end

function DungeonTowerDynData:HasNewDunTwinTower()
  local dtowerId = self:GetDefaultTowerId()
  for towerId, _ in pairs(self.__newTower) do
    if towerId ~= dtowerId then
      return true
    end
  end
  return false
end

function DungeonTowerDynData:IsNewDunTower(towerId)
  return self.__newTower[towerId] or false
end

function DungeonTowerDynData:ClearNewDunTower(towerId)
  self.__newTower[towerId] = nil
end

function DungeonTowerDynData:IsNewNormalDunTower()
  return self:IsNewDunTower(self:GetDefaultTowerId())
end

function DungeonTowerDynData:GetDynTowerDataById(id)
  return self.__towerData[id]
end

function DungeonTowerDynData:GetDefaultTowerId()
  return 1
end

function DungeonTowerDynData:GetDefaultTowerTotalLevel()
  local towerTypeCfg = ConfigData.dungeon_tower_type[self:GetDefaultTowerId()]
  return towerTypeCfg.total_level
end

function DungeonTowerDynData:GetDefaultTowerCompleteLevel()
  local towerData = self:GetDynTowerDataById(self:GetDefaultTowerId())
  if towerData == nil then
    return 0
  end
  return towerData.currentCompletedId
end

function DungeonTowerDynData:GetTowerCompleteLevel(towerId)
  local towerData = self:GetDynTowerDataById(towerId)
  if towerData == nil then
    return 0
  end
  return towerData.currentCompletedId
end

function DungeonTowerDynData:IsTowerRacingRewardPick(towerId, rewardId)
  local towerData = self:GetDynTowerDataById(towerId)
  if towerData == nil then
    return false
  end
  return towerData.rewardMask & 1 << rewardId > 0
end

function DungeonTowerDynData:GetTowerLevelRacingFrame(towerId, floorId)
  local towerData = self:GetDynTowerDataById(towerId)
  if towerData == nil or towerData.racing == nil then
    return -1
  end
  if floorId > towerData.currentCompletedId then
    return -1
  end
  local floorInfo = towerData.racing.floorInfo[floorId]
  if floorInfo ~= nil and floorInfo.floorId == floorId then
    return floorInfo.frame
  end
  for _, floorInfo in pairs(towerData.racing.floorInfo) do
    if floorInfo.floorId == floorId then
      return floorInfo.frame
    end
  end
  return -1
end

function DungeonTowerDynData:GetTowerTotalRacingFrame(towerId)
  local towerTypeCfg = ConfigData.dungeon_tower_type[towerId] or ConfigData.env_dungeon_tower[towerId]
  if towerTypeCfg == nil then
    return false, 0
  end
  local totalLevel = towerTypeCfg.total_level
  if totalLevel == nil then
    totalLevel = #ConfigData.env_dungeon_tower_dungeon_detail.tower2DunDic[towerId]
  end
  local towerData = self:GetDynTowerDataById(towerId)
  if towerData == nil then
    return false, 0
  end
  local completeLevel = towerData.currentCompletedId
  if totalLevel > completeLevel then
    return false, 0
  end
  if towerData.racing == nil then
    return false, 0
  end
  local frame = 0
  for _, floorInfo in pairs(towerData.racing.floorInfo) do
    frame = frame + floorInfo.frame
  end
  return true, frame
end

function DungeonTowerDynData:GetTwinTowerProgressInfo()
  local twinTowerList = ConfigData.dungeon_tower_type.twin_towers
  local completeCount = 0
  local towerCount = #twinTowerList
  for _, towerId in pairs(twinTowerList) do
    local towerTypeCfg = ConfigData.dungeon_tower_type[towerId]
    local completeLevel = self:GetTowerCompleteLevel(towerId)
    if completeLevel >= towerTypeCfg.total_level then
      completeCount = completeCount + 1
    end
  end
  return completeCount, towerCount
end

function DungeonTowerDynData:GetTwinTowerFirstNoComplete()
  local twinTowerList = ConfigData.dungeon_tower_type.twin_towers
  local completeCount = 0
  local towerCount = #twinTowerList
  for index, towerId in pairs(twinTowerList) do
    local towerTypeCfg = ConfigData.dungeon_tower_type[towerId]
    local completeLevel = self:GetTowerCompleteLevel(towerId)
    if completeLevel < towerTypeCfg.total_level then
      return index, towerId
    end
  end
  return 0, 0
end

function DungeonTowerDynData:_OnDungeTowerDataUpdate(towerId, towerData)
  local towerTypeCfg = ConfigData.dungeon_tower_type[towerId]
  if towerTypeCfg == nil then
    if ConfigData.env_dungeon_tower[towerId] ~= nil then
      towerTypeCfg = ConfigData.env_dungeon_tower[towerId]
      if (towerTypeCfg.start_time or 0) == 0 then
        return
      end
      local totalLevel = #ConfigData.env_dungeon_tower_dungeon_detail.tower2DunDic[towerId]
      local completeLevel = towerData.currentCompletedId
      if totalLevel > completeLevel then
        return
      end
      local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
      local rewardNode = twinTowerNode:AddChild(towerId)
      if rewardNode == nil then
        return
      end
      local rewardMask = ConfigData.env_dungeon_tower_speed_reward.reward_mask_dic[towerId]
      if rewardMask < towerData.rewardMask then
        rewardNode:SetRedDotCount(0)
      end
      local _, totalFrame = self:GetTowerTotalRacingFrame(towerId)
      local count = 0
      local racingCfg = ConfigData.env_dungeon_tower_speed_reward[towerId]
      for rewardId, racingCfg in ipairs(racingCfg) do
        local isPicked = 0 < towerData.rewardMask & 1 << rewardId
        if not isPicked then
          local frame = BattleUtil.SecondToFrame(racingCfg.time_limit)
          if totalFrame <= frame then
            count = count + 1
          end
        end
      end
      rewardNode:SetRedDotCount(count)
      return
    end
    self.__towerData[towerId] = nil
    return
  end
  if towerTypeCfg.tower_cat ~= 1 then
    return
  end
  local totalLevel = towerTypeCfg.total_level
  local completeLevel = towerData.currentCompletedId
  if totalLevel > completeLevel then
    return
  end
  if towerData.rewardMask >= towerTypeCfg.racing_reward_mask then
    local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower, RedDotStaticTypeId.DungeonTwinTower)
    local rewardNode = twinTowerNode:GetChild(towerId)
    if rewardNode ~= nil then
      rewardNode:SetRedDotCount(0)
    end
    return
  end
  local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower, RedDotStaticTypeId.DungeonTwinTower)
  local rewardNode = twinTowerNode:AddChildWithPath(towerId, RedDotDynPath.DunTwinTowerReward)
  local _, totalFrame = self:GetTowerTotalRacingFrame(towerId)
  local count = 0
  local racingCfg = ConfigData.dungeon_tower_racing[towerId]
  for rewardId, racingCfg in pairs(racingCfg) do
    local isPicked = 0 < towerData.rewardMask & 1 << rewardId
    if not isPicked then
      local frame = BattleUtil.SecondToFrame(racingCfg.time_limit)
      if totalFrame <= frame then
        count = count + 1
      end
    end
  end
  rewardNode:SetRedDotCount(count)
end

return DungeonTowerDynData
