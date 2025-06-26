--这是一个系统设置画质的管理器的类哦

module("systemSetting.SystemSettingManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self.PlayerPrefs_Key = "SystemSetting_" --前缀key

    self:__init()
end

-- 析构函数
function dtor(self)

end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    sdk.SdkManager:addEventListener(sdk.SdkManager.DEVICE_DP_CHANGE, self.updateQuality, self)

    -- 设备画质默认适配配置
    self.mDeviceQualityList = nil

    self.mSettingValueDic = {} --系统存储数据
    self.mCacheSettingValueDic = {} --临时缓存数据
    -- 设备刘海高度（0没有）(28为美术效果预留，刘海屏按实际刘海减去预留就可以刘海贴边)
    self.mNotchHeight = math.max(gs.DeviceInfoMgr.GetNotchHeigt() - 28, 0)

    self:loadPlayerPrefsSystemSetting()

    --音效默认开启
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.totalVolume] == nil then
        self:setSystemSettingValue(systemSetting.SystemSettingDefine.totalVolume, 100)
    end
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.musicVolume] == nil then
        self:setSystemSettingValue(systemSetting.SystemSettingDefine.musicVolume, 100)
    end
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.voiceVolume] == nil then
        self:setSystemSettingValue(systemSetting.SystemSettingDefine.voiceVolume, 100)
    end
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.soundEffectVolume] == nil then
        self:setSystemSettingValue(systemSetting.SystemSettingDefine.soundEffectVolume, 100)
    end

    if self.mSettingValueDic[systemSetting.SystemSettingDefine.totalVolumeSwitch] == nil then
        self:setSystemSettingBoolValue(systemSetting.SystemSettingDefine.totalVolumeSwitch, true)
    end
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.musicVolumeSwitch] == nil then
        self:setSystemSettingBoolValue(systemSetting.SystemSettingDefine.musicVolumeSwitch, true)
    end
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.voiceVolumeSwitch] == nil then
        self:setSystemSettingBoolValue(systemSetting.SystemSettingDefine.voiceVolumeSwitch, true)
    end
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.soundEffectVolumeSwitch] == nil then
        self:setSystemSettingBoolValue(systemSetting.SystemSettingDefine.soundEffectVolumeSwitch, true)
    end
    --默认开始自动UI适应
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.notch_Auto] == nil then
        self:setSystemSettingBoolValue(systemSetting.SystemSettingDefine.notch_Auto, true)
    end

    --默认开始高画质
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.pictureQuality] == nil then
        self:setSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality, 3)
    end

    --默认开启陀螺仪
    if self.mSettingValueDic[systemSetting.SystemSettingDefine.gyro] == nil then
        self:setSystemSettingBoolValue(systemSetting.SystemSettingDefine.gyro, true)
    end

    -- if not gs.Application.isMobilePlatform then
    --     local windowResolution = self.mSettingValueDic[systemSetting.SystemSettingDefine.windowResolution]
    --     if windowResolution == nil or windowResolution == 0 then
    --         self:setSystemSettingValue(systemSetting.SystemSettingDefine.windowResolution, 3)
    --     end
    -- end

    self:applyAllSetting(self.mSettingValueDic)
end

function getPlayerPrefsKey(self, defineType)
    return self.PlayerPrefs_Key .. defineType
end

function getPlayerPrefsValue(self, defineType)
    return gs.StorageUtil.GetFloat(self:getPlayerPrefsKey(defineType))
end

---加载本地系统设置
function loadPlayerPrefsSystemSetting(self)
    for _, key in pairs(systemSetting.SystemSettingDefine) do
        local strKey = self:getPlayerPrefsKey(key)
        if gs.StorageUtil.HasKey(strKey) then
            local value = self:getPlayerPrefsValue(key)
            self.mSettingValueDic[key] = value
        end
    end
end

--设置系统设置的值 (同时保存到本地)
function setSystemSettingValue(self, key, value)
    self.mSettingValueDic[key] = value
    self.mCacheSettingValueDic[key] = value
    gs.StorageUtil.SaveFloat(self:getPlayerPrefsKey(key), value)

    if key == systemSetting.SystemSettingDefine.quality or key == systemSetting.SystemSettingDefine.pictureQuality then
        GameDispatcher:dispatchEvent(EventName.SYSTEM_QUALITY_UPDATE)
    end
