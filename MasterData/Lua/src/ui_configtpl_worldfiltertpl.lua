local this = class("worldFilterTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getShowType(tpl)
  return tpl.showType
end

function this:getResizingShow(tpl)
  return tpl.resizingShow
end

function this:getScreeningShow(tpl)
  return tpl.screeningShow
end

function this:getSort(tpl)
  return tpl.sort
end

function this:getRadarShow(tpl)
  return tpl.radarShow
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getScreeningIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.screeningIcon)
  return icon
end

function this:getConfig()
  return self.data
end

return this
