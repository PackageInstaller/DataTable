




require("ViewModel/Home/MainPageViewModelRed")
require("ViewModel/FriendChat/FriendChatMgr")
require("ViewModel/Home/CharacterHighSkin")
require("ViewModel/TeamTower/TeamTowerMgr")



local this = {
    vm = nil,
    snacksTimer = 0,
    travelTimer=0,
    limitSSRTimer = 0,
    curCharacterId = "",
    characterMsg = nil,
    characterMsgVM = nil,
    activityIndex = 1,
    isInitBanner = false,
    bannerScrollCenter = nil,
    bannerIndex = 0,
    bannerTime = 0,
    isAutoBanner = true,
    bannerData = nil,
    timeIndex = -1,
    timePeriods = {"zi", "chou", "yin", "mao", "chen", "si", "wu", "wei", "shen", "you", "xu", "hai"},
    otherBtnUIAnimatorList = {},
    otherBtnsTr = nil,
    otherBtnShowIndex = 0,
    playerDynamicAvatar = nil,
    playerAvatarFrame = nil,
    isHighSkin=false,
    lastHighSkinClick=nil,
    currentTimePeriod = -1,
    newButtonTransform = nil,
    newButtonIndex = 1,
}

local ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png";
local TIME_ANI001 = "ani_ui_zhujiemian_time_001";
local TIME_ANI002 = "ani_ui_zhujiemian_time_002";
local HERO_VIDEO_PATH = "Video/%s.mp4"
local data = {
    playerLevel = "",
    playerName = "",
    playerTitle = DefaultSprite,
    playerTitleText = "",
    titleTextPos = Vector2.zero,
    playerExp = 0,
    playerId = "",
    bodyPath = "",
    isLockQZ = false,
    isLockZX = false,
    isLockBC = false,
    isLockZM = false,
    isLockSJZJ = false,
    isLockPQGS = false,
    isLockMission = false,
    isLockStore = false,
    isLockCharge = false,
    isLockWarehouse = false,
    isLockZD = false,
    isLockTravel = false,
    stamina = "",
    maxStamina = "",
    staminaIcon = DefaultTexture,
    isTest = false,
    isLockHD = false,
    isLockZBZZ = false,
    isLockQH = false,
    isLockSetting = false,
    isLockMail = false,
    isLockTB = false,
    isClickStamina = false,
    isGLZ = false,
    
    isClickZD = false,
    isClickQH = false,
    isClickSetting = false,
    isClickMail = false,
    isClickTB = false,
    isTraffic=false,
    isFriendUnLock=false;
    isGuildUnLock = false,
    uiPanelAniName = "",
    snacksInfo = "",
    snacksBool = false,
    snacksRewardBool = false,
    playerAvatar = DefaultTexture,
    playerAvatarShow = false,
    dynamicAvatarShow = false,
    bannerContentBool = false,
    bannerItemDatas = {{url=""}},
    bannerHuadongDatas = {{huadong=DefaultSprite}},
    activityDataBig = {{icon=DefaultSprite,isShow=false,redId="", 
smallIcon = DefaultSprite, smallIconAnchPos = Vector2.zero, smallIconScale = Vector3.zero}};
activityDataSmall = {{icon=DefaultSprite,redId="",isShowTime=false,time=""}};
    trafficePermitTime="",

    isShowLeftDropCardItemCount = false,
    leftDropCardItemIcon = DefaultTexture,
    leftDropCardItemCount = "",
    
    sjzjRedIconId = "",
    isTeaStatus = false,
    isIdleStatus = false,
    isItemStatus = false,
    isStaminaStatus = false,
    b_TimeRed = false,
    b_PointRed = false,
    character_ConfigPos=Vector2(0,0),
    character_Scale=Vector3.one,
    siginRed = false,
    bgTexture=DefaultTexture,
    isHomeBG001 = false,
    isQHDot = false,


    isLimitSSROpen = false,
    isShowLimitSSRTimer = false,
    limitSSRTimeText = "",
    

    isLimitEquipOpen = false,
    isShowLimitEquipTimer = false,
    limitEquipTimeText = "",


    isLimitBreakOpen = false,
    isShowLimitBreakTimer = false,
    limitBreakTimeText = "",
    videoPanel=false;
    playingPV=false;


    topBtnRoot = false,
    topBtnRed = false,
    bottomRoot = false,
    bottomRed = false,
    buttonViewPos = Vector2.zero
}

local objs = {
    timeAnimator = { path = "root/Middle/Time", type = "UIAnimator" },
    time1CanvasGroup = { path = "root/Middle/Time/Time1", type = "CanvasGroup" },
    time1Icon1 = { path = "root/Middle/Time/Time1/Icon1", type = "Image" },
    time1Icon2 = { path = "root/Middle/Time/Time1/Icon2", type = "Image" },
    time1Icon3 = { path = "root/Middle/Time/Time1/Icon3", type = "Image" },
    time1Icon4 = { path = "root/Middle/Time/Time1/Icon4", type = "Image" },
    time1Icon5 = { path = "root/Middle/Time/Time1/Icon5", type = "Image" },
    time2CanvasGroup = { path = "root/Middle/Time/Time2", type = "CanvasGroup" },
    time2Icon2 = { path = "root/Middle/Time/Time2/Icon2", type = "Image" },
    time2Icon3 = { path = "root/Middle/Time/Time2/Icon3", type = "Image" },
    time2Icon4 = { path = "root/Middle/Time/Time2/Icon4", type = "Image" },
    time2Icon5 = { path = "root/Middle/Time/Time2/Icon5", type = "Image" },
}


this.FirstMainPage = function()
    if (DataHelper.firstMainPage) then
        PlayerCharacterMgr.CheckCharacter()
        PlayerRhythmGameMgr.InitNewDotData()
        PlayerSlgMgr.InitSlgNewDotData()
        PlayerZGCXMgr.InitMainAreaUnlockData()
        DataHelper.firstMainPage = false;
        PopUpMgr.canShowIosUrlInterface = true
        if (not LuaMgr.IsGuide()) then

            if DataExHelper.Check_ComeBackActivity() then
                if IsNullOrEmpty(DataMgr.Player.backPlayer.completeChapter) then
                    local callback = function()
                        LuaMgr.InvokeUIEventListeners(UIEventConst.FirstMainPage);
                        LuaMgr.ShowLuaPanel(UIName.MainPageViewModel)
                    end
                    LuaMgr.PlayNovel(ConfigMgr.Config.constants.BackPlayerNarrative,callback) 
                else
                    LuaMgr.InvokeUIEventListeners(UIEventConst.FirstMainPage);
                end
            else
                LuaMgr.InvokeUIEventListeners(UIEventConst.FirstMainPage);
            end
        end
        this.PlaySkinVideo();
    else
        PopUpMgr.canShowIosUrlInterface = false
    end
end


this.EmptyPanelParam = function()
    if not LuaMgr.IsShowMainPagePop() then
        return
    end
    PanelParamMgr.EmptyPanelParam();
    PlayerAreaMgr.SetAreaDungeonId(nil);
    PlayerAssistMgr.Clear();
    LuaMgr.SetRogueDataByNovel(nil,nil);
end


this.RefreshAvatar = function()
    if TableIsNull(ConfigMgr.Config.avatarFrames) then
        return
    end
    local currentAvatar = DataMgr.Player.Avatar
    local length = #ConfigMgr.Config.avatarFrames
    local avatarConfig = nil
    if not IsNullOrEmpty(currentAvatar) then
        for i = 1, length do
            if ConfigMgr.Config.avatarFrames[i].id == currentAvatar then
                avatarConfig = ConfigMgr.Config.avatarFrames[i]
                break
            end
        end
    end
    if not TableIsNull(avatarConfig) then
        if avatarConfig.imgType == 1 then
            local avatarPath = ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId);
            this.vm.data.playerAvatar = LuaMgr.GetTexture(avatarPath);
        else

            this.playerDynamicAvatar:AppointAvatar(avatarConfig.id)
        end
        this.vm.data.playerAvatarShow = avatarConfig.imgType == 1
        this.vm.data.dynamicAvatarShow = avatarConfig.imgType == 2
    end

    avatarConfig = nil
    local currentAvatarFrame = DataMgr.Player.currentAvatarFrame
    for i = 1, length do
        if ConfigMgr.Config.avatarFrames[i].id == currentAvatarFrame then
            avatarConfig = ConfigMgr.Config.avatarFrames[i]
            break
        end
    end
    if not TableIsNull(avatarConfig) then
        PlayerAvatarFrameTool.SetAvatarFrame(this.playerAvatarFrame,avatarConfig.id)

    end
