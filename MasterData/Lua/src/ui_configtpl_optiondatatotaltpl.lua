local this = class("optionDataTotalTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getVal(tpl, quality)
  return tpl[tostring(quality)]
end

return this
