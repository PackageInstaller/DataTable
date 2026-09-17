local this = class("uiViewTpl")

function this:init(config)
  self.data = {}
  for _, v in pairs(config) do
    self.data[v.viewName] = v
  end
end

function this:getTplByName(name)
  return self.data[name]
end

function this:getQueueType(tpl)
  return tpl.queueType
end

function this:getPanelType(tpl)
  return tpl.panelType
end

function this:getViewName(tpl)
  return tpl.viewName
end

function this:getNote(tpl)
  return tpl.note
end

function this:getId(tpl)
  return tpl.id
end

function this:getQueue(tpl)
  return tpl.queue
end

function this:getCheckshowfun(tpl)
  if string.isEmpty(tpl.checkshowfun) then
    return nil
  end
  if L_PriorityShowQueueManager[tpl.checkshowfun] then
    return function()
      return L_PriorityShowQueueManager[tpl.checkshowfun](L_PriorityShowQueueManager)
    end
  end
  return nil
end

function this:checkStopGuide(tpl)
  if tpl == nil then
    return false
  end
  return tpl.guide > 0
end

function this:getBlockIgnore(tpl)
  return tpl.blockIgnore or {}
end

return this
