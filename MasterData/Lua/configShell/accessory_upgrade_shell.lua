local this = class("accessory_upgrade_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryUpgradeTable.GetInstance()

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
  Id = 0,
  rarity = 1,
  grade = 2,
  count = 3,
  cost = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getGrade(offset)
  return core:GetInt(offset, this.indexMap.grade)
end

function this:_getCount(offset)
  return core:GetInt(offset, this.indexMap.count)
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  rarity = this._getRarity,
  grade = this._getGrade,
  count = this._getCount,
  cost = this._getCost
}
return this
