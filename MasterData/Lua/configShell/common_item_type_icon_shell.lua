local this = class("common_item_type_icon_shell", G_BaseConfig)
local core = G_Tables.TDCommonItemTypeIconTable.GetInstance()

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
  tabId = 0,
  name = 1,
  icon = 2
}

function this:_getTabid(offset)
  return core:GetInt(offset, this.indexMap.tabId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_item_type_icon", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  tabId = this._getTabid,
  name = this._getName,
  icon = this._getIcon
}
return this
