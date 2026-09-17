local this = class("food_shell", G_BaseConfig)
local core = G_Tables.TDFoodTable.GetInstance()

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
  desc = 1,
  foodType = 2,
  foodCharge = 3,
  charge = 4,
  satietyScore = 5,
  endurance = 6,
  buffId = 7,
  tag = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("food", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getFoodtype(offset)
  return core:GetInt(offset, this.indexMap.foodType)
end

function this:_getFoodcharge(offset)
  local str = core:GetVString(offset, this.indexMap.foodCharge).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCharge(offset)
  return core:GetInt(offset, this.indexMap.charge)
end

function this:_getSatietyscore(offset)
  return core:GetInt(offset, this.indexMap.satietyScore)
end

function this:_getEndurance(offset)
  return core:GetInt(offset, this.indexMap.endurance)
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffId)
end

function this:_getTag(offset)
  local str = core:GetVString(offset, this.indexMap.tag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  desc = this._getDesc,
  foodType = this._getFoodtype,
  foodCharge = this._getFoodcharge,
  charge = this._getCharge,
  satietyScore = this._getSatietyscore,
  endurance = this._getEndurance,
  buffId = this._getBuffid,
  tag = this._getTag
}
return this
