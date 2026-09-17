local this = class("hero_favorability_gift_shell", G_BaseConfig)
local core = G_Tables.TDHeroFavorabilityGiftTable.GetInstance()

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
  normalValue = 2,
  favourValue = 3,
  favourHero = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_favorability_gift", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getNormalvalue(offset)
  return core:GetInt(offset, this.indexMap.normalValue)
end

function this:_getFavourvalue(offset)
  return core:GetInt(offset, this.indexMap.favourValue)
end

function this:_getFavourhero(offset)
  local str = core:GetVString(offset, this.indexMap.favourHero).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  normalValue = this._getNormalvalue,
  favourValue = this._getFavourvalue,
  favourHero = this._getFavourhero
}
return this
