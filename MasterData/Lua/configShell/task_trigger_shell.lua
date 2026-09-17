local this = class("task_trigger_shell", G_BaseConfig)
local core = G_Tables.TDTaskTriggerTable.GetInstance()

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
  Id = 0,
  triggerCondition = 1,
  taskId = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getTriggercondition(offset)
  local str = core:GetVString(offset, this.indexMap.triggerCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTaskid(offset)
  local str = core:GetVString(offset, this.indexMap.taskId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  triggerCondition = this._getTriggercondition,
  taskId = this._getTaskid
}
return this
