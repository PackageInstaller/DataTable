local AllDynServerGrid = class("AllDynServerGrid")
local DynServerChipGrid = require("Game.Exploration.Data.ServerGrid.DynServerChipGrid")
local GridLogicEnum = {Chip = 1}

function AllDynServerGrid:ctor()
  self.__gridLogicGroup = {}
  self.__gridLogicGroup[GridLogicEnum.Chip] = self.UpdateAllServerChipGrid
  self.__chipGridList = {}
end

function AllDynServerGrid:UpdateAllServerGrid(epBattleGrid, dynPlayer)
  if epBattleGrid == nil then
    return
  end
  for cat, grid in pairs(epBattleGrid.grids) do
    local logicFunc = self.__gridLogicGroup[cat]
    if logicFunc ~= nil then
      logicFunc(self, grid, dynPlayer)
    end
  end
end

function AllDynServerGrid:UpdateAllServerChipGrid(grid, dynPlayer)
  while #self.__chipGridList > 0 do
    local chipGrid = table.remove(self.__chipGridList)
    chipGrid:RollbackGridChip(dynPlayer.heroDic)
  end
  for k, effector in pairs(grid.eff) do
    local chipGrid = DynServerChipGrid.New()
    chipGrid:InitChipGrid(effector)
    chipGrid:ExecuteGridChip(dynPlayer.heroDic)
    table.insert(self.__chipGridList, chipGrid)
  end
end

function AllDynServerGrid:GetHeroServerGrid(heroId)
  local gridlist
  for _, chipGrid in pairs(self.__chipGridList) do
    local gridheroid = chipGrid:GetGridHeroId()
    if heroId == gridheroid then
      gridlist = gridlist or {}
      table.insert(gridlist, chipGrid)
    end
  end
  return gridlist
end

return AllDynServerGrid
