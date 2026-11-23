





local this = {};

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local textDes = nil;
local rootAnimator=nil;
local rectDes=nil;
local textClimDes=nil;
local goPoint=nil;
local goReslock=nil;
local goResIsOn=nil;
local goMoremodlock=nil;
local goMoremodIsOn=nil;
local goClimlock=nil;
local goClimIsOn=nil;
local goTraininglock=nil;
local goTrainingIsOn=nil;
local goTrainingRed=nil;
local btnDispatchLock= nil;
local btnDispatchIsOn= nil;
local btnDispatchRed = nil;
local levelList={ };
local subList={ };
local adTweenter=nil;
local jobData=nil;
local updateCortinue=nil;
local goStar=nil;
local goTrainingBtn=nil;
local goDummylock = nil
local goDummyIsOn = nil

if TrainingDungeonHelper==nil then
    require("ViewModel/TrainingDungeon/TrainingDungeonHelper")
end

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    textDes = uiLink:Get("textDes"):GetComponent("Text");
    rootAnimator=uiLink:Get("root"):GetComponent("Animator");
    rectDes=uiLink:Get("textDes"):GetComponent("RectTransform");
    textClimDes=uiLink:Get("textClimDes"):GetComponent("Text");
    goPoint=uiLink:Get("goPoint");
    goReslock=uiLink:Get("goReslock");
    goResIsOn=uiLink:Get("goResIsOn");
    goMoremodlock=uiLink:Get("goMoremodlock");
    goMoremodIsOn=uiLink:Get("goMoremodIsOn");
    goClimlock=uiLink:Get("goClimlock");
    goClimIsOn=uiLink:Get("goClimIsOn");
    goTraininglock=uiLink:Get("goTraininglock");
    goTrainingIsOn=uiLink:Get("goTrainingIsOn");
    goTrainingRed=uiLink:Get("goTrainingRed")
    btnDispatchLock = uiLink:Get("btnDispatchLock");
    btnDispatchIsOn = uiLink:Get("btnDispatchIsOn");
    btnDispatchRed = uiLink:Get("btnDispatchRed")
    goStar=uiLink:Get("goStar");
    goTrainingBtn=uiLink:Get("btnTraining")
    goDummylock=uiLink:Get("goDummylock")
    goDummyIsOn=uiLink:Get("goDummyIsOn")
    rectDes.anchoredPosition=Vector2(140, 0);

    for i = 1, 4 do
        local goLv=uiLink:Get("goLv"..i);
        if IsNull(goLv) then
            break
        end

        table.insert(levelList,goLv)
    end

    
    local goJob1= uiLink:Get("goJob1")
    table.insert(subList,goJob1)
    uiLink:AddClickEvent(goJob1,function()
        this.btnRes(1);
    end)

    local goJob2= uiLink:Get("goJob2")
    table.insert(subList,goJob2)
    uiLink:AddClickEvent(goJob2,function()
        this.btnRes(2);
    end)

    local goJob3= uiLink:Get("goJob3")
    table.insert(subList,goJob3)
    uiLink:AddClickEvent(goJob3,function()
        this.btnRes(3);
    end)

    local goJob4= uiLink:Get("goJob4")
    table.insert(subList,goJob4)
    uiLink:AddClickEvent(goJob4,function()
        this.btnRes(4);
    end)

    local goJob5= uiLink:Get("goJob5")
    table.insert(subList,goJob5)
    uiLink:AddClickEvent(goJob5,function()
        this.btnRes(5);
    end)
    
    uiLink:AddClickEvent("btnStartTrain",this.btnRes)
    uiLink:AddClickEvent("btnMoremod2",this.btnMoremod)
    uiLink:AddClickEvent("btnMoremod",this.btnMoremod)
    uiLink:AddClickEvent("btnClimbtown",this.btnClimbtown)
    uiLink:AddClickEvent("btnClimbtown2",this.btnClimbtown)
    uiLink:AddClickEvent("btnTraining",this.btnTraining)
    uiLink:AddClickEvent("btnDispatch",this.btnDispatch)
    uiLink:AddClickEvent("btnDummy",this.btnDummy)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    textDes = nil;
    rootAnimator=nil;
    rectDes=nil;
    textClimDes=nil;
    goPoint=nil;
    goReslock=nil;
    goResIsOn=nil;
    goMoremodlock = nil;
    goMoremodIsOn = nil;
    goClimlock = nil;
    goClimIsOn = nil;
    goTraininglock= nil;
    goTrainingIsOn= nil;
    goTrainingRed = nil;
    btnDispatchLock= nil;
    btnDispatchIsOn= nil;
    btnDispatchRed = nil;

    adTweenter=nil;
    jobData=nil;
    updateCortinue=nil;
