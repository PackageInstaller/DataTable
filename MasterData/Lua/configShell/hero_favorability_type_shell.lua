local this = class("hero_favorability_type_shell", G_BaseConfig)
local core = G_Tables.TDHeroFavorabilityTypeTable.GetInstance()

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
  name = 1,
  show = 2,
  systemId = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_favorability_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  show = this._getShow,
  systemId = this._getSystemid
}
return this
