local this = class("battle_message_unitrule_shell", G_BaseConfig)
local core = G_Tables.TDBattleMessageUnitruleTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  ruleType = 1,
  eventType = 2,
  eventParameter = 3,
  triggerProbability = 4,
  blockTriggerDuration = 5,
  messageTagType = 6,
  messageTag = 7,
  messageGroup = 8,
  messageId = 9,
  messageType = 10,
  messageTime = 11,
  priority = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRuletype(offset)
  return core:GetInt(offset, this.indexMap.ruleType)
end

function this:_getEventtype(offset)
  return core:GetInt(offset, this.indexMap.eventType)
end

function this:_getEventparameter(offset)
  local str = core:GetVString(offset, this.indexMap.eventParameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTriggerprobability(offset)
  return core:GetInt(offset, this.indexMap.triggerProbability)
end

function this:_getBlocktriggerduration(offset)
  return core:GetInt(offset, this.indexMap.blockTriggerDuration)
end

function this:_getMessagetagtype(offset)
  return core:GetInt(offset, this.indexMap.messageTagType)
end

function this:_getMessagetag(offset)
  local str = core:GetVString(offset, this.indexMap.messageTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getMessagegroup(offset)
  return core:GetInt(offset, this.indexMap.messageGroup)
end

function this:_getMessageid(offset)
  local str = core:GetVString(offset, this.indexMap.messageId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getMessagetype(offset)
  return core:GetInt(offset, this.indexMap.messageType)
end

function this:_getMessagetime(offset)
  return core:GetInt(offset, this.indexMap.messageTime)
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

this.keyToMethodsMap = {
  id = this._getId,
  ruleType = this._getRuletype,
  eventType = this._getEventtype,
  eventParameter = this._getEventparameter,
  triggerProbability = this._getTriggerprobability,
  blockTriggerDuration = this._getBlocktriggerduration,
  messageTagType = this._getMessagetagtype,
  messageTag = this._getMessagetag,
  messageGroup = this._getMessagegroup,
  messageId = this._getMessageid,
  messageType = this._getMessagetype,
  messageTime = this._getMessagetime,
  priority = this._getPriority
}
return this
