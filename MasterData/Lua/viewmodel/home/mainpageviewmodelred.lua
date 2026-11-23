




MainPageViewModelRed = {
    vm = nil,

}


























local function ShowWeaponMakeRed()
   
    local redNum=0;

    local cfgCrafts=ConfigMgr.Config.weaponMade.Craftsman;
    for i,v in pairs(DataMgr.Player.weaponMade.Craftsman) do
        if not IsNull(v.List) and  v.List~=nil and #v.List>0 then
            for p,m in ipairs(v.List) do
                local craft=cfgCrafts[m];
                if craft~=nil then
                    local spendsItems=craft.SpendItems
                    local myCount1=DataHelper.GetItemCountById(spendsItems[1].id)
                    local myCount2=DataHelper.GetItemCountById(spendsItems[2].id)
                    if spendsItems[1].count<=myCount1 and spendsItems[2].count<=myCount2 then
                        redNum=redNum+1;
                    end
                end
            end
           
        end
    end
    
    if not RedMgr.Singleton:CheckRedCondition("1020_main") then
        redNum=0;
    end
    

    local orderList=DataMgr.Player.weaponMade.OrdersList;
    if orderList~=nil and #orderList>0 then
        for i,v in ipairs(orderList) do
            if v.EndTime<=LuaMgr.Timestamp() then
                redNum=1;
                break;
            end
        end
    end
    
    RedMgr.Singleton:UpdateClientRedData("1020_main",redNum);
end


local function OnTeaTastRed()
    local teadata = DataMgr.Player.hightea;
    local nextOneSecond = teadata.Deadline - LuaMgr.Timestamp();
    if (nextOneSecond <= 0) then
        RedMgr.Singleton:UpdateClientRedData("1075", 1);
    end
end
local NonsenseChickTime = 0
local function NonsenseChickShow()
    if ComData.MainPageChickShowTime>0 then
        if type(NonsenseChickTime)~="number"then
            NonsenseChickTime = ConfigMgr.Config.constants.ChickShowTimeSecond
        end
        if LuaMgr.Timestamp()- ComData.MainPageChickShowTime >= NonsenseChickTime then
            RedMgr.Singleton:SetCDjTipShow(true)
            LuaMgr.RemoveTimer(TimerConst.NonsenseChick);
        end  
    end
end


local function ShowTeaTastRed()
    RedMgr.Singleton:UpdateClientRedData("1075", 0);
    RedMgr.Singleton:UpdateClientRedData("1077", 0);
    if (FeatureManager.IsLock("1302")) then return end

    local teadata = DataMgr.Player.hightea;
    local firstSeeTealevel = false;
    local key = DataMgr.Player.uid .. "teaLevelHave";
    local teaLevelShow = PlayerPrefs.GetString(key);
    local timestamp = LuaMgr.Timestamp();
    if (teaLevelShow ~= "") then
        firstSeeTealevel = tonumber(teaLevelShow) <= timestamp;
    else
        firstSeeTealevel = true;
    end
    local items = DataMgr.Player.items;
    local highteaMainMap = ConfigMgr.Config.highteaMain;
    for _, v in pairs(highteaMainMap) do
        local item = items[v.ID];
        if (item ~= nil) then
            if (item.count0 > 0 and firstSeeTealevel) then
                RedMgr.Singleton:UpdateClientRedData("1077", 1);
            end
        end
    end
    if (teadata.Stage == 1 or teadata.Stage == 5) then
        local lastTime = teadata.Deadline - timestamp;
        if (lastTime <= 0) then
            RedMgr.Singleton:UpdateClientRedData("1075", 1);
        else
            RedMgr.Singleton:UpdateClientRedData("1075", 0);
            LuaMgr.RemoveTimer(TimerConst.TeaTastHeroShowTime);
            LuaMgr.AddTimer(TimerConst.TeaTastHeroShowTime, OnTeaTastRed, 1, -1, true);
        end
    end
end


function MainPageViewModelRed.ShowCollectRed()

    RedMgr.Singleton:UpdateClientRedData("1200",0)
    local tempData = DataMgr.Player.collection.ActInfos["301"]
    local tempConfig = ConfigMgr.Config.CollectionActivities["301"]
    if tempData ~= nil and tempConfig.Open == 1 then
