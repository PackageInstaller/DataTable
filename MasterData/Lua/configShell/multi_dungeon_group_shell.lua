local this = class("multi_dungeon_group_shell", G_BaseConfig)
local core = G_Tables.TDMultiDungeonGroupTable.GetInstance()

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
  dungeonGroupId = 0,
  openTime = 1,
  closeTime = 2
}

function this:_getDungeongroupid(offset)
  return core:GetInt(offset, this.indexMap.dungeonGroupId)
end

function this:_getOpentime(offset)
  return core:GetVString(offset, this.indexMap.openTime).value
end

function this:_getClosetime(offset)
  return core:GetVString(offset, this.indexMap.closeTime).value
end

this.keyToMethodsMap = {
  dungeonGroupId = this._getDungeongroupid,
  openTime = this._getOpentime,
  closeTime = this._getClosetime
}
return this
