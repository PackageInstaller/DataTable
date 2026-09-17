local this = class("accessory_smelt_shell", G_BaseConfig)
local core = G_Tables.TDAccessorySmeltTable.GetInstance()

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
  decompose_upperlimit_1 = 0,
  decompose_upperlimit_2 = 1,
  decompose_item_1 = 2,
  decompose_item_2 = 3,
  decompose_building_group = 4
}

function this:_getDecompose_upperlimit_1(offset)
  return core:GetInt(offset, this.indexMap.decompose_upperlimit_1)
end

function this:_getDecompose_upperlimit_2(offset)
  return core:GetInt(offset, this.indexMap.decompose_upperlimit_2)
end

function this:_getDecompose_item_1(offset)
  local str = core:GetVString(offset, this.indexMap.decompose_item_1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDecompose_item_2(offset)
  local str = core:GetVString(offset, this.indexMap.decompose_item_2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDecompose_building_group(offset)
  return core:GetInt(offset, this.indexMap.decompose_building_group)
end

this.keyToMethodsMap = {
  decompose_upperlimit_1 = this._getDecompose_upperlimit_1,
  decompose_upperlimit_2 = this._getDecompose_upperlimit_2,
  decompose_item_1 = this._getDecompose_item_1,
  decompose_item_2 = this._getDecompose_item_2,
  decompose_building_group = this._getDecompose_building_group
}
return this
