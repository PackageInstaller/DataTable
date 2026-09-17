local this = class("world_eep_template_shell", G_BaseConfig)
local core = G_Tables.TDWorldEepTemplateTable.GetInstance()

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
  dropID = 1,
  triggerProbability = 2,
  failAddProbability = 3,
  overtime = 4,
  randomStartStep = 5,
  triggerParam = 6,
  condition = 7,
  filterRules = 8,
  positionList = 9,
  stepMax = 10,
  jumpStep = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDropid(offset)
  local str = core:GetVString(offset, this.indexMap.dropID).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTriggerprobability(offset)
  return core:GetInt(offset, this.indexMap.triggerProbability)
end

function this:_getFailaddprobability(offset)
  return core:GetInt(offset, this.indexMap.failAddProbability)
end

function this:_getOvertime(offset)
  return core:GetInt(offset, this.indexMap.overtime)
end

function this:_getRandomstartstep(offset)
  local str = core:GetVString(offset, this.indexMap.randomStartStep).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTriggerparam(offset)
  local str = core:GetVString(offset, this.indexMap.triggerParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCondition(offset)
  return core:GetVString(offset, this.indexMap.condition).value
end

function this:_getFilterrules(offset)
  return core:GetVString(offset, this.indexMap.filterRules).value
end

function this:_getPositionlist(offset)
  local str = core:GetVString(offset, this.indexMap.positionList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getStepmax(offset)
  return core:GetInt(offset, this.indexMap.stepMax)
end

function this:_getJumpstep(offset)
  return core:GetInt(offset, this.indexMap.jumpStep)
end

this.keyToMethodsMap = {
  id = this._getId,
  dropID = this._getDropid,
  triggerProbability = this._getTriggerprobability,
  failAddProbability = this._getFailaddprobability,
  overtime = this._getOvertime,
  randomStartStep = this._getRandomstartstep,
  triggerParam = this._getTriggerparam,
  condition = this._getCondition,
  filterRules = this._getFilterrules,
  positionList = this._getPositionlist,
  stepMax = this._getStepmax,
  jumpStep = this._getJumpstep
}
return this
