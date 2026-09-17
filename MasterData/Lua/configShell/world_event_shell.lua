local this = class("world_event_shell", G_BaseConfig)
local core = G_Tables.TDWorldEventTable.GetInstance()

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
  group = 1,
  worldMapID = 2,
  triggerType = 3,
  conditionID = 4,
  checkCD = 5,
  refreshCD = 6,
  probability = 7,
  weight = 8,
  stepCount = 9,
  blueprintID = 10,
  dropID = 11,
  overtime = 12,
  overtimeResult = 13,
  resetGroupState = 14,
  resetSingleState = 15,
  checkPostion = 16,
  position = 17,
  targetGroupId = 18,
  targetWorldMapId = 19,
  assetName = 20,
  targetParamList = 21
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getWorldmapid(offset)
  return core:GetInt(offset, this.indexMap.worldMapID)
end

function this:_getTriggertype(offset)
  return core:GetInt(offset, this.indexMap.triggerType)
end

function this:_getConditionid(offset)
  local str = core:GetVString(offset, this.indexMap.conditionID).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getCheckcd(offset)
  return core:GetInt(offset, this.indexMap.checkCD)
end

function this:_getRefreshcd(offset)
  return core:GetInt(offset, this.indexMap.refreshCD)
end

function this:_getProbability(offset)
  return core:GetInt(offset, this.indexMap.probability)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getStepcount(offset)
  return core:GetInt(offset, this.indexMap.stepCount)
end

function this:_getBlueprintid(offset)
  return core:GetInt(offset, this.indexMap.blueprintID)
end

function this:_getDropid(offset)
  local str = core:GetVString(offset, this.indexMap.dropID).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOvertime(offset)
  return core:GetInt(offset, this.indexMap.overtime)
end

function this:_getOvertimeresult(offset)
  return core:GetInt(offset, this.indexMap.overtimeResult)
end

function this:_getResetgroupstate(offset)
  local str = core:GetVString(offset, this.indexMap.resetGroupState).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getResetsinglestate(offset)
  local str = core:GetVString(offset, this.indexMap.resetSingleState).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCheckpostion(offset)
  local str = core:GetVString(offset, this.indexMap.checkPostion).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "string")
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTargetgroupid(offset)
  local str = core:GetVString(offset, this.indexMap.targetGroupId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTargetworldmapid(offset)
  local str = core:GetVString(offset, this.indexMap.targetWorldMapId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAssetname(offset)
  return core:GetVString(offset, this.indexMap.assetName).value
end

function this:_getTargetparamlist(offset)
  local str = core:GetVString(offset, this.indexMap.targetParamList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  worldMapID = this._getWorldmapid,
  triggerType = this._getTriggertype,
  conditionID = this._getConditionid,
  checkCD = this._getCheckcd,
  refreshCD = this._getRefreshcd,
  probability = this._getProbability,
  weight = this._getWeight,
  stepCount = this._getStepcount,
  blueprintID = this._getBlueprintid,
  dropID = this._getDropid,
  overtime = this._getOvertime,
  overtimeResult = this._getOvertimeresult,
  resetGroupState = this._getResetgroupstate,
  resetSingleState = this._getResetsinglestate,
  checkPostion = this._getCheckpostion,
  position = this._getPosition,
  targetGroupId = this._getTargetgroupid,
  targetWorldMapId = this._getTargetworldmapid,
  assetName = this._getAssetname,
  targetParamList = this._getTargetparamlist
}
return this
