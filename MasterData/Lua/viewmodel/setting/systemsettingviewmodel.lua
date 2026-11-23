




require("ViewModel/Setting/SettingAssistHeroViewModel")

local this = {vm=nil};
local HeroManager=CS.Laigu.ViewModel.Hero.HeroManager;
local blackColor=UnityEngine.Color(38/255,36/255,41/255,255/255);
local whiteColor=UnityEngine.Color(162/255,154/255,133/255,255/255);
local isPlayer=false;
local curImageQualityKey=nil;
local fightingAnima="ani_SystemSettingPanel_FightingPanel";
local msgAnima="ani_SystemSettingPanel_MsgPanel";
local musicAnima="ani_SystemSettingPanel_MusicPanel";
local screenAnima="ani_SystemSettingPanel_ScreenViewPanel";
local languageAnima="ani_SystemSettingPanel_LanguageViewPanel";
local sysAnimator=nil;
local spineUICharacter=nil;
local playerAvatarFrame = nil;
local protocolGO;
local enableNFCGO;
local userProtocolBtn;
local privacyProtocolBtn;
local enableNFCBtn;
local cfg_playerSkin=nil;
local data_playerSkin=nil;

local mottoInputField = nil

local toggleTimesNum = 0

local dataVoiceList={}
local voiceTypeIndex=nil;
local assistHeroViewModel=nil;
local playerDynamicAvatar = nil
local data = {
  
    systemList={
        {
            isOn=false,
            color=blackColor
        },
        {
            isOn=false,
            color=blackColor
        },
        {
            isOn=false,
            color=blackColor
        },
    },
    systemSubList={
        {
            isOn=false,
            color=blackColor
        },
        {
            isOn=false,
            color=blackColor
        },
        {
            isOn=false,
            color=blackColor
        },
        {
            isOn=false,
            color=blackColor
        },
        {
            isOn=false,
            color=blackColor
        }
       
    },
    
    systemPanelBools={
        {
            isOn=false,
        },
        {
            isOn=false,
        },
        {
            isOn=false,
        },
        {
            isOn=false,
        },
        {
            isOn=false,
        },

    },
    textList={
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
        { text="", isOn=false },
    };
    
    voiceList={
        {
            isOn=false,
            text="",
        }  
    },
    sealList={
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
    },
    assistList={
        {
            level="",
            img=DefaultTexture,
            rare=DefaultSprite,
            job=DefaultSprite,
        }
    },
    zhanXunList={
        {isOn=false,icon=DefaultSprite},
        {isOn=false,icon=DefaultSprite},
        {isOn=false,icon=DefaultSprite},
        {isOn=false,icon=DefaultSprite},
        {isOn=false,icon=DefaultSprite},
        {isOn=false,icon=DefaultSprite},
        {isOn=false,icon=DefaultSprite},
        {isOn=false,icon=DefaultSprite},
        {isOn=false,icon=DefaultSprite},
    },
    
    screenViewSize=Vector2(0,0);
    imageQtysSpacing=0.0;
    otherCellSize=Vector2(0,0);
    screenOffset=0.0;
    screenOffsetIsOn=false;
    screenAnchorPos=Vector2(0,0);
    screenViewOtherAnchorPos=Vector2(0,0);
    
    playerInfoPanelBool=false,
    systemSettingPanelBool=false,
    assistPanelBool=false;

    imageQualityLowIsOn=false;
    imageQualityMiddleIsOn=false;
    imageQualityHighIsOn=false;
    imageQualityCustomIsOn=false;
    
    isRenderOn = false,
    isResLevelHigh = false,
    isResLevelMedium = false,
    isResLevelLow = false,
    isFrameOn = false,
    isFrameBattleOn = false,
    isSpineOn = false,
    isShadowOn = false,
    
    

    languageCnIsOn=false;
    languageTwIsOn=false;
    

    musicVolume=0.0;
    soundVolume=0.0;
    voiceVolume=0.0;
    

    battleMusicVolume=0.0;
    battleSoundVolume=0.0;
    battleVoiceVolume=0.0;
    

    
    novelMusicVolume=0.0;
    novelSoundVolume=0.0;
    novelVoiceVolume=0.0;
    
    voiceOtherBool=false;
    

    levelUpRed_allHero=false;
    levelUpRed_commonlyHero=false;
    levelUpRed_close=false;
    talentRed_allHero=false;
    talentRed_commonlyHero=false;
    talentRed_close=false;
    zzRed_allHero=false;
    zzRed_commonlyHero=false,
    zzRed_close=false;
    allMsgIsOn=false;
    powerMDoneMsgIsOn=false;
    dispatchDoneMsgIsOn=false;
    weaponMakeMsgIsOn=false;
    searchMsgIsOn=false;
    
    specialityRed_allHero = false;
    specialityRed_commonlyHero = false;
    specialityRed_close = false;
    hzRed_allHero = false;
    hzRed_commonlyHero = false;
    hzRed_close = false;
    zztxkRed_close = false;
    zztxkRed_open = false;
    qzzjRed_close = false;
    qzzjRed_auto = false;
    qzzjRed_max = false;
    equipPopup_Close = false,
    equipPopup_TodayClose = false,
    equipPopup_Open = false,

    attackFocusIsOn=false;
    trickAnimationIsOn=false;
    screenShakeIsOn=false;
    buffBubblesIsOn=false;
    hpBarIsOn=false;
    hpMarkIsOn=false;
    characterInfoIsOn=false;
    oldPrediction=false;
    idleIsOn=false;
    previewIsOn=false;
    hpBarMode1 = false,
    hpBarMode2 = false,
    fiveSpeedTimeline = false,
    previewInfo = false,





    characterPath="";
    bodyRawBool=false;
    showMotto = false;
    mottoInputText="";
    userLevel="";
    playerExp=0.0;
    userName="";
    userID="";
    userMotto="";
    userChallenge="";
    characterChallenge="";
    equipmentChallenge="";
    characterChallengeFill=0.0;
    equipmentChallengeFill=0.0;
    challengeSize=Vector2(0,0);
    expScaleData=Vector3(0,0,0);
    playerCVSize=Vector2(0,0);
    playerTitle = DefaultSprite,
    playerTitleText = "",
    titleTextPos = Vector2.zero,

    secretaryBool=false;
    copyBool=false;
    maskBool=false;
    playerId="";
    playerAvatarFrame=DefaultSprite;
    playerAvatar=DefaultTexture;
    playerAvatarIsShow = false,
    useCenter=false;
    userChallengeCompleteBool=false;
    
    userTeamIcon=DefaultSprite;
    userTeamIcon_b=DefaultSprite;
    userTeam="";
    userTeamLock=false;
    characterPos=Vector2(50,-13);
    unLockRawImg=DefaultTexture;
    unLockRawImgBool = false;
    
    playerBirthDay="";
    
    systemAnima="";
    cancelAccountBtnText = "",

    isShowCustomCenter = true,
    customCenterRed = false,
    isChargeCDKey=false,
    isDynamicAvatar = false,
    
    assistBarGray=false;
    assistHeroScrollViewIsHorizontal=false;

    isCameraUnLock = false,
}

