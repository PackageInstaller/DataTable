local this = class("details_tab_shell", G_BaseConfig)
local core = G_Tables.TDDetailsTabTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, tabName = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTabname(offset)
  local langStr = G_TableMgrIns:GetLangStr("details_tab", core:GetVString(offset, this.indexMap.tabName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tabName")
end

this.keyToMethodsMap = {
  id = this._getId,
  tabName = this._getTabname
}
return this
