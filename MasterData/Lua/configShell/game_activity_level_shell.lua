local this = class("game_activity_level_shell", G_BaseConfig)
local core = G_Tables.TDGameActivityLevelTable.GetInstance()

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
  activityid = 1,
  groupid = 2,
  difficulty = 3,
  dungeonId = 4,
  level = 5,
  dungeonTarget = 6,
  trialrole = 7,
  stamina = 8,
  taskUnlock = 9,
  starttimenum = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getActivityid(offset)
  return core:GetInt(offset, this.indexMap.activityid)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupid)
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getDungeontarget(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_level", core:GetVString(offset, this.indexMap.dungeonTarget))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dungeonTarget")
end

function this:_getTrialrole(offset)
  local str = core:GetVString(offset, this.indexMap.trialrole).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStamina(offset)
  return core:GetInt(offset, this.indexMap.stamina)
end

function this:_getTaskunlock(offset)
  local str = core:GetVString(offset, this.indexMap.taskUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getStarttimenum(offset)
  return core:GetInt(offset, this.indexMap.starttimenum)
end

this.keyToMethodsMap = {
  id = this._getId,
  activityid = this._getActivityid,
  groupid = this._getGroupid,
  difficulty = this._getDifficulty,
  dungeonId = this._getDungeonid,
  level = this._getLevel,
  dungeonTarget = this._getDungeontarget,
  trialrole = this._getTrialrole,
  stamina = this._getStamina,
  taskUnlock = this._getTaskunlock,
  starttimenum = this._getStarttimenum
}
return this
