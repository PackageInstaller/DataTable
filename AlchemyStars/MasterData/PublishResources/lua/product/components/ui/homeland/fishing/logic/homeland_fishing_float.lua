local FishgingFloatType = {Main = 0, Pet = 1}
_enum("FishgingFloatType", FishgingFloatType)
local FishgingFloatStatus = {
  None = 0,
  Toss = 1,
  Idle = 2,
  Offset = 3,
  Success = 4
}
_enum("FishgingFloatStatus", FishgingFloatStatus)
_class("HomelandFishingFloat", Object)
HomelandFishingFloat = HomelandFishingFloat

function HomelandFishingFloat:Constructor(type, pos)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  self._homelandClient = homeLandModule:GetClient()
  local characterManager = self._homelandClient:CharacterManager()
  self._characterController = characterManager:MainCharacterController()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    self:Update()
  end)
  self._type = type
  self._status = FishgingFloatStatus.None
  self._timer = 0
  self._middleFrame = 30
  self._totalFrame = 60
  self._currentFrame = self._middleFrame
  self._targetFrame = self._middleFrame
  self:_AddEvent()
  self:CreateFloat(pos)
end

function HomelandFishingFloat:Update()
  if self._status == FishgingFloatStatus.None then
    return
  end
  if self._status == FishgingFloatStatus.Toss then
    self._timer = self._timer + UnityEngine.Time.deltaTime
    if self._timer >= 1 then
      self._status = FishgingFloatStatus.Idle
      self._animation:Play("anim_5012001_idle")
    end
    return
  end
  if self._status == FishgingFloatStatus.Offset then
    if self._currentFrame == self._targetFrame then
      return
    end
    if self._currentFrame > self._targetFrame then
      self._currentFrame = self._currentFrame - 1
    else
      self._currentFrame = self._currentFrame + 1
    end
    self:PlayAnimationByFrame("anim_5012001_offset", self._totalFrame, self._currentFrame)
    return
  end
end

function HomelandFishingFloat:CreateFloat(pos)
  self._floatReq = ResourceManager:GetInstance():SyncLoadAsset("hl_tool_5012001_float.prefab", LoadType.GameObject)
  if not self._floatReq or not self._floatReq.Obj then
    Log.fatal("加载鱼漂资源失败")
  end
  local go = self._floatReq.Obj
  go:SetActive(true)
  self._floatTran = go.transform
  self._floatTran.position = pos
  local playerTran = self._characterController:Transform()
  self._floatTran.rotation = playerTran.rotation
  self._status = FishgingFloatStatus.Toss
  self._timer = 0
  self._animation = go:GetComponent("Animation")
  self._floatRealTran = self._floatTran:Find("effect/water_loop")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioThrowFishingRod)
end

function HomelandFishingFloat:Release()
  if self._floatReq then
    self._floatReq:Dispose()
    self._floatReq = nil
  end
  self._floatTran = nil
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:_RemoveEvent()
end

function HomelandFishingFloat:_AddEvent()
  if self._cbFishingPowerChange == nil then
    self._cbFishingPowerChange = GameHelper:GetInstance():CreateCallback(self.OnFishingPowerChange, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingPowerChange, self._cbFishingPowerChange)
  end
  if self._cbChangeFishingStatus == nil then
    self._cbChangeFishingStatus = GameHelper:GetInstance():CreateCallback(self.OnMainChangeFishingStatus, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ChangeFishingStatus, self._cbChangeFishingStatus)
  end
  if self._cbFishMatchPetChangeFishingStatus == nil then
    self._cbFishMatchPetChangeFishingStatus = GameHelper:GetInstance():CreateCallback(self.OnPetChangeFishingStatus, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishMatchPetChangeFishingStatus, self._cbFishMatchPetChangeFishingStatus)
  end
end

function HomelandFishingFloat:_RemoveEvent()
  if self._cbFishingPowerChange then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingPowerChange, self._cbFishingPowerChange)
    self._cbFishingPowerChange = nil
  end
  if self._cbChangeFishingStatus then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ChangeFishingStatus, self._cbChangeFishingStatus)
    self._cbChangeFishingStatus = nil
  end
  if self._cbFishMatchPetChangeFishingStatus then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishMatchPetChangeFishingStatus, self._cbFishMatchPetChangeFishingStatus)
    self._cbFishMatchPetChangeFishingStatus = nil
  end
end

function HomelandFishingFloat:GetFloatPosition()
  return self._floatRealTran.position
end

function HomelandFishingFloat:OnFishingPowerChange(value, percent)
  if self._type == FishgingFloatType.Pet then
    return
  end
  if value == 0 then
    self._targetFrame = self._middleFrame
  elseif value < 0 then
    self._targetFrame = self._middleFrame + math.floor((1 - percent) * (self._totalFrame - self._middleFrame))
  elseif 0 < value then
    self._targetFrame = math.floor((1 - percent) * self._middleFrame)
  end
end

function HomelandFishingFloat:OnChangeFishingStatus(status)
  if status == FishgingStatus.Bite then
    self._status = FishgingFloatStatus.Offset
    self:PlayAnimationByFrame("anim_5012001_offset", self._totalFrame, self._currentFrame)
    return
  end
  if status == FishgingStatus.FishSuccess then
    self._status = FishgingFloatStatus.Success
    self._animation:Play("anim_5012001_success")
    return
  end
end

function HomelandFishingFloat:OnMainChangeFishingStatus(status)
  if self._type == FishgingFloatType.Main then
    self:OnChangeFishingStatus(status)
  end
end

function HomelandFishingFloat:OnPetChangeFishingStatus(status)
  if self._type == FishgingFloatType.Pet then
    self:OnChangeFishingStatus(status)
  end
end

function HomelandFishingFloat:PlayAnimationByFrame(animName, totalFrame, currentFrame)
  self._animation:Play(animName)
  local state = self._animation:get_Item(animName)
  if state then
    local length = state.clip.length
    state.time = length * currentFrame / totalFrame
    self._animation:Sample()
    state.enabled = false
  end
  self._animation:Stop()
end
