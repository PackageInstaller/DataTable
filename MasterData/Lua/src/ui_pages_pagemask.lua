local this = class("pageMask", G_UIPageBase)
local CALLBACK = {
  fadeIn = "fadeInCallBack",
  loadComplete = "loadCompleteCallBack",
  closed = "callback"
}

function this.bind()
  return {
    raycast = false,
    blockColor = C_Color(0, 0, 0, 1)
  }
end

function this.methods()
  return {}
end

function this:show(options)
  self:doFadeAnim(options)
end

function this:close()
  self:killAll()
  self.bindComponents.mask.alpha = 0
end

function this:DoStoryChangeState()
  printf("DoStoryChangeState")
  local halfTime = self.options.coverdTime / 3
  self.tweens.tween2 = self.bindComponents.mask:DOFade(0, halfTime):SetEase(self.options.fadeOutStyle)
  
  function self.tweens.tween2.onComplete()
    if self.options.isCompleteClose then
      self.bind.blockColor = C_Color(0, 0, 0, 1)
      L_UI:close(self.pageName)
    end
    print("-------------new story tween2 in callback--------------" .. tostring(Unity.Time.timeSinceLevelLoad))
  end
end

function this:doFadeAnim(options)
  printf("pageMask doFadeAnim")
  self:killAll()
  self.options = options or {}
  self.bind.raycast = options.raycast == true
  options.fadeInStyle = options.fadeInStyle or Tweening.Ease.Linear
  options.fadeOutStyle = options.fadeOutStyle or Tweening.Ease.Linear
  self.callMap[CALLBACK.fadeIn] = options.fadeInCallBack
  self.callMap[CALLBACK.loadComplete] = options.loadCompleteCallBack
  self.callMap[CALLBACK.closed] = options.callback
  if options.isNewStory then
    local halfTime = options.coverdTime / 3
    self.tweens.sequence = DOTween.Sequence()
    if options.isChangeColor then
      self.bind.blockColor = C_Color(1, 1, 1, 1)
    end
    self.bindComponents.mask.alpha = 1
    self.tweens.tween1 = self.bindComponents.mask:DOFade(1, halfTime):SetEase(options.fadeInStyle)
    
    function self.tweens.tween1.onComplete()
      self:triggerCallback(CALLBACK.fadeIn, L_Const.callbackType.success)
      print("new story fade in callback: " .. tostring(halfTime))
    end
    
    self.timer = Timer.once(halfTime + halfTime, function()
      self:triggerCallback(CALLBACK.loadComplete, L_Const.callbackType.success)
      print("new story loadCompleteCallBack callback: " .. tostring(halfTime))
    end, nil, self.gameObject)
    return
  end
  if options.fadeIn and options.fadeOut then
    local halfTime = options.coverdTime / 2
    self.tweens.sequence = DOTween.Sequence()
    self.bindComponents.mask.alpha = 0
    local tween1 = self.bindComponents.mask:DOFade(1, halfTime):SetEase(options.fadeInStyle)
    self.tweens.sequence:Append(tween1)
    local tween2 = self.bindComponents.mask:DOFade(0, halfTime):SetEase(options.fadeOutStyle)
    self.tweens.sequence:Append(tween2)
    
    function self.tweens.sequence.onComplete()
      self:triggerCallback(CALLBACK.closed, true)
      if options.isCompleteClose then
        L_UI:close(self.pageName)
      end
    end
    
    self.tweens.sequence:Play()
  elseif options.fadeIn then
    self.bindComponents.mask.alpha = 0
    self.tweens.tween = self.bindComponents.mask:DOFade(1, options.coverdTime):SetEase(options.fadeInStyle)
    
    function self.tweens.tween.onComplete()
      self:triggerCallback(CALLBACK.closed, true)
      if options.isCompleteClose then
        L_UI:close(self.pageName)
      end
    end
  elseif options.fadeOut then
    self.bindComponents.mask.alpha = 1
    self.tweens.tween = self.bindComponents.mask:DOFade(0, options.coverdTime):SetEase(options.fadeOutStyle)
    
    function self.tweens.tween.onComplete()
      self:triggerCallback(CALLBACK.closed, true)
      if options.isCompleteClose then
        L_UI:close(self.pageName)
      end
    end
  else
    self.bindComponents.mask.alpha = 1
    self.timer = Timer.once(options.coverdTime or 0, function()
      self:triggerCallback(CALLBACK.closed, true)
      if options.isCompleteClose then
        L_UI:close(self.pageName)
      end
    end, nil, self.gameObject)
  end
end

function this:triggerCallback(cType, ...)
  local call = self.callMap[cType]
  if call == nil then
    return
  end
  call(...)
  self.callMap[cType] = nil
end

function this:triggerAllCallback(...)
  if self.callMap then
    for key, v in pairs(self.callMap) do
      self:triggerCallback(key, ...)
    end
  end
  self.callMap = {}
end

function this:killAll()
  printf("pageMask killAll")
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.tweens then
    for _, v in pairs(self.tweens) do
      v:Kill()
    end
  end
  self.tweens = {}
  self:triggerAllCallback(L_Const.callbackType.interrupt)
end

return this
