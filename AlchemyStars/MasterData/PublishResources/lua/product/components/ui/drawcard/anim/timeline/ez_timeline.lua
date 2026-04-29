local EZTL_EndTag = {
  All = 1,
  Any = 2,
  SomeOne = 3
}
_enum("EZTL_EndTag", EZTL_EndTag)
_class("EZTL_Player", Object)
EZTL_Player = EZTL_Player

function EZTL_Player:Constructor()
  self._tl = nil
  self._stopped = false
end

function EZTL_Player:Play(tl)
  if tl == nil then
    Log.fatal("[EZTL] 时间线为空，不能播放")
    return
  end
  if self._tl and not self._tl:Over() then
    Log.fatal("[EZTL] 当前时间线正在播放，不能打断")
    return
  end
  if not GameSingle and not GameGlobal.GetModule(LoginModule):IsLogin() then
    Log.fatal("[EZTL] 客户端已离线，不执行播放")
    return
  end
  self.callback = GameHelper:GetInstance():CreateCallback(EZTL_Player.Stop, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.LoginReset, self.callback)
  self._tl = tl
  self._tl:Start()
  self._stopped = false
  self._taskID = GameGlobal.TaskManager():StartTask(self._Update, self)
end

function EZTL_Player:_Update(TT)
  while not self._stopped and not self._tl:Over() do
    YIELD(TT)
    if not self._stopped then
      local ms = UnityEngine.Time.deltaTime * 1000
      self._tl:Update(ms)
    end
  end
  if self.callback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.LoginReset, self.callback)
  end
end

function EZTL_Player:Stop()
  if not self._tl:Over() then
    self._tl:Stop()
    self._tl = nil
  end
  self._stopped = true
  if self.callback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.LoginReset, self.callback)
  end
end

function EZTL_Player:IsPlaying()
  if self._tl then
    return not self._tl:Over()
  end
  return false
end

_class("EZTL_Base", Object)
EZTL_Base = EZTL_Base

function EZTL_Base:Constructor()
  self._running = false
  self._des = ""
end

function EZTL_Base:Start()
end

function EZTL_Base:StartLog()
  if self._des then
    Log.debug("[EZTL] 开始时间线--->", self._des)
  end
end

function EZTL_Base:EndLog()
  if self._des then
    Log.debug("[EZTL] 结束时间线===>", self._des)
  end
end

function EZTL_Base:Stop()
  self._running = false
  self:EndLog()
end

function EZTL_Base:Update(deltaTimeMS)
end

function EZTL_Base:Over()
  return not self._running
end

_class("EZTL_Sequence", EZTL_Base)
EZTL_Sequence = EZTL_Sequence

function EZTL_Sequence:Constructor(timelines, des)
  self._timelines = timelines
  self._currentIdx = 0
  self._current = nil
  self._des = des
end

function EZTL_Sequence:Start()
  self:StartLog()
  if not self._timelines or #self._timelines == 0 then
    Log.fatal("[Timeline] sequence time line children is null")
    return
  end
  self._count = #self._timelines
  self._currentIdx = 1
  self._current = self._timelines[1]
  self._current:Start()
  self._running = true
end

function EZTL_Sequence:Update(deltaTimeMS)
  if self._running then
    self._current:Update(deltaTimeMS)
    if self._current:Over() then
      self._currentIdx = self._currentIdx + 1
      if self._currentIdx > self._count then
        self:Stop()
      else
        self._current = self._timelines[self._currentIdx]
        self._current:Start()
      end
    end
  end
end

function EZTL_Sequence:Stop()
  self._running = false
  for _, tl in ipairs(self._timelines) do
    if not tl:Over() then
      tl:Stop()
    end
  end
  self:EndLog()
end

_class("EZTL_Parallel", EZTL_Base)
EZTL_Parallel = EZTL_Parallel

function EZTL_Parallel:Constructor(timelines, endTag, endOne, des)
  self._timelines = timelines
  self._endTag = endTag or EZTL_EndTag.All
  self._endOne = endOne
  self._des = des
  self._endFunc = nil
  self._endFlag = false
  if self._endTag == EZTL_EndTag.All then
    self._endFlag = true
    
    function self._endFunc(_end1, _end2)
      return _end1 and _end2
    end
  elseif self._endTag == EZTL_EndTag.Any then
    self._endFlag = false
    
    function self._endFunc(_end1, _end2)
      return _end1 or _end2
    end
  elseif self._endTag == EZTL_EndTag.SomeOne then
    self._targetOne = self._timelines[self._endOne]
    
    function self._endFunc(_end1, _end2)
      return self._targetOne:Over()
    end
  else
    Log.fatal("[Timeline] Parallel timeline tag error：", self._endTag)
  end
