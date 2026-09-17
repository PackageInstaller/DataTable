local this = class("battleMessageUnitruleTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMessageTag(tpl)
  return tpl.messageTag
end

function this:getMessageTime(tpl)
  return tpl.messageTime
end

function this:getEventType(tpl)
  return tpl.eventType
end

function this:getTriggerProbability(tpl)
  return tpl.triggerProbability
end

function this:getPriority(tpl)
  return tpl.priority
end

function this:getMessageType(tpl)
  return tpl.messageType
end

function this:getMessageId(tpl)
  return tpl.messageId
end

function this:getBlockTriggerDuration(tpl)
  return tpl.blockTriggerDuration
end

function this:getId(tpl)
  return tpl.id
end

function this:getRuleType(tpl)
  return tpl.ruleType
end

function this:getEventParameter(tpl)
  return tpl.eventParameter
end

return this
