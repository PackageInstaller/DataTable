local this = class("reputation_level_shell", G_BaseConfig)
local core = G_Tables.TDReputationLevelTable.GetInstance()

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
  reputationId = 1,
  reputationlevel = 2,
  reputationNeed = 3,
  reputationRecipe = 4,
  reputationProducts = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getReputationid(offset)
  return core:GetInt(offset, this.indexMap.reputationId)
end

function this:_getReputationlevel(offset)
  return core:GetInt(offset, this.indexMap.reputationlevel)
end

function this:_getReputationneed(offset)
  return core:GetInt(offset, this.indexMap.reputationNeed)
end

function this:_getReputationrecipe(offset)
  local str = core:GetVString(offset, this.indexMap.reputationRecipe).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReputationproducts(offset)
  local str = core:GetVString(offset, this.indexMap.reputationProducts).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  reputationId = this._getReputationid,
  reputationlevel = this._getReputationlevel,
  reputationNeed = this._getReputationneed,
  reputationRecipe = this._getReputationrecipe,
  reputationProducts = this._getReputationproducts
}
return this