end

this.btnRes=function(jobId)
    if FeatureManager.IsLock("1070") then
        FeatureManager.GotoViewModel("1070")
        return;
    end







        if jobId~=nil then
            local index=1;
            for i, v in ipairs(jobData) do
                local id= tonumber(jobData[i].activeId)%2000;
                if id == jobId then
                    if v.unlock  then
                        HeroParameter.dailyType=2;
                        HeroParameter.dailyStyle=index;
                        break;
                    else
                        print("未解锁  "..jobId)
                        return
                    end
                end

                if v.unlock then
index=index+1;
                end
            end
        end
        
        FeatureManager.GotoViewModel("1070")

end

this.btnMoremod=function()
    if FeatureManager.IsLock("1080") then
        FeatureManager.GotoViewModel("1080")
        return;
    end
    this.PreMoreModOnAskThemeInfo(function()
        FeatureManager.GotoViewModel("1080")
    end)
end

this.PreMoreModOnAskThemeInfo=function(callback)
    if HeroParameter.moreModeTheme~=nil then
        if callback~=nil then
            callback();
        end
        return;
    end
    local dataMoreModData=DataMgr.Player.moreModData;
    if dataMoreModData.Expires==nil or dataMoreModData.Expires - LuaMgr.Timestamp()<=0 then
        this.OnAskGetCurrentTheme(function(theme)
            if callback~=nil then
                callback();
            end
        end)
    else
        if callback~=nil then
            callback();
        end
    end
end

this.btnClimbtown=function()
    if FeatureManager.IsLock("3070") then
        FeatureManager.GotoViewModel("3070")
        return;
    end

    TrainingTowerHelper.ClearCurTowerCache()

    if TrainingTowerHelper.CheckWeekTowerExpired() then
        TrainingTowerHelper.OnAskGetCurrentRotation(function()
            FeatureManager.GotoViewModel("3070")
        end)
    else
        FeatureManager.GotoViewModel("3070")
    end
end

this.btnTraining = function()
    if FeatureManager.IsLock("11001") then
        FeatureManager.GotoViewModel("11001")
        return;
    end

    FeatureManager.GotoViewModel("11001")
    if TrainingDungeonHelper.CheckOpenTime() then
        FeatureManager.GotoViewModel("11001")
    end
end

this.btnDispatch = function()
    RedMgr.Singleton:FrushRedCondition("16820")
    RedMgr.Singleton:UpdateClientRedData("16820", 0)
    FeatureManager.GotoViewModel("30095")
end

