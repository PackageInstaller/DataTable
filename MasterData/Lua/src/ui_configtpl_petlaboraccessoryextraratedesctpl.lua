local this = class("petLaborAccessoryExtraRateDescTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRate(tpl)
  return tpl.rate
end

function this:getRateDesc(tpl)
  return L_Config:provider(tpl.rateText)
end

return this
