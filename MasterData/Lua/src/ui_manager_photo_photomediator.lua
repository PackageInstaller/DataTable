local this = L_DoubleBindUtil.createCls("photoMediator")
local _paramTpl = L_GameTpl:getPhotographParamTpl()

function this:ctor()
  self.takeMode = L_Const.photoTakeMode.normal
  self.bevMode = L_Const.photoBevMode.capture
  self.isViewLine = false
  self.isGrid = false
  self.isUI = true
  self.isMenu = false
  self.isPetAction = false
  self.photoFilter = nil
  self.playActionId = nil
  self.playFaceActionId = nil
  self.playActionPer = nil
  self.colorSettingId = nil
  self.setting = {}
  self.paramDic = {}
  self.target = nil
  self.hudSwitch = require("ui.manager.photo.entityHudSwitch").new()
end

function this:setSetting(id, val)
  self.setting[id] = val
end

function this:revertSetting()
  for id, v in pairs(self.setting) do
    local tpl = _paramTpl:getTplById(id)
    local default = _paramTpl:getParam(tpl)
    self.setting[id] = default
  end
  self.setting = {}
end

function this:getSettingOrDefault(id)
  local val = self.setting[id]
  if val == nil then
    local tpl = _paramTpl:getTplById(id)
    val = _paramTpl:getParam(tpl)
  end
  return val
end

function this:setPrefsBool(key, val)
  local key = string.format("photo_%s_%d", key, L_PlayerStore:getPlayerId())
  L_SettingStore:setPrefsBool(key, val)
end

function this:getPrefsBool(key)
  local key = string.format("photo_%s_%d", key, L_PlayerStore:getPlayerId())
  return L_SettingStore:getPrefsBool(key)
end

function this:onDestroy()
  self.hudSwitch:destroy()
  self:clearHandlers()
  self:revertSetting()
  self.paramDic = {}
  self.cacheRateVal = nil
  self:setLightSetting(nil)
  if self.lightParam ~= nil then
    self.lightParam:clear()
    self.lightParam = nil
  end
  self.lightArrangeData = nil
end

function this:setPhotoParmVal(id, val)
  local filter = self.photoFilter
  if id == L_Const.photoParam.wideIntensity then
    local tactics = C_CameraManager.GetTactics(C_ECameraType.Photo)
    tactics:SetCameraFov(val)
  elseif id == L_Const.photoParam.dof then
    filter.enableDof = 0 < val
    filter.dofIntensity = val
  elseif id == L_Const.photoParam.softlightIntensity then
    filter.softlightIntensity = val
  elseif id == L_Const.photoParam.vignetteIntensity then
    filter.vignetteIntensity = val
  elseif id == L_Const.photoParam.grainIntensity then
    filter.grainIntensity = val
  elseif id == L_Const.photoParam.rotation then
    local target = C_EntityManager.ControllingEntity
    local rot = L_PlayerManager:getMainControlEntityRot()
    rot.y = val
    target.entity:SetAngles(rot)
  elseif id == L_Const.photoParam.rate then
    local controller = C_CameraManager.GetTactics(C_ECameraType.Photo)
    if val == 0 then
      controller:RefreshRotation(0, true)
    else
      local diff = val - self:getPhotoParmDefaultVal(id)
      controller:RefreshRotation(diff)
    end
    self.cacheRateVal = val
  end
  self.paramDic[id] = val
end

function this:getPhotoParmVal(id)
  local val
  local filter = self.photoFilter
  if id == L_Const.photoParam.wideIntensity then
    local tactics = C_CameraManager.GetTactics(C_ECameraType.Photo)
    val = tactics:GetCameraFov()
  elseif id == L_Const.photoParam.dof then
    val = filter.enableDof and filter.dofIntensity or 0
  elseif id == L_Const.photoParam.softlightIntensity then
    val = filter.softlightIntensity
  elseif id == L_Const.photoParam.vignetteIntensity then
    val = filter.vignetteIntensity
  elseif id == L_Const.photoParam.grainIntensity then
    val = filter.grainIntensity
  elseif id == L_Const.photoParam.rotation then
    val = L_PlayerManager:getMainControlEntityRot().y or 0
  elseif id == L_Const.photoParam.rate then
    val = self.cacheRateVal or 0
  end
  return val
end

function this:getPhotoParmList()
  if not self.parmValIdDict then
    self.parmValIdDict = {
      [L_Const.photoParam.wideIntensity] = true,
      [L_Const.photoParam.dof] = true,
      [L_Const.photoParam.softlightIntensity] = true,
      [L_Const.photoParam.vignetteIntensity] = true,
      [L_Const.photoParam.grainIntensity] = true,
      [L_Const.photoParam.rate] = true
    }
  end
  local list = {}
  for id, _ in pairs(self.parmValIdDict) do
    local val = self:getPhotoParmVal(id)
    table.insert(list, id)
    table.insert(list, val)
  end
  return list
end

function this:getPhotoParmDefaultVal(id)
  local tpl = _paramTpl:getTplById(id)
  return tpl and _paramTpl:getParam(tpl) or 0
end

function this:setLightSetting(lightData)
  self.globalLightData = lightData
  local _UseFakeLightColor = C_Shader.PropertyToID("_UseFakeLightColor")
  if lightData == nil then
    self.globalLightData = nil
    C_Shader.SetGlobalInt(_UseFakeLightColor, 0)
    return
  end
  C_Shader.SetGlobalInt(_UseFakeLightColor, 1)
  local _FakeLightColor = C_Shader.PropertyToID("_FakeLightColor")
  C_Shader.SetGlobalColor(_FakeLightColor, lightData.color * lightData.intensity)
end

function this:getLightSettingData()
  if self.globalLightData == nil then
    self.globalLightData = require("ui.pages.photo.submodule.globalLightData").new()
  end
  return self.globalLightData
end

function this:getLightParam()
  if self.lightParam == nil then
    self.lightParam = require("ui.pages.photo.submodule.lightParamController").new()
  end
  return self.lightParam
end

function this:setLightParam(id, val, dontApply)
  if self.lightParam == nil then
    self.lightParam = require("ui.pages.photo.submodule.lightParamController").new()
  end
  self.lightParam:setParam(id, val)
  if not dontApply then
    self.lightParam:applyParam()
  end
end

return this
