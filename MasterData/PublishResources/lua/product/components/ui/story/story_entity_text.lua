_class("StoryEntityText", StoryEntityMovable)
StoryEntityText = StoryEntityText

function StoryEntityText:Constructor(ID, gameObject, resRequest, storyManager)
  StoryEntityText.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._txt = gameObject:GetComponent("UILocalizationText")
  self._txtColor = self._txt.color
  self._circleOutline = gameObject:GetComponent("H3D.UGUI.CircleOutline")
  self._type = StoryEntityType.Text
  self._textTotalCharCount = 0
  self._typeSpeed = 0
  self._isTyping = false
  self._typeStartTime = 0
  self._curCharIndex = 0
  self._active = false
  self._showAsTimer = false
  self._timerStr = nil
end

function StoryEntityText:_TriggerKeyframe(keyframeData)
  local languageTypeStr = self._storyManager:GetCurLanguageStr()
  local localizedKeyframeData = keyframeData
  if keyframeData.Languages and keyframeData.Languages[languageTypeStr] then
    localizedKeyframeData = keyframeData.Languages[languageTypeStr]
    localizedKeyframeData.Active = keyframeData.Active
    localizedKeyframeData.Layer = keyframeData.Layer
    localizedKeyframeData.Time = keyframeData.Time
    localizedKeyframeData.R = keyframeData.R
    localizedKeyframeData.G = keyframeData.G
    localizedKeyframeData.B = keyframeData.B
    localizedKeyframeData.Alpha = keyframeData.Alpha
    localizedKeyframeData.AlphaChange = keyframeData.AlphaChange
    localizedKeyframeData.ShowAsTimer = keyframeData.ShowAsTimer
  end
  StoryEntityText.super._TriggerKeyframe(self, localizedKeyframeData)
  if localizedKeyframeData.Active ~= nil then
    self._active = localizedKeyframeData.Active
  end
  if localizedKeyframeData.ShowAsTimer then
    self._showAsTimer = true
    self._txt.ShowCharCount = -1
    self._isTyping = false
    self:TriggerTimer()
  end
  if localizedKeyframeData.TypeText and not self._showAsTimer then
    local text = StringTable.Get(localizedKeyframeData.TypeText.TextID)
    local contentStr = self:_DoEscape(text)
    self._txt:SetText(contentStr)
    self._textTotalCharCount = self:_GetContentInfo(contentStr)
    self._txt.ShowCharCount = self._curCharIndex
    self._typeSpeed = self._textTotalCharCount / localizedKeyframeData.TypeText.Time
    self._typeStartTime = localizedKeyframeData.Time
    self._isTyping = true
  end
  if localizedKeyframeData.FontSize then
    self._txt.fontSize = localizedKeyframeData.FontSize
  end
  if localizedKeyframeData.R then
    self._txtColor.r = localizedKeyframeData.R
    self._txt.color = self._txtColor
  end
  if localizedKeyframeData.G then
    self._txtColor.g = localizedKeyframeData.G
    self._txt.color = self._txtColor
  end
  if localizedKeyframeData.B then
    self._txtColor.b = localizedKeyframeData.B
    self._txt.color = self._txtColor
  end
  if keyframeData.OutLine ~= nil then
    self._circleOutline.enabled = keyframeData.OutLine
  else
    self._circleOutline.enabled = true
  end
  if keyframeData.Shadow then
    if not self._shadow then
      self._shadow = gameObject:AddComponent(typeof(UnityEngine.UI.Shadow))
      self._shadowEffectColor = self._shadow.effectColor
    end
    self._shadowEffectColor.r = keyframeData.Shadow.R
    self._shadowEffectColor.g = keyframeData.Shadow.G
    self._shadowEffectColor.b = keyframeData.Shadow.B
    self._shadowEffectColor.a = keyframeData.Shadow.Alpha
    self._shadow.enabled = true
  elseif self._shadow then
    self._shadow.enabled = false
  end
end

function StoryEntityText:_UpdateAnimation(time)
  local res = StoryEntityText.super._UpdateAnimation(self, time)
  if self._isTyping then
    local t = time - self._typeStartTime
    local typeCharCount = math.floor(t * self._typeSpeed)
    if typeCharCount > self._textTotalCharCount then
      typeCharCount = self._textTotalCharCount
    end
    if typeCharCount > self._curCharIndex then
      self._txt.ShowCharCount = typeCharCount
      self._curCharIndex = typeCharCount
    end
    if self._curCharIndex >= self._textTotalCharCount then
      self._isTyping = false
    end
    return false
  else
    return res
  end
end

function StoryEntityText:Destroy()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
  end
  StoryEntityText.super.Destroy(self)
end

function StoryEntityText:TriggerTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
  end
  self._timerHandler = GameGlobal.Timer():AddEventTimes(0, TimerTriggerCount.Infinite, function()
    if self._timerStr == nil then
      self._timerStr = "00:00:00:00"
      self._startTime = GameGlobal:GetInstance():GetCurrentTime()
    else
      local timeSpan = GameGlobal:GetInstance():GetCurrentTime() - self._startTime
      self._timerStr = ToTimingFormat4(timeSpan)
    end
    self._txt:SetText(self._timerStr)
  end)
end

function StoryEntityText:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end

function StoryEntityText:_GetContentInfo(str)
  local plainStr = string.gsub(str, "<size=%d*>", "")
  plainStr = string.gsub(plainStr, "</size>", "")
  plainStr = string.gsub(plainStr, "<color=#%x*>", "")
  plainStr = string.gsub(plainStr, "</color>", "")
  local charCount = 0
  for uchar in string.gmatch(plainStr, "[%z\001-\127Â-ô][€-¿]*") do
    charCount = charCount + 1
  end
  return charCount
end

function StoryEntityText:_SetAlpha(alpha)
  self._txtColor.a = alpha
  self._txt.color = self._txtColor
end
