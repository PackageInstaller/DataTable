local this = class("accessory_pet_product_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryPetProductTable.GetInstance()

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
  adjust1 = 1,
  adjust2 = 2,
  adjust3 = 3,
  adjust4 = 4,
  adjust5 = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAdjust1(offset)
  return core:GetInt(offset, this.indexMap.adjust1)
end

function this:_getAdjust2(offset)
  return core:GetInt(offset, this.indexMap.adjust2)
end

function this:_getAdjust3(offset)
  return core:GetInt(offset, this.indexMap.adjust3)
end

function this:_getAdjust4(offset)
  return core:GetInt(offset, this.indexMap.adjust4)
end

function this:_getAdjust5(offset)
  return core:GetInt(offset, this.indexMap.adjust5)
end

this.keyToMethodsMap = {
  id = this._getId,
  adjust1 = this._getAdjust1,
  adjust2 = this._getAdjust2,
  adjust3 = this._getAdjust3,
  adjust4 = this._getAdjust4,
  adjust5 = this._getAdjust5
}
return this
