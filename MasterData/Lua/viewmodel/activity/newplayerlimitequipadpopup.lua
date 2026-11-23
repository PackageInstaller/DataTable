
local this = {
    vm = nil,
    data = {
        goodsIdList = "",
        curIndex = 0,
        chargeId = "",
        isPaying = false,
        playAnim = false,
        attrItemShowIndex = 0,
        LevelUpImmedParam = nil,
    },
    rewardItemTrList = {},
    RewardItemTemp = nil,
    rewardContentTr = nil,
}

local data = {
    pageActive = false,
    goodsImg = DefaultTexture,

    isShowContent_1 = false,
    isShowContent_2 = false,
    isShowContent_3 = false,

    content_text_1 = "",
    leftTimeStr = "",
    
    goodsPriceStr = "",
    isShowLeftBtn = false,
    isShowRightBtn = false,
}

local command = {
    leftBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local newIndex = this.data.curIndex - 1
            if newIndex <= 0 then
                newIndex = 1
            end
            if newIndex == this.data.curIndex then
                return
            end
            this.data.curIndex = newIndex
            this.RefreshPage()
        end
    },
    rightBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local newIndex = this.data.curIndex + 1
            if newIndex > #this.data.goodsIdList then
                newIndex = #this.data.goodsIdList
            end
            if newIndex == this.data.curIndex then
                return
            end
            this.data.curIndex = newIndex
            this.RefreshPage()
        end
    },
    buyBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local choiceGoodsId = this.data.goodsIdList[this.data.curIndex]
if choiceGoodsId == NewPlayerLimitEquipMgr.EquipLockGoodsIDList[1] then
                LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitEquipAddPopup, false, function(goodsId)
                    this.OnClickGoodsBuy(goodsId)
                end);
            else
                this.OnClickGoodsBuy(choiceGoodsId)
            end
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAdPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.RewardItemTemp = this.vm.behaviour.transform:Find("root/Middle/obj/Info/ItemList/RewardItem").gameObject
        this.rewardContentTr = this.vm.behaviour.transform:Find("root/Middle/obj/Info/ItemList"):GetComponent("RectTransform")
        SetActive(this.RewardItemTemp, false)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.data.goodsIdList = {}
        this.data.curIndex = 1
        this.vm.data.pageActive = false
        this.RefreshData()
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        NewPlayerLimitEquipMgr.RefreshData()
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRAdTimer);
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer)
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRAdShowTimer)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.RefreshData = function()
    NewPlayerLimitEquipMgr.RefreshData()
    LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRAdTimer)
    local curTime = LuaMgr.Timestamp()
    local newGoodsId = {}

    for i, goodsId in ipairs(NewPlayerLimitEquipMgr.AllEquipUpgradeGoodsIDList) do
        if i ~= 2 then
            local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil then
                if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Hide and curTime > goodsData.openTime) or
                        (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing and NewPlayerLimitSSRMgr.GetGoodsDisplayTime(goodsId) == 0) then
                    table.insert(newGoodsId, goodsId)
                end
            end
            if #newGoodsId > 0 then
                break
            end
        end
    end

    function RefreshDataAndPage()
        NewPlayerLimitEquipMgr.RefreshData()
        for i, v in ipairs(newGoodsId) do
            table.insert(this.data.goodsIdList, v)
        end
        if this.CheckGoodsIdList() then
            this.RefreshPage()
            LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRAdTimer, this.UpdateLeftTimer, 1, -1, true)
        end
    end
    if #newGoodsId > 0 then
        ApiMgr.Request("set_goods_display_time", { GoodsID = newGoodsId}, true, function()
            NewPlayerLimitEquipMgr.isAddAdPageToPopupList = false
            RefreshDataAndPage()
        end, nil, true, true);
    else
        RefreshDataAndPage()
    end
end

this.CheckGoodsIdList = function()
    local curTime = LuaMgr.Timestamp()
    for i = #this.data.goodsIdList, 1, -1 do
        local goodsId = this.data.goodsIdList[i]
        local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
        if goodsData == nil or goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Close or goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Bought or
                (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing and curTime > goodsData.closeTime) then
            table.remove(this.data.goodsIdList, i)
        end
    end
    if #this.data.goodsIdList == 0 then
        LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAdPopup)
        return false
    end

    if this.data.curIndex > #this.data.goodsIdList then
        this.data.curIndex = 1
    end
    return true
end

