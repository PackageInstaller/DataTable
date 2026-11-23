require("ViewModel/Simulate/Simulate_BuildingUpLevelItem")

local this = {
    vm = nil,
    buildingUIList={};
    buildingItemObj=nil;
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
    ui.goUpLevelFX = uiLink:Get("goUpLevelFX");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.rectBg = uiLink:Get("rectBg"):GetComponent("RectTransform");
    ui.tranStar = uiLink:Get("tranStar"):GetComponent("RectTransform");
    ui.tranUpLevelList = uiLink:Get("tranUpLevelList"):GetComponent("RectTransform");
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
    ui.sliderTourists = uiLink:Get("sliderTourists"):GetComponent("Slider");
    ui.sliderSatisfies = uiLink:Get("sliderSatisfies"):GetComponent("Slider");
    ui.sliderVisits = uiLink:Get("sliderVisits"):GetComponent("Slider");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnConfrim",function()
        this.UpLevelExecute();
    end)
  
end


this.UpLevelExecute=function()
    if this.UpLevelType==0 or not this.isCanUpLevel then return end;
    local curBuildingData=this.buildingUIList.itemList[this.UpLevelType].data;
    local myCostCount=DataHelper.GetItemCountById(curBuildingData.upCost.id);
    if curBuildingData.isMaxLevel then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateBuildingUpLevelViewModel_1"))
        return;
    end
    if myCostCount<curBuildingData.upCost.count then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateBuildingUpLevelViewModel_0"))
        return;
    end
    this.isCanUpLevel=false;
    if this.UpLevelType==1 then
        SimulateRoomMgr.OnAskBuildingUpLevel(this.buildId,function()
            this.buildingUIList.itemList[this.UpLevelType]:SetUpLevelFX();
            this.SetUpLevelFX();
            NumTool.DelayHandler(function()
                if ui~=nil then
                    this.ParseData();
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateBuildingUpLevelViewModel_2"));
                end
            end,1)


        end)
    else
        SimulateRoomMgr.OnAskBuildingThreeRange(this.buildId,this.UpLevelType-2,function()
            this.buildingUIList.itemList[this.UpLevelType]:SetUpLevelFX();
            this.SetUpLevelFX();
            NumTool.DelayHandler(function()
                if ui~=nil then
                    this.ParseData();
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateBuildingUpLevelViewModel_3"))
                end
            end,1)

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
        this.InitUI(vm.behaviour)
        this.buildingUIList=UIListView.New(ui.tranUpLevelList);
        this.buildingItemObj=vm.behaviour.transform:Find("template/buildingUpItem").gameObject;

    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                this.buildId=vm.behaviour.Params[0];
                this.buildInfo=ConfigMgr.Config.SimulateArchitectMap[this.buildId];
                if this.buildInfo==nil then return end;
                this.UpLevelType=0;
                SetActive(ui.goUpLevelFX,false)
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.buildingUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_BuildingUpLevelItem")
    end
}


this.ParseData=function()
    this.isCanUpLevel=true;
    this.dataSimulateArchitect=DataMgr.Player.SimulateArchitect;
    if not IsNull(DataMgr.Player.SimulateArchitect) and not IsNull(DataMgr.Player.SimulateArchitect.SimulateBuilds) then
        this.dataBuilding=DataMgr.Player.SimulateArchitect.SimulateBuilds[this.buildId];
        if this.dataBuilding==nil then
            return
        end;
    end
    
    this.curBuildingLevel=this.dataBuilding.Level;
    this.curTouristLevel=this.dataBuilding.Tourists;
    this.curSatisfiesLevel= this.dataBuilding.Satisfies;
    this.curVisitsLevel=this.dataBuilding.Visits;
    
    this.IsMaxBuildingLevel=this.curBuildingLevel+1>=SimulateRoomMgr.GetBuildingMaxLevel(this.buildId,1)
    this.IsMaxTouristLevel=this.curTouristLevel+1>=SimulateRoomMgr.GetBuildingMaxLevel(this.buildId,2)
    this.IsMaxSatisfiesLevel=this.curSatisfiesLevel+1>=SimulateRoomMgr.GetBuildingMaxLevel(this.buildId,3)
    this.IsMaxVisitsLevel=this.curVisitsLevel+1>=SimulateRoomMgr.GetBuildingMaxLevel(this.buildId,4)
    this.SetBuildingUpData();
    this.UpdateInfo(this.UpLevelType);
