local this = class("cityObjListTpl")

function this:init(luaConfig)
  self.objGroup = {}
  for _, v in pairs(luaConfig) do
    if self.objGroup[v.cityId] == nil then
      self.objGroup[v.cityId] = {}
    end
    self.objGroup[v.cityId][v.id] = v
  end
end

function this:getObjs(dungeonID)
  return self.objGroup[dungeonID] or {}
end

return this
