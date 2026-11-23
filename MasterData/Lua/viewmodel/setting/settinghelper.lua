





RenderLevel={
   LOW=0,
   MIDDLE=1,
   HIGH=2,
   CUSTOM=3
}


local skinPath="Assets/_BundleResources/Character/"
local PlayerPrefs=UnityEngine.PlayerPrefs;
local CIsOn = 1;
local CVolume = 0.85;
local defaultImgQuality;


SettingHelper= {
CMIN = 0;
CMAX = 1;
    SettingBrithDay=false;
}






local function GetSetting_TogDefault(setting)
    local isOn=true;
    if setting.key==ESetting.Image_QualityMiddle.key
            or setting.key==ESetting.Image_QualityLow.key
            or setting.key==ESetting.Image_QualityCustom.ky
            or setting.key==ESetting.Image_Render.key
            or setting.key==ESetting.Image_Frame.key
            or setting.key==ESetting.Image_FrameBattle.key
            or setting.key==ESetting.Image_Spine.key
            or setting.key==ESetting.Image_Shadow.key
            or setting.key==ESetting.Image_Resolution.key
            or setting.key==ESetting.Fight_Idle.key
            or setting.key==ESetting.Fight_Auto.key
            or setting.key==ESetting.Fight_SpeedUp.key
            or setting.key==ESetting.Fight_OldPrediction.key
            or setting.key==ESetting.Fight_HpBarMode2.key
            or setting.key==ESetting.Msg_ZZRed_AllHero.key
            or setting.key==ESetting.Msg_TalentRed_AllHero.key
            or setting.key==ESetting.Msg_LevelUpRed_AllHero.key
            or setting.key==ESetting.Msg_LevelUpRed_Close.key
            or setting.key==ESetting.Msg_TalentRed_Close.key
            or setting.key==ESetting.Msg_ZZRed_Close.key
            or setting.key==ESetting.Msg_LPRed_AllHero.key
            or setting.key==ESetting.Msg_LPRed_Close.key
            or setting.key==ESetting.Msg_ZZTXKRed_Close.key
            or setting.key==ESetting.Msg_QZZJRed_Close.key
            or setting.key==ESetting.Msg_QZZJRed_Max.key
            or setting.key==ESetting.Msg_EquipPopup_Close.key
            or setting.key==ESetting.Msg_EquipPopup_TodayClose.key
            or setting.key==ESetting.Fight_PreviewInfo.key
            or setting.key==ESetting.Msg_HZRed_AllHero.key
            or setting.key==ESetting.Msg_HZRed_Close.key
    then
        isOn=false;
    end
    return isOn;
    
end



local function GetSetting_FloatDefault(setting)
    local value=nil;
    if setting.key==ESetting.ScreenOffset.key then
        value=0.7;
    elseif setting.key==ESetting.Audio_VoiceVolume.key or
            setting.key==ESetting.Audio_SoundVolume.key or
            setting.key==ESetting.Audio_MusicVolume.key or
            setting.key==ESetting.Audio_VoiceVolume_Battle.key or
            setting.key==ESetting.Audio_SoundVolume_Battle.key or
            setting.key==ESetting.Audio_MusicVolume_Battle.key or
            setting.key==ESetting.Audio_VoiceVolume_Novel.key or
            setting.key==ESetting.Audio_SoundVolume_Novel.key or
            setting.key==ESetting.Audio_MusicVolume_Novel.key 
    then
        value=CVolume;
    else
        value=0;
    end
    return value;
end


function SettingHelper.ConverToSetting(value)
    for i,v in pairs(ESetting) do
        if v.value==value then
            return v;
        end
    end
    return nil

end

