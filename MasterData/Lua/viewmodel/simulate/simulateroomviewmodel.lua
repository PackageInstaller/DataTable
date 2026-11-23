require("ViewModel/Simulate/Simulate_BuildBufferItem")
local this = {
    vm = nil,
    buildBufferUIList={};
    buildBufferItemObj=nil;
};

local buildNamePos={}
buildNamePos["1001"]=Vector2(-241,193);
buildNamePos["1002"]=Vector2(427,239);
buildNamePos["1003"]=Vector2(37,333);
buildNamePos["1004"]=Vector2(114.8,26);
buildNamePos["1005"]=Vector2(-288,-41);




local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goFixPool = uiLink:Get("goFixPool");
    ui.goOrder = uiLink:Get("goOrder");
    ui.goSellOut = uiLink:Get("goSellOut");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.tranbuildPool = uiLink:Get("tranbuildPool"):GetComponent("RectTransform");
    ui.tranOtherPool = uiLink:Get("tranOtherPool"):GetComponent("RectTransform");
    ui.btnMaterial = uiLink:Get("btnMaterial"):GetComponent("Button");
    ui.btnEmloyees = uiLink:Get("btnEmloyees"):GetComponent("Button");
    ui.btnOrder = uiLink:Get("btnOrder"):GetComponent("Button");
    ui.btnSellOut = uiLink:Get("btnSellOut"):GetComponent("Button");
    ui.btnPoker = uiLink:Get("btnPoker"):GetComponent("Button");
    ui.btnWrite = uiLink:Get("btnWrite"):GetComponent("Button");
    ui.btnTask = uiLink:Get("btnTask"):GetComponent("Button");
    ui.btnManage = uiLink:Get("btnManage"):GetComponent("Button");
    ui.txtDay = uiLink:Get("txtDay"):GetComponent("Text");
    ui.txtSlider = uiLink:Get("txtSlider"):GetComponent("Text");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.imgSlider = uiLink:Get("imgSlider"):GetComponent("Image");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnManage",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateManageBreviaryViewModel)
    end)
    uiLink:AddClickEvent("btnWrite",function()
        if (SimulateRoomMgr.IsEventUnlock(2)) then

            LuaMgr.ShowLuaPanel(UIName.SimulateNewYearViewModel);
        end

    end)
    uiLink:AddClickEvent("btnTask",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateManageTaskViewModel)


    end)
    uiLink:AddClickEvent("btnPoker",function()
        if (SimulateRoomMgr.IsEventUnlock(3)) then

            LuaMgr.ShowLuaPanel(UIName.SimulateSupperzzleViewModel);
        end




    end)
    uiLink:AddClickEvent("btnMaterial",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateLanternMainViewModel)
    end)
    uiLink:AddClickEvent("btnEmloyees",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateEmployeesBagViewModel)
    end)
    uiLink:AddClickEvent("btnOrder",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateOrderNormalViewModel)
    end)
    uiLink:AddClickEvent("btnSellOut",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateOrderSellOutViewModel)
    end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.buildBufferUIList=UIListView.New(ui.tranbuildPool);
        this.buildBufferItemObj=vm.behaviour.transform:Find("template/buildBuffItem").gameObject;
        this.dailyNPC=nil;
        this.specialNPCList={};
        RedMgr.Singleton:RegisterViewModel(UIName.SimulateRoomViewModel)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("",this.Back)
            this.simulateConstants=ConfigMgr.Config.SimulateConstants;
            SetActive(ui.btnWrite.gameObject,SimulateRoomMgr.GetEventUnlockTime(2)<=0)
            SetActive(ui.btnPoker.gameObject,SimulateRoomMgr.GetEventUnlockTime(2)<=0)
            LuaMgr.RemoveUIEventListener(UIEventConst.SimulateRoomButtonState,this.SetActiveInfo);
            LuaMgr.AddUIEventListener(UIEventConst.SimulateRoomButtonState,this.SetActiveInfo)
            XCHDMgr.CheckSimulateRedDot();
            this.buildList={}
            for i,v in pairs(ConfigMgr.Config.SimulateArchitectMap) do
                if v.Id~="1006" then
                    table.insert(this.buildList,v);
                end
            end
            table.sort(this.buildList,function(a, b) return tonumber(a.Id)< tonumber(b.Id) end)
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        LuaMgr.RemoveUIEventListener(UIEventConst.SimulateRoomButtonState,this.SetActiveInfo);
        this.buildBufferUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        SimulateSceneMgr.ClearNPC();
        UIListView.ClearItem("Simulate_BuildBufferItem")
    end
}

