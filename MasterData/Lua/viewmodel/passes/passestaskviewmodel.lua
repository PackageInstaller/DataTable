




require("ViewModel/Passes/Passes_TaskItem")
local this = {vm=nil, 
              taskUIList={},
              taskItemObj=nil;
};

local themId=nil
local cfgThemePass=nil;
local taskBarIndex=nil;
local dataPasses=nil;
local dataPassesMissions=nil;
local isTaskRewarding=false;
local isMaxExp=nil;
local isChargeRecord = nil;
local norReward = nil;
local highReward = nil;


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local good = nil;
local Middle = nil;
local goWeek = nil;
local goAchieve = nil;
local Right = nil;
local Left = nil;
local btnReward = nil;
local btnJump = nil;
local btnWeek = nil;
local btnAchieve = nil;
local btnRewardAll = nil;
local btnBuy = nil;
local ScrollView = nil;
local tranContent = nil;
local slider = nil;
local imgSlider = nil;
local txtPro = nil;
local txtMax = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    good = uiLink:Get("good");
    Middle = uiLink:Get("Middle");
    goWeek = uiLink:Get("goWeek");
    goAchieve = uiLink:Get("goAchieve");
    Right = uiLink:Get("Right");
    Left = uiLink:Get("Left");
    norReward = uiLink:Get("goNormal");
    highReward = uiLink:Get("goHigh");
    btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    btnJump = uiLink:Get("btnJump"):GetComponent("Button");
    btnWeek = uiLink:Get("btnWeek"):GetComponent("Button");
    btnAchieve = uiLink:Get("btnAchieve"):GetComponent("Button");
    btnRewardAll = uiLink:Get("btnRewardAll"):GetComponent("Button");
    btnBuy = uiLink:Get("btnBuy"):GetComponent("Button");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    slider = uiLink:Get("slider"):GetComponent("Slider");
    imgSlider = uiLink:Get("imgSlider"):GetComponent("Image");
    txtPro = uiLink:Get("txtPro"):GetComponent("Text");
    txtMax = uiLink:Get("txtMax"):GetComponent("Text");
    this.AddRigister(uiLink);
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    good = nil;
    Middle = nil;
    goWeek = nil;
    goAchieve = nil;
    Right = nil;
    Left = nil;
    btnReward = nil;
    btnJump = nil;
    btnWeek = nil;
    btnAchieve = nil;
    btnRewardAll = nil;
    btnBuy = nil;
    ScrollView = nil;
    tranContent = nil;
    slider = nil;
    imgSlider = nil;
    txtPro = nil;
    txtMax = nil;

end


this.AddRigister=function(uiLink)
    uiLink:AddClickEvent("btnWeek",function()
        taskBarIndex=1;
        this.SetTopBarState();
    end)
    uiLink:AddClickEvent("btnAchieve",function()
       taskBarIndex=2;
        this.SetTopBarState();
    end)
    uiLink:AddClickEvent("btnRewardAll",function()
        if not this.PassesIsRuning() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18002"));
            return;
        end
        this.OnAskMissionReward("all",function()
            this.ParseData();
        end)
    end)
    uiLink:AddClickEvent("btnBuy",function()
        if not this.PassesIsRuning() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18002"));
            return;
        end
        if isMaxExp then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18003"));
            return
        end
        LuaMgr.ShowLuaPanel(UIName.PassesBuyTipViewModel,themId,function()
            this.ParseData();
        end);
    end)
end


local data={}

local command = {

}




this.OnAskMissionReward=function(pid,callBack)
    local tag=taskBarIndex==1 and "weekly" or "period"
    local askData={
        passesID=themId,
        id=pid,
        tab=tag
    }
    ApiMgr.Request("passes/get_mission_award",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        this.Init(vm.behaviour)
        this.taskUIList=UIListView.New(tranContent);
        this.taskItemObj=vm.behaviour.transform:Find("template/taskItem").gameObject
        RedMgr.Singleton:RegisterViewModel(UIName.PassesTaskViewModel);
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            themId=vm.behaviour.Params[0];
            if IsNullOrEmpty(themId) then
                return
            end
            isChargeRecord = vm.behaviour.Params[1];
            taskBarIndex=1;           
        end
        this.ParseData();
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end
        this.taskUIList:Clear();
    end,
    
    before_destroy=function()
       UIListView.ClearItem("Passes_TaskItem") 
        this.Clear();
    end
}