this.RefreshPage = function()
    this.vm.data.pageActive = true
    this.SetPageInfo()
    this.SetRewardList()

    this.data.isPaying=false;
    this.data.chargeId=nil;
    this.vm.data.goodsPriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.goodsIdList[this.data.curIndex])
    this.vm.data.isShowLeftBtn = this.data.curIndex > 1
    this.vm.data.isShowRightBtn = this.data.curIndex < #this.data.goodsIdList
    NewPlayerLimitEquipMgr.isAddPageToPopupList = false
end

this.SetPageInfo = function()
    for i, goodsId in ipairs(NewPlayerLimitEquipMgr.AllEquipUpgradeGoodsIDList) do
        if goodsId == this.data.goodsIdList[this.data.curIndex] then
            if i <= 3 then
                this.vm.data.isShowContent_1 = true
                this.vm.data.isShowContent_2 = false
                this.vm.data.goodsImg = LuaMgr.GetTexture("Images/NewPlayerLimitEquip/ui_plt_xsth2_lb_lbt_01.png")
            else
                this.vm.data.isShowContent_1 = false
                this.vm.data.isShowContent_2 = true
                this.vm.data.goodsImg = LuaMgr.GetTexture("Images/NewPlayerLimitEquip/ui_plt_xsth2_lb_lbt_02.png")
            end
            
            local _cfgChargeMap= ConfigMgr.Config.charge
            local charge=_cfgChargeMap[goodsId];
            if charge ~= nil and charge.Reward ~= nil then
                local itemConfig = ConfigMgr.Config.itemMap[charge.Reward[1].id]
                this.vm.data.content_text_1 = LuaMgr.GetLangText(itemConfig.nameLan)
            end
        end
    end
end   

this.SetRewardList = function()
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[this.data.goodsIdList[this.data.curIndex]];
    if charge == nil or charge.Reward == nil then
        return
    end

    local index = 1
    for i,v in ipairs(charge.Reward) do
        local goodsItem = nil
        if this.rewardItemTrList[i] == nil then
            local obj = LuaMgr.InstantiateGO(this.RewardItemTemp, this.rewardContentTr, false)
            SetActive(obj, false)
            this.rewardItemTrList[i] = GoodsDataItem.New(obj.transform)
        end
        SetActive(this.rewardItemTrList[i].transform.parent.gameObject,true)
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        itemConfig["count0"] = v.count
        this.rewardItemTrList[i]:SetData(1, itemConfig, 1, false, Vector3(0.8, 0.8, 0.8), false)
        index = index + 1
    end
    for i = index, #this.rewardItemTrList do
        SetActive(this.rewardItemTrList[i].transform.parent.gameObject,false)
    end
end

this.UpdateLeftTimer = function()
    local curTime = LuaMgr.Timestamp()
    for i = #this.data.goodsIdList, 1, -1 do
        local goodsId = this.data.goodsIdList[i]
        local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
        if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
            local leftTime = goodsData.closeTime - curTime
            if leftTime < 0 then
                LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAdPopup)
                break
            else
                this.vm.data.leftTimeStr = LuaMgr.GetLangText("NewPlayerLimitSSRAdPopup_5") .. this.GetLeftTimeText(leftTime)
            end
        end
    end
end

this.GetLeftTimeText = function(leftTime)
    local timeStr = "%s : %s : %s"
    if leftTime < 0 then
        return timeStr
    end
    local h, m, s = GetTimeHMS(leftTime)
    return string.format(timeStr, h, m, s)
end

this.OnClickGoodsBuy = function(goodsId)
    if this.data.isPaying then
        return
    end
    this.data.isPaying = true
    this.data.chargeId = goodsId
    LuaMgr.LuaOnAskPay(goodsId);
end

this.PayOrder=function(data)
    if data.Length==2 then
        local reChargeId=tostring(data[0]);
        this.data.order=tostring(data[1]);
        if this.data.chargeId ~= reChargeId then return end;
        if LuaMgr.GetPlatform()~="EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer)
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer,this.OnTimer,1,100,true);
    end
end

this.OnPayResult=function(data)
    if data.Length==1 then
        if this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        this.data.isPaying=false;
    end
end

this.OnPaySuccess=function(data)
    if data.Length==1 then
        if this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAdPopup)
    end
end

this.OnTimer=function()
    local askData={order=this.data.order}
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re=json.decode(result);
        if re.result.status==2 then
            LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer)
            local rewards=re.result.rewards;
            if rewards~=nil then
                local data=json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end
            LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAdPopup)
        end

    end, nil, true);
end

return vm({
    data = data,
    command = command,
    hook = hook
})