this.btnDummy = function()
    RedMgr.Singleton:FrushRedCondition("17014")
    RedMgr.Singleton:UpdateClientRedData("17014", 0)
    FeatureManager.GotoViewModel("30662")
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        RedMgr.Singleton:RegisterViewModel(UIName.AreaDailyMainViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return end
        PlayerAssistMgr.Clear();
        if adTweenter~=nil then
            adTweenter:Kill();
        end

        SetActive(goPoint,false)
        SetActive(goStar,false);

          rootAnimator.enabled = false;
          rootAnimator.enabled = true;
          rootAnimator:Play("AreaDailyMainPanel");

        local resLock=FeatureManager.IsLock("1070");
        local moreModLock=FeatureManager.IsLock("1080");
        local climbtownLock=FeatureManager.IsLock("3070");
        local trainingLock=FeatureManager.IsLock("11001");
        local dispatchLock = FeatureManager.IsLock("30095");
        local dummyLock = FeatureManager.IsLock("30662");

        SetActive(goReslock, resLock)
        SetActive(goResIsOn,not resLock)
        SetActive(goMoremodlock,  moreModLock)
        SetActive(goMoremodIsOn, not moreModLock)
        SetActive(goClimlock,  climbtownLock)
        SetActive(goClimIsOn, not climbtownLock)
        SetActive(goTraininglock,  trainingLock)
        SetActive(goTrainingIsOn, not trainingLock)
        SetActive(goTrainingBtn, TrainingDungeonHelper.CheckOpenTime())
        SetActive(goDummylock, dummyLock)
        SetActive(goDummyIsOn, not dummyLock)

        SetActive(btnDispatchLock, dispatchLock)
        SetActive(btnDispatchIsOn, not dispatchLock)
        SetActive(btnDispatchRed, false)

        for i = 1, #subList do
            SetActive(subList[i].transform:Find("isOn").gameObject,false);
            SetActive(subList[i].transform:Find("lock").gameObject,true);
        end

        if not resLock then
            local dailyList=this.FormatData(DataMgr.Player.dailyActives,function(a,b) return tonumber(a.activeId)<tonumber(b.activeId)  end);
            if #dailyList>=2 then
                jobData=this.FormatData(dailyList[2].dailyActives,function(a,b) return tonumber(a.activeId)<tonumber(b.activeId)  end);
                if(jobData~=nil) then
                    table.sort(jobData,function(a,b) return a.unlock and not b.unlock end);
                    for i, v in ipairs(jobData) do
                        if v.unlock then
                            local id= tonumber(v.activeId)%2000;
                            SetActive(subList[id].transform:Find("isOn").gameObject,true);
                            SetActive(subList[id].transform:Find("lock").gameObject,false);
                        end
                    end
                end
            end
        end

        if not climbtownLock then

            if TrainingTowerHelper.CheckWeekTowerExpired() then
                TrainingTowerHelper.OnAskGetCurrentRotation(this.RefreshTrainingTower)
            else
                this.RefreshTrainingTower()
            end
        end

        if not moreModLock then
            local dataMoreModData=DataMgr.Player.moreModData;
            if dataMoreModData.Expires==nil or dataMoreModData.Expires - LuaMgr.Timestamp()<=0 then
                this.OnAskGetCurrentTheme(function(theme)
                    this.ShowSquadInfo(theme);
end);
            else
                this.ShowSquadInfo(dataMoreModData.Theme);
            end
        end

        if not trainingLock then
            local red1, red2 = HeroRedDataHelper.GetTrainingRewardRed()
            SetActive(goTrainingRed, red1 + red2 > 0)
        end

        if not dispatchLock then
            local red1 = DispatchData.GetRedPointCount()
            SetActive(btnDispatchRed, red1 > 0)
        end

        HeroParameter.moreModeTheme=nil
    end,
    before_deactive = function(vm)
        if adTweenter~=nil then
            adTweenter:Kill();
        end

        if updateCortinue ~= nil then
            coroutine_runner.stop(updateCortinue)
        end
    end,
    before_destroy = function(vm)
        this.Clear()
    end,
}

this.OnAskGetCurrentTheme=function(callBack)
    ApiMgr.Request("moremod/get_current_theme", { } ,true,function(result)
        local re=json.decode(result);
        HeroParameter.moreModeTheme=re.result;
        if callBack~=nil then
            callBack(re.result.Theme)
        end
    end,nil,true)
end


this.ShowSquadInfo=function(moreModTheme)
    local dataMoreModData=DataMgr.Player.moreModData;
    local dataDungeons ={};
    local allCount=#levelList;
    for i = 1, allCount do
        SetActive(levelList[i].transform:Find("imgOn").gameObject,false)
    end
    
    if type(dataMoreModData.Dungeons) =="table" then
        for i,v in pairs(dataMoreModData.Dungeons) do
            table.insert(dataDungeons,v);
        end
        
        table.sort(dataDungeons,function(a, b)
            return a.Id<b.Id;
        end)

        local index=1;
        for i,v in ipairs(dataDungeons) do
            if v.Score>0 then
                SetActive(levelList[index].transform:Find("imgOn").gameObject,true)
                index=index+1;
            end
        end
    end
    
    local cfgmoreModList={};
    local moreModGroup=ConfigMgr.Config.moreModGroup;
    local cycleList=ConfigMgr.Config.moreModConstants.ActivityCycleList;
    local isBegain=false;
    for i,v in ipairs(cycleList) do
        if v==moreModTheme then
            isBegain=true;
        end
        if isBegain then
            table.insert(cfgmoreModList,moreModGroup[v]);
        end
    end
    
    for i,v in pairs(cfgmoreModList) do
