require("ViewModel/Simulate/Simulate_BuildingRewardItem")
require("ViewModel/Simulate/Simulate_BuildingLineItem")
require("ViewModel/Simulate/Simulate_headItem")
local this = {
    vm = nil,
    rewardItemObj=nil;
    buildingRewardUIList={};
    lineChat=nil;
    constKey="EMPLOYEESETTLEMENT";
    employeeList={},
    lineUIList={},
    lineItemObj={},
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goEmployee = uiLink:Get("goEmployee");
    ui.goMore = uiLink:Get("goMore");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.txtDay = uiLink:Get("txtDay"):GetComponent("Text");
    ui.txtCountGet = uiLink:Get("txtCountGet"):GetComponent("Text");
    ui.tranLines = uiLink:Get("tranLines"):GetComponent("RectTransform");
    ui.tranInfoList = uiLink:Get("tranInfoList"):GetComponent("RectTransform");
    ui.tranOut = uiLink:Get("tranOut"):GetComponent("RectTransform");
    ui.tranGet = uiLink:Get("tranGet"):GetComponent("RectTransform");
    ui.tranEmployee = uiLink:Get("tranEmployee"):GetComponent("RectTransform");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.rawIconGet = uiLink:Get("rawIconGet"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SimulateManageSettlementViewModel);
        LuaMgr.InvokeUIEventListeners(UIEventConst.SimulateRoomButtonState, 1);
        if this.dataPrefixSettlement.EvtId>0 then
            LuaMgr.ShowLuaPanel(UIName.SimulateManageEventViewModel);
        end
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
        this.employeeList={};
        this.InitUI(vm.behaviour)
        this.buildingRewardUIList=UIListView.New(ui.tranInfoList);
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.lineChat=vm.behaviour.transform:Find("root/Middle/Info/Chat"):GetComponent("LineChat");
        this.lineUIList=UIListView.New(ui.tranLines);
        this.lineItemObj=vm.behaviour.transform:Find("template/lineItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.buildingList={}
            for i,v in pairs(ConfigMgr.Config.SimulateArchitectMap) do
                if v.Isupgrade>0 then
                    table.insert(this.buildingList,v);
                end
            end
            this.revenueDay=ConfigMgr.Config.SimulateConstants.SimulateRevenueShow
            this.revenueMaxValue=ConfigMgr.Config.SimulateConstants.SimulateRevenueTotal
            table.sort(this.buildingList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.buildingRewardUIList:Clear();
        this.lineUIList:Clear();
        this.ClearEmployeeList();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_BuildingRewardItem")
        UIListView.ClearItem("Simulate_BuildingLineItem")
    end
}

this.ParseData=function()
    this.dataPrefixSettlement=DataMgr.Player.SimulateArchitect.PrefixSettlement;
    this.SetBuildingRewardList();
    this.SetOutInfo();
    this.SetGetInfo();
    this.SetRevenueLineChat();
    this.SetEmployee();
    if this.dataPrefixSettlement.EvtId==0 then
        SimulateRoomMgr.OnAskSettlement()
    end
end

this.SetBuildingRewardList=function()
    if IsNull(this.dataPrefixSettlement) then return end;
    this.buildingRewardUIList:Clear();
    local list={}
    for i,v in ipairs(this.buildingList) do
        local buildInfo=this.dataPrefixSettlement.Builds[v.Id];
        if buildInfo~=nil then
            local buildingItem={
                index=i,
                name=LuaMgr.GetLangText(v.NameLan),
                rewards=buildInfo.Rewards;
            }
            local buildingData=UIListData.GetData(this.rewardItemObj,"Simulate_BuildingRewardItem",buildingItem)
            table.insert(list,buildingData);
        end
    end
    this.buildingRewardUIList:SetData(list);
    if #list>4 then
        DOTWeen.To(function() return 0  end,function(value)
            ui.tranInfoList.anchoredPosition=Vector2(0,value);
        end,38,0.5);
    end
end


this.SetOutInfo=function()
    if IsNull(this.dataPrefixSettlement) or IsNull(this.dataPrefixSettlement.Cost) then return end;
    local cost=this.dataPrefixSettlement.Cost;
    local costData={}
    costData.data={
        name=LuaMgr.GetLangText("SimulateManageSettlementViewModel_0");
        rewards=cost;
    }
    if this.costRewardVM==nil then
        local obj=LuaMgr.InstantiateGO(this.rewardItemObj);
        this.costRewardVM=Simulate_BuildingRewardItem.New(ui.tranOut,obj);
    end
    this.costRewardVM:SetData(costData);
end


this.SetGetInfo=function()
    if IsNull(this.dataPrefixSettlement) then return end;
    local id=nil;
    this.getCount=0;
    for i,v in pairs(this.dataPrefixSettlement.Builds) do
        for p,m in pairs(v.Rewards) do
            id=p;
            this.getCount=this.getCount+m;
        end
    end
    if not IsNull(this.dataPrefixSettlement.Cost) then
        for i,v in pairs(this.dataPrefixSettlement.Cost) do
            this.getCount=this.getCount-v;
        end
    end
    local iconPath=ConfigHelper.GetItemHomeIconPath(id);
    ui.rawIconGet.texture=LuaMgr.GetTexture(iconPath);
    DOTWeen.To(function() return 0  end,function(value)
        if ui~=nil and ui.txtCountGet~=nil then
            ui.txtCountGet.text=string.format("%s",math.floor(value));
        end
    end,this.getCount,1);

end


this.SetRevenueLineChat=function()
    local dayNum=DataMgr.Player.SimulateArchitect.Days;
    ui.txtDay.text=dayNum;
    local historyProfitDic=DataMgr.Player.SimulateArchitect.HistoryProfit;
    local hisLen=NumTool.GetLen(historyProfitDic);
    local hisProfitList={}

    for i=dayNum-1,dayNum-hisLen,-1 do
        if historyProfitDic[tostring(i)]~=nil then
            table.insert(hisProfitList,{day=i,value=historyProfitDic[tostring(i)]})
        else
            LuaDebug.error("historyProfitDic:isError")
        end
    end
    table.sort(hisProfitList,function(a, b) return a.day<b.day end)

    table.insert(hisProfitList,{day=dayNum,value=this.getCount,isCur=true})

    local moreLen=#hisProfitList-this.revenueDay;
    if moreLen>0 then
        for i=1,moreLen,1 do
            table.remove(hisProfitList,1)
        end
    end

    local lessLen=this.revenueDay-#hisProfitList;
    if lessLen>0 then
        for i=1,lessLen,1 do
            table.insert(hisProfitList,{day=dayNum+i,value=0})
        end
    end



    local revenueList={};
    for i,v in ipairs(hisProfitList) do
        local valueF=v.value/this.revenueMaxValue;
        if valueF>1 then
            valueF=1
        end
        valueF=valueF<0 and 0 or valueF;
        table.insert(revenueList,valueF);
    end
    this.lineChat:SetPoints(revenueList);
    this.SetLineUIList(hisProfitList)
    
end

this.SetLineUIList=function(hisProfitList)
    this.lineUIList:Clear();
    local list={}
    for i,v in ipairs(hisProfitList) do
        local valueF=v.value/this.revenueMaxValue;
        if valueF>1 then
            valueF=1
        end
        local lineItem={
            index=i,
            value=valueF<0 and 0 or valueF;
            num=v.day,
            isFirst=i==1,
            isEnd=i==this.revenueDay,
            isCur=v.isCur,
        }
        local lineData=UIListData.GetData(this.lineItemObj,"Simulate_BuildingLineItem",lineItem);
        table.insert(list,lineData);
    end
    this.lineUIList:SetData(list);
end

this.SetEmployee=function()
    local cfgRecruitMap=ConfigMgr.Config.SimulateRecruitMap;
    local newUnlockList={}
    for i,v in pairs(cfgRecruitMap) do
        if v.Type>0 and  SimulateRoomMgr.CheckEmployeeIsUnlock(v) and SimulateRoomMgr.CheckEmployeeIsNew(v.Id,this.constKey) then
            local character=ConfigMgr.Config.characterTable[v.Id]
            if character~=nil  and DataMgr.Player.SimulateArchitect.Employees[v.Id]==nil then
                local employee={
                    characterId=i,
                    name=LuaMgr.GetLangText(character.namelan);
                    rare=character.rare;
                    job=character.job,
                }
                table.insert(newUnlockList,employee)
            end
        end
    end
    SetActive(ui.goEmployee,#newUnlockList>0);
    if #newUnlockList==0 then return end;
    SetActive(ui.goMore,#newUnlockList>3);
    for i,v in ipairs(newUnlockList) do

        if i<=3 then  
            local employeeVM=nil;
            if this.employeeList[i]==nil then
                this.employeeList[i]=Simulate_headItem.New(ui.tranEmployee,0.72);
            end
            employeeVM=this.employeeList[i];
            SetActive(employeeVM.gameObject,true);
            employeeVM:SetData(v);
            SimulateRoomMgr.UpdateEmployeeNew(v.characterId,this.constKey);
        end
    end
end

this.ClearEmployeeList=function()
    for i,v in ipairs(this.employeeList) do
        SetActive(v.gameObject,false);
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})