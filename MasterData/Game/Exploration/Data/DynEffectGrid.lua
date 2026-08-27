local DynEffectGrid = class("DynEffectGrid")

function DynEffectGrid:ctor(coord, id)
  self.coord = coord
  self.x, self.y = BattleUtil.Pos2XYCoord(coord)
  self.id = id
  local gridCfg = ConfigData.battle_grid[id]
  if gridCfg == nil then
    error("battle grid cfg is null,id:" .. tostring(id))
    return
  end
  self.gridCfg = gridCfg
  self.gridSrcNames = self:__LoadGridSrcCfg()
end

function DynEffectGrid:__LoadGridSrcCfg()
  if self.gridCfg.creations ~= nil and #self.gridCfg.creations > 0 then
    local gridSrcNames = {}
    for _, v in ipairs(self.gridCfg.creations) do
      local creationCfg = ConfigData.grid_creation[v]
      if creationCfg ~= nil then
        table.insert(gridSrcNames, creationCfg.src_name)
      else
        error("battle grid creation_cfg is null,id:" .. tostring(id))
      end
    end
    return gridSrcNames
  end
end

function DynEffectGrid:GetGridName()
  return LanguageUtil.GetLocaleText(self.gridCfg.name)
end

function DynEffectGrid:GetGridInfo()
  return LanguageUtil.GetLocaleText(self.gridCfg.info)
end

function DynEffectGrid:GetGridType()
  return self.gridCfg.type or 0
end

function DynEffectGrid:GetGridSrcName()
  return self.gridSrcNames
end

function DynEffectGrid:GetGridSkillScript()
  return self.gridCfg.grid_skill
end

function DynEffectGrid:GetGridIconSprite()
  return CRH:GetSprite(self.gridCfg.icon, CommonAtlasType.ExplorationIcon)
end

function DynEffectGrid:IsContainObstacle()
  return self.gridCfg.contain_obstacle
end

function DynEffectGrid:IsAbandonEquipmentTower()
  return self.gridCfg.abandon_equipment
end

function DynEffectGrid:GetGridAutoCareer()
  return self.gridCfg.auto_career
end

function DynEffectGrid:GetGridPriority()
  return self.gridCfg.priority
end

function DynEffectGrid:GetGridCareerPriority()
  return self.gridCfg.career_priority
end

function DynEffectGrid:GetGridNecessaryFormulaValue(tab)
  local formulaFunc = self.gridCfg.necessary
  if type(formulaFunc) ~= "function" then
    formulaFunc = load("return function(tab) return " .. formulaFunc .. " end")()
    self.gridCfg.necessary = formulaFunc
  end
  local result = formulaFunc(tab)
  return result
end

function DynEffectGrid:GetGridAttrFormulaValue(tab)
  local formulaFunc = self.gridCfg.attr_formula
  if type(formulaFunc) ~= "function" then
    formulaFunc = load("return function(tab) return " .. formulaFunc .. " end")()
    self.gridCfg.attr_formula = formulaFunc
  end
  local result = formulaFunc(tab)
  return result
end

function DynEffectGrid:GetAutoIsMax()
  return self.gridCfg.auto_order
end

function DynEffectGrid:IsMetalGearGrid()
  return self.gridCfg.grid_show_type == 1
end

function DynEffectGrid:GetIsUncorverGrid()
  return self.gridCfg.isuncover
end

function DynEffectGrid:GetCorverPriority()
  return self.gridCfg.cover_priority
end

function DynEffectGrid:GetIsHaveLifeTime()
  return self.gridCfg.duration > 0
end

function DynEffectGrid:GetDefaultLifeTime()
  return self.gridCfg.duration
end

function DynEffectGrid:GetIsRelativeTypeGrid()
  return self.gridCfg.type_relative
end

return DynEffectGrid
