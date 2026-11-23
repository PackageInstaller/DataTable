
local this = {
    vm = nil,
    
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goType2 = uiLink:Get("goType2");
    ui.goType1 = uiLink:Get("goType1");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.txtTag2 = uiLink:Get("txtTag2"):GetComponent("Text");
    ui.txtContent2 = uiLink:Get("txtContent2"):GetComponent("Text");
    ui.txtPayCount = uiLink:Get("txtPayCount"):GetComponent("Text");
    ui.txtTag1 = uiLink:Get("txtTag1"):GetComponent("Text");
    ui.txtContent1 = uiLink:Get("txtContent1"):GetComponent("Text");
    ui.txtDayCount = uiLink:Get("txtDayCount"):GetComponent("Text");
    ui.btnPay = uiLink:Get("btnPay"):GetComponent("Button");
    ui.btnCancel = uiLink:Get("btnCancel"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    ui.rawPayIcon = uiLink:Get("rawPayIcon"):GetComponent("RawImage");
    ui.tranItemList = uiLink:Get("tranItemList"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnCancel",function()
        SimulateRoomMgr.OnAskConfirmEvent(false,function()
            this.ConfirmEventExecute(false)
        end)
    end)
    uiLink:AddClickEvent("btnPay",function()
        SimulateRoomMgr.OnAskConfirmEvent(true,function()
            this.ConfirmEventExecute(true)
        end)
    end)
    uiLink:AddClickEvent("btnConfrim",function()
        SimulateRoomMgr.OnAskConfirmEvent(true,function()
            this.ConfirmEventExecute(true)
        end)
    end)
end

this.ConfirmEventExecute=function(isAccept)
    SimulateRoomMgr.OnAskSettlement(function()
        LuaMgr.HidePanel(UIName.SimulateManageEventViewModel);
    end)
end


local data = {
  
}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.InitUI(vm.behaviour);
        print("before_awake");
        this.itemVMList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        LuaMgr.InvokeUIEventListeners(UIEventConst.SimulateRoomButtonState, 1);
        if not IsNull(this.itemVMList) then
            for i,v in pairs(this.itemVMList) do
                SetActive(v.transform.gameObject,false);
            end
        end
    end,
    before_destroy = function()
        this.ClearUI()
    end
}

this.ParseData=function()
    this.cfgConstants=ConfigMgr.Config.SimulateConstants
    this.dataPrefixSettlement=DataMgr.Player.SimulateArchitect.PrefixSettlement;

    SetActive(ui.goType1,this.dataPrefixSettlement.EvtId==1);
    SetActive(ui.goType2,this.dataPrefixSettlement.EvtId==2);
    if this.dataPrefixSettlement.EvtId==1 then

        this.SetType1Info();
    elseif this.dataPrefixSettlement.EvtId==2 then

        this.SetType2Info();
    end
end

this.SetType1Info=function()
    ui.txtTag1.text=ConfigMgr.LangGlobal("28114");
    ui.txtContent1.text=ConfigMgr.LangGlobal("28113");
    local curCount=this.cfgConstants.SimulateOccasionEvent2-DataMgr.Player.SimulateArchitect.GetRwEvtTimes;
    ui.txtDayCount.text=string.format(ConfigMgr.LangGlobal("28115"),curCount,this.cfgConstants.SimulateOccasionEvent2)
    local itemList={}
    if not IsNull(this.dataPrefixSettlement.EvtItm) then
        for i,v in pairs(this.dataPrefixSettlement.EvtItm) do
           table.insert(itemList,{id=i,count=v});
        end
    end
    for i,v in ipairs(itemList) do
        if this.itemVMList[tonumber(i)]==nil then
            this.itemVMList[tonumber(i)]=GoodsDataItem.New(ui.tranItemList);
        end
        SetActive(this.itemVMList[tonumber(i)].transform.gameObject,true);
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemConfig["count0"] = v.count
        this.itemVMList[tonumber(i)]:SetData(1,itemConfig,1,false,Vector3(0.56,0.56,0.56),false)
    end
end



this.SetType2Info=function()
    local itemId=this.cfgConstants.SimulateRevenueItem;
    local itemCount=this.cfgConstants.SimulateOccasionEvent1Cost;
    local path=ConfigHelper.GetItemHomeIconPath(itemId)
    ui.rawPayIcon.texture=LuaMgr.GetTexture(path);
    ui.txtPayCount.text=itemCount;
    ui.txtTag2.text=ConfigMgr.LangGlobal("28112");
    local content=string.format(ConfigMgr.LangGlobal("28111"),ConfigMgr.Config.SimulateConstants.SimulateOccasionOutcome[1],
            math.floor(ConfigMgr.Config.SimulateConstants.SimulateOccasionOutcome[2]/100)).."%";
    ui.txtContent2.text=content;
end


return vm({
    data = data,
    command = command,
    hook = hook
})