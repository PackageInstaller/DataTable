local this = class("app_link_shell", G_BaseConfig)
local core = G_Tables.TDAppLinkTable.GetInstance()

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
  appId = 0,
  appSort = 1,
  appSortMoive = 2,
  appIcon = 3
}

function this:_getAppid(offset)
  return core:GetInt(offset, this.indexMap.appId)
end

function this:_getAppsort(offset)
  return core:GetInt(offset, this.indexMap.appSort)
end

function this:_getAppsortmoive(offset)
  return core:GetInt(offset, this.indexMap.appSortMoive)
end

function this:_getAppicon(offset)
  local str = core:GetVString(offset, this.indexMap.appIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  appId = this._getAppid,
  appSort = this._getAppsort,
  appSortMoive = this._getAppsortmoive,
  appIcon = this._getAppicon
}
return this
