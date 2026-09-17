local flashScreen = class("flashScreen", G_UIModuleBase)

function flashScreen.bind()
  return {}
end

function flashScreen.methods()
  return {}
end

function flashScreen:open()
end

function flashScreen:doAnimation(params)
  local duration = params.duration
  local colorStr = params.colorStr
  local dataColor = C_LuaUtility.ParseHtmlStringColor(colorStr)
  local image = self.bindComponents.Image
  image.color = dataColor
  image.gameObject:SetActive(true)
  self._timer = Timer.once(duration / 1000, function()
    image.gameObject:SetActive(false)
    self:afterPlay()
  end, nil, image)
end

function flashScreen:doSkip()
  if self._timer then
    self._timer:stop()
    self._timer = nil
  end
  local image = self.bindComponents.Image
  image.gameObject:SetActive(false)
end

function flashScreen:dispose()
  if self._timer then
    self._timer:stop()
    self._timer = nil
  end
end

function flashScreen:afterPlay()
  if self.callback then
    self.callback()
    self.callback = nil
  end
end

return flashScreen
