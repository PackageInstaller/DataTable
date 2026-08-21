_class("AirActionGroupTalk", Object)
AirActionGroupTalk = AirActionGroupTalk

function AirActionGroupTalk:Constructor(petList, cfg, airMain)
  self._airMain = airMain
  self._petList = petList
  self._talkCfg = cfg
  self._talkIndex = 1
  self._running = false
  self._talkInterval = Cfg.cfg_aircraft_const.aircraft_social_talk_txt_interval.IntValue or 5000
  self._talkOverStayTime = Cfg.cfg_aircraft_const.aircraft_social_talk_stay_time.IntValue or 5000
  self._talkData = cfg.TalkData
  self._curTalkAction = nil
  self._lastTalkAction = nil
  self._curTalkBeginTime = 0
  self._needOver = false
  self._isOver = false
end

function AirActionGroupTalk:GetTalkPet(petTemplateID)
  return self._petList[petTemplateID]
end

function AirActionGroupTalk:IsCanTalk()
  return self._talkIndex < table.count(self._talkData)
end

function AirActionGroupTalk:Talk()
  local talkData = self._talkData[self._talkIndex]
  local talkPet = self:GetTalkPet(talkData.Speaker)
  if talkPet then
    local action = AirActionSentence:New(talkPet, talkData.data, self._airMain)
    action:SetLastTime(self._talkInterval)
    if self._curTalkAction then
      if self._lastTalkAction and not self._lastTalkAction:IsOver() then
        self._lastTalkAction:Stop()
      end
      self._lastTalkAction = self._curTalkAction
      self._lastTalkAction:StartClose()
    end
    self._curTalkAction = action
    self._curTalkAction:Start()
    self._running = true
  else
    Log.fatal("")
  end
end

function AirActionGroupTalk:Start()
  self:Talk()
  self._curTalkBeginTime = self._airMain:Time()
end

function AirActionGroupTalk:IsOver()
  return self._isOver
end

function AirActionGroupTalk:Update(deltaTimeMS)
  if self._running and self._curTalkAction then
    self._curTalkAction:Update(deltaTimeMS)
    if self._curTalkAction:IsOver() then
      self._talkIndex = self._talkIndex + 1
      if self:IsCanTalk() then
        self:Talk()
      else
        self._running = false
        self._isOver = true
      end
    end
  end
end

function AirActionGroupTalk:Stop()
  self._running = false
  self._isOver = true
  if self._curTalkAction then
    self._curTalkAction:Stop()
  end
end

function AirActionGroupTalk:GetPets()
  return self._petList
end

function AirActionGroupTalk:Dispose()
end

function AirActionGroupTalk:Log(...)
  Log.debug("[AircraftAction] ", ...)
end
