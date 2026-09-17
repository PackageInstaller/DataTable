local this = class("home_building_production_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingProductionTable.GetInstance()

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
  type = 1,
  groupId = 2,
  tab = 3,
  productionQueueNum = 4,
  petSize = 5,
  petHomeAttribute = 6,
  laborType = 7,
  productListype = 8,
  reduceSatietyScoreBefore = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getTab(offset)
  local str = core:GetVString(offset, this.indexMap.tab).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getProductionqueuenum(offset)
  return core:GetInt(offset, this.indexMap.productionQueueNum)
end

function this:_getPetsize(offset)
  local str = core:GetVString(offset, this.indexMap.petSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPethomeattribute(offset)
  return core:GetInt(offset, this.indexMap.petHomeAttribute)
end

function this:_getLabortype(offset)
  local str = core:GetVString(offset, this.indexMap.laborType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getProductlistype(offset)
  return core:GetInt(offset, this.indexMap.productListype)
end

function this:_getReducesatietyscorebefore(offset)
  return core:GetBool(offset, this.indexMap.reduceSatietyScoreBefore)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  groupId = this._getGroupid,
  tab = this._getTab,
  productionQueueNum = this._getProductionqueuenum,
  petSize = this._getPetsize,
  petHomeAttribute = this._getPethomeattribute,
  laborType = this._getLabortype,
  productListype = this._getProductlistype,
  reduceSatietyScoreBefore = this._getReducesatietyscorebefore
}
return this
