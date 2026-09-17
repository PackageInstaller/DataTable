local this = class("repeat_event_task_shell", G_BaseConfig)
local core = G_Tables.TDRepeatEventTaskTable.GetInstance()

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
  sort = 2,
  taskReward = 3,
  taskRewardDisplay = 4,
  desc = 5,
  param = 6,
  systemJump = 7,
  finishCondition = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getTaskreward(offset)
  local str = core:GetVString(offset, this.indexMap.taskReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTaskrewarddisplay(offset)
  local str = core:GetVString(offset, this.indexMap.taskRewardDisplay).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("repeat_event_task", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getSystemjump(offset)
  return core:GetInt(offset, this.indexMap.systemJump)
end

function this:_getFinishcondition(offset)
  local str = core:GetVString(offset, this.indexMap.finishCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  sort = this._getSort,
  taskReward = this._getTaskreward,
  taskRewardDisplay = this._getTaskrewarddisplay,
  desc = this._getDesc,
  param = this._getParam,
  systemJump = this._getSystemjump,
  finishCondition = this._getFinishcondition
}
return this
