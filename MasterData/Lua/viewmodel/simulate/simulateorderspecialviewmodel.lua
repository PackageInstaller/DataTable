require("ViewModel/Simulate/Simulate_OrderSlotItem2")
require("ViewModel/Simulate/Simulate_OrderLanternItem2")
require("ViewModel/Simulate/Simulate_BagViewModel")
local this = {
    vm = nil,
    slotUIList={};
    slotItemObj=nil;
lanternNeedUIList={};
    lanternItemObj=nil;
    qSpine=nil;
    isShowMsg=false,
};

local cokey=nil;

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goOrderInfos = uiLink:Get("goOrderInfos");
    ui.goMsg = uiLink:Get("goMsg");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");
    ui.btnBook = uiLink:Get("btnBook"):GetComponent("Button");
    ui.btnRefuse = uiLink:Get("btnRefuse"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.tranQSpine = uiLink:Get("tranQSpine"):GetComponent("RectTransform");
    ui.tranList1 = uiLink:Get("tranList1"):GetComponent("RectTransform");
    ui.tranRewards = uiLink:Get("tranRewards"):GetComponent("RectTransform");
    ui.tranBag = uiLink:Get("tranBag"):GetComponent("RectTransform");
    ui.txtSpineMsg = uiLink:Get("txtSpineMsg"):GetComponent("Text");
    ui.txtDaily = uiLink:Get("txtDaily"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBook",function()
       LuaMgr.ShowLuaPanel(UIName.SimulateLanternBookViewModel);
    end)
    uiLink:AddClickEvent("btnRefuse",function()

        this.OrderRefuseExecute();
    end)
    uiLink:AddClickEvent("btnConfrim",function()
        this.OrderFinishExecute()
    end)
end

this.OrderRefuseExecute=function()
    if not this.isShowMsg and this.orderInfo~=nil then
        local orderId=this.orderInfo.Id
        SimulateRoomMgr.OnAskOrderRefuse(orderId,function()
            this.isShowMsg=true;
            SetActive(ui.goMsg,true);
            ui.txtSpineMsg.text=this.GetRandomMsg(2);
            cokey=coroutine_runner.start(function()
                coroutine_runner.wait(2);
                if ui~=nil then
                    this.ParseData();
                end
            end)
        end)
        
    end
end

this.OrderFinishExecute=function()
    if not this.isShowMsg and this.orderInfo~=nil then
        local curCount=DataMgr.Player.dailyCount["sltspRefreshOrder"]==nil and 0 or DataMgr.Player.dailyCount["sltspRefreshOrder"] ;
        if curCount>=ConfigMgr.Config.SimulateConstants.SimulateSpecialOrderDailyLimit then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("29418"));
            return;
        end
        local orderIds={}
        table.insert(orderIds,this.orderInfo.Id)
        if this.CheckSubmitCountIsEnough(this.submitDic)<0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateOrderSpecialViewModel_0"))
            return;
        end
        local costDic={}
        for i,v in pairs(this.submitDic) do
            costDic[v.id]=v.count
        end
        SimulateRoomMgr.OnAskOrderFinish(orderIds,costDic,function()
            this.isShowMsg=true;
            SetActive(ui.goMsg,true);
            ui.txtSpineMsg.text=this.GetRandomMsg(1);
            cokey=coroutine_runner.start(function()
                coroutine_runner.wait(2);
                if ui~=nil then
                    this.ParseData();
                end
            end)
        end)
    end
end