end


this.UpdateFatigueTime = function()
    local level = tostring(DataMgr.Player.level);
    local levelUp = ConfigMgr.Config.playerLevelUp[level];
    if (DataMgr.Player.stamina >= levelUp.staminaLimit) then return end
    
    local staminaRecoverInterval = ConfigMgr.Config.constants.staminaRecoverInterval * 60;
    local lastRecoverStaminaTime = DataMgr.Player.lastRecoverStaminaTime;
    local count = levelUp.staminaLimit * staminaRecoverInterval;
    LuaMgr.AddTimer(TimerConst.StaminaTime, function()
        local pastTime = LuaMgr.Timestamp() - lastRecoverStaminaTime;
        local residueTime = (staminaRecoverInterval - (pastTime % staminaRecoverInterval));
        if (residueTime <= 1) then
            DataMgr.Player.stamina = DataMgr.Player.stamina + 1;
            this.vm.data.stamina = tostring(DataMgr.Player.stamina);
            if (DataMgr.Player.stamina == levelUp.staminaLimit) then
                LuaMgr.RemoveTimer(TimerConst.StaminaTime);
            end
        end
    end, 1, count, true);
end


this.SetButtonStatus = function()
    this.vm.data.isLockQZ = FeatureManager.IsLock("1002");
    this.vm.data.isLockZX = FeatureManager.IsLock("2000");
    this.vm.data.isLockBC = FeatureManager.IsLock("1021");
    this.vm.data.isLockZM = FeatureManager.IsLock("1009");
    this.vm.data.isLockSJZJ = FeatureManager.IsLock("1009");
    this.vm.data.isLockZBZZ = FeatureManager.IsLock("1400");
    this.vm.data.isLockPQGS = FeatureManager.IsLock("1302");
    this.vm.data.isLockHD = false;
    this.vm.data.isLockZD = FeatureManager.IsLock("1100");
    this.vm.data.isLockTravel = false;
    this.vm.data.isClickZD = not FeatureManager.IsLock("1100");
    this.vm.data.isLockMission = FeatureManager.IsLock("1016");
    this.vm.data.isLockStore = FeatureManager.IsLock("1200");
    this.vm.data.isLockCharge = FeatureManager.IsLock("1200") or FeatureManager.IsLock("1210");
    this.vm.data.isLockWarehouse = FeatureManager.IsLock("1019");
    this.vm.data.isLockQH = FeatureManager.IsLock("1022");
    this.vm.data.isClickQH = not FeatureManager.IsLock("1022");
    this.vm.data.isLockSetting = FeatureManager.IsLock("1034");
    this.vm.data.isClickSetting = not FeatureManager.IsLock("1034");
    this.vm.data.isLockMail = FeatureManager.IsLock("1033");
    this.vm.data.isClickMail = not FeatureManager.IsLock("1033");
    this.vm.data.isLockTB = FeatureManager.IsLock("1035");
    this.vm.data.isClickTB = not FeatureManager.IsLock("1035");
    this.vm.data.isGLZ = ConfigMgr.Config.constants.homeWebOpen == 1
    this.vm.data.isClickStamina = not LuaMgr.IsGuide();
    local isTrafficLock=FeatureManager.IsLock("9001");
    local isNewTrafficActive=not IsNull(DataMgr.Player.passes) and not IsNullOrEmpty(DataMgr.Player.passes.id)
    this.vm.data.isTraffic=not isTrafficLock and (DataExHelper.Check_TrafficPermintRuning() or isNewTrafficActive);
    this.vm.data.isFriendUnLock=not FeatureManager.IsLock("13001")
    this.vm.data.isGuildUnLock= not FeatureManager.IsLock("30305");
    this.vm.data.isLimitSSROpen = ActivityMgr.IsNewPlayerLimitSSRActivityOpen()   
    if this.vm.data.isLimitSSROpen then
        NewPlayerLimitSSRMgr.RefreshData()
        this.vm.data.isShowLimitSSRTimer = NewPlayerLimitSSRMgr.CheckActivityIsShown()
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSREntranceTimer, this.SetLimitSSREntranceLeftTimer, 1, -1, true);
    end
    this.vm.data.isLimitEquipOpen = ActivityMgr.IsNewPlayerLimitEquipActivityOpen()
    if this.vm.data.isLimitEquipOpen then
        NewPlayerLimitEquipMgr.RefreshData()
        this.vm.data.isShowLimitEquipTimer = NewPlayerLimitEquipMgr.CheckActivityIsShown()
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitEquipEntranceTimer, this.SetLimitEquipEntranceLeftTimer, 1, -1, true);
    end
    this.vm.data.isLimitBreakOpen = ActivityMgr.CheckShowPlayerLimitBreakPopup()
    if this.vm.data.isLimitBreakOpen then
        NewPlayerLimitBreakMgr.RefreshData()
        this.vm.data.isShowLimitBreakTimer = NewPlayerLimitBreakMgr.CheckActivityIsShown()
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSREntranceTimer, this.SetLimitBreakEntranceLeftTimer, 1, -1, true);
    end
    
    this.SetOtherBtnStatus()
end

this.SetOtherBtnStatus = function()
    this.otherBtnUIAnimatorList = {}
    if this.vm.data.isGuildUnLock then
        local btn = this.otherBtnsTr:Find("Guild")
        if btn ~= nil then
            local item = {
                anim = btn:GetComponent("Animator"),
                uianimator = btn:GetComponent("UIAnimator"),
                canvasGroup = btn:Find("image"):GetComponent("CanvasGroup")
            }
            table.insert(this.otherBtnUIAnimatorList, item)
        end
    end
    if this.vm.data.isGLZ then
        local btn = this.otherBtnsTr:Find("GLZ")
        if btn ~= nil then
            local item = {
                anim = btn:GetComponent("Animator"),
                uianimator = btn:GetComponent("UIAnimator"),
                canvasGroup = btn:Find("image"):GetComponent("CanvasGroup")
            }
            table.insert(this.otherBtnUIAnimatorList, item)
        end
        
    end
    if this.vm.data.isFriendUnLock then
        local btn = this.otherBtnsTr:Find("Friend")
        if btn ~= nil then
            local item = {
                anim = btn:GetComponent("Animator"),
                uianimator = btn:GetComponent("UIAnimator"),
                canvasGroup = btn:Find("image"):GetComponent("CanvasGroup")
            }
            table.insert(this.otherBtnUIAnimatorList, item)
        end
    end
    if this.vm.data.isLimitSSROpen then
        local btn = this.otherBtnsTr:Find("LimitSSR")
        if btn ~= nil then
            local item = {
                anim = btn:GetComponent("Animator"),
                uianimator = btn:GetComponent("UIAnimator"),
                canvasGroup = btn:Find("image"):GetComponent("CanvasGroup")
            }
            table.insert(this.otherBtnUIAnimatorList, item)
        end
    end
    if this.vm.data.isLimitEquipOpen then
        local btn = this.otherBtnsTr:Find("LimitEquip")
        if btn ~= nil then
            local item = {
                anim = btn:GetComponent("Animator"),
                uianimator = btn:GetComponent("UIAnimator"),
                canvasGroup = btn:Find("image"):GetComponent("CanvasGroup")
            }
            table.insert(this.otherBtnUIAnimatorList, item)
        end
    end
    if this.vm.data.isLimitBreakOpen then
        local btn = this.otherBtnsTr:Find("LimitBreak")
        if btn ~= nil then
            local item = {
                anim = btn:GetComponent("Animator"),
                uianimator = btn:GetComponent("UIAnimator"),
                canvasGroup = btn:Find("image"):GetComponent("CanvasGroup")
            }
            table.insert(this.otherBtnUIAnimatorList, item)
        end
    end
    if #this.otherBtnUIAnimatorList == 0 then
        return
    end

    for i = 1, #this.otherBtnUIAnimatorList do
        local item = this.otherBtnUIAnimatorList[i]
        item.anim.enabled = false
        item.uianimator.AnimationName = ""
        item.canvasGroup.alpha = 0.0
    end
    this.otherBtnShowIndex = -2
    LuaMgr.RemoveTimer(TimerConst.MainPageOtherBtnShow);
    LuaMgr.AddTimer(TimerConst.MainPageOtherBtnShow, this.OnOtherBtnShow, 0.1, -1, false)
end