end

--获取参数值(lua计数 1 2 3,开光2为开 其他为关)
function getSystemSettingValue(self, key)
    if key == systemSetting.SystemSettingDefine.effect then 
        return 3
    end
    --自定义画质，取系统缓存。不是自定义画质，取配置(非自定义)。自定义取缓存(取不到缓存，拿上次画质的参数)
    if not self:getCurQualityIsCustom() then
        local curQualityConfig = self:getSystemQualitySettingVo(self.mSettingValueDic[systemSetting.SystemSettingDefine.pictureQuality])
        if curQualityConfig and curQualityConfig[key] ~= nil then
            return curQualityConfig[key]
        end
    end
    return self.mSettingValueDic[key] or 0
end

--是否设置过自定义画质
function isSetingQuality(self)
    return self.mSettingValueDic[systemSetting.SystemSettingDefine.frameCount] ~= nil
end

--设置bool值
function setSystemSettingBoolValue(self, key, value)
    local boolIndex = value and 2 or 1
    self:setSystemSettingValue(key, boolIndex)
end

---获取bool值
function getSystemSettingBoolValue(self, key)
    return self:getIsOpen(self:getSystemSettingValue(key))
end

function getIsOpen(self,value)
    return value == 2
end

--保存系统设置到本地(统一保存到本地)
function savePlayerPrefsSystemSetting(self)
    for key, value in pairs(self.mSettingValueDic) do
        gs.StorageUtil.SaveFloat(self:getPlayerPrefsKey(key), value)
    end

    self:applyAllSetting(self.mCacheSettingValueDic)
    self.mCacheSettingValueDic = {}
end

--生效设置参数
function applyAllSetting(self, settingDic)
    local isCustomQuality = self:getCurQualityIsCustom()
    local isChangeQuality = settingDic[systemSetting.SystemSettingDefine.pictureQuality] ~= nil

    --如果改变过画质的话
    if isChangeQuality then
        ---如果当前画质是自定义画质的话，生效改变的画质
        if not isCustomQuality then
            for i = 2, #systemSetting.QualitySettingDrop do
                local key = systemSetting.QualitySettingDrop[i].key
                local val = self:getSystemSettingValue(key)
                self:applySetting(key, val)
            end
        end
    end

    for key, val in pairs(settingDic) do
        self:applySetting(key, val)
    end
end

--设置帧数
function setFrameCount(self,frameCount)
    if not frameCount then 
        local label = self:getQualityLabelValue(systemSetting.SystemSettingDefine.frameCount)
        local value = self:getSystemSettingValue(systemSetting.SystemSettingDefine.frameCount)
        frameCount = tonumber(label[value])
    end
    gs.Application.targetFrameRate = frameCount
end

--设置垂直同步
function setVSyns(self)
    local vSyncCount = 0
    -- if value == 2 then
    --     local curFrameCount = self:getSystemSettingValue(systemSetting.SystemSettingDefine.frameCount)
    --     if curFrameCount == 1 then
    --         vSyncCount = 2
    --     else
    --         vSyncCount = 1
    --     end
    -- end
    gs.QualitySettingsUtil.SetVSyncCount(vSyncCount)
end