this.Back=function()
    SimulateSceneMgr.Clear();
    LuaMgr.Back();
end

this.SetActiveInfo=function(params)
    local state=tonumber(params[0]);
    SetActive(ui.Left,state==1)
    SetActive(ui.Right,state==1)
    this.dataSIMArchitect=DataMgr.Player.SimulateArchitect;
    this.dataSimulateOrders=DataMgr.Player.SimulateOrders;
    this.SetBaseInfo();
end

this.ParseData=function()
    SetActive(ui.Left,not SimulateRoomMgr.isHideInfo)
    SetActive(ui.Right,not SimulateRoomMgr.isHideInfo)
    SimulateRoomMgr.isHideInfo=false;
    this.dataSIMArchitect=DataMgr.Player.SimulateArchitect;
    this.dataSimulateOrders=DataMgr.Player.SimulateOrders;
    SimulateSceneMgr.UpdateCheckBuildingUpLevel();
    this.SetBaseInfo();
    this.SetBuildBufferUIList();
    this.SetDailyRandomInfos();
    this.CheckSpecialOrder();
    SimulateSceneMgr.SetWalkNPC(ui.tranOtherPool);
    this.CheckBufferTips();
end

this.SetBaseInfo=function()
    ui.txtDay.text=this.dataSIMArchitect.Days
    local curSIMDegree=ConfigMgr.Config.SimulateDegreeMap[tostring(this.dataSIMArchitect.StageLevel)]
    local nextSIMDegree=ConfigMgr.Config.SimulateDegreeMap[tostring(this.dataSIMArchitect.StageLevel+1)];
    if nextSIMDegree==nil then
        nextSIMDegree=curSIMDegree;

        ui.txtSlider.text=LuaMgr.GetLangText(curSIMDegree.NameLan);
        ui.imgSlider.fillAmount=1.0
    else

        local curFansCount=this.dataSIMArchitect.StageValue;
        local maxFansCount=nextSIMDegree.Para;
        ui.txtSlider.text=string.format("%s/%s",curFansCount,maxFansCount);
        ui.imgSlider.fillAmount=curFansCount/maxFansCount;
    end
end

this.SetBuildBufferUIList=function()
    this.buildBufferUIList:Clear();
    local list={}
    for i,v in ipairs(this.buildList) do
        local curLevel=this.dataSIMArchitect.SimulateBuilds[v.Id].Level+1;

        local buildItem={
            index=i,
            id=v.Id,
            pos=buildNamePos[v.Id],
            name=LuaMgr.GetLangText(v.NameLan);
            levelInfo=string.format("LV.%s",curLevel),
            starIndex=SimulateRoomMgr.GetBuildingStarIndex(v.Id),
            callBack=this.BuildCallBack,
            isRed=this.CheckBuildRed(v.Id)>0,
        }
        local buildData=UIListData.GetData(this.buildBufferItemObj,"Simulate_BuildBufferItem",buildItem);
        table.insert(list,buildData);
    end
    this.buildBufferUIList:SetData(list);
end


this.BuildCallBack=function(id)
    if id=="1001" then
        LuaMgr.ShowLuaPanel(UIName.SimulateDropLevelViewModel);
    elseif id=="1002" then
        LuaMgr.ShowLuaPanel(UIName.SimulateLanternMakeViewModel)
    elseif id=="1003" then
        LuaMgr.ShowLuaPanel(UIName.SimulateRiddlesQuestionViewModel)
    elseif id=="1004" then
        SimulateRoomMgr.OpenBlessingPanel();
    elseif id=="1005" then
        LuaMgr.ShowLuaPanel(UIName.SimulateTeachTreeViewModel)
    end
end


