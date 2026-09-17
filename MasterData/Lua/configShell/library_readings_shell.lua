local this = class("library_readings_shell", G_BaseConfig)
local core = G_Tables.TDLibraryReadingsTable.GetInstance()

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
  subTitle = 1,
  chapter = 2,
  chapterIcon = 3,
  detail = 4,
  author = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSubtitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("library_readings", core:GetVString(offset, this.indexMap.subTitle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "subTitle")
end

function this:_getChapter(offset)
  local langStr = G_TableMgrIns:GetLangStr("library_readings", core:GetVString(offset, this.indexMap.chapter))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "chapter")
end

function this:_getChaptericon(offset)
  local str = core:GetVString(offset, this.indexMap.chapterIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDetail(offset)
  local langStr = G_TableMgrIns:GetLangStr("library_readings", core:GetVString(offset, this.indexMap.detail))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "detail")
end

function this:_getAuthor(offset)
  local langStr = G_TableMgrIns:GetLangStr("library_readings", core:GetVString(offset, this.indexMap.author))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "author")
end

this.keyToMethodsMap = {
  id = this._getId,
  subTitle = this._getSubtitle,
  chapter = this._getChapter,
  chapterIcon = this._getChaptericon,
  detail = this._getDetail,
  author = this._getAuthor
}
return this
