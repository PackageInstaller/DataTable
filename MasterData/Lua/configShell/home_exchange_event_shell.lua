local this = class("home_exchange_event_shell", G_BaseConfig)
local core = G_Tables.TDHomeExchangeEventTable.GetInstance()

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
  EventId = 0,
  EventUnlock = 1,
  EventName = 2,
  EventDesc = 3,
  EventForeshowName = 4,
  EventForeshowDesc = 5,
  PriceIncreaseTag = 6
}

function this:_getEventid(offset)
  return core:GetInt(offset, this.indexMap.EventId)
end

function this:_getEventunlock(offset)
  local str = core:GetVString(offset, this.indexMap.EventUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getEventname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_exchange_event", core:GetVString(offset, this.indexMap.EventName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EventName")
end

function this:_getEventdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_exchange_event", core:GetVString(offset, this.indexMap.EventDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EventDesc")
end

function this:_getEventforeshowname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_exchange_event", core:GetVString(offset, this.indexMap.EventForeshowName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EventForeshowName")
end

function this:_getEventforeshowdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_exchange_event", core:GetVString(offset, this.indexMap.EventForeshowDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EventForeshowDesc")
end

function this:_getPriceincreasetag(offset)
  local str = core:GetVString(offset, this.indexMap.PriceIncreaseTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  EventId = this._getEventid,
  EventUnlock = this._getEventunlock,
  EventName = this._getEventname,
  EventDesc = this._getEventdesc,
  EventForeshowName = this._getEventforeshowname,
  EventForeshowDesc = this._getEventforeshowdesc,
  PriceIncreaseTag = this._getPriceincreasetag
}
return this
