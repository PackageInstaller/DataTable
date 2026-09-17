local this = class("dungeon_enemy_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEnemyTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, avatarTexture = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAvatartexture(offset)
  return core:GetVString(offset, this.indexMap.avatarTexture).value
end

this.keyToMethodsMap = {
  id = this._getId,
  avatarTexture = this._getAvatartexture
}
return this
