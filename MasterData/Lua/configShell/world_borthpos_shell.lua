local this = class("world_borthpos_shell", G_BaseConfig)
local core = G_Tables.TDWorldBorthposTable.GetInstance()

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
  cityId = 2,
  type = 3,
  mainPoint = 4,
  lockPoint = 5,
  borthPoint = 6,
  aoiCenterPos = 7,
  checkpointType = 8,
  priority = 9,
  distance = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_borthpos", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getCityid(offset)
  return core:GetInt(offset, this.indexMap.cityId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getMainpoint(offset)
  return core:GetInt(offset, this.indexMap.mainPoint)
end

function this:_getLockpoint(offset)
  return core:GetInt(offset, this.indexMap.lockPoint)
end

function this:_getBorthpoint(offset)
  local str = core:GetVString(offset, this.indexMap.borthPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAoicenterpos(offset)
  return core:GetInt(offset, this.indexMap.aoiCenterPos)
end

function this:_getCheckpointtype(offset)
  return core:GetInt(offset, this.indexMap.checkpointType)
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

function this:_getDistance(offset)
  return core:GetInt(offset, this.indexMap.distance)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  cityId = this._getCityid,
  type = this._getType,
  mainPoint = this._getMainpoint,
  lockPoint = this._getLockpoint,
  borthPoint = this._getBorthpoint,
  aoiCenterPos = this._getAoicenterpos,
  checkpointType = this._getCheckpointtype,
  priority = this._getPriority,
  distance = this._getDistance
}
return this
