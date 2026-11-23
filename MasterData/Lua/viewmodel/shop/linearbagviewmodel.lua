
local this = {
    vm=nil,
    data = {
        paying=false;
        order=nil;
        showSecondBuyFunc = nil,
        shelfId = "",
        endTime = 0,
    },
    bagDataList = {},
    giftList = {},
};

local data = {
    BagList = {
        {
            index = 0,
            indexStr = "",
            anchoredPos = Vector2.zero,
            showBg = false,
            showFreeBg = false,
            priceStr = "",
            isCanGet = false,
            isFinish = false,
            isLock = false,
            goodsSprite = DefaultSprite,
            goodsIconAlpha = 1.0,
            showArrow = false,
        }
    },
    leftTimeStr = "",
}

local command = {
    LinearBagBuyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            local goodsData = this.bagDataList[index].goodsData
            if this.vm.data.BagList[index].isCanGet then
                this.data.paying=true;
                local goods = this.bagDataList[index].goodsData
                this.data.chargeId = goods.Id
                if goods.BuyWay == 1 then
                    LuaMgr.LuaOnAskPay(this.data.chargeId);
                elseif goods.BuyWay == 0 then
                    LuaDebug.error("buyWay==0 is Error,giftShop not contains buyWay ==0");
                    this.data.paying=false;
                elseif goods.BuyWay == 2 then
                    this.ShopDirectBuy()
                end
            elseif this.vm.data.BagList[index].isFinish or this.vm.data.BagList[index].isLock then
                this.data.showSecondBuyFunc(goodsData, true)
            else
                this.data.showSecondBuyFunc(goodsData)
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        if vm.behaviour.Params.Length > 0 then
            this.giftList = ConfigHelper.CheckGiftListByTime(vm.behaviour.Params[0])
        end

        if vm.behaviour.Params.Length > 1 then
            this.data.showSecondBuyFunc = vm.behaviour.Params[1]
        end

        this.ParseData()
        
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.ShopGiftBuyEditorSuccess,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.ShopGiftBuyEditorSuccess,this.FrushData);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
    end,

    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        LuaMgr.RemoveUIEventListener(UIEventConst.ShopGiftBuyEditorSuccess,this.FrushData);
        LuaMgr.RemoveTimer(TimerConst.LinearBagLeftTimer);
    end,

    before_destroy = function(vm)
        this = nil
    end,
}

this.InitData = function()
    this.bagDataList = {}
    local _cfgChargeMap= ConfigMgr.Config.charge
    
    for i,v in ipairs(this.giftList) do
        local charge = _cfgChargeMap[v.Id];
        local data = {
            isBought = charge.RefreshCount-DataHelper.GetShopRecordByGoodsId(v.Id)<=0,
            cfg = this.GetLinearCfgByChargeId(v.Id),
            goodsData = v,
        }
        table.insert(this.bagDataList, data)
        this.data.shelfId = v.Shelf
    end
    table.sort(this.bagDataList, function(a, b) 
        return a.cfg.ID < b.cfg.ID
    end)
    for i, v in ipairs(this.bagDataList) do
        v.index = i
        v.anchoredPos = i <= 5 and Vector2(24 + (i - 1) * 176, -31) or Vector2(74.6 + (i - 6) * 176, -241)
    end

    if not IsNullOrEmpty(this.data.shelfId) then
        local _cfgGiftShop= ConfigMgr.Config.shop[ShopType.Gift]
        for i,v in ipairs(_cfgGiftShop.shelfs) do
            if v.Id == this.data.shelfId then
                this.data.endTime = v.EndTime
                break
            end
        end
    end
end

