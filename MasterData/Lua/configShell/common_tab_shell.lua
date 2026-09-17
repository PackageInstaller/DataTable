local this = class("common_tab_shell", G_BaseConfig)
local core = G_Tables.TDCommonTabTable.GetInstance()

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
  teamId = 1,
  name = 2,
  icon = 3,
  iconSmall = 4,
  productBuild = 5,
  value = 6,
  color = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeamid(offset)
  return core:GetInt(offset, this.indexMap.teamId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_tab", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconsmall(offset)
  local str = core:GetVString(offset, this.indexMap.iconSmall).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getProductbuild(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_tab", core:GetVString(offset, this.indexMap.productBuild))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "productBuild")
end

function this:_getValue(offset)
  return core:GetInt(offset, this.indexMap.value)
end

function this:_getColor(offset)
  return core:GetVString(offset, this.indexMap.color).value
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  name = this._getName,
  icon = this._getIcon,
  iconSmall = this._getIconsmall,
  productBuild = this._getProductbuild,
  value = this._getValue,
  color = this._getColor
}
return this
