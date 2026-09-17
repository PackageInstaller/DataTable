local this = class("journey_chapter_shell", G_BaseConfig)
local core = G_Tables.TDJourneyChapterTable.GetInstance()

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
  chapterTitleId = 0,
  name = 1,
  sort = 2
}

function this:_getChaptertitleid(offset)
  return core:GetInt(offset, this.indexMap.chapterTitleId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_chapter", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

this.keyToMethodsMap = {
  chapterTitleId = this._getChaptertitleid,
  name = this._getName,
  sort = this._getSort
}
return this
