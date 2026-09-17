local this = class("stamina_chest_drop_shell", G_BaseConfig)
local core = G_Tables.TDStaminaChestDropTable.GetInstance()

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
  type = 2,
  need = 3,
  rewardChance = 4,
  multimes = 5,
  drop = 6,
  rewardDisplay = 7,
  dropUp = 8,
  rewardDisplayUp = 9,
  rewardChanceUp = 10,
  time = 11,
  upDuration = 12,
  worldFilter = 13,
  worldmapid = 14,
  worldmapcityid = 15,
  spawnerid = 16
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("stamina_chest_drop", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getNeed(offset)
  local str = core:GetVString(offset, this.indexMap.need).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRewardchance(offset)
  local str = core:GetVString(offset, this.indexMap.rewardChance).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMultimes(offset)
  return core:GetInt(offset, this.indexMap.multimes)
end

function this:_getDrop(offset)
  return core:GetInt(offset, this.indexMap.drop)
end

function this:_getRewarddisplay(offset)
  local str = core:GetVString(offset, this.indexMap.rewardDisplay).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDropup(offset)
  return core:GetInt(offset, this.indexMap.dropUp)
end

function this:_getRewarddisplayup(offset)
  local str = core:GetVString(offset, this.indexMap.rewardDisplayUp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRewardchanceup(offset)
  return core:GetInt(offset, this.indexMap.rewardChanceUp)
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getUpduration(offset)
  local str = core:GetVString(offset, this.indexMap.upDuration).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldfilter(offset)
  local str = core:GetVString(offset, this.indexMap.worldFilter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldmapid(offset)
  return core:GetInt(offset, this.indexMap.worldmapid)
end

function this:_getWorldmapcityid(offset)
  return core:GetInt(offset, this.indexMap.worldmapcityid)
end

function this:_getSpawnerid(offset)
  return core:GetInt(offset, this.indexMap.spawnerid)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  type = this._getType,
  need = this._getNeed,
  rewardChance = this._getRewardchance,
  multimes = this._getMultimes,
  drop = this._getDrop,
  rewardDisplay = this._getRewarddisplay,
  dropUp = this._getDropup,
  rewardDisplayUp = this._getRewarddisplayup,
  rewardChanceUp = this._getRewardchanceup,
  time = this._getTime,
  upDuration = this._getUpduration,
  worldFilter = this._getWorldfilter,
  worldmapid = this._getWorldmapid,
  worldmapcityid = this._getWorldmapcityid,
  spawnerid = this._getSpawnerid
}
return this