local command = {
    systemTog={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            this.SetBarList(index);
        end
    },
    systemSubTog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            if isOn then
                local index=tonumber(param+1);
                this.SetSubBarList(index);
            end
        end
    },
    systemImageQualityItemTog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            local index=tonumber(param);
            this.OnTog_ImageQualityItem(isOn,index);
        end
    },
    systemOtherImageQualityItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            this.OnClick_OtherQualityItem(index);
        end
    },

    volumeOffBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            this.OnClick_VolumeItemOff(index);
        end
    },
    volumeOnBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            this.OnClick_VolumeItemOn(index);
        end
    },
    volumeSlider={
      type=XLuaCommandType.Float,
      execute=function(vm,value,param)
          local index=tonumber(param);
          this.OnSlider_VolumeItem(value,index);
      end
    },

    LanguageItemTog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            local index=tonumber(param);
            this.OnTog_LanguageItem(isOn,index);
        end
    },

    msgItemTog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            local index=tonumber(param);
            this.OnTog_MsgItem(isOn,index);
        end
    },
    fightingItemIog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            local index=tonumber(param);
            this.OnTog_FightingItem(isOn,index);
        end
    },
    screenFitSlider={
        type=XLuaCommandType.Float,
        execute=function(vm,value,param)
            this.ScreenFitSlider(value);
        end
    },
    loadVoiceBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.VoiceLoadingViewModel)
        end  
    },
    voiceBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if #dataVoiceList==0 then return end;
            local index=param+1;
            if index==voiceTypeIndex then return end;
            local resName=LuaMgr.GetLangText(dataVoiceList[index].RESNameLan)
            local tip=ConfigMgr.LangGlobal("1603")
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,string.format(tip,resName),function()
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("1604"))
                voiceTypeIndex=index
                for i,v in ipairs(this.vm.data.voiceList) do
                    v.isOn=i==index;
                end
            end,nil);
        end
    },


    exitLoginBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaDebug.info("DoLogout")
            LuaMgr.DoLogout();
        end
    },
    userCenterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.DoShowUserCenter();
        end
    },
    customCenterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.customCenterRed = false
            HeroRedDataHelper.UpdateSettingRed(0)
            RedMgr.Singleton:Refresh();
            LuaMgr.DoCustomCenter();
        end
    },
    cancelAccountBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if LuaMgr.IsOneSDK() then
                LuaMgr.ShowOneSDKCloseAccount()
            else
                LuaMgr.ShowLuaPanel(UIName.CancelAccountViewModel)
            end
        end
    },
    copyUserIdBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           this.CopyToClipboard();
        end
    },
    openCopyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.maskBool=true;
            this.vm.data.copyBool=true;
        end
    },
    chanceCopyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.maskBool=false;
            this.vm.data.copyBool=false;

        end
    },
    changeAvatarFrameBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.SettingAvatarFramedViewModel);
        end
    },
    checkInBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          LuaMgr.ShowLuaPanel(UIName.ActivitySignInMonthViewModel);
      end
    },
    activityCameraBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ActivityCameraViewModel);
        end
    },
    birthDayBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local curBirthDay=DataMgr.Player.birthday;
            LuaMgr.ShowLuaPanel(UIName.CalendarViewModel,function(birthDay,isToday)
                local askData={Birthday=birthDay};
                ApiMgr.Request("set_birthday",askData,true,function()
                    SettingHelper.SettingBrithDay=isToday;
                    this.SetBrithDay(birthDay);
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2263"].NameLan))
                end,nil,true);
                
            end,curBirthDay);
        end
    },
    switchSpineBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)



            FeatureManager.GotoPanel("1039","")
        end
    },
    OnResLevelHigh={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.SetResLevel(RenderLevel.HIGH);
            this.ClickResLevel(RenderLevel.HIGH);
        end
    },
    OnResLevelMedium={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.SetResLevel(RenderLevel.MIDDLE);
            this.ClickResLevel(RenderLevel.MIDDLE);
        end
    },
    OnResLevelLow={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.SetResLevel(RenderLevel.LOW);
            this.ClickResLevel(RenderLevel.LOW);
        end
    },
    cdKeyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.CharageCDKeyViewModel)
        end
    },
    sealSettingBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           LuaMgr.ShowLuaPanel(UIName.SealEditorViewModel)
        end
    },
    renameCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local item = DataMgr.Player.items["25"]
            if item == nil or item.count0 <= 0 then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15954"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
                return
            end
            LuaMgr.ShowLuaPanel(UIName.RenameViewModel)
        end
    },
    assistHeroBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           local index=tonumber(param)+1;
            local id=this.vm.data.assistList[index].id
            PlayerAssistMgr.GoToPanel_HeroInfo(id,nil)
        end
    },
    zhanXunSettingBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ZhanXunEditorViewModel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        spineUICharacter=vm.behaviour.transform:Find("root/Middle/Panels/PlayerInfoPanel/root/Middle/PlayerCVPanel/Character/Body"):GetComponent("UISpineCharacter");
        protocolGO = vm.behaviour.transform:Find("root/Middle/Bars/PlayerCVBar/Protocol").gameObject;
        enableNFCGO = vm.behaviour.transform:Find("root/Middle/Bars/PlayerCVBar/Protocol/NFC").gameObject;
        userProtocolBtn = vm.behaviour.transform:Find("root/Middle/Bars/PlayerCVBar/Protocol/User"):GetComponent("Button");
        privacyProtocolBtn = vm.behaviour.transform:Find("root/Middle/Bars/PlayerCVBar/Protocol/Privacy"):GetComponent("Button");
        enableNFCBtn = vm.behaviour.transform:Find("root/Middle/Bars/PlayerCVBar/Protocol/NFC"):GetComponent("Button");
        mottoInputField = vm.behaviour.transform:Find("root/Middle/Panels/PlayerInfoPanel/root/Middle/PlayerCVPanel/Left/imgback2/MottoInputField"):GetComponent("InputField")
        mottoInputField.onEndEdit:AddListener(this.OnMottoEndEdit)
        this.assistPanelObj= vm.behaviour.transform:Find("root/Middle/Panels/AssistHeroPanel");
        this.headGroup=vm.behaviour.transform:Find("template/headGroup").gameObject;
        this.headItem=vm.behaviour.transform:Find("template/headItem").gameObject;
        this.cardItem=vm.behaviour.transform:Find("template/cardItem").gameObject;
        playerDynamicAvatar = vm.behaviour.transform:Find("root/Middle/Panels/PlayerInfoPanel/root/Middle/PlayerCVPanel/Left/imgBack/bg/dynamicAvatar"):GetComponent("PlayerDynamicAvatar")
        playerAvatarFrame = vm.behaviour.transform:Find("root/Middle/Panels/PlayerInfoPanel/root/Middle/PlayerCVPanel/Left/imgBack/bg/frame"):GetComponent("Image");
        RedMgr.Singleton:RegisterViewModel(UIName.SystemSettingViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end

        LuaMgr.AddUIEventListener(UIEventConst.SettingAvatarChange,this.OnAvatarRefresh)
        LuaMgr.AddUIEventListener(UIEventConst.CancelAccountRefresh,this.RefreshCancelAccountBtn)
        LuaMgr.AddUIEventListener(UIEventConst.RenameEvent,this.RenameText)
        LuaMgr.AddUIEventListener(UIEventConst.CustomRedRefresh,this.OnCustomRedRefresh)
        LuaMgr.AddUIEventListener(UIEventConst.ChangeTitleSettingUpdate,this.UpdateTitle)
        LuaMgr.AddClick(userProtocolBtn, this.OnUserProtocol);
        LuaMgr.AddClick(privacyProtocolBtn, this.OnPrivacyProtocol);
        LuaMgr.AddClick(enableNFCBtn, this.OnEnableNativeNFC);
        isPlayer=false;
        dataVoiceList={}
        if vm.behaviour.Params.Length>0 then
            local page=vm.behaviour.Params[0];
            isPlayer=true;
        end
        this.curBarIndex=nil;
        this.ParseData();
        SetActive(protocolGO, LuaMgr.IsOneSDK());

        SetActive(enableNFCGO, false);
        if assistHeroViewModel~=nil then
            assistHeroViewModel:Clear();
        end
    end,
    after_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end
    end,
    before_deactive = function(vm)
        this.Clear();
        LuaMgr.RemoveUIEventListener(UIEventConst.SettingAvatarChange,this.OnAvatarRefresh)
        LuaMgr.RemoveUIEventListener(UIEventConst.CancelAccountRefresh,this.RefreshCancelAccountBtn)
        LuaMgr.RemoveUIEventListener(UIEventConst.RenameEvent,this.RenameText)
        LuaMgr.RemoveUIEventListener(UIEventConst.CustomRedRefresh,this.OnCustomRedRefresh)
        LuaMgr.RemoveUIEventListener(UIEventConst.ChangeTitleSettingUpdate,this.UpdateTitle)
        LuaMgr.RemoveClick(userProtocolBtn, this.OnUserProtocol);
        LuaMgr.RemoveClick(privacyProtocolBtn, this.OnPrivacyProtocol);
        LuaMgr.RemoveClick(enableNFCBtn, this.OnEnableNativeNFC);
    end,
    before_destroy = function(vm)
        playerDynamicAvatar = nil
        if assistHeroViewModel~=nil then
            assistHeroViewModel:Destroy();
        end
    end
}


