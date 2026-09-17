local this = class("pet_labor_accessory_extra_rate_desc_shell", G_BaseConfig)
local core = G_Tables.TDPetLaborAccessoryExtraRateDescTable.GetInstance()

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
  rate = 1,
  rateText = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRate(offset)
  local str = core:GetVString(offset, this.indexMap.rate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRatetext(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_labor_accessory_extra_rate_desc", core:GetVString(offset, this.indexMap.rateText))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "rateText")
end

this.keyToMethodsMap = {
  id = this._getId,
  rate = this._getRate,
  rateText = this._getRatetext
}
return this
