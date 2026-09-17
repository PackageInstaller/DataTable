local this = class("game_events_cul_attr_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulAttrTable.GetInstance()

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
  AttrId = 0,
  systemId = 1,
  name = 2,
  icon = 3
}

function this:_getAttrid(offset)
  return core:GetInt(offset, this.indexMap.AttrId)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_attr", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

this.keyToMethodsMap = {
  AttrId = this._getAttrid,
  systemId = this._getSystemid,
  name = this._getName,
  icon = this._getIcon
}
return this
