_class("AirActionSentence", AirActionBase)
AirActionSentence = AirActionSentence

function AirActionSentence:Constructor(pet, sentence, main, audioPlayerID, timeOutTime)
  self._pet = pet
  self._sentence = sentence
  self._main = main
  self._timeOutTime = timeOutTime
  self._startTime = 0
  self._lastTime = 5000
  self._animLstTime = self._lastTime + 600
  self._audioPlayerID = audioPlayerID
  self._isClosing = false
  self._focusPetPosZ = Cfg.cfg_aircraft_camera.focusPetPosZ.Value
  self._TalkTexDef = Cfg.cfg_aircraft_const.TalkTexDef.FloatValue or 15
  self._TalkTexParam = Cfg.cfg_aircraft_const.TalkTexParam.FloatValue or 0.1
end

function AirActionSentence:SetLastTime(time)
  self._lastTime = time
  self._animLstTime = self._lastTime + 600
end

function AirActionSentence:Start()
  local pos = self._pet:HeadPos()
  local petPosZ = self._pet:WorldPosition().z
  local dis = math.abs(self._focusPetPosZ - petPosZ)
  local scales = dis - self._TalkTexDef
  local k = self._TalkTexParam
  local lastScale = scales * k + 0.75
  local petid = self._pet:TemplateID()
  Log.debug("###[AircraftInteractiveTexPool] 拿来吧你,petid:", petid)
  self._texItem = self._main:DequeueTexItem()
  self._texItem:SetScale(lastScale)
  local str = HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(self._sentence))
  self._texItem:SetData(pos, str)
  self._texItem:PlayOpenAnim()
  self._running = true
  if self._audioPlayerID then
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
    end
    self._event = GameGlobal.Timer():AddEvent(1500, function()
      if self._isClosing then
        return
      end
      local audioLength = AudioHelperController.GetPlayingVoiceSecLength(self._audioPlayerID)
      if audioLength and 0 < audioLength then
        audioLength = math.floor(audioLength * 1000)
        audioLength = audioLength + 1000
        if self._timeOutTime and audioLength > self._timeOutTime then
          self._main:ChangeInteractiveTimeOut(audioLength)
        end
        if 3000 < audioLength then
          self._lastTime = audioLength
          self._animLstTime = self._lastTime + 600
        else
          self._lastTime = 3000
          self._animLstTime = self._lastTime + 600
        end
      else
        Log.debug("###audioLength --> nil")
      end
    end)
  end
end

function AirActionSentence:IsOver()
  return not self._running
end

function AirActionSentence:Update(deltaTimeMS)
  if self._running then
    self._startTime = self._startTime + deltaTimeMS
    if self._texItem then
      local pos = self._pet:HeadPos()
      self._texItem:UpDataPos(pos)
    end
    if self._isClosing then
      if self._startTime >= self._animLstTime then
        self:Stop()
      end
    elseif self._startTime >= self._lastTime then
      self:StartClose()
    end
  end
end

function AirActionSentence:StartClose()
  if self._isClosing == false then
    self._isClosing = true
    self._startTime = self._lastTime
    if self._texItem then
      self._texItem:PLayCloseAnim()
    end
  end
end

function AirActionSentence:Stop()
  self._running = false
  self._isClosing = false
  self:Dispose()
end

function AirActionSentence:Dispose()
  if self._texItem then
    if self._pet then
      local petid = self._pet:TemplateID()
      Log.debug("###[AircraftInteractiveTexPool] 给你了啊,petid:", petid)
    end
    self._main:EnqueueTexItem(self._texItem)
    self._texItem = nil
  end
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function AirActionSentence:GetPets()
  return {
    self._pet
  }
end
