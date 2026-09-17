local this = class("region_shell", G_BaseConfig)
local core = G_Tables.TDRegionTable.GetInstance()

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
  code = 1,
  language = 2,
  initialLanguage = 3,
  voice = 4,
  initialVoice = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCode(offset)
  return core:GetVString(offset, this.indexMap.code).value
end

function this:_getLanguage(offset)
  local str = core:GetVString(offset, this.indexMap.language).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getInitiallanguage(offset)
  return core:GetInt(offset, this.indexMap.initialLanguage)
end

function this:_getVoice(offset)
  local str = core:GetVString(offset, this.indexMap.voice).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getInitialvoice(offset)
  return core:GetInt(offset, this.indexMap.initialVoice)
end

this.keyToMethodsMap = {
  id = this._getId,
  code = this._getCode,
  language = this._getLanguage,
  initialLanguage = this._getInitiallanguage,
  voice = this._getVoice,
  initialVoice = this._getInitialvoice
}
return this
