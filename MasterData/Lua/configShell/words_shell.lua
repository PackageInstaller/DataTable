local this = class("words_shell", G_BaseConfig)
local core = G_Tables.TDWordsTable.GetInstance()

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
  title = 0,
  type = 1,
  words = 2
}

function this:_getTitle(offset)
  return core:GetVString(offset, this.indexMap.title).value
end

function this:_getType(offset)
  return core:GetVString(offset, this.indexMap.type).value
end

function this:_getWords(offset)
  local langStr = G_TableMgrIns:GetLangStr("words", core:GetVString(offset, this.indexMap.words))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "words")
end

this.keyToMethodsMap = {
  title = this._getTitle,
  type = this._getType,
  words = this._getWords
}
return this
