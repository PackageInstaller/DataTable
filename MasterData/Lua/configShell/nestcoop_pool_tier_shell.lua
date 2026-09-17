local this = class("nestcoop_pool_tier_shell", G_BaseConfig)
local core = G_Tables.TDNestcoopPoolTierTable.GetInstance()

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
  poolID = 1,
  tierWeight = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPoolid(offset)
  return core:GetInt(offset, this.indexMap.poolID)
end

function this:_getTierweight(offset)
  local str = core:GetVString(offset, this.indexMap.tierWeight).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  poolID = this._getPoolid,
  tierWeight = this._getTierweight
}
return this