local firstSearchAll=true;
        for i = 1, #tempData.CollectionMeta do
if tempData.CollectionMeta[i].characterid == "" and firstSearchAll then
for k,v in pairs(DataMgr.Player.characters) do
                    if next(v.talents) == nil then goto continue end
if WhetherAddHero(k) then goto continue end
                    if v.talents[k.."18"].status == 2 then
                        return 1
                    end
                    ::continue::
                end
                firstSearchAll=false;
else
                local activity = tempData.CollectionMeta[i]
                local character = DataMgr.Player.characters[tempData.CollectionMeta[i].characterid]

                if activity.status == 0 and character~=nil and character.talents[character.id .. "18"].status == 2 then
                    return 1
                end
            end
        end
    end

    tempConfig = ConfigMgr.Config.CollectionActivities["302"]
    if tempConfig.Open == 1 then
        local lock = false
        if tempConfig.UnlockType == 0 then lock = true end
        if tempConfig.UnlockType == 1 then
            if DataMgr.Player.level >= tonumber(tempConfig.UnlockParam) then lock = true end
        end
        if tempConfig.UnlockType == 2 then
            if DataMgr.Player.dungeonRecords[tempConfig.UnlockParam] ~= nil then lock = true end
        end
        if lock then
            tempData = DataMgr.Player.collection.ActInfos["302"]
            if tempData ~= nil then
                local state = nil
                local characterid = nil
                for i = 1, #tempData.CollectionMeta do
                    characterid = tempData.CollectionMeta[i].characterid
                    state = tempData.CollectionMeta[i].status == 0 and DataMgr.Player.characters[characterid] ~= nil
                    if state then return 1 end
                end
            end
        end
    end

    tempConfig = ConfigMgr.Config.CollectionActivities["303"]
    if tempConfig.Open == 1 then
        if tempConfig.UnlockType == 1 then
            if DataMgr.Player.level < tonumber(tempConfig.UnlockParam) then return 0 end
        end
        if tempConfig.UnlockType == 2 then
            if DataMgr.Player.dungeonRecords[tempConfig.UnlockParam] == nil then return 0 end
        end
        tempData = DataMgr.Player.collection.ActInfos["303"]
        local isActiveRed = true
        if tempData ~= nil then
            for i = 1, #tempData.CollectionMeta do
                if tempData.CollectionMeta[i].status == 1 then
                    isActiveRed = false
                    break
                end
            end
        end
        if RedMgr.Singleton:CheckRedCondition("1200") and isActiveRed then
            RedMgr.Singleton:UpdateClientRedData("1200",1)
            return 1
        end
        RedMgr.Singleton:UpdateClientRedData("1200",0)
    end

    tempConfig = ConfigMgr.Config.CollectionActivities["304"]
    if tempConfig.Open == 1 then
        if tempConfig.UnlockType == 1 then
            if DataMgr.Player.level < tonumber(tempConfig.UnlockParam) then return 0 end
        end
        if tempConfig.UnlockType == 2 then
            if DataMgr.Player.dungeonRecords[tempConfig.UnlockParam] == nil then return 0 end
        end
        tempData = DataMgr.Player.collection.ActInfos["304"]
        if tempData ~= nil then
            local isRed = UnityEngine.PlayerPrefs.HasKey("304")
            if not isRed then return 1 end
        end
    end
    return 0
end

function WhetherAddHero(characterid)
    local tempData = DataMgr.Player.collection.ActInfos["301"].CollectionMeta
    for i = 1, #tempData do
        if tempData[i].characterid == characterid then
            return true
        end
    end
    return false
end


function MainPageViewModelRed.MainPageChickTimeShow()
    if not LuaMgr.IsGuide()  then
        LuaMgr.RemoveTimer(TimerConst.NonsenseChick);
        LuaMgr.AddTimer(TimerConst.NonsenseChick, NonsenseChickShow, 1, -1, true);
    end  
end