this.OnOtherBtnShow = function()
    if this.otherBtnShowIndex <= 0 then
        this.otherBtnShowIndex = this.otherBtnShowIndex + 1
        return
    end
    if this.otherBtnShowIndex > #this.otherBtnUIAnimatorList then
        LuaMgr.RemoveTimer(TimerConst.MainPageOtherBtnShow);
        return
    end
    this.otherBtnUIAnimatorList[this.otherBtnShowIndex].uianimator.AnimationName = "ani_mainpagepanel_Left_otherbtns_001"
    this.otherBtnShowIndex = this.otherBtnShowIndex + 1
end

this.SetNewButtons = function()
    if this.newButtonIndex == nil then
        return
    end
    local activeCount,buttonRed = this.GetNewButtonsData()
    this.vm.data.topBtnRoot = this.newButtonIndex > 1
    this.vm.data.bottomRoot = this.newButtonIndex <= 1 and activeCount > 4
    if this.newButtonIndex == 1 then
        this.vm.data.bottomRed = #buttonRed >= 2 and buttonRed[2] > 0
        this.vm.data.buttonViewPos = Vector2.zero
    elseif this.newButtonIndex == 2 then
        this.vm.data.topBtnRed = #buttonRed >= 1 and buttonRed[1] > 0
        this.vm.data.buttonViewPos = Vector2(0,336)
    end
end

this.GetNewButtonsData = function()
    if this.newButtonTransform == nil then
        return
    end
    local length = this.newButtonTransform.childCount
    local activeCount = 0
    local object = nil
    local redList = {}
    for i = 1, length do
        object = this.newButtonTransform:GetChild(i - 1)
        if object.gameObject.activeSelf then
            activeCount = activeCount + 1
        end



    end
    local count = 0
    local buttonRed = {}
    for i = 1, #redList do
        count = count + redList[i]
        if i % 4 == 0 then
            table.insert(buttonRed,count)
            count = 0
        end
    end
    table.insert(buttonRed,count)
    return activeCount,buttonRed
end


this.SetUIButton = function(transform, path, callback)
    local button = transform:Find(path):GetComponent("UIButton");
    button.OnClick = callback;
end


this.SetPlayerInfo = function()
    local level = DataMgr.Player.level;
    this.vm.data.playerLevel = tostring(level);
    local levelUp = ConfigMgr.Config.playerLevelUp[tostring(level)];
    local nextLevel = ConfigMgr.Config.playerLevelUp[tostring(level + 1)];
    if (nextLevel ~= nil) then
        local totalExp = nextLevel.exp - levelUp.exp;
        local nowExp = DataMgr.Player.exp - levelUp.exp;
        this.vm.data.playerExp = nowExp / totalExp;
    else
        this.vm.data.playerExp = 0;
    end
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
    this.vm.data.playerName = DataMgr.Player.name;
    this.vm.data.playerId = DataMgr.Player.uid;
    this.vm.data.stamina = tostring(DataMgr.Player.stamina);
    this.vm.data.maxStamina = "/" .. (levelUp ~= nil and levelUp.staminaLimit or 0);
    local config = ConfigMgr.Config.itemMap["101"];
    if (config ~= null) then
        this.vm.data.staminaIcon = LuaMgr.GetTexture(string.format(ITEM_ICON_PATH, config.id));
    end
end


this.SwitchCharacterAndBG=function()
    this.SetBGTexture();
    this.SetCharacter();
end



this.SetCharacter = function()
    local characterId = PlayerSkinMgr.GetCharacterId()
    local backgroundSkin=nil;
    if PlayerSkinMgr.GetSkinId()~=nil and PlayerSkinMgr.GetSkinId()~="" then
        backgroundSkin=PlayerSkinMgr.GetSkinId();
    end
    this.SetCharacterRect(backgroundSkin);
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId,backgroundSkin);
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
    local isH = this.CheckIsHighSkin();
    if(isH ~= this.isHighSkin) then
        this.isHighSkin=isH;
        this.SetBGTexture();
    end

    if not LuaMgr.IsGuide() then
        local characterIdOrSkin = PlayerSkinMgr.GetCharacterId()
        if not IsNullOrEmpty(PlayerSkinMgr.GetSkinId()) then
            characterIdOrSkin=PlayerSkinMgr.GetSkinId();
        end
        if this.playingPV then return end;

        if SettingHelper.SettingBrithDay then
            SettingHelper.SettingBrithDay = false;
            this.characterMsgVM = LuaMgr.LoadCharacterMsgViewModel(this.characterMsgVM, this.characterMsg, characterIdOrSkin, CharacterMsgType.HappyBirthdayLine, nil);
        elseif (DataHelper.isFirstLogin) then
            DataHelper.isFirstLogin = false;
            this.characterMsgVM = LuaMgr.LoadCharacterMsgViewModel(this.characterMsgVM, this.characterMsg, characterIdOrSkin, CharacterMsgType.LoginMain, nil);
        elseif (this.curCharacterId ~= characterId) then
            this.characterMsgVM = LuaMgr.LoadCharacterMsgViewModel(this.characterMsgVM, this.characterMsg, characterIdOrSkin, CharacterMsgType.SelectCharacter, nil);
        end
    end   
    this.curCharacterId = characterId;
end


this.SetCharacterRect=function(skinId)
    local scale=1.0;
    local pos=Vector2(0,0);
    local spineData=HeroMgr.GetSpineFile();
    if spineData~=nil and spineData[skinId]~=nil then
        pos=Vector2(spineData[skinId].posX,spineData[skinId].posY)
        scale=spineData[skinId].scale;
    end;
    this.vm.data.character_ConfigPos=pos;
    this.vm.data.character_Scale=this.playingPV and Vector3.zero or Vector3.one*scale
end


this.SetActivityTime=function()
    if #this.vm.data.activityDataSmall==0 then return end;
    local isTime=false;
    local timestamp=LuaMgr.Timestamp();
    if #this.vm.data.activityDataSmall>0 then
        for i,v in ipairs(this.vm.data.activityDataSmall) do
            if ActivityMgr.ActivityRuning(v.key) and v.isTime then
                v.surplusTime=v.expireTime-timestamp;
                if v.surplusTime<0 then

                    v.surplusTime=20;
                end
                isTime=true
            end
        end
    end
    if not isTime then return end;
    LuaMgr.RemoveTimer(TimerConst.MainActivityTimer)
    LuaMgr.AddTimer(TimerConst.MainActivityTimer,this.MainActivityTimer,20,-1,true);
    
    
end

this.MainActivityTimer=function()
    for i,v in ipairs(this.vm.data.activityDataSmall) do
        if v.isTime then
            if v.surplusTime<=0 then
                v.isShowTime=false
                LuaMgr.RemoveTimer(TimerConst.MainActivityTimer)
                this.SetActivitysSmall();
                break;
            elseif v.surplusTime<=60 then
                v.isShowTime=true
                v.time=LuaMgr.GetLangText("MainPageViewModel_14")
            elseif v.surplusTime<=172800 then
                v.isShowTime=true
                v.time=string.format(LuaMgr.GetLangText("MainPageViewModel_15"),math.floor(v.surplusTime/(60*60)),math.floor(v.surplusTime%(60*60)/60))
            else
                v.isShowTime=false
            end
            v.surplusTime=v.surplusTime-60
        end
    end
end


this.SetActivitysSmall = function()
    local actsSmall=ActivityMgr.activityTop;
    table.sort(actsSmall,function(a, b) return a.iconOrder<b.iconOrder end)
    if #actsSmall==0 then
        this.vm.data.activityDataSmall={}
        return 
    end;
    local datas={}
    for i,v in ipairs(actsSmall) do
        if ActivityMgr.ActivityRuning(v.key) then
            local actItem={
                icon=LuaMgr.GetSprite("HomeRes", v.iconRes);
                redId=v.RedId,
                isTime=v.isTime,
                isShowTime=false,
                key=v.key,
                time="",
                expireTime=-1,
                panelName=v.iconPanel,
                surplusTime=-1,
            }
            if actItem.isTime then
                actItem.expireTime=DataExHelper.GetDataExByTag(v.key).expireTime;
            end

            if #datas<=8 then
                table.insert(datas,actItem);
            else
                break;
            end
        end
    end
    this.vm.data.activityDataSmall = datas;
    this.SetActivityTime();
end


