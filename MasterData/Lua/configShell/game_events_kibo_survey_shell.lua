local this = class("game_events_kibo_survey_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsKiboSurveyTable.GetInstance()

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
  name = 2,
  desc = 3,
  kiboMission = 4,
  kiboMissionSelect = 5,
  dropId = 6,
  unlockTime = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_kibo_survey", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_kibo_survey", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getKibomission(offset)
  local str = core:GetVString(offset, this.indexMap.kiboMission).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKibomissionselect(offset)
  return core:GetInt(offset, this.indexMap.kiboMissionSelect)
end

function this:_getDropid(offset)
  return core:GetInt(offset, this.indexMap.dropId)
end

function this:_getUnlocktime(offset)
  return core:GetInt(offset, this.indexMap.unlockTime)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  name = this._getName,
  desc = this._getDesc,
  kiboMission = this._getKibomission,
  kiboMissionSelect = this._getKibomissionselect,
  dropId = this._getDropid,
  unlockTime = this._getUnlocktime
}
return this
