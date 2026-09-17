local this = class("char_voice_shell", G_BaseConfig)
local core = G_Tables.TDCharVoiceTable.GetInstance()

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
  title = 1,
  text = 2,
  audioEvent = 3,
  action = 4,
  unlockCondition = 5,
  unlockConditionText = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getAudioevent(offset)
  return core:GetVString(offset, this.indexMap.audioEvent).value
end

function this:_getAction(offset)
  return core:GetVString(offset, this.indexMap.action).value
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockconditiontext(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("char_voice", core:GetVString(offset, this.indexMap.unlockConditionText))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "char_voice")
end

this.keyToMethodsMap = {
  id = this._getId,
  title = this._getTitle,
  text = this._getText,
  audioEvent = this._getAudioevent,
  action = this._getAction,
  unlockCondition = this._getUnlockcondition,
  unlockConditionText = this._getUnlockconditiontext
}
return this
