require("ViewModel/Simulate/Simulate_OrderBagItem")
require("ViewModel/Simulate/Simulate_OrderBoxItem")

local this = {
    vm = nil,
    boxUIList={};
    boxItemObj=nil;
    bagUIList={};
    bagItemObj=nil;
};



local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goEmpty = uiLink:Get("goEmpty");
    ui.goActive = uiLink:Get("goActive");
    ui.goPush = uiLink:Get("goPush");
    ui.goCancel = uiLink:Get("goCancel");
    ui.goReward = uiLink:Get("goReward");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goFXHongBaoYu = uiLink:Get("goFXHongBaoYu");
    ui.rawLightIcon = uiLink:Get("rawLightIcon"):GetComponent("RawImage");
    ui.rawItem = uiLink:Get("rawItem"):GetComponent("RawImage");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.txtLightName = uiLink:Get("txtLightName"):GetComponent("Text");
    ui.txtIncome = uiLink:Get("txtIncome"):GetComponent("Text");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.txtTips = uiLink:Get("txtTips"):GetComponent("Text");
    ui.btnAdd = uiLink:Get("btnAdd"):GetComponent("Button");
    ui.btnLessen = uiLink:Get("btnLessen"):GetComponent("Button");
    ui.btnMax = uiLink:Get("btnMax"):GetComponent("Button");
    ui.btnMin = uiLink:Get("btnMin"):GetComponent("Button");
    ui.btnPush = uiLink:Get("btnPush"):GetComponent("Button");
    ui.btnCancel = uiLink:Get("btnCancel"):GetComponent("Button");
    ui.btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    ui.btnBook = uiLink:Get("btnBook"):GetComponent("Button");
    ui.imgLight = uiLink:Get("imgLight"):GetComponent("Image");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranBox = uiLink:Get("tranBox"):GetComponent("RectTransform");
    ui.tranBag = uiLink:Get("tranBag"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBook",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateLanternBookViewModel);
    end)
    uiLink:AddClickEvent("btnCancel",function()
        this.BoxCancelExecute();
    end)
    uiLink:AddClickEvent("btnPush",function()
        this.BoxPushExecute();
    end)
    uiLink:AddClickEvent("btnReward",function()
        this.BoxRewardsExecute();
    end)
    uiLink:AddClickEvent("btnAdd",function()
        if this.pushCount<this.saleMax then
            this.pushCount=this.pushCount+1;
            this.UpdateInCome();
        end
    end)
    uiLink:AddClickEvent("btnLessen",function()
        if this.pushCount>1 then
            this.pushCount=this.pushCount-1;
            this.UpdateInCome();
        end
    end)
    uiLink:AddClickEvent("btnMax",function()
        this.pushCount=this.saleMax;
        this.UpdateInCome();
    end)
    uiLink:AddClickEvent("btnMin",function()
        this.pushCount=1;
        this.UpdateInCome();
    end)










end
   


this.BoxPushExecute=function()
    if this.lightInfo==nil then return end;
    local boxId=tostring(this.boxIndex);
    if this.dataLightBlocks[boxId]~=nil and not IsNullOrEmpty(this.dataLightBlocks[boxId].LightId) then
        return;
    end
    SimulateRoomMgr.OnAskSaleLight(true,boxId,this.lightInfo.Id,this.pushCount,function()
        this.ParseData();
    end)
end

this.BoxCancelExecute=function()
    local boxId=tostring(this.boxIndex);
    if this.dataLightBlocks[boxId]==nil or IsNullOrEmpty(this.dataLightBlocks[boxId].LightId) then
        return;
    end
    LuaMgr.ShowLuaPanel(UIName.SimulateConfirmTipViewModel,LuaMgr.GetLangText("SimulateOrderSellOutViewModel_0"),function()
        local lightId=this.dataLightBlocks[boxId].LightId;
        SimulateRoomMgr.OnAskSaleLight(false,boxId,lightId,this.pushCount,function()
            this.ParseData();
        end)
    end,nil);
