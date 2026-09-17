local this = class("home_labor_train_condition_shell", G_BaseConfig)
local core = G_Tables.TDHomeLaborTrainConditionTable.GetInstance()

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
  desc = 2,
  condition_parameter = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCondition(offset)
  return core:GetVString(offset, this.indexMap.condition).value
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_labor_train_condition", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getCondition_parameter(offset)
  local str = core:GetVString(offset, this.indexMap.condition_parameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  condition = this._getCondition,
  desc = this._getDesc,
  condition_parameter = this._getCondition_parameter
}
return this
