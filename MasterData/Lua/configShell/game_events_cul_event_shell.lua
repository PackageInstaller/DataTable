local this = class("game_events_cul_event_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulEventTable.GetInstance()

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
  systemId = 1,
  eventType = 2,
  unlockCondition = 3,
  postype = 4,
  eventName = 5,
  heroId = 6,
  randweight = 7,
  eventDesc = 8,
  icon = 9,
  pic = 10,
  posX = 11,
  posY = 12,
  repeattime = 13,
  duration = 14,
  iconName = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getEventtype(offset)
  return core:GetInt(offset, this.indexMap.eventType)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getPostype(offset)
  return core:GetInt(offset, this.indexMap.postype)
end

function this:_getEventname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_event", core:GetVString(offset, this.indexMap.eventName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "eventName")
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getRandweight(offset)
  return core:GetInt(offset, this.indexMap.randweight)
end

function this:_getEventdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_event", core:GetVString(offset, this.indexMap.eventDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "eventDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPosx(offset)
  return core:GetInt(offset, this.indexMap.posX)
end

function this:_getPosy(offset)
  return core:GetInt(offset, this.indexMap.posY)
end

function this:_getRepeattime(offset)
  return core:GetInt(offset, this.indexMap.repeattime)
end

function this:_getDuration(offset)
  return core:GetInt(offset, this.indexMap.duration)
end

function this:_getIconname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_event", core:GetVString(offset, this.indexMap.iconName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "iconName")
end

this.keyToMethodsMap = {
  id = this._getId,
  systemId = this._getSystemid,
  eventType = this._getEventtype,
  unlockCondition = this._getUnlockcondition,
  postype = this._getPostype,
  eventName = this._getEventname,
  heroId = this._getHeroid,
  randweight = this._getRandweight,
  eventDesc = this._getEventdesc,
  icon = this._getIcon,
  pic = this._getPic,
  posX = this._getPosx,
  posY = this._getPosy,
  repeattime = this._getRepeattime,
  duration = this._getDuration,
  iconName = this._getIconname
}
return this
