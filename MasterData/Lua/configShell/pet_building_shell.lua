local this = class("pet_building_shell", G_BaseConfig)
local core = G_Tables.TDPetBuildingTable.GetInstance()

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
  condition = 1,
  petFunction = 2,
  para = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPetfunction(offset)
  local str = core:GetVString(offset, this.indexMap.petFunction).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPara(offset)
  local str = core:GetVString(offset, this.indexMap.para).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  condition = this._getCondition,
  petFunction = this._getPetfunction,
  para = this._getPara
}
return this