end

function EZTL_Parallel:Start()
  self:StartLog()
  if not self._timelines or #self._timelines == 0 then
    Log.fatal("[Timeline] parallel time line children is null")
    return
  end
  for _, tl in ipairs(self._timelines) do
    tl:Start()
  end
  self._running = true
end

function EZTL_Parallel:Update(deltaTimeMS)
  if self._running then
    local _over = self._endFlag
    for _, tl in ipairs(self._timelines) do
      tl:Update(deltaTimeMS)
      _over = self._endFunc(_over, tl:Over())
    end
    if _over then
      self:Stop()
    end
  end
end

function EZTL_Parallel:Stop()
  self._running = false
  for _, tl in ipairs(self._timelines) do
    if not tl:Over() then
      tl:Stop()
    end
  end
  self:EndLog()
end

_class("EZTL_Wait", EZTL_Base)
EZTL_Wait = EZTL_Wait

function EZTL_Wait:Constructor(_time, des)
  self._delayTimeMS = _time
  self._timer = 0
  self._des = des
end

function EZTL_Wait:Start()
  self:StartLog()
  if self._delayTimeMS <= 0 then
    self:Stop()
    return
  end
  self._timer = 0
  self._running = true
end

function EZTL_Wait:Update(deltaTimeMS)
  if self._running then
    self._timer = self._timer + deltaTimeMS
    if self._timer >= self._delayTimeMS then
      self:Stop()
    end
  end
end

_class("EZTL_Callback", EZTL_Base)
EZTL_Callback = EZTL_Callback

function EZTL_Callback:Constructor(cb, des)
  self._callback = cb
  self._des = des
end

function EZTL_Callback:Start()
  self:StartLog()
  self._callback()
  self:Stop()
end

_class("EZTL_DOTweenMove", EZTL_Base)
EZTL_DOTweenMove = EZTL_DOTweenMove

function EZTL_DOTweenMove:Constructor(transform, endPos, duration, ease, des)
  self.transform = transform
  self.endPos = endPos
  self.duration = duration
  self.ease = ease
  self._des = des
end

function EZTL_DOTweenMove:Start()
  self:StartLog()
  self._tweener = self.transform:DOMove(self.endPos, self.duration):SetEase(self.ease):OnComplete(function()
    self:Stop()
  end)
  self._running = true
end

function EZTL_DOTweenMove:Stop()
  self._running = false
  if self._tweener:IsPlaying() then
    self._tweener:Kill()
  end
  self:EndLog()
end

_class("EZTL_DOTweenRotate", EZTL_Base)
EZTL_DOTweenRotate = EZTL_DOTweenRotate

function EZTL_DOTweenRotate:Constructor(transform, endRot, duration, ease, des)
  self.transform = transform
  self.endPos = endRot
  self.duration = duration
  self.ease = ease
  self._des = des
end

function EZTL_DOTweenRotate:Start()
  self:StartLog()
  self._tweener = self.transform:DORotate(self.endPos, self.duration, DG.Tweening.RotateMode.Fast):SetEase(self.ease):OnComplete(function()
    self:Stop()
  end)
  self._running = true
end

function EZTL_DOTweenRotate:Stop()
  self._running = false
  if self._tweener:IsPlaying() then
    self._tweener:Kill()
  end
  self:EndLog()
end

_class("EZTL_PlayAnimation", EZTL_Base)
EZTL_PlayAnimation = EZTL_PlayAnimation

function EZTL_PlayAnimation:Constructor(animation, name, des)
  self._anim = animation
  self._name = name
  self._des = des
end

function EZTL_PlayAnimation:Start()
  self:StartLog()
  self._duration = 0
  self._timer = 0
  if not self._anim then
    Log.fatal("[EZTL] Animation 组件为空，不能播放")
    return
  end
  if not self._name then
    Log.fatal("[EZTL] Animation 名称为空，不能播放")
    return
  end
  local clip = self._anim:GetClip(self._name)
  if not clip then
    Log.fatal("[EZTL] 找不到AnimationClip: ", self._name)
    return
  end
  self._duration = clip.length * 1000
  self._anim:Play(self._name)
  self._running = true
