local this = class("hero_favorability_exp_shell", G_BaseConfig)
local core = G_Tables.TDHeroFavorabilityExpTable.GetInstance()

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
  favorabilityLevel = 0,
  name = 1,
  favorabilityExp = 2
}

function this:_getFavorabilitylevel(offset)
  return core:GetInt(offset, this.indexMap.favorabilityLevel)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_favorability_exp", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getFavorabilityexp(offset)
  return core:GetInt(offset, this.indexMap.favorabilityExp)
end

this.keyToMethodsMap = {
  favorabilityLevel = this._getFavorabilitylevel,
  name = this._getName,
  favorabilityExp = this._getFavorabilityexp
}
return this
