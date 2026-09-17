local this = class("battle_message_unitpack_shell", G_BaseConfig)
local core = G_Tables.TDBattleMessageUnitpackTable.GetInstance()

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
  character = 1,
  characterType = 2,
  triggerType = 3,
  triggerParameter = 4,
  triggerProbability = 5,
  blockTriggerDuration = 6,
  messageId = 7,
  messagePriority = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCharacter(offset)
  return core:GetInt(offset, this.indexMap.character)
end

function this:_getCharactertype(offset)
  return core:GetInt(offset, this.indexMap.characterType)
end

function this:_getTriggertype(offset)
  return core:GetInt(offset, this.indexMap.triggerType)
end

function this:_getTriggerparameter(offset)
  local str = core:GetVString(offset, this.indexMap.triggerParameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTriggerprobability(offset)
  return core:GetInt(offset, this.indexMap.triggerProbability)
end

function this:_getBlocktriggerduration(offset)
  return core:GetInt(offset, this.indexMap.blockTriggerDuration)
end

function this:_getMessageid(offset)
  return core:GetInt(offset, this.indexMap.messageId)
end

function this:_getMessagepriority(offset)
  return core:GetInt(offset, this.indexMap.messagePriority)
end

this.keyToMethodsMap = {
  id = this._getId,
  character = this._getCharacter,
  characterType = this._getCharactertype,
  triggerType = this._getTriggertype,
  triggerParameter = this._getTriggerparameter,
  triggerProbability = this._getTriggerprobability,
  blockTriggerDuration = this._getBlocktriggerduration,
  messageId = this._getMessageid,
  messagePriority = this._getMessagepriority
}
return this
