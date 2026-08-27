local DungeonDyncData = class("DungeonDyncData")
local DungeonDyncElemDataDailyDg = require("Game.Dungeon.Dync.DungeonDyncElemDataDailyDg")
local DungeonDyncElemDataWinterChallengeDg = require("Game.Dungeon.Dync.DungeonDyncElemDataWinterChallengeDg")
local DungeonDyncElemHGV3 = require("Game.Dungeon.Dync.DungeonDyncElemHGV3")
local DungeonDyncElemHGV3Free = require("Game.Dungeon.Dync.DungeonDyncElemHGV3Free")
local DgDyncElemDataDic = {
  [proto_csmsg_DungeonType.DungeonType_Daily] = DungeonDyncElemDataDailyDg,
  [proto_csmsg_DungeonType.DungeonType_WinterHard] = DungeonDyncElemDataWinterChallengeDg,
  [proto_csmsg_DungeonType.DungeonType_HeroLite] = DungeonDyncElemHGV3,
  [proto_csmsg_DungeonType.DungeonType_HeroLiteFree] = DungeonDyncElemHGV3Free
}

local function _GetDgDyncElemData(moduleId)
  local dungeonType = ConfigData.battle_dungeon.moduleId2DungeonTypeDic[moduleId]
  if dungeonType == nil then
    error("Cant get dungeonType, moduleId = " .. tostring(moduleId))
    return
  end
  local DgDyncElemData = DgDyncElemDataDic[dungeonType]
  if DgDyncElemData == nil then
    error("Cant get DgDyncElemData, dungeonType = " .. tostring(dungeonType))
  end
  return DgDyncElemData
end

local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local FormationUtil = require("Game.Formation.FormationUtil")

function DungeonDyncData:ctor()
  self.dungeonDyncDataDic = {}
  self._defaultDungeonDyncDataDic = {}
end

function DungeonDyncData:InitDungeonDyncData(dungeonDync)
  for k, v in pairs(self.dungeonDyncDataDic) do
    v:ClearDungeonDyncElemFmtExclude()
  end
  self.dungeonDyncDataDic = {}
  self:UpdDungeonDyncData(dungeonDync, nil, false)
end

function DungeonDyncData:UpdDungeonDyncData(dungeonDync, deleteDic, needBroadcast)
  if deleteDic ~= nil then
    for k, v in pairs(deleteDic) do
      local dyncData = self.dungeonDyncDataDic[k]
      self.dungeonDyncDataDic[k] = nil
      if dyncData ~= nil then
        dyncData:ClearDungeonDyncElemFmtExclude()
      end
    end
  end
  for k, v in pairs(dungeonDync) do
    local elem = self.dungeonDyncDataDic[k]
    if elem == nil then
      local DgDyncElemData = _GetDgDyncElemData(k)
      if DgDyncElemData == nil then
        goto lbl_38
      end
      elem = DgDyncElemData.New()
      self.dungeonDyncDataDic[k] = elem
    end
    elem:UpdDungeonDyncElemData(v)
    ::lbl_38::
  end
  if needBroadcast then
    MsgCenter:Broadcast(eMsgEventId.DungeonUpdate)
  end
end

function DungeonDyncData:GetDailyDungeonDyncData()
  local dungeonUITypeDic = ConfigData.material_dungeon.dungeonUITypeDic
  local moduleIdList = dungeonUITypeDic[eDungeonEnum.eDungeonType.DailyDungeon]
  if moduleIdList == nil then
    error("Cant get dungeonUITypeDic, eDungeonEnum.eDungeonType.DailyDungeon")
    return
  end
  for k, moduleId in ipairs(moduleIdList) do
    if self.dungeonDyncDataDic[moduleId] ~= nil then
      return self.dungeonDyncDataDic[moduleId]
    end
  end
  local moduleId = moduleIdList[1]
  local dungeonDyncElemData = self._defaultDungeonDyncDataDic[moduleId] or DungeonDyncElemDataDailyDg.CreateDefaultDungeonDyncElemData(DungeonDyncElemDataDailyDg, moduleId)
  self._defaultDungeonDyncDataDic[moduleId] = dungeonDyncElemData
  return dungeonDyncElemData
end

function DungeonDyncData:GetWinterChallengeDgDyncData()
  return self:GetDungeonDyncData(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinterChallenge)
end

function DungeonDyncData:GetDungeonDyncData(moduleId)
  if self.dungeonDyncDataDic[moduleId] ~= nil then
    return self.dungeonDyncDataDic[moduleId]
  end
  local DgDyncElemData = _GetDgDyncElemData(moduleId)
  local dungeonDyncElemData = self._defaultDungeonDyncDataDic[moduleId] or DgDyncElemData.CreateDefaultDungeonDyncElemData(DgDyncElemData, moduleId)
  self._defaultDungeonDyncDataDic[moduleId] = dungeonDyncElemData
  return dungeonDyncElemData
end

function DungeonDyncData:GetDailyDungeonState()
  local dungeonDyncElemData = self:GetDailyDungeonDyncData()
  if dungeonDyncElemData.isDailyDungeonNew then
    return false, false
  end
  local matDungeonCfg = ConfigData.material_dungeon[dungeonDyncElemData.moduleId]
  if matDungeonCfg == nil then
    error("Cant get ConfigData.material_dungeon, id : " .. tostring(dungeonDyncElemData.moduleId))
    return false, false
  end
  local isFinish = dungeonDyncElemData.idx >= #matDungeonCfg.stage_id
  local inDungeon = not isFinish
  return isFinish, inDungeon
end

function DungeonDyncData:GetWinterChallengeDgStage()
  local dungeonDyncElemData = self:GetWinterChallengeDgDyncData()
  if dungeonDyncElemData.isDailyDungeonNew then
    return false, false
  end
end

function DungeonDyncData:CacheDgFmtFriendSupportHeroData(supportHeroData)
  self._dgFmtFriendSupportHeroData = supportHeroData
end

function DungeonDyncData:GetDgFmtFriendSupportHeroDataCache()
  return self._dgFmtFriendSupportHeroData
end

function DungeonDyncData:_ClearDgFmtFriendSupportHeroDataCache()
  self._dgFmtFriendSupportHeroData = nil
end

return DungeonDyncData
