local this = class("unit_collider_shell", G_BaseConfig)
local core = G_Tables.TDUnitColliderTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, colliderList = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getColliderlist(offset)
  local str = core:GetVString(offset, this.indexMap.colliderList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  colliderList = this._getColliderlist
}
return this
