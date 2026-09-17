local this = class("battle_formation_shell", G_BaseConfig)
local core = G_Tables.TDBattleFormationTable.GetInstance()

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
  name = 1,
  tag = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getTag(offset)
  return core:GetInt(offset, this.indexMap.tag)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  tag = this._getTag
}
return this
