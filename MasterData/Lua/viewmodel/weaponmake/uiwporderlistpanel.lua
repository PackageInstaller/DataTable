






local this = {
    vm = nil;
    data = {
        cfgCraftsman = nil,
        cfgCrdersTypes = nil,
        cfgAccelerateCost = nil,
        dataWeaponMade = nil,
        orderCatal = nil;
    };
    textNumObject=nil;
};

local data = {
    tpOrderList={
        {

            craftsName = "",
            craftsIcon = DefaultSprite,
            craftsJobIcon = DefaultSprite,
            craftsQt = DefaultSprite,
            orderTitleBg = DefaultSprite,
            orderRemainTime = "",
            orderSpendTime = 0,
            orderRemainTime_doing = false,
            orderRemainTime_done = false,
            orderState_active = false,
            orderState_free = false,
            orderState_lock = false,

            endTime = 0,
            orderDoing = false,
            orderDone = false,
            orderTransing = false,
            orderTextShows = false,
            orderWillTransing = false,
            orderTransDone = false,
            orderDoDes = "",
            orderTransDes = "",
            orderSlider = 0.0,
            qtSize = Vector2(0, 0),
        }
    },
toolsName="",
toolsImage=DefaultTexture,

}

local command = {

    onClickSpeedUpAllBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.data.orderCatal.orderDoing<=0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2013"].NameLan))
                return;
            end

            local count=this.data.cfgAccelerateCost.count* this.data.orderCatal.orderDoing;
            local mas1 = CS.System.String.Format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2473"].NameLan), count);
            local mas2 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2536"].NameLan);
            local mas3 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2475"].NameLan)

            LuaMgr.ShowPanel(UIName.ConfirmImageTextViewModel, this.data.cfgAccelerateCost.id, mas1, mas2, mas3,function()
                this.OnAskAcceslerateOrder("*")
            end,nil);
        end
    },

    onClickHarvestAllBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.data.orderCatal.orderDone<=0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2014"].NameLan))
                return;
            end
            this.OnAskHarvestOrder("*");
        end
    },

    backCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.UIWpOrderListPanel);
        end
    },

    onClickSpeedUpBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local orderId=this.data.dataWeaponMade.OrdersList[index].ID
            local data={};
            table.insert(data,{
                id=this.data.cfgAccelerateCost.id,
                count=this.data.cfgAccelerateCost.count;
            });
            local jsonData=json.encode(data);
            LuaMgr.ShowConfirmConsumeViewModel(LuaMgr.GetLangText("WeaponMakeViewModel_48"),jsonData,function()
                this.OnAskAcceslerateOrder(orderId)
            end,nil,nil);

        end
    },

    onClickHarvestBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local orderId=this.data.dataWeaponMade.OrdersList[index].ID
            this.OnAskHarvestOrder(orderId);
        end
    },

    orderLockBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2016"].NameLan))
        end
    },

    orderDoneBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.data.orderCatal.orderDone<=0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2014"].NameLan))
                return;
            end
            this.OnAskHarvestOrder("*");
        end
    },
toolsItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, "2501", true, false,false)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.WeaponMakeViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        if  vm.behaviour.Params.Length>0 then

        end
this.textNumObject=vm.behaviour.transform:Find("Middle/imgFrame/toolsImage/textNum"):GetComponent("Text");
        this.data.cfgCraftsman=ConfigMgr.Config.weaponMade.Craftsman;
        this.data.cfgCrdersTypes=ConfigMgr.Config.weaponMade.OrdersType;
        this.data.cfgAccelerateCost=ConfigMgr.Config.constants.WeaponOrdersAccCost;

        local item = ConfigHelper.GetItemById("2501")
        this.vm.data.toolsName= LuaMgr.GetLangText(item.nameLan);
        this.vm.data.toolsImage=LuaMgr.GetTexture("Assets/_BundleResources/Images/ItemIcons/itemicon_home_2501.png")
        local itemConfig=ConfigItemMgr.GetItemById("2501")
        local player=DataMgr.Player;
        this.textNumObject.text=player.items["2501"]==nil and "X 0" or "X "..LuaMgr.NumFormat(player.items["2501"].count0)

        this.ParseData();

        LuaMgr.AddDataEventListener(this.UpdateNum);
    end,
    
    before_deactive = function(vm)

        LuaMgr.RemoveDataEventListener(this.UpdateNum);
    end,

    before_destroy = function(vm)
        LuaMgr.RemoveTimer(TimerConst.WeaponMakeOrderTime);
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data = nil;
    end,
}

this.OnAskAcceslerateOrder=function(orderId)
    local askData={Orders=orderId};
    ApiMgr.Request("weaponmade/accelerate",askData,true,function(result)
        AudioMgr.Singleton:PlayUISFX(AudioNames.EItem_reward);
        this.ParseData();
    end,nil,true)
end

this.UpdateNum=function (args)
    local itemConfig=ConfigItemMgr.GetItemById("2501")
    local player=DataMgr.Player;
    this.textNumObject.text=player.items["2501"]==nil and "X 0" or "X "..LuaMgr.NumFormat(player.items["2501"].count0)
end

