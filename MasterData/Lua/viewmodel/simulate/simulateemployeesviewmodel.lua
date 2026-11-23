require("ViewModel/Simulate/Simulate_EmployeeGroup")
require("ViewModel/Simulate/Simulate_EmployeeItem")
require("ViewModel/Simulate/Simulate_headItem")

local this = {
    vm = nil,
    employeeList={};
    employeeViewData={};
    employeeViewList={};
    employeeGroupItemObj=nil;
    employeeItemObj=nil;
groupCount=2;
    usedDic={};
    members={};
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
    ui.goEmployeeView = uiLink:Get("goEmployeeView");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.txtBuildingName = uiLink:Get("txtBuildingName"):GetComponent("Text");
    ui.txtFansValue = uiLink:Get("txtFansValue"):GetComponent("Text");
    ui.txtBuildingLevel = uiLink:Get("txtBuildingLevel"):GetComponent("Text");
    ui.txtTouristsPro = uiLink:Get("txtTouristsPro"):GetComponent("Text");
    ui.txtSatisfiesPro = uiLink:Get("txtSatisfiesPro"):GetComponent("Text");
    ui.txtVisitsPro = uiLink:Get("txtVisitsPro"):GetComponent("Text");
    ui.imgBuildingTag = uiLink:Get("imgBuildingTag"):GetComponent("Image");
    ui.imgTouristsFillColor = uiLink:Get("imgTouristsFillColor"):GetComponent("Image");
    ui.imgSatisfiesFillColor = uiLink:Get("imgSatisfiesFillColor"):GetComponent("Image");
    ui.imgVisitsFillColor = uiLink:Get("imgVisitsFillColor"):GetComponent("Image");
    ui.tranStar = uiLink:Get("tranStar"):GetComponent("RectTransform");
    ui.tranEmployee = uiLink:Get("tranEmployee"):GetComponent("RectTransform");
    ui.sliderTourists = uiLink:Get("sliderTourists"):GetComponent("Slider");
    ui.sliderSatisfies = uiLink:Get("sliderSatisfies"):GetComponent("Slider");
    ui.sliderVisits = uiLink:Get("sliderVisits"):GetComponent("Slider");
    ui.btnEmployee = uiLink:Get("btnEmployee"):GetComponent("Button");
    ui.btnEmployeeBag = uiLink:Get("btnEmployeeBag"):GetComponent("Button");
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnComfrim",function()
        this.EmployeesComfrimExecute();
    end)
    uiLink:AddClickEvent("btnEmployeeBag",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateEmployeesBagViewModel)
    end)
end


this.EmployeesComfrimExecute=function()
    if #this.members==0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateEmployeesViewModel_0"))
        return
    end
    local employee={}
    for i,v in ipairs(this.members) do
        employee[v.id]=this.buildId;
    end
    SimulateRoomMgr.OnAskEmployees(employee,function()
        for i,v in ipairs(this.members) do
            SimulateRoomMgr.UpdateEmployeeNew(v.id,"EMPLOYEES")
        end
        this.members={};

        LuaMgr.Back();
    end)
end

this.EmployeesCancelExecute=function(characterId)
    if not IsNullOrEmpty(characterId) then
        local employee={};
        employee[characterId]="";
        SimulateRoomMgr.OnAskEmployees(employee,function()
            this.ParseData();
        end)
    end
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.employeeList={}
        this.InitUI(vm.behaviour)
        this.employeeViewList=UIScrollView.New(ui.goEmployeeView);
        this.employeeGroupItemObj=vm.behaviour.transform:Find("template/employeeGroup").gameObject;
        this.employeeItemObj=vm.behaviour.transform:Find("template/employeeItem").gameObject;

    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                this.buildId=vm.behaviour.Params[0];
                this.buildInfo=ConfigMgr.Config.SimulateArchitectMap[this.buildId];
                this.cfgRecruitMap=ConfigMgr.Config.SimulateRecruitMap;
                this.simulateConstants=ConfigMgr.Config.SimulateConstants
                if this.buildInfo==nil then return end;
                this.isRefrush=true;
                this.members={};
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.employeeViewList:Clear();
        for i,v in ipairs(this.employeeViewData) do
            SimulateRoomMgr.UpdateEmployeeNew(v.characterId,"EMPLOYEES")
        end
    end,
    before_destroy = function()
        this.ClearUI()
        UIScrollView.ClearItem("Simulate_EmployeeGroup")
        UIListView.ClearItem("Simulate_EmployeeItem")
        if this.employeeList~=nil and #this.employeeList>0 then
            for i,v in ipairs(this.employeeList) do
                v:Destroy();
            end
        end
    end
}

