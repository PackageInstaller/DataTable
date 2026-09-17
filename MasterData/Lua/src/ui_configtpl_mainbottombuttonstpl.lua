local this = class("mainBottomButtonsTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getText(tpl)
  return L_Config:provider(tpl.text)
end

function this:getDecorateText(tpl)
  return tpl.decorateText
end

function this:getExitText(tpl)
  return L_Config:provider(tpl.exitText)
end

function this:getExitDecorateText(tpl)
  return tpl.exitDecorateText
end

function this:getBottomOrder(tpl)
  return tpl.bottomOrder
end

function this:getExtendOrder(tpl)
  return tpl.extendOrder
end

return this
