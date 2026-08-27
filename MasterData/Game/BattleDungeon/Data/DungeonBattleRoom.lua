local BaseBattleRoom = require("Game.Common.Data.BaseBattleRoom")
local DungeonBattleRoom = class("DungeonBattleRoom", BaseBattleRoom)
local CS_BattleUtility = CS.BattleUtility
local ItemData = require("Game.PlayerData.Item.ItemData")

function DungeonBattleRoom:ctor()
end

function DungeonBattleRoom.CreateBattleDungeonRoom(bdCtrl, monsterGroup, dungeonCfg, dynPlayer)
  local batteRoom = DungeonBattleRoom.New()
  batteRoom:InitBattleRoom(bdCtrl, monsterGroup, dungeonCfg, dynPlayer)
  return batteRoom
end

function DungeonBattleRoom:InitBattleRoom(bdCtrl, monsterGroup, dungeonCfg, dynPlayer)
  self.bdCtrl = bdCtrl
  self.battleId = monsterGroup.battleId
  self.dungeonType = dungeonCfg.dungeon_type
  if self.dungeonType == proto_csmsg_DungeonType.DungeonType_WinterHard then
    self.dungeonType = proto_csmsg_DungeonType.DungeonType_Daily
  end
  self.formation = monsterGroup.form
  self.dynPlayer = dynPlayer
  self.rewardList = {}
  if monsterGroup.reward ~= nil then
    for k1, elem in ipairs(monsterGroup.reward.data) do
      for i = 1, elem.stacking do
        local itemData = ItemData.New(elem.id, elem.num)
        local pos = math.random(1, #self.rewardList + 1)
        table.insert(self.rewardList, pos, itemData)
      end
    end
    self.rewardExtraDic = monsterGroup.reward.extra
  end
  self.crazyTime = self.bdCtrl.sceneCtrl:GetDungeonCrazyTime()
  local size_row, size_col, deploy_rows, grid_scale_factor = self.bdCtrl.sceneCtrl:GetBattleFieldSizeBySceneId()
  local benchCount = ConfigData.game_config.battleMap_bench_count
  if self:IsInTDBattle() then
    benchCount = 0
  end
  self.battleMap = CS_BattleUtility.GenBattleMap(size_row, size_col, deploy_rows, benchCount, grid_scale_factor)
  self:TryInitSpecailDeployGrid(monsterGroup.specialDeployId, monsterGroup.redeploy)
  self:__InitMonsterOrNeutralData(monsterGroup.data)
  if self.bdCtrl.bloodGridMax == nil then
    self.bdCtrl:CalculateBloodGrid(self.monsterList)
  end
  self.battleMap:SetBloodGridParam(self.bdCtrl.unitBlood, self.bdCtrl.bossUnitBlood, self.bdCtrl.bloodGridMax)
  self.battleMap:SetPlayerRoleBattleMaxCount(self.dynPlayer:GetEnterFiledNum())
  self:__InitBattleGrid(monsterGroup.grids)
  self:UpdateMonsterChip()
end

function DungeonBattleRoom:GetSceneId()
  return self.bdCtrl.sceneCtrl.curSceneId
end

function DungeonBattleRoom:RollbackMonsterChipForEditor(chipMsg)
  local chipDic = self.dynPlayer:GetNormalChipDic()
  if chipMsg.delete ~= nil then
    for chipId, v in pairs(chipMsg.delete) do
      local chipData = chipDic[chipId]
      if chipData ~= nil then
        self:__RollbackMonsterChip(chipData)
      end
    end
  end
  if chipMsg.update ~= nil then
    for chipId, num in pairs(chipMsg.update) do
      local chipData = chipDic[chipId]
      if chipData ~= nil then
        self:__RollbackMonsterChip(chipData)
      end
    end
  end
end

function DungeonBattleRoom:UpdateMonsterChip()
  local chipList = self.dynPlayer:GetChipList()
  for k, chipData in pairs(chipList) do
    self:__ExecuteMonsterChip(chipData)
  end
  local epBuffChipDic = self.dynPlayer:GetEpBuffChipDic()
  for k, buffChip in pairs(epBuffChipDic) do
    self:__ExecuteMonsterBuffChip(buffChip)
  end
end

function DungeonBattleRoom:IsInTDBattle()
  return self.dungeonType == proto_csmsg_DungeonType.DungeonType_TD
end

function DungeonBattleRoom:IsBrotatoBattle()
  return self.dungeonType == proto_csmsg_DungeonType.DungeonType_Brotato
end

function DungeonBattleRoom:IsGuardTDBattle()
  return self.dungeonType == proto_csmsg_DungeonType.DungeonType_GuardianProfessor
end

function DungeonBattleRoom:GetIsInBigBossRoom()
  if BattleUtil.IsInWinterChallengeDungeon() then
    return true
  end
  return false
end

return DungeonBattleRoom
