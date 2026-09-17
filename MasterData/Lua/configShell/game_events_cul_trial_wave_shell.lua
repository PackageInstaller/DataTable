local this = class("game_events_cul_trial_wave_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulTrialWaveTable.GetInstance()

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
  Id = 0,
  trialId = 1,
  waveId = 2,
  worldMapId = 3,
  commonScore = 4,
  eliteScore = 5,
  eliteHpCoefficient = 6,
  bossScore = 7,
  bossHpCoefficient = 8,
  waveScore = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getTrialid(offset)
  return core:GetInt(offset, this.indexMap.trialId)
end

function this:_getWaveid(offset)
  return core:GetInt(offset, this.indexMap.waveId)
end

function this:_getWorldmapid(offset)
  local str = core:GetVString(offset, this.indexMap.worldMapId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCommonscore(offset)
  return core:GetInt(offset, this.indexMap.commonScore)
end

function this:_getElitescore(offset)
  return core:GetInt(offset, this.indexMap.eliteScore)
end

function this:_getElitehpcoefficient(offset)
  return core:GetInt(offset, this.indexMap.eliteHpCoefficient)
end

function this:_getBossscore(offset)
  return core:GetInt(offset, this.indexMap.bossScore)
end

function this:_getBosshpcoefficient(offset)
  return core:GetInt(offset, this.indexMap.bossHpCoefficient)
end

function this:_getWavescore(offset)
  return core:GetInt(offset, this.indexMap.waveScore)
end

this.keyToMethodsMap = {
  Id = this._getId,
  trialId = this._getTrialid,
  waveId = this._getWaveid,
  worldMapId = this._getWorldmapid,
  commonScore = this._getCommonscore,
  eliteScore = this._getElitescore,
  eliteHpCoefficient = this._getElitehpcoefficient,
  bossScore = this._getBossscore,
  bossHpCoefficient = this._getBosshpcoefficient,
  waveScore = this._getWavescore
}
return this
