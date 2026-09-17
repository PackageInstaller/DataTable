local fadeOut = class("fadeOut", G_UIModuleBase)

function fadeOut.bind()
  return {}
end

function fadeOut.methods()
  return {}
end

function fadeOut:open()
end

function fadeOut:doAnimation(params)
  local duration = params.duration
  local colorStr = params.colorStr
  local dataColor = C_LuaUtility.ParseHtmlStringColor("#" .. colorStr)
  local image = self.bindComponents.Image
  local aimAlpha = dataColor.a
  dataColor.a = 0
  image.color = dataColor
  self._tween = image:DOFade(aimAlpha, duration / 1000)
  
  function self._tween.onComplete()
    self:afterPlay()
  end
end

function fadeOut:doSkip()
  if self._tween then
    self._tween:Kill(true)
    self._tween = nil
  end
end

function fadeOut:dispose()
  if self._tween then
    self._tween:Kill(true)
    self._tween = nil
  end
end

function fadeOut:afterPlay()
  if self.callback then
    self.callback()
    self.callback = nil
  end
end

return fadeOut
