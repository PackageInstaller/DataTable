local this = class("egg_prob_list_shell", G_BaseConfig)
local core = G_Tables.TDEggProbListTable.GetInstance()

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
  probability_R5 = 3,
  probability_R4 = 4,
  probability_R3 = 5,
  probability_R2 = 6,
  probability_R1 = 7,
  ratio_nonUP_SSR = 8,
  ratio_nonUP_SR = 9
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

function this:_getProbability_r5(offset)
  return core:GetInt(offset, this.indexMap.probability_R5)
end

function this:_getProbability_r4(offset)
  return core:GetInt(offset, this.indexMap.probability_R4)
end

function this:_getProbability_r3(offset)
  return core:GetInt(offset, this.indexMap.probability_R3)
end

function this:_getProbability_r2(offset)
  return core:GetInt(offset, this.indexMap.probability_R2)
end

function this:_getProbability_r1(offset)
  return core:GetInt(offset, this.indexMap.probability_R1)
end

function this:_getRatio_nonup_ssr(offset)
  return core:GetInt(offset, this.indexMap.ratio_nonUP_SSR)
end

function this:_getRatio_nonup_sr(offset)
  return core:GetInt(offset, this.indexMap.ratio_nonUP_SR)
end

this.keyToMethodsMap = {
  probList = this._getProblist,
  probability_SSR = this._getProbability_ssr,
  probability_SR = this._getProbability_sr,
  probability_R5 = this._getProbability_r5,
  probability_R4 = this._getProbability_r4,
  probability_R3 = this._getProbability_r3,
  probability_R2 = this._getProbability_r2,
  probability_R1 = this._getProbability_r1,
  ratio_nonUP_SSR = this._getRatio_nonup_ssr,
  ratio_nonUP_SR = this._getRatio_nonup_sr
}
return this
