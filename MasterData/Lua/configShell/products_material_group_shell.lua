local this = class("products_material_group_shell", G_BaseConfig)
local core = G_Tables.TDProductsMaterialGroupTable.GetInstance()

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
  Id = 0,
  materialGroupId = 1,
  material = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getMaterialgroupid(offset)
  return core:GetInt(offset, this.indexMap.materialGroupId)
end

function this:_getMaterial(offset)
  local str = core:GetVString(offset, this.indexMap.material).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  materialGroupId = this._getMaterialgroupid,
  material = this._getMaterial
}
return this
