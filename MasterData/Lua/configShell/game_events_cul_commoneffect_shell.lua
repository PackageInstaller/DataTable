local this = class("game_events_cul_commoneffect_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulCommoneffectTable.GetInstance()

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
  commoneventid = 0,
  systemId = 1,
  triggertimingid = 2,
  weight = 3,
  commoneventgroup = 4,
  triggereffect = 5
}

function this:_getCommoneventid(offset)
  return core:GetInt(offset, this.indexMap.commoneventid)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getTriggertimingid(offset)
  local str = core:GetVString(offset, this.indexMap.triggertimingid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getCommoneventgroup(offset)
  return core:GetInt(offset, this.indexMap.commoneventgroup)
end

function this:_getTriggereffect(offset)
  local str = core:GetVString(offset, this.indexMap.triggereffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  commoneventid = this._getCommoneventid,
  systemId = this._getSystemid,
  triggertimingid = this._getTriggertimingid,
  weight = this._getWeight,
  commoneventgroup = this._getCommoneventgroup,
  triggereffect = this._getTriggereffect
}
return this
