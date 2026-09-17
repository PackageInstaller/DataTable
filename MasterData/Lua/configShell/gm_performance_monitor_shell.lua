local this = class("gm_performance_monitor_shell", G_BaseConfig)
local core = G_Tables.TDGmPerformanceMonitorTable.GetInstance()

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
  key = 1,
  PCUltra = 2,
  PCHigh = 3,
  PCMedium = 4,
  PCLow = 5,
  MobileHigh = 6,
  MobileMedium = 7,
  MobileLow = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getKey(offset)
  return core:GetVString(offset, this.indexMap.key).value
end

function this:_getPcultra(offset)
  return core:GetFloat(offset, this.indexMap.PCUltra)
end

function this:_getPchigh(offset)
  return core:GetFloat(offset, this.indexMap.PCHigh)
end

function this:_getPcmedium(offset)
  return core:GetFloat(offset, this.indexMap.PCMedium)
end

function this:_getPclow(offset)
  return core:GetFloat(offset, this.indexMap.PCLow)
end

function this:_getMobilehigh(offset)
  return core:GetFloat(offset, this.indexMap.MobileHigh)
end

function this:_getMobilemedium(offset)
  return core:GetFloat(offset, this.indexMap.MobileMedium)
end

function this:_getMobilelow(offset)
  return core:GetFloat(offset, this.indexMap.MobileLow)
end

this.keyToMethodsMap = {
  id = this._getId,
  key = this._getKey,
  PCUltra = this._getPcultra,
  PCHigh = this._getPchigh,
  PCMedium = this._getPcmedium,
  PCLow = this._getPclow,
  MobileHigh = this._getMobilehigh,
  MobileMedium = this._getMobilemedium,
  MobileLow = this._getMobilelow
}
return this
