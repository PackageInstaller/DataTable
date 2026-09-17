local this = class("gameActivityMainTaskRewardGE", L_GameEventStore.baseGameEventCls)

function this:initData()
  self.data.dataList = {}
end

function this:populate(protoData)
end

function this:getData()
  return self.data
end

function this:isAllTaskFinish(systemId)
end

function this:isActivityCompleted()
  return false
end

return this