end

function EZTL_PlayAnimation:Update(deltaTimeMS)
  self._timer = self._timer + deltaTimeMS
  if self._timer >= self._duration then
    self:Stop()
  end
end

function EZTL_PlayAnimation:Stop()
  if self._running then
    self._anim:Stop()
    self._running = false
  end
  self:EndLog()
end

_class("EZTL_MatColor", EZTL_Base)
EZTL_MatColor = EZTL_MatColor

function EZTL_MatColor:Constructor(mat, propertyName, fromColor, toColor, duration, des)
  self._mat = mat
  self._propertyName = propertyName
  self._fromColor = fromColor
  self._toColor = toColor
  self._duration = duration
  self._des = des
end

function EZTL_MatColor:_setColor(color)
  self._mat:SetColor(self._propertyName, color)
end

function EZTL_MatColor:Start()
  self:_setColor(self._fromColor)
  self._timer = 0
  self._running = true
end

function EZTL_MatColor:Update(deltaTimeMS)
  if self._running then
    if self._timer > self._duration then
      self:_setColor(self._toColor)
      self:Stop()
    else
      self._timer = self._timer + deltaTimeMS
      self:_setColor(Color.Lerp(self._fromColor, self._toColor, self._timer / self._duration))
    end
  end
end

_class("EZTL_MatFloat", EZTL_Base)
EZTL_MatFloat = EZTL_MatFloat

function EZTL_MatFloat:Constructor(mat, propertyName, to, duration, des)
  self._mat = mat
  self._propertyName = propertyName
  self._from = mat:GetFloat(propertyName)
  self._to = to
  self._duration = duration
  self._des = des
end

function EZTL_MatFloat:_setValue(value)
  self._mat:SetFloat(self._propertyName, value)
end

function EZTL_MatFloat:Start()
  self._timer = 0
  self._running = true
  self:StartLog()
end

function EZTL_MatFloat:Update(deltaTimeMS)
  if self._running then
    if self._timer > self._duration then
      self:_setValue(self._to)
      self._running = false
      self:Stop()
    else
      self._timer = self._timer + deltaTimeMS
      self:_setValue(Mathf.Lerp(self._from, self._to, self._timer / self._duration))
    end
  end
end

function EZTL_MatFloat:Stop()
  if self._running then
    self._running = false
  end
  self:EndLog()
end

_class("EZTL_PlayEffect", EZTL_Base)
EZTL_PlayEffect = EZTL_PlayEffect

function EZTL_PlayEffect:Constructor(gameObject, duration, des)
  self.eft = gameObject
  self.duration = duration
  self._timer = 0
end

function EZTL_PlayEffect:Start()
  self._timer = 0
  self.eft:SetActive(true)
  self._running = true
  self:StartLog()
  if self.duration == nil then
    self._running = false
    self:EndLog()
  end
end

function EZTL_PlayEffect:Update(deltaTimeMS)
  if not self._running then
    return
  end
  if self.duration then
    self._timer = self._timer + deltaTimeMS
    if self._timer > self.duration then
      self:Stop()
    end
  end
end

function EZTL_PlayEffect:Stop()
  self._running = false
  self.eft:SetActive(false)
  self:EndLog()
end

_class("EZTL_PlayAudioOnce", EZTL_Base)
EZTL_PlayAudioOnce = EZTL_PlayAudioOnce

function EZTL_PlayAudioOnce:Constructor(audioName, des)
  self.audio = audioName
  self._des = des
end

function EZTL_PlayAudioOnce:Start()
  AudioHelperController.PlayUISoundResource(self.audio, false)
  self._running = false
  self:StartLog()
end

_class("EZTL_PlayAudioByID", EZTL_Base)
EZTL_PlayAudioByID = EZTL_PlayAudioByID

function EZTL_PlayAudioByID:Constructor(audioID, delayTime, des)
  self.audio = audioID
  self._des = des
  if delayTime and 0 < delayTime then
    self._delayTime = delayTime
  end
end

function EZTL_PlayAudioByID:Start()
  if self._delayTime then
    self._timer = 0
    self._running = true
  else
    AudioHelperController.RequestAndPlayUIVoiceAutoRelease(self.audio)
    self._running = false
  end
  self:StartLog()
