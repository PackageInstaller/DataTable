local this = class("homeCropTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTplData()
  return self.data
end

function this:getCropType(tpl)
  return L_Config:provider(tpl.cropType)
end

return this
