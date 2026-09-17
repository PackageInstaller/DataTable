local this = class("world_camera_anim_shell", G_BaseConfig)
local core = G_Tables.TDWorldCameraAnimTable.GetInstance()

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
  animType = 1,
  resource = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAnimtype(offset)
  return core:GetInt(offset, this.indexMap.animType)
end

function this:_getResource(offset)
  return core:GetVString(offset, this.indexMap.resource).value
end

this.keyToMethodsMap = {
  id = this._getId,
  animType = this._getAnimtype,
  resource = this._getResource
}
return this