end

function EZTL_PlayAudioByID:Update(deltaTimeMS)
  if self._running then
    self._timer = self._timer + deltaTimeMS
    if self._timer > self._delayTime then
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(self.audio)
      self._running = false
      self:Stop()
    end
  end
end

function EZTL_PlayAudioByID:Stop()
  if self._running then
    self._running = false
  end
  self:EndLog()
end

_class("EZTL_TweenSliderValue", EZTL_Base)
EZTL_TweenSliderValue = EZTL_TweenSliderValue

function EZTL_TweenSliderValue:Constructor(slider, from, to, duration, des)
  self._slider = slider
  self._from = from
  self._to = to
  self._duration = duration
  self._des = des
end

function EZTL_TweenSliderValue:Start()
  self:StartLog()
  self._slider.value = self._from
  self._tweener = self._slider:DOValue(self._to, self._duration, false):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self._running = false
    self:Stop()
  end)
  self._running = true
end

function EZTL_TweenSliderValue:Stop()
  if self._running then
    self._running = false
    if self._tweener:IsPlaying() then
      self._tweener:Kill()
    end
  end
  self:EndLog()
end

_class("EZTL_TextUpAnim", EZTL_Base)
EZTL_TextUpAnim = EZTL_TextUpAnim

function EZTL_TextUpAnim:Constructor(text, from, to, duration, des)
  self._text = text
  self._from = from
  self._to = to
  self._duration = duration
  self._des = des
  self._timer = 0
end

function EZTL_TextUpAnim:Start()
  self._text:SetText(self._from)
  self._running = true
  self._timer = 0
end

function EZTL_TextUpAnim:Update(deltaTimeMS)
  if self._running then
    if self._timer < self._duration then
      local cur = math.ceil(self._from + (self._to - self._from) * (self._timer / self._duration))
      self._text:SetText(cur)
      self._timer = self._timer + deltaTimeMS
    else
      self._running = false
      self:Stop()
    end
  end
end

function EZTL_TextUpAnim:Stop()
  if self._running then
    self._running = false
    self._timer = 0
  end
  self._text:SetText(self._to)
  self:EndLog()
end

_class("EZTL_RandomText", EZTL_Base)
EZTL_RandomText = EZTL_RandomText

function EZTL_RandomText:Constructor(text, content, duration, des)
  self._text = text
  self._duration = duration
  self._content = content
  self._des = des
  self._childS = string.split(self._content, " ")
  self._charLib = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
  self._libLen = #self._charLib
end

function EZTL_RandomText:Start()
  self._running = true
  self._timer = 0
  self._text:SetText(self:_random())
  self:StartLog()
end

