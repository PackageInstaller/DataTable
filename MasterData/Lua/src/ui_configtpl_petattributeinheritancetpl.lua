local this = class("petAttributeinheritanceTpl")

function this:init(config)
  self.data = config
  self.attrData = {}
  for i, v in pairs(config) do
    if self.attrData[v.attrVal] == nil then
      self.attrData[v.attrVal] = v
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByAttrId(id)
  return self.attrData[id]
end

function this:getAttrId(tpl)
  return tpl.attrId
end

function this:getAdjustment(tpl)
  return tpl.adjustment
end

function this:getAttrVal(tpl)
  return tpl.attrVal
end

function this:getId(tpl)
  return tpl.id
end

function this:getPetAttrVal(tpl)
  return tpl.petAttrVal
end

function this:getName(tpl)
  return tpl.name
end

function this:getAllData()
  return self.attrData
end

return this
