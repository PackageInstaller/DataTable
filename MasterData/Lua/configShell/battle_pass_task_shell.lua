local this = class("battle_pass_task_shell", G_BaseConfig)
local core = G_Tables.TDBattlePassTaskTable.GetInstance()

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
  teamId = 1,
  type = 2,
  desc = 3,
  param = 4,
  condition = 5,
  exp = 6,
  showCondition = 7,
  showTime = 8,
  endTime = 9,
  commonJump = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeamid(offset)
  return core:GetInt(offset, this.indexMap.teamId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_pass_task", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExp(offset)
  local str = core:GetVString(offset, this.indexMap.exp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getShowcondition(offset)
  local str = core:GetVString(offset, this.indexMap.showCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getShowtime(offset)
  return core:GetVString(offset, this.indexMap.showTime).value
end

function this:_getEndtime(offset)
  return core:GetVString(offset, this.indexMap.endTime).value
end

function this:_getCommonjump(offset)
  return core:GetInt(offset, this.indexMap.commonJump)
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  type = this._getType,
  desc = this._getDesc,
  param = this._getParam,
  condition = this._getCondition,
  exp = this._getExp,
  showCondition = this._getShowcondition,
  showTime = this._getShowtime,
  endTime = this._getEndtime,
  commonJump = this._getCommonjump
}
return this
