local this = class("detailsTpl")

function this:init(config)
  self.data = config
  self._timelineMap = {}
  for i, v in pairs(config) do
    local timeline = v.timeline
    local t = self._timelineMap[timeline] or {}
    self._timelineMap[timeline] = t
    local stage = v.stage
    if table.isEmpty(stage) then
      t[0] = v
    else
      for _, s in ipairs(v.stage) do
        t[s] = v
      end
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplsByTimeline(timeline)
  return self._timelineMap[timeline]
end

function this:getTplByTimelineAndStage(timeline, stage)
  local subMap = self._timelineMap[timeline]
  return subMap and subMap[stage]
end

function this:getName(tpl)
  return tpl.name
end

function this:getTimeline(tpl)
  return tpl.timeline
end

function this:getStage(tpl)
  return tpl.stage
end

function this:getAudioEvent(tpl)
  return tpl.audioEvent
end

function this:getBgmEvent(tpl)
  return tpl.bgmEvent
end

function this:getTab(tpl)
  return tpl.tab
end

return this
