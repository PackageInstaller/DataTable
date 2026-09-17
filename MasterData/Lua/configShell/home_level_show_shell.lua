local this = class("home_level_show_shell", G_BaseConfig)
local core = G_Tables.TDHomeLevelShowTable.GetInstance()

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
  building = 1,
  buildingCollection = 2,
  systemUnlock = 3,
  block = 4,
  products = 5,
  commonItem = 6,
  mountSaddle = 7,
  technology = 8,
  buildingNum = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBuilding(offset)
  local str = core:GetVString(offset, this.indexMap.building).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBuildingcollection(offset)
  local str = core:GetVString(offset, this.indexMap.buildingCollection).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSystemunlock(offset)
  local str = core:GetVString(offset, this.indexMap.systemUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBlock(offset)
  local str = core:GetVString(offset, this.indexMap.block).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getProducts(offset)
  local str = core:GetVString(offset, this.indexMap.products).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCommonitem(offset)
  local str = core:GetVString(offset, this.indexMap.commonItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMountsaddle(offset)
  local str = core:GetVString(offset, this.indexMap.mountSaddle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTechnology(offset)
  local str = core:GetVString(offset, this.indexMap.technology).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBuildingnum(offset)
  local str = core:GetVString(offset, this.indexMap.buildingNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  building = this._getBuilding,
  buildingCollection = this._getBuildingcollection,
  systemUnlock = this._getSystemunlock,
  block = this._getBlock,
  products = this._getProducts,
  commonItem = this._getCommonitem,
  mountSaddle = this._getMountsaddle,
  technology = this._getTechnology,
  buildingNum = this._getBuildingnum
}
return this
