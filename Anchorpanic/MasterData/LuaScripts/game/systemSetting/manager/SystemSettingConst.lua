systemSetting.SettingTabKey = {
    QualitySetting = 1,
    SoundSetting = 2,
    OtherSetting = 3,
}

---系统设置保存键
systemSetting.SystemSettingDefine = {
    pictureQuality = "pictureQuality", --画面质量
    ---下面这些对于配置表中的字段名
    frameCount = "fps", --帧率
    vSyns = "v_sync", --垂直同步
    quality = "render_resolution", --渲染精度
    shadow = "shadow_quality", --阴影质量
    bloom = "bloom", --Bloom
    effect = "sfx_quality", --特效质量
    anti_Aliasing = "anti_aliasing", --抗锯齿
    dispersion = "dispersion", --色散
    radial_Blur = "radial_Blur", --径向模糊
    special_effect_distortion = "special_effect_distortion", --特效扭曲
    post_processing = "post_processing", --后处理
    reflection = "reflex", --镜面反射
    gyro = "gyro",--陀螺仪

    -- later_Effect = "visual_effects", --后期效果
    -- screen = "environment_detail", --场景细节
    -- fog = "volumetric_fog", --体积雾
    -- dynamic_fuzzy = "motion_blur", --动态模糊
    -- subsurface_Scattering = "subsurfasce_scattering", --次表面散射
    -- anisotropic_filtering = "anisotropic_filtering", --各向异性采样
    ---end
    notch_Auto = "notch_Auto", --是否开启自动刘海
    notch_Value = "notch_Value", --刘海值
    totalVolume = "totalVolume", --总音量
    musicVolume = "musicVolume", --音乐音量
    voiceVolume = "voiceVolume", --语音音量
    totalVolumeSwitch = "totalVolumeSwitch", --总音量开关
    musicVolumeSwitch = "musicVolumeSwitch", --音乐音量开关
    soundEffectVolume = "soundEffectVolume", --音效音量
    voiceVolumeSwitch = "voiceVolumeSwitch", --语音音量开关
    soundEffectVolumeSwitch = "soundEffectVolumeSwitch", --音效音量开关
    cameraLock = "cameraLock", --镜头锁定
    -- checkAsset = 26, --检查资源
    lockTeamMember = "lockTeamMember", --锁定战员
    windowResolution = "windowResolution", --窗口分辨率
}

--画质档次
systemSetting.QualitySetting_Grade = {
    Low = 1, --低
    Middle = 2, --中
    High = 3, --高
    VeryHigh = 4, --极高
    Custom = 5, --自定义
}

--用于画质设置界面的dropDown
systemSetting.QualitySettingDrop = {
    ---"画面质量" "低" 中" "高" "极高"
    { key = systemSetting.SystemSettingDefine.pictureQuality, title = _TT(62070), label = { _TT(62082), _TT(62083), _TT(62084), _TT(62085) } },
    --"渲染精度" 文本获取在下面
    { key = systemSetting.SystemSettingDefine.quality, title = _TT(62072), label = {}, isDownDrop = true },
    { key = systemSetting.SystemSettingDefine.frameCount, title = _TT(62071), label = { "30", "60" } }, --帧率
    --阴影质量 "低" "中" "高"
    { key = systemSetting.SystemSettingDefine.shadow, title = _TT(62073), label = { _TT(62082), _TT(62083), _TT(62084), _TT(62085) } },
    --"低" "中" "高"
    -- { key = systemSetting.SystemSettingDefine.effect, title = _TT(62074), label = { _TT(62082), _TT(62083), _TT(62084)} }, -- 特效质量
    -- { key = systemSetting.SystemSettingDefine.vSyns, title = _TT(62075), label = { _TT(62086), _TT(62087)},isToggle = true }, -- 垂直同步
    { key = systemSetting.SystemSettingDefine.anti_Aliasing, title = _TT(62076), label = { _TT(62086), _TT(62087) }, isToggle = true }, --抗锯齿
    { key = systemSetting.SystemSettingDefine.bloom, title = _TT(62077), label = { _TT(62086), _TT(62087) }, isToggle = true }, --Bloom
    { key = systemSetting.SystemSettingDefine.dispersion, title = _TT(62078), label = { _TT(62086), _TT(62087) }, isToggle = true }, --色散
    { key = systemSetting.SystemSettingDefine.radial_Blur, title = _TT(62079), label = { _TT(62086), _TT(62087) }, isToggle = true }, --径向模糊
    { key = systemSetting.SystemSettingDefine.special_effect_distortion, title = _TT(62080), label = { _TT(62086), _TT(62087) }, isToggle = true }, --特效扭曲
    { key = systemSetting.SystemSettingDefine.post_processing, title = _TT(62081), label = { _TT(62086), _TT(62087) }, isToggle = true }, --后处理
    { key = systemSetting.SystemSettingDefine.reflection, title = _TT(62090), label = { _TT(62086), _TT(62087) }, isToggle = true }, --镜面反射
    --{ key = systemSetting.SystemSettingDefine.gyro, title = _TT(282), label = { _TT(62086), _TT(62087) }, isToggle = true }, --陀螺仪
-- { key = systemSetting.SystemSettingDefine.later_Effect, title = "后期效果", label = { "极低", "低", "中", "高" } }, --后期效果
-- { key = systemSetting.SystemSettingDefine.screen, title = "场景细节", label = { "极低", "低", "中", "高", "极高" } }, --场景细节
-- { key = systemSetting.SystemSettingDefine.fog, title = "体积雾", label = { "关闭", "打开" } }, --体积雾
-- { key = systemSetting.SystemSettingDefine.dynamic_fuzzy, title = "动态模糊", label = { "关闭", "低", "高", "非常高" } }, --动态模糊
-- { key = systemSetting.SystemSettingDefine.subsurface_Scattering, title = "次表面散射", label = { "低", "中", "高" } }, --次表面散射 
-- { key = systemSetting.SystemSettingDefine.anisotropic_filtering, title = "各向异性采样", label = { "1.1x", "2.2x", "3.4x", "4.8x", "5.16x " } }, --各向异性采样 
}

--单条获取画质设置界面的dropDown
systemSetting.getOneQualitySettingDrop = function(defineType)
    for i = 1, #systemSetting.QualitySettingDrop do
        local _value = systemSetting.QualitySettingDrop[i]
        if (_value.key == defineType) then
            return _value
        end
    end
end

-- 自动获取渲染精度文本
systemSetting.getResolutionLabel = function()
    if gs.Application.isMobilePlatform then
        return { _TT(62103), _TT(62082), _TT(62083), _TT(62084), _TT(62085) }
    else
        return { "0.6", "0.8", "1.0", "1.2", "1.5", "2.0" }
    end
end

-- 自动获取渲染精度
systemSetting.getResolution = function(value)
    if gs.Application.isMobilePlatform then
        return systemSetting.resolutionByMobile[value]
    else
        return systemSetting.resolutionByPc[value]
    end
end

-- 移动平台渲染进度列表
systemSetting.resolutionByMobile = { 450, 560, 720, 960, 1080 }

-- PC和ipad 平台渲染进度列表
systemSetting.resolutionByPc = { 720, 960, 1080, 1440, 1600, 2048 }

--[[ 替换语言包自动生成，请勿修改！
]]