--生效单个参数设置，value为空，生效本地缓存的值
function applySetting(self, key, value)
    if value == nil then value = self:getSystemSettingValue(key) end

    if key == systemSetting.SystemSettingDefine.pictureQuality then
        for i=2,#systemSetting.QualitySettingDrop do
            local k = systemSetting.QualitySettingDrop[i].key
            local val = self:getSystemSettingValue(k)
            self:applySetting(k,val)
        end
    elseif key == systemSetting.SystemSettingDefine.frameCount then
        self:setFrameCount()
        self:setVSyns()
    elseif key == systemSetting.SystemSettingDefine.vSyns then
        self:setFrameCount()
        self:setVSyns()
    elseif key == systemSetting.SystemSettingDefine.windowResolution then
        if not gs.Application.isMobilePlatform then
            local resolutions = self:getAllwindowResolution()
            if not resolutions[value] then 
                value = 1
            end

            local isFull = false
            if value == 1 then 
                isFull = true
            end

            gs.Screen.SetResolution(resolutions[value].width, resolutions[value].height, isFull)
            self:setFrameCount()
            self:updateQuality()

            GameDispatcher:dispatchEvent(EventName.SYSTEM_WINDOWRESOLUTION_UPDATE)
        end
    elseif key == systemSetting.SystemSettingDefine.quality then
        self:setQuality(value)
    elseif key == systemSetting.SystemSettingDefine.shadow then
        gs.QualitySettingsUtil.SetShadowResolution(value - 1)
   
    elseif key == systemSetting.SystemSettingDefine.anti_Aliasing then
        local post1, post2 = self:GetCameraPostProcessing()
        if post1 then
            post1.FXAA3Toggle = self:getIsOpen(value)
        end
        if post2 then
            post2.FXAA3Toggle = self:getIsOpen(value)
        end
    
    elseif key == systemSetting.SystemSettingDefine.bloom then
        local post1, post2 = self:GetCameraPostProcessing()
        if post1 then
            post1.BloomToggle = self:getIsOpen(value)
        end
        if post2 then
            post2.BloomToggle = self:getIsOpen(value)
        end
    elseif key == systemSetting.SystemSettingDefine.dispersion then
        local post1, post2 = self:GetCameraPostProcessing()
        if post1 then
            post1.QualityChromaticAberrationToggle = self:getIsOpen(value)
        end
        if post2 then
            post2.QualityChromaticAberrationToggle = self:getIsOpen(value)
        end
    elseif key == systemSetting.SystemSettingDefine.radial_Blur then
        local post1, post2 = self:GetCameraPostProcessing()
        if post1 then
            post1.QualityRadialBlurToggle = self:getIsOpen(value)
        end
        if post2 then
            post2.QualityRadialBlurToggle = self:getIsOpen(value)
        end
    elseif key == systemSetting.SystemSettingDefine.special_effect_distortion then
        local post1, post2 = self:GetCameraPostProcessing()
        if post1 then
            post1.NoiseToggle = self:getIsOpen(value)
        end
        if post2 then
            post2.NoiseToggle = self:getIsOpen(value)
        end
    elseif key == systemSetting.SystemSettingDefine.post_processing then
        local post1, post2 = self:GetCameraPostProcessing()
        if post1 then
            post1.PostProcessToggle = self:getIsOpen(value)
        end
        if post2 then
            post2.PostProcessToggle = self:getIsOpen(value)
        end
    -- elseif key == systemSetting.SystemSettingDefine.subsurface_Scattering then
    -- elseif key == systemSetting.SystemSettingDefine.anisotropic_filtering then
    -- elseif key == systemSetting.SystemSettingDefine.later_Effect then
    -- elseif key == systemSetting.SystemSettingDefine.effect then
    -- elseif key == systemSetting.SystemSettingDefine.screen then
    -- elseif key == systemSetting.SystemSettingDefine.fog then
    elseif key == systemSetting.SystemSettingDefine.reflection then
        if self.reflectionComponent == nil or gs.GoUtil.IsCompNull(self.reflectionComponent) then 
            local reflectionNode = gs.GameObject.Find("ReflectionPlane")
            if reflectionNode then
                self.reflectionComponent = reflectionNode:GetComponent(ty.ReflectionTexture)
            end
        end
        if self.reflectionComponent ~= nil and not gs.GoUtil.IsCompNull(self.reflectionComponent) then
            local switch = self:getIsOpen(value)
            self.reflectionComponent.enabled = switch
        end
    -- elseif key == systemSetting.SystemSettingDefine.dynamic_fuzzy then
    elseif key == systemSetting.SystemSettingDefine.notch_Auto or key == systemSetting.SystemSettingDefine.notch_Value then
        GameDispatcher:dispatchEvent(EventName.SYSTEM_SETTING_NOTCH_CHANGE)
    elseif key == systemSetting.SystemSettingDefine.totalVolume then
        local switch = self:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.totalVolumeSwitch)
        if switch then
            AudioManager:setTotalVolume(value / 100)
        else
            AudioManager:setTotalVolume(0)
        end
    elseif key == systemSetting.SystemSettingDefine.musicVolume then
        local switch = self:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.musicVolumeSwitch)
        if switch then
            AudioManager:setMusicVolume(value / 100)
        else
            AudioManager:setMusicVolume(0)
        end
    elseif key == systemSetting.SystemSettingDefine.voiceVolume then
        local switch = self:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.voiceVolumeSwitch)
        if switch then
            AudioManager:setCvVolume(value / 100)
        else
            AudioManager:setCvVolume(0)
        end
    elseif key == systemSetting.SystemSettingDefine.soundEffectVolume then
        local switch = self:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.soundEffectVolumeSwitch)
        if switch then
            AudioManager:setSoundEffectVolume(value / 100)
        else
            AudioManager:setSoundEffectVolume(0)
        end
    elseif key == systemSetting.SystemSettingDefine.totalVolumeSwitch then
        local switch = self:getIsOpen(value)
        if switch then
            AudioManager:setTotalVolume(self:getSystemSettingValue(systemSetting.SystemSettingDefine.totalVolume) / 100)
        else
            AudioManager:setTotalVolume(0)
        end
    elseif key == systemSetting.SystemSettingDefine.musicVolumeSwitch then
        local switch = self:getIsOpen(value)
        if switch then
            AudioManager:setMusicVolume(self:getSystemSettingValue(systemSetting.SystemSettingDefine.musicVolume) / 100)
        else
            AudioManager:setMusicVolume(0)
        end
    elseif key == systemSetting.SystemSettingDefine.voiceVolumeSwitch then
        local switch = self:getIsOpen(value)
        if switch then
            AudioManager:setCvVolume(self:getSystemSettingValue(systemSetting.SystemSettingDefine.voiceVolume) / 100)
        else
            AudioManager:setCvVolume(0)
        end
    elseif key == systemSetting.SystemSettingDefine.soundEffectVolumeSwitch then
        local switch = self:getIsOpen(value)
        if switch then
            AudioManager:setSoundEffectVolume(self:getSystemSettingValue(systemSetting.SystemSettingDefine.soundEffectVolume) / 100)
        else
            AudioManager:setSoundEffectVolume(0)
        end
    elseif key == systemSetting.SystemSettingDefine.cameraLock then
    elseif key == systemSetting.SystemSettingDefine.lockTeamMember then
    elseif key == systemSetting.SystemSettingDefine.gyro then
        GameDispatcher:dispatchEvent(EventName.SET_MAIN_SCENE_GYRO,self:getSystemSettingValue(systemSetting.SystemSettingDefine.gyro)) 
    end
