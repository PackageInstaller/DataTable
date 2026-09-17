local this = class("pet_dnalink_shell", G_BaseConfig)
local core = G_Tables.TDPetDnalinkTable.GetInstance()

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
  link = 1,
  attribute = 2,
  valueParam = 3,
  words = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLink(offset)
  local str = core:GetVString(offset, this.indexMap.link).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAttribute(offset)
  local str = core:GetVString(offset, this.indexMap.attribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getValueparam(offset)
  return core:GetFloat(offset, this.indexMap.valueParam)
end

function this:_getWords(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_dnalink", core:GetVString(offset, this.indexMap.words))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "words")
end

this.keyToMethodsMap = {
  id = this._getId,
  link = this._getLink,
  attribute = this._getAttribute,
  valueParam = this._getValueparam,
  words = this._getWords
}
return this
