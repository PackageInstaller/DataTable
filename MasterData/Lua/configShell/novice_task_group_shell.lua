local this = class("novice_task_group_shell", G_BaseConfig)
local core = G_Tables.TDNoviceTaskGroupTable.GetInstance()

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
  type = 1,
  canAcceptEarly = 2,
  unlockContidion = 3,
  lockTips = 4,
  exId = 5,
  name = 6,
  desc = 7,
  reward = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getCanacceptearly(offset)
  return core:GetBool(offset, this.indexMap.canAcceptEarly)
end

function this:_getUnlockcontidion(offset)
  local str = core:GetVString(offset, this.indexMap.unlockContidion).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getLocktips(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("novice_task_group", core:GetVString(offset, this.indexMap.lockTips))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "novice_task_group")
end

function this:_getExid(offset)
  return core:GetInt(offset, this.indexMap.exId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("novice_task_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("novice_task_group", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  canAcceptEarly = this._getCanacceptearly,
  unlockContidion = this._getUnlockcontidion,
  lockTips = this._getLocktips,
  exId = this._getExid,
  name = this._getName,
  desc = this._getDesc,
  reward = this._getReward
}
return this
