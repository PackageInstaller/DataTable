local this = class("rougeEntryTimelineDynamicBindInfo", require("ui.manager.hero.timeline.timelineDynamicBindInfo"))
local TimelineEventData = CS.Gameplay.Tools.TimelineSplitTool.TimelineEventData
local TimelineEventReceiver = CS.Gameplay.Tools.TimelineSplitTool.TimelineEventReceiver
local TimelineState = CS.Gameplay.Tools.TimelineSplitTool.TimelineState

function this:dispose()
  self:CleanupTimelineReceiverFromHero()
  self.actor = nil
end

function this:setHeroId(heroId)
  self.heroId = heroId
  self:setupTimelineReceiverForHero(self.actor)
end

function this:setupTimelineReceiverForHero(heroGameObject)
  if not heroGameObject then
    return nil
  end
  local parentTransform = heroGameObject.transform
  if parentTransform.childCount == 0 then
    error("英雄 '" .. heroGameObject.name .. "' 没有任何子对象，无法添加事件接收器！")
    return nil
  end
  local firstChildTransform = parentTransform:GetChild(0)
  local obj = firstChildTransform.gameObject
  self.playObj = obj
  local receiver = obj:GetComponent(typeof(TimelineEventReceiver))
  if receiver == nil then
    receiver = obj:AddComponent(typeof(TimelineEventReceiver))
  else
  end
  local newDynamicEvent = {
    uuid = 0,
    timelineEventType = 2,
    strParam1 = "openmain",
    intParam1 = 12345
  }
  self:AddDynamicEventToReceiver(receiver, newDynamicEvent)
  return receiver
end

function this:CleanupTimelineReceiverFromHero()
  if not self.playObj then
    return
  end
  local receiver = self.playObj:GetComponent(typeof(TimelineEventReceiver))
  if receiver ~= nil then
    Unity.GameObject.Destroy(receiver)
  end
end

function this:AddDynamicEventToReceiver(receiver, eventInfo)
  if not receiver or not eventInfo then
    errorf("AddDynamicEventToReceiver: 传入的参数无效。")
    return
  end
  local newEventData = TimelineEventData()
  newEventData.uuid = eventInfo.uuid or 0
  newEventData.timelineEventType = eventInfo.timelineEventType or 0
  newEventData.skipCanEmit = eventInfo.skipCanEmit or false
  newEventData.strParam1 = eventInfo.strParam1 or ""
  newEventData.strParam2 = eventInfo.strParam2 or ""
  newEventData.strParam3 = eventInfo.strParam3 or ""
  newEventData.intParam1 = eventInfo.intParam1 or 0
  newEventData.intParam2 = eventInfo.intParam2 or 0
  newEventData.intParam3 = eventInfo.intParam3 or 0
  print(string.format("在Lua中创建了新的事件数据, UUID: %d", newEventData.uuid))
  receiver.eventDatas:Add(newEventData)
end

return this