this.Clear=function()
    for i,v in ipairs(this.vm.data.systemList) do   
        v.isOn=false;
        v.color= blackColor;
    end

    if spineUICharacter~=nil then
        spineUICharacter:Clear();
    end
    if toggleTimesNum>0 then
        PlayerCharacterMgr.CheckCharacter()
        toggleTimesNum = 0
    end
    PlayerAvatarFrameTool.ClearImage(playerAvatarFrame)
end


this.ParseData=function()
    local msgCount = LuaMgr.GetMsgCount()
    this.vm.data.customCenterRed = msgCount > 0
    local barIndex=isPlayer and 1 or 2;
    if this.vm.behaviour.IsPop then
        if HeroParameter.SettingHeroData~=nil then
            barIndex=3
        end
    end
    this.vm.data.assistBarGray=not PlayerAssistMgr.IsOpen();
    cfg_playerSkin=ConfigMgr.Config.playerSkinMap;
    data_playerSkin=DataMgr.Player.playerSkins;
    this.SetBarList(barIndex,false)
    this.SetTextData();
    this.InitScreenOffSet();
    this.AdjustScreen();
    this.RefreshCancelAccountBtn()
end


this.InitScreenOffSet=function()
    local isHighScreen=LuaMgr.ScreenCompare();
    if isHighScreen then
        this.vm.data.screenOffset=SettingHelper.GetPrefasFloat(ESetting.ScreenOffset)
    end
    this.vm.data.screenViewOtherAnchorPos=isHighScreen and Vector2(0,-430) or Vector2(0,-255);
    this.vm.data.screenOffsetIsOn=isHighScreen;
end

this.ScreenFitSlider=function(value)
    LuaMgr.SetScreenOffset(value);
    SettingHelper.SetPrefsFloat(ESetting.ScreenOffset, value);
    this.AdjustScreen();
end;

this.AdjustScreen=function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    local width = addWidth > 200 and 200 or addWidth;
    this.vm.data.screenViewSize=Vector2(1014 + width, 800);
    this.vm.data.imageQtysSpacing=(40 + math.floor(width / 3));
    this.vm.data.otherCellSize=Vector2(460 + width * 0.5, 71);
end