this.OnAskHarvestOrder=function(orderId)
    local askData={Orders=orderId};
    ApiMgr.Request("weaponmade/gather",askData,true,function(result)
        local re=json.decode(result);
        local rewards=json.encode(re.result.Reward)
        LuaMgr.ShowItemRewared(rewards);
        this.ParseData();

        if(this.data.orderCatal.orderDoing<=0 and this.data.orderCatal.orderDone<=0 )then
            LuaMgr.HidePanel(UIName.UIWpOrderListPanel);
        end
        
    end,nil,true)
end

this.SetPdOrderList=function()
    local orders=this.data.dataWeaponMade.OrdersList;
    local fundBuildingLevel_7=PlayerFoundationMgr.GetBuildingLevelByType(7)
    local unlockNum=ConfigMgr.Config.MakeUpGradeList[fundBuildingLevel_7].WaitNum;
    local list={}
    for i=1,5,1 do
        local orderItem={};
        if i<=#orders then
            local order=orders[i];
            local craftsman=this.data.cfgCraftsman[order.Craftsman];
            orderItem={

                craftsName =LuaMgr.GetLangText(craftsman.MasterNameLan),
                craftsIcon = LuaMgr.GetSprite("CraftsIcon",craftsman.MasterIcon),
                craftsJobIcon = LuaMgr.GetSprite("JobIcon","job_"..craftsman.MasterType),
                craftsQt = LuaMgr.GetSprite("WeaponMake","ui_wqzz_bq0"..craftsman.MasterClass),
                orderTitleBg = LuaMgr.GetSprite("WeaponMake","ui_wqzz_dd2_"..order.OrdersType),
                orderRemainTime = "",
                orderRemainTime_doing = false,
                orderRemainTime_done = false,

                orderSpendTime = craftsman.SpendTime*60,
                state = 0,
                orderState_active = true,
                orderState_free = false,
                orderState_lock = false,

                endTime = order.EndTime,
                orderDoing = false,
                orderDone = false,
                orderTransing = false,
                orderTextShows = false,
                orderWillTransing = false,
                orderTransDone = false,
                orderDoDes = "",
                orderTransDes = "",
                orderSlider = 0.0,
qtSize = order.OrdersType==1004 and Vector2(124, 34) or  Vector2(124, 28),
            }
        elseif i<= unlockNum then
            orderItem={
                orderState_active = false,
                orderState_free = true,
                orderState_lock = false,
            }
        else
            orderItem={
                orderState_active = false,
                orderState_free = false,
                orderState_lock = true,
            }
        end
        table.insert(list,orderItem);
    end
    this.vm.data.tpOrderList=list;
    LuaMgr.RemoveTimer(TimerConst.WeaponMakeOrderTime);
    LuaMgr.AddTimer(TimerConst.WeaponMakeOrderTime, this.RefrushOrder, 1, -1, true);
end

this.RefrushOrder=function()
    this.data.orderCatal={orderCount=5;
                          orderDoing=0;
                          orderDone=0;}
    for i,v in ipairs(this.vm.data.tpOrderList) do
        if v.orderState_active then
            local lastTime=v.endTime-LuaMgr.Timestamp();
            this.data.orderCatal.orderDoing=this.data.orderCatal.orderDoing+1;
            if lastTime>0 then
                v.orderRemainTime=string.format(LuaMgr.GetLangText("WeaponMakeViewModel_50"),math.floor(lastTime/3600),math.floor(lastTime%3600/60));
                v.orderDoing = lastTime>600;
                v.orderDone = lastTime<=600;
                v.orderTransing = lastTime<=600;
                v.orderTextShows = false;
                v.orderWillTransing = lastTime>600;
                v.orderTransDone = false;
                v.orderDoDes = lastTime<=600 and LuaMgr.GetLangText("WeaponMakeViewModel_51") or LuaMgr.GetLangText("WeaponMakeViewModel_52");
                v.orderTransDes = lastTime<=600 and LuaMgr.GetLangText("WeaponMakeViewModel_53") or LuaMgr.GetLangText("WeaponMakeViewModel_54");
                v.orderSlider =1-lastTime/v.orderSpendTime;
                v.orderRemainTime_doing=true;
                v.orderRemainTime_done=false;
            else
                v.orderRemainTime=LuaMgr.GetLangText("WeaponMakeViewModel_55");
                v.orderDoDes=LuaMgr.GetLangText("WeaponMakeViewModel_56");
                v.orderTransDes=LuaMgr.GetLangText("WeaponMakeViewModel_57");
                v.orderDone=true;
                v.orderWillTransing=false;
                v.orderTextShows=true;
                v.orderTransDone=true;
                v.orderRemainTime_doing=false;
                v.orderRemainTime_done=true;
                this.data.orderCatal.orderDone=this.data.orderCatal.orderDone+1;
                this.data.orderCatal.orderDoing=this.data.orderCatal.orderDoing-1;
            end

        end
    end
end

this.ParseData=function()
    this.data.dataWeaponMade=DataMgr.Player.weaponMade;
    this.SetPdOrderList();
end      

return vm({
    data = data,
    command = command,
    hook = hook
})