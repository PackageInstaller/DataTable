local this = class("interfacetransition_shell", G_BaseConfig)
local core = G_Tables.TDInterfacetransitionTable.GetInstance()

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
  transitionResource = 1,
  openSfx = 2,
  closeSfx = 3,
  lowEndTransitionResource = 4,
  lowEndOpenSfx = 5,
  lowEndCloseSfx = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTransitionresource(offset)
  return core:GetVString(offset, this.indexMap.transitionResource).value
end

function this:_getOpensfx(offset)
  return core:GetVString(offset, this.indexMap.openSfx).value
end

function this:_getClosesfx(offset)
  return core:GetVString(offset, this.indexMap.closeSfx).value
end

function this:_getLowendtransitionresource(offset)
  return core:GetVString(offset, this.indexMap.lowEndTransitionResource).value
end

function this:_getLowendopensfx(offset)
  return core:GetVString(offset, this.indexMap.lowEndOpenSfx).value
end

function this:_getLowendclosesfx(offset)
  return core:GetVString(offset, this.indexMap.lowEndCloseSfx).value
end

this.keyToMethodsMap = {
  id = this._getId,
  transitionResource = this._getTransitionresource,
  openSfx = this._getOpensfx,
  closeSfx = this._getClosesfx,
  lowEndTransitionResource = this._getLowendtransitionresource,
  lowEndOpenSfx = this._getLowendopensfx,
  lowEndCloseSfx = this._getLowendclosesfx
}
return this
