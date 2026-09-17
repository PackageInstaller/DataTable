local this = class("world_instance_debug_shell", G_BaseConfig)
local core = G_Tables.TDWorldInstanceDebugTable.GetInstance()

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
  instanceIdType = 1,
  instanceId = 2,
  LOD2SetPassCall = 3,
  LOD3SetPassCall = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getInstanceidtype(offset)
  return core:GetInt(offset, this.indexMap.instanceIdType)
end

function this:_getInstanceid(offset)
  return core:GetInt(offset, this.indexMap.instanceId)
end

function this:_getLod2setpasscall(offset)
  return core:GetInt(offset, this.indexMap.LOD2SetPassCall)
end

function this:_getLod3setpasscall(offset)
  return core:GetInt(offset, this.indexMap.LOD3SetPassCall)
end

this.keyToMethodsMap = {
  id = this._getId,
  instanceIdType = this._getInstanceidtype,
  instanceId = this._getInstanceid,
  LOD2SetPassCall = this._getLod2setpasscall,
  LOD3SetPassCall = this._getLod3setpasscall
}
return this
