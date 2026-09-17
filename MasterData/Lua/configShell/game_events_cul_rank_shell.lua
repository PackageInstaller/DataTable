local this = class("game_events_cul_rank_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulRankTable.GetInstance()

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
  rank = 0,
  needTotalAttr = 1,
  coefficient = 2
}

function this:_getRank(offset)
  return core:GetInt(offset, this.indexMap.rank)
end

function this:_getNeedtotalattr(offset)
  return core:GetInt(offset, this.indexMap.needTotalAttr)
end

function this:_getCoefficient(offset)
  return core:GetInt(offset, this.indexMap.coefficient)
end

this.keyToMethodsMap = {
  rank = this._getRank,
  needTotalAttr = this._getNeedtotalattr,
  coefficient = this._getCoefficient
}
return this
