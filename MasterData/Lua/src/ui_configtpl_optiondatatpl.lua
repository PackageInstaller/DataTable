local this = class("optionDataTpl")

function this:init(config)
  self.data = config
  local strGrade = tostring(C_DeviceGradingManager.deviceGrade)
  local imageData = string.split(strGrade, ":")
  self.globalImageSet = tostring(tonumber(imageData[2]) + 1)
end

function this:getConfig()
  return self.data
end

function this:getActiveConfig(equipType)
  local list = table.findAll(self.data, function(v)
    local equipList = self:getClientType(v)
    local exist = self:getIsActive(v)
    if exist then
      local support = false
      for _, equipId in ipairs(equipList) do
        if equipType == equipId then
          support = true
          break
        end
      end
      exist = exist and support
    end
    return exist
  end)
  return list
end

function this:getTplById(id)
  return self.data[id]
end

function this:getOptionclassification1(tpl)
  return tpl.optionclassification1
end

function this:getOptionclassification2Name(tpl)
  return L_Config:provider(tpl.optionclassification2Name)
end

function this:getOptionType(tpl)
  return tpl.optionType
end

function this:getOptionPara4(tpl)
  return L_Config:provider(tpl.optionPara4)
end

function this:getId(tpl)
  return tpl.id
end

function this:getOptionName(tpl)
  return L_Config:provider(tpl.optionName)
end

function this:getChangeImmediately(tpl)
  return tpl.changeImmediately == 1
end

function this:getAllowChange(tpl)
  return tpl.allowChange == 1
end

function this:getOptionPara6(tpl)
  if L_DeviceTpl:getIsMobile() then
    return tpl.optionPara6mobile
  else
    return tpl.optionPara6
  end
end

function this:getOptionPara2(tpl)
  return tpl.optionPara2
end

function this:getOptionclassification2(tpl)
  return tpl.optionclassification2
end

function this:getClientType(tpl)
  return tpl.clientType
end

function this:getFunctionId(tpl)
  return tpl.functionId
end

function this:getIsActive(tpl)
  return tpl.isActive == 1
end

function this:getDefaultPara(tpl, settingStore)
  local id = tpl.id
  local data
  if id == L_Const.settingType.image then
    data = self.globalImageSet
  elseif id == L_Const.settingType.resolution then
    settingStore = settingStore or L_SettingStore
    data = settingStore:getResolutionData()
  elseif id == L_Const.settingType.windowMode then
    settingStore = settingStore or L_SettingStore
    data = settingStore:getWindowMode()
  elseif id == L_Const.settingType.mute then
    data = self:getDefaultMute(tpl.defaultPara)
  elseif id >= L_Const.settingType.renderSet and id <= L_Const.settingType.antiAliasing then
    data = tpl.defaultPara
  elseif tpl.optionType == L_Const.optionType.toggle then
    local default = tpl.defaultPara
    data = tpl.defaultPara
    if default == "1" then
      data = "false"
    elseif default == "2" then
      data = "true"
    end
  elseif id == L_Const.settingType.superResolution then
    local SuperRes = L_Const.superResolutionType
    local SuperResConfig = {
      NVIDIA = {
        supported = SuperRes.dlss,
        notSupported = SuperRes.fsr
      },
      Amd = {
        supported = SuperRes.fsr,
        notSupported = SuperRes.xess
      },
      Intel = {
        supported = SuperRes.xess,
        notSupported = SuperRes.fsr
      },
      Apple = {
        supported = SuperRes.close,
        notSupported = SuperRes.close
      },
      CPU = {
        supported = SuperRes.fsr,
        notSupported = SuperRes.close
      }
    }
    local deviceType = C_SettingUtility.GetGPUMainfacter()
    local config = SuperResConfig[deviceType] or SuperResConfig.CPU
    local isSupported = false
    if deviceType == "NVIDIA" then
      isSupported = C_SettingUtility.IsSupportDLSS()
    elseif deviceType == "Intel" then
      isSupported = C_SettingUtility.IsSupportXeSS()
    elseif deviceType == "AMD" then
      isSupported = true
    elseif deviceType == "Apple" then
      isSupported = true
    else
      isSupported = C_SettingUtility.IsIntegratedGPU()
    end
    if isSupported then
      data = tostring(config.supported)
    else
      data = tostring(config.notSupported)
    end
  elseif id == L_Const.settingType.language then
    data = L_Const.settingText:GetParamIdx(L_Const.settingType.language, CS.Lens.Framework.Managers.AppConfigManager.Language)
  elseif id == L_Const.settingType.textureQuality then
    local deviceMemory = Unity.SystemInfo.systemMemorySize
    local deviceGraphicsMemory = Unity.SystemInfo.graphicsMemorySize
    if deviceMemory <= L_Const.textureQualityLevel.Memory or deviceGraphicsMemory <= L_Const.textureQualityLevel.GraphicsMemory then
      data = "1"
    else
      data = "2"
    end
  elseif id == L_Const.settingType.antiAliasing and L_DeviceTpl:getIsMobile() then
    data = 2
  elseif id == L_Const.settingType.frame then
    if L_DeviceTpl:getIsPc() then
      data = tpl.defaultPara
    else
      data = "1"
    end
  else
    data = tpl.defaultPara
  end
  return data
end

function this:getDefaultResultionId(width, height)
  local displayTpl = L_GameTpl:getOptionDataDisplayTpl()
  local list = displayTpl:getConfig()
  local tpl
  for i = #list, 1, -1 do
    local t = list[i]
    local csvWidth = displayTpl:getHorizontalPixels(t)
    local csvHeigth = displayTpl:getVerticalPixels(t)
    if width <= csvWidth or height <= csvHeigth then
      tpl = t
      break
    end
  end
  return tpl and displayTpl:getId(tpl) or 1
end

function this:getDefaultMute(str)
  if str == "1" then
    return "true"
  else
    return "false"
  end
end

return this
