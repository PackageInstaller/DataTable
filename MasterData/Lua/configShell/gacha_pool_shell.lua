local this = class("gacha_pool_shell", G_BaseConfig)
local core = G_Tables.TDGachaPoolTable.GetInstance()

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
  gachaId = 0,
  UP_hero_SSR = 1,
  UP_soulessence_SSR = 2,
  hero_SSR = 3,
  soulessence_SSR = 4,
  UP_hero_SR = 5,
  UP_soulessence_SR = 6,
  hero_SR = 7,
  soulessence_SR = 8,
  soulessence_R = 9,
  aim = 10,
  SR = 11
}

function this:_getGachaid(offset)
  return core:GetInt(offset, this.indexMap.gachaId)
end

function this:_getUp_hero_ssr(offset)
  local str = core:GetVString(offset, this.indexMap.UP_hero_SSR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUp_soulessence_ssr(offset)
  local str = core:GetVString(offset, this.indexMap.UP_soulessence_SSR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHero_ssr(offset)
  local str = core:GetVString(offset, this.indexMap.hero_SSR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSoulessence_ssr(offset)
  local str = core:GetVString(offset, this.indexMap.soulessence_SSR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUp_hero_sr(offset)
  local str = core:GetVString(offset, this.indexMap.UP_hero_SR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUp_soulessence_sr(offset)
  local str = core:GetVString(offset, this.indexMap.UP_soulessence_SR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHero_sr(offset)
  local str = core:GetVString(offset, this.indexMap.hero_SR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSoulessence_sr(offset)
  local str = core:GetVString(offset, this.indexMap.soulessence_SR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSoulessence_r(offset)
  local str = core:GetVString(offset, this.indexMap.soulessence_R).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAim(offset)
  local str = core:GetVString(offset, this.indexMap.aim).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSr(offset)
  local str = core:GetVString(offset, this.indexMap.SR).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  gachaId = this._getGachaid,
  UP_hero_SSR = this._getUp_hero_ssr,
  UP_soulessence_SSR = this._getUp_soulessence_ssr,
  hero_SSR = this._getHero_ssr,
  soulessence_SSR = this._getSoulessence_ssr,
  UP_hero_SR = this._getUp_hero_sr,
  UP_soulessence_SR = this._getUp_soulessence_sr,
  hero_SR = this._getHero_sr,
  soulessence_SR = this._getSoulessence_sr,
  soulessence_R = this._getSoulessence_r,
  aim = this._getAim,
  SR = this._getSr
}
return this
