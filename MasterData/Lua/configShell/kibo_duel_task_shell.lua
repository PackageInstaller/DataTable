local this = class("kibo_duel_task_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelTaskTable.GetInstance()

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
  task = 1,
  completionTimes = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTask(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_task", core:GetVString(offset, this.indexMap.task))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "task")
end

function this:_getCompletiontimes(offset)
  return core:GetInt(offset, this.indexMap.completionTimes)
end

this.keyToMethodsMap = {
  id = this._getId,
  task = this._getTask,
  completionTimes = this._getCompletiontimes
}
return this
