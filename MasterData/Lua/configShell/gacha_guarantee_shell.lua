local this = class("gacha_guarantee_shell", G_BaseConfig)
local core = G_Tables.TDGachaGuaranteeTable.GetInstance()

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
  guaranteeId = 0,
  guaranteepoolId = 1,
  guaranteeType = 2,
  guaranteeCount = 3,
  isRepeatable = 4,
  isInheritable = 5,
  selfchoose = 6,
  desc = 7,
  gacha_pool_type_list = 8,
  probability_base = 9
}

function this:_getGuaranteeid(offset)
  return core:GetInt(offset, this.indexMap.guaranteeId)
end

function this:_getGuaranteepoolid(offset)
  return core:GetInt(offset, this.indexMap.guaranteepoolId)
end

function this:_getGuaranteetype(offset)
  return core:GetInt(offset, this.indexMap.guaranteeType)
end

function this:_getGuaranteecount(offset)
  return core:GetInt(offset, this.indexMap.guaranteeCount)
end

function this:_getIsrepeatable(offset)
  return core:GetInt(offset, this.indexMap.isRepeatable)
end

function this:_getIsinheritable(offset)
  return core:GetInt(offset, this.indexMap.isInheritable)
end

function this:_getSelfchoose(offset)
  return core:GetInt(offset, this.indexMap.selfchoose)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("gacha_guarantee", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getGacha_pool_type_list(offset)
  local str = core:GetVString(offset, this.indexMap.gacha_pool_type_list).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "string")
end

function this:_getProbability_base(offset)
  return core:GetInt(offset, this.indexMap.probability_base)
end

this.keyToMethodsMap = {
  guaranteeId = this._getGuaranteeid,
  guaranteepoolId = this._getGuaranteepoolid,
  guaranteeType = this._getGuaranteetype,
  guaranteeCount = this._getGuaranteecount,
  isRepeatable = this._getIsrepeatable,
  isInheritable = this._getIsinheritable,
  selfchoose = this._getSelfchoose,
  desc = this._getDesc,
  gacha_pool_type_list = this._getGacha_pool_type_list,
  probability_base = this._getProbability_base
}
return this
