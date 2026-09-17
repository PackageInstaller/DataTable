local this = class("explore_map_reward_shell", G_BaseConfig)
local core = G_Tables.TDExploreMapRewardTable.GetInstance()

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
  exploreLevel = 1,
  mapId = 2,
  reward = 3,
  exploreGroupId = 4,
  levelUpExp = 5,
  scan = 6,
  systemUnlock = 7,
  systemUnlockText = 8,
  systemUnlockIcon = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getExplorelevel(offset)
  return core:GetInt(offset, this.indexMap.exploreLevel)
end

function this:_getMapid(offset)
  return core:GetInt(offset, this.indexMap.mapId)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getExploregroupid(offset)
  return core:GetInt(offset, this.indexMap.exploreGroupId)
end

function this:_getLevelupexp(offset)
  return core:GetInt(offset, this.indexMap.levelUpExp)
end

function this:_getScan(offset)
  return core:GetInt(offset, this.indexMap.scan)
end

function this:_getSystemunlock(offset)
  return core:GetInt(offset, this.indexMap.systemUnlock)
end

function this:_getSystemunlocktext(offset)
  return core:GetVString(offset, this.indexMap.systemUnlockText).value
end

function this:_getSystemunlockicon(offset)
  local str = core:GetVString(offset, this.indexMap.systemUnlockIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  exploreLevel = this._getExplorelevel,
  mapId = this._getMapid,
  reward = this._getReward,
  exploreGroupId = this._getExploregroupid,
  levelUpExp = this._getLevelupexp,
  scan = this._getScan,
  systemUnlock = this._getSystemunlock,
  systemUnlockText = this._getSystemunlocktext,
  systemUnlockIcon = this._getSystemunlockicon
}
return this
