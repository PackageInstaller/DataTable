local this = class("settingAdapter_mobile", require(L_R.store .. "setting.adapter.settingAdapter"))

function this:ctor()
  C_InputManager.InitializeMobileMode()
end

this[L_Const.settingType.image] = function(self, value)
  local v = tonumber(value) or 1
  C_DeviceGradingManager.SetQualityLevel(v - 1)
  if 2 <= v and L_PlayerStore.data and L_PlayerStore.data.baseInfo then
    local playerId = L_PlayerStore:getPlayerId()
    C_PlayerPrefsUtility.SetInt(string.format(L_Const.prefsKey.lastImageSetting, playerId), v)
  end
  if v <= 1 and L_PlayerStore.data and L_PlayerStore.data.baseInfo then
    local playerId = L_PlayerStore:getPlayerId()
    local key = string.format(L_Const.prefsKey.lastImageSetting, playerId)
    local has = C_PlayerPrefsUtility.HasKey(key)
    if has then
      local res = C_PlayerPrefsUtility.GetInt(key)
      if res ~= 0 and 1 < res then
        C_DeviceGradingManager.SetQualityLevel(res - 1)
      end
    end
  end
end
this[L_Const.settingType.specialEffects] = function(self, value)
  self:setQualityValue(value, L_Const.settingType_Effects_mobile)
end
this[L_Const.settingType.resolution] = function(self, value)
end
this[L_Const.settingType.image] = function(self, value)
  C_DeviceGradingManager.SetQualityLevel(tonumber(value) - 1)
end
this[L_Const.settingType.vSync] = function(self, value)
end
this[L_Const.settingType.physicalPush] = function(self, value)
  C_AppMessageFeedManager.Instance:SetStaminaFeedDefaultLoginActive(value)
end
this[L_Const.settingType.antiAliasing] = function(self, value)
  value = tostring(value)
  local val
  if value == "1" then
    val = "0"
  elseif value == "2" then
    val = "1"
  elseif value == "3" then
    val = "2"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.ANTIALIASING, val)
  end
end
this[L_Const.settingType.shadowType] = function(self, value)
  value = tostring(value)
  local val
  if value == "1" then
    val = "3"
  elseif value == "2" then
    val = "2"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.SHADOW_TYPE, val)
  end
end
return this
