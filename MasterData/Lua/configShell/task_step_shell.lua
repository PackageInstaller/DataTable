local this = class("task_step_shell", G_BaseConfig)
local core = G_Tables.TDTaskStepTable.GetInstance()

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
  taskId = 1,
  nodeId = 2,
  desc = 3,
  sign = 4,
  rewardShow = 5,
  reward = 6,
  isLimitStep = 7,
  rewardMain = 8,
  mutexSpawnerIdList = 9
}

function this:_getId(offset)
  return core:GetLong(offset, this.indexMap.id)
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

function this:_getNodeid(offset)
  return core:GetInt(offset, this.indexMap.nodeId)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_step", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSign(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_step", core:GetVString(offset, this.indexMap.sign))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "sign")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getReward(offset)
  return core:GetInt(offset, this.indexMap.reward)
end

function this:_getIslimitstep(offset)
  return core:GetInt(offset, this.indexMap.isLimitStep)
end

function this:_getRewardmain(offset)
  return core:GetInt(offset, this.indexMap.rewardMain)
end

function this:_getMutexspawneridlist(offset)
  local str = core:GetVString(offset, this.indexMap.mutexSpawnerIdList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  taskId = this._getTaskid,
  nodeId = this._getNodeid,
  desc = this._getDesc,
  sign = this._getSign,
  rewardShow = this._getRewardshow,
  reward = this._getReward,
  isLimitStep = this._getIslimitstep,
  rewardMain = this._getRewardmain,
  mutexSpawnerIdList = this._getMutexspawneridlist
}
return this
