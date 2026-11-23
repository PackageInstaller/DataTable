require("ViewModel/Simulate/Simulate_BuildingProItem")
local this = {
    vm = nil,
    buildingProUIList={};
    buildingProItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.slider = uiLink:Get("slider"):GetComponent("Slider");
    ui.imgLevelIcon = uiLink:Get("imgLevelIcon"):GetComponent("Image");
    ui.imgFanFillAmount = uiLink:Get("imgFanFillAmount"):GetComponent("Image");
    ui.txtLevelName = uiLink:Get("txtLevelName"):GetComponent("Text");
    ui.txtTotalFans = uiLink:Get("txtTotalFans"):GetComponent("Text");
    ui.txtFansValue = uiLink:Get("txtFansValue"):GetComponent("Text");
    ui.txtManageCount = uiLink:Get("txtManageCount"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.btnSettlement = uiLink:Get("btnSettlement"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnSettlement",function()
        LuaMgr.HidePanel(UIName.SimulateManageInfoViewModel)
        LuaMgr.ShowLuaPanel(UIName.SimulateManageSettlementViewModel)
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
        this.buildingProUIList=UIListView.New(ui.tranContent);
        this.buildingProItemObj=vm.behaviour.transform:Find("template/buildProItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_finish.mp3");
            this.buildingList={}
            for i,v in pairs(ConfigMgr.Config.SimulateArchitectMap) do
                if v.Isupgrade>0 then
                    table.insert(this.buildingList,v);
                end
            end
            table.sort(this.buildingList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.buildingProUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_BuildingProItem")
    end
}

this.ParseData=function()
    this.dataPrefixSettlement=DataMgr.Player.SimulateArchitect.PrefixSettlement;
    this.dataBuilds=DataMgr.Player.SimulateArchitect.SimulateBuilds;
    ui.txtManageCount.text=""


    this.SetBuildingList();
end


this.SetBuildingList=function()
    this.buildingProUIList:Clear();
    this.totalFans=0;
    local list={}
    for i,v in ipairs(this.buildingList) do
        local isUnLock=SimulateRoomMgr.CheckBuildingIsUnLock(v.Id);
        if isUnLock then
            local buildingItem={
                id=v.Id,
                index=i,
                name=LuaMgr.GetLangText(v.NameLan),
                tag="",
                starIndex=this.GetBuildingRareIndex(v.Id);
                value=this.GetBuildFans(v.Id);
            }
            this.totalFans=this.totalFans+buildingItem.value;
            local buildingData=UIListData.GetData(this.buildingProItemObj,"Simulate_BuildingProItem",buildingItem)
            table.insert(list,buildingData);
        end
    end
    this.buildingProUIList:SetData(list);
    this.SetFansInfos();
end

this.GetBuildingRareIndex=function(buildId)
    local buildData=this.dataBuilds[buildId]
    local touristsPro=buildData.TouristsValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,2,buildData.Level);
    local satisfiesPro=buildData.SatisfiesValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,3,buildData.Level);
    local visitsPro=buildData.VisitsValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,4,buildData.Level);
    local starIndex=1;
    if touristsPro>0.99 then
        starIndex=starIndex+1;
    end
    if satisfiesPro>0.99 then
        starIndex=starIndex+1;
    end
    if visitsPro>0.99 then
        starIndex=starIndex+1;
    end
    return starIndex;
end

this.GetBuildFans=function(buildId)
    if IsNull(this.dataPrefixSettlement) or this.dataPrefixSettlement.Builds[buildId]==nil then
        return 0
    end
    return this.dataPrefixSettlement.Builds[buildId].StageValue
end

this.SetFansInfos=function()
    local dataSIM=DataMgr.Player.SimulateArchitect;
    ui.imgLevelIcon.sprite=LuaMgr.GetSprite("Simulate","ui_hd_rsrh_jy_settle_yydj_icon_lv"..dataSIM.StageLevel);
    local cfgDegree=ConfigMgr.Config.SimulateDegreeMap[tostring(dataSIM.StageLevel)];
    if cfgDegree==nil then
        cfgDegree=ConfigMgr.Config.SimulateDegreeMap["1"]
    end
    ui.txtLevelName.text=LuaMgr.GetLangText(cfgDegree.NameLan);
    ui.txtTotalFans.text=string.format(LuaMgr.GetLangText("SimulateManageInfoViewModel_0"),this.totalFans);
    local curFans=dataSIM.StageValue+this.totalFans;
    local maxFans=SimulateRoomMgr.GetBuildingMaxStageValue(dataSIM.StageLevel);
    ui.txtFansValue.text=string.format(LuaMgr.GetLangText("SimulateManageInfoViewModel_1"),curFans,maxFans);
    ui.imgFanFillAmount.fillAmount=curFans/maxFans;
end

return vm({
    data = data,
    command = command,
    hook = hook
})