this.SetDailyRandomInfos=function()
    this.SetDailyTipText();
    if this.dataSIMArchitect.DailyRandomCount>= this.simulateConstants.SimulateDailyRandomLimit+SimulateRoomMgr.CheckTriggerAddDailyRewardCount() then
        return;
    end

    local randomRewardTimeUnixList=this.GetRandomRewardTimeUnix();
    local curTimestamp=LuaMgr.Timestamp();
    if curTimestamp<randomRewardTimeUnixList[1] or curTimestamp>randomRewardTimeUnixList[5] then

        return 
    end
    local lastDailyRandomTime=this.dataSIMArchitect.LastDailyRandomTime;
    local isTrigger=false;
    if curTimestamp>randomRewardTimeUnixList[4] and lastDailyRandomTime<randomRewardTimeUnixList[4] then
        isTrigger=true;
    elseif curTimestamp>randomRewardTimeUnixList[3] and lastDailyRandomTime<randomRewardTimeUnixList[3] then

        isTrigger=true;
    elseif curTimestamp>randomRewardTimeUnixList[2] and lastDailyRandomTime<randomRewardTimeUnixList[2] then
        isTrigger=true;
    elseif curTimestamp>randomRewardTimeUnixList[1] and lastDailyRandomTime<randomRewardTimeUnixList[1] then
        isTrigger=true;
    else
        isTrigger=false;
    end
    if isTrigger then
        this.dailyNPC=SimulateSceneMgr.DailyRewardQSpine(ui.tranOtherPool,function()
            this.dataSIMArchitect=DataMgr.Player.SimulateArchitect;
            this.SetDailyTipText();
        end);
    end
     
end

this.SetDailyTipText=function()
    ui.txtCount.text=string.format(LuaMgr.GetLangText("SimulateRoomViewModel_0"),
            this.simulateConstants.SimulateDailyRandomLimit+SimulateRoomMgr.CheckTriggerAddDailyRewardCount()-this.dataSIMArchitect.DailyRandomCount);
end

this.GetRandomRewardTimeUnix=function()
    local list={}
    local dailyRandomRewardTimeList=this.simulateConstants.SimulateDailyRandomRewardTime;
    local date=os.date("*t",LuaMgr.Timestamp());
    for i,v in ipairs(dailyRandomRewardTimeList) do
        local unix=os.time({year=date.year,month=date.month,day=date.day,hour=tonumber(v),min=0,sec=0});
        table.insert(list,unix);
    end
    return list;
end

this.CheckSpecialOrder=function()
    local orderList={}
    for i,v in pairs(ConfigMgr.Config.SimulateExchangeMap) do

        if v.PoolID=="100" then
            table.insert(orderList,v);
        end
    end
    local specialList={}
    for i,v in ipairs(orderList) do
        local dataOrder=this.dataSimulateOrders.Orders[v.Id];
        if dataOrder~=nil then
            table.insert(specialList,v.Id);
        end
    end
    local curCount=DataMgr.Player.dailyCount["sltspRefreshOrder"]==nil and 0 or DataMgr.Player.dailyCount["sltspRefreshOrder"] ;
    if curCount>=ConfigMgr.Config.SimulateConstants.SimulateSpecialOrderDailyLimit then
        specialList={};
    end
    SimulateSceneMgr.SpecialOrderQSpine(ui.tranOtherPool,specialList);
end


this.CheckBufferTips=function()
    this.dataLightBlocks=DataMgr.Player.SimulateFlowerLight.LightBlocks;
    local isNewSellOut=false;
    if not IsNull(this.dataLightBlocks) then
        for i,v in pairs(this.dataLightBlocks) do
            if v.HarvestTime>0 and LuaMgr.Timestamp()>v.HarvestTime then
                isNewSellOut=true;
            end
        end
    end
    SetActive(ui.goSellOut,isNewSellOut);
    
    local isNorOrder=false;
    if RedMgr.Singleton:CheckRedCondition("17311") then
        local orderNorList={}
        for i,v in pairs(ConfigMgr.Config.SimulateExchangeMap) do

            if v.PoolID~="100" then
                table.insert(orderNorList,v);
            end
        end
        for i,v in ipairs(orderNorList) do
            local dataOrder=this.dataSimulateOrders.Orders[v.Id];
            if dataOrder~=nil and dataOrder.EffectTime-LuaMgr.Timestamp()<0 then
                isNorOrder=true;
            end
        end
    end
    SetActive(ui.goOrder,isNorOrder);
end

this.CheckBuildRed=function(buildId)
    if buildId=="1001" then
        return SimulateRoomMgr.CheckDropGameRed()
    elseif buildId=="1002" then

        return SimulateRoomMgr.LightCollectRewardsRed();
    elseif buildId=="1003" then
        return SimulateRoomMgr.CheckRiddlesRed();
    elseif buildId=="1004" then

        return 0;
    elseif buildId=="1005" then
        return SimulateRoomMgr.CheckTechTreeRed();
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})