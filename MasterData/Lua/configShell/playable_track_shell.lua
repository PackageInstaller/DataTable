local this = class("playable_track_shell", G_BaseConfig)
local core = G_Tables.TDPlayableTrackTable.GetInstance()

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
  playableType = 1,
  trackType = 2,
  markType = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPlayabletype(offset)
  return core:GetInt(offset, this.indexMap.playableType)
end

function this:_getTracktype(offset)
  local str = core:GetVString(offset, this.indexMap.trackType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMarktype(offset)
  return core:GetInt(offset, this.indexMap.markType)
end

this.keyToMethodsMap = {
  id = this._getId,
  playableType = this._getPlayabletype,
  trackType = this._getTracktype,
  markType = this._getMarktype
}
return this
