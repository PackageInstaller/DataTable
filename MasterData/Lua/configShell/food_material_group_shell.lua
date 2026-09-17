local this = class("food_material_group_shell", G_BaseConfig)
local core = G_Tables.TDFoodMaterialGroupTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, includeItems = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIncludeitems(offset)
  local str = core:GetVString(offset, this.indexMap.includeItems).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  includeItems = this._getIncludeitems
}
return this
