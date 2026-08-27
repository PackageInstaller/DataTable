local BaseBattleRoom = require("Game.Common.Data.BaseBattleRoom")
local WarChessBattleRoom = class("WarChessBattleRoom", BaseBattleRoom)
local DynEpBuffChip = require("Game.Exploration.Data.DynEpBuffChip")
local CS_BattleUtility = CS.BattleUtility
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function WarChessBattleRoom:ctor()
end

function WarChessBattleRoom.CreateWCBattleRoom(bsd, dynPlayer, wcBattleCtrl)
  local batteRoom = WarChessBattleRoom.New()
  batteRoom._sceneId = bsd.sceneId
  batteRoom:InitBattleRoom(bsd, dynPlayer, wcBattleCtrl)
  return batteRoom
end

function WarChessBattleRoom:InitBattleRoom(battleSystemData, dynPlayer, wcBattleCtrl)
  local battleRoomId = battleSystemData.roomId
  if battleRoomId ~= nil then
    local monsterGroupCfg = ConfigData.warchess_room_monster[battleSystemData.roomId]
    if monsterGroupCfg ~= nil then
      self.battleId = monsterGroupCfg.team_id
      self.dungeonType = monsterGroupCfg.type
    else
      self.battleId = 0
      self.dungeonType = 1
      error("表怪物组不存在 battleRoomId:" .. tostring(battleSystemData.roomId))
    end
  else
    self.battleId = 0
    self.dungeonType = 1
  end
  self.crazyTime = battleSystemData.crazyTime
  self._wcBattleCtrl = wcBattleCtrl
  local size_row, size_col, deploy_rows, grid_scale_factor = wcBattleCtrl.sceneCtrl:GetBattleFieldSizeBySceneId()
  local benchCount = ConfigData.game_config.battleMap_bench_count
  if self:IsInTDBattle() then
    benchCount = 0
  end
  self.battleMap = CS_BattleUtility.GenBattleMap(size_row, size_col, deploy_rows, benchCount, grid_scale_factor)
  self:TryInitSpecailDeployGrid(battleSystemData.specialDeployId, battleSystemData.redeploy)
  local monsters = battleSystemData.monsters
  local tmpAlgs = battleSystemData.tmpAlg
  self:__InitMonsterOrNeutralData(battleSystemData.monsters)
  for _, buffChip in pairs(dynPlayer.epBuffChipDic) do
    if buffChip ~= nil then
      dynPlayer:__RollBackBuffChip(buffChip)
    end
  end
  dynPlayer:ClearAlg()
  if tmpAlgs ~= nil then
    for chipId, num in pairs(tmpAlgs) do
      local buffChip = dynPlayer.epBuffChipDic[chipId]
      if buffChip ~= nil then
        dynPlayer:__RollBackBuffChip(buffChip)
        buffChip:SetCount(num)
        dynPlayer:__ExecuteBuffChip(buffChip)
      else
        local buffChip = DynEpBuffChip.New(chipId, num)
        dynPlayer.epBuffChipDic[chipId] = buffChip
        dynPlayer:__ExecuteBuffChip(buffChip)
      end
    end
  end
  self:ExecuteMonsterTempChip(dynPlayer:GetEpBuffChipDic())
  self.battleMap:SetPlayerRoleBattleMaxCount(dynPlayer:GetEnterFiledNum())
  self:__InitBattleGrid(battleSystemData.monsterGrids)
  if self:IsGuardTDBattle() then
    self:ExecuteDungeonRoleChip(self.dynPlayer)
  end
end

function WarChessBattleRoom:GetSceneId()
  return self._sceneId
end

function WarChessBattleRoom:UpdateMonsterChip()
end

function WarChessBattleRoom:IsInTDBattle()
  return false
end

function WarChessBattleRoom:IsBrotatoBattle()
  return false
end

function WarChessBattleRoom:GetIsInBigBossRoom()
  return false
end

function WarChessBattleRoom:IsGuardTDBattle()
  local entityData = self._wcBattleCtrl:GetBattleEntity()
  if entityData == nil then
    error("can't get monster entity data")
    return false
  end
  local battleRoomId = entityData:GetBattleRoomID()
  local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
  if monsterGroupCfg == nil then
    error("表怪物组不存在 battleRoomId:" .. tostring(battleRoomId))
    return false
  end
  return monsterGroupCfg.type == proto_csmsg_DungeonType.DungeonType_GuardianProfessor
end

function WarChessBattleRoom:IsWcBossRoom()
  local entityData = self._wcBattleCtrl:GetBattleEntity()
  if entityData == nil then
    error("can't get monster entity data")
    return false
  end
  local battleRoomId = entityData:GetBattleRoomID()
  local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
  if monsterGroupCfg == nil then
    error("表怪物组不存在 battleRoomId:" .. tostring(battleRoomId))
    return false
  end
  local isBossRoom = monsterGroupCfg.type == eWarChessEnum.BattleRoomTypeBoss
  return isBossRoom
end

return WarChessBattleRoom
