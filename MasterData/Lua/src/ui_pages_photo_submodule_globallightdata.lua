local this = class("globalLightData", require("ui.pages.photo.submodule.lightDataBase"))

function this:ctor()
  self.super.ctor(self)
  local tpl = self.paramTpl:getTplById(L_Const.photoParam.globalLightIntensity)
  self.tpl = tpl
  self.intensity = tonumber(tpl.param) or 0
  self.default = self.intensity
end

function this:getRangeLimit()
end

function this:getIntensityLimit()
  local min = self.paramTpl:getParamMin(self.tpl)
  local max = self.paramTpl:getParamMax(self.tpl)
  return min, max
end

function this:reset()
  self.color = C_Color.white
  self.intensity = self.default
end

function this:setColor(color)
  this.super.setColor(self, color)
end

function this:setIntensity(intensity)
  this.super.setIntensity(self, intensity)
end

function this:setRange(range)
  this.super.setRange(self, range)
end

return this
