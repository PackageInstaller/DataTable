local fadeIn = class("fadeIn", G_UIModuleBase)

function fadeIn.bind()
  return {}
end

function fadeIn.methods()
  return {}
end

function fadeIn:open()
end

function fadeIn:doAnimation(params)
  self._params = params
  local duration = params.duration
  local colorStr = params.colorStr
  local dataColor = C_LuaUtility.ParseHtmlStringColor("#" .. colorStr)
  local image = self.bindComponents.Image
  image.color = dataColor
  self._tween = image:DOFade(0, duration / 1000)
  
  function self._tween.onComplete()
    self:afterPlay()
  end
end

function fadeIn:doSkip()
  if self._tween then
    self._tween:Kill(true)
    self._tween = nil
  end
end

function fadeIn:dispose()
  printf("释放")
  if self._tween then
    self._tween:Kill(true)
    self._tween = nil
  end
end

function fadeIn:afterPlay()
  if self.callback then
    self.callback()
    self.callback = nil
  end
end

return fadeIn