this.SetTextData=function()
    local cfgSettings=ConfigMgr.Config.settings;
    for i,v in ipairs(cfgSettings) do
        if this.vm.data.textList[i]~=nil then
            this.vm.data.textList[i].isOn=v.comment~=0;
            this.vm.data.textList[i].text=LuaMgr.GetLangText(v.settingsNameLan);
            
        end
    end
end


this.SetBarList=function(barIndex,single)
    if this.curBarIndex~=nil and this.curBarIndex==barIndex then 
        return
    end;
    this.curBarIndex=barIndex;
    if barIndex==3 and  not PlayerAssistMgr.IsOpen() then
        local dungeonId=ConfigMgr.Config.FriendConstants.UnlockCondition;
        local dungeon = ConfigMgr.Config.dungeonMap[dungeonId];
        local unlockInfo=nil
        if dungeon~=nil then
            unlockInfo=LuaMgr.GetLangText(dungeon.NameLan)
        end
        local tips=string.format(ConfigMgr.LangGlobal("22307"),unlockInfo);
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips);
        return;
    end
    for i,v in ipairs(this.vm.data.systemList) do
        v.isOn=i==barIndex;
        v.color=i==barIndex  and blackColor or whiteColor;
    end
    
    this.vm.data.playerInfoPanelBool=barIndex==1;
    this.vm.data.systemSettingPanelBool=barIndex==2;
    this.vm.data.assistPanelBool=barIndex==3;
    if barIndex==3 then
        this.SetAssistHeroPanel();
    elseif barIndex==2 then
        this.SetSubBarList(1,false);
    else
        this.SystemClear();
        this.InitPlayerInfo()
    end
end




this.SystemClear=function()
    for i,v in ipairs(this.vm.data.systemSubList) do
        v.isOn=i==1;
        v.color=whiteColor;
    end
end
this.SetSubBarList=function(subBarIndex,single)
    for i,v in ipairs(this.vm.data.systemSubList) do
        v.isOn=i==subBarIndex;
        v.color=i==subBarIndex and blackColor or whiteColor;
    end

    for i,v in ipairs(this.vm.data.systemPanelBools) do
        v.isOn=i==subBarIndex;
    end
    
    if single~=nil then return end;
    if subBarIndex==1 then
        this.InitImage();
        this.vm.data.screenAnchorPos=Vector2(0,0);
        this.vm.data.systemAnima=screenAnima;
    elseif subBarIndex==2 then
        this.InitVoice();
        this.vm.data.systemAnima=musicAnima;
    elseif subBarIndex==3 then
        this.InitMsg();
        this.vm.data.screenAnchorPos=Vector2(0,0);
        this.vm.data.systemAnima=msgAnima;
    elseif subBarIndex==4 then
        this.InitBattle();
        this.vm.data.screenAnchorPos=Vector2(0,0);
        this.vm.data.systemAnima=fightingAnima;
    elseif subBarIndex==5 then
        this.InitLanguage();
        this.vm.data.systemAnima=languageAnima;
    end
    
end



this.InitImage=function()
    local setting=SettingHelper.GetCurImageQuality();
    this.vm.data.imageQualityLowIsOn=setting.key==ESetting.Image_QualityLow.key;
    this.vm.data.imageQualityMiddleIsOn=setting.key==ESetting.Image_QualityMiddle.key;
    this.vm.data.imageQualityHighIsOn=setting.key==ESetting.Image_QualityHigh.key;
    this.vm.data.imageQualityCustomIsOn=setting.key==ESetting.Image_QualityCustom.key;
    curImageQualityKey=setting.key;


    local isOn = SettingHelper.GetPrefasBool(ESetting.Image_Frame);
    this.vm.data.isFrameOn = isOn;

    isOn = SettingHelper.GetPrefasBool(ESetting.Image_FrameBattle);
    this.vm.data.isFrameBattleOn = isOn;
end

this.OnTog_ImageQualityItem=function(isOn,pa)
    if not isOn then return end;
    local setting=SettingHelper.ConverToSetting(pa)
    local targetRenderQuality = 0
    if setting.key==ESetting.Image_QualityLow.key then
        LuaMgr.SetRenderLevel(RenderLevel.LOW)

        this.SetImageRender();
        targetRenderQuality = 1
    elseif setting.key==ESetting.Image_QualityMiddle.key then
        LuaMgr.SetRenderLevel(RenderLevel.MIDDLE)

        this.SetImageRender();
        targetRenderQuality = 2
    elseif setting.key==ESetting.Image_QualityHigh.key then
        LuaMgr.SetRenderLevel(RenderLevel.HIGH)

        this.SetImageRender();
        targetRenderQuality = 3
    elseif setting.key==ESetting.Image_QualityCustom.key then
        this.SetCustomRender();
        targetRenderQuality = 4
    end
    curImageQualityKey=setting.key;
    SettingHelper.SetPrefsInt(ESetting.Image_CurrentQulity,setting.value);
    LuaMgr.SwitchRenderQuality(DataMgr.Player.uid, targetRenderQuality)
    LuaMgr.SetScreen();
    SettingHelper.UpdateFrame(false);
end

this.OnClick_OtherQualityItem=function(pa)
    local setting=SettingHelper.ConverToSetting(pa)
    local isOn=SettingHelper.GetPrefasBool(setting)
    SettingHelper.SetPrefsBool(setting,not isOn);
    SettingHelper.SetItemRender(setting,not isOn);
    this.SetButtonState(setting,not isOn);
    
    if setting.key==ESetting.Image_Frame.key or setting.key==ESetting.Image_FrameBattle.key then
        return;
    end

    if curImageQualityKey~=nil and curImageQualityKey~=ESetting.Image_QualityCustom.key then
        SettingHelper.SetPrefsInt(ESetting.Image_CurrentQulity,ESetting.Image_QualityCustom.value)
        this.vm.data.imageQualityCustomIsOn=true;
    end
    
end

this.ClickResLevel=function(level)
    local setting = SettingHelper.ConverToSetting(401);
    SettingHelper.SetPrefsInt(ESetting.Image_ResLevel, level);

    if curImageQualityKey~=nil and curImageQualityKey~=ESetting.Image_QualityCustom.key then
        SettingHelper.SetPrefsInt(ESetting.Image_CurrentQulity,ESetting.Image_QualityCustom.value);
        this.vm.data.imageQualityCustomIsOn=true;
    end
    SettingHelper.SetItemRender(setting, level);
    this.SetButtonState(setting, level);
