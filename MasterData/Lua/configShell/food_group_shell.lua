local this = class("food_group_shell", G_BaseConfig)
local core = G_Tables.TDFoodGroupTable.GetInstance()

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
  foodType = 2,
  icon = 3,
  isNeedPet = 4,
  unlockLevel = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("food_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getFoodtype(offset)
  return core:GetInt(offset, this.indexMap.foodType)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIsneedpet(offset)
  return core:GetBool(offset, this.indexMap.isNeedPet)
end

function this:_getUnlocklevel(offset)
  local str = core:GetVString(offset, this.indexMap.unlockLevel).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  foodType = this._getFoodtype,
  icon = this._getIcon,
  isNeedPet = this._getIsneedpet,
  unlockLevel = this._getUnlocklevel
}
return this
