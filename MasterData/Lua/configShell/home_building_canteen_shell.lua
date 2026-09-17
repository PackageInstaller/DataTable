local this = class("home_building_canteen_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingCanteenTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, products = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getProducts(offset)
  local str = core:GetVString(offset, this.indexMap.products).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  products = this._getProducts
}
return this
