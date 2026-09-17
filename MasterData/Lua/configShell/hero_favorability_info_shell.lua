local this = class("hero_favorability_info_shell", G_BaseConfig)
local core = G_Tables.TDHeroFavorabilityInfoTable.GetInstance()

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
  heroId = 1,
  name = 2,
  favorabilityLevel = 3,
  info = 4,
  levelUpAttribute = 5,
  reward = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_favorability_info", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getFavorabilitylevel(offset)
  return core:GetInt(offset, this.indexMap.favorabilityLevel)
end

function this:_getInfo(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("hero_favorability_info", core:GetVString(offset, this.indexMap.info))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "hero_favorability_info")
end

function this:_getLevelupattribute(offset)
  local str = core:GetVString(offset, this.indexMap.levelUpAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  heroId = this._getHeroid,
  name = this._getName,
  favorabilityLevel = this._getFavorabilitylevel,
  info = this._getInfo,
  levelUpAttribute = this._getLevelupattribute,
  reward = this._getReward
}
return this
