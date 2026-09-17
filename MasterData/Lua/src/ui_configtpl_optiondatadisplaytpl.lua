local this = class("optionDataDisplayTpl")

function this:init(config)
  self.data = config
end

function this:getConfig()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getVerticalPixels(tpl)
  return tpl.verticalPixels
end

function this:getId(tpl)
  return tpl.id
end

function this:getDisplayType(tpl)
  return tpl.displayType
end

function this:getHorizontalPixels(tpl)
  return tpl.horizontalPixels
end

function this:getIsFullScreen(tpl)
  return tpl.displayType == 1
end

return this
