local this = class("journey_task_target_shell", G_BaseConfig)
local core = G_Tables.TDJourneyTaskTargetTable.GetInstance()

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
  condition = 1,
  targetParam = 2,
  name = 3,
  desc = 4,
  guideDesc = 5,
  pic = 6,
  jumpId = 7,
  traceType = 8,
  traceParam = 9,
  traceCondition = 10,
  traceDesc = 11,
  reward = 12,
  completePoint = 13,
  hud_special_icon = 14,
  hud_desc = 15,
  isAutoGetReward = 16,
  waitNodeId = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTargetparam(offset)
  return core:GetInt(offset, this.indexMap.targetParam)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_task_target", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_task_target", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getGuidedesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_task_target", core:GetVString(offset, this.indexMap.guideDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "guideDesc")
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getJumpid(offset)
  return core:GetInt(offset, this.indexMap.jumpId)
end

function this:_getTracetype(offset)
  return core:GetInt(offset, this.indexMap.traceType)
end

function this:_getTraceparam(offset)
  local str = core:GetVString(offset, this.indexMap.traceParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTracecondition(offset)
  local str = core:GetVString(offset, this.indexMap.traceCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTracedesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("journey_task_target", core:GetVString(offset, this.indexMap.traceDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "journey_task_target")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCompletepoint(offset)
  return core:GetInt(offset, this.indexMap.completePoint)
end

function this:_getHud_special_icon(offset)
  return core:GetInt(offset, this.indexMap.hud_special_icon)
end

function this:_getHud_desc(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_task_target", core:GetVString(offset, this.indexMap.hud_desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "hud_desc")
end

function this:_getIsautogetreward(offset)
  return core:GetInt(offset, this.indexMap.isAutoGetReward)
end

function this:_getWaitnodeid(offset)
  return core:GetInt(offset, this.indexMap.waitNodeId)
end

this.keyToMethodsMap = {
  id = this._getId,
  condition = this._getCondition,
  targetParam = this._getTargetparam,
  name = this._getName,
  desc = this._getDesc,
  guideDesc = this._getGuidedesc,
  pic = this._getPic,
  jumpId = this._getJumpid,
  traceType = this._getTracetype,
  traceParam = this._getTraceparam,
  traceCondition = this._getTracecondition,
  traceDesc = this._getTracedesc,
  reward = this._getReward,
  completePoint = this._getCompletepoint,
  hud_special_icon = this._getHud_special_icon,
  hud_desc = this._getHud_desc,
  isAutoGetReward = this._getIsautogetreward,
  waitNodeId = this._getWaitnodeid
}
return this
