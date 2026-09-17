local this = class("gacha_prob_list_shell", G_BaseConfig)
local core = G_Tables.TDGachaProbListTable.GetInstance()

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
  probList = 0,
  probability_SSR = 1,
  probability_SR = 2,
  probability_R = 3,
  ratio_up_SSR_hero = 4,
  ratio_up_SSR_soulessence = 5,
  ratio_nonUP_SSR_hero = 6,
  ratio_nonUP_SSR_soulessence = 7,
  ratio_up_SR_hero = 8,
  ratio_up_SR_soulessence = 9,
  ratio_nonUP_SR_hero = 10,
  ratio_nonUP_SR_soulessence = 11
}

function this:_getProblist(offset)
  return core:GetInt(offset, this.indexMap.probList)
end

function this:_getProbability_ssr(offset)
  return core:GetInt(offset, this.indexMap.probability_SSR)
end

function this:_getProbability_sr(offset)
  return core:GetInt(offset, this.indexMap.probability_SR)
end

function this:_getProbability_r(offset)
  return core:GetInt(offset, this.indexMap.probability_R)
end

function this:_getRatio_up_ssr_hero(offset)
  return core:GetInt(offset, this.indexMap.ratio_up_SSR_hero)
end

function this:_getRatio_up_ssr_soulessence(offset)
  return core:GetInt(offset, this.indexMap.ratio_up_SSR_soulessence)
end

function this:_getRatio_nonup_ssr_hero(offset)
  return core:GetInt(offset, this.indexMap.ratio_nonUP_SSR_hero)
end

function this:_getRatio_nonup_ssr_soulessence(offset)
  return core:GetInt(offset, this.indexMap.ratio_nonUP_SSR_soulessence)
end

function this:_getRatio_up_sr_hero(offset)
  return core:GetInt(offset, this.indexMap.ratio_up_SR_hero)
end

function this:_getRatio_up_sr_soulessence(offset)
  return core:GetInt(offset, this.indexMap.ratio_up_SR_soulessence)
end

function this:_getRatio_nonup_sr_hero(offset)
  return core:GetInt(offset, this.indexMap.ratio_nonUP_SR_hero)
end

function this:_getRatio_nonup_sr_soulessence(offset)
  return core:GetInt(offset, this.indexMap.ratio_nonUP_SR_soulessence)
end

this.keyToMethodsMap = {
  probList = this._getProblist,
  probability_SSR = this._getProbability_ssr,
  probability_SR = this._getProbability_sr,
  probability_R = this._getProbability_r,
  ratio_up_SSR_hero = this._getRatio_up_ssr_hero,
  ratio_up_SSR_soulessence = this._getRatio_up_ssr_soulessence,
  ratio_nonUP_SSR_hero = this._getRatio_nonup_ssr_hero,
  ratio_nonUP_SSR_soulessence = this._getRatio_nonup_ssr_soulessence,
  ratio_up_SR_hero = this._getRatio_up_sr_hero,
  ratio_up_SR_soulessence = this._getRatio_up_sr_soulessence,
  ratio_nonUP_SR_hero = this._getRatio_nonup_sr_hero,
  ratio_nonUP_SR_soulessence = this._getRatio_nonup_sr_soulessence
}
return this