end
this.BoxRewardsExecute=function()
    local ids={}
    for id,v in pairs(this.rewardDic) do
        table.insert(ids,id);
    end
    SimulateRoomMgr.OnAskLightReward(ids,function()
        SetActive(ui.goFXHongBaoYu,true);
        this.ParseData();
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
        this.InitUI(vm.behaviour);
        this.boxUIList=UIListView.New(ui.tranBox)
        this.boxItemObj=vm.behaviour.transform:Find("template/boxItem").gameObject;
        this.bagUIList=UIListView.New(ui.tranBag)
        this.bagItemObj=vm.behaviour.transform:Find("template/bagItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.boxLength=ConfigMgr.Config.SimulateConstants.SimulateCounterLimit
            this.saleMax=ConfigMgr.Config.SimulateConstants.SimulateSaleLimit
            this.boxIndex=1;
            this.pushCount=1;
            SetActive(ui.goFXHongBaoYu,false);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.boxUIList:Clear();
        this.bagUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_OrderBoxItem")
        UIListView.ClearItem("Simulate_OrderBagItem")
    end
}

this.ParseData=function()
    this.bagIndex=nil
    this.lightList={}
    for i,v in pairs(ConfigMgr.Config.SimulateHandBookMap) do
        table.insert(this.lightList,v);
    end
    table.sort(this.lightList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
    this.dataLightBlocks=DataMgr.Player.SimulateFlowerLight.LightBlocks;
    this.reduceTime=SimulateRoomMgr.CheckTriggerReduceTimeSec();
    for i=#this.lightList,1,-1 do
        if SimulateRoomMgr.GetLanternCount(this.lightList[i].Id)<1 then
            table.remove(this.lightList,i);
        end
    end
    this.SetBagUIList();
    this.SetBoxUIList();
    this.SetBoxInfo();
end

this.SetBagUIList=function()
    this.bagUIList:Clear();
    local list={}
    local locIndex=1;
    for i,v in ipairs(this.lightList) do
        local bagItem={
            id=v.Id,
            index=locIndex,
            name=LuaMgr.GetLangText(v.NameLan),
            iconName=v.Icon;
            count=SimulateRoomMgr.GetLanternCount(v.Id);
            needCount=0;
            isSelect=false;
            callBack=this.BagCallBack;
        }
        local bagData=UIListData.GetData(this.bagItemObj,"Simulate_OrderBagItem",bagItem)
        table.insert(list,bagData)
        locIndex=locIndex+1;
    end
    this.bagUIList:SetData(list);
end

this.BagCallBack=function(index)
    if this.bagIndex~=nil and this.bagIndex==index then
        return;
    end
    local boxId=tostring(this.boxIndex);
    if this.dataLightBlocks[boxId]~=nil and not IsNullOrEmpty(this.dataLightBlocks[boxId].LightId) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("29416"))
        return
    end
    this.bagIndex=index;
    for i,v in ipairs(this.bagUIList.dataList) do
        v.data.isSelect=i==index
        v.data.needCount=i==index and 1 or 0
    end
    local curMaxCount=this.bagUIList.dataList[index].data.count;
    this.saleMax=curMaxCount>ConfigMgr.Config.SimulateConstants.SimulateSaleLimit and 
            ConfigMgr.Config.SimulateConstants.SimulateSaleLimit or curMaxCount;
    this.pushCount=1;
    this.bagUIList:Refresh();
    this.SetBoxPush();
end

this.SetBoxUIList=function()
    this.boxUIList:Clear();
    local list={}
    this.rewardDic={};

    for i=1,this.boxLength,1 do
        local boxItem={
            index=i,
            isActive=false,
            isSelect=this.boxIndex==i;
            callBack=this.BoxCallBack;
        }
        local lightBlock=this.dataLightBlocks[tostring(i)];
        if lightBlock~=nil and not IsNullOrEmpty(lightBlock.LightId) then
            local lightInfo=ConfigMgr.Config.SimulateHandBookMap[lightBlock.LightId]
            boxItem.isActive=true;
            boxItem.count=lightBlock.Count;
            boxItem.iconName=lightInfo.Icon;
            boxItem.harvestTime=lightBlock.HarvestTime;
            if LuaMgr.Timestamp()>lightBlock.HarvestTime then
                this.rewardDic[tostring(i)]=true;
            end
        end
        local boxData=UIListData.GetData(this.boxItemObj,"Simulate_OrderBoxItem",boxItem);
        table.insert(list,boxData);
    end
    SetActive(ui.goReward,NumTool.GetLen(this.rewardDic)>0);
    this.boxUIList:SetData(list);
end

this.BoxCallBack=function(index)
    if this.boxIndex~=nil and this.boxIndex==index then
        return
    end
    this.boxIndex=index;
    for i,v in ipairs(this.boxUIList.dataList) do
        v.data.isSelect=i==index 
    end
    this.boxUIList:Refresh();
    this.SetBoxInfo();
    this.bagIndex=nil;
    this.SetBagUIList();
end

this.SetButtonState=function(type)
    this.buttonType=type
    SetActive(ui.goEmpty,type==0)
    SetActive(ui.goPush,type==1)
    SetActive(ui.goCancel,type==2);
    SetActive(ui.goActive,type>1)
end
this.SetBoxInfo=function()
    local boxId=tostring(this.boxIndex);
    if this.dataLightBlocks[boxId]==nil or IsNullOrEmpty(this.dataLightBlocks[boxId].LightId) then
        this.SetButtonState(0);
        return
    end
    local block=this.dataLightBlocks[boxId];
    local remainTime=block.HarvestTime-LuaMgr.Timestamp();
    remainTime=remainTime<0 and 0 or remainTime;
    if remainTime>0 then
        this.SetButtonState(2)
    else
        this.SetButtonState(3)
        SetActive(ui.goReward,true);
        this.rewardDic[boxId]=true;
    end
    local lightInfo=ConfigMgr.Config.SimulateHandBookMap[block.LightId]
    local path= string.format("%sSimulate/%s.png",Path.Image,lightInfo.Icon);
    ui.rawLightIcon.texture=LuaMgr.GetTexture(path)
end


this.SetBoxPush=function()
    this.lightInfo=this.lightList[this.bagIndex];
    this.SetButtonState(1)
    ui.txtLightName.text=LuaMgr.GetLangText(this.lightInfo.NameLan)
    ui.imgLight.sprite=LuaMgr.GetSprite("Simulate",this.lightInfo.Icon)
    local path=ConfigHelper.GetItemHomeIconPath(this.lightInfo.Price[1].id)
    ui.rawItem.texture=LuaMgr.GetTexture(path);
    local d1,h1,m1=GetTimeDHM2(this.lightInfo.TimeNew[1]*60-this.reduceTime)
    local d2,h2,m2=GetTimeDHM2(this.lightInfo.TimeNew[2]*60-this.reduceTime)
    ui.txtTime.text=string.format(LuaMgr.GetLangText("SimulateOrderSellOutViewModel_1"),h1,m1,h2,m2)
    ui.txtIncome.text=this.lightInfo.Price[1].count*this.pushCount;
    ui.txtTips.text=string.format(LuaMgr.GetLangText("SimulateOrderSellOutViewModel_2"),this.pushCount,ConfigMgr.Config.SimulateConstants.SimulateSaleLimit);
    ui.txtCount.text=this.pushCount;
end

this.UpdateInCome=function()
    local lightInfo=this.lightList[this.bagIndex];
    ui.txtIncome.text=lightInfo.Price[1].count*this.pushCount;
    ui.txtTips.text=string.format(LuaMgr.GetLangText("SimulateOrderSellOutViewModel_3"),this.pushCount,ConfigMgr.Config.SimulateConstants.SimulateSaleLimit);
    ui.txtCount.text=this.pushCount;
    this.bagUIList.dataList[this.bagIndex].data.needCount=this.pushCount;
    this.bagUIList:Refresh();
end



return vm({
    data = data,
    command = command,
    hook = hook
})