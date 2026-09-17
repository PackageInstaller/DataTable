local this = class("heroAttrInfo")

function this:ctor(heroGuid)
  self.heroGuid = heroGuid
  self.modules = {}
  self.attrMap = {}
end

function this:addModule(sModule)
  local m = self:getModule(sModule.module_type, true)
  if sModule.sub_modules then
    for _, v in ipairs(sModule.sub_modules) do
      m:addSub(v)
    end
  end
end

function this:getModule(id, isCreate)
  local m = self.modules[id]
  if m == nil and isCreate then
    m = require(L_R.store .. "hero.data.heroAttrModuleInfo").new(id)
    self.modules[id] = m
  end
  return m
end

function this:updateAttrMap()
  self.attrMap = {}
  for _, module in pairs(self.modules) do
    for _, sub in pairs(module.subModules) do
      self:packAttr(sub.attrs, self.attrMap)
    end
  end
  return self.attrMap
end

function this:packAttr(attr, attrMap)
  for id, v in pairs(attr) do
    if attrMap[id] then
      attrMap[id] = attrMap[id] + v
    else
      attrMap[id] = v
    end
  end
end

return this