end

--获取相机后处理脚本
function GetCameraPostProcessing(self)
   local post1, post2
    local cameraCom1 = gs.CameraMgr:GetSceneCamera()
    if cameraCom1 and not gs.GoUtil.IsCompNull(cameraCom1) then
        post1 = cameraCom1:GetComponent(ty.PostProcessing)
    end
    local cameraCom2 = gs.CameraMgr:GetDefSceneCamera()
    if cameraCom2 and not gs.GoUtil.IsCompNull(cameraCom2) then
        post2 = cameraCom2:GetComponent(ty.PostProcessing)
    end

    return post1,post2
end

--切换场景需要生效的参数
function onLoadSceneApply(self)
    self.mCurScreenSize = nil

    local setingTab =
    {
        systemSetting.SystemSettingDefine.bloom,
        systemSetting.SystemSettingDefine.anti_Aliasing,
        systemSetting.SystemSettingDefine.quality,
        systemSetting.SystemSettingDefine.dispersion,
        systemSetting.SystemSettingDefine.radial_Blur,
        systemSetting.SystemSettingDefine.special_effect_distortion,
        systemSetting.SystemSettingDefine.post_processing,
        systemSetting.SystemSettingDefine.reflection,
        systemSetting.SystemSettingDefine.frameCount,
    }

    for k, v in pairs(setingTab) do
        self:applySetting(v)
    end
end

