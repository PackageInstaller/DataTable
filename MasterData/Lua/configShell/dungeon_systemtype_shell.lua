local this = class("dungeon_systemtype_shell", G_BaseConfig)
local core = G_Tables.TDDungeonSystemtypeTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, feature = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFeature(offset)
  return core:GetVString(offset, this.indexMap.feature).value
end

this.keyToMethodsMap = {
  id = this._getId,
  feature = this._getFeature
}
return this
