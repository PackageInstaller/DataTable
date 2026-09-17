local this = class("home_technology_shell", G_BaseConfig)
local core = G_Tables.TDHomeTechnologyTable.GetInstance()

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
  objName = 1,
  level = 2,
  type = 3,
  point = 4,
  unlockCondi1 = 5,
  newTechnologyProduct = 6,
  effectDescription = 7,
  buffCondition = 8,
  buffConditionLogic = 9,
  buffParams = 10,
  buffId = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getObjname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_technology", core:GetVString(offset, this.indexMap.objName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "objName")
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getPoint(offset)
  return core:GetInt(offset, this.indexMap.point)
end

function this:_getUnlockcondi1(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondi1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNewtechnologyproduct(offset)
  local str = core:GetVString(offset, this.indexMap.newTechnologyProduct).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEffectdescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_technology", core:GetVString(offset, this.indexMap.effectDescription))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "effectDescription")
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
  id = this._getId,
  objName = this._getObjname,
  level = this._getLevel,
  type = this._getType,
  point = this._getPoint,
  unlockCondi1 = this._getUnlockcondi1,
  newTechnologyProduct = this._getNewtechnologyproduct,
  effectDescription = this._getEffectdescription,
  buffCondition = this._getBuffcondition,
  buffConditionLogic = this._getBuffconditionlogic,
  buffParams = this._getBuffparams,
  buffId = this._getBuffid
}
return this
