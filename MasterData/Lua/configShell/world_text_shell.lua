local this = class("world_text_shell", G_BaseConfig)
local core = G_Tables.TDWorldTextTable.GetInstance()

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
  text = 1,
  VoiceEventId = 2,
  VoiceNpcType = 3,
  VoiceNpcId = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_text", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getVoiceeventid(offset)
  return core:GetVString(offset, this.indexMap.VoiceEventId).value
end

function this:_getVoicenpctype(offset)
  return core:GetInt(offset, this.indexMap.VoiceNpcType)
end

function this:_getVoicenpcid(offset)
  local str = core:GetVString(offset, this.indexMap.VoiceNpcId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  text = this._getText,
  VoiceEventId = this._getVoiceeventid,
  VoiceNpcType = this._getVoicenpctype,
  VoiceNpcId = this._getVoicenpcid
}
return this