function getNotchH(self)
    if ScreenUtil:isSmallScreen() then
        return 0
    end

    local cb = self:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.notch_Auto)
    if cb then
        return self.mNotchHeight
    end
    return self:getSystemSettingValue(systemSetting.SystemSettingDefine.notch_Value) or 0
end

--获取对应下拉框的值
function getQualityLabelValue(self, key)
    for i = 1, #systemSetting.QualitySettingDrop do
        if systemSetting.QualitySettingDrop[i].key == key then
            return systemSetting.QualitySettingDrop[i].label
        end
    end
end

--获取当前画质是否是自定义画质
function getCurQualityIsCustom(self)
    return self.mSettingValueDic[systemSetting.SystemSettingDefine.pictureQuality] == systemSetting.QualitySetting_Grade.Custom
end

--读取配置
function getSystemQualitySettingVo(self, qualityType)
    if not self.mQualitySettingData then
        self.mQualitySettingData = self:parseConfigData()
    end
    return self.mQualitySettingData[qualityType]
end

function parseConfigData(self)
    local data = {}
    local baseData = RefMgr:getData("graphics_set_data")
    for key, config in pairs(baseData) do
        local baseVo = systemSetting.SystemQualityVo.new()
        baseVo:parseCogfigData(key, config)
        data[baseVo.quality_type] = baseVo
    end
    return data
end

-- 解析设备画质配置
function parseDeviceQualityConfig(self)
    self.mDeviceQualityList = {}
    local baseData = RefMgr:getData("device_quality_data")
    for key = 1, #baseData do
        local config = baseData[key]
        local baseVo = systemSetting.SystemDeviceQualityVo.new()
        baseVo:parseCogfigData(key, config)
        table.insert(self.mDeviceQualityList, baseVo)
    end
end

function getDeviceQualityConfigVo(self, deviceName, cpuName, gpuName)
    if(not self.mDeviceQualityList)then
        self:parseDeviceQualityConfig()
    end
    local isSameDeviceName = nil
    local isSameCpuName = nil
    local isSameGpuName = nil
    for i = 1, #self.mDeviceQualityList do
        local configVo = self.mDeviceQualityList[i]
        if(configVo.deviceName == "")then
            isSameDeviceName = nil
        else
            if(string.lower(configVo.deviceName) == string.lower(deviceName))then
                isSameDeviceName = true
            else
                isSameDeviceName = false
            end
        end
        if(configVo.cpuName == "")then
            isSameCpuName = nil
        else
            if(string.lower(configVo.cpuName) == string.lower(cpuName))then
                isSameCpuName = true
            else
                isSameCpuName = false
            end
        end
        if(configVo.gpuName == "")then
            isSameGpuName = nil
        else
            if(string.lower(configVo.gpuName) == string.lower(gpuName))then
                isSameGpuName = true
            else
                isSameGpuName = false
            end
        end
        if(isSameDeviceName ~= false and isSameCpuName ~= false and isSameGpuName ~= false)then
            if(isSameDeviceName or isSameCpuName or isSameGpuName)then
                return configVo
            end
        end
    end
end