end

this.SetButtonState=function(setting,value)
    if setting.key==ESetting.Image_Render.key then
        this.vm.data.isRenderOn=value;
    elseif setting.key==ESetting.Image_ResLevel.key then
        this.SetResLevel(value);
    elseif setting.key==ESetting.Image_Frame.key then
        this.vm.data.isFrameOn=value;
    elseif setting.key==ESetting.Image_FrameBattle.key then
        this.vm.data.isFrameBattleOn=value;
    elseif setting.key==ESetting.Image_Spine.key then
        this.vm.data.isSpineOn=value;
    elseif setting.key==ESetting.Image_Shadow.key then
        this.vm.data.isShadowOn=value;
    end
end


this.SetImageRender=function()

    local isOn = LuaMgr.GetRenderLevelEnable("RenderQuality");
    this.vm.data.isRenderOn = isOn;
    SettingHelper.SetPrefsBool(ESetting.Image_Render,isOn);

    local level = LuaMgr.GetRenderLevelValue("ArtLevel");
    this.SetResLevel(level);
    SettingHelper.SetPrefsInt(ESetting.Image_ResLevel,level);








    isOn = LuaMgr.GetRenderLevelEnable("SpineEnable");
    this.vm.data.isSpineOn = isOn;
    SettingHelper.SetPrefsBool(ESetting.Image_Spine,isOn);

    isOn = LuaMgr.GetRenderLevelEnable("HeightShadow");
    this.vm.data.isShadowOn = isOn;
    SettingHelper.SetPrefsBool(ESetting.Image_Shadow,isOn);
end


this.SetCustomRender=function()

    local isOn = SettingHelper.GetPrefasBool(ESetting.Image_Render);
    this.vm.data.isRenderOn = isOn;

    local level =  SettingHelper.GetPrefasInt(ESetting.Image_ResLevel);
    this.SetResLevel(level);







    isOn = SettingHelper.GetPrefasBool(ESetting.Image_Spine);
    this.vm.data.isSpineOn = isOn;

    isOn = SettingHelper.GetPrefasBool(ESetting.Image_Shadow);
    this.vm.data.isShadowOn = isOn;
end


this.InitVoice=function()
    this.vm.data.musicVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_MusicVolume);
    this.vm.data.soundVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_SoundVolume);
    this.vm.data.voiceVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_VoiceVolume);

    this.vm.data.battleMusicVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_MusicVolume_Battle);
    this.vm.data.battleSoundVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_SoundVolume_Battle);
    this.vm.data.battleVoiceVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_VoiceVolume_Battle);

    this.vm.data.novelMusicVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_MusicVolume_Novel);
    this.vm.data.novelSoundVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_SoundVolume_Novel);
    this.vm.data.novelVoiceVolume=SettingHelper.GetPrefasFloat(ESetting.Audio_VoiceVolume_Novel);
    
end

this.OnClick_VolumeItemOff=function(index)
    this.OnSlider_VolumeItem(SettingHelper.CMIN,index)
end


this.OnClick_VolumeItemOn=function(index)
    this.OnSlider_VolumeItem(SettingHelper.CMAX,index)
end

this.OnSlider_VolumeItem=function(value,index)
    local setting=SettingHelper.ConverToSetting(index)
    if setting.key==ESetting.Audio_MusicVolume.key then
        this.vm.data.musicVolume=value;
    elseif setting.key==ESetting.Audio_SoundVolume.key then
        this.vm.data.soundVolume=value;
    elseif setting.key==ESetting.Audio_VoiceVolume.key then
        this.vm.data.voiceVolume=value;
    elseif setting.key==ESetting.Audio_MusicVolume_Battle.key then
        this.vm.data.battleMusicVolume=value;
    elseif setting.key==ESetting.Audio_SoundVolume_Battle.key then
        this.vm.data.battleSoundVolume=value;
    elseif setting.key==ESetting.Audio_VoiceVolume_Battle.key then
        this.vm.data.battleVoiceVolume=value;

    elseif setting.key==ESetting.Audio_MusicVolume_Novel.key then
        this.vm.data.novelMusicVolume=value;
    elseif setting.key==ESetting.Audio_SoundVolume_Novel.key then
        this.vm.data.novelSoundVolume=value;
    elseif setting.key==ESetting.Audio_VoiceVolume_Novel.key then
        this.vm.data.novelVoiceVolume=value;
        
    end
    SettingHelper.SetPrefsFloat(setting,value);
    if index<3 then
        AudioMgr.Singleton:ResetBaseVolume(0);
    end
end
    