function MainPageViewModelRed.CheckFoundation()

    local status = 0;
    if (not FeatureManager.IsLock("1310")) then
        status = PlayerPrefs.GetInt(DataMgr.Player.uid .. "FoundationBgm", 1);
    end
    RedMgr.Singleton:UpdateClientRedData("1164", status);

    MainPageViewModelRed.vm.data.isIdleStatus = PlayerFoundationMgr.IsBuildingsIdle();

    MainPageViewModelRed.vm.data.isItemStatus = PlayerFoundationMgr.IsBuildingsDrawItem() or PlayerFoundationMgr.IsVendingMachineBuy();

    MainPageViewModelRed.vm.data.isTeaStatus = PlayerFoundationMgr.IsTeaIdleOrComplete();

    MainPageViewModelRed.vm.data.isStaminaStatus = PlayerFoundationMgr.IsRoomStamina();
end


function MainPageViewModelRed.CheckActivity()
    local activityKey;
    local redState;
    local activityKeyList = ActivityMgr.activityKeyList;
    local len = #activityKeyList;
    local isShowRed = false;
    for i = 1, len do
        activityKey = activityKeyList[i];
if (ActivityMgr.ActivityCanFinish(activityKey.key)) then
            redState = RedMgr.Singleton:GetRedStateById(activityKey.RedId);
            if (redState >= 1) then
                isShowRed = true;
                break;
            end
        end
    end
    MainPageViewModelRed.vm.data.siginRed = isShowRed;





end


function MainPageViewModelRed.CheckSigninHuaZhao()
    local status = ActivityMgr.ActivityCanFinish(ActivityKey.signinHuaZhao);
    RedMgr.Singleton:UpdateClientRedData("1307", status and 1 or 0);
end



function MainPageViewModelRed.CheckRefreshActivityState()
    local activityKey;
    local redState;
    local activityKeyList = ActivityMgr.activityKeyList;
    local len = #activityKeyList;
    local isShowRed = false;
    for i = 1, len do
        activityKey = activityKeyList[i];
if (ActivityRedStateChangeKey[activityKey.key]~=nil) then
local re=(ActivityMgr.ActivityCanFinish(activityKey.key));
local redNum=re and 1 or 0;
            RedMgr.Singleton:UpdateClientRedData(activityKey.RedId,redNum);
        end
    end
    MainPageViewModelRed.vm.data.siginRed = isShowRed;
end

local MainUIItemUnlock = function(id)
    if IsNull(DataMgr.Player.uiSkin) or IsNull(DataMgr.Player.uiSkin.unlock) then
        return false;
    end
    return DataMgr.Player.uiSkin.unlock[id]~=nil and DataMgr.Player.uiSkin.unlock[id]>0;
end

