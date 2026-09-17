local this = class("wardrobe_avatar2_shell", G_BaseConfig)
local core = G_Tables.TDWardrobeAvatar2Table.GetInstance()

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
  sex = 1,
  part = 2,
  colorFormula = 3,
  initial = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSex(offset)
  return core:GetInt(offset, this.indexMap.sex)
end

function this:_getPart(offset)
  return core:GetInt(offset, this.indexMap.part)
end

function this:_getColorformula(offset)
  return core:GetInt(offset, this.indexMap.colorFormula)
end

function this:_getInitial(offset)
  return core:GetInt(offset, this.indexMap.initial)
end

this.keyToMethodsMap = {
  id = this._getId,
  sex = this._getSex,
  part = this._getPart,
  colorFormula = this._getColorformula,
  initial = this._getInitial
}
return this
