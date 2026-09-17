local this = class("home_buff_para_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuffParaTable.GetInstance()

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
  talentId = 0,
  buffCondition = 1,
  buffConditionLogic = 2,
  buffParams = 3,
  buffId = 4
}

function this:_getTalentid(offset)
  return core:GetInt(offset, this.indexMap.talentId)
end

function this:_getBuffcondition(offset)
  local str = core:GetVString(offset, this.indexMap.buffCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffconditionlogic(offset)
  return core:GetInt(offset, this.indexMap.buffConditionLogic)
end

function this:_getBuffparams(offset)
  local str = core:GetVString(offset, this.indexMap.buffParams).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffid(offset)
  local str = core:GetVString(offset, this.indexMap.buffId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  talentId = this._getTalentid,
  buffCondition = this._getBuffcondition,
  buffConditionLogic = this._getBuffconditionlogic,
  buffParams = this._getBuffparams,
  buffId = this._getBuffid
}
return this