this.PassesIsRuning=function()
    return not IsNull(dataPasses) and LuaMgr.Timestamp()<dataPasses.endTime;
end


this.ParseData=function()



    HeroRedDataHelper.GetPassesRed()
    cfgThemePass= ConfigMgr.Config.PassesMap[themId];
    if cfgThemePass==nil then
        return 
    end
    this.SetBaseInfo();
    dataPasses=DataMgr.Player.passesMultiple[themId]
    dataPassesMissions=DataMgr.Player.passesMissionsMultiple[themId];
    this.SetTopBarState();
end

this.SetTopBarState=function()
    SetActive(goWeek,taskBarIndex==1)
    SetActive(goAchieve,taskBarIndex==2)
    this.SetTaskList();
end


this.SetBaseInfo=function()
    local myCount=DataHelper.GetItemCountById(cfgThemePass.Expitems);
    txtPro.text=myCount;
    local maxExp=cfgThemePass.MaxLevel*cfgThemePass.Exp;
    isMaxExp=myCount>=maxExp;
    txtMax.text="/"..maxExp
    imgSlider.fillAmount=myCount/maxExp
    SetActive(norReward.gameObject, not isChargeRecord)
    SetActive(highReward.gameObject, isChargeRecord)
end


this.SetTaskList=function()
    isTaskRewarding=false;
    local missionMap=nil;
    if taskBarIndex==1 then
        missionMap=dataPassesMissions.weekly;
    elseif taskBarIndex==2 then
        missionMap=dataPassesMissions.period
    end
    if IsNull(missionMap) then return end;
    local list={}
    for i,v in pairs(missionMap) do
        local cfgMissionItem=ConfigMgr.Config.PassesTaskMap[v.id]
        local missionItem={
            id=v.id,
            sort=cfgMissionItem.Sort,
            des=LuaMgr.GetLangText(cfgMissionItem.Namelan),
            exp=cfgMissionItem.Exp,
pro=string.format("(<color=#cf54ae>%s</color>/%s)",v.current,v.target),
            state=this.GetMissionState(v);
            rewardCallBack=this.RewardCallBack,
            jumpCallBack=this.JumpCallBack,
            item={id=cfgThemePass.Expitems,count=cfgMissionItem.Exp}
        }
        local missionData=UIListData.GetData(this.taskItemObj,"Passes_TaskItem",missionItem);
        table.insert(list,missionData);
        if missionItem.state==1 then
            isTaskRewarding=true;
        end
    end
    table.sort(list,function(a, b)
        if a.data.state==b.data.state then
            return a.data.sort<b.data.sort;
        else
            return a.data.state<b.data.state;
        end
    end)
    this.taskUIList:SetData(list);
    SetActive(btnRewardAll.gameObject,isTaskRewarding)    
end



this.GetMissionState=function(mission)
    local state=2;
    if mission.completed then
        state=3;
    elseif mission.current>=mission.target then
        state=1;
    end
    return state;
end



this.RewardCallBack=function(id)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18002"));
        return;
    end
    this.OnAskMissionReward(id,function()
        this.ParseData();
    end)
end


this.JumpCallBack=function(id)
    local cfgMissionItem=ConfigMgr.Config.PassesTaskMap[id]
    if cfgMissionItem~=nil and not IsNullOrEmpty(cfgMissionItem.PageSkip) then
        FeatureManager.GotoViewModel(cfgMissionItem.PageSkip);
    end
end




return vm({
    data = data,
    command = command,
    hook = hook
})