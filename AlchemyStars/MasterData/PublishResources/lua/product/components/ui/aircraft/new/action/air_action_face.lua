_class("AirActionFace", AirActionBase)
AirActionFace = AirActionFace

function AirActionFace:Constructor(pet, cfgID, waitTime, duration)
  self._pet = pet
  self._waitTime = waitTime
  local cfg = Cfg.cfg_aircraft_pet_face[cfgID]
  if not cfg then
    Log.fatal("###找不到配置表情配置：", cfgID)
    return
  end
  self._faceSeq = {}
  self._faceIdx = 1
  self._curTime = 0
  local preTime = 0
  if self._waitTime then
    preTime = preTime + self._waitTime
  end
  self._duration = 0
  if duration then
    self._duration = duration
  end
  for i, value in ipairs(cfg.FaceSeq) do
    local face = {}
    face.frame = value[1]
    local time = value[2]
    face.time = preTime + time
    preTime = preTime + time
    if not duration then
      self._duration = self._duration + time
    end
    self._faceSeq[#self._faceSeq + 1] = face
  end
  if cfg.BubbleEffect then
    local req = ResourceManager:GetInstance():SyncLoadAsset(cfg.BubbleEffect, LoadType.GameObject)
    self._bubble = req.Obj
    self._bubbleReq = req
    self._cfgOffset = Vector3(cfg.BubbleOffset[1], cfg.BubbleOffset[2], cfg.BubbleOffset[3])
    if not duration then
      if self._duration < cfg.Length then
        self._duration = cfg.Length
      end
      self._bubbleDuration = cfg.Length
    else
      self._bubbleDuration = duration
    end
    self:_updateBubblePos()
  end
  if self._waitTime then
    self._duration = self._duration + self._waitTime
  end
end

function AirActionFace:Start()
  if self._faceSeq == nil then
    self._running = false
    return
  end
  self:_setFace(self._faceSeq[1].frame)
  self._curTime = 0
  self._running = true
  self._faceIdx = 1
  if self._bubble and not self._waitTime then
    self._bubble:SetActive(true)
  end
end

function AirActionFace:IsOver()
  return not self._running
end

function AirActionFace:Update(deltaTimeMS)
  if self._running then
    self._curTime = self._curTime + deltaTimeMS
    if self._waitTime then
      if self._curTime < self._waitTime then
        return
      end
      self._waitTime = nil
      if self._bubble then
        self._bubble:SetActive(true)
      end
    end
    if self._curTime > self._duration then
      self:Stop()
    else
      if self._faceIdx <= #self._faceSeq and self._curTime > self._faceSeq[self._faceIdx].time then
        self._faceIdx = self._faceIdx + 1
        if self._faceIdx <= #self._faceSeq then
          self:_setFace(self._faceSeq[self._faceIdx].frame)
        end
      end
      if self._bubble then
        if self._curTime > self._bubbleDuration then
          self._bubble:SetActive(false)
          self._bubble = nil
        else
          self:_updateBubblePos()
        end
      end
    end
  end
end

function AirActionFace:Stop()
  self._running = false
  self._curTime = 0
  self:Dispose()
end

function AirActionFace:Dispose()
  if self._bubbleReq then
    self._bubbleReq:Dispose()
    self._bubbleReq = nil
  end
end

function AirActionFace:GetPets()
  return {
    self._pet
  }
end

function AirActionFace:_setFace(frame)
  local mat = self._pet:GetFaceMat()
  if mat then
    mat:SetInt("_Frame", frame)
  end
end

function AirActionFace:_updateBubblePos()
  self._bubble.transform.position = self._pet:HeadPos() + self._cfgOffset
end

function AirActionFace:GetBubbleGameObject()
  return self._bubble
end

function AirActionFace:GetActionType()
  return AircraftActionType.Face
end