this.SetActivitysBig = function()
    local actsBig=ActivityMgr.activityLeft;
    table.sort(actsBig,function(a, b) return a.iconOrder<b.iconOrder end)
    if #actsBig==0 then
        this.vm.data.activityDataBig={}
        return
    end;
    local datas={}
    for i,v in ipairs(actsBig) do
        if ActivityMgr.ActivityRuning(v.key) then
            local actItem={
                icon=LuaMgr.GetSprite("HomeRes", v.iconRes);
                redId=v.RedId,
                isShow=false,
                key=v.key,
                panelName=v.iconPanel,
                smallIconScale = Vector3.zero,
            }


            if v.key == ActivityKey.crisiscontract and DataMgr.Player.crisisContracts ~= nil then
                actItem.smallIcon = ActivityMgr.GetCrisisContractRatingImg(DataMgr.Player.crisisContracts.maxScore, false)
                actItem.smallIconAnchPos = Vector2(195.5, -30.5)
                actItem.smallIconScale = Vector3(0.3, 0.3, 1)
            end
            

            if #datas<=3 then
                table.insert(datas,actItem);
            else
                break;
            end
        end
    end
    this.vm.data.activityDataBig = datas;
    if (#datas > 0) then
        this.activityIndex = 1;

        if TimerConst.MainActivityDelay~=nil then
            LuaMgr.AddTimer(TimerConst.MainActivityDelay, this.OnMainActivityDelay, 0.1, -1, true);
        end
    end
end


this.OnMainActivityDelay = function()
    local len = #this.vm.data.activityDataBig;
    if (this.activityIndex <= len) then
        this.vm.data.activityDataBig[this.activityIndex].isShow = true;
        this.activityIndex = this.activityIndex + 1;
        if (this.activityIndex > len) then
            LuaMgr.RemoveTimer(TimerConst.MainActivityDelay);
        end
    end
end























this.OnClickQZ = function()
    FeatureManager.GotoPanel("1002");
end


this.OnClickZX = function()
    FeatureManager.GotoPanel("2000");
end


this.OnClickZM = function()
    if (LuaMgr.IsGuide()) then
        local cardPoolId = this.GetOpenCardPoolId()
        FeatureManager.GotoPanel("1009", cardPoolId);
    else
        local limitCardpoolDatas = ConfigHelper.GetCurLimitCardPoolsData()
        if limitCardpoolDatas == nil or #limitCardpoolDatas == 0 then
            FeatureManager.GotoPanel("1009");    
        else
            local firstData = limitCardpoolDatas[1]
            if firstData == nil or type(firstData.openShow) ~= "table" or firstData.openShow[1] == nil then
                FeatureManager.GotoPanel("1009")
                return
            end
            local archiveKey = string.format("%s%s%s",DataMgr.Player.uid ,FeatureManager.ShowCardVideoKey ,firstData.id)
            local isShowFlag = PlayerPrefs.GetInt(archiveKey) == 1
            if isShowFlag == true then
                FeatureManager.GotoPanel("1009")
                return
            end
            local data = {}
            data.callback = this.VideoPlayEndCalbback
            data.videoName = firstData.openShow[1]
            LuaMgr.ShowLuaPanel(UIName.ExtractCardPreVideoPanel, data)
            PlayerPrefs.SetInt(archiveKey, 1)
        end
    end
end

this.VideoPlayEndCalbback = function()
    FeatureManager.GotoPanel("1009")
end


this.OnClickSJZJ = function()
    FeatureManager.GotoPanel("1009", "3001");
end


this.OnClickHD = function()
    LuaMgr.ShowLuaPanel(UIName.AreaDailyMainViewModel);
end


this.OnClickZBZZ = function()
    if (FeatureManager.IsLock("1400")) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1400"));
    else

        CollectorPracticeAllMgr.InitCurrentMapData();
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeSelectMapViewModel);
    end
end


this.OnClickPQGS = function()
    if (FeatureManager.IsLock("1302")) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1302"));
    else
        FoundationMgr.Open();
    end
end

this.OnClickMarket=function()
    LuaMgr.ShowLuaPanel(UIName.MarketViewModel);
end

this.OnClickShop = function()
    if (FeatureManager.IsLock("1200")) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1200"));
    else
        RedMgr.Singleton:FrushRedCondition("1029")
        LuaMgr.ShowLuaPanel(UIName.MainShopViewModel);
    end
end



this.GetActivityRuningState = function(key)
    local open=nil;
    if key==nil then
        open=ActivityMgr.ActivityRunningAnyOne()~=nil;
    else
        open = ActivityMgr.ActivityRuning(key);
    end
    if (not open) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MainPageViewModel_3"));
    end
    return open;
end

this.GetOpenCardPoolId = function()
    local tempGroup = {}
    for key,value in pairs(ConfigMgr.Config.cardPools) do
        if value.tabNum == 2 and not value.hidden then
            if value.startTime == 0 and value.endTime == 0 then
                table.insert(tempGroup,value)
            else
                if LuaMgr.Timestamp() >= value.startTime and LuaMgr.Timestamp() < value.endTime then
                    table.insert(tempGroup,value)
                end
            end
        end
    end
    table.sort(tempGroup,function(a,b) return a.kindNum < b.kindNum end)
    if #tempGroup ~= 0 then
        return tempGroup[1].id
    end
end
    

this.HeartAcrossDay=function()
    this.SetActivitysBig();
    this.SetActivitysSmall();
    MainPageViewModelRed.Check();
end


this.OnDataChanged = function(args)
    if (this.vm.behaviour.Params == nil) then return end
    
    local type = args[0];
    if (type == "stamina") then
        this.SetPlayerInfo();
    elseif (type == "background") then
        this.SetCharacter();
        local characterId = PlayerSkinMgr.GetCharacterId()
        if not IsNullOrEmpty(PlayerSkinMgr.GetSkinId()) then
            characterId=PlayerSkinMgr.GetSkinId();
        end
        if this.playingPV then return end;
        this.characterMsgVM = LuaMgr.LoadCharacterMsgViewModel(this.characterMsgVM, this.characterMsg, characterId, CharacterMsgType.SelectCharacter, nil);
    elseif (type == "onlineReward") then

    end
end


