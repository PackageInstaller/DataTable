local this = class("iconography_task_shell", G_BaseConfig)
local core = G_Tables.TDIconographyTaskTable.GetInstance()

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
  nextTaskId = 1,
  taskname = 2,
  taskdesc = 3,
  taskAward = 4,
  taskcondition = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getNexttaskid(offset)
  return core:GetInt(offset, this.indexMap.nextTaskId)
end

function this:_getTaskname(offset)
  local langStr = G_TableMgrIns:GetLangStr("iconography_task", core:GetVString(offset, this.indexMap.taskname))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "taskname")
end

function this:_getTaskdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("iconography_task", core:GetVString(offset, this.indexMap.taskdesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "taskdesc")
end

function this:_getTaskaward(offset)
  return core:GetInt(offset, this.indexMap.taskAward)
end

function this:_getTaskcondition(offset)
  local str = core:GetVString(offset, this.indexMap.taskcondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  nextTaskId = this._getNexttaskid,
  taskname = this._getTaskname,
  taskdesc = this._getTaskdesc,
  taskAward = this._getTaskaward,
  taskcondition = this._getTaskcondition
}
return this
