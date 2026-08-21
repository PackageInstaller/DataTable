require("base_ins_r")
_class("PlayBossSpeakInstruction", BaseInstruction)
PlayBossSpeakInstruction = PlayBossSpeakInstruction

function PlayBossSpeakInstruction:Constructor(paramList)
  self._bossCardImage = paramList.bossCardImage
  self._bossName = paramList.bossName
  self._prob = tonumber(paramList.prob)
  self._speakList = {}
  self._audioList = {}
  local paramStr = paramList.speakList
  local splitStrArray = string.split(paramStr, "|")
  for _, v in ipairs(splitStrArray) do
    self._speakList[#self._speakList + 1] = v
  end
  paramStr = paramList.audioList
  splitStrArray = string.split(paramStr, "|")
  for _, v in ipairs(splitStrArray) do
    self._audioList[#self._audioList + 1] = tonumber(v)
  end
  if #self._speakList ~= #self._audioList then
    Log.error("PlayBossSpeak speak and audio size error!")
  end
  self._duration = tonumber(paramList.duration)
  self._inAnimName = paramList.inAnimName
  self._loopAnimName = paramList.loopAnimName
  self._outAnimName = paramList.outAnimName
end

function PlayBossSpeakInstruction:GetCacheAudio()
  local t = {}
  for _, v in ipairs(self._audioList) do
    if v and 0 < v then
      t[#t + 1] = v
    end
  end
  return t
end

function PlayBossSpeakInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local rand = Mathf.Random(1, 100)
  if rand <= self._prob then
    local index = Mathf.Random(1, #self._speakList)
    local curSpeak = self._speakList[index]
    world:EventDispatcher():Dispatch(GameEventType.UIShowBossSpeak, {
      self._inAnimName,
      self._loopAnimName
    }, self._bossCardImage, self._bossName, curSpeak, self._duration, self._outAnimName)
    local curAudioID = self._audioList[index]
    if curAudioID and 0 < curAudioID then
      InnerGameHelperRender.InnerGamePlayPetVoid(curAudioID, casterEntity)
    end
  end
end
