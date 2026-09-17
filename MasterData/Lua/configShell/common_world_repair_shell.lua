local this = class("common_world_repair_shell", G_BaseConfig)
local core = G_Tables.TDCommonWorldRepairTable.GetInstance()

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
  reward = 1,
  cityId = 2,
  worldmapId = 3,
  cost = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCityid(offset)
  return core:GetInt(offset, this.indexMap.cityId)
end

function this:_getWorldmapid(offset)
  return core:GetInt(offset, this.indexMap.worldmapId)
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  reward = this._getReward,
  cityId = this._getCityid,
  worldmapId = this._getWorldmapid,
  cost = this._getCost
}
return this
