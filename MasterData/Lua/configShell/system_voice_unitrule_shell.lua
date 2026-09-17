local this = class("system_voice_unitrule_shell", G_BaseConfig)
local core = G_Tables.TDSystemVoiceUnitruleTable.GetInstance()

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
  voiceKey = 1,
  ruleType = 2,
  eventType = 3,
  eventParameter = 4,
  triggerProbability = 5,
  blockTriggerDuration = 6,
  VoiceTagType = 7,
  VoiceTag = 8,
  VoiceGroup = 9,
  VoiceId = 10,
  VoiceType = 11,
  VoiceTime = 12,
  priority = 13,
  text = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getVoicekey(offset)
  return core:GetVString(offset, this.indexMap.voiceKey).value
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

function this:_getVoicetagtype(offset)
  return core:GetInt(offset, this.indexMap.VoiceTagType)
end

function this:_getVoicetag(offset)
  local str = core:GetVString(offset, this.indexMap.VoiceTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getVoicegroup(offset)
  return core:GetInt(offset, this.indexMap.VoiceGroup)
end

function this:_getVoiceid(offset)
  local str = core:GetVString(offset, this.indexMap.VoiceId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getVoicetype(offset)
  return core:GetInt(offset, this.indexMap.VoiceType)
end

function this:_getVoicetime(offset)
  return core:GetInt(offset, this.indexMap.VoiceTime)
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

function this:_getText(offset)
  return core:GetInt(offset, this.indexMap.text)
end

this.keyToMethodsMap = {
  id = this._getId,
  voiceKey = this._getVoicekey,
  ruleType = this._getRuletype,
  eventType = this._getEventtype,
  eventParameter = this._getEventparameter,
  triggerProbability = this._getTriggerprobability,
  blockTriggerDuration = this._getBlocktriggerduration,
  VoiceTagType = this._getVoicetagtype,
  VoiceTag = this._getVoicetag,
  VoiceGroup = this._getVoicegroup,
  VoiceId = this._getVoiceid,
  VoiceType = this._getVoicetype,
  VoiceTime = this._getVoicetime,
  priority = this._getPriority,
  text = this._getText
}
return this