end

this.SetUpLevelFX=function()
    SetActive(ui.goUpLevelFX,true)
    NumTool.DelayHandler(function()
        if ui~=nil and ui.goUpLevelFX~=nil then
            SetActive(ui.goUpLevelFX,false)
        end
    end,1)
end

this.SetBuildingUpData=function()
    this.buildingUpLevelList={}
    local buildingUpData={
        index=1,
        level=this.dataBuilding.Level+1;
        levelValue=this.dataBuilding.StageValue;
        name="",
        isMaxLevel=this.IsMaxBuildingLevel,
    }
    local buildingTouristData={
        index=2,
        level=this.dataBuilding.Tourists+1;
        levelValue=this.dataBuilding.TouristsValue;
        name="",
        isMaxLevel=this.IsMaxTouristLevel,
    }
    local buildingSatisfiesData={
        index=3,
        level=this.dataBuilding.Satisfies+1;
        levelValue=this.dataBuilding.SatisfiesValue;
        name="",
        isMaxLevel=this.IsMaxSatisfiesLevel,
    }
    local buildingVisitsData={
        index=4,
        level=this.dataBuilding.Visits+1;
        levelValue=this.dataBuilding.VisitsValue;
        name="",
        isMaxLevel=this.IsMaxVisitsLevel,
    }
    table.insert(this.buildingUpLevelList,buildingUpData);
    table.insert(this.buildingUpLevelList,buildingTouristData)
    table.insert(this.buildingUpLevelList,buildingSatisfiesData)
    table.insert(this.buildingUpLevelList,buildingVisitsData);
    this.SetBuildingUpList();
end

this.SetBuildingUpList=function()
    this.buildingUIList:Clear();
    local list={}
    for i,v in ipairs(this.buildingUpLevelList) do
        local upLevelItem=v;
        local level=v.level;

        if i==1 then
            level=level>#this.buildInfo.Consume1Itm and #this.buildInfo.Consume1Itm or level
            upLevelItem.upCost=this.buildInfo.Consume1Itm[level];
        else
            level=level>#this.buildInfo.Consume2Itm[i-1] and #this.buildInfo.Consume2Itm[i-1] or level
            upLevelItem.upCost=this.buildInfo.Consume2Itm[i-1][level];
        end

        upLevelItem.maxLevel=SimulateRoomMgr.GetBuildingMaxLevel(this.buildId,i);
        upLevelItem.buildId=this.buildId;
        upLevelItem.callBack=this.UpLevelCallBack;
        upLevelItem.isOn=i==this.UpLevelType;
        
        local upLevelData=UIListData.GetData(this.buildingItemObj,"Simulate_BuildingUpLevelItem",upLevelItem);
        table.insert(list,upLevelData);
    end
    this.buildingUIList:SetData(list);
end

this.UpLevelCallBack=function(index)
    if this.UpLevelType==index then return end;
    this.UpLevelType=index;
    this.UpdateInfo(this.UpLevelType)
    for i,v in ipairs(this.buildingUIList.itemList) do
        v:SetSelect(i==index);
    end
end

this.UpdateInfo=function(index)
    this.starIndex=1;
    this.SetTouristsInfo(index)
    this.SetSatisfiesInfo(index)
    this.SetVisitsInfo(index);
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


