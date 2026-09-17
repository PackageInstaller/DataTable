local this = class("event_herotrial_shell", G_BaseConfig)
local core = G_Tables.TDEventHerotrialTable.GetInstance()

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
  eventName = 1,
  trailId = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEventname(offset)
  local langStr = G_TableMgrIns:GetLangStr("event_herotrial", core:GetVString(offset, this.indexMap.eventName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "eventName")
end

function this:_getTrailid(offset)
  local str = core:GetVString(offset, this.indexMap.trailId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  eventName = this._getEventname,
  trailId = this._getTrailid
}
return this
