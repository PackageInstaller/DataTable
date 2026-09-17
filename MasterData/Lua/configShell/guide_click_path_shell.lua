local this = class("guide_click_path_shell", G_BaseConfig)
local core = G_Tables.TDGuideClickPathTable.GetInstance()

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
  path = 1,
  subpath = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPath(offset)
  return core:GetVString(offset, this.indexMap.path).value
end

function this:_getSubpath(offset)
  return core:GetVString(offset, this.indexMap.subpath).value
end

this.keyToMethodsMap = {
  id = this._getId,
  path = this._getPath,
  subpath = this._getSubpath
}
return this
