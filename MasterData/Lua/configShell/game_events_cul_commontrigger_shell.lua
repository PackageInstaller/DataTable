local this = class("game_events_cul_commontrigger_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulCommontriggerTable.GetInstance()

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
  triggertimingid = 0,
  systemId = 1,
  triggertiming = 2,
  triggerchance = 3
}

function this:_getTriggertimingid(offset)
  return core:GetInt(offset, this.indexMap.triggertimingid)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getTriggertiming(offset)
  local str = core:GetVString(offset, this.indexMap.triggertiming).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTriggerchance(offset)
  return core:GetInt(offset, this.indexMap.triggerchance)
end

this.keyToMethodsMap = {
  triggertimingid = this._getTriggertimingid,
  systemId = this._getSystemid,
  triggertiming = this._getTriggertiming,
  triggerchance = this._getTriggerchance
}
return this
