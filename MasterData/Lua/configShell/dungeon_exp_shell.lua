local this = class("dungeon_exp_shell", G_BaseConfig)
local core = G_Tables.TDDungeonExpTable.GetInstance()

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
  drop = 2,
  introduce = 3,
  doorId = 4,
  dungeonItem = 5,
  dungeonCard = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getDrop(offset)
  return core:GetVString(offset, this.indexMap.drop).value
end

function this:_getIntroduce(offset)
  return core:GetVString(offset, this.indexMap.introduce).value
end

function this:_getDoorid(offset)
  return core:GetInt(offset, this.indexMap.doorId)
end

function this:_getDungeonitem(offset)
  local str = core:GetVString(offset, this.indexMap.dungeonItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDungeoncard(offset)
  local str = core:GetVString(offset, this.indexMap.dungeonCard).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  drop = this._getDrop,
  introduce = this._getIntroduce,
  doorId = this._getDoorid,
  dungeonItem = this._getDungeonitem,
  dungeonCard = this._getDungeoncard
}
return this
