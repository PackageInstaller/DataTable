local this = class("pet_pixel_tag_shell", G_BaseConfig)
local core = G_Tables.TDPetPixelTagTable.GetInstance()

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
  tagPos = 1,
  tagPriority = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTagpos(offset)
  return core:GetInt(offset, this.indexMap.tagPos)
end

function this:_getTagpriority(offset)
  return core:GetInt(offset, this.indexMap.tagPriority)
end

this.keyToMethodsMap = {
  id = this._getId,
  tagPos = this._getTagpos,
  tagPriority = this._getTagpriority
}
return this
