local this = class("home_technology_tab_shell", G_BaseConfig)
local core = G_Tables.TDHomeTechnologyTabTable.GetInstance()

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
  tabCategory = 1,
  tabSubclass = 2,
  tabName = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTabcategory(offset)
  return core:GetInt(offset, this.indexMap.tabCategory)
end

function this:_getTabsubclass(offset)
  return core:GetInt(offset, this.indexMap.tabSubclass)
end

function this:_getTabname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_technology_tab", core:GetVString(offset, this.indexMap.tabName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tabName")
end

this.keyToMethodsMap = {
  id = this._getId,
  tabCategory = this._getTabcategory,
  tabSubclass = this._getTabsubclass,
  tabName = this._getTabname
}
return this
