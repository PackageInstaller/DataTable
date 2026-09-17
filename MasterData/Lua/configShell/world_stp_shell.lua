local this = class("world_stp_shell", G_BaseConfig)
local core = G_Tables.TDWorldStpTable.GetInstance()

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
  sceneId = 1,
  position = 2,
  rotation = 3,
  isBorn = 4,
  radius = 5,
  capacity = 6,
  coolTime = 7,
  commonTag = 8,
  stpTag = 9,
  needTag = 10,
  conditionList = 11,
  precisePosition = 12,
  aoiRange = 13,
  specialIdle = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRotation(offset)
  local str = core:GetVString(offset, this.indexMap.rotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsborn(offset)
  return core:GetInt(offset, this.indexMap.isBorn)
end

function this:_getRadius(offset)
  return core:GetFloat(offset, this.indexMap.radius)
end

function this:_getCapacity(offset)
  return core:GetInt(offset, this.indexMap.capacity)
end

function this:_getCooltime(offset)
  return core:GetFloat(offset, this.indexMap.coolTime)
end

function this:_getCommontag(offset)
  return core:GetInt(offset, this.indexMap.commonTag)
end

function this:_getStptag(offset)
  return core:GetVString(offset, this.indexMap.stpTag).value
end

function this:_getNeedtag(offset)
  return core:GetVString(offset, this.indexMap.needTag).value
end

function this:_getConditionlist(offset)
  local str = core:GetVString(offset, this.indexMap.conditionList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getPreciseposition(offset)
  return core:GetInt(offset, this.indexMap.precisePosition)
end

function this:_getAoirange(offset)
  return core:GetFloat(offset, this.indexMap.aoiRange)
end

function this:_getSpecialidle(offset)
  return core:GetVString(offset, this.indexMap.specialIdle).value
end

this.keyToMethodsMap = {
  id = this._getId,
  sceneId = this._getSceneid,
  position = this._getPosition,
  rotation = this._getRotation,
  isBorn = this._getIsborn,
  radius = this._getRadius,
  capacity = this._getCapacity,
  coolTime = this._getCooltime,
  commonTag = this._getCommontag,
  stpTag = this._getStptag,
  needTag = this._getNeedtag,
  conditionList = this._getConditionlist,
  precisePosition = this._getPreciseposition,
  aoiRange = this._getAoirange,
  specialIdle = this._getSpecialidle
}
return this
