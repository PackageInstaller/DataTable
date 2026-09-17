local this = class("kiboDuelAreaLevelTpl")

function this:init(config)
  self.data = config
  self.areaLevelMaps = {}
  local type, level
  for _, v in pairs(config) do
    type = self:getAreaType(v)
    level = self:getLevel(v)
    if not self.areaLevelMaps[type] then
      self.areaLevelMaps[type] = {}
    end
    self.areaLevelMaps[type][level] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTaskId(tpl)
  return tpl.taskId
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getKiboDuelId(tpl)
  return tpl.kiboDuelId
end

function this:getId(tpl)
  return tpl.Id
end

function this:getKiboDuelSkill(tpl)
  return tpl.kiboDuelSkill
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getAreaType(tpl)
  return tpl.areaType
end

function this:getName(tpl)
  return tpl.name
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getTpl(areaType, level)
  local levelConfs = self.areaLevelMaps[areaType]
  return levelConfs and levelConfs[level]
end

function this:getAreaLevels(areaType)
  local levelConfs = self.areaLevelMaps[areaType]
  return levelConfs and table.keys(levelConfs) or {}
end

function this:getMaxLevel(areaType)
  local levels = self:getAreaLevels(areaType)
  return #levels
end

function this:getMaxExp(areaType, level)
  local tpl = self:getTpl(areaType, level)
  return self:getExp(tpl)
end

function this:getResLevelNum(tpl)
  return tpl.level_num
end

function this:getResLevelNumByType(areaType, level)
  local tpl = self:getTpl(areaType, level)
  return self:getResLevelNum(tpl)
end

function this:getKiboDuelDecs(tpl)
  return tpl.kiboDuelDecs
end

return this
