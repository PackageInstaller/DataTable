local this = class("commonBannerTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getPic(tpl)
  return L_Config:getPathByHash(tpl.pic)
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getType(tpl)
  return tpl.type
end

function this:getId(tpl)
  return tpl.id
end

function this:getStartTime(tpl)
  return tpl.startTime
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getParam(tpl)
  return tpl.param
end

function this:getEndTime(tpl)
  return tpl.endTime
end

function this:getShow(tpl)
  return tpl.show
end

function this:getStayTime(tpl)
  return tpl.stayTime
end

function this:getAllData()
  return self.data
end

function this:getIsFake(param)
  return param == "99801"
end

return this
