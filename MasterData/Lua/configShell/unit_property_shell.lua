local this = class("unit_property_shell", G_BaseConfig)
local core = G_Tables.TDUnitPropertyTable.GetInstance()

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
  baseAttributeId = 1,
  behavior = 2,
  confrontDistance = 3,
  avoidnessHeatLevel = 4,
  avoidnessHeatDecayRate = 5,
  flashRate = 6,
  followId = 7,
  paramFloat = 8,
  paramStr = 9,
  paramInt = 10,
  paramBool = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBaseattributeid(offset)
  return core:GetInt(offset, this.indexMap.baseAttributeId)
end

function this:_getBehavior(offset)
  return core:GetInt(offset, this.indexMap.behavior)
end

function this:_getConfrontdistance(offset)
  return core:GetFloat(offset, this.indexMap.confrontDistance)
end

function this:_getAvoidnessheatlevel(offset)
  return core:GetFloat(offset, this.indexMap.avoidnessHeatLevel)
end

function this:_getAvoidnessheatdecayrate(offset)
  return core:GetFloat(offset, this.indexMap.avoidnessHeatDecayRate)
end

function this:_getFlashrate(offset)
  return core:GetFloat(offset, this.indexMap.flashRate)
end

function this:_getFollowid(offset)
  return core:GetInt(offset, this.indexMap.followId)
end

function this:_getParamfloat(offset)
  local str = core:GetVString(offset, this.indexMap.paramFloat).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getParamstr(offset)
  local str = core:GetVString(offset, this.indexMap.paramStr).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getParamint(offset)
  local str = core:GetVString(offset, this.indexMap.paramInt).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getParambool(offset)
  local str = core:GetVString(offset, this.indexMap.paramBool).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "bool")
end

this.keyToMethodsMap = {
  id = this._getId,
  baseAttributeId = this._getBaseattributeid,
  behavior = this._getBehavior,
  confrontDistance = this._getConfrontdistance,
  avoidnessHeatLevel = this._getAvoidnessheatlevel,
  avoidnessHeatDecayRate = this._getAvoidnessheatdecayrate,
  flashRate = this._getFlashrate,
  followId = this._getFollowid,
  paramFloat = this._getParamfloat,
  paramStr = this._getParamstr,
  paramInt = this._getParamint,
  paramBool = this._getParambool
}
return this
