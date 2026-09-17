local this = class("charge_satiety_shell", G_BaseConfig)
local core = G_Tables.TDChargeSatietyTable.GetInstance()

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
  interval = 1,
  amplitude = 2,
  worldBuffId = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getInterval(offset)
  local str = core:GetVString(offset, this.indexMap.interval).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAmplitude(offset)
  return core:GetInt(offset, this.indexMap.amplitude)
end

function this:_getWorldbuffid(offset)
  return core:GetInt(offset, this.indexMap.worldBuffId)
end

this.keyToMethodsMap = {
  id = this._getId,
  interval = this._getInterval,
  amplitude = this._getAmplitude,
  worldBuffId = this._getWorldbuffid
}
return this
