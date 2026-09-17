local this = class("guide_words_shell", G_BaseConfig)
local core = G_Tables.TDGuideWordsTable.GetInstance()

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
  talkIcon = 2,
  words = 3,
  mWords = 4,
  cWords = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTitle(offset)
  return core:GetVString(offset, this.indexMap.title).value
end

function this:_getTalkicon(offset)
  local str = core:GetVString(offset, this.indexMap.talkIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getWords(offset)
  local langStr = G_TableMgrIns:GetLangStr("guide_words", core:GetVString(offset, this.indexMap.words))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "words")
end

function this:_getMwords(offset)
  local langStr = G_TableMgrIns:GetLangStr("guide_words", core:GetVString(offset, this.indexMap.mWords))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "mWords")
end

function this:_getCwords(offset)
  local langStr = G_TableMgrIns:GetLangStr("guide_words", core:GetVString(offset, this.indexMap.cWords))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cWords")
end

this.keyToMethodsMap = {
  id = this._getId,
  title = this._getTitle,
  talkIcon = this._getTalkicon,
  words = this._getWords,
  mWords = this._getMwords,
  cWords = this._getCwords
}
return this
