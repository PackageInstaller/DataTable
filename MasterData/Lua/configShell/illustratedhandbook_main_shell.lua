local this = class("illustratedhandbook_main_shell", G_BaseConfig)
local core = G_Tables.TDIllustratedhandbookMainTable.GetInstance()

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
  areaId = 0,
  sortID = 1,
  areaName = 2,
  _note = 3,
  isLock = 4,
  icon = 5,
  page = 6,
  color = 7,
  words = 8
}

function this:_getAreaid(offset)
  return core:GetInt(offset, this.indexMap.areaId)
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortID)
end

function this:_getAreaname(offset)
  local langStr = G_TableMgrIns:GetLangStr("illustratedhandbook_main", core:GetVString(offset, this.indexMap.areaName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "areaName")
end

function this:_get_note(offset)
  local langStr = G_TableMgrIns:GetLangStr("illustratedhandbook_main", core:GetVString(offset, this.indexMap._note))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "_note")
end

function this:_getIslock(offset)
  return core:GetInt(offset, this.indexMap.isLock)
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.icon).value
end

function this:_getPage(offset)
  return core:GetVString(offset, this.indexMap.page).value
end

function this:_getColor(offset)
  return core:GetVString(offset, this.indexMap.color).value
end

function this:_getWords(offset)
  return core:GetVString(offset, this.indexMap.words).value
end

this.keyToMethodsMap = {
  areaId = this._getAreaid,
  sortID = this._getSortid,
  areaName = this._getAreaname,
  _note = this._get_note,
  isLock = this._getIslock,
  icon = this._getIcon,
  page = this._getPage,
  color = this._getColor,
  words = this._getWords
}
return this