function SettingHelper.Init()

    local curQu=SettingHelper.GetCurImageQuality();

    local renderLevel=nil;
    if curQu.key==ESetting.Image_QualityCustom.key then
        renderLevel=RenderLevel.CUSTOM
    elseif curQu.key==ESetting.Image_QualityHigh.key then
        renderLevel=RenderLevel.HIGH
    elseif curQu.key==ESetting.Image_QualityMiddle.key then
        renderLevel=RenderLevel.MIDDLE
    else
        renderLevel=RenderLevel.LOW
    end
    print("当前使用画质:",renderLevel)
    if renderLevel==RenderLevel.CUSTOM then
        SettingHelper.SetCustomItem();
    else
        LuaMgr.SetRenderLevel(renderLevel);
        SettingHelper.SetFrame(renderLevel)
    end
    SettingHelper.UpdateFrame(false);
end


function SettingHelper.SetCustomItem()
    local isOn = SettingHelper.GetPrefasBool(ESetting.Image_Render);
    SettingHelper.SetItemRender(ESetting.Image_Render, isOn);
    
    local level = SettingHelper.GetPrefasInt(ESetting.Image_ResLevel);
    SettingHelper.SetItemRender(ESetting.Image_ResLevel, level);
    
    isOn = SettingHelper.GetPrefasBool(ESetting.Image_Spine);
    SettingHelper.SetItemRender(ESetting.Image_Spine, isOn);
    
    isOn = SettingHelper.GetPrefasBool(ESetting.Image_Shadow);
    SettingHelper.SetItemRender(ESetting.Image_Shadow, isOn);
    
    SettingHelper.SetFrame(RenderLevel.CUSTOM)
    


end

function SettingHelper.SetItemRender(setting, value)
    if setting.key==ESetting.Image_Render.key then
        LuaMgr.SetRenderLevelEnable("RenderQuality", value);
    elseif setting.key==ESetting.Image_ResLevel.key then
        LuaMgr.SetRenderLevelValue("ArtLevel", value);
    elseif setting.key==ESetting.Image_Frame.key then
        SettingHelper.SetPrefsBool(ESetting.Image_Frame,value);
        SettingHelper.UpdateFrame(false);
    elseif setting.key==ESetting.Image_FrameBattle.key then
        SettingHelper.SetPrefsBool(ESetting.Image_FrameBattle,value);
    elseif setting.key==ESetting.Image_Spine.key then
        LuaMgr.SetRenderLevelEnable("SpineEnable", value);
    elseif setting.key==ESetting.Image_Shadow.key then
        LuaMgr.SetRenderLevelEnable("HeightShadow", value);
    elseif setting.key==ESetting.Image_Resolution.key then

    end
end

function SettingHelper.SetFrame(renderLevel)
    local hakKey, isOn = false, false
    local imageFrameCfg = nil
    local imageFrameBattleCfg = nil
    if ConfigMgr.Config.constants.ImageFrame ~= nil then
        imageFrameCfg = ConfigMgr.Config.constants.ImageFrame[renderLevel + 1]
    end
    if ConfigMgr.Config.constants.ImageFrameBattle ~= nil then
        imageFrameBattleCfg = ConfigMgr.Config.constants.ImageFrameBattle[renderLevel + 1]
    end

    hakKey = SettingHelper.PrefasHasKey(ESetting.Image_Frame)
    if hakKey then
        isOn = SettingHelper.GetPrefasBool(ESetting.Image_Frame)
    elseif imageFrameCfg ~= nil then
        isOn = imageFrameCfg == 60
    end
    SettingHelper.SetItemRender(ESetting.Image_Frame, isOn)
    

    isOn = false
    hakKey = SettingHelper.PrefasHasKey(ESetting.Image_FrameBattle)
    if hakKey then
        isOn = SettingHelper.GetPrefasBool(ESetting.Image_FrameBattle)
    elseif imageFrameBattleCfg ~= nil then
        isOn = imageFrameBattleCfg == 60
    end
    SettingHelper.SetItemRender(ESetting.Image_FrameBattle, isOn)
end

function SettingHelper.UpdateFrame(isBattle)
    local isOn=false;
    if isBattle then
        isOn = SettingHelper.GetPrefasBool(ESetting.Image_FrameBattle);
    else
        isOn = SettingHelper.GetPrefasBool(ESetting.Image_Frame);
    end
    local frame = isOn and 60 or 30;
    if UnityEngine.Application.targetFrameRate~=frame then
        UnityEngine.Application.targetFrameRate = frame;
    end
    
    local frameStep = isOn and 2 or 1
    LuaMgr.SetSkeletonFrameData(frameStep)
