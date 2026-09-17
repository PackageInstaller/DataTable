local this = class("groups_shell", G_BaseConfig)
local core = G_Tables.TDGroupsTable.GetInstance()

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
  name = 1,
  icon = 2,
  reputation = 3,
  orderIcon = 4,
  reputationTabIcon = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("groups", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 6)
end

function this:_getReputation(offset)
  return core:GetInt(offset, this.indexMap.reputation)
end

function this:_getOrdericon(offset)
  local str = core:GetVString(offset, this.indexMap.orderIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getReputationtabicon(offset)
  local str = core:GetVString(offset, this.indexMap.reputationTabIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  icon = this._getIcon,
  reputation = this._getReputation,
  orderIcon = this._getOrdericon,
  reputationTabIcon = this._getReputationtabicon
}
return this
