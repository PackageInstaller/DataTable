local this = class("seven_day_target_shell", G_BaseConfig)
local core = G_Tables.TDSevenDayTargetTable.GetInstance()

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
  group = 1,
  condition = 2,
  param = 3,
  reward = 4,
  jump = 5,
  desc = 6,
  sortid = 7,
  isTop = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getJump(offset)
  return core:GetInt(offset, this.indexMap.jump)
end

function this:_getDesc(offset)
  return core:GetVString(offset, this.indexMap.desc).value
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortid)
end

function this:_getIstop(offset)
  return core:GetInt(offset, this.indexMap.isTop)
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  condition = this._getCondition,
  param = this._getParam,
  reward = this._getReward,
  jump = this._getJump,
  desc = this._getDesc,
  sortid = this._getSortid,
  isTop = this._getIstop
}
return this