this.ParseData = function()
    this.InitData()
    this.data.paying=false;
    this.data.chargeId=nil;
    local tempList = {}
    for i, v in ipairs(this.bagDataList) do
        local isLock = i ~= 1 and not this.bagDataList[i - 1].isBought
        local isFree = v.cfg.Type == 0
        local priceStr = ""
        if not v.isBought then
            priceStr = isFree and LuaMgr.GetLangText("LinearBagViewModel_2") or ConfigHelper.GetGoodsPriceStr(v.cfg.ChargeId)
        end
        local bagItem = {
            index = i,
            indexStr = tostring(i),
            anchoredPos = v.anchoredPos,
            showBg = not isFree,
            showFreeBg = isFree,
            priceStr = priceStr,
            isCanGet = isFree and not isLock and not v.isBought,
            isFinish = v.isBought,
            isLock = isLock,
            goodsSprite = LuaMgr.GetSprite("Shop","ui_xxlb_lb"..v.index),
            goodsIconAlpha = (isLock or v.isBought) and 0.6 or 1.0,
            showArrow = i < 10,
        }
        table.insert(tempList, bagItem)
    end
    
    this.vm.data.BagList = tempList
    
    LuaMgr.RemoveTimer(TimerConst.GiftRemainTime)
    LuaMgr.AddTimer(TimerConst.GiftRemainTime,this.OnLeftTimer,1,-1,true);
end

this.CheckIsLock = function(index, list)
    if index == 0 then
        return false
    end
    return DataHelper.GetShopRecordByGoodsId(list[index - 1].chargeId) == 0;
end

this.GetLinearCfgByChargeId = function(chargeId)
    local linearBagCfg = nil
    local linearBagCfgs = ConfigMgr.Config.LinearBagMap
    for k, v in pairs(linearBagCfgs) do
        if v.ChargeId == chargeId then
            linearBagCfg = v
            break
        end
    end
    return linearBagCfg
end


this.ShopDirectBuy=function()
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[this.data.chargeId]

    if charge==nil then
        this.data.paying=false;
        return
    end

    if charge.UnlockLv>0 and DataMgr.Player.level<charge.UnlockLv then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ShopGiftViewModel_3"))
        this.data.paying=false;
        return;
    end

    if DataHelper.GetItemCountById(charge.Cost.id)<charge.Cost.count then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ShopGiftViewModel_4"))
        this.data.paying=false;
        return;
    end

    local askData={goods=this.data.chargeId}
    ApiMgr.Request("shop/direct_buy",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        HeroRedDataHelper.FrushMainShopRed();
        this.ParseData();
    end,function()
        this.data.paying=false;
    end,true);

end

this.FrushData=function()
    this.ParseData();
end

this.PayOrder=function(data)
    if data.Length==2 then
        local reChargeId=tostring(data[0]);
        this.data.order=tostring(data[1]);
        if this.data.chargeId~=reChargeId then return end;
        if LuaMgr.GetPlatform()~="EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus,this.OnTimer,1,100,true);
    end
end

this.OnPayResult=function(data)
    if data.Length==1 then
        if this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        this.data.paying=false;
    end
end

this.OnPaySuccess=function(data)
    if this.data.paying and data.Length==1 and this.data.order~=nil and this.data.order~=tostring(data[0]) then
        return
    end
    this.ParseData();
end

this.OnTimer=function()
    local askData={order=this.data.order}
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re=json.decode(result);
        if re.result.status==2 then
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            local rewards=re.result.rewards;
            if rewards~=nil then
                local data=json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end

            SetActive(goSecondBuyPanel,false);
            this.data.paying=false;
            this.ParseData();
        end

    end, nil, true);
end

this.OnLeftTimer = function()
    if this == nil or this.data == nil then
        return
    end
    local leftTime = this.data.endTime - LuaMgr.Timestamp()
    if leftTime < 0 then
        LuaMgr.RemoveTimer(TimerConst.GiftRemainTime)
        LuaMgr.HidePanel(UIName.LinearBagViewModel)
        LuaMgr.InvokeUIEventListeners(UIEventConst.ShopGiftPanelRefresh);
        return
    end

    local d, h, m = GetTimeDHM2(leftTime)
    d = d <= 0 and "0" or tostring(d)
    h = h < 10 and "0" .. h or tostring(h)
    m = m < 10 and "0" .. m or tostring(m)
    this.vm.data.leftTimeStr = string.format(LuaMgr.GetLangText("LinearBagViewModel_1"),d,h,m)
end

return vm({
    data = data,
    command = command,
    hook = hook
})