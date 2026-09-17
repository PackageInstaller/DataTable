local this = class("pet_rank_voice_shell", G_BaseConfig)
local core = G_Tables.TDPetRankVoiceTable.GetInstance()

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
  timeline = 1,
  stage = 2,
  audioEvent = 3,
  bgmEvent = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTimeline(offset)
  local str = core:GetVString(offset, this.indexMap.timeline).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getStage(offset)
  local str = core:GetVString(offset, this.indexMap.stage).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getAudioevent(offset)
  return core:GetVString(offset, this.indexMap.audioEvent).value
end

function this:_getBgmevent(offset)
  return core:GetVString(offset, this.indexMap.bgmEvent).value
end

this.keyToMethodsMap = {
  id = this._getId,
  timeline = this._getTimeline,
  stage = this._getStage,
  audioEvent = this._getAudioevent,
  bgmEvent = this._getBgmevent
}
return this