this.SetTouristsInfo=function(index)
    local curTourists= this.dataBuilding.TouristsValue;
    local maxTourists=SimulateRoomMgr.GetBuildingMaxFansByLevel(this.buildId,2,this.curBuildingLevel)
    local curValue=curTourists/maxTourists;;
    ui.sliderTourists.value=curValue
    ui.imgTouristsFillColor.color=curValue<0.4 and colorRed or colorGreen
    ui.txtTouristsPro.text=string.format("%s/%s",curTourists,maxTourists)
    if curValue>0.99 then
        this.starIndex=this.starIndex+1;
    end
    local offValue=0;
    if index==1 then

        if this.IsMaxBuildingLevel then
            ui.txtTouristsPro.text=string.format("%s/%s",curTourists,maxTourists)
        else
            offValue=SimulateRoomMgr.GetBuildingFansByLevel(this.buildId,2,this.curBuildingLevel+1)
            ui.txtTouristsPro.text=string.format("%s/%s<color=#487e45>+%s</color>",curTourists,maxTourists,offValue)
        end
    elseif index==2 then

        if this.IsMaxTouristLevel then
            ui.txtTouristsPro.text=string.format("%s/%s",curTourists,maxTourists)
        else
            offValue=SimulateRoomMgr.GetBuildingBaseFansByLevel(this.buildId,1,this.curTouristLevel+1)
            ui.txtTouristsPro.text=string.format("%s<color=#487e45>+%s</color>/%s",curTourists,offValue,maxTourists)
        end
    else
        ui.txtTouristsPro.text=string.format("%s/%s",curTourists,maxTourists)
    end
end


this.SetSatisfiesInfo=function(index)
    local curSatisfies= this.dataBuilding.SatisfiesValue;
    local maxSatisfies=SimulateRoomMgr.GetBuildingMaxFansByLevel(this.buildId,3,this.curBuildingLevel)
    local curValue=curSatisfies/maxSatisfies;
    ui.sliderSatisfies.value=curValue;
    ui.imgSatisfiesFillColor.color=curValue<0.4 and colorRed or colorGreen
    if curValue>0.99 then
        this.starIndex=this.starIndex+1;
    end
    local offValue=0;
    if index==1 then

        if this.IsMaxBuildingLevel then
            ui.txtSatisfiesPro.text=string.format("%s/%s",curSatisfies,maxSatisfies)
        else
            offValue=SimulateRoomMgr.GetBuildingFansByLevel(this.buildId,3,this.curBuildingLevel+1)
            ui.txtSatisfiesPro.text=string.format("%s/%s<color=#487e45>+%s</color>",curSatisfies,maxSatisfies,offValue)
        end
    elseif index==3 then

        if this.IsMaxSatisfiesLevel then
            ui.txtSatisfiesPro.text=string.format("%s/%s",curSatisfies,maxSatisfies)
        else
            offValue=SimulateRoomMgr.GetBuildingBaseFansByLevel(this.buildId,2,this.curSatisfiesLevel+1)
            ui.txtSatisfiesPro.text=string.format("%s<color=#487e45>+%s</color>/%s",curSatisfies,offValue,maxSatisfies)
        end
    else
        ui.txtSatisfiesPro.text=string.format("%s/%s",curSatisfies,maxSatisfies)
    end
    
end



this.SetVisitsInfo=function(index)
    local curVisits= this.dataBuilding.VisitsValue;
    local maxVisits=SimulateRoomMgr.GetBuildingMaxFansByLevel(this.buildId,4,this.curBuildingLevel)
    local curValue=curVisits/maxVisits;
    ui.sliderVisits.value=curValue
    ui.imgVisitsFillColor.color=curValue<0.4 and colorRed or colorGreen
    if curValue>0.99 then
        this.starIndex=this.starIndex+1;
    end
    local offValue=0;
    if index==1 then

        if this.IsMaxBuildingLevel then
            ui.txtVisitsPro.text=string.format("%s/%s",curVisits,maxVisits)
        else
            offValue=SimulateRoomMgr.GetBuildingFansByLevel(this.buildId,4,this.curBuildingLevel+1)
            ui.txtVisitsPro.text=string.format("%s/%s<color=#487e45>+%s</color>",curVisits,maxVisits,offValue)
        end
    elseif index==4 then

        if this.IsMaxSatisfiesLevel then
            ui.txtVisitsPro.text=string.format("%s/%s",curVisits,maxVisits)
        else
            offValue=SimulateRoomMgr.GetBuildingBaseFansByLevel(this.buildId,3,this.curVisitsLevel+1)
            ui.txtVisitsPro.text=string.format("%s<color=#487e45>+%s</color>/%s",curVisits,offValue,maxVisits)
        end
    else
        ui.txtVisitsPro.text=string.format("%s/%s",curVisits,maxVisits)
    end
    
    
end


return vm({
    data = data,
    command = command,
    hook = hook
})