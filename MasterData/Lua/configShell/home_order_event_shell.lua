local this = class("home_order_event_shell", G_BaseConfig)
local core = G_Tables.TDHomeOrderEventTable.GetInstance()

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
  eventid = 0,
  eventType = 1,
  subdivisionType = 2,
  eventName = 3,
  eventToday = 4,
  eventTomorrow = 5,
  eventInfluence = 6,
  eventPriceChange = 7,
  eventEffect = 8,
  orderUnlock = 9
}

function this:_getEventid(offset)
  return core:GetInt(offset, this.indexMap.eventid)
end

function this:_getEventtype(offset)
  return core:GetInt(offset, this.indexMap.eventType)
end

function this:_getSubdivisiontype(offset)
  return core:GetInt(offset, this.indexMap.subdivisionType)
end

function this:_getEventname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_order_event", core:GetVString(offset, this.indexMap.eventName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "eventName")
end

function this:_getEventtoday(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_order_event", core:GetVString(offset, this.indexMap.eventToday))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "eventToday")
end

function this:_getEventtomorrow(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_order_event", core:GetVString(offset, this.indexMap.eventTomorrow))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "eventTomorrow")
end

function this:_getEventinfluence(offset)
  return core:GetInt(offset, this.indexMap.eventInfluence)
end

function this:_getEventpricechange(offset)
  return core:GetInt(offset, this.indexMap.eventPriceChange)
end

function this:_getEventeffect(offset)
  local str = core:GetVString(offset, this.indexMap.eventEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOrderunlock(offset)
  local str = core:GetVString(offset, this.indexMap.orderUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  eventid = this._getEventid,
  eventType = this._getEventtype,
  subdivisionType = this._getSubdivisiontype,
  eventName = this._getEventname,
  eventToday = this._getEventtoday,
  eventTomorrow = this._getEventtomorrow,
  eventInfluence = this._getEventinfluence,
  eventPriceChange = this._getEventpricechange,
  eventEffect = this._getEventeffect,
  orderUnlock = this._getOrderunlock
}
return this
