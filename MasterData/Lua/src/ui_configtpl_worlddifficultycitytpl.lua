local this = class("worldDifficultyCityTpl")

function this:init(config)
  self.data = config
  self.levelDic = {}
  for i, v in pairs(self.data) do
    if self.levelDic[v.mapid] == nil then
      self.levelDic[v.mapid] = {}
    end
    self.levelDic[v.mapid][v.difficultLv] = v
  end
end

function this:getTplsByMapId(mapId)
  for k, v in pairs(self.levelDic) do
    local mapData = self.levelDic[mapId]
    if mapData ~= nil then
      return mapData
    end
  end
  return nil
end

function this:getMapsMinDifficultLevel(mapId)
  local tpls = self:getTplsByMapId(mapId)
  if table.isEmpty(tpls) then
    return 1
  end
  local minLevel = math.maxinteger
  for k, v in pairs(tpls) do
    if minLevel > v.difficultLv then
      minLevel = v.difficultLv
    end
  end
  return minLevel
end

function this:getTplByMapIdAndLv(mapId, lv)
  local tpls = self:getTplsByMapId(mapId)
  if tpls == nil then
    return nil
  end
  for k, v in pairs(tpls) do
    if k == lv then
      return v
    end
  end
  return nil
end

function this:getNameByMapIdAndLv(mapId, lv)
  local tpl = self:getTplByMapIdAndLv(mapId, lv)
  if tpl == nil then
    return string.empty
  end
  return L_Config:provider(tpl.name)
end

function this:getDescByMapIdAndLv(mapId, lv)
  local tpl = self:getTplByMapIdAndLv(mapId, lv)
  if tpl == nil then
    return string.empty
  end
  return L_Config:provider(tpl.desc)
end

return this
