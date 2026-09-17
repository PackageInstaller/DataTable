local this = class("timelineEventHandle")

function this:ctor(timelineHandle)
  self.timelineHandle = timelineHandle
end

function this:onTimelineEventHandler(eventData)
  if eventData == nil then
    return
  end
  local timelineEventType = eventData.timelineEventType
  print("timeline事件类型：" .. eventData.timelineEventType)
  if timelineEventType == L_Const.timelineEventType.UI then
    self:onTimelineEvent_UI(eventData)
  elseif timelineEventType == L_Const.timelineEventType.CustomEvent and self.timelineHandle then
    self.timelineHandle:onTimelineCustomEvent(eventData.strParam1, eventData.strParam2, eventData.strParam3)
  end
end

function this:onTimelineEvent_UI(eventData)
  local uiName = eventData.strParam1
  local uiParam = eventData.strParam2
  local parseUiParam = {}
  if not string.isEmpty(uiParam) then
    local strs = string.split(uiParam, "/")
    for _, v in ipairs(strs) do
      local par = string.split(v, "=")
      parseUiParam[par[1]] = tonumber(par[2]) or par[2]
    end
  end
  if not string.isEmpty(uiName) then
    L_UI:open(uiName, parseUiParam)
  end
end

return this
