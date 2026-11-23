require("ViewModel/Activity/NewPlayerLimitBreakMgr")  


ActivityMgr = {
    activityKeyList = {},
    welfareKeyList = {},
    trafficPermit_passPay1={},
    trafficPermit_passPay2={},
    trafficPermit_passPay3={},
    trafficPermit_passShop={},
    cdKeyState=nil,
    isConfigUpdate=false;
changan_isFristLogin=false;
    crisiscontractLastScore = nil,
}


function ActivityMgr.CheckPopUpList()
    if LuaMgr.IsGuide() then return end;

    if DataExHelper.Check_ComeBackActivity() then
        if DataExHelper.Check_ComeBackLetter() then
            PopUpMgr.Insert(UIName.ComeBackLetterPopup)
        end
    end
    if NoticeMgr.GetPaiLianCount()>0 then
        PopUpMgr.Insert(UIName.NoticeSlapfaceViewModel);
    end
    if ActivityMgr.CheckInPopOneYear() then
        PopUpMgr.Insert(UIName.ActivityCheckInYearViewModel); 
    end
    if ActivityMgr.IsPopSignIn()then
        PopUpMgr.Insert(UIName.ActivitySignInViewModel);
    end
    if ActivityMgr.IsCheckInMonthCurDay() then
        PopUpMgr.Insert(UIName.ActivitySignInMonthViewModel);
    end
    if DataExHelper.Check_CelebrationActivity() then
        PopUpMgr.Insert(UIName.CelebrationViewModel);
    end
    if DataExHelper.Check_BrilliantGift() then
        PopUpMgr.Insert(UIName.BrilliantGiftPopUpViewModel);
    end
    if DataExHelper.Check_YPS() then
        PopUpMgr.Insert(UIName.YPSSignIn7DaysViewModel);
    end
    for key, value in pairs(ActivityPopKey) do
if DataExHelper.CommonActivityCheck(key) then
if not DataExHelper.CommonFinishActivityCheck(key) then
                PopUpMgr.Insert(value);
            end
        end
    end
end





function ActivityMgr.IsPopSignIn()
    local checkIn_Quests=DataExHelper.Check_DataExByGroupId(101)
    for i,v in ipairs(checkIn_Quests) do
        if v.state==2 then
            return true;
        end
    end
    return false;
end

function ActivityMgr.IsCheckInMonthCurDay()

    local date=Get_Beijing_Time(LuaMgr.Timestamp());
    local curDay=date.day
    if date.hour<4 then
        local offTimeStamp=LuaMgr.Timestamp()-4*60*60;
        date=os.date("*t",offTimeStamp);
        curDay=date.day;
    end
    return DataMgr.Player.monthlySignInRecords[tostring(curDay)]==nil;
end

function ActivityMgr.CheckInPopOneYear()
    if not DataExHelper.CommonActivityCheck(ActivityKey.checkInOneYear) then
        return false;
    end
    local checkInList=DataExHelper.Check_ConfigQuestEventByText("checkInOneYear")
    if IsNull(checkInList) or #checkInList==0 then
        return false;
    end
    local questData=DataMgr.Player.quests;
    for i,v in ipairs(checkInList) do
        if questData[v.id]~=nil and questData[v.id].state==2 then
            return true;
        end
    end
    return false;
    
end

function ActivityMgr.ActivityRunningAnyOne()
    local key=nil;
    for i,v in ipairs(ActivityMgr.activityKeyList) do
        if ActivityMgr.ActivityRuning(v.key) then
            key=v.key;
            break;
        end
    end
    return key;
end