function getDeviceQualityType(self, deviceName, cpuName, gpuName, memoryGBSize)
    if(web.WebManager.platform == web.DEVICE_TYPE.IOS)then
        local deviceModel, count = string.gsub(string.lower(CS.UnityEngine.SystemInfo.deviceModel), " ", "")
        local paramList = string.split(deviceModel, ",")
        local model = paramList[1]
		local id = 0
		local subId = paramList[2] and tonumber(paramList[2]) or 0
		if (string.find(model, "iphone") ~= nil) then
			local iphoneId, _count = string.gsub(model, "iphone", "")
			id = tonumber(iphoneId)
			model = "iphone"
		elseif (string.find(model, "ipa") ~= nil) then
			model = "ipa"
		end

		if (model == "iphone") then
			if(id <= 8)then -- iphoneSE
				return systemSetting.QualitySetting_Grade.Low
			elseif(id == 9)then -- iphone7
				if(subId ~= 2 and subId ~= 4)then -- 非plus
					return systemSetting.QualitySetting_Grade.Middle
                else
                    return systemSetting.QualitySetting_Grade.High
				end
			elseif(id == 10)then -- iphone8、iphonex
				if(subId ~= 2 and subId ~= 5 and subId ~= 3 and subId ~= 6)then -- 非iphone8plus 和 非iphonex
					return systemSetting.QualitySetting_Grade.Middle
                else
                    return systemSetting.QualitySetting_Grade.High
				end
            elseif(11 <= id and id <= 12)then
                return systemSetting.QualitySetting_Grade.High
            elseif(id > 12)then
                return systemSetting.QualitySetting_Grade.VeryHigh
			end
        elseif(model == "ipa")then
            return systemSetting.QualitySetting_Grade.VeryHigh
		end
    elseif(web.WebManager.platform == web.DEVICE_TYPE.ANDROID)then
        if(sdk.SdkManager:getIsSimulator())then
            return systemSetting.QualitySetting_Grade.High
        else
            local configVo = self:getDeviceQualityConfigVo(deviceName, cpuName, gpuName)
            if(configVo)then
                return configVo.qualityType
            else
                return self:getQualityByMemory(memoryGBSize)
            end
        end
    else
        local deviceName, cpuName, gpuName = sdk.SdkManager:getDeviceData()
        cpuName = string.lower(cpuName)
        for cpuIndex = 3, 15 do
            if(string.find(cpuName, "i" .. cpuIndex) ~= nil)then
                -- i5区分
                if(cpuIndex > 5)then
                    if(string.find(gpuName, "uhd") == nil)then
                        -- 非集显
                        return systemSetting.QualitySetting_Grade.VeryHigh
                    else
                        -- 集显
                        return systemSetting.QualitySetting_Grade.High
                    end
                else
                    return systemSetting.QualitySetting_Grade.High
                end
                break
            end
        end
        return systemSetting.QualitySetting_Grade.High
    end
end

-- 根据内存大小自动确定画质
function getQualityByMemory(self, memoryGBSize)
    -- 注:4G 内存的手机，这里获得的内存只有3.7G左右 (系统保留部分内存)
    memoryGBSize = memoryGBSize or (math.ceil(gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024))
    if(web.WebManager.platform == web.DEVICE_TYPE.IOS)then
        if memoryGBSize <= 3 then
            return systemSetting.QualitySetting_Grade.Middle        -- 3G 以及以下的开中等画质
        else
            return systemSetting.QualitySetting_Grade.High          -- 3G 以上(即4G和6G)的开高画质
        end
    elseif(web.WebManager.platform == web.DEVICE_TYPE.ANDROID or web.WebManager.platform == web.DEVICE_TYPE.WINDOWS)then
        if memoryGBSize >= 6 then                                   
            return systemSetting.QualitySetting_Grade.High          -- 6G 以及以上的开高画质
        elseif memoryGBSize >= 4 then
            return systemSetting.QualitySetting_Grade.Middle        -- 4G 以及以上的开中画质
        else
            return systemSetting.QualitySetting_Grade.Low           -- 4G 以下的开低画质
        end
    else
        return systemSetting.QualitySetting_Grade.High              -- 开高画质
    end
end

-- 设置画质（根据配置自动默认配置）
function setDefaultQuality(self)
    local deviceName, cpuName, gpuName = sdk.SdkManager:getDeviceData()
    local result = StorageUtil:getBool1(gstor.APP_FIRST_AUTO_QUALITY)
    if(not result)then
        logInfo("自动画质设置")
        StorageUtil:saveBool1(gstor.APP_FIRST_AUTO_QUALITY, true)
        local defaultQuality = self:getDeviceQualityType(deviceName, cpuName, gpuName)
        self:setSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality, defaultQuality)
        self:applySetting(systemSetting.SystemSettingDefine.pictureQuality)
    end

    -- 此处直接每次上报没有推荐到的画质
    local configVo = self:getDeviceQualityConfigVo(deviceName, cpuName, gpuName)
    if(not configVo)then
        local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.AUTO_CONFIG_QUALITY, "失败")
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
    end
end

--更新渲染精度
function updateQuality(self)
    self:setQuality()
end

