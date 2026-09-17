local this = class("world_emp_shell", G_BaseConfig)
local core = G_Tables.TDWorldEmpTable.GetInstance()

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
  probability = 4,
  cdTime = 5,
  actionTempList = 6
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

function this:_getProbability(offset)
  return core:GetInt(offset, this.indexMap.probability)
end

function this:_getCdtime(offset)
  return core:GetInt(offset, this.indexMap.cdTime)
end

function this:_getActiontemplist(offset)
  return core:GetVString(offset, this.indexMap.actionTempList).value
end

this.keyToMethodsMap = {
  id = this._getId,
  sceneId = this._getSceneid,
  position = this._getPosition,
  rotation = this._getRotation,
  probability = this._getProbability,
  cdTime = this._getCdtime,
  actionTempList = this._getActiontemplist
}
return this
