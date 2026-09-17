local this = class("world_area_trigger_shell", G_BaseConfig)
local core = G_Tables.TDWorldAreaTriggerTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, assetPath = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAssetpath(offset)
  return core:GetVString(offset, this.indexMap.assetPath).value
end

this.keyToMethodsMap = {
  id = this._getId,
  assetPath = this._getAssetpath
}
return this
