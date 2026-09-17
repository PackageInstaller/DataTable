local this = class("game_events_cul_attrrate_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulAttrRateTable.GetInstance()

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
  rating = 0,
  eventid = 1,
  needAttr = 2,
  ratingText = 3,
  ACBonus = 4,
  ACJian = 5,
  finalscore = 6
}

function this:_getRating(offset)
  return core:GetInt(offset, this.indexMap.rating)
end

function this:_getEventid(offset)
  return core:GetInt(offset, this.indexMap.eventid)
end

function this:_getNeedattr(offset)
  return core:GetInt(offset, this.indexMap.needAttr)
end

function this:_getRatingtext(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_attrRate", core:GetVString(offset, this.indexMap.ratingText))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ratingText")
end

function this:_getAcbonus(offset)
  return core:GetInt(offset, this.indexMap.ACBonus)
end

function this:_getAcjian(offset)
  return core:GetInt(offset, this.indexMap.ACJian)
end

function this:_getFinalscore(offset)
  return core:GetInt(offset, this.indexMap.finalscore)
end

this.keyToMethodsMap = {
  rating = this._getRating,
  eventid = this._getEventid,
  needAttr = this._getNeedattr,
  ratingText = this._getRatingtext,
  ACBonus = this._getAcbonus,
  ACJian = this._getAcjian,
  finalscore = this._getFinalscore
}
return this
