local this = class("activity_shell", G_BaseConfig)
local core = G_Tables.TDActivityTable.GetInstance()

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
  groupOrder = 2,
  reward = 3,
  activityReward = 4,
  activityRewardDisplay = 5,
  description = 6,
  para = 7,
  system = 8,
  unlockCondition = 9,
  systemJump = 10,
  finishCondition = 11,
  taskType = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getGrouporder(offset)
  return core:GetInt(offset, this.indexMap.groupOrder)
end

function this:_getReward(offset)
  return core:GetInt(offset, this.indexMap.reward)
end

function this:_getActivityreward(offset)
  local str = core:GetVString(offset, this.indexMap.activityReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getActivityrewarddisplay(offset)
  local str = core:GetVString(offset, this.indexMap.activityRewardDisplay).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("activity", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getPara(offset)
  return core:GetInt(offset, this.indexMap.para)
end

function this:_getSystem(offset)
  return core:GetInt(offset, this.indexMap.system)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSystemjump(offset)
  return core:GetInt(offset, this.indexMap.systemJump)
end

function this:_getFinishcondition(offset)
  local str = core:GetVString(offset, this.indexMap.finishCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTasktype(offset)
  return core:GetInt(offset, this.indexMap.taskType)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  groupOrder = this._getGrouporder,
  reward = this._getReward,
  activityReward = this._getActivityreward,
  activityRewardDisplay = this._getActivityrewarddisplay,
  description = this._getDescription,
  para = this._getPara,
  system = this._getSystem,
  unlockCondition = this._getUnlockcondition,
  systemJump = this._getSystemjump,
  finishCondition = this._getFinishcondition,
  taskType = this._getTasktype
}
return this
