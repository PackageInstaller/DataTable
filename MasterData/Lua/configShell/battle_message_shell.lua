local this = class("battle_message_shell", G_BaseConfig)
local core = G_Tables.TDBattleMessageTable.GetInstance()

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
  messageType = 3,
  dialogueId = 4,
  messageTime = 5
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

function this:_getMessagetype(offset)
  return core:GetInt(offset, this.indexMap.messageType)
end

function this:_getDialogueid(offset)
  return core:GetInt(offset, this.indexMap.dialogueId)
end

function this:_getMessagetime(offset)
  return core:GetInt(offset, this.indexMap.messageTime)
end

this.keyToMethodsMap = {
  id = this._getId,
  character = this._getCharacter,
  characterType = this._getCharactertype,
  messageType = this._getMessagetype,
  dialogueId = this._getDialogueid,
  messageTime = this._getMessagetime
}
return this