this.InitMsg=function()
    this.vm.data.levelUpRed_allHero=SettingHelper.GetPrefasBool(ESetting.Msg_LevelUpRed_AllHero);
    this.vm.data.levelUpRed_commonlyHero=SettingHelper.GetPrefasBool(ESetting.Msg_LevelUpRed_CommonlyHero);
    this.vm.data.levelUpRed_close=SettingHelper.GetPrefasBool(ESetting.Msg_LevelUpRed_Close);
    this.vm.data.talentRed_allHero=SettingHelper.GetPrefasBool(ESetting.Msg_TalentRed_AllHero);
    this.vm.data.talentRed_commonlyHero=SettingHelper.GetPrefasBool(ESetting.Msg_TalentRed_CommonlyHero);
    this.vm.data.talentRed_close=SettingHelper.GetPrefasBool(ESetting.Msg_TalentRed_Close);
    this.vm.data.zzRed_allHero=SettingHelper.GetPrefasBool(ESetting.Msg_ZZRed_AllHero);
    this.vm.data.zzRed_commonlyHero=SettingHelper.GetPrefasBool(ESetting.Msg_ZZRed_CommonlyHero);
    this.vm.data.zzRed_close=SettingHelper.GetPrefasBool(ESetting.Msg_ZZRed_Close);
    this.vm.data.allMsgIsOn=SettingHelper.GetPrefasBool(ESetting.Msg_All);
    this.vm.data.powerMDoneMsgIsOn=SettingHelper.GetPrefasBool(ESetting.Msg_PowerDone);
    this.vm.data.dispatchDoneMsgIsOn=SettingHelper.GetPrefasBool(ESetting.Msg_DispatchDone);
    this.vm.data.weaponMakeMsgIsOn=SettingHelper.GetPrefasBool(ESetting.Msg_WeaponMake);
    this.vm.data.searchMsgIsOn=SettingHelper.GetPrefasBool(ESetting.Msg_Search);
    this.vm.data.specialityRed_allHero=SettingHelper.GetPrefasBool(ESetting.Msg_LPRed_AllHero);
    this.vm.data.specialityRed_commonlyHero=SettingHelper.GetPrefasBool(ESetting.Msg_LPRed_CommonlyHero);
    this.vm.data.specialityRed_close=SettingHelper.GetPrefasBool(ESetting.Msg_LPRed_Close);
    this.vm.data.zztxkRed_close = SettingHelper.GetPrefasBool(ESetting.Msg_ZZTXKRed_Close);
    this.vm.data.zztxkRed_open = SettingHelper.GetPrefasBool(ESetting.Msg_ZZTXKRed_Open);
    this.vm.data.hzRed_allHero=SettingHelper.GetPrefasBool(ESetting.Msg_HZRed_AllHero);
    this.vm.data.hzRed_commonlyHero=SettingHelper.GetPrefasBool(ESetting.Msg_HZRed_CommonlyHero);
    this.vm.data.hzRed_close=SettingHelper.GetPrefasBool(ESetting.Msg_HZRed_Close);
    local isClose = SettingHelper.GetPrefasBool(ESetting.Msg_QZZJRed_Close);
    local isAuto = SettingHelper.GetPrefasBool(ESetting.Msg_QZZJRed_Auto);
    local isMax = SettingHelper.GetPrefasBool(ESetting.Msg_QZZJRed_Max);
    if (not isAuto and not isClose and not isMax) then
        isAuto = true;
    end
    this.vm.data.qzzjRed_close = isClose;
    this.vm.data.qzzjRed_auto = isAuto;
    this.vm.data.qzzjRed_max = isMax;
    this.vm.data.equipPopup_Close = SettingHelper.GetPrefasBool(ESetting.Msg_EquipPopup_Close);
    this.vm.data.equipPopup_TodayClose = SettingHelper.GetPrefasBool(ESetting.Msg_EquipPopup_TodayClose);
    this.vm.data.equipPopup_Open = SettingHelper.GetPrefasBool(ESetting.Msg_EquipPopup_Open);
end

this.OnTog_MsgItem=function(isOn,index)
    local setting=SettingHelper.ConverToSetting(index);
    if setting.value>=150 and setting.value<=155 then
        LuaMgr.InvokeUIEventListeners(UIEventConst.SettingMsgRed,setting.key,isOn);
    end
    SettingHelper.SetPrefsBool(setting,isOn);
    toggleTimesNum = toggleTimesNum+1
end






this.InitBattle=function()
    this.vm.data.attackFocusIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_AttackFocus);
    this.vm.data.trickAnimationIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_TrickAnimation);
    this.vm.data.screenShakeIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_ScreenShake);
    this.vm.data.buffBubblesIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_BuffBubbles);
    this.vm.data.hpBarIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_HPBar);
    this.vm.data.hpMarkIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_HpMark);
    this.vm.data.characterInfoIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_CharcterInfo);
    this.vm.data.oldPrediction=SettingHelper.GetPrefasBool(ESetting.Fight_OldPrediction);
    this.vm.data.idleIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_Idle);
    this.vm.data.previewIsOn=SettingHelper.GetPrefasBool(ESetting.Fight_Preview);
    this.vm.data.hpBarMode1 = SettingHelper.GetPrefasBool(ESetting.Fight_HpBarMode1)
    this.vm.data.hpBarMode2 = SettingHelper.GetPrefasBool(ESetting.Fight_HpBarMode2)
    this.vm.data.fiveSpeedTimeline=SettingHelper.GetPrefasBool(ESetting.Fight_FiveSpeedTimeline);
    this.vm.data.previewInfo = SettingHelper.GetPrefasBool(ESetting.Fight_PreviewInfo);
end

this.OnTog_FightingItem=function(isOn,index)
    local setting=SettingHelper.ConverToSetting(index);
    SettingHelper.SetPrefsBool(setting,isOn);
end


this.InitLanguage=function()
    this.vm.data.languageCnIsOn=SettingHelper.GetPrefasBool(ESetting.Language_CN)
    this.vm.data.languageTwIsOn=SettingHelper.GetPrefasBool(ESetting.Language_TW)
    this.vm.data.voiceList={}
    dataVoiceList={}
    for i,v in pairs(ConfigMgr.Config.RESDownloadMap) do
        if v.RESOn==1 then
            table.insert(dataVoiceList,v);
        end
    end
    this.vm.data.voiceOtherBool=#dataVoiceList>1
    table.sort(dataVoiceList,function(a, b) return a.Id<b.Id end)
    local list={}
    for i,v in ipairs(dataVoiceList) do
        local voiceType={
            isOn=i==voiceTypeIndex,
            text=LuaMgr.GetLangText(v.RESNameLan)
        }
        table.insert(list,voiceType)
    end
    this.vm.data.voiceList=list;
end

this.OnTog_LanguageItem=function(isOn,index)
    local setting=SettingHelper.ConverToSetting(index);
    SettingHelper.SetPrefsBool(setting,isOn);
end












this.InitPlayerInfo=function()
    this.SetUserBaseInfo();
    local addWidth=LuaMgr.GetScreenAddWidth();
    this.vm.data.playerCVSize=Vector2(1220+addWidth,558);
    this.vm.data.copyBool=false;
    this.vm.data.maskBool=false;
    this.vm.data.playerId= LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["1001"].NameLan);
    this.OnAvatarRefresh();
    this.vm.data.useCenter=this.UseCenterInfo();
    this.vm.data.isShowCustomCenter=true;
    this.vm.data.isChargeCDKey=ConfigMgr.Config.constants.CdKeyOpen~=nil and ConfigMgr.Config.constants.CdKeyOpen==1;
    this.vm.data.isCameraUnLock = not FeatureManager.IsLock("30090");
    RedMgr.Singleton:Refresh();
    
end

