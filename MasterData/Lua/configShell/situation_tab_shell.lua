local this = class("situation_tab_shell", G_BaseConfig)
local core = G_Tables.TDSituationTabTable.GetInstance()

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
  tabId = 1,
  tabName = 2,
  tabIcon = 3,
  number = 4
}

function this:_getAreaid(offset)
  return core:GetInt(offset, this.indexMap.areaId)
end

function this:_getTabid(offset)
  return core:GetInt(offset, this.indexMap.tabId)
end

function this:_getTabname(offset)
  local langStr = G_TableMgrIns:GetLangStr("situation_tab", core:GetVString(offset, this.indexMap.tabName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tabName")
end

function this:_getTabicon(offset)
  local str = core:GetVString(offset, this.indexMap.tabIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNumber(offset)
  return core:GetInt(offset, this.indexMap.number)
end

this.keyToMethodsMap = {
  areaId = this._getAreaid,
  tabId = this._getTabid,
  tabName = this._getTabname,
  tabIcon = this._getTabicon,
  number = this._getNumber
}
return this
