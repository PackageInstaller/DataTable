local this = class("taskTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getMapIcon(tpl)
  return tpl.mapIcon
end

function this:getMapIconBg(tpl)
  return tpl.mapIconBg
end

function this:getDetailColor(tpl)
  local _, color = C_ColorUtility.TryParseHtmlString(tpl.detailcolor)
  return color
end

function this:getTypeIcon(tpl)
  return tpl.taskIcon
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getId(tpl)
  return tpl.id
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getEnglishName(tpl)
  return tpl.englishName
end

function this:getShow(tpl)
  return tpl.show
end

function this:getColor(tpl)
  local _, color = C_ColorUtility.TryParseHtmlString(tpl.color)
  return color
end

return this
