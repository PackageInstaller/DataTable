local this = class("unit_collider_runtime_shell", G_BaseConfig)
local core = G_Tables.TDUnitColliderRuntimeTable.GetInstance()

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
  colliderList = 1,
  kiboColliderList = 2,
  mountColliderList = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getColliderlist(offset)
  local str = core:GetVString(offset, this.indexMap.colliderList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKibocolliderlist(offset)
  local str = core:GetVString(offset, this.indexMap.kiboColliderList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMountcolliderlist(offset)
  local str = core:GetVString(offset, this.indexMap.mountColliderList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  colliderList = this._getColliderlist,
  kiboColliderList = this._getKibocolliderlist,
  mountColliderList = this._getMountcolliderlist
}
return this
