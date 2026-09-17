local this = class("fish_qte_shell", G_BaseConfig)
local core = G_Tables.TDFishQteTable.GetInstance()

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
  teamId = 1,
  order = 2,
  coordinate = 3,
  disappear = 4,
  interval = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeamid(offset)
  return core:GetInt(offset, this.indexMap.teamId)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getCoordinate(offset)
  local str = core:GetVString(offset, this.indexMap.coordinate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDisappear(offset)
  return core:GetInt(offset, this.indexMap.disappear)
end

function this:_getInterval(offset)
  return core:GetInt(offset, this.indexMap.interval)
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  order = this._getOrder,
  coordinate = this._getCoordinate,
  disappear = this._getDisappear,
  interval = this._getInterval
}
return this
