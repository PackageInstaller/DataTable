local this = class("common_item_change_shell", G_BaseConfig)
local core = G_Tables.TDCommonItemChangeTable.GetInstance()

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
  itemId = 1,
  itemType = 2,
  itemNum = 3,
  change = 4,
  title = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getItemid(offset)
  return core:GetInt(offset, this.indexMap.itemId)
end

function this:_getItemtype(offset)
  return core:GetInt(offset, this.indexMap.itemType)
end

function this:_getItemnum(offset)
  return core:GetInt(offset, this.indexMap.itemNum)
end

function this:_getChange(offset)
  local str = core:GetVString(offset, this.indexMap.change).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_item_change", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

this.keyToMethodsMap = {
  id = this._getId,
  itemId = this._getItemid,
  itemType = this._getItemtype,
  itemNum = this._getItemnum,
  change = this._getChange,
  title = this._getTitle
}
return this