this.GetRandomMsg=function(msgType)
    local list=msgType==1 and this.acceptMsgList or this.refuseMsgList;
    math.randomseed(LuaMgr.Timestamp())
    local index=math.random(#list)
    return list[index];
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
        this.slotUIList=UIListView.New(ui.tranContent)
        this.slotItemObj=vm.behaviour.transform:Find("template/slotItem").gameObject;
        this.lanternNeedUIList=UIListView.New(ui.tranList1);
        this.lanternItemObj=vm.behaviour.transform:Find("template/lanternItem").gameObject;
        this.qSpine=vm.behaviour.transform:Find("root/Middle/goOrderInfos/tranQSpine"):GetComponent("UISpineCharacter")
        this.rewardListVM={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.cfgSimulateExchangePoolMap=ConfigMgr.Config.SimulateExchangePoolMap;
            this.orderList={}
            this.submitDic={};
            for i,v in pairs(ConfigMgr.Config.SimulateExchangeMap) do

                if v.PoolID=="100" then
                    table.insert(this.orderList,v);
                end
            end
            table.sort(this.orderList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end);
            this.orderIndex=1;
            this.ParseData();
            local msgAct=ConfigMgr.LangGlobal("28116");
            local msgRef=ConfigMgr.LangGlobal("28117");
            this.acceptMsgList=NumTool.split(msgAct,'_');
            this.refuseMsgList=NumTool.split(msgRef,'_');
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.slotUIList:Clear();
        this.lanternNeedUIList:Clear();
        if this.myBagViewModel~=nil then
            this.myBagViewModel:Clear();
        end
        this.ClearOrderRewardsList();
        if cokey~=nil then
            coroutine_runner.stop(cokey);
            cokey=nil;
        end
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_OrderSlotItem2")
        UIListView.ClearItem("Simulate_OrderLanternItem2")
        if this.myBagViewModel~=nil then
            this.myBagViewModel:Destroy();
        end
    end
}

this.ParseData=function()
    this.isShowMsg=false;
    SetActive(ui.goMsg,false);
    this.dataSimulateOrders=DataMgr.Player.SimulateOrders;
    this.SetOrderSpecialList();
    if #this.slotUIList.itemList==0 then
        SetActive(ui.btnRefuse.gameObject,false)
        SetActive(ui.btnConfrim.gameObject,false);
        LuaMgr.Back();
        return;
    end
    this.SetOrderInfos();
end



this.CheckSubmitCountIsEnough=function(submitDic)
    local needCount=0;
    local curCount=0;
    for i,v in pairs(this.needList) do
        needCount=needCount+v.count;
    end
    if submitDic~=nil then
        for i,v in pairs(submitDic) do
            curCount=curCount+v.count;
        end
    end
    if curCount<needCount then
        return -1;
    elseif curCount>needCount then
        return 1;
    else
        return 0;
    end
end

this.SetOrderSpecialList=function()
    this.slotUIList:Clear();
    local list={};
    local locIndex=1;
    for i,v in ipairs(this.orderList) do
        local dataOrder=this.dataSimulateOrders.Orders[v.Id];
        if dataOrder~=nil then
            local characterId=ConfigMgr.Config.SimulateExchangePoolMap[dataOrder.ExchangeId].CharacterID;
            local orderItem={
                index=locIndex,
                orderId=v.Id,
                orderState=2,
                characterId=characterId;
                stateInfo="";
                isCur=this.orderIndex==i;
                callBack=this.OrderClickCallBack,
            }
            local orderData=UIListData.GetData(this.slotItemObj,"Simulate_OrderSlotItem2",orderItem);
            table.insert(list,orderData);
            locIndex=locIndex+1;
        end
    end
    this.slotUIList:SetData(list);
end

this.OrderClickCallBack=function(index)
    if this.orderIndex~=nil and this.orderIndex==index then
        return;
    end
    this.orderIndex=index;
    for i,v in ipairs(this.slotUIList.itemList) do
        v:SetSelect(i==this.orderIndex)
    end
    if this.myBagViewModel~=nil then
        this.myBagViewModel:Clear();
    end
    this.SetOrderInfos();
end

this.SetOrderInfos=function()
    SetActive(ui.goOrderInfos,true)
    this.needList={}
    this.submitDic={};
    if this.myBagViewModel==nil then
        this.myBagViewModel=Simulate_BagViewModel.New(ui.tranBag)
    end
    if this.orderIndex>#this.slotUIList.dataList then
        this.orderIndex=1;
    end
    local curOrderId=this.slotUIList.dataList[this.orderIndex].data.orderId
    this.orderInfo=ConfigMgr.Config.SimulateExchangeMap[curOrderId];
    local dataOrder=this.dataSimulateOrders.Orders[curOrderId];
    local curCount=DataMgr.Player.dailyCount["sltspRefreshOrder"]==nil and 0 or DataMgr.Player.dailyCount["sltspRefreshOrder"] ;
    ui.txtDaily.text=string.format(LuaMgr.GetLangText("SimulateOrderSpecialViewModel_1"),curCount,ConfigMgr.Config.SimulateConstants.SimulateSpecialOrderDailyLimit)
    this.exchangeInfo=ConfigMgr.Config.SimulateExchangePoolMap[dataOrder.ExchangeId];
    this.needList=this.exchangeInfo.Cost;
    this.orderNeedDic={};
    for i,v in ipairs(this.exchangeInfo.Cost) do
        this.orderNeedDic[v.id]={index=1,count=v.count};
    end
    this.myBagViewModel:SetData(dataOrder.ExchangeId,this.orderNeedDic,this.BagSelectCallBack);
    this.qSpine:SetBattle(this.exchangeInfo.CharacterID,this.exchangeInfo.CharacterID.."001","-1",0,nil)

    this.SetOrderNeedUIList();
    this.SetOrderRewardsList();
end

this.BagSelectCallBack=function(selectIdsDic)
    if IsNull(selectIdsDic) then return end;




    for i,v in ipairs(this.lanternNeedUIList.dataList) do
        if selectIdsDic[v.data.id]~=nil then
            v.data.isSelect=true;
            v.data.curCount=selectIdsDic[v.data.id].count>v.data.needCount and v.data.needCount or selectIdsDic[v.data.id].count;
        else
            v.data.isSelect=false;
            v.data.curCount=0;
        end
    end
    this.lanternNeedUIList:Refresh()
    this.submitDic=selectIdsDic;

end

this.SetOrderNeedUIList=function()
    this.lanternNeedUIList:Clear();
    local list={}
    for i,v in ipairs(this.needList) do
        local cfgLantern=ConfigMgr.Config.SimulateHandBookMap[v.id]
        if cfgLantern~=nil then
            local needItem={
                id=v.id;
                iconName=cfgLantern.Icon;
                name=LuaMgr.GetLangText(cfgLantern.NameLan);
                type=2;
                curCount=0;
                isTag=false,
                tagInfo="",
                isSelect=false;
                needCount=v.count;
            }
            local needData=UIListData.GetData(this.lanternItemObj,"Simulate_OrderLanternItem2",needItem);
            table.insert(list,needData);
        end
    end
    this.lanternNeedUIList:SetData(list);
    
end


this.SetOrderRewardsList=function()
    for i,v in ipairs(this.exchangeInfo.Rewards) do
        if this.rewardListVM[tostring(i)]==nil then
            this.rewardListVM[tostring(i)]=GoodsDataItem.New(ui.tranRewards)
        end
        local itemData = ConfigMgr.Config.itemMap[v.id];
        itemData.count0 = v.count;
        SetActive(this.rewardListVM[tostring(i)].gameObject,true);
        this.rewardListVM[tostring(i)]:SetData(1, itemData, 1, false, Vector3(0.6,0.6,0.6), false);
    end
end
this.ClearOrderRewardsList=function()
    if IsNull(this.rewardListVM) then return end;
    for i,v in pairs(this.rewardListVM) do
        SetActive(v.gameObject,false);
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})