this.SetUserBaseInfo=function()
    this.vm.data.showMotto = ConfigMgr.Config.FriendConstants.PlayerInfoMotto > 0
    this.vm.data.secretaryBool=true;
    this.SetBrithDay(DataMgr.Player.birthday);
    local title = ConfigHelper.GetTitleConfig(DataMgr.Player.currentTitle)
    if not TableIsNull(title) then
        this.vm.data.playerTitle = LuaMgr.GetSprite("PlayerTitle",title.img)
        this.vm.data.playerTitleText = LuaMgr.GetLangText(title.namelan)
        if title.img == "Title_40001" then
           this.vm.data.titleTextPos =  Vector2(2,1)
        else
           this.vm.data.titleTextPos =  Vector2(10,1)
        end
    end
    this.vm.data.userName=DataMgr.Player.name;
    this.vm.data.userID=DataMgr.Player.uid;
    mottoInputField.text = DataMgr.Player.motto;
    this.vm.data.userLevel=tostring(DataMgr.Player.level);
    local challengeName,isComplete=this.GetCurrentChallengeName();
    
    if challengeName~=nil then
        this.vm.data.challengeSize=LuaMgr.GetStringLength(challengeName)<=10 and
                Vector2(134,52) or Vector2(134,62);
        this.vm.data.userChallenge=challengeName;
        this.vm.data.userChallengeCompleteBool=isComplete;
    end
    
    this.vm.data.characterChallenge=string.format("<color=#1c6f6c><size=19>%s</size></color>/%s",
            NumTool.GetLen(DataMgr.Player.characters),this.GetHeroCount());
    this.vm.data.equipmentChallenge=string.format("<color=#1c6f6c><size=19>%s</size></color>/%s",
            NumTool.GetLen(DataMgr.Player.equipmentFiles),NumTool.GetLen(ConfigMgr.Config.equipments))
    this.vm.data.characterChallengeFill=NumTool.GetLen(DataMgr.Player.characters)/this.GetHeroCount()
    this.vm.data.equipmentChallengeFill=NumTool.GetLen(DataMgr.Player.equipmentFiles)/NumTool.GetLen(ConfigMgr.Config.equipments);
    
    this.SetExp();
    this.SetCharactor();
    this.SetSeal();
    this.SetZhanXun()
    this.SetAssistHeroList();
end

this.UpdateTitle = function()
    local title = ConfigHelper.GetTitleConfig(DataMgr.Player.currentTitle)
    if not TableIsNull(title) then
        this.vm.data.playerTitle = LuaMgr.GetSprite("PlayerTitle",title.img)
        this.vm.data.playerTitleText = LuaMgr.GetLangText(title.namelan)
        if title.img == "Title_40001" then
           this.vm.data.titleTextPos =  Vector2(2,1)
        else
           this.vm.data.titleTextPos =  Vector2(10,1)
        end
    end
end


this.SetBrithDay=function(birthday)
    if birthday=="" then
        this.vm.data.playerBirthDay=LuaMgr.GetLangText("SystemSettingViewModel_0")
        return;
    end
    local value=string.sub(DataMgr.Player.birthday,6,10);
    local briths=NumTool.split(value,"/");
    this.vm.data.playerBirthDay=string.format(LuaMgr.GetLangText("SystemSettingViewModel_3"),briths[1],briths[2]);
end



this.GetCurrentChallengeName=function()
    local isComplete=false;
    local challengeNameLan=nil;
    local lastMainEvent = DataMgr.Player.lastMainEvent;
    if not IsNullOrEmpty(lastMainEvent) then
        challengeNameLan, isComplete = DataHelper.GetNextChallengeName(lastMainEvent, DataMgr.Player.completedAreaEvents)
    else
        challengeNameLan= ConfigMgr.Config.narrativeMap["M0001001"].nameLan;    
    end
    
    return LuaMgr.GetLangText(challengeNameLan),isComplete;
end


this.SetExp=function()
    local levelUp=ConfigMgr.Config.playerLevelUp[tostring(DataMgr.Player.level)];
    local nextLevelUp=ConfigMgr.Config.playerLevelUp[tostring(DataMgr.Player.level+1)];
    
    if nextLevelUp~=nil then
        local totalExp=nextLevelUp.exp-levelUp.exp;
        local nowExp=DataMgr.Player.exp-levelUp.exp;
        if nowExp<=0 then
            this.vm.data.playerExp=tostring(0);
            this.vm.data.expScaleData=Vector3(0,0,0);
        else
            this.vm.data.playerExp=tostring(nowExp/totalExp);
            this.vm.data.expScaleData=Vector3(nowExp/totalExp,1,1);
        end
    else
        this.vm.data.playerExp=tostring(0);
        this.vm.data.expScaleData=Vector3(0,0,0);
    end
end

this.SetCharactor=function()
    
    local curSkinId=nil;
    for i,v in pairs(data_playerSkin) do
        if v then
            curSkinId=i;
            break;
        end
    end
    if curSkinId==nil then
        curSkinId=DataMgr.Player.sex>1 and "SCJ102" or "SCJ101";
    end
    local unlock=curSkinId~="SCJ101" and curSkinId~= "SCJ102"
    this.vm.data.userTeamLock=not unlock;
    this.vm.data.unLockRawImgBool=not unlock;
    local skinInfo=cfg_playerSkin[curSkinId];
    local teamInfo=LuaMgr.GetLangText(skinInfo.TypeDisplayLan);

    this.vm.data.userTeam=teamInfo;
    this.vm.data.userTeamIcon=LuaMgr.GetSprite("PlayerFigure",skinInfo.TypeEnterPic)
    this.vm.data.userTeamIcon_b=LuaMgr.GetSprite("PlayerFigure",skinInfo.TypeEnterPic.."_b")
    
    if not unlock then
        local imgName= DataMgr.Player.sex>1 and "SCJ102" or "SCJ101";
        this.vm.data.unLockRawImg=LuaMgr.GetTexture("Assets/_BundleResources/Images/PlayerSKin/"..imgName..".png");
        return;
    end
    
    local path=HeroManager.SetCharacterDrawing(spineUICharacter,curSkinId);
    if path~="" then
        this.vm.data.bodyRawBool=true;
        this.vm.data.characterPath=path;
    end
end


this.SetSeal=function()
    local sealCharacterIds=DataMgr.Player.friendShipSeal;
    for i=1,7,1 do
        if sealCharacterIds[i]~=nil and sealCharacterIds[i]~="" then
            local iconId=ConfigMgr.Config.characterPreferences[sealCharacterIds[i]].friendshipTalent[10][1]
            this.vm.data.sealList[i].isOn=true;
            this.vm.data.sealList[i].texture=LuaMgr.GetTexture(Path.Image.."FriendlyIcon/friendly_"..iconId..".png");
        else
            this.vm.data.sealList[i].isOn=false;
        end
    end