this.SetBanners = function(data)
    if (not LuaMgr.IsPanelOpen(UIName.MainPageViewModel)) then return end
    
    this.vm.data.bannerContentBool = false;
    this.vm.data.bannerContentBool = true;
    this.bannerIndex = 0;
    this.bannerTime = os.time() + 5;
    this.isAutoBanner = true;
    local list = {};
    this.bannerData = data;
    if (data ~= nil and #data > 0) then
        local len = #data;
        for i = 1, len do
            local banner = {};
            banner.url = data[i].Img;
            table.insert(list, banner);
        end
    else
        local banner = {Img = ""};
        table.insert(list, banner);
    end
    this.vm.data.bannerItemDatas = list;
    this.SelectBanner(0);
    LuaMgr.RemoveTimer(TimerConst.MainInitBanner);
    if (this.isInitBanner) then
        this.InitBannerScrollContent();
    else
        LuaMgr.AddTimer(TimerConst.MainInitBanner, this.InitBannerScrollContent, 1, 1, false);
    end
    LuaMgr.RemoveTimer(TimerConst.MainBanner);
    LuaMgr.AddTimer(TimerConst.MainBanner, this.AutoNextBanner, 1, -1);
end


this.AutoNextBanner = function()
    if (os.time() > this.bannerTime) then
        this.bannerTime = os.time() + 5;
        this.isAutoBanner = true;
        if (this.bannerScrollCenter.GetCurrentPage + 1 >= this.bannerScrollCenter.GetAllPage) then
            this.bannerScrollCenter:SetCurrentPage(0);
            this.OnScrollEndCallback();
        else
            this.bannerScrollCenter:ToRight();
        end
    end
end


this.InitBannerScrollContent = function()
    this.bannerScrollCenter.scrollEndCallback = this.OnScrollEndCallback;
    this.bannerScrollCenter:InitPageArray(#this.vm.data.bannerItemDatas, false);
    this.bannerScrollCenter:SetCurrentPage(0);
    this.SelectBanner(0);
    this.isInitBanner = true;
end


this.OnScrollEndCallback = function()
    if (not this.isAutoBanner and this.bannerIndex ~= this.bannerScrollCenter.GetCurrentPage) then
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/change_switch.mp3");
    end
    this.isAutoBanner = false;
    this.SelectBanner(this.bannerScrollCenter.GetCurrentPage);
    this.bannerTime = os.time() + 5;
end


this.SelectBanner = function(index)
    this.bannerIndex = index;
    local len = #this.vm.data.bannerItemDatas - 1;
    local list = {};
    for i = 0, len do
        local itemData = {};
        itemData.huadong = LuaMgr.GetSprite("HomeRes", this.bannerIndex == i and "ui_home_gg_huadong_3" or "ui_home_gg_huadong_4");
        table.insert(list, itemData);
    end
    this.vm.data.bannerHuadongDatas = list;
end


this.SetTimeInfo = function()
    this.showTime = os.time();
    LuaMgr.AddTimer(TimerConst.MainUpdateTime, this.UpdateTimeInfo, 1, -1, true);
end


this.UpdateTimeInfo = function()
    local index, half = this.CalculateCurrentTimePeriod();
    this.time1CanvasGroup.alpha = half and 0 or 1;
    this.time2CanvasGroup.alpha = half and 1 or 0;
    this.SetTimeIcons(index);
    this.CheckIdelTime();
    this.timeAnimator.AnimationName = half and TIME_ANI002 or TIME_ANI001;
    this.timeIndex = index;
end


this.CalculateCurrentTimePeriod = function()
    local half = false;
    local index = 0;
    local hour = LuaMgr.GetNowHour();
    if (hour == 0) then index = 0; half = true;
    elseif (hour == 1) then index = 1;
    elseif (hour == 2) then index = 1; half = true;
    elseif (hour == 3) then index = 2;
    elseif (hour == 4) then index = 2; half = true;
    elseif (hour == 5) then index = 3;
    elseif (hour == 6) then index = 3; half = true;
    elseif (hour == 7) then index = 4;
    elseif (hour == 8) then index = 4; half = true;
    elseif (hour == 9) then index = 5;
    elseif (hour == 10) then index = 5; half = true;
    elseif (hour == 11) then index = 6;
    elseif (hour == 12) then index = 6; half = true;
    elseif (hour == 13) then index = 7;
    elseif (hour == 14) then index = 7; half = true;
    elseif (hour == 15) then index = 8;
    elseif (hour == 16) then index = 8; half = true;
    elseif (hour == 17) then index = 9;
    elseif (hour == 18) then index = 9; half = true;
    elseif (hour == 19) then index = 10;
    elseif (hour == 20) then index = 10; half = true;
    elseif (hour == 21) then index = 11;
    elseif (hour == 22) then index = 11; half = true;
    elseif (hour == 23) then index = 0;
    end
    return index, half;
end


this.SetTimeIcons = function(middleIndex)
    if this.currentTimePeriod == middleIndex then
        return
    end
    this.currentTimePeriod = middleIndex
    local secondIndex = middleIndex - 1 < 0 and 11 or middleIndex - 1;
    local firstIndex = secondIndex - 1 < 0 and 11 or secondIndex - 1;
    local fourthIndex = middleIndex + 1 > 11 and 0 or middleIndex + 1;
    local fifthIndex = fourthIndex + 1 > 11 and 0 or fourthIndex + 1;
    
    local icon = LuaMgr.GetSprite("HomeRes", "ui_home_sj_" .. this.timePeriods[firstIndex + 1]);
    this.time1Icon1.sprite = icon;
    icon = LuaMgr.GetSprite("HomeRes", "ui_home_sj_" .. this.timePeriods[secondIndex + 1]);
    this.time1Icon2.sprite = icon;
    this.time2Icon2.sprite = icon;
    icon = LuaMgr.GetSprite("HomeRes", "ui_home_sj_" .. this.timePeriods[middleIndex + 1]);
    this.time1Icon3.sprite = icon;
    this.time2Icon3.sprite = icon;
    icon = LuaMgr.GetSprite("HomeRes", "ui_home_sj_" .. this.timePeriods[fourthIndex + 1]);
    this.time1Icon4.sprite = icon;
    this.time2Icon4.sprite = icon;
    icon = LuaMgr.GetSprite("HomeRes", "ui_home_sj_" .. this.timePeriods[fifthIndex + 1]);
    this.time1Icon5.sprite = icon;
    this.time2Icon5.sprite = icon;
end


this.CheckIdelTime = function()
    local time = os.time();
    if (time - this.showTime > 60) then
        this.showTime = time;
        local characterId = PlayerSkinMgr.GetCharacterId()
        if not IsNullOrEmpty(PlayerSkinMgr.GetSkinId()) then
            characterId=PlayerSkinMgr.GetSkinId();
        end
        if this.playingPV then return end;
        this.characterMsgVM = LuaMgr.LoadCharacterMsgViewModel(this.characterMsgVM, this.characterMsg,characterId, CharacterMsgType.Idel, nil);
    end
end


this.SetLeftDropCardItem = function()
    local oneDropCardItemCount = PlayerItemMgr.GetItemCountById("3003")
    local tenDropCardItemCount = PlayerItemMgr.GetItemCountById("3004")
    local indentationNum = ConfigMgr.Config.constants.IndentationNum[1]
    if tenDropCardItemCount > 0 then
        local str = string.format(ITEM_ICON_PATH, "home_" .. "3004")
        this.vm.data.leftDropCardItemIcon = LuaMgr.GetTexture(str)
        this.vm.data.leftDropCardItemCount = tenDropCardItemCount > indentationNum and ">" .. LuaMgr.NumFormat(indentationNum) or LuaMgr.NumFormat(tenDropCardItemCount)
        this.vm.data.isShowLeftDropCardItemCount = true
    elseif oneDropCardItemCount > 0 then
        this.vm.data.leftDropCardItemIcon = LuaMgr.GetTexture(string.format(ITEM_ICON_PATH, "home_" .. "3003"))
        this.vm.data.leftDropCardItemCount = oneDropCardItemCount > indentationNum and ">" .. LuaMgr.NumFormat(indentationNum) or LuaMgr.NumFormat(oneDropCardItemCount)
        this.vm.data.isShowLeftDropCardItemCount = true
    else
        this.vm.data.isShowLeftDropCardItemCount = false
    end
end

this.RefreshSJZJRedStatus = function()
    local count = LuaMgr.CheckCompleteQueueCount();
    if (count > 0) then
        this.vm.data.sjzjRedIconId = "1152"
        RedMgr.Singleton:UpdateClientRedData("1152", count);
        return;
    end
    local isClose = SettingHelper.GetPrefasBool(ESetting.Msg_QZZJRed_Close);
    local isAuto = SettingHelper.GetPrefasBool(ESetting.Msg_QZZJRed_Auto);
    local isMax = SettingHelper.GetPrefasBool(ESetting.Msg_QZZJRed_Max);
    if (not isAuto and not isClose and not isMax) then
        isAuto = true;
    end
    if (isClose) then
        RedMgr.Singleton:UpdateClientRedData("1151", 0);
        return;
    end
    if (isAuto) then
        this.vm.data.sjzjRedIconId = "1151"
        count = LuaMgr.CheckTimeRecruit()
        RedMgr.Singleton:UpdateClientRedData("1151", count);
        return;
    end
    if (isMax) then
        local maxCount = this.GetDrawCardSearchGrids();
        if (maxCount > 0) then
            local costItem = this.GetQZZJCostItem();
            local costCount = costItem.count * maxCount;
            local itemCount = PlayerItemMgr.GetItemCountById(costItem.itemId);
            this.vm.data.sjzjRedIconId = "1151"
            if (itemCount >= costCount) then
                RedMgr.Singleton:UpdateClientRedData("1151", maxCount);
                return;
            end
        end
        RedMgr.Singleton:UpdateClientRedData("1151", 0);
    end
end

this.GetDrawCardSearchGrids = function()
    local count = 0;
    local searchGrids = DataMgr.Player.drawCard.searchGrids;
    local len = #searchGrids;
    for i = 1, len do
        if (IsNull(searchGrids[i])) then
            count = count + 1;
        end
    end
    return count;
end

this.GetQZZJCostItem = function()
    local cardPools = ConfigMgr.Config.cardPools;
    for _, v in pairs(cardPools) do
        if (not v.hidden and v.kind == "search") then
            return v.searchCost[1];
        end
    end
    return nil;
end

this.SetLimitSSREntranceLeftTimer = function()
    if not ActivityMgr.IsNewPlayerLimitSSRActivityOpen() then
        this.vm.data.isLimitSSROpen = false
        return
    end
    if not NewPlayerLimitSSRMgr.CheckActivityIsShown() then
        this.vm.data.isShowLimitSSRTimer = false
        return
    end
    local str = NewPlayerLimitSSRMgr.GetNewPlayerLimitEntranceTimerStr()
    if IsNullOrEmpty(str) then
        this.vm.data.isLimitSSROpen = false
        return
    end
    this.vm.data.isLimitSSROpen = true
    this.vm.data.isShowLimitSSRTimer = true
    this.vm.data.limitSSRTimeText = str
end

this.SetLimitEquipEntranceLeftTimer = function()
    if not ActivityMgr.IsNewPlayerLimitEquipActivityOpen() then
        this.vm.data.isLimitEquipOpen = false
        return
    end
    if not NewPlayerLimitEquipMgr.CheckActivityIsShown() then
        this.vm.data.isShowLimitEquipTimer = false
        return
    end
    local str = NewPlayerLimitEquipMgr.GetNewPlayerLimitEntranceTimerStr()
    if IsNullOrEmpty(str) then
        this.vm.data.isLimitEquipOpen = false
        return
    end
    this.vm.data.isLimitEquipOpen = true
    this.vm.data.isShowLimitEquipTimer = true
    this.vm.data.limitEquipTimeText = str
end

this.SetLimitBreakEntranceLeftTimer = function()
    if not ActivityMgr.CheckShowPlayerLimitBreakPopup() then
        this.vm.data.isLimitBreakOpen = false
        return
    end 
    local str = NewPlayerLimitBreakMgr.GetNewPlayerLimitEntranceTimerStr()
    if IsNullOrEmpty(str) then
        this.vm.data.isLimitBreakOpen = false
        return
    end
    this.vm.data.isLimitBreakOpen = true
    this.vm.data.isShowLimitBreakTimer = true
    this.vm.data.limitBreakTimeText = str
end

this.CheckFix = function()
    if (LuaMgr.IsDebug()) then return end

    local status = PlayerPrefs.GetInt("FixStatus");
    local path = LuaMgr.GetPersistentWWWPre();
    local jsonPath = path .. "/bundles/a0020a7cfe0376db202a12a6be1b0019.ab";

    
    local jsonStr = LuaMgr.ReadFile(jsonPath);
    if (status == 1 and not IsNullOrEmpty(jsonStr)) then
        local jsonData = json.decode(jsonStr);
        if jsonData==nil then
            LuaDebug.error("checkFix jsonData is nil")
            return;
        end
        local fileHash = LuaMgr.GetFileHash(path .. "/fixs/" .. jsonData.name);
        local len = string.len(fileHash);
        local index = math.floor(len / 2) + 1;
        local newHash = string.sub(fileHash, index + 1, len) .. "-" .. string.sub(fileHash, 1, index - 1);
        if (newHash == jsonData.hash) then
            return;
        end
    end
    ConfigMgr.Config = {};
end

local command = {
    OnClickSigin = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.GetActivityRuningState()) then
                LuaMgr.ShowLuaPanel(UIName.ActivityOnViewModel);
            end
        end
    },
    OnClickMission = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoPanel("1016");
        end
    },
    OnClickWarehouse = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoPanel("1019")
        end
    },
    OnClickZD = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoPanel("4001");
        end
    },
    OnClickBody = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.isHighSkin and this.CheckPlayInterval() and SettingHelper.GetCurImageQuality()~=ESetting.Image_QualityLow then

                this.PlaySpineAnimation();
                return;
            end
            local characterId = PlayerSkinMgr.GetCharacterId()
            if not IsNullOrEmpty(PlayerSkinMgr.GetSkinId()) then
                characterId=PlayerSkinMgr.GetSkinId();
            end
            this.characterMsgVM = LuaMgr.LoadCharacterMsgViewModel(this.characterMsgVM, this.characterMsg, characterId, CharacterMsgType.ClickCharacter, nil);
        end
    },
    OnClickSetting = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoPanel("1034");
        end
    },
    OnClickUserInfo = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoPanel("1034", "player");
        end
    },
    OnClickMail = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (FeatureManager.IsLock("1033")) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1033"));
            else
                ApiMgr.Request("get_mails", {}, true, function()
                    LuaMgr.ShowLuaPanel(UIName.MailViewModel);
                end, nil, true);
            end
        end
    },
    OnClickTB = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (FeatureManager.IsLock("1035")) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1035"));
            else
                LuaMgr.ShowLuaPanel(UIName.NoticeNormalViewModel, 1);
            end
        end
    },
    OnClickQH = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoPanel("1022");
        end
    },
    OnClickStamina = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not LuaMgr.IsGuide()) then
                LuaMgr.ShowLuaPanel(UIName.FatigueReplyViewModel);
            end
        end
    },
    OnClickTest = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel(UIName.TestViewModel);
        end
    },
    OnClickActivity = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local activeItem=this.vm.data.activityDataBig[param+1]
            if not ActivityMgr.ActivityRuning(activeItem.key) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MainPageViewModel_3"));
            else
                if this.OnActiveSpecialClick(activeItem) then
                    return
                end

                if(activeItem.panelName[1] == "FarmRoom")then
                    FarmRoom.Open()
                    return
                end
                if #activeItem.panelName>1 then
                    LuaMgr.ShowLuaPanel(activeItem.panelName[1],activeItem.panelName[2]);
                else
                    LuaMgr.ShowLuaPanel(activeItem.panelName[1]);
                end
            end
        end
    },
    OnClickActivitySmall = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local activeItem=this.vm.data.activityDataSmall[param+1]

            if not ActivityMgr.ActivityRuning(activeItem.key) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MainPageViewModel_3"));
            else

                if #activeItem.panelName>1 then
                    LuaMgr.ShowLuaPanel(activeItem.panelName[1],activeItem.panelName[2]);
                else
                    if activeItem.key=="huazhao" then
                        LuaMgr.ShowLuaPanel(UIName.ActivityFlowerDrawViewModel)
                        return;
                    end
                    if activeItem.key == "Story1" then
                        HeroParameter.SavePanelType("branchprop")
                    end
                    LuaMgr.ShowLuaPanel(activeItem.panelName[1]);
                end
            end
        end
        
    },
    OnClickBanner = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.bannerData ~= nil and #this.bannerData > 0) then
                local index = param + 1;
                NoticeMgr.CompleteAD(2, 2, this.bannerData[index].ID);
                local tarUrl = this.bannerData[index].ImgHref;
                if (tarUrl ~= nil) then 
                    NoticeMgr.GoToPanel(tarUrl);
                end
            end
        end
    },
    
    OnClickBC = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoPanel("1021");
        end
    },
    OnClickCharge = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if FeatureManager.IsLock("1200") then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1200"));
            end
            RedMgr.Singleton:FrushRedCondition("1029")
            FeatureManager.GotoViewModel("1200");
           
        end
    },
    OnClickGLZ = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local mapWebURL = ConfigMgr.Config.constants.homeWebURL;
            local orientation = ConfigMgr.Config.constants.homeWebURLType
            LuaMgr.OpenURL(mapWebURL,orientation);
        end
    },
    OnClickTravel = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if DataExHelper.Check_TrafficPermintRuning() then
                LuaMgr.ShowLuaPanel(UIName.TrafficPermitViewModel);
            else
                if IsNull(DataMgr.Player.passes) or IsNullOrEmpty(DataMgr.Player.passes.id) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MainPageViewModel_3"));
                else
                    local numId=tonumber(DataMgr.Player.passes.id);
                    if numId%2==0 then
                        LuaMgr.ShowLuaPanel(UIName.TrafficPermitNewViewModel)
                    else
                        LuaMgr.ShowLuaPanel(UIName.TrafficPermitViewModel)
                    end
                end
            end
        end
        
    },
    OnClickFriend = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FriendChatViewModel)
        end
    },
    OnClickLimitSSR = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)
