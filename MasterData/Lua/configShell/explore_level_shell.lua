local this = class("explore_level_shell", G_BaseConfig)
local core = G_Tables.TDExploreLevelTable.GetInstance()

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
  regionid = 1,
  lv = 2,
  ExploreLevel = 3,
  exp = 4,
  reward = 5,
  ifFly = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRegionid(offset)
  return core:GetInt(offset, this.indexMap.regionid)
end

function this:_getLv(offset)
  return core:GetInt(offset, this.indexMap.lv)
end

function this:_getExplorelevel(offset)
  local str = core:GetVString(offset, this.indexMap.ExploreLevel).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIffly(offset)
  return core:GetInt(offset, this.indexMap.ifFly)
end

this.keyToMethodsMap = {
  id = this._getId,
  regionid = this._getRegionid,
  lv = this._getLv,
  ExploreLevel = this._getExplorelevel,
  exp = this._getExp,
  reward = this._getReward,
  ifFly = this._getIffly
}
return this
