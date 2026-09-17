local this = class("iconography_level_shell", G_BaseConfig)
local core = G_Tables.TDIconographyLevelTable.GetInstance()

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
  petid = 1,
  iconographyLevel = 2,
  reward = 3,
  attrReward = 4,
  exp = 5,
  surveycoefficient = 6,
  iconparticulars = 7,
  iconlist = 8,
  text = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPetid(offset)
  return core:GetInt(offset, this.indexMap.petid)
end

function this:_getIconographylevel(offset)
  return core:GetInt(offset, this.indexMap.iconographyLevel)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAttrreward(offset)
  local str = core:GetVString(offset, this.indexMap.attrReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getSurveycoefficient(offset)
  return core:GetInt(offset, this.indexMap.surveycoefficient)
end

function this:_getIconparticulars(offset)
  local str = core:GetVString(offset, this.indexMap.iconparticulars).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconlist(offset)
  local str = core:GetVString(offset, this.indexMap.iconlist).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("iconography_level", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

this.keyToMethodsMap = {
  id = this._getId,
  petid = this._getPetid,
  iconographyLevel = this._getIconographylevel,
  reward = this._getReward,
  attrReward = this._getAttrreward,
  exp = this._getExp,
  surveycoefficient = this._getSurveycoefficient,
  iconparticulars = this._getIconparticulars,
  iconlist = this._getIconlist,
  text = this._getText
}
return this