if index == 1 then
                if ActivityMgr.IsNewPlayerLimitSSRActivityOpen() then
                    if NewPlayerLimitSSRMgr.CheckActivityIsShown() then
                        LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitSSRPopup)
                    end
                end
elseif index == 2 then
                if ActivityMgr.IsNewPlayerLimitEquipActivityOpen() then
                    if NewPlayerLimitEquipMgr.CheckActivityIsShown() then
                        LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitEquipPopup)
                    end
                end
            end
        end
    },
    OnClickLimitBreak = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if ActivityMgr.CheckShowPlayerLimitBreakPopup() then
                LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitBreakPopup)
            end
        end
    },
    OnClickGuild = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            PlayerGuildMgr.FirstEnter = false
            PlayerGuildMgr.RefreshGuildInfo(function()
                LuaMgr.ShowLuaPanel(UIName.GuildMainViewModel)
            end,function ()
                PlayerGuildMgr.GetGuildList(function()
                    LuaMgr.ShowLuaPanel(UIName.GuildEnterViewModel)
                end)
            end)
            RedMgr.Singleton:SetRedState("17830",PlayerGuildMgr.CheckMainRed())
        end
    },
    topButtonCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.newButtonIndex = 1
            this.SetNewButtons()
        end
    },
    bottomButtonCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.newButtonIndex = 2
            this.SetNewButtons()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.MainPageViewModel);
        local transform = vm.behaviour.transform;
        this.SetUIButton(transform, "root/Right/QZ", this.OnClickQZ);
        this.SetUIButton(transform, "root/Right/SJZJ", this.OnClickSJZJ);
        this.SetUIButton(transform, "root/Right/ZM", this.OnClickZM);
        this.SetUIButton(transform, "root/Right/ZX", this.OnClickZX);
        this.SetUIButton(transform, "root/Right/HD", this.OnClickHD);
        this.SetUIButton(transform, "root/Right/ZBZZ", this.OnClickZBZZ);
        this.SetUIButton(transform, "root/Right/PQGS", this.OnClickPQGS);
        this.SetUIButton(transform, "root/Right/YWS", this.OnClickMarket);
        this.spineCharacter = transform:Find("root/Middle/Character/Group/Body"):GetComponent("UISpineCharacter");
        this.characterMsg = transform:Find("root/Middle/Character/Msg");
        this.bannerScrollCenter = transform:Find("root/Left/Banners"):GetComponent("ScrollChildrenCenter");
        this.fxRawBG=transform:Find("root/Middle/MainBG/FXBG"):GetComponent("RawImage");
        this.otherBtnsTr = transform:Find("root/Left/Buttons/OtherBtns");
        this.playerDynamicAvatar = transform:Find("root/Left/PlayerInfo/BG/DynamicAvatar"):GetComponent("PlayerDynamicAvatar");
        this.playerAvatarFrame = transform:Find("root/Left/PlayerInfo/BG/Frame"):GetComponent("Image");
        this.videoObj = vm.behaviour.transform:Find("root/Video"):GetComponent("UIVideoPlayer");
        this.newButtonTransform = vm.behaviour.transform:Find("root/Left/NewButtons/Mask2D/View"):GetComponent("Transform")
        UITool.Parse(vm.behaviour, this, objs);
        require("ViewModel/Home/MainPageBGFX")
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.CheckFix();
        this.SetLoginKVName();
        ComData.skipJump=nil;
        this.characterHighskinVM=nil;
        this.lastHighSkinClick=nil;
        this.currentTimePeriod = -1
        vm.data.videoPanel=false;
        this.playingPV=false;
        vm.data.uiPanelAniName = "ani_ui_zhujiemian_001";
        vm.data.isTest = LuaMgr.IsDebug();
        ActivityMgr.RefreshActivityData()
        this.isHighSkin=this.CheckIsHighSkin();
        this.SetBGTexture()
        this.SetActivitysBig();
        this.SetActivitysSmall()
        this.SetButtonStatus();

        this.SetPlayerInfo();
        this.SetTimeInfo();
        this.SetBanners(NoticeMgr.lunboData);

