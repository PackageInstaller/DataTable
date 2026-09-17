local this = class("iconography_type_shell", G_BaseConfig)
local core = G_Tables.TDIconographyTypeTable.GetInstance()

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
  rewardtype = 1,
  rewardpet = 2,
  abilities = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRewardtype(offset)
  return core:GetInt(offset, this.indexMap.rewardtype)
end

function this:_getRewardpet(offset)
  local str = core:GetVString(offset, this.indexMap.rewardpet).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAbilities(offset)
  local str = core:GetVString(offset, this.indexMap.abilities).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  rewardtype = this._getRewardtype,
  rewardpet = this._getRewardpet,
  abilities = this._getAbilities
}
return this
