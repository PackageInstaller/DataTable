require("ViewModel/Simulate/Simulate_OrderSlotItem")
require("ViewModel/Simulate/Simulate_OrderLanternItem")
require("ViewModel/Simulate/Simulate_BagViewModel")
local this = {
    vm = nil,
    slotUIList={};
    slotItemObj=nil;
lanternNeedUIList={};
lanternMyUIList={};
    lanternItemObj=nil;
    qSpine=nil;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goOrderInfos = uiLink:Get("goOrderInfos");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");
    ui.btnBook = uiLink:Get("btnBook"):GetComponent("Button");
    ui.btnFrushOrder = uiLink:Get("btnFrushOrder"):GetComponent("Button");
    ui.btnConfrimMax = uiLink:Get("btnConfrimMax"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.tranQSpine = uiLink:Get("tranQSpine"):GetComponent("RectTransform");
    ui.tranList1 = uiLink:Get("tranList1"):GetComponent("RectTransform");
    ui.tranList2 = uiLink:Get("tranList2"):GetComponent("RectTransform");
    ui.tranRewards = uiLink:Get("tranRewards"):GetComponent("RectTransform");
    ui.tranBag = uiLink:Get("tranBag"):GetComponent("RectTransform");
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
    uiLink:AddClickEvent("btnFrushOrder",function()

       this.OrderRefrushExecute();
    end)
    uiLink:AddClickEvent("btnConfrimMax",function()

        this.AutoAddLight();
    end)
    uiLink:AddClickEvent("btnConfrim",function()
        this.OrderFinishExecute()
    end)
  
end

this.OrderRefrushExecute=function()
    if this.orderInfo~=nil then
        local orderId=this.orderInfo.Id
        SimulateRoomMgr.OnAskOrderRefresh(orderId,function()
            this.ParseData();
        end)
    end
end

this.OrderFinishExecute=function()
    if this.orderInfo~=nil then
        local curCount=DataMgr.Player.dailyCount["sltRefreshOrder"]==nil and 0 or DataMgr.Player.dailyCount["sltRefreshOrder"] ;
        if curCount>=ConfigMgr.Config.SimulateConstants.SimulateOrderRefresh then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("29418"))
            return;
        end
        local orderIds={}
        table.insert(orderIds,this.orderInfo.Id)
        if this.CheckSubmitCountIsEnough(this.submitDic)<0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateOrderNormalViewModel_0"))
            return;
        end
        local costDic={}
        for i,v in pairs(this.submitDic) do
            costDic[v.id]=v.count
        end
        SimulateRoomMgr.OnAskOrderFinish(orderIds,costDic,function()
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
        this.InitUI(vm.behaviour);
        this.slotUIList=UIListView.New(ui.tranContent)
        this.slotItemObj=vm.behaviour.transform:Find("template/slotItem").gameObject;
        this.lanternNeedUIList=UIListView.New(ui.tranList1);
        this.lanternMyUIList=UIListView.New(ui.tranList2);
        this.lanternItemObj=vm.behaviour.transform:Find("template/lanternItem").gameObject;
        this.qSpine=vm.behaviour.transform:Find("root/Middle/goOrderInfos/tranQSpine"):GetComponent("UISpineCharacter")
        this.rewardListVM={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.cfgSimulateExchangePoolMap=ConfigMgr.Config.SimulateExchangePoolMap;
            RedMgr.Singleton:FrushRedCondition("17311")
            this.orderList={}
            this.submitDic={};
            for i,v in pairs(ConfigMgr.Config.SimulateExchangeMap) do

                if v.PoolID~="100" then
                    table.insert(this.orderList,v);
                end
            end
            table.sort(this.orderList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end);
            this.orderIndex=1;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.slotUIList:Clear();
        this.lanternNeedUIList:Clear();
        this.lanternMyUIList:Clear();
        if this.myBagViewModel~=nil then
            this.myBagViewModel:Clear();
        end
        this.ClearOrderRewardsList();
        LuaMgr.RemoveTimer(TimerConst.SimulateOrder)
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_OrderSlotItem")
        UIListView.ClearItem("Simulate_OrderLanternItem")
        if this.myBagViewModel~=nil then
            this.myBagViewModel:Destroy();
        end
    end
}

this.ParseData=function()
    this.sortDataLightList={}
    for i,v in pairs(DataMgr.Player.SimulateFlowerLight.Light) do
        table.insert(this.sortDataLightList,{id=i,count=v});
    end
    table.sort(this.sortDataLightList,function(a, b) return a.count>b.count end);
    this.dataSimulateOrders=DataMgr.Player.SimulateOrders;
    this.SetOrderNormalList();
    this.SetOrderInfos();

    this.refrushOrderDic={}
    for i,v in pairs(this.dataSimulateOrders.Orders) do
        if LuaMgr.Timestamp()<v.EffectTime then
            this.refrushOrderDic[v.OrderNo]=v;
        end
    end
    LuaMgr.RemoveTimer(TimerConst.SimulateOrder)
    if NumTool.GetLen(this.refrushOrderDic)>0 then
        LuaMgr.AddTimer(TimerConst.SimulateOrder, this.RefreshSimulateOrder, 10, -1)
    end
end

this.RefreshSimulateOrder=function()
    local newRefrushOrderDic={}
    for i,v in pairs(this.dataSimulateOrders.Orders) do
        if LuaMgr.Timestamp()<v.EffectTime then
            newRefrushOrderDic[v.OrderNo]=v.EffectTime;
        end
    end
    local updateOrderDic= {};
    for i,v in pairs(this.refrushOrderDic) do
        if newRefrushOrderDic[v.OrderNo]==nil then

            updateOrderDic[v.OrderNo]=v;
        end
    end
    this.SetOrderNormalList();

    if this.orderIndex~=nil and not IsNull(updateOrderDic) and NumTool.GetLen(updateOrderDic)>0  then
        local orderInfo=this.orderList[this.orderIndex];
        if updateOrderDic[orderInfo.Id]~=nil then
            this.SetOrderInfos();
            if this.refrushOrderDic[orderInfo.Id]~=nil then
                this.refrushOrderDic[orderInfo.Id]=nil;
            end
        end
    end
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

this.SetOrderNormalList=function()
    this.slotUIList:Clear();
    local list={};
    for i,v in ipairs(this.orderList) do
        local state,Info,chId=this.GetOrderInfos(v);
        local orderItem={
            index=i,
            orderState=state,
            characterId=chId;
            stateInfo=Info;
            isCur=this.orderIndex==i;
            callBack=this.OrderClickCallBack,
        }
        local orderData=UIListData.GetData(this.slotItemObj,"Simulate_OrderSlotItem",orderItem);
        table.insert(list,orderData);
    end
    this.slotUIList:SetData(list);
end



this.GetOrderInfos=function(order)
    local orderState=0;
    local Info="";
    local characterId=""
    local dataOrder=this.dataSimulateOrders.Orders[order.Id];
    if dataOrder~=nil then

        local exchange=ConfigMgr.Config.SimulateExchangePoolMap[dataOrder.ExchangeId];
        if exchange~=nil then
            characterId=exchange.CharacterID;
        end
        local remainTime=dataOrder.EffectTime-LuaMgr.Timestamp();
        if remainTime>0 then
            orderState=1;
            local day,hour,min=GetTimeDHM2(remainTime);
            Info=string.format(LuaMgr.GetLangText("SimulateOrderNormalViewModel_1"),min);
        else
            orderState=2;
        end
    else

        if order.UnlockType==1 then

            local dungeonId=order.UnlockParam;
            local dungeon = ConfigMgr.Config.dungeonMap[dungeonId]
            if dungeon~=nil then
                local dungeonName=LuaMgr.GetLangText(dungeon.NameLan);
                Info=string.format(LuaMgr.GetLangText("SimulateOrderNormalViewModel_2"),dungeonName);
            end
        elseif order.UnlockType==2 then

            local delayDay=tonumber(order.UnlockParam);
            local remainTime=SimulateRoomMgr.GetXCHDActiveStartTime()+delayDay*24*60*60-LuaMgr.Timestamp();
            if remainTime<0 then remainTime=0 end;
            local day,hour,min=GetTimeDHM2(remainTime);
            if day>0 then
                Info=string.format(LuaMgr.GetLangText("SimulateOrderNormalViewModel_3"),day);
            elseif hour>0 then
                Info=string.format(LuaMgr.GetLangText("SimulateOrderNormalViewModel_4"),hour);
            else
                Info=string.format(LuaMgr.GetLangText("SimulateOrderNormalViewModel_5"),min);
            end
        end
    end
    return orderState,Info,characterId;
end


this.OrderClickCallBack=function(index)
    if this.orderIndex~=nil and this.orderIndex==index then
        return;
    end
    if this.slotUIList.itemList[index].data.orderState<1 then
        local tips=this.slotUIList.itemList[index].data.stateInfo
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
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
    this.needList={}
    this.submitDic={};
    if this.myBagViewModel==nil then
        this.myBagViewModel=Simulate_BagViewModel.New(ui.tranBag)
    end
    this.orderInfo=this.orderList[this.orderIndex];
    local dataOrder=this.dataSimulateOrders.Orders[this.orderInfo.Id];
    if LuaMgr.Timestamp()<dataOrder.EffectTime then
        this.myBagViewModel:SetData(nil,nil,nil);
        SetActive(ui.goOrderInfos,false)
        return;
    end
    SetActive(ui.goOrderInfos,true)
    local curCount=DataMgr.Player.dailyCount["sltRefreshOrder"]==nil and 0 or DataMgr.Player.dailyCount["sltRefreshOrder"] ;
    ui.txtDaily.text=string.format(LuaMgr.GetLangText("SimulateOrderNormalViewModel_6"),curCount,ConfigMgr.Config.SimulateConstants.SimulateOrderRefresh)
    this.exchangeInfo=ConfigMgr.Config.SimulateExchangePoolMap[dataOrder.ExchangeId];
    this.needList=this.exchangeInfo.Cost;
    this.orderNeedDic={};
    for i,v in ipairs(this.exchangeInfo.Cost) do
        this.orderNeedDic[v.id]={index=1,count=v.count};
    end
    this.myBagViewModel:SetData(dataOrder.ExchangeId,this.orderNeedDic,this.BagSelectCallBack);
    this.qSpine:SetBattle(this.exchangeInfo.CharacterID,this.exchangeInfo.CharacterID.."001","-1",0,nil)

    this.SetOrderNeedUIList();
    this.SetOrderMyUIList()
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

    this.SetOrderMyUIList(selectIdsDic);
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
                type=1;
                curCount=0;
                isTag=false,
                tagInfo="",
                isSelect=false;
                needCount=v.count;
            }
            local needData=UIListData.GetData(this.lanternItemObj,"Simulate_OrderLanternItem",needItem);
            table.insert(list,needData);
        end
    end
    this.lanternNeedUIList:SetData(list);
    
end

this.SetOrderMyUIList=function(selectIdsDic)
    this.submitDic=selectIdsDic;
    this.lanternMyUIList:Clear();
    if IsNull(this.submitDic) then return end;
    this.myList={};
    for i,v in pairs(this.submitDic) do
        table.insert(this.myList,v);
    end
    table.sort(this.myList,function(a, b) return a.time<b.time end)
    this.lanternMyUIList:Clear();
    local list={};
    for i,v in ipairs(this.myList) do
        local cfgLantern=ConfigMgr.Config.SimulateHandBookMap[v.id]
        if cfgLantern~=nil then
            local myItem={
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
            if this.orderNeedDic[v.id]~=nil then
                myItem.isTag=true;
                myItem.isSelect=true;
                local index=this.orderNeedDic[v.id].index;
                local rate=this.exchangeInfo.Rate[index];
                myItem.tagInfo=string.format("+%s%%",rate/100);
            end
            local needData=UIListData.GetData(this.lanternItemObj,"Simulate_OrderLanternItem",myItem);
            table.insert(list,needData);
        end
    end
    this.lanternMyUIList:SetData(list);
end

this.AutoAddLight=function()
    this.submitDic={};
    if IsNull(DataMgr.Player.SimulateFlowerLight) or IsNull(DataMgr.Player.SimulateFlowerLight.Light) then
        return;
    end
    this.dataLight=DataMgr.Player.SimulateFlowerLight.Light
    local sortNum=1;

    local isEnough=true;
    for i,v in ipairs(this.needList) do
        if this.dataLight[v.id]~=nil then
            if this.dataLight[v.id]<v.count then
                this.submitDic={};
                isEnough=false;
                break;
            end
            this.submitDic[v.id]={id=v.id,time=sortNum,count=v.count};
            sortNum=sortNum+1;
        else
            isEnough=false;
            break;
        end
    end
if not isEnough then
        local noEnoughCount=0;
        for i,v in ipairs(this.needList) do
            noEnoughCount=noEnoughCount+v.count
        end

        for i,v in ipairs(this.sortDataLightList) do
            if this.submitDic[v.id]==nil and v.count>0 then
                local count=noEnoughCount;
                if v.count<noEnoughCount then
                    count=v.count
                end
                this.submitDic[v.id]={id=v.id,time=sortNum,count=count};
                sortNum=sortNum+1;
                noEnoughCount=noEnoughCount-v.count;
            end
            if noEnoughCount<=0 then
                break;
            end
        end
    end
    if this.myBagViewModel~=nil then
        this.myBagViewModel:UpdateData(this.submitDic)
    end
    this.BagSelectCallBack(this.submitDic);
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