this.ParseData=function()
    this.dataSimulateArchitect=DataMgr.Player.SimulateArchitect;
    if not IsNull(DataMgr.Player.SimulateArchitect) and not IsNull(DataMgr.Player.SimulateArchitect.SimulateBuilds) then
        this.dataBuilding=DataMgr.Player.SimulateArchitect.SimulateBuilds[this.buildId];
        if this.dataBuilding==nil then
            return
        end;
    end
    this.curBuildingLevel=this.dataBuilding.Level;
    this.SetBuildingEmployees();
    this.UpdateInfo();
    this.SetEmployeeData();
    
end


this.CheckIsInMember=function(characterId)
    for i,v in ipairs(this.members) do
        if v.id==characterId then
            return i;
        end
    end
    return 0;
end

this.SetEmployeeData=function()
    this.employeeViewData={};
    this.usedDic={};
    if not IsNull(this.dataSimulateArchitect.Employees) then
        for i,v in pairs(this.dataSimulateArchitect.Employees) do
            local character=ConfigMgr.Config.characterTable[i]
            local recCharacter=this.cfgRecruitMap[i];
            if character~=nil and recCharacter ~=nil then
                local employee={
                    characterId=i,
                    name=LuaMgr.GetLangText(character.namelan);
                    rare=character.rare;
                    job=character.job,
                    tourist=recCharacter.Customer,
                    satisfie=recCharacter.Satisfy,
                    visit=recCharacter.TravelTime,
                    touristPro=recCharacter.Customer/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[1]),
                    satisfiePro=recCharacter.Satisfy/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[2]),
                    visitPro=recCharacter.TravelTime/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[3]),
                    orderTime=this.dataSimulateArchitect.EmployeesTime[i]~=nil and this.dataSimulateArchitect.EmployeesTime[i] or 0;
                    isNew=SimulateRoomMgr.CheckEmployeeIsNew(i,"EMPLOYEES"),
                    bindId=v,
                    isSelect=this.CheckIsInMember(i)>0;
                    isUsedBuildId=this.dataSimulateArchitect.Employees[i];
                    callBack=this.EmployeeCallBack,
                }



                table.insert(this.employeeViewData,employee)
            end
        end
    end
    if #this.employeeViewData==0 then
        return;
    end
    table.sort(this.employeeViewData,function(a, b)
        if not a.isSelect and not b.isSelect then
            return a.orderTime>b.orderTime
        else
            return a.isSelect and not b.isSelect
        end
    end)
    this.SetEmployeeView();
end

this.SetEmployeeView=function()
    this.employeeViewList:Clear();
    local groupList={}