--设置渲染精度
function setQuality(self, value)
    --去除渲染精度相机，设置视口分辨率
    local normalQuality = function (resolution)
        gs.CameraMgr:ResetRenderCamera() 
        gs.ScreenResolutionUtil.SetResolutionLv01(resolution)
    end

    --更新渲染精度
    local SetResolution01 = function (height)
        local width = height / gs.Screen.height * gs.Screen.width
        gs.CameraMgr:SetResolution(width, height)

        if gs.CameraMgr:IsGraphicBlitCamera() then
            local screenSceneCamera = gs.CameraMgr:GetToScreenSceneCamera()
            if gs.GoUtil.IsCompNull(screenSceneCamera.gameObject:GetComponent(ty.RaycastMouseEvent)) then
                screenSceneCamera.gameObject:AddComponent(ty.RaycastMouseEvent)
            end
        end
    end

    if map then
        --(14138)
        --PC：主界面和UI模型展示界面，渲染精度最低1080p，当渲染精度设置超过1080（1.0），主界面和UI模型展示需同步处理（超过1080p）。其他按渲染精度设置。
        --移动：主界面和UI等保持1080，其他场景按渲染精度设置。

        local height = systemSetting.getResolution(value)
        if not height then 
            height = 720
        end

        if gs.Application.isMobilePlatform then
            if self:getIsNormalQuality()  then
                normalQuality(1080)
            else
                if height >= 1080 then 
                    normalQuality(height)
                else
                   SetResolution01(height)
                end
            end
        else
            if self:getIsNormalQuality() then
                if height < 1080 then 
                    height = 1080
                end
            end

            SetResolution01(height)
        end
    end
end

--是否不适用RT渲染分离
function getIsNormalQuality(self)
    local curSceneType = map.MapLoader:getCurSceneType()
    if curSceneType == MAP_TYPE.MAIN_CITY then 
        return true
    elseif curSceneType == MAP_TYPE.RECRUIT_HERO then 
        return true
    elseif curSceneType == MAP_TYPE.RECRUIT_CARD then 
        return true
    elseif curSceneType == MAP_TYPE.BIG_HOSTEL then 
        return true
    end
end

--获取所有的分辨率
function getAllwindowResolution(self)
    if gs.Application.isMobilePlatform then return end

    if not self.mResolutionList then 
        local function table_indexof(tab,value)
            for k,v in pairs(tab) do
                if v.width == value.width and v.height == value.height then 
                    return true
                end
            end
            return false
        end
        self.mResolutionList = {}
        local resolutions = gs.Screen.resolutions
        local _resolution = nil
        for i=0,resolutions.Length - 1 do
            _resolution = resolutions[i]
            local resolution = {width = _resolution.width, height = _resolution.height}
            if not table_indexof(self.mResolutionList,resolution) then 
                table.insert(self.mResolutionList, resolution)
            end
        end

        table.sort(self.mResolutionList, function (a, b)
            if a.width == b.width then 
                return a.height > b.height
            end
            return a.width > b.width
        end)
    end
    return self.mResolutionList
end

--获取cv选项参数配置
function getCvTypeSettingCfgs(self)
    local cvOptionsConfig = sysParam.SysParamManager:getValue(SysParamType.CV_TYPE)
    return cvOptionsConfig
end

--获取当前cv选项配置
function getCurCvTypeSettingCfg(self)
    local cvOptionsConfig = self:getCvTypeSettingCfgs()
    local curSelectIdx = self:getCurSelectCvTypeSetting()
    local data = cvOptionsConfig[curSelectIdx]
    return data
end

--获取当前选中cv选项
function getCurSelectCvTypeSetting(self)
    local curSelectIdx = StorageUtil:getNumber1(gstor.CV_TYPE)
    local config = self:getCvTypeSettingCfgs()
    if not config[curSelectIdx] then
        curSelectIdx = 1 
        self:setCurSelectCvTypeSetting(curSelectIdx)
    end
    return curSelectIdx
end

--设置当前选中cv选项
function setCurSelectCvTypeSetting(self, curSelectIdx)
    StorageUtil:saveNumber1(gstor.CV_TYPE, curSelectIdx)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
