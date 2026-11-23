require("ViewModel/Simulate/Simulate_BuildingItem")
require("ViewModel/Simulate/Simulate_ManageHeadItem")
local this = {
    vm = nil,
    buildUIList={};
    buildItemObj=nil;
    employeeUIList={};
    employeeItemObj=nil;
};
local colorRed=UnityEngine.Color(185/255,76/255,51/255,1)
local colorGreen=UnityEngine.Color(204/255,224/255,140/255,1)

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranBuildingContent = uiLink:Get("tranBuildingContent"):GetComponent("RectTransform");
    ui.tranStar = uiLink:Get("tranStar"):GetComponent("RectTransform");
    ui.tranEmployee = uiLink:Get("tranEmployee"):GetComponent("RectTransform");
    ui.txtFansValue = uiLink:Get("txtFansValue"):GetComponent("Text");
    ui.txtBuildingLevel = uiLink:Get("txtBuildingLevel"):GetComponent("Text");
    ui.txtTotalTans = uiLink:Get("txtTotalTans"):GetComponent("Text");
    ui.txtManageCount = uiLink:Get("txtManageCount"):GetComponent("Text");
    ui.btnUpLevel = uiLink:Get("btnUpLevel"):GetComponent("Button");
    ui.btnEmployee = uiLink:Get("btnEmployee"):GetComponent("Button");
    ui.btnBusiness = uiLink:Get("btnBusiness"):GetComponent("Button");
    ui.sliderTourists = uiLink:Get("sliderTourists"):GetComponent("Slider");
    ui.sliderSatisfies = uiLink:Get("sliderSatisfies"):GetComponent("Slider");
    ui.sliderVisits = uiLink:Get("sliderVisits"):GetComponent("Slider");
    ui.imgTouristsFillColor = uiLink:Get("imgTouristsFillColor"):GetComponent("Image");
    ui.imgSatisfiesFillColor = uiLink:Get("imgSatisfiesFillColor"):GetComponent("Image");
    ui.imgVisitsFillColor = uiLink:Get("imgVisitsFillColor"):GetComponent("Image");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnUpLevel",function()
        local buildId=this.buildingList[this.buildingIndex].Id;
        LuaMgr.ShowLuaPanel(UIName.SimulateBuildingUpLevelViewModel,buildId)
    end)
    uiLink:AddClickEvent("btnBusiness",function()
        if SimulateRoomMgr.GetManageDailyCount()>=ConfigMgr.Config.SimulateConstants.SimulateDailyOperateLimit then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateManageViewModel_0"))
            return;
        end
        if not this.CheckManage() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateManageViewModel_1"))
            return;
        end
        SimulateRoomMgr.OnAskStart(function()
            SimulateRoomMgr.isHideInfo=true;
            LuaMgr.Back();
            LuaMgr.ShowLuaPanel(UIName.SimulateManageInfoViewModel);
        end)
    end)
    uiLink:AddClickEvent("btnEmployee",function()
        local buildId=this.buildingList[this.buildingIndex].Id;
        LuaMgr.ShowLuaPanel(UIName.SimulateEmployeesViewModel,buildId)
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
        this.buildUIList=UIListView.New(ui.tranBuildingContent)
        this.buildItemObj= vm.behaviour.transform:Find("template/buildItem").gameObject;
        this.employeeUIList=UIListView.New(ui.tranEmployee);
        this.employeeItemObj= vm.behaviour.transform:Find("template/headItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.buildingList={}
            for i,v in pairs(ConfigMgr.Config.SimulateArchitectMap) do
                if v.Isupgrade>0 then
                    table.insert(this.buildingList,v);
                end
            end
            table.sort(this.buildingList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
            this.buildingIndex=1;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.buildUIList:Clear();
        this.employeeUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_BuildingItem")
        UIListView.ClearItem("Simulate_ManageHeadItem")
    end
}

this.ParseData=function()
    this.dataSimulateArchitect=DataMgr.Player.SimulateArchitect;
    this.SetBuildingList();
end


this.SetBuildingList=function()
    this.buildUIList:Clear();
    local list={}
    for i,v in ipairs(this.buildingList) do
        local buildingItem={
            id=v.Id,
            index=i,
            name=LuaMgr.GetLangText(v.NameLan),
            lockInfo="",
            isUnLock=SimulateRoomMgr.CheckBuildingIsUnLock(v.Id),
            callBack=this.BuildingCallBack,
            isCur=this.buildingIndex==i,
            starIndex=SimulateRoomMgr.GetBuildingStarIndex(v.Id);
        }
        if not buildingItem.isUnLock then
            buildingItem.lockInfo=this.GetLockInfo(v.Id);
        end
        local buildingData=UIListData.GetData(this.buildItemObj,"Simulate_BuildingItem",buildingItem)
        table.insert(list,buildingData);
    end
    this.buildUIList:SetData(list);
    this.SetBuildInfos(this.buildingIndex);
end


this.GetLockInfo=function(buildId)
    local cfgBuild=ConfigMgr.Config.SimulateArchitectMap[buildId]
    if cfgBuild==nil or cfgBuild.Type==0 then return "" end;
    if cfgBuild.Type==1 then

        local delayDay=tonumber(cfgBuild.Unlock);
        local startTime=SimulateRoomMgr.GetXCHDActiveStartTime()+delayDay*3600*24;
        local time=startTime-LuaMgr.Timestamp();
        time=time<0 and 0 or time;
        local day,hour,min=GetTimeDHM(time);
        if IsNullOrEmpty(day) then
            return string.format(LuaMgr.GetLangText("SimulateManageViewModel_2"),hour,min);
        else
            return string.format(LuaMgr.GetLangText("SimulateManageViewModel_3"),day,hour);
        end
    elseif cfgBuild.Type==2 then

        local level=cfgBuild.Unlock;
        if ConfigMgr.Config.SimulateDegreeMap[level]~=nil then
            local nameLan=ConfigMgr.Config.SimulateDegreeMap[level].NameLan
            return string.format(LuaMgr.GetLangText("SimulateManageViewModel_4"),LuaMgr.GetLangText(nameLan));
        end
        return "";
    end
end


this.BuildingCallBack=function(index)
    if this.buildingIndex==index then
        return;
    end
    this.buildingIndex=index;
    for i,v in ipairs(this.buildUIList.itemList) do
        v:SetSelect(i==index);
    end
    this.SetBuildInfos(index);
end

this.SetBuildInfos=function(index)
    local buildId=this.buildingList[index].Id;
    this.buildData=this.dataSimulateArchitect.SimulateBuilds[buildId];
    if this.buildData==nil then
        LuaDebug.error("buildData is Error: Id"..buildId);
        return 
    end
    ui.txtBuildingLevel.text=string.format("%s/%s",this.buildData.Level+1,SimulateRoomMgr.GetBuildingMaxLevel(buildId));
    ui.txtFansValue.text=this.buildData.StageValue;
    local touristsPro=this.buildData.TouristsValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,2,this.buildData.Level);
    local satisfiesPro=this.buildData.SatisfiesValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,3,this.buildData.Level);
    local visitsPro=this.buildData.VisitsValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,4,this.buildData.Level);
    ui.sliderTourists.value=touristsPro
    ui.sliderSatisfies.value=satisfiesPro
    ui.sliderVisits.value=visitsPro
    
    ui.imgTouristsFillColor.color=touristsPro<0.4 and colorRed or colorGreen;
    ui.imgSatisfiesFillColor.color=satisfiesPro<0.4 and colorRed or colorGreen;
    ui.imgVisitsFillColor.color=visitsPro<0.4 and colorRed or colorGreen;
    
    local starIndex=1;
    if touristsPro>=0.99 then
        starIndex=starIndex+1;
    end
    if satisfiesPro>=0.99 then
        starIndex=starIndex+1;
    end
    if visitsPro>=0.99 then
        starIndex=starIndex+1;
    end
    for i=1,ui.tranStar.childCount,1 do
        SetActive(ui.tranStar:GetChild(i-1).gameObject,i<=starIndex);
    end
    ui.txtTotalTans.text=SimulateRoomMgr.GetAllBuildingFans();
    ui.txtManageCount.text=string.format(LuaMgr.GetLangText("SimulateManageViewModel_5"),
            ConfigMgr.Config.SimulateConstants.SimulateDailyOperateLimit-SimulateRoomMgr.GetManageDailyCount());
    this.SetEmployees(this.buildData)
