local this = class("novice_task_shell", G_BaseConfig)
local core = G_Tables.TDNoviceTaskTable.GetInstance()

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
  orderId = 2,
  title = 3,
  desc = 4,
  reward = 5,
  rewardShow = 6,
  param = 7,
  finishCondition = 8,
  systemJump = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getOrderid(offset)
  return core:GetInt(offset, this.indexMap.orderId)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("novice_task", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("novice_task", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getFinishcondition(offset)
  local str = core:GetVString(offset, this.indexMap.finishCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getSystemjump(offset)
  return core:GetInt(offset, this.indexMap.systemJump)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  orderId = this._getOrderid,
  title = this._getTitle,
  desc = this._getDesc,
  reward = this._getReward,
  rewardShow = this._getRewardshow,
  param = this._getParam,
  finishCondition = this._getFinishcondition,
  systemJump = this._getSystemjump
}
return this
