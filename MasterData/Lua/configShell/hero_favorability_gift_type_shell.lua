local this = class("hero_favorability_gift_type_shell", G_BaseConfig)
local core = G_Tables.TDHeroFavorabilityGiftTypeTable.GetInstance()

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
  desc = 2,
  show = 3,
  commonTab = 4,
  systemId = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_favorability_gift_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_favorability_gift_type", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getCommontab(offset)
  return core:GetInt(offset, this.indexMap.commonTab)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  show = this._getShow,
  commonTab = this._getCommontab,
  systemId = this._getSystemid
}
return this