function ActivityMgr.ActivityRuning(tag)
    if tag==ActivityKey.yunyou then
        return DataExHelper.Check_TourismRuning()~=nil;
    elseif tag==ActivityKey.newYear then
        return DataExHelper.Check_NewYearRunning();
    elseif tag==ActivityKey.huazhao then
        return DataExHelper.Check_FlowerRuning();
    elseif tag==ActivityKey.questionnaire then

        return DataExHelper.Check_QuestionnaireSurvey();
    elseif tag == ActivityKey.collect then
        return DataExHelper.Check_CollectActivity();
    elseif tag==ActivityKey.travel then
        return DataExHelper.Check_TravelRunning();
    elseif tag==ActivityKey.cdkey then
        return DataExHelper.Check_CDKeyRuning();
    elseif tag==ActivityKey.changan then
        return DataExHelper.Check_ChanganRunning();
    elseif tag==ActivityKey.entry then
        return DataExHelper.Check_JobInRunning();
    elseif tag==ActivityKey.initialcharge then
        return DataExHelper.Check_InitialchargeRunning()
    elseif tag==ActivityKey.onlinereward then
        return DataExHelper.Check_SnacksOnLineRunning();
    elseif tag==ActivityKey.pass then
        return DataExHelper.Check_TrafficPermintRuning()
    elseif tag==ActivityKey.welfare then
        return DataExHelper.Check_BuyHeroActivity();
    elseif tag==ActivityKey.draw then
        return DataExHelper.Check_LuckDrawRunning();
    elseif tag==ActivityKey.checkIn7 then
        return DataExHelper.Check_SignInNewRuning()
    elseif tag==ActivityKey.daqin then
        return DataExHelper.Check_DaQin();
    elseif tag==ActivityKey.GuoBao then
        return DataExHelper.Check_GuoBao();
    elseif tag==ActivityKey.buyHero then
        return DataExHelper.Check_BuyHeroActivity()
    elseif tag == ActivityKey.Story then
        return DataExHelper.Check_HeroBranchActivity()
    elseif tag == ActivityKey.sailing  then
        return DataExHelper.Check_Sailing();
    elseif tag==ActivityKey.walkmount then
        return DataExHelper.Check_WalkMount();
    elseif tag == ActivityKey.musicYDW then
        return DataExHelper.Check_Music();
    elseif tag==ActivityKey.NianBeast then
        return DataExHelper.Check_NianBeast();
    elseif tag==ActivityKey.UpactorV0076 then
        return DataExHelper.Check_UpactorV0076();
    elseif tag==ActivityKey.UpactorA0093 then
        return DataExHelper.Check_UpactorA0093();
    elseif tag==ActivityKey.UpactorOne or tag==ActivityKey.UpactorTwo or tag==ActivityKey.UpactorThree or tag==ActivityKey.UpactorFour then
        return DataExHelper.Check_Upactor(tag);
    elseif tag==ActivityKey.BalatroBrand then
        return DataExHelper.CommonActivityCheck(tag);
    elseif tag==ActivityKey.SGY then
        return DataExHelper.Check_SGY();
    elseif tag==ActivityKey.SummerCamp then
        return DataExHelper.Check_SummerCamp();
    elseif tag==ActivityKey.KingDeerActivity then
        return DataExHelper.CommonActivityCheck(tag);
    elseif tag==ActivityKey.YearGift1 then
        return DataExHelper.CheckYearGift(tag)
    elseif ActivityCheckFinishOnOpenKey[tag]~=nil then
if DataExHelper.CommonActivityCheck(tag) then
return not DataExHelper.CommonFinishActivityCheck(tag);
        else
            return false;
        end
    elseif ActivityKey[tag]~=nil then
return DataExHelper.CommonActivityCheck(tag);
    end
    return false;
end

function ActivityMgr.ActivityFinish(tag)







end


function ActivityMgr.ActivityCanFinish(tag)
    if tag == ActivityKey.backPlayer then
        return HeroRedDataHelper.SetComeBackRed() > 0
    elseif tag == ActivityKey.HuanZhangActivity then
        return HeroRedDataHelper.SetBrilliantTrialPlayRed() > 0
    elseif tag == ActivityKey.LimitCharacterOne or tag == ActivityKey.LimitCharacterTwo then
        return ActivityMgr.CheckLimitCharacterRedCount(tag)
