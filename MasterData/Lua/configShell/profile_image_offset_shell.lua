local this = class("profile_image_offset_shell", G_BaseConfig)
local core = G_Tables.TDProfileImageOffsetTable.GetInstance()

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
  resPath = 1,
  type = 2,
  offsetPos = 3,
  offsetScale = 4,
  distance = 5
}

function this:_getId(offset)
  return core:GetVString(offset, this.indexMap.id).value
end

function this:_getRespath(offset)
  return core:GetVString(offset, this.indexMap.resPath).value
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getOffsetpos(offset)
  local str = core:GetVString(offset, this.indexMap.offsetPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOffsetscale(offset)
  local str = core:GetVString(offset, this.indexMap.offsetScale).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDistance(offset)
  local str = core:GetVString(offset, this.indexMap.distance).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  resPath = this._getRespath,
  type = this._getType,
  offsetPos = this._getOffsetpos,
  offsetScale = this._getOffsetscale,
  distance = this._getDistance
}
return this
