local this = class("kiboDuelAreaTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return tpl.name
end

function this:getCurrencyId(tpl)
  return tpl.currencyId
end

function this:getId(tpl)
  return tpl.Id
end

function this:getUIIcon(tpl)
  return tpl.uiIcon
end

function this:getMapIcon(tpl)
  return tpl.mapIcon
end

function this:getKiboCenterCameraParam(tpl)
  return tpl.kiboCenterCameraParam
end

return this