end

this.SetZhanXun = function()
    PlayerMedalMgr.Init()
    local dedalDisplay = DataMgr.Player.MedalDisplay
    local length = #dedalDisplay
    local sprite = nil
    for i = 1, 9 do
        if length >= i then
            sprite = LuaMgr.GetSprite("ZhanXunIcon", dedalDisplay[i])
            this.vm.data.zhanXunList[i].icon = sprite
            this.vm.data.zhanXunList[i].isOn = true
        else
            this.vm.data.zhanXunList[i].icon = nil
            this.vm.data.zhanXunList[i].isOn = false
        end
    end
end

this.SetAssistHeroList=function()
    this.vm.data.assistList={}
    this.vm.data.assistHeroScrollViewIsHorizontal=false;
    if not PlayerAssistMgr.IsOpen() then
        return 
    end
    if IsNull(DataMgr.Player.FriendHelp) or IsNull(DataMgr.Player.FriendHelp.HelpCharacterIds)
    or #DataMgr.Player.FriendHelp.HelpCharacterIds==0 then
        return
    end
    local list={}
    local tempRare,imageRare = nil,nil
    for i,v in ipairs(DataMgr.Player.FriendHelp.HelpCharacterIds) do
        local character=DataMgr.Player.characters[v];
        if character~=nil then
            local cfgCharacter=ConfigMgr.Config.characterTable[v]
            local item={
                id=v,
                img=LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(character.id,character.curSkin));
                level=tostring(character.level);
                rare=nil;
                job=LuaMgr.GetSprite("JobIcon","jobtips_"..cfgCharacter.job);
            }
            tempRare = HeroMgr.GetHeroNowRare(cfgCharacter.id)
            imageRare = tempRare >= 5 and 4 or tempRare
            item.rare = LuaMgr.GetSprite("AssistRare","ui_sz_qzyz_tx0"..imageRare)
            table.insert(list,item);
        end
    end
    this.vm.data.assistList=list;
    this.vm.data.assistHeroScrollViewIsHorizontal=#list>3;
end

this.CopyToClipboard=function()
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("PlayerInfoViewModel_1"));
    this.vm.data.maskBool=false;
    local input = DataMgr.Player.uid;
    LuaMgr.DoCopyText(input);
end

this.OnAvatarRefresh=function()
    local avatarData=nil;
    local frameData=nil;
    for i,v in ipairs(ConfigMgr.Config.avatarFrames) do
        if v.id==DataMgr.Player.Avatar then
            avatarData=v;
        elseif v.id==DataMgr.Player.currentAvatarFrame then
            frameData=v;
        end
        if avatarData~=nil and frameData~=nil then
            break;
        end
    end
    if avatarData~=nil then
        if avatarData.imgType == 1 then
            local avatarPath=ConfigHelper.GetHeadIconPath(avatarData.img,avatarData.imgId);
            this.vm.data.playerAvatar=LuaMgr.GetTexture(avatarPath);
        else

            playerDynamicAvatar:AppointAvatar(avatarData.id)
        end
        this.vm.data.playerAvatarIsShow = avatarData.imgType == 1
        this.vm.data.isDynamicAvatar = avatarData.imgType == 2
    end
    if frameData~=nil then
        PlayerAvatarFrameTool.SetAvatarFrame(playerAvatarFrame, frameData.id)

    end
end

this.RefreshCancelAccountBtn = function()
    if DataMgr.Player.status == 4 then
        this.vm.data.cancelAccountBtnText = LuaMgr.GetLangText("SystemSettingViewModel_1")
    else
        this.vm.data.cancelAccountBtnText = LuaMgr.GetLangText("SystemSettingViewModel_2")
    end
end
this.GetHeroCount = function()
    local curTime=LuaMgr.Timestamp();
    local allCount = 0
    for key, value in pairs(ConfigMgr.Config.characterTable) do
        if value.CharacterType == 1 and value.Switch == 0 and (value.UnlockDate==0 or value.UnlockDate<=curTime) then
            allCount = allCount + 1
        end
    end
    return allCount
end
this.UseCenterInfo=function()
    for i,v in ipairs(ConfigMgr.Config.ShareChannel) do
        if v.Usercenter and v.ChannelId==LuaMgr.GetChanel() then
            return false;
        end
    end
    return true;
end

this.SetResLevel = function(level)
    this.vm.data.isResLevelHigh = level == RenderLevel.HIGH;
    this.vm.data.isResLevelMedium = level == RenderLevel.MIDDLE;
    this.vm.data.isResLevelLow = level == RenderLevel.LOW;
end


this.OnUserProtocol = function()
    LuaMgr.ShowUserProtocol();
end


this.OnPrivacyProtocol = function()
    LuaMgr.ShowPrivacyProtocol();
end


this.OnEnableNativeNFC = function()
    LuaMgr.EnableNativeNFC();
end

this.RenameText = function()
    this.vm.data.userName = DataMgr.Player.name
end

this.OnMottoEndEdit = function(str)
    local askData={motto=str};
    ApiMgr.Request("update_motto",askData,true,function()
        mottoInputField.text = DataMgr.Player.motto;
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("PlayerInfoViewModel_0"))
    end,nil,true);
end

this.OnCustomRedRefresh = function(args) 
    local redCount = args[0]
    this.vm.data.customCenterRed = redCount > 0
    HeroRedDataHelper.UpdateSettingRed(redCount)
end


this.SetAssistHeroPanel=function()
    if assistHeroViewModel==nil then
        local class = _G["SettingAssistHeroViewModel"];
        if (class ~= nil) then
            assistHeroViewModel = class.New();
            assistHeroViewModel.gameObject = this.assistPanelObj;
            assistHeroViewModel.transform = this.assistPanelObj.transform;
            assistHeroViewModel.headGroupObj=this.headGroup;
            assistHeroViewModel.headItemObj=this.headItem;
            assistHeroViewModel.cardItemObj=this.cardItem;
            assistHeroViewModel:Init();
        end
    end
    assistHeroViewModel:SetData();
end



return vm({
    data = data,
    command = command,
    hook = hook
})