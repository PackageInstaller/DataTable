require("ViewModel/Simulate/Simulate_EmployeeBagGroup")
require("ViewModel/Simulate/Simulate_EmployeeBagItem")

local this = {
    vm = nil,
    employeeViewData={};
    employeeViewList={};
    employeeGroupItemObj=nil;
    employeeItemObj=nil;
groupCount=2;
    qSpineId="W0147";
    qSpineSkinId="W0147001";
    curCharacterId=nil;
    employeeHeroVm=nil;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goEmployeeView = uiLink:Get("goEmployeeView");
    ui.goEmployeeInfo = uiLink:Get("goEmployeeInfo");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.tranQSpine = uiLink:Get("tranQSpine"):GetComponent("RectTransform");
    ui.tranHead = uiLink:Get("tranHead"):GetComponent("RectTransform");
    ui.tranQSpine = uiLink:Get("tranQSpine"):GetComponent("UISpineCharacter");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.imgTouristFill = uiLink:Get("imgTouristFill"):GetComponent("Image");
    ui.imgSatisfieFill = uiLink:Get("imgSatisfieFill"):GetComponent("Image");
    ui.imgVisitFill = uiLink:Get("imgVisitFill"):GetComponent("Image");
    ui.txtTouristName = uiLink:Get("txtTouristName"):GetComponent("Text");
    ui.txtTouristValue = uiLink:Get("txtTouristValue"):GetComponent("Text");
    ui.txtSatisfieName = uiLink:Get("txtSatisfieName"):GetComponent("Text");
    ui.txtSatisfieValue = uiLink:Get("txtSatisfieValue"):GetComponent("Text");
    ui.txtVisitName = uiLink:Get("txtVisitName"):GetComponent("Text");
    ui.txtVisitValue = uiLink:Get("txtVisitValue"):GetComponent("Text");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        SetActive(ui.goEmployeeInfo,false);
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
        this.employeeHeroVm=nil;
        this.InitUI(vm.behaviour)
        this.employeeViewList=UIScrollView.New(ui.goEmployeeView);
        this.employeeGroupItemObj=vm.behaviour.transform:Find("template/employeeBagGroup").gameObject;
        this.employeeItemObj=vm.behaviour.transform:Find("template/employeeBagItem").gameObject;
        this.QSpine=vm.behaviour.transform:Find("root/Middle/heroInfo/tranQSpine"):GetComponent("UISpineCharacter");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.cfgRecruitMap=ConfigMgr.Config.SimulateRecruitMap;
            this.simulateConstants=ConfigMgr.Config.SimulateConstants
            this.curCharacterId=nil;

            SetActive(ui.goEmployeeInfo,false);
            this.isRefrush=true;
            this.defalutDataEmployees={};
            this.employeeUsedFXDic={};
            if not IsNull(DataMgr.Player.SimulateArchitect.Employees) then
                this.defalutDataEmployees=table.Copy(DataMgr.Player.SimulateArchitect.Employees);
            end
            this.ParseData();
        end
        
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.employeeViewList:Clear();
        if this.employeeViewData~=nil and #this.employeeViewData>0 then
            for i,v in ipairs(this.employeeViewData) do
                SimulateRoomMgr.UpdateEmployeeNew(v.characterId,"EMPLOYEESBAG");
            end
        end
    end,
    before_destroy = function()
        this.ClearUI()
        UIScrollView.ClearItem("Simulate_EmployeeBagGroup")
        UIListView.ClearItem("Simulate_EmployeeBagItem")
    end
}

this.ParseData=function()
    this.dataSimulateArchitect=DataMgr.Player.SimulateArchitect;
    this.SetEmployeeData();
end


this.SetEmployeeData=function()
    this.employeeViewData={};
    for i,v in pairs(this.cfgRecruitMap) do
        if SimulateRoomMgr.CheckEmployeeIsUnlock(v) then
            local character=ConfigMgr.Config.characterTable[v.Id]
            if character~=nil  and this.defalutDataEmployees[v.Id]==nil then
                local employee={
                    characterId=i,
                    name=LuaMgr.GetLangText(character.namelan);
                    rare=character.rare;
                    job=character.job,
                    tourist=v.Customer,
                    satisfie=v.Satisfy,
                    visit=v.TravelTime,
                    touristPro=v.Customer/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[1]),
                    satisfiePro=v.Satisfy/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[2]),
                    visitPro=v.TravelTime/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[3]),
                    isNew=SimulateRoomMgr.CheckEmployeeIsNew(v.Id,"EMPLOYEESBAG"),
                    order=v.Order,
                    isUsed=this.dataSimulateArchitect.Employees[v.Id]~=nil ,
                    cost=v.Cost,
                    callBack=this.EmployeeCallBack,
                }
                employee.isUsedFX=employee.isUsed and this.employeeUsedFXDic[v.Id]==nil;
                if employee.isUsedFX then
                    this.employeeUsedFXDic[v.Id]=true;
                end
                table.insert(this.employeeViewData,employee)
            end
        end
    end
    if #this.employeeViewData==0 then
        return;
    end
    table.sort(this.employeeViewData,function(a, b) return a.order<b.order end)
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
        local groupData=UIScrollData.GetData(this.employeeGroupItemObj,"Simulate_EmployeeBagGroup",890,210,groupItem);
        table.insert(list,groupData);
    end
    this.employeeViewList:SetParams(890, 520)

    this.employeeViewList:SetData(list, this.isRefrush)
end

this.EmployeeCallBack=function(characterId,index)
    this.curCharacterId=characterId;






    local cost=this.cfgRecruitMap[characterId].Cost;
    local count=cost[1].count;
    count=count-count*SimulateRoomMgr.CheckTriggerReduceCostEmployee()
    if DataHelper.GetItemCountById(cost[1].id)<count then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateEmployeesBagViewModel_0"));
        return;
    end
    SimulateRoomMgr.OnAskHire(this.curCharacterId,function()

        this.isRefrush=false;
        this.ParseData()
    end)
end


this.ShowEmployeeInfo=function(characterId)
    SetActive(ui.goEmployeeInfo,true);
    local character=ConfigMgr.Config.characterTable[characterId]
    local recCharacter=this.cfgRecruitMap[characterId]
    if character~=nil  and recCharacter~=nil then
        ui.imgTouristFill.fillAmount=recCharacter.Customer/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[1]);
        ui.imgSatisfieFill.fillAmount=recCharacter.Satisfy/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[2]);
        ui.imgVisitFill.fillAmount=recCharacter.TravelTime/tonumber(this.simulateConstants.SimulateRoleAttributeLimit[3]);
        ui.txtTouristValue.text=recCharacter.Customer;
        ui.txtSatisfieValue.text=recCharacter.Satisfy;
        ui.txtVisitValue.text=recCharacter.TravelTime;
        ui.txtTouristName.text=SimulateRoomMgr.Build_FourName[2]
        ui.txtSatisfieName.text=SimulateRoomMgr.Build_FourName[3]
        ui.txtVisitName.text=SimulateRoomMgr.Build_FourName[4]
        ui.txtName.text=LuaMgr.GetLangText(character.namelan);
        local headData={
            characterId=characterId,
            rare=character.rare;
            job=character.job,
        }
        if this.employeeHeroVm==nil then
            this.employeeHeroVm=Simulate_headItem.New(ui.tranHead)
        end
        this.employeeHeroVm:SetData(headData);
    end
end
    


return vm({
    data = data,
    command = command,
    hook = hook
})