local maxLen=math.ceil(#this.employeeViewData/this.groupCount);
    for i=1,maxLen,1 do
        local group={}
        for sIndex=1+(i-1)*this.groupCount,this.groupCount*i,1 do
            if sIndex<=#this.employeeViewData then

                this.employeeViewData[sIndex].index=sIndex;
                table.insert(group,this.employeeViewData[sIndex])
            end
        end
        table.insert(groupList,group);
    end
    local list={}
    for i,v in ipairs(groupList) do
        local groupItem={
            list=v,
            ItemObj=this.employeeItemObj;
        }
        local groupData=UIScrollData.GetData(this.employeeGroupItemObj,"Simulate_EmployeeGroup",834,160,groupItem);
        table.insert(list,groupData);
    end
    this.employeeViewList:SetParams(834, 555)

    this.employeeViewList:SetData(list, this.isRefrush)
end

this.EmployeeCallBack=function(characterId,index)
    local findIndex=this.CheckIsInMember(characterId);
    if findIndex>0 then

        if not IsNullOrEmpty(characterId) and this.dataBuilding.Employees[characterId]~=nil then

            this.HeadCallBack(characterId)
            return;
        end
        table.remove(this.members,findIndex);
        this.EmployeeViewListRefresh();
    else
        if this.usedDic[characterId]~=nil then

            this.EmployeesCancelExecute(characterId);
            return;
        end

        local max=SimulateRoomMgr.GetEmployeesMaxCount()
        if #this.members+NumTool.GetLen(this.usedDic)>=max then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("SimulateEmployeesViewModel_1"),max));
        else
            local empBuildingID=this.dataSimulateArchitect.Employees[characterId];
            if not IsNullOrEmpty(empBuildingID) then
                local empBuildingName=SimulateRoomMgr.GetBuildingNameByBuildName(empBuildingID)
                local newBuildingName=LuaMgr.GetLangText(this.buildInfo.NameLan)
                local tips=string.format(LuaMgr.GetLangText("SimulateEmployeesViewModel_2"),empBuildingName,newBuildingName);
                LuaMgr.ShowLuaPanel(UIName.SimulateConfirmTipViewModel,tips,function()
                    table.insert(this.members,{id=characterId,time=0});
                    this.EmployeeViewListRefresh();
                end,nil);
            else
                table.insert(this.members,{id=characterId,time=0});
                this.EmployeeViewListRefresh();
            end
        end
    end
end

this.EmployeeViewListRefresh=function()
    for i,v in ipairs(this.employeeViewList.dataList) do
        for j,p in ipairs(v.data.list) do
            p.isSelect=this.CheckIsInMember(p.characterId)>0;
        end
    end
    this.employeeViewList:Refresh();
end



this.UpdateInfo=function()
    this.starIndex=1;
    this.SetTouristsInfo()
    this.SetSatisfiesInfo()
    this.SetVisitsInfo();
    this.SetBaseInfo();
end


this.SetBaseInfo=function()
    local maxBuildLevel=SimulateRoomMgr.GetBuildingMaxLevel(this.buildId,1)
    ui.txtBuildingName.text=LuaMgr.GetLangText(this.buildInfo.NameLan);
    ui.txtBuildingLevel.text=string.format("%s/%s",this.dataBuilding.Level+1,maxBuildLevel)
    ui.imgBuildingTag.sprite=LuaMgr.GetSprite("Simulate","ui_hd_rsrh_jy_icon_"..this.buildInfo.Id);
    ui.txtFansValue.text=this.dataBuilding.StageValue;
    for i=1,ui.tranStar.childCount,1 do
        SetActive(ui.tranStar:GetChild(i-1).gameObject,i<= this.starIndex);
    end
end


this.SetTouristsInfo=function()
    local curTourists= this.dataBuilding.TouristsValue;
    local maxTourists=SimulateRoomMgr.GetBuildingMaxFansByLevel(this.buildId,2,this.curBuildingLevel)
    local curValue=curTourists/maxTourists;;

    ui.sliderTourists.value=curValue
    ui.imgTouristsFillColor.color=curValue<0.4 and colorRed or colorGreen
    ui.txtTouristsPro.text=string.format("%s/%s",curTourists,maxTourists)
    if curValue>0.99 then
       this.starIndex=this.starIndex+1;
    end
end


this.SetSatisfiesInfo=function()
    local curSatisfies= this.dataBuilding.SatisfiesValue;
    local maxSatisfies=SimulateRoomMgr.GetBuildingMaxFansByLevel(this.buildId,3,this.curBuildingLevel)
    local curValue=curSatisfies/maxSatisfies;

    ui.sliderSatisfies.value=curValue;
    ui.imgSatisfiesFillColor.color=curValue<0.4 and colorRed or colorGreen
    ui.txtSatisfiesPro.text=string.format("%s/%s",curSatisfies,maxSatisfies)
    if curValue>0.99 then
        this.starIndex=this.starIndex+1;
    end
end



this.SetVisitsInfo=function()
    local curVisits= this.dataBuilding.VisitsValue;
    local maxVisits=SimulateRoomMgr.GetBuildingMaxFansByLevel(this.buildId,4,this.curBuildingLevel)
    local curValue=curVisits/maxVisits;

    ui.sliderVisits.value=curValue;
    ui.imgVisitsFillColor.color=curValue<0.4 and colorRed or colorGreen
    ui.txtVisitsPro.text=string.format("%s/%s",curVisits,maxVisits)
    if curValue>0.99 then
        this.starIndex=this.starIndex+1;
    end
end

this.SetBuildingEmployees=function()
    this.members={};
    local buildEmployees={}
    if not IsNull(this.dataBuilding.Employees) then
        for i,v in pairs(this.dataBuilding.Employees) do
            local cfgCharacter=ConfigMgr.Config.SimulateRecruitMap[i]
            table.insert(buildEmployees,{characterId=i,rare=cfgCharacter.Rare,job=cfgCharacter.Job,empTime=v});
            table.insert(this.members,{id=i,time=v})
        end
        table.sort(buildEmployees,function(a, b) return a.empTime>b.empTime end)
    end
    local max=SimulateRoomMgr.GetEmployeesMaxCount();
    if #buildEmployees<max then

        for i=#buildEmployees+1,max,1 do
            table.insert(buildEmployees,{characterId=""})
        end
    end
    for i,v in ipairs(buildEmployees) do
        if this.employeeList[i]==nil then
            this.employeeList[i]=Simulate_headItem.New(ui.tranEmployee);
        end
        local employee=this.employeeList[i];
        local headData=not IsNullOrEmpty(v.characterId) and v or nil;
        if headData~=nil then
            headData.callBack=this.HeadCallBack
        end
        employee:SetData(headData);
    end
end

this.HeadCallBack=function(characterId)
    if not IsNullOrEmpty(characterId) then
        this.EmployeesCancelExecute(characterId);
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})