elseif ActivityCheckCanFinishKey[tag]~=nil then
        return DataExHelper.CommonCanFinishActivityCheck(tag);
elseif ActivityKey[tag]~=nil then
        return ActivityMgr.ActivityRuning(tag);
    end
return false;
end


function ActivityMgr.CheckFristOpenAny()
    local activityBarNames=ActivityMgr.activityKeyList;
    table.sort(activityBarNames,function(a,b)
        return a.orderSum<b.orderSum;
    end)
    for i,v in ipairs(activityBarNames) do
        if ActivityMgr.ActivityRuning(v.key) and PlayerPrefs.GetInt(DataMgr.Player.uid..v.key)==0 then
            return true;
        end
    end
    return false;
end



function ActivityMgr.OnAskSignInMonth(callBack,failBack)
    ApiMgr.Request("get_monthly_sign_in_list", {}, true, function(result)
        local re=json.decode(result);
        local data=re.result;
        if callBack~=nil then
            callBack(data);
        end
    end, function()
        if failBack~=nil then
            failBack();
        end
    end, true);
end







function ActivityMgr.CompleteActivity(groupId,activityId,rewardids,nums)
    LuaMgr.CompleteActivity(groupId,activityId,rewardids,nums);
end





function ActivityMgr.GetActivityId(actGroupId)
    local activityId=nil;
    for i,v in ipairs(ActivityMgr.activityTag) do
        if(v.activity==actGroupId) then
            activityId=v.activity_instance;
            break
        end
    end
    return activityId;
end





function ActivityMgr.GetRareSprite(rare)
    return ConfigHelper.GetRareSprite(rare)
end





function ActivityMgr.GetItemTexture(id)
    return ConfigHelper.GetItemTexture(id)
end



function ActivityMgr.OnAskFocusOnData(callBack)
    ApiMgr.Request("focus/getcode",{},true,function(data)
        local re=json.decode(data);
        ActivityMgr.cdKeyState=re.result.Status;
        if callBack~=nil then
            callBack(re.result);
        end
    end,nil,true);
end


function ActivityMgr.Activity_Reward(type,actId,callBack)
    local askData={Activity=type,ActivityID=actId}
    ApiMgr.Request("activity_reward",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


function ActivityMgr.OnChangeData(data)
    if not LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then return end;
    local type=tostring(data[0]);
    if type~="items" then return end;
    HeroRedDataHelper.ShowFlowerRed();
    RedMgr.Singleton:RefreshOtherViewModel(UIName.MainPageViewModel);

end


function ActivityMgr.HeartAcrossDay()
    ActivityMgr.CheckPopUpList();
    if LuaMgr.IsPanelOpen("MainPageViewModel") then
        PopUpMgr.StartPopUp();
    end
end


function ActivityMgr.FirstMainPage()
    ActivityMgr.changan_isFristLogin=true;
    ActivityMgr.CheckPopUpList();
end






function ActivityMgr.Init()
    if  not DataHelper.firstMainPage and  not ActivityMgr.isConfigUpdate then return end;
    ActivityMgr.isConfigUpdate=true;
    require("ViewModel/Changan/ChanganMgr")
    ActivityMgr.RefreshActivityData();
    if DataExHelper.Check_CDKeyRuning() and ActivityMgr.cdKeyState==nil then
        ActivityMgr.OnAskFocusOnData();
    end
    LuaMgr.RemoveUIEventListener(UIEventConst.FirstMainPage,ActivityMgr.FirstMainPage);
    LuaMgr.AddUIEventListener(UIEventConst.FirstMainPage,ActivityMgr.FirstMainPage);
    LuaMgr.RemoveDataEventListener(ActivityMgr.OnChangeData);
    LuaMgr.AddDataEventListener(ActivityMgr.OnChangeData);
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,ActivityMgr.HeartAcrossDay)
    LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,ActivityMgr.HeartAcrossDay);

    BossDummy3Mgr.Init()
end


