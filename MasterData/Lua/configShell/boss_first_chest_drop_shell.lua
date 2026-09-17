local this = class("boss_first_chest_drop_shell", G_BaseConfig)
local core = G_Tables.TDBossFirstChestDropTable.GetInstance()

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
  drop = 1,
  rewardDisplay = 2,
  WorldFilter = 3,
  spawnerid = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDrop(offset)
  return core:GetInt(offset, this.indexMap.drop)
end

function this:_getRewarddisplay(offset)
  local str = core:GetVString(offset, this.indexMap.rewardDisplay).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getWorldfilter(offset)
  local str = core:GetVString(offset, this.indexMap.WorldFilter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSpawnerid(offset)
  return core:GetInt(offset, this.indexMap.spawnerid)
end

this.keyToMethodsMap = {
  id = this._getId,
  drop = this._getDrop,
  rewardDisplay = this._getRewarddisplay,
  WorldFilter = this._getWorldfilter,
  spawnerid = this._getSpawnerid
}
return this
