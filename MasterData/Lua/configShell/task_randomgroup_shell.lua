local this = class("task_randomgroup_shell", G_BaseConfig)
local core = G_Tables.TDTaskRandomgroupTable.GetInstance()

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
  groupId = 1,
  cityId = 2,
  position = 3,
  checkarea = 4,
  randomnum = 5,
  taskid = 6,
  taskrandom = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getCityid(offset)
  return core:GetInt(offset, this.indexMap.cityId)
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCheckarea(offset)
  return core:GetInt(offset, this.indexMap.checkarea)
end

function this:_getRandomnum(offset)
  local str = core:GetVString(offset, this.indexMap.randomnum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskid)
end

function this:_getTaskrandom(offset)
  return core:GetInt(offset, this.indexMap.taskrandom)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  cityId = this._getCityid,
  position = this._getPosition,
  checkarea = this._getCheckarea,
  randomnum = this._getRandomnum,
  taskid = this._getTaskid,
  taskrandom = this._getTaskrandom
}
return this