function ActivityMgr.RefreshActivityData()
    if IsNull(ConfigMgr.Config.activityGroup) then
        print("fix bugly,activityGroup config is nil,")
        return
    end;
    ActivityMgr.activityKeyList = {}

    ActivityMgr.welfareKeyList = {}

    ActivityMgr.groupKeyList = {}

    ActivityMgr.activityLeft={}

    ActivityMgr.activityTop={}


    local config = {},{}
local timeBool = false


    for i,v in pairs(ConfigMgr.Config.activityGroup) do
        if v.startTimeUnix==0 and v.endTimeUnix==0 then
            timeBool = true
        else


            timeBool = v.startTimeUnix <= LuaMgr.Timestamp() and v.endTimeUnix >LuaMgr.Timestamp()
        end
        if v.key ~= nil and v.key ~= "" and v.open and timeBool then
            ActivityMgr.groupKeyList[v.key] = "group."..v.id

            config = {orderSum = v.order,key=v.key,name = LuaMgr.GetLangText(v.nameLan),
                      panel = v.panel,RedId = v.RedId, text = v.text}
            if v.type == 1 then
                table.insert(ActivityMgr.activityKeyList,config)
            elseif v.type == 2 then
                table.insert(ActivityMgr.welfareKeyList,config)
            end

            if v.IconType=="big" or v.IconType=="small"then
                config.iconOrder=v.IconOrder
                config.iconPanel=v.IconPanel
                config.iconRes=v.IconRes
                config.isTime=v.TimerBool==1
                if v.IconType=="big" then
                    table.insert(ActivityMgr.activityLeft,config)
                else
                    table.insert(ActivityMgr.activityTop,config)
                end
            end
            

            if v.key == ActivityKey.RogueLike and not IsNullOrEmpty(v.text) and RogueMgr.CheckRogueLike2IsOpen() then

                local nextRogueActivityCfg = nil
                for j, activityCfg in pairs(ConfigMgr.Config.activityGroup) do
                    if activityCfg.key == v.text then
                        nextRogueActivityCfg = activityCfg
                        break
                    end
                end
                if nextRogueActivityCfg ~= nil then
                    config.name = LuaMgr.GetLangText(nextRogueActivityCfg.nameLan)
                    config.panel = nextRogueActivityCfg.panel
                    config.RedId = nextRogueActivityCfg.RedId
                    config.iconPanel = nextRogueActivityCfg.IconPanel
                    config.iconRes = nextRogueActivityCfg.IconRes
                end
            end
        end
    end
    
    ActivityMgr.crisiscontractLastScore = nil
end
function ActivityMgr.DateToTimestamp(timeStr)
    if IsNullOrEmpty(timeStr) then return 0 end
    local pattern = "(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)"
    local year, month, day, hour, min, sec = timeStr:match(pattern)
    return os.time({year = year,month = month,day = day,hour = hour,min = min,sec = sec})
end

function ActivityMgr.DoubleRewards_ActiveID(dungeonId)

    if DataExHelper.CommonActivityCheck(ActivityKey.double) then
        local ids={}
        if IsNull(DataMgr.Player.activityDouble) then return end;
        for i,v in pairs(DataMgr.Player.activityDouble) do
            table.insert(ids,v.id);
        end
        if #ids==0 then return nil end;
        return ids[1];
    end
    if DataExHelper.Check_ComeBackActivity() then
        for key,value in pairs(ConfigMgr.Config.ActivityDoubleMap) do
            if not TableIsNull(value) and not TableIsNull(value.DungeonIdGroup) then
                return value.DungeonIdMap[dungeonId] ~= nil
            end
        end
    end
end


