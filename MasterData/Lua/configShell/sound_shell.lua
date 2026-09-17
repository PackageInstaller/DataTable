local this = class("sound_shell", G_BaseConfig)
local core = G_Tables.TDSoundTable.GetInstance()

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
  soundList = 1,
  type = 2,
  db = 3,
  randomType = 4,
  isLoop = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSoundlist(offset)
  local str = core:GetVString(offset, this.indexMap.soundList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getDb(offset)
  return core:GetFloat(offset, this.indexMap.db)
end

function this:_getRandomtype(offset)
  return core:GetInt(offset, this.indexMap.randomType)
end

function this:_getIsloop(offset)
  return core:GetInt(offset, this.indexMap.isLoop)
end

this.keyToMethodsMap = {
  id = this._getId,
  soundList = this._getSoundlist,
  type = this._getType,
  db = this._getDb,
  randomType = this._getRandomtype,
  isLoop = this._getIsloop
}
return this
