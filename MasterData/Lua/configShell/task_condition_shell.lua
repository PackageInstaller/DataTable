local this = class("task_condition_shell", G_BaseConfig)
local core = G_Tables.TDTaskConditionTable.GetInstance()

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
  param = 2,
  formulaId = 3,
  guideParam = 4,
  guideCondition = 5,
  guideDesc = 6,
  commonJump = 7,
  jumpDesc = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getFormulaid(offset)
  return core:GetInt(offset, this.indexMap.formulaId)
end

function this:_getGuideparam(offset)
  local str = core:GetVString(offset, this.indexMap.guideParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGuidecondition(offset)
  local str = core:GetVString(offset, this.indexMap.guideCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getGuidedesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("task_condition", core:GetVString(offset, this.indexMap.guideDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "task_condition")
end

function this:_getCommonjump(offset)
  return core:GetInt(offset, this.indexMap.commonJump)
end

function this:_getJumpdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_condition", core:GetVString(offset, this.indexMap.jumpDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "jumpDesc")
end

this.keyToMethodsMap = {
  id = this._getId,
  condition = this._getCondition,
  param = this._getParam,
  formulaId = this._getFormulaid,
  guideParam = this._getGuideparam,
  guideCondition = this._getGuidecondition,
  guideDesc = this._getGuidedesc,
  commonJump = this._getCommonjump,
  jumpDesc = this._getJumpdesc
}
return this