end




function SettingHelper.AdjusetImage(level)
    print("机型推荐画质",level)
    if level~=nil then
        if level==RenderLevel.LOW then
            defaultImgQuality=ESetting.Image_QualityLow
        elseif level==RenderLevel.MIDDLE then
            defaultImgQuality=ESetting.Image_QualityMiddle
        elseif level==RenderLevel.HIGH then
            defaultImgQuality=ESetting.Image_QualityHigh
        elseif level==RenderLevel.CUSTOM then
            defaultImgQuality=ESetting.Image_QualityCustom
        end
        return defaultImgQuality;
    else
        return defaultImgQuality;
    end
end




function SettingHelper.GetSetting_FloatDefault(setting)
    local value=0.0;
    if setting.key==ESetting.Audio_MusicVolume.key or
            setting.key==ESetting.Audio_SoundVolume.key or
            setting.key==ESetting.Audio_VoiceVolume.key then
        value=0.85;
    elseif setting.key==ESetting.ScreenOffset.key then
        value=0.7;
    end
    return value;
    
end

function SettingHelper.SetPrefsFloat(setting,floatValue)
    PlayerPrefs.SetFloat(setting.key,floatValue)
    PlayerPrefs.Save();
    if setting.value>=0 and setting.value<10000 then
        LuaMgr.InvokeUIEventListeners(UIEventConst.BattleSettingModify,setting.value);
    end
end 

function SettingHelper.SetPrefsBool(setting,isOn)
    local key=setting.key;
    if setting.value>=150 and setting.value<300 then
        key=DataMgr.Player.uid..key;
    end
    local value=isOn and 1 or 0;
    PlayerPrefs.SetInt(key,value);
    PlayerPrefs.Save();

    if setting.value>=0 and setting.value<10000 then
        print("settingValue",setting.value)
        LuaMgr.InvokeUIEventListeners(UIEventConst.BattleSettingModify,setting.value);
    end
end

function SettingHelper.SetPrefsInt(setting,intValue)
    PlayerPrefs.SetInt(setting.key,intValue)
    PlayerPrefs.Save();
    if setting.value>=0 and setting.value<10000 then
        LuaMgr.InvokeUIEventListeners(UIEventConst.BattleSettingModify,setting.value);
    end
end

function SettingHelper.GetPrefasFloat(setting)
    if not PlayerPrefs.HasKey(setting.key) then
        return GetSetting_FloatDefault(setting)
    else
        return PlayerPrefs.GetFloat(setting.key);
    end
end

function SettingHelper.GetPrefasBool(setting)
    local key=setting.key;
    if setting.value>=150 and setting.value<300 then
        key=DataMgr.Player.uid..key;
    end
    if not PlayerPrefs.HasKey(key) then
        return GetSetting_TogDefault(setting)
    else
        local re=PlayerPrefs.GetInt(key);
        return re==CIsOn;
    end
end

function SettingHelper.GetPrefasInt(setting)
    if not PlayerPrefs.HasKey(setting.key) then
        return -1;
    end
    return PlayerPrefs.GetInt(setting.key);
end

function SettingHelper.PrefasHasKey(setting)
    local key=setting.key;
    if setting.value>=150 and setting.value<300 then
        key=DataMgr.Player.uid..key;
    end
    return PlayerPrefs.HasKey(key)
end

function SettingHelper.GetCurImageQuality()
    local value=SettingHelper.GetPrefasInt(ESetting.Image_CurrentQulity)
    if value<0 then
        print("无玩家画质记录....，采用推荐画质")
        return defaultImgQuality;
    end
    print("调取玩家画质记录....")
    return  SettingHelper.ConverToSetting(value);
end


function SettingHelper.IsImageLow()
    local cur=SettingHelper.GetCurImageQuality()
    if cur.key==ESetting.Image_QualityLow.key then
        return true;
    else
        return false;
    end
end


return SettingHelper;