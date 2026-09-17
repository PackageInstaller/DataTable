local this = class("accessory_product_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryProductTable.GetInstance()

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
  dungeonOptionId = 1,
  difficulty = 2,
  name = 3,
  dungeonId = 4,
  unlockCondition = 5,
  dropId = 6,
  time = 7,
  technologyExp = 8,
  numberLimit = 9,
  satietyScore = 10,
  locateCost = 11,
  material = 12,
  group = 13,
  pic = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDungeonoptionid(offset)
  return core:GetInt(offset, this.indexMap.dungeonOptionId)
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("accessory_product", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getDropid(offset)
  return core:GetInt(offset, this.indexMap.dropId)
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getNumberlimit(offset)
  return core:GetInt(offset, this.indexMap.numberLimit)
end

function this:_getSatietyscore(offset)
  return core:GetInt(offset, this.indexMap.satietyScore)
end

function this:_getLocatecost(offset)
  local str = core:GetVString(offset, this.indexMap.locateCost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMaterial(offset)
  local str = core:GetVString(offset, this.indexMap.material).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

this.keyToMethodsMap = {
  id = this._getId,
  dungeonOptionId = this._getDungeonoptionid,
  difficulty = this._getDifficulty,
  name = this._getName,
  dungeonId = this._getDungeonid,
  unlockCondition = this._getUnlockcondition,
  dropId = this._getDropid,
  time = this._getTime,
  technologyExp = this._getTechnologyexp,
  numberLimit = this._getNumberlimit,
  satietyScore = this._getSatietyscore,
  locateCost = this._getLocatecost,
  material = this._getMaterial,
  group = this._getGroup,
  pic = this._getPic
}
return this
