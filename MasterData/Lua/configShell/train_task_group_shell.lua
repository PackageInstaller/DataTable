local this = class("train_task_group_shell", G_BaseConfig)
local core = G_Tables.TDTrainTaskGroupTable.GetInstance()

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
  taskId = 0,
  trainTaskName = 1,
  groupId = 2,
  imgPath = 3
}

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

function this:_getTraintaskname(offset)
  local langStr = G_TableMgrIns:GetLangStr("train_task_group", core:GetVString(offset, this.indexMap.trainTaskName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "trainTaskName")
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getImgpath(offset)
  return core:GetVString(offset, this.indexMap.imgPath).value
end

this.keyToMethodsMap = {
  taskId = this._getTaskid,
  trainTaskName = this._getTraintaskname,
  groupId = this._getGroupid,
  imgPath = this._getImgpath
}
return this
