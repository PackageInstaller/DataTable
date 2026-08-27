local DynEpBuffChip = class("DynEpBuffChip")
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function DynEpBuffChip:ctor(dataId, num)
  self.dataId = dataId
  self.count = num
  local chipCfg = ConfigData.chip[self.dataId]
  if chipCfg == nil then
    error("Can't find chip cfg, id = " .. tostring(self.dataId))
    return
  end
  self.chipCfg = chipCfg
  self.chipBattleData = ChipBattleData.New(self.chipCfg, self.count, eBattleSkillLogicType.TempChip)
end

function DynEpBuffChip:GetCount()
  return self.count
end

function DynEpBuffChip:SetCount(count)
  self.count = count
  if self.chipBattleData ~= nil then
    self.chipBattleData:UpdateChipBattleLevel(self:GetCount())
  end
end

function DynEpBuffChip:ExecuteBuffChip(chipHolder)
  self.chipBattleData:ExecuteChipBattle(chipHolder)
end

function DynEpBuffChip:RollbackBuffChip(chipHolder)
  self.chipBattleData:RollbackChipBattle(chipHolder)
end

function DynEpBuffChip:IsValidDynPlayer()
  return self.chipBattleData:IsValidDynPlayer()
end

function DynEpBuffChip:GetValidRoleList(dynBattleRoleList, belong)
  return self.chipBattleData:GetValidRoleList(dynBattleRoleList, belong)
end

function DynEpBuffChip:IsForHeroIDChipBattle()
  return self.chipBattleData:IsForHeroIDChipBattle()
end

function DynEpBuffChip:IsForEnemyChipBattle()
  return self.chipBattleData:IsForEnemyChipBattle()
end

function DynEpBuffChip:IsForDynEnemyChipBattle()
  return self.chipBattleData:IsForDynEnemyChipBattle()
end

return DynEpBuffChip
