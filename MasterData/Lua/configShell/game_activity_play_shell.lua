local this = class("game_activity_play_shell", G_BaseConfig)
local core = G_Tables.TDGameActivityPlayTable.GetInstance()

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
  activityid = 2,
  sortId = 3,
  introduce = 4,
  dungeonId = 5,
  taskShow = 6,
  taskUnlock = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_play", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getActivityid(offset)
  return core:GetInt(offset, this.indexMap.activityid)
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortId)
end

function this:_getIntroduce(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_play", core:GetVString(offset, this.indexMap.introduce))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "introduce")
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getTaskshow(offset)
  local str = core:GetVString(offset, this.indexMap.taskShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTaskunlock(offset)
  local str = core:GetVString(offset, this.indexMap.taskUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  activityid = this._getActivityid,
  sortId = this._getSortid,
  introduce = this._getIntroduce,
  dungeonId = this._getDungeonid,
  taskShow = this._getTaskshow,
  taskUnlock = this._getTaskunlock
}
return this
