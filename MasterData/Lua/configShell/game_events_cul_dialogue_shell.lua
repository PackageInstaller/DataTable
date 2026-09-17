local this = class("game_events_cul_dialogue_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulDialogueTable.GetInstance()

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
  systemId = 1,
  condition = 2,
  character = 3,
  dialogueText = 4,
  Voice = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getCharacter(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_dialogue", core:GetVString(offset, this.indexMap.character))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "character")
end

function this:_getDialoguetext(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_dialogue", core:GetVString(offset, this.indexMap.dialogueText))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dialogueText")
end

function this:_getVoice(offset)
  return core:GetVString(offset, this.indexMap.Voice).value
end

this.keyToMethodsMap = {
  id = this._getId,
  systemId = this._getSystemid,
  condition = this._getCondition,
  character = this._getCharacter,
  dialogueText = this._getDialoguetext,
  Voice = this._getVoice
}
return this