function MainPageViewModelRed.CheckQHRedStatus()
    if (FeatureManager.IsLock("1022")) then return end
    local bgSwitchRed = 0
    local bgImages = DataMgr.Player.bgImages
    if TableIsNull(ConfigMgr.Config.BGSwitchMap) then
        return
    end
    local bgSwitchMap = ConfigMgr.Config.BGSwitchMap
    for _, v in pairs(bgSwitchMap) do
        if v.DefaultUnlock == 0 then

            if tonumber(v.Id) > 1006 then
                local key = DataMgr.Player.uid .. "_BgSwitch_" .. v.Id
                if not PlayerPrefs.HasKey(key) or PlayerPrefs.GetInt(key) == 0 then
                    bgSwitchRed = bgSwitchRed + 1
                end
            end
        end
            
        if (bgImages[v.Id] == nil) then
            if v.DefaultUnlock == 1 then
                if (#v.UnlockItem1 > 0) then
                    local count = PlayerItemMgr.GetItemCountById(v.UnlockItem1[1]);
                    if (count >= tonumber(v.UnlockItem1[2])) then
                        bgSwitchRed = bgSwitchRed + 1
                    end
                end
                if (#v.UnlockItem2 > 0) then
                    local count = PlayerItemMgr.GetItemCountById(v.UnlockItem2[1]);
                    if (count >= tonumber(v.UnlockItem2[2])) then
                        bgSwitchRed = bgSwitchRed + 1
                    end
                end
            end
        end
    end
    local themeSwitchRed = 0
    local firstkey = DataMgr.Player.uid .. "_MianUISwitch_FirstShow"
    if not PlayerPrefs.HasKey(firstkey) or PlayerPrefs.GetInt(firstkey) == 0 then
        themeSwitchRed = themeSwitchRed + 1
    end

    for k, v in pairs(ConfigMgr.Config.UIskinMap) do
        if k ~= "2001" and (v.DefaultUnlock==0 or MainUIItemUnlock(v.ID)) then
            local key = DataMgr.Player.uid .. "_MianUISwitch_" .. v.ID
            if not PlayerPrefs.HasKey(key) or PlayerPrefs.GetInt(key) == 0 then
                themeSwitchRed = themeSwitchRed + 1
            end
        end
    end
    
    local msgRedCount = MainPageViewModelRed.CheckMsgRedStatus()
    RedMgr.Singleton:UpdateClientRedData("15032", bgSwitchRed);
    RedMgr.Singleton:UpdateClientRedData("15033", themeSwitchRed);
    RedMgr.Singleton:UpdateClientRedData("15031", bgSwitchRed + themeSwitchRed + msgRedCount);
end

function MainPageViewModelRed.CheckMsgRedStatus()
    local msgRedKey = DataMgr.Player.uid.."_MsgRed"
    if not PlayerPrefs.HasKey(msgRedKey) or PlayerPrefs.GetInt(msgRedKey) == 0 then
        return 1
    else
        return 0
    end
end

function MainPageViewModelRed.Check()

    local count = 0;
    count = PlayerCharacterMgr.CheckMail();
    RedMgr.Singleton:UpdateClientRedData("1001", count);




    count = 0 + PlayerCharacterMgr.CheckCGMap();
    if count == 0 then
        count = count + PlayerCharacterMgr.CheckArchives()
    end
    if count == 0 then
        count = count + PlayerCharacterMgr.CheckJournal()
    end
    if count == 0 then
        count = count + PlayerCharacterMgr.CheckEventPlayback()
    end
    if count == 0 then
        count = count + PlayerCharacterMgr.CheckGroupPhotoRed()
    end
    if count == 0 then
        count = count + PlayerCharacterMgr.CheckAddAttrActiveRed()
    end
    if count==0 then
        count=count+PlayerCharacterMgr.GetReveiwActivityRed();
    end
    if count==0 then
        count=count+PlayerCharacterMgr.GetDispatchStoryRed();
    end
    RedMgr.Singleton:UpdateClientRedData("1055", count);




    count = PlayerCharacterMgr.CheckMission();
    RedMgr.Singleton:UpdateClientRedData("1036", count);

    count = LuaMgr.CheckMinimumReward()
    
    local giftCharacterRed = HeroRedDataHelper.CheckCurCardGiftCharacterRed()
    RedMgr.Singleton:UpdateClientRedData("1067", count + giftCharacterRed);
    local uid = DataMgr.Player.uid;

   
    local fbRed=HeroRedDataHelper.FrushMoreModRed();
    local trainingRewardRed1, trainingRewardRed2 = HeroRedDataHelper.GetTrainingRewardRed()
    local dispatchRed = DispatchData.GetRedPointCount()
    local redNum = fbRed + trainingRewardRed1 + trainingRewardRed2 + dispatchRed
    RedMgr.Singleton:UpdateClientRedData("1038", redNum)

    TrainingTowerHelper.GetTowerStageRewardsRedCount(function(trainingTowerRed)
        local timeRedCount = TrainingTowerHelper.GetTimeRedCount()
        RedMgr.Singleton:UpdateClientRedData("1038", redNum + trainingTowerRed + timeRedCount);
    end)
    
    HeroRedDataHelper.RefreshCollectorPractice();
   

    ShowWeaponMakeRed();
    ShowTeaTastRed();




    RedMgr.Singleton:UpdateClientRedData("16816", HeroRedDataHelper.GetEquipExchangeRed())
    RedMgr.Singleton:UpdateClientRedData("17830", PlayerGuildMgr.CheckMainRed())




    RedMgr.Singleton:UpdateClientRedData("16851", BossDummy3Mgr.GetRedStatus())

    HeroRedDataHelper.MainPageCheckRed();

    SCNJData.SetOldServerHotData()
    
    NonsenseChickTime = ConfigMgr.Config.constants.ChickShowTimeSecond
    MainPageViewModelRed.MainPageChickTimeShow()
    MainPageViewModelRed.CheckFoundation();
MainPageViewModelRed.CheckRefreshActivityState();
    MainPageViewModelRed.CheckSigninHuaZhao();
    MainPageViewModelRed.CheckActivity();
    MainPageViewModelRed.CheckQHRedStatus();
    PlayerCharacterMgr.CheckCharacter();



end