NoticeMgr.SetContinuePaiLian();
        LuaMgr.AddDataEventListener(this.OnDataChanged);
        LuaMgr.AddUIEventListener(UIEventConst.SettingAvatarChange, this.RefreshAvatar);
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,this.HeartAcrossDay);
        LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.RefreshActivityData);
        LuaMgr.AddUIEventListener(UIEventConst.MainActivityFrush,this.SetActivitysSmall)        
        LuaMgr.AddUIEventListener(UIEventConst.OnChangeCharacterSkin,this.SwitchCharacterAndBG)
        LuaMgr.AddUIEventListener(UIEventConst.MainNewButtonRedUpdate,this.SetNewButtons)
        this.FirstMainPage();



        MainPageViewModelRed.vm = this.vm;
        MainPageViewModelRed.Check();
        this.CheckBackpackRed()
        this.RefreshAvatar();
        this.UpdateFatigueTime();
        UnlockTipsMgr.CheckUnlockTips();
        LuaMgr.MemoryCheck(true);
        this.EmptyPanelParam();
        ConfigFoundationMgr.PlayBgmMusic();
        this.SetLeftDropCardItem();
        this.RefreshSJZJRedStatus()
        PopUpMgr.StartPopUp();
        if this.vm.data.isFriendUnLock then
            FriendChatMgr.Init();
        end
        PlayerGuoBaoMgr.CheckBuildingRewards();
        if HeroParameter.update_background~=nil and this.isHighSkin then
            HeroParameter.update_background=nil;
            this.PlaySkinVideo();
        end
        HeroParameter.update_background = nil
        if not this.playingPV then
            this.SetCharacter();
        end
        if (LuaMgr.IsPanelOpen(UIName.PackUpGameViewModel)) then

            LuaMgr.HidePanel(UIName.PackUpGameViewModel)
        end
        PlayerMedalMgr.CheckMedalPopup("",ConfigMgr.Config.constants.DefaultTitle)


    end,
    before_deactive = function(vm)
        MainPageViewModelRed.vm = nil;

        LuaMgr.RemoveTimer(TimerConst.MainActivityDelay);
        LuaMgr.RemoveTimer(TimerConst.MainOnlineReward);
        LuaMgr.RemoveTimer(TimerConst.WeaponMakeOrderTime);
        LuaMgr.RemoveTimer(TimerConst.TeaTastHeroShowTime);
        LuaMgr.RemoveTimer(TimerConst.NonsenseChick);
        LuaMgr.RemoveTimer(TimerConst.StaminaTime);
        LuaMgr.RemoveTimer(TimerConst.MainUpdateTime);
        LuaMgr.RemoveTimer(TimerConst.MainInitBanner);
        LuaMgr.RemoveTimer(TimerConst.MainBanner);
        LuaMgr.RemoveTimer(TimerConst.MainActivityTimer)
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSREntranceTimer);
        LuaMgr.RemoveTimer(TimerConst.MainPageOtherBtnShow);
        LuaMgr.RemoveDataEventListener(this.OnDataChanged);
        LuaMgr.RemoveUIEventListener(UIEventConst.SettingAvatarChange, this.RefreshAvatar);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.HeartAcrossDay);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.RefreshActivityData);
        LuaMgr.RemoveUIEventListener(UIEventConst.MainActivityFrush,this.SetActivitysSmall);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnChangeCharacterSkin,this.SwitchCharacterAndBG)
        LuaMgr.RemoveUIEventListener(UIEventConst.MainNewButtonRedUpdate,this.SetNewButtons)
        if (this.characterMsgVM ~= nil) then
            this.characterMsgVM:Clear();
        end
        if (this.spineCharacter ~= nil) then
            this.spineCharacter:Clear();
        end
        this.updateTime = false;
        LuaMgr.MemoryCheck(false);
        LuaMgr.InvokeUIEventListeners(UIEventConst.NonsenseChickPanelClose)
        if (vm.behaviour.Params == nil) then return end
        this.CloserOtherPops();
        FriendChatMgr.RemoveTimer();
        if this.characterHighskinVM~=nil then
            this.characterHighskinVM:Destroy();
        end


        if this.isHighSkin and not IsNullOrEmpty(PlayerSkinMgr.GetSkinId()) then
            local volume = SettingHelper.GetPrefasFloat(ESetting.Audio_MusicVolume)
            AudioMgr.Singleton:SetBgmVolume(volume)
        end

        PlayerAvatarFrameTool.ClearImage(this.playerAvatarFrame)
    end,
    before_destroy = function(vm)
        this.characterMsgVM = nil;
        this.spineCharacter = nil;
        this.characterMsg=nil;
        this.playerDynamicAvatar = nil
        this.fxRawBG=nil;
        if this.mainBGFX~=nil then
            this.mainBGFX:Clear();
            this.mainBGFX=nil;
        end
    end
}


this.SetLoginKVName=function()
    local key="LOGINKV_NAME";
    local curValue=UnityEngine.PlayerPrefs.GetString(key);
    if not IsNullOrEmpty(curValue) and not IsNullOrEmpty(DataMgr.Player.LoginKV) then
        UnityEngine.PlayerPrefs.SetString(key,DataMgr.Player.LoginKV);
    else
        for i,v in ipairs(ConfigMgr.Config.LoginBackgroundList) do
            if LuaMgr.Timestamp()>v.StartTime and LuaMgr.Timestamp()<v.EndTime then
                PlayerCharacterMgr.UpdateLoginKV(v.KV,function()
                    UnityEngine.PlayerPrefs.SetString(key,v.KV);
                end);
                break
            end
        end
    end
end
    




this.CloserOtherPops=function()
    LuaMgr.HidePanel(UIName.TravelTipViewModel);
    LuaMgr.HidePanel(UIName.GuoBaoMainTipsViewModel);
    LuaMgr.HidePanel(UIName.NonsenseChickViewModel);
