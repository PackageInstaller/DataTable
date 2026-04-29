_class("UIDrawCardAnimOperation", Object)
UIDrawCardAnimOperation = UIDrawCardAnimOperation

function UIDrawCardAnimOperation:Constructor(finder)
  self._enable = false
  self._finder = finder
  self._input = MazeInputManager:New(true)
  self._input:Init(3)
  self._screenHeight = UnityEngine.Screen.height
  self._handle = self._finder:GetGameObject("Ckt_Yg").transform
  self._handleStartRot = Cfg.cfg_drawcard_value[2].Value
  self._handleEndRot = Cfg.cfg_drawcard_value[3].Value
  self._handleFinishRot = Cfg.cfg_drawcard_value[4].Value
  self._handleFallDuaration = Cfg.cfg_drawcard_value[5].Value
  self._handleBackDuaration = Cfg.cfg_drawcard_value[6].Value
  self._operating = false
  self._guideEft = self._finder:GetGameObject("chouka_yindao_prefab")
  self._guideEft:SetActive(false)
end

function UIDrawCardAnimOperation:Init(camera, maxStar, onEnd)
  local audio_eft = {
    [3] = CriAudioIDConst.Drawcard_lagan_eft_3,
    [4] = CriAudioIDConst.Drawcard_lagan_eft_4,
    [5] = CriAudioIDConst.Drawcard_lagan_eft_5,
    [6] = CriAudioIDConst.Drawcard_lagan_eft_6
  }
  self._camera = camera
  self.maxStar = maxStar
  self._onEnd = onEnd
  self._handle.eulerAngles = Vector3(self._handleStartRot, 0, 0)
  self._handleParams = self:FormatParams(maxStar)
  self._audio_eft = audio_eft[maxStar]
  self._viewPortStart = nil
end

function UIDrawCardAnimOperation:FormatParams(star)
  local cfgID = star - 2
  local cfg = Cfg.cfg_drawcard_handle[cfgID]
  local param = {}
  param.parts = {}
  param.rates = {}
  for i = 1, #cfg.Rates do
    param.parts[i] = cfg.Parts[i]
    param.rates[i] = cfg.Rates[i]
  end
  return param
end

function UIDrawCardAnimOperation:Enabled()
  return self._enable
end

function UIDrawCardAnimOperation:SetEnable(enable)
  self._enable = enable
  self:FlushGuide(1000)
end

function UIDrawCardAnimOperation:Dispose()
  self._enable = false
end

function UIDrawCardAnimOperation:OperateFinish()
  self._enable = false
  if self._oprateAudio then
    AudioHelperController.StopUISound(self._oprateAudio)
    self._oprateAudio = nil
  end
  AudioHelperController.StopUISound(self._eft_audio)
  AudioHelperController.StopUISound(self._once_audio)
  self:FlushGuide(-1)
  self._onEnd()
end

function UIDrawCardAnimOperation:HandleRollBack()
  self._enable = false
  if self._oprateAudio then
    AudioHelperController.StopUISound(self._oprateAudio)
    self._oprateAudio = nil
  end
  AudioHelperController.StopUISound(self._eft_audio)
  self._handle:DORotate(Vector3(self._handleStartRot, 0, 0), self._handleBackDuaration):SetEase(DG.Tweening.Ease.OutBounce):OnComplete(function()
    self._enable = true
  end)
end

function UIDrawCardAnimOperation:Update(deltaTime)
  if not self._enable then
    return
  end
  self._input:Update(deltaTime)
  local down, downPos = self._input:GetMouseDown()
  if down and not self._operating then
    local clickRay = self._camera:ScreenPointToRay(downPos)
    local castRes, hitInfo = UnityEngine.Physics.Raycast(clickRay, nil, 1)
    if castRes and hitInfo.transform == self._handle then
      self._operating = true
      self._viewPortStart = self:ScreenPos2ViewPortY(downPos)
      self:FlushGuide(-1)
      self._eft_audio = AudioHelperController.PlayRequestedUISound(self._audio_eft)
      self._once_audio = AudioHelperController.PlayRequestedUISound(CriAudioIDConst.Drawcard_lagan_once)
    end
  end
  if self._operating then
    local up, upPos = self._input:GetMouseUp()
    if up then
      self:HandleRollBack()
      self:FlushGuide(1500)
      self._operating = false
      return
    end
    local dragging, dragStart, dragEnd = self._input:GetDrag()
    if dragging then
      local deltaPixel = dragEnd.y - dragStart.y
      local deltaViewport = deltaPixel / self._screenHeight
      local rot = self._handle.eulerAngles:Clone()
      local viewPortY = self:ScreenPos2ViewPortY(dragEnd)
      local rate = self:GetDragRate(viewPortY)
      rot.x = rot.x + deltaViewport * rate
      if rot.x > 180 then
        rot.x = rot.x - 360
      end
      rot.x = math.min(rot.x, self._handleStartRot)
      self._handle.eulerAngles = rot
      if math.abs(deltaPixel) > 3 then
        if self._oprateAudio == nil then
          self._oprateAudio = AudioHelperController.PlayRequestedUISound(CriAudioIDConst.DrawCard_lagan_new)
        end
      elseif self._oprateAudio then
        AudioHelperController.StopUISound(self._oprateAudio)
        self._oprateAudio = nil
      end
      if rot.x <= self._handleEndRot then
        self:OperateFinish()
      end
    end
  end
end

function UIDrawCardAnimOperation:FlushGuide(delayTime)
  if self.guideEvent then
    GameGlobal.Timer():CancelEvent(self.guideEvent)
    self.guideEvent = nil
  end
  self._guideEft:SetActive(false)
  if delayTime <= 0 then
    return
  end
  self.guideEvent = GameGlobal.Timer():AddEvent(delayTime, function()
    self._guideEft:SetActive(true)
  end)
end

function UIDrawCardAnimOperation:ScreenPos2ViewPortY(pos)
  return 1 - pos.y / self._screenHeight
end

function UIDrawCardAnimOperation:GetDragRate(viewPortY)
  viewPortY = (viewPortY - self._viewPortStart) / (1 - self._viewPortStart)
  for idx, value in ipairs(self._handleParams.parts) do
    if value > viewPortY then
      return self._handleParams.rates[idx]
    end
  end
  return 0.03
end
