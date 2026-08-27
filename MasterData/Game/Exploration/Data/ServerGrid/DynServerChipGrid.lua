local DynServerChipGrid = class("DynServerChipGrid")
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local GridChipLevel = 1

function DynServerChipGrid:ctor()
end

function DynServerChipGrid:InitChipGrid(effector)
  self.__gridId = effector.gridId
  self.__times = effector.times
  self.__chipId = effector.p1
  self.__heroId = effector.p2
  local chipCfg = ConfigData.chip[self.__chipId]
  if chipCfg == nil then
    error("Can't find chip cfg, id = " .. tostring(self.__chipId))
    return
  end
  self.chipBattleData = ChipBattleData.New(chipCfg, GridChipLevel, eBattleSkillLogicType.TempChip)
end

function DynServerChipGrid:ExecuteGridChip(heroDic)
  if heroDic == nil then
    return
  end
  local dynHero = heroDic[self.__heroId]
  if dynHero == nil then
    return
  end
  self.chipBattleData:ExecuteChipBattle(dynHero)
end

function DynServerChipGrid:RollbackGridChip(heroDic)
  if heroDic == nil then
    return
  end
  local dynHero = heroDic[self.__heroId]
  if dynHero == nil then
    return
  end
  self.chipBattleData:RollbackChipBattle(dynHero)
end

function DynServerChipGrid:GetGridTimes()
  return self.__times
end

function DynServerChipGrid:GetGridHeroId()
  return self.__heroId
end

function DynServerChipGrid:GetGridCfg()
  local gridCfg = ConfigData.battle_grid[self.__gridId]
  if gridCfg == nil then
    error("battle grid cfg is null,id:" .. tostring(self.__gridId))
    return nil
  end
  return gridCfg
end

function DynServerChipGrid:GetGridIconSprite()
  local gridCfg = self:GetGridCfg()
  if gridCfg == nil then
    return nil
  end
  return CRH:GetSprite(gridCfg.icon, CommonAtlasType.ExplorationIcon)
end

function DynServerChipGrid:GetGridNameAndDesc()
  local gridCfg = self:GetGridCfg()
  if gridCfg == nil then
    return nil, nil
  end
  return LanguageUtil.GetLocaleText(gridCfg.name), LanguageUtil.GetLocaleText(gridCfg.effect_info)
end

return DynServerChipGrid
