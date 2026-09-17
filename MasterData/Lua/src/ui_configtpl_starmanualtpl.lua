local this = class("starManualTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getId(tpl)
  return tpl.id
end

function this:getUnlock(tpl)
  return tpl.unlock
end

function this:getShopId(tpl)
  return tpl.shopId
end

function this:getShow(tpl)
  return tpl.show
end

function this:getLimitParam(tpl)
  return tpl.limitParam
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getAllData()
  local data = {}
  for _, v in pairs(self.data) do
    table.insert(data, v)
  end
  table.sort(data, function(a, b)
    return a.order < b.order
  end)
  return data
end

return this
