local this = class("lightDataBase")

function this:ctor()
  self.color = C_Color.white
  self.range = 10
  self.intensity = 1
  self.isOn = true
  self.paramTpl = L_GameTpl:getPhotographParamTpl()
end

function this:setColorHex(hex)
  local r, c = C_ColorUtility.TryParseHtmlString(hex)
  if r then
    self.color = c
  end
  return r
end

function this:setColor(color)
  self.color = color
end

function this:setRange(range)
  self.range = range
end

function this:setIntensity(intensity)
  self.intensity = intensity
end

function this:getColorHex()
  return C_ColorUtility.ToHtmlStringRGB(self.color)
end

function this:reset()
  self.color = C_Color.white
  self.range = 10
  self.intensity = 1
end

function this:getRangeLimit()
  return 0, 100
end

function this:getIntensityLimit()
  return 0, 100
end

return this
