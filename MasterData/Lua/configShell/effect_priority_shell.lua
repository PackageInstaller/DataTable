local this = class("effect_priority_shell", G_BaseConfig)
local core = G_Tables.TDEffectPriorityTable.GetInstance()

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
  Path = 1,
  pc_cost_low = 2,
  pc_rank_low = 3,
  pc_cost_mid = 4,
  pc_rank_mid = 5,
  pc_cost_high = 6,
  pc_rank_high = 7,
  pc_cost_perfect = 8,
  pc_rank_perfect = 9,
  mobile_cost_low = 10,
  mobile_rank_low = 11,
  mobile_cost_mid = 12,
  mobile_rank_mid = 13,
  mobile_cost_high = 14,
  mobile_rank_high = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPath(offset)
  return core:GetVString(offset, this.indexMap.Path).value
end

function this:_getPc_cost_low(offset)
  return core:GetFloat(offset, this.indexMap.pc_cost_low)
end

function this:_getPc_rank_low(offset)
  return core:GetVString(offset, this.indexMap.pc_rank_low).value
end

function this:_getPc_cost_mid(offset)
  return core:GetFloat(offset, this.indexMap.pc_cost_mid)
end

function this:_getPc_rank_mid(offset)
  return core:GetVString(offset, this.indexMap.pc_rank_mid).value
end

function this:_getPc_cost_high(offset)
  return core:GetFloat(offset, this.indexMap.pc_cost_high)
end

function this:_getPc_rank_high(offset)
  return core:GetVString(offset, this.indexMap.pc_rank_high).value
end

function this:_getPc_cost_perfect(offset)
  return core:GetFloat(offset, this.indexMap.pc_cost_perfect)
end

function this:_getPc_rank_perfect(offset)
  return core:GetVString(offset, this.indexMap.pc_rank_perfect).value
end

function this:_getMobile_cost_low(offset)
  return core:GetFloat(offset, this.indexMap.mobile_cost_low)
end

function this:_getMobile_rank_low(offset)
  return core:GetVString(offset, this.indexMap.mobile_rank_low).value
end

function this:_getMobile_cost_mid(offset)
  return core:GetFloat(offset, this.indexMap.mobile_cost_mid)
end

function this:_getMobile_rank_mid(offset)
  return core:GetVString(offset, this.indexMap.mobile_rank_mid).value
end

function this:_getMobile_cost_high(offset)
  return core:GetFloat(offset, this.indexMap.mobile_cost_high)
end

function this:_getMobile_rank_high(offset)
  return core:GetVString(offset, this.indexMap.mobile_rank_high).value
end

this.keyToMethodsMap = {
  id = this._getId,
  Path = this._getPath,
  pc_cost_low = this._getPc_cost_low,
  pc_rank_low = this._getPc_rank_low,
  pc_cost_mid = this._getPc_cost_mid,
  pc_rank_mid = this._getPc_rank_mid,
  pc_cost_high = this._getPc_cost_high,
  pc_rank_high = this._getPc_rank_high,
  pc_cost_perfect = this._getPc_cost_perfect,
  pc_rank_perfect = this._getPc_rank_perfect,
  mobile_cost_low = this._getMobile_cost_low,
  mobile_rank_low = this._getMobile_rank_low,
  mobile_cost_mid = this._getMobile_cost_mid,
  mobile_rank_mid = this._getMobile_rank_mid,
  mobile_cost_high = this._getMobile_cost_high,
  mobile_rank_high = this._getMobile_rank_high
}
return this