end

this.SetBGTexture=function()
    local bgName=ConfigHelper.GetHomeBgTexture();
    bgName=this.CheckBGNameByTime(bgName);
    if this.isHighSkin then
        bgName=this.CheckBGNameByHighSkin(bgName);
    end
    this.vm.data.isHomeBG001 = bgName == "ui_home_bj_di";
    local fxPath=Path.UI_PATH.."Home/HomeBGEffect/"..bgName..".prefab";
    if not LuaMgr.HasAsset(fxPath) then
        local bgPath = string.format("Assets/_BundleResources/Images/Home/%s.png", bgName);
        this.vm.data.bgTexture = LuaMgr.GetTexture(bgPath);
        SetActive(this.fxRawBG.gameObject,false);
        if this.mainBGFX~=nil then
            this.mainBGFX:Clear();
            this.mainBGFX=nil;
        end
        return ;
    end
    this.vm.data.bgTexture = "";
    SetActive(this.fxRawBG.gameObject,true);
    if this.mainBGFX==nil then
        this.mainBGFX=MainPageBGFX.New()
    end
    this.mainBGFX:SetBGFX(bgName,fxPath,this.fxRawBG)
end


this.CheckBGNameByTime=function(bgName)
    if bgName~="ui_home_bj_di_gjbz" then
       return bgName;
    end
    local curDate=os.date("*t",LuaMgr.Timestamp());

    if curDate.hour<6 or curDate.hour>=18 then
        bgName=bgName.."_2";
    end
    return bgName;
end


this.CheckBGNameByHighSkin=function(bgName)
    local cfgSkin=ConfigMgr.Config.CharacterHighSkinMap[PlayerSkinMgr.GetSkinId()]
    if cfgSkin~=nil and  not IsNullOrEmpty(cfgSkin.bgpic) then
        return cfgSkin.bgpic;
    end
    return bgName;
end

this.RefreshActivityData=function ()
    ActivityMgr.RefreshActivityData();
    PlayerGuoBaoMgr.CheckBuildingRewards();

    if not this.vm.data.isLimitSSROpen then
        this.vm.data.isLimitSSROpen = ActivityMgr.IsNewPlayerLimitSSRActivityOpen()
        if this.vm.data.isLimitSSROpen then
            NewPlayerLimitSSRMgr.RefreshData()
            this.vm.data.isShowLimitSSRTimer = NewPlayerLimitSSRMgr.CheckActivityIsShown()
            LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSREntranceTimer, this.SetLimitSSREntranceLeftTimer, 1, -1, true);
        end
    end
    if not this.vm.data.isLimitEquipOpen then
        this.vm.data.isLimitEquipOpen = ActivityMgr.IsNewPlayerLimitEquipActivityOpen()
        if this.vm.data.isLimitEquipOpen then
            NewPlayerLimitEquipMgr.RefreshData()
            this.vm.data.isShowLimitEquipTimer = NewPlayerLimitEquipMgr.CheckActivityIsShown()
            LuaMgr.AddTimer(TimerConst.NewPlayerLimitEquipEntranceTimer, this.SetLimitEquipEntranceLeftTimer, 1, -1, true);
        end
    end
    if not this.vm.data.isLimitBreakOpen then
        this.vm.data.isLimitBreakOpen = ActivityMgr.CheckShowPlayerLimitBreakPopup()
        if this.vm.data.isLimitBreakOpen then
            NewPlayerLimitBreakMgr.RefreshData()
            this.vm.data.isShowLimitBreakTimer = NewPlayerLimitBreakMgr.CheckActivityIsShown()
            LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSREntranceTimer, this.SetLimitBreakEntranceLeftTimer, 1, -1, true);
        end
    end
end

this.CheckBackpackRed = function()
    local redCount = HeroRedDataHelper.InitTimePropRed()
    if redCount == 0 then
        redCount = HeroRedDataHelper.InitBackPackRed()
        this.vm.data.b_TimeRed = false
        this.vm.data.b_PointRed = redCount > 0
    else
        this.vm.data.b_TimeRed = true
        this.vm.data.b_PointRed = false
    end
end

this.OnActiveSpecialClick = function(activeItem)
    if activeItem.key=="huazhao" then
        LuaMgr.ShowLuaPanel(UIName.ActivityFlowerDrawViewModel)
        return true

    elseif activeItem.key == "BossChallenge" then
        LuaMgr.ShowLuaPanel(UIName.ActivityBossChallengeViewModel, "MainPageViewModel")
        return true

    elseif activeItem.key == ActivityKey.BZHalfYear then
        LuaMgr.OpenURL(ConfigMgr.Config.constants.BZHalfYear1);
        return true
    end
    return false
end


this.PlaySkinVideo=function()
    if not this.isHighSkin or IsNullOrEmpty(PlayerSkinMgr.GetSkinId()) then
        return;
    end
    this.vm.data.videoPanel=true;
    local cfgSkin=ConfigMgr.Config.CharacterHighSkinMap[PlayerSkinMgr.GetSkinId()]
    if cfgSkin~=nil and this.videoObj~=nil and not IsNullOrEmpty(cfgSkin.pv) then
        this.playingPV=true;
        this.vm.data.character_Scale=Vector3.zero
        AudioMgr.Singleton:SetBgmVolume(0)
        local volume = SettingHelper.GetPrefasFloat(ESetting.Audio_MusicVolume)
        this.videoObj:SetVolume(volume)
        this.videoObj:Load(string.format(HERO_VIDEO_PATH, cfgSkin.pv), function()
            this.playingPV=false;
            this.SetCharacter();
            this.vm.data.videoPanel=false;
            this.videoObj :Stop()
            local volume = SettingHelper.GetPrefasFloat(ESetting.Audio_MusicVolume)
            AudioMgr.Singleton:SetBgmVolume(volume)
        end)
    end;
end

this.CheckIsHighSkin=function()
    if IsNullOrEmpty(PlayerSkinMgr.GetSkinId()) then return  end;
    local cfgSkin=ConfigHelper.GetHeroSkinConfig(PlayerSkinMgr.GetSkinId());
    if cfgSkin~=nil and cfgSkin.highskin~=nil and cfgSkin.highskin==1 then
        return true;
    end
    return false;
end

this.PlaySpineAnimation=function()
    if this.spineCharacter~=nil then
        if this.characterHighskinVM==nil then
            this.characterHighskinVM=CharacterHighSkin.New(this.spineCharacter.transform);
        end
        this.characterHighskinVM:SetData(PlayerSkinMgr.GetCharacterId(),PlayerSkinMgr.GetSkinId());
        this.characterHighskinVM:PlayAnimation();

        local cfgHighSkin=ConfigMgr.Config.CharacterHighSkinMap[PlayerSkinMgr.GetSkinId()];
        if cfgHighSkin~=nil and not IsNull(cfgHighSkin.pokeline) and #cfgHighSkin.pokeline>1 then
            local hightArray=cfgHighSkin.pokeline[2]
            local maxHight=tonumber(hightArray[#hightArray]);
            maxHight=maxHight>0 and maxHight or 1;
            math.randomseed(LuaMgr.Timestamp());
            local randomHight=math.random(1,maxHight);
            local randomIndex=1;
for i,v in ipairs(cfgHighSkin.pokeline[2]) do
                if randomHight>tonumber(v) then
                    randomIndex=randomIndex+1;
                end
            end
            local lineType=cfgHighSkin.pokeline[1][randomIndex]
            this.characterMsgVM = LuaMgr.LoadCharacterMsgViewModel(this.characterMsgVM, this.characterMsg, PlayerSkinMgr.GetSkinId(), CharacterMsgType.ClickCharacter, lineType);
        end
    end
end

this.CheckPlayInterval=function()
    local isCanPlay=false;
    local interval=20;
    local skinID=PlayerSkinMgr.GetSkinId();
    if skinID~=nil then
        local cfgHighSkin=ConfigMgr.Config.CharacterHighSkinMap[skinID];
        if cfgHighSkin~=nil then
            interval=cfgHighSkin.highSkinInterval;
        end
    end
    if this.lastHighSkinClick==nil or CS.UnityEngine.Time.realtimeSinceStartup-this.lastHighSkinClick>=interval then
        isCanPlay=true;
        this.lastHighSkinClick=CS.UnityEngine.Time.realtimeSinceStartup;
    end
    return isCanPlay;
end


return vm({
    data = data,
    command = command,
    hook = hook,
})