function ActivityMgr.DoubleRewards_CheckDungeonID(dungeonId,isResult)
    if (isResult ~= nil or DataExHelper.CommonActivityCheck(ActivityKey.double)) and not DataExHelper.Check_ComeBackActivity() then
        local doubleID=ActivityMgr.DoubleRewards_ActiveID();
        if doubleID==nil then return false end;
        local configActiveDouble=ConfigMgr.Config.ActivityDoubleMap[doubleID];
        if configActiveDouble==nil or IsNull(configActiveDouble.DungeonIdMap) then return false end;
        local  dataDouble=DataMgr.Player.activityDouble[doubleID]
        return configActiveDouble.DungeonIdMap[dungeonId]~=nil,dataDouble.totalTimes-dataDouble.todayUsedTimes;
    end
    if isResult ~= nil or DataExHelper.Check_ComeBackActivity() then
        local totalCount = ConfigMgr.Config.constants.RetDoubTotal
        local usedCount = DataMgr.Player.backPlayer.doubleRewardCount
        return ActivityMgr.DoubleRewards_ActiveID(dungeonId),totalCount - usedCount
    end
    return false;
end

function ActivityMgr.DoubleRewards_CheckDailyFB(typeId,subId)

    if not DataExHelper.CommonActivityCheck(ActivityKey.double) then
        if not DataExHelper.Check_ComeBackActivity() then
            return false
        else

            return true
        end
    else


        local doubleID=ActivityMgr.DoubleRewards_ActiveID();
        if doubleID==nil then return false end;
        local configActiveDouble=ConfigMgr.Config.ActivityDoubleMap[doubleID];
        if typeId~=nil then
            for i,v in pairs(ConfigMgr.Config.dailyActiveMap) do
                if v.activeId==typeId and configActiveDouble.DailyActiveIDMap[v.id]~=nil then
                    return true;
                end
            end
            return false;
        end
        if subId~=nil then
            return configActiveDouble.DailyActiveIDMap[subId]~=nil ;
        end
    end
end


function ActivityMgr.DoubleRewards_ProText()
    if not DataExHelper.CommonActivityCheck(ActivityKey.double) then
        if not DataExHelper.Check_ComeBackActivity() then
            return ""
        else
            local totalCount = ConfigMgr.Config.constants.RetDoubTotal
            local usedCount = DataMgr.Player.backPlayer.doubleRewardCount
            local strTip = ConfigMgr.LangGlobal("10217")
            return string.format(strTip,totalCount - usedCount)
        end
    else

        local doubleID=ActivityMgr.DoubleRewards_ActiveID();
        if doubleID==nil then return ""  end;
        local  dataDouble=DataMgr.Player.activityDouble[doubleID]
        local strTip=ConfigMgr.LangGlobal("10217")
        return string.format(strTip,dataDouble.totalTimes-dataDouble.todayUsedTimes)
    end
end


function ActivityMgr.GetCrisisContractRatingImg(score, isEnter)
    local level = 1
    local levelCfg = ConfigMgr.Config.constants.WJHYLevel
    for i, v in ipairs(levelCfg) do
        if score > v[1] and score <= v[2] then
            level = i
            break
        end
    end

    local levelToRating = {"d", "c", "b", "a", "s", "ss", "sss"}
    local ratingImgStr = isEnter and "ui_wjhy_rk_" or "ui_wjhy_pj_"
    ratingImgStr = ratingImgStr .. levelToRating[level]
    return LuaMgr.GetSprite("CrisisContract", ratingImgStr);
end

function ActivityMgr.GetCrisisContractNumSprite(num)
    return LuaMgr.GetSprite("CrisisContract", "ui_wjhy_sz" .. num)
end

function ActivityMgr.GetActivityBuffList(activityKey)
    local buffList = {}
    local activityBuffs = ConfigMgr.Config.ActivityBuffMap
    for k, v in pairs(activityBuffs) do
        if v.ActivityGroup == activityKey then
            table.insert(buffList, v)
        end
    end
    
    table.sort(buffList, function(a, b) return a.Id < b.Id end)
    return buffList
end

function ActivityMgr.GetActivityBuffUnlock(activityKey, BuffId)
    local unlockBuffMap = DataMgr.Player.activityBuffMap[activityKey]
    if unlockBuffMap == nil or unlockBuffMap.unlock == nil then
        return false
    end
    return unlockBuffMap.unlock[BuffId] ~= nil