function EZTL_RandomText:_random()
  local s = ""
  for i = 1, #self._childS do
    local child = self._childS[i]
    local c = {}
    for j = 1, #child do
      local idx = math.random(1, self._libLen)
      local code = string.byte(self._charLib, idx)
      c[#c + 1] = code
    end
    s = s .. string.char(table.unpack(c))
    if i < #self._childS then
      s = s .. " "
    end
  end
  return s
end

function EZTL_RandomText:Update(deltaTimeMS)
  if self._running then
    self._timer = self._timer + deltaTimeMS
    if self._timer > self._duration then
      self._running = false
      self:Stop()
      return
    end
    self._text:SetText(self:_random())
  end
end

function EZTL_RandomText:Stop()
  if self._running then
    self._running = false
  end
  self._text:SetText(self._content)
  self:EndLog()
end

_class("EZTL_AlphaTween", EZTL_Base)
EZTL_AlphaTween = EZTL_AlphaTween

function EZTL_AlphaTween:Constructor(graphic, target, duration, des)
  self._graphic = graphic
  self._duration = duration
  self._target = target
  self._des = des
end

function EZTL_AlphaTween:Start()
  self._running = true
  self._timer = 0
  local color = self._graphic.color
  self._r = color.r
  self._g = color.g
  self._b = color.b
  self._from = color.a
  self:StartLog()
end

function EZTL_AlphaTween:Update(deltaTimeMS)
  if self._running then
    self._timer = self._timer + deltaTimeMS
    if self._timer > self._duration then
      self._running = false
      self:Stop()
      return
    end
    local alpha = Mathf.Lerp(self._from, self._target, self._timer / self._duration)
    self._graphic.color = Color(self._r, self._g, self._b, alpha)
  end
end

function EZTL_AlphaTween:Stop()
  if self._running then
    self._running = false
  else
    self._graphic.color = Color(self._r, self._g, self._b, self._target)
  end
  self:EndLog()
end

_class("EZTL_AnchorMove", EZTL_Base)
EZTL_AnchorMove = EZTL_AnchorMove

function EZTL_AnchorMove:Constructor(rect, target, duration, des)
  self._rect = rect
  self._target = target
  self._duration = duration
  self._des = des
end

function EZTL_AnchorMove:Start()
  self._timer = 0
  self._from = self._rect.anchoredPosition
  self._running = true
  self:StartLog()
end

function EZTL_AnchorMove:Update(dt)
  if self._running then
    self._timer = self._timer + dt
    if self._timer > self._duration then
      self._running = false
      self:Stop()
    else
      self._rect.anchoredPosition = Vector2.Lerp(self._from, self._target, self._timer / self._duration)
    end
  end
end

function EZTL_AnchorMove:Stop()
  if self._running then
    self._running = false
  end
  self._rect.anchoredPosition = self._target
  self:EndLog()
end

_class("EZTL_TextUpAnimFormat", EZTL_Base)
EZTL_TextUpAnimFormat = EZTL_TextUpAnimFormat

function EZTL_TextUpAnimFormat:Constructor(text, from, to, duration, format, des)
  self._text = text
  self._from = from
  self._to = to
  self._duration = duration
  self._format = format
  self._des = des
  self._timer = 0
end

function EZTL_TextUpAnimFormat:Start()
  self._text:SetText(string.format(self._format, self._from))
  self._running = true
  self._timer = 0
end

function EZTL_TextUpAnimFormat:Update(deltaTimeMS)
  if self._running then
    if self._timer < self._duration then
      local cur = math.ceil(self._from + (self._to - self._from) * (self._timer / self._duration))
      self._text:SetText(string.format(self._format, cur))
      self._timer = self._timer + deltaTimeMS
    else
      self._running = false
      self:Stop()
    end
  end
end

function EZTL_TextUpAnimFormat:Stop()
  if self._running then
    self._running = false
    self._timer = 0
  end
  self._text:SetText(string.format(self._format, self._to))
  self:EndLog()
end

_class("EZTL_CanvasGroupAlpha", EZTL_Base)
EZTL_CanvasGroupAlpha = EZTL_CanvasGroupAlpha

function EZTL_CanvasGroupAlpha:Constructor(canvasGroup, target, duration, des)
  self._canvasGroup = canvasGroup
  self._target = target
  self._duration = duration
  self._des = des
end

function EZTL_CanvasGroupAlpha:Start()
  self:StartLog()
  self._from = self._canvasGroup.alpha
  self._running = true
  self._timer = 0
end

function EZTL_CanvasGroupAlpha:Update(dtMS)
  if self._running then
    self._timer = self._timer + dtMS
    if self._timer < self._duration then
      self._canvasGroup.alpha = Mathf.Lerp(self._from, self._target, self._timer / self._duration)
    else
      self._running = false
      self:Stop()
    end
  end
end

function EZTL_CanvasGroupAlpha:Stop()
  self:EndLog()
  if self._running then
    self._running = false
  end
  self._canvasGroup.alpha = self._target
end

_class("EZTL_LocalScale", EZTL_Base)
EZTL_LocalScale = EZTL_LocalScale

function EZTL_LocalScale:Constructor(transform, to, duration, des)
  self._transform = transform
  self._to = to
  self._duration = duration
  self._des = des
end

function EZTL_LocalScale:Start()
  self._from = self._transform.localScale.x
  self._running = true
  self._timer = 0
  self:StartLog()
end

function EZTL_LocalScale:Update(dtMS)
  if self._running and self._timer < self._duration then
    self._timer = self._timer + dtMS
    if self._timer >= self._duration then
      self._running = false
      self:Stop()
    else
      local scale = Mathf.Lerp(self._from, self._to, self._timer / self._duration)
      self._transform.localScale = Vector3.one * scale
    end
  end
end

function EZTL_LocalScale:Stop()
  if self._running then
    self._running = false
  end
  self._transform.localScale = Vector3.one * self._to
end