end

this.SetEmployees=function(buildData)
    this.employeesCount=0;
    local buildEmployees={}
    if not IsNull(buildData.Employees) then
        for i,v in pairs(buildData.Employees) do
            local cfgCharacter=ConfigMgr.Config.SimulateRecruitMap[i]
            table.insert(buildEmployees,{characterId=i,rare=cfgCharacter.Rare,job=cfgCharacter.Job,empTime=v});
        end
        table.sort(buildEmployees,function(a, b) return a.empTime>b.empTime end)
    end
    this.employeesCount=#buildEmployees;
    local max=SimulateRoomMgr.GetEmployeesMaxCount();
    if this.employeesCount<max then

        for i=this.employeesCount+1,max,1 do
            table.insert(buildEmployees,{characterId=""})
        end
    end
    this.employeeUIList:Clear();
    local list={}
    for i,v in ipairs(buildEmployees) do
        local employeeData=UIListData.GetData(this.employeeItemObj,"Simulate_ManageHeadItem",v);
        table.insert(list,employeeData);
    end
    this.employeeUIList:SetData(list);
  
end

this.CheckManage=function()
    for i,v in ipairs(this.buildingList) do
        local buildData_v=this.dataSimulateArchitect.SimulateBuilds[v.Id]
        if IsNull(buildData_v.Employees) or NumTool.GetLen(buildData_v.Employees)==0 then
            return false;
        end
    end
    return true;
end

return vm({
    data = data,
    command = command,
    hook = hook
})