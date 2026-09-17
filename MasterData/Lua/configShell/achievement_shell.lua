local this = class("achievement_shell", G_BaseConfig)
local core = G_Tables.TDAchievementTable.GetInstance()

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
  achiLevel = 2,
  achiName = 3,
  achiDesc = 4,
  finishCondition = 5,
  param = 6,
  nextAchi = 7,
  firstAchi = 8,
  reward = 9,
  achPoint = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getAchilevel(offset)
  return core:GetInt(offset, this.indexMap.achiLevel)
end

function this:_getAchiname(offset)
  local langStr = G_TableMgrIns:GetLangStr("achievement", core:GetVString(offset, this.indexMap.achiName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "achiName")
end

function this:_getAchidesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("achievement", core:GetVString(offset, this.indexMap.achiDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "achiDesc")
end

function this:_getFinishcondition(offset)
  return core:GetVString(offset, this.indexMap.finishCondition).value
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getNextachi(offset)
  return core:GetInt(offset, this.indexMap.nextAchi)
end

function this:_getFirstachi(offset)
  return core:GetInt(offset, this.indexMap.firstAchi)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAchpoint(offset)
  return core:GetInt(offset, this.indexMap.achPoint)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  achiLevel = this._getAchilevel,
  achiName = this._getAchiname,
  achiDesc = this._getAchidesc,
  finishCondition = this._getFinishcondition,
  param = this._getParam,
  nextAchi = this._getNextachi,
  firstAchi = this._getFirstachi,
  reward = this._getReward,
  achPoint = this._getAchpoint
}
return this
