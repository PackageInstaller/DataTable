local this = class("settingAdapter_pc", require(L_R.store .. "setting.adapter.settingAdapter"))

function this:ctor()
  C_InputManager.InitializePCMode()
end

this[L_Const.settingType.resolution] = function(self, id)
end
this[L_Const.settingType.renderSet] = function(self, value)
  self:setQualityValue(value, L_Const.settingType_Render_pc)
end
this[L_Const.settingType.dlss] = function(self, value)
end
this[L_Const.settingType.dlssLevel] = function(self, value)
  if L_SettingStore.checkAdapter:checkState(L_Const.settingType.dlssLevel) == L_Const.settingState.none and L_SettingStore:getSetData(L_Const.settingType.superResolution) ~= tostring(1) then
    local v = L_Const.dlssLevel[tostring(value)]
    if L_GameUtil.isUnder2K() then
      C_DeviceGradingManager.SetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE, "1")
    else
      C_DeviceGradingManager.SetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE, v)
    end
  end
end
this[L_Const.settingType.superResolution] = function(self, value)
  local n = tonumber(value)
  if n == L_Const.superResolutionType.close then
    L_SettingStore:openSuperResolution(L_Const.superResolutionType.close)
  elseif n == L_Const.superResolutionType.dlss then
    if L_SettingStore.checkAdapter:checkState(L_Const.settingType.dlss) ~= L_Const.settingState.none then
      L_SettingStore.data.cache[L_Const.settingType.superResolution] = tostring(L_Const.superResolutionType.fsr)
      L_SettingStore:openSuperResolution(L_Const.superResolutionType.fsr)
    else
      L_SettingStore:openSuperResolution(L_Const.superResolutionType.dlss)
    end
  elseif n == L_Const.superResolutionType.fsr then
    L_SettingStore:openSuperResolution(L_Const.superResolutionType.fsr)
  elseif n == L_Const.superResolutionType.xess then
    L_SettingStore:openSuperResolution(L_Const.superResolutionType.xess)
  end
  if n == L_Const.superResolutionType.close then
    local ac = L_SettingStore:getSetData(L_Const.settingType.renderAccuracy)
    self[L_Const.settingType.renderAccuracy](self, ac or 100)
  elseif L_GameUtil.isUnder2K() then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE, "1")
  else
    local level = L_SettingStore:getSetData(L_Const.settingType.dlssLevel)
    local levelStr = L_Const.dlssLevel[tostring(level)]
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE, levelStr)
  end
end
this[L_Const.settingType.antiAliasing] = function(self, value)
  value = tostring(value)
  local val
  if value == "1" then
    val = "0"
  elseif value == "2" then
    val = "2"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.ANTIALIASING, val)
  end
end
return this
