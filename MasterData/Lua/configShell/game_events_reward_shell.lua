local this = class("game_events_reward_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsRewardTable.GetInstance()

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
  groupIdGather = 1,
  groupId = 2,
  showType = 3,
  description = 4,
  dropId = 5,
  reward = 6,
  rewardShow = 7,
  finishCondition = 8,
  para = 9,
  commonJump = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupidgather(offset)
  return core:GetInt(offset, this.indexMap.groupIdGather)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getShowtype(offset)
  return core:GetInt(offset, this.indexMap.showType)
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_reward", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getDropid(offset)
  local str = core:GetVString(offset, this.indexMap.dropId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFinishcondition(offset)
  local str = core:GetVString(offset, this.indexMap.finishCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPara(offset)
  return core:GetInt(offset, this.indexMap.para)
end

function this:_getCommonjump(offset)
  return core:GetInt(offset, this.indexMap.commonJump)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupIdGather = this._getGroupidgather,
  groupId = this._getGroupid,
  showType = this._getShowtype,
  description = this._getDescription,
  dropId = this._getDropid,
  reward = this._getReward,
  rewardShow = this._getRewardshow,
  finishCondition = this._getFinishcondition,
  para = this._getPara,
  commonJump = this._getCommonjump
}
return this