end

function ActivityMgr.IsNewPlayerLimitSSRActivityOpen()
    if DataMgr.Player.accountVersion == 1 and ConfigMgr.Config.constants ~= nil and ConfigMgr.Config.constants.NewPlayerLimitOpenSwitch == 1 then
        require("ViewModel/Activity/NewPlayerLimitSSRMgr")
        return true
    end
    return false
end

function ActivityMgr.IsNewPlayerLimitEquipActivityOpen()
    if DataMgr.Player.specialPurchase2 == 1 and ConfigMgr.Config.constants ~= nil and ConfigMgr.Config.constants.NewPlayerJumpWeaponOpenSwitch == 1 then
        require("ViewModel/Activity/NewPlayerLimitEquipMgr")
        return true
    end
    return false
end

function ActivityMgr.CheckLimitCharacterRedCount(tag)
    local showRed = DataExHelper.CommonCanFinishActivityCheck(tag);
    if not showRed then
        local playerPrefsKey = ""
        for i,v in pairs(ConfigMgr.Config.activityGroup) do
            if v.key == tag then
                playerPrefsKey = string.format("%s%s%s", DataMgr.Player.uid, tag, v.IconPanel[1])
                break
            end
        end
        if not IsNullOrEmpty(playerPrefsKey) then
            showRed = PlayerPrefs.GetInt(playerPrefsKey, 0) == 0
        end
    end
    return showRed
end

function ActivityMgr.GetEventBossesTotalScore()
    local totalScore = 0
    if not IsNull(DataMgr.Player.EventBosses) then
        for k, v in pairs(DataMgr.Player.EventBosses) do
            if v.Damage ~= nil then
                totalScore = totalScore + tonumber(v.Damage)
            end
        end
    end
    return totalScore
end

function ActivityMgr.CheckShowPlayerLimitBreakPopup()
    local nowTime = LuaMgr.Timestamp() 
    local level = ConfigMgr.Config.constants.NewbieGiftLevel
    local record = DataMgr.Player.dungeonRecords;
    local cache = record[level]
    local recordFinish = cache ~= nil and cache.completeCount ~= nil and cache.completeCount > 0
    if nowTime >= ConfigMgr.Config.constants.NewbieGiftTime and recordFinish then      
        if(NewPlayerLimitBreakMgr.NewbieGiftDisplayTime > 0)then         
            local curTime = LuaMgr.Timestamp()    
            local minLeftTime = 0
            minLeftTime = NewPlayerLimitBreakMgr.NewbieGiftDisplayTime + NewPlayerLimitBreakMgr.NewbieGiftContinueTime - curTime            
            if minLeftTime <= 0  then
                return false
            end
        end   
        if(NewPlayerLimitBreakMgr.CheckGetAll ~= nil and NewPlayerLimitBreakMgr.CheckGetAll())then
            return false
        end

        return true 
    end
    return false
end

function ActivityMgr.CheckIsGiftCharacter(activityTextType)

    return activityTextType == "dptd" or activityTextType == "zjzl"
end

function ActivityMgr.CheckGiftCharacterIsOpenByCardId(cardId)

    local activityCfg = nil
    for i,v in pairs(ConfigMgr.Config.activityGroup) do
        if ActivityMgr.CheckIsGiftCharacter(v.text) and cardId == v.IconPanel[1] then
            activityCfg = v
        end
    end

local timeBool = false
    if not TableIsNull(activityCfg) then
        if activityCfg.startTimeUnix==0 and activityCfg.endTimeUnix==0 then
            timeBool = true
        else


            timeBool = activityCfg.startTimeUnix <= LuaMgr.Timestamp() and activityCfg.endTimeUnix >LuaMgr.Timestamp()
        end
        if activityCfg.key ~= nil and activityCfg.key ~= "" and activityCfg.open and timeBool then

            return activityCfg
        end
    end








    return nil
end

