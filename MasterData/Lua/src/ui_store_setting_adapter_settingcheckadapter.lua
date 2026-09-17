local this = class("settingCheckAdapter")
local _optionDataTpl = L_GameTpl:getOptionDataTpl()

function this:ctor()
end

function this:checkState(id, tempData)
  error("lua设置已废弃，如果还有在调用的@wangsongyan  调用堆栈" .. debug.traceback())
  if self[id] then
    return self[id](self, tempData)
  else
    return L_Const.settingState.none
  end
end

this[L_Const.settingType.frame] = function(self)
  local v = C_DeviceGradingManager.GetQualityValue(C_QualityConstants.VSYNC)
  if v == "True" then
    return L_Const.settingState.block
  end
  return L_Const.settingState.none
end
this[L_Const.settingType.dlss] = function(self)
  local isSupport = C_SettingUtility.IsSupportDLSS()
  if isSupport then
    return L_Const.settingState.none
  else
    return L_Const.settingState.block, L_Const.settingBlockType.hardware
  end
end
this[L_Const.settingType.dlssLevel] = function(self, tempData)
  if L_SettingStore:getSetData(L_Const.settingType.superResolution) == "1" then
    return L_Const.settingState.hide
  end
  if L_GameUtil.isUnder2K() then
    return L_Const.settingState.hide
  end
  return L_Const.settingState.none
end
this[L_Const.settingType.renderAccuracy] = function(self, tempData)
  if L_SettingStore:getSetData(L_Const.settingType.superResolution) ~= "1" then
    return L_Const.settingState.block
  end
  return L_Const.settingState.none
end
this[L_Const.settingType.superResolution] = function(self)
  return L_Const.settingState.none
end
return this