textDes.text=string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2235"),LuaMgr.GetLangText(v.GroupNameLan));
    end

    SetActive(goPoint,(#cfgmoreModList>0))
    
    local width=100;
    local beginPos=Vector2(width+textDes.preferredWidth/2,0);
    local endPos=Vector2(-textDes.preferredWidth/1.2,0);
    rectDes.anchoredPosition=beginPos;

    if adTweenter~=nil then
        adTweenter:Kill();
    end

    local time=(textDes.preferredWidth+width)/50;
    adTweenter=DOTWeen.To(function() return beginPos  end,function(vector) rectDes.anchoredPosition=vector end,endPos,time):SetEase(Ease.Linear):SetLoops(-1);

    if updateCortinue ~= nil then
        coroutine_runner.stop(updateCortinue)
    end

    updateCortinue = coroutine_runner.start(function()
        coroutine_runner.wait(1)
        SetActive(goStar,true);
    end)
    
end

this.FormatData=function(data,compare)
    local list={};
    for i,v in pairs(data) do
        table.insert(list,v);
    end
    table.sort(list,compare);
    return list;
end

this.RefreshTrainingTower = function()
    local curTowerData=DataMgr.Player.Tower;
    local towerRecords=DataMgr.Player.TowerRecords;
    local isWheeling = curTowerData.Dungeon~="";
    local cfgBattleTowerMap =ConfigMgr.Config.BattleTowerMap;
    local curTower=nil;
    local isNor = false
    local isNor_2 = false
    local isOpenNor_2 = false
    local isFinishWeekTower = true
    if isWheeling then
        for i, v in pairs(cfgBattleTowerMap) do
            if v.GroupId == curTowerData.GroupId then
                curTower = v
                isNor = v.RotationType == 1
            end
        end
    else
        local cfgTowerList={};
        for i,v in pairs(cfgBattleTowerMap) do
            table.insert(cfgTowerList,v);
        end
        table.sort(cfgTowerList,function(a, b) return a.GroupId<b.GroupId end);
        for i,v in ipairs(cfgTowerList) do
            if v.RotationType == 1 then
                if towerRecords[v.GroupId]==nil then
                    curTower = v
                    isNor = true
                    isFinishWeekTower = false;
                    break;
                end
            elseif v.RotationType == 2 or v.RotationType == 3 then
                isOpenNor_2 = isOpenNor_2 or LuaMgr.Timestamp() - v.Opentime >= 0
                if towerRecords[v.GroupId]==nil and LuaMgr.Timestamp() - v.Opentime >= 0 then
                    curTower = v
                    isNor_2 = true
                    isFinishWeekTower = false;
                    break;
                end
            elseif v.RotationType == 4 then
                if TrainingTowerHelper.weekTowerData ~= nil and TrainingTowerHelper.weekTowerData.RotationId ~= nil and
                        v.RotationId == TrainingTowerHelper.weekTowerData.RotationId then

                    if towerRecords[v.GroupId] == nil or towerRecords[v.GroupId] - LuaMgr.Timestamp() <= 0 then
                        curTower = v
                        isFinishWeekTower = false;
                        break
                    end
                end
            end
        end
    end
    
    local climbInfo = ConfigMgr.LangGlobal("2255")
    local groupIdName = curTower == nil and "" or LuaMgr.GetLangText(curTower.GroupnameLan)

    if isWheeling then
        local index=TrainingTowerHelper.GetDungeonIndexFromList(curTowerData.GroupId,curTowerData.Dungeon)
        local indexStr = ConfigMgr.LangGlobal(tostring(9100 + index - 1))
        local formatStr = "%s-%s"
        textClimDes.text=string.format(climbInfo,string.format(formatStr, groupIdName, indexStr));
    else
        if isNor then

            textClimDes.text=string.format(climbInfo,groupIdName);
        else

            if isNor_2 then

                textClimDes.text=string.format(climbInfo,groupIdName);
            else

                if TrainingTowerHelper.CheckWeekTowerExpired() then

                    if isOpenNor_2 then

textClimDes.text=ConfigMgr.LangGlobal("9200")
                    else

textClimDes.text=ConfigMgr.LangGlobal("9012")
                    end
                else

                    if isFinishWeekTower then

textClimDes.text=ConfigMgr.LangGlobal("9202")
                    else
                        textClimDes.text=string.format(climbInfo,groupIdName);
                    end
                end
            end
        end
    end
    local refreshRedPoint = function(trainingTowerRed)
        local timeRed = TrainingTowerHelper.GetTimeRedCount()
        RedMgr.Singleton:UpdateClientRedData("15100", trainingTowerRed + timeRed);
        RedMgr.Singleton:Refresh();
    end 
    TrainingTowerHelper.GetTowerStageRewardsRedCount(refreshRedPoint)
end

return vm({
    hook = hook
})