local this = class("battle_damagetext_shell", G_BaseConfig)
local core = G_Tables.TDBattleDamagetextTable.GetInstance()

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
  type = 1,
  element = 2,
  overdrive = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getElement(offset)
  return core:GetInt(offset, this.indexMap.element)
end

function this:_getOverdrive(offset)
  return core:GetBool(offset, this.indexMap.overdrive)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  element = this._getElement,
  overdrive = this._getOverdrive
}
return this