function ActivityMgr.GetGiftCharacterRedCount(cardId)
    local activityGroupTable = ActivityMgr.CheckGiftCharacterIsOpenByCardId(cardId)
    if TableIsNull(activityGroupTable) then
        return 0
    end

    local activityKey = activityGroupTable.key
    local activityData = DataExHelper.GetDataExByTag(activityKey);
    if activityData == nil or not DataExHelper.CommonActivityCheck(activityKey) then
        return 0
    end

    local showRed = false
    local groupId = ActivityMgr.groupKeyList[activityKey]
if LuaMgr.Timestamp() >= DataMgr.Player.variables[groupId].delTime then
        showRed = false
    else if DataMgr.Player.variables[groupId] ~= nil then
            local id=string.sub(groupId,7,#groupId);
            local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(tonumber(id))
            for index, value in ipairs(activityData) do
                local tempData = DataMgr.Player.quests[value.id]
                if value.eventType == 801 and tempData ~= nil and tempData.state == 2 then
                    showRed = true
                    break
                end
            end
        end
    end
    return showRed and 1 or 0
end

function ActivityMgr.GetGiftCharacterInfo(cardId)
    local activityGroupTable = ActivityMgr.CheckGiftCharacterIsOpenByCardId(cardId)
    if TableIsNull(activityGroupTable) then
        return ""
    end

    local activityKey = activityGroupTable.key
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByGroupId(activityGroupTable.id);
    table.sort(cfgCheckInQuest,function(a,b) return tonumber(a.id)<tonumber(b.id); end)
    local allCanGetTaskCount = 0
    local totalProgress = 0
    local totalTarget = 0
    local curTaskData = nil
    local lastTaskData = nil
    local taskList = {}
    for i,cfg in ipairs(cfgCheckInQuest) do
        local tempData = DataMgr.Player.quests[cfg.id]
        local state = DataExHelper.Check_RewardState(cfg.id)
        local progress = 0
        if not TableIsNull(tempData) then
            progress = tempData.progress
        end
        local taskData = {
            target = cfg.progress,
            progress = progress,
        }
        if cfg.eventType == 801 then
            local rewardItem = cfg.showReward[1]
            taskData.showReward = rewardItem
            taskData.dynamicAvatarId = ActivityMgr.GetItemDynamicAvatarID(rewardItem.id)
            allCanGetTaskCount = state == 2 and allCanGetTaskCount + 1 or allCanGetTaskCount
            if state == 2 then
                curTaskData = taskData
            elseif state == 1 and curTaskData == nil then
                curTaskData = taskData
            end
            lastTaskData = taskData
        elseif cfg.eventType == 808 then
            totalProgress = progress
            totalTarget = cfg.progress
        end
    end
    if curTaskData == nil then
        curTaskData = lastTaskData
    end
    local curTaskLevel = curTaskData.target
    local rewardType = 1
    local rewardId = curTaskData.showReward.id
    local rewardCount = curTaskData.showReward.count
    if not IsNullOrEmpty(curTaskData.dynamicAvatarId) then
        rewardType = 2
        rewardId = curTaskData.dynamicAvatarId
        rewardCount = 0
    end
    local redId = activityGroupTable.RedId;
    local tipsText = activityGroupTable.text;
    
    local infoStr = string.format("%s;%d;%d;%d;%d;%s;%d;%d;%s;%s", 
            activityKey, curTaskLevel, totalProgress, totalTarget, rewardType, rewardId, rewardCount, allCanGetTaskCount, redId, tipsText)
    return infoStr
end

function ActivityMgr.GetItemDynamicAvatarID(pItemId)
    local rewardItemCfg = ConfigHelper.GetItemById(pItemId)
    if rewardItemCfg.type ~= 13 then

        return ""
    end
    if nil ~= ConfigMgr.Config.avatarFrames then
        for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
            if v.type == 1 and v.imgType == 2 and v.unlockType == 2 and v.unlock == pItemId then
                return v.id
            end
        end
    end
    return ""
end

return ActivityMgr