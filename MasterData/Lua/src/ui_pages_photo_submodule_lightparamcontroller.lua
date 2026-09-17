local this = class("lightParamController")
local _PhotoMode = C_Shader.PropertyToID("_PhotoMode")
local _CharSkinSpecularIntensity = C_Shader.PropertyToID("_CharSkinSpecularIntensity")
local _CharLightIntensity = C_Shader.PropertyToID("_CharLightIntensity")

function this:ctor()
  self.params = {}
  self.charLightIntensity = 0
  self.params[L_Const.photoParam.charLightIntensity] = 0
  self.charSkinSpecular = 0
  self.params[L_Const.photoParam.charSkinSpecular] = 0
end

function this:setParam(id, val)
  if id == L_Const.photoParam.charLightIntensity then
    self.charLightIntensity = val
    self.params[L_Const.photoParam.charLightIntensity] = val
  elseif id == L_Const.photoParam.charSkinSpecular then
    self.charSkinSpecular = val
    self.params[L_Const.photoParam.charSkinSpecular] = val
  end
end

function this:applyParam()
  C_Shader.SetGlobalInt(_PhotoMode, 1)
  C_Shader.SetGlobalFloat(_CharSkinSpecularIntensity, self.charSkinSpecular)
  C_Shader.SetGlobalFloat(_CharLightIntensity, self.charLightIntensity)
end

function this:clear()
  self.params = nil
  self.charLightIntensity = 0
  self.charSkinSpecular = 0
  C_Shader.SetGlobalInt(_PhotoMode, 0)
  C_Shader.SetGlobalFloat(_CharSkinSpecularIntensity, 0)
  C_Shader.SetGlobalFloat(_CharLightIntensity, 0)
end

function this:reset()
  self.charLightIntensity = 0
  self.params[L_Const.photoParam.charLightIntensity] = 0
  self.charSkinSpecular = 0
  self.params[L_Const.photoParam.charSkinSpecular] = 0
  self:applyParam()
end

return this
