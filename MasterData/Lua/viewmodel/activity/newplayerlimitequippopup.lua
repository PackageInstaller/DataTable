require("ViewModel/Activity/NewPlayerLimitEquipGoodsItem")

local this = {
    vm = nil,
    data = {
        page1GoodsItems = {},
        page1GoodsItemDatas = { {} },
        page2GoodsItems = {},
        page2GoodsItemDatas = { {} },
        isPage1Open = false,
        isPage2Open = false,
        isShowPage1 = false,
        page1ChoiceIndex = 0,
        allWaitShowGoodsId = {},
        chargeId = "",
        isPaying = false,
        LevelUpImmedParam = nil,
        showIndex = 0,
        shouldPlayShowAnim = false,
    },
    characterGoodsContent = nil,
    page2Content = nil,
}

local data = {
    page1LeftTimeStr = "",
    page1PriceStr = "",
    page1TitleImg = DefaultSprite,
    isShowPage1 = false,
    isShowPage2 = false,
    isShowLeftBtn = false,
    isShowRightBtn = false,
    isShowPoint = false,
    pointLight_1 = false,
    pointLight_2 = false,
}

local command = {
    leftBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.data.isShowPage1 = not this.data.isShowPage1
            this.data.shouldPlayShowAnim = true
            this.RefreshPageStatus()
        end
    },
    rightBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.data.isShowPage1 = not this.data.isShowPage1
            this.data.shouldPlayShowAnim = true
            this.RefreshPageStatus()
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.NewPlayerLimitEquipPopup)
        end
    },

    page1GoodsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            this.OnChoicePage1Goods(index)
        end
    },
    
    page1BuyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local choiceGoodsId = this.data.page1GoodsItemDatas[this.data.page1ChoiceIndex].goodsID

            if this.data.isShowPage1 then
                local curChoiceIndex, otherChoiceIndex, boughtIndex = 0, 0, 0
                local needShowAddPopup = false
                local twoEquipGoodsId = ""
                for index, goodsList in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
                    for i, v in ipairs(goodsList) do
                        if v == choiceGoodsId then
                            needShowAddPopup = i == 2
                            curChoiceIndex = index
                        end

                        if i == 1 and NewPlayerLimitSSRMgr.IsBoughtGoods(v) then
                            twoEquipGoodsId = goodsList[4]
                            boughtIndex = index
                        end
                    end
                end
                if needShowAddPopup then
                    for i, v in ipairs(ConfigMgr.Config.constants.NewPlayerJumpWeaponId) do
                        if i ~= curChoiceIndex and i ~= boughtIndex then
                            otherChoiceIndex = i
                        end
                    end
                    local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[twoEquipGoodsId]
                    if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
                        LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitEquipAddPopup, this.data.isShowPage1, curChoiceIndex, otherChoiceIndex, choiceGoodsId, twoEquipGoodsId, function(goodsId)
                            this.OnClickGoodsBuy(goodsId)
                        end);
                    end
                else
                    this.OnClickGoodsBuy(choiceGoodsId)
                end
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.characterGoodsContent = vm.behaviour.transform:Find("root/Middle/obj/page_1/CharacterList"):GetComponent("RectTransform");
        this.page2Content = vm.behaviour.transform:Find("root/Middle/obj/page_2/Scroll View/Viewport/Content"):GetComponent("RectTransform");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.Init()
        this.RefreshPage()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        NewPlayerLimitEquipMgr.RefreshData()
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRTimer);
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer)
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRShowTimer)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.NewPlayerLimitSSRRefresh,this.RefreshPage);
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.Init = function()
    this.data.isShowPage1 = true
    this.data.page1ChoiceIndex = 1
    this.data.shouldPlayShowAnim = true
    NewPlayerLimitEquipMgr.firstShowNewPlayerLimitEquipPopup = false
    LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
    LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
    LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
    LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
    LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
    LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
    LuaMgr.RemoveUIEventListener(UIEventConst.NewPlayerLimitSSRRefresh,this.RefreshPage);
    LuaMgr.AddUIEventListener(UIEventConst.NewPlayerLimitSSRRefresh, this.RefreshPage)
end

this.RefreshPage = function()
    NewPlayerLimitEquipMgr.RefreshData()
    this.data.allWaitShowGoodsId = {}
    this.data.isPaying=false;
    this.data.chargeId=nil;
this.RefreshPage1()
this.RefreshPage2()

    if #this.data.allWaitShowGoodsId > 0 then
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRTimer)
        ApiMgr.Request("set_goods_display_time", { GoodsID = this.data.allWaitShowGoodsId}, true, function()
            NewPlayerLimitEquipMgr.isAddPageToPopupList = false
            this.RefreshPage()
        end, nil, true, true);
    else
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRTimer, this.UpdateLeftTimer, 1, -1, true)
    end
end

this.RefreshPage1 = function()
    this.data.page1GoodsItemDatas = {}
    local curShowIndex = 0
    for listIndex, goodsList in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
        local weaponId = ConfigMgr.Config.constants.NewPlayerJumpWeaponId[listIndex]
        local equipConfig = ConfigMgr.Config.equipments[weaponId]
        for i = 1, 3 do
            local goodsId = goodsList[i]
            local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil and (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing or goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow) then
                local item = this.GetDefaultGoodsItem()
                item.goodsID = goodsId
                item.weaponId = weaponId
                item.heroPic = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/NewPlayerLimitEquip/ui_plt_xsth2_zt%s.png", listIndex))
                item.name = LuaMgr.GetLangText(equipConfig.NameLan)
                item.desc = NewPlayerLimitEquipMgr.EquipItemDesc[listIndex]
                item.isPage1 = true
                item.onClick = this.OnChoicePage1Goods
                item.isActive = not this.data.shouldPlayShowAnim
                table.insert(this.data.page1GoodsItemDatas, item)

                if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or 
                        (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing and NewPlayerLimitSSRMgr.GetGoodsDisplayTime(goodsId) == 0) then
                    table.insert(this.data.allWaitShowGoodsId, goodsId)
                end
                curShowIndex = i
            end
        end

        local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsList[4]]
        if goodsData ~= nil then
            if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing and NewPlayerLimitSSRMgr.GetGoodsDisplayTime(goodsList[4]) == 0) then
                table.insert(this.data.allWaitShowGoodsId, goodsList[4])
            end
        end
    end

    if #this.data.page1GoodsItemDatas == 0 then
        return
    end
    this.vm.data.page1TitleImg = LuaMgr.GetSprite("NewPlayerLimitSSR", "ui_plt_xsth2_title_0" .. curShowIndex);
    if this.data.page1ChoiceIndex > #this.data.page1GoodsItemDatas then
        this.data.page1ChoiceIndex = 1
    end
    this.data.page1GoodsItemDatas[this.data.page1ChoiceIndex].isSelect = true
    local choiceGoodsId = this.data.page1GoodsItemDatas[this.data.page1ChoiceIndex].goodsID
    this.vm.data.page1PriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(choiceGoodsId)
    
    local index = 0
    for i, v in ipairs(this.data.page1GoodsItemDatas) do
        if i > #this.data.page1GoodsItems then
            local tempItem = NewPlayerLimitEquipGoodsItem.New(this.characterGoodsContent)
            table.insert(this.data.page1GoodsItems, tempItem)
        end
        local item = this.data.page1GoodsItems[i]
        item:SetData(i, v)
        item:Show()
        if not this.data.shouldPlayShowAnim then
            item:Show2()
        end
        index = i
    end
    for i = index + 1, #this.data.page1GoodsItems do
        this.data.page1GoodsItems[i]:Hide()
    end
end

this.RefreshPage2 = function()
    this.data.page2GoodsItemDatas = {}
    
    for listIndex, goodsId in ipairs(NewPlayerLimitEquipMgr.AllEquipUpgradeGoodsIDList) do
        if listIndex ~= 2 then
            local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
                local item = this.GetDefaultGoodsItem()
                item.goodsID = goodsId
                item.name = this.GetGoodsName(goodsId)
                if listIndex <= 3 then
                    item.heroPic = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/NewPlayerLimitEquip/ui_plt_xsth2_lb_txd.png"))
                else
                    item.heroPic = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/NewPlayerLimitEquip/ui_plt_xsth2_lb_txd_1.png"))
                end
                item.priceStr =  NewPlayerLimitSSRMgr.GetGoodsPriceStr(goodsId)
                item.onBuy = this.Page2BuyCommand
                item.isActive = not this.data.shouldPlayShowAnim
                table.insert(this.data.page2GoodsItemDatas, item)
            end
        end
    end
    
    if #this.data.page2GoodsItemDatas == 0 then
        return
    end

    local index = 0
    for i, v in ipairs(this.data.page2GoodsItemDatas) do
        if i > #this.data.page2GoodsItems then
            local tempItem = NewPlayerLimitEquipGoodsItem.New(this.page2Content)
            table.insert(this.data.page2GoodsItems, tempItem)
        end
        local item = this.data.page2GoodsItems[i]
        item:SetData(i, v)
        item:SetRewardItems()
        item:Show()
        if not this.data.shouldPlayShowAnim then
            item:Show2()
        end
        index = i
    end
    for i = index + 1, #this.data.page2GoodsItems do
        this.data.page2GoodsItems[i]:Hide()
    end
end

this.RefreshPageStatus = function()
    this.vm.data.isShowPoint = false
    this.vm.data.isShowLeftBtn = false
    this.vm.data.isShowRightBtn = false
    this.vm.data.isShowLeftBtn = false
    this.vm.data.isShowRightBtn = false
    if this.data.isPage1Open == true and this.data.isPage2Open == true then
        this.vm.data.isShowPoint = true
        this.vm.data.pointLight_1 = this.data.isShowPage1
        this.vm.data.pointLight_2 = not this.data.isShowPage1
        this.vm.data.isShowLeftBtn = not this.data.isShowPage1
        this.vm.data.isShowRightBtn = this.data.isShowPage1
    elseif this.data.isPage1Open == true and this.data.isPage2Open == false then
        this.data.isShowPage1 = true
    elseif this.data.isPage1Open == false and this.data.isPage2Open == true then
        this.data.isShowPage1 = false
    else
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRTimer);
        LuaMgr.HidePanel(UIName.NewPlayerLimitEquipPopup)
    end

    if this.data.shouldPlayShowAnim then
        this.data.showIndex = 1
        this.data.shouldPlayShowAnim = false
        local itemList = nil
        if this.data.isShowPage1 then
            itemList = this.data.page1GoodsItems
        else
            itemList = this.data.page2GoodsItems
        end
        for i, v in ipairs(itemList) do
            v:Hide2()
        end
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRShowTimer, this.OnGoodsItemShow, 0.05, -1, false)
    end
    this.vm.data.isShowPage1 = this.data.isShowPage1
    this.vm.data.isShowPage2 = not this.data.isShowPage1
end

this.UpdateLeftTimer = function()
    local curTime = LuaMgr.Timestamp()

    this.data.isPage1Open = false
    this.data.isPage2Open = false
    local needRefresh = false

    for listIndex, goodsList in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
        for needShowAddPopup = 1, #goodsList do
            local goodsId = goodsList[needShowAddPopup]
            local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
                local leftTime = goodsData.closeTime - curTime 
                if leftTime < 0 then
                    needRefresh = true
                    break
                end
                this.data.isPage1Open = true
                this.vm.data.page1LeftTimeStr = LuaMgr.GetLangText("NewPlayerLimitSSRPopup_1") .. this.GetLeftTimeText(leftTime)
            end
        end
        if needRefresh then
            break
        end
    end

    for i, goodsId in ipairs(NewPlayerLimitEquipMgr.AllEquipUpgradeGoodsIDList) do
        local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
        if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
            local leftTime = goodsData.closeTime - curTime
            if leftTime < 0 then
                needRefresh = true
                break
            end
            this.data.isPage2Open = true
            for i, v in ipairs(this.data.page2GoodsItems) do
                if v.data.goodsID == goodsId then
                    v:SetTimerStr(this.GetLeftTimeText(leftTime))
                end
            end
        end
        if needRefresh then
            break
        end
    end

    if needRefresh then
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRTimer)
        this.RefreshPage()
        return
    end
    
    this.RefreshPageStatus()
end

this.OnChoicePage1Goods = function(index)
    if this.data.page1ChoiceIndex == index then
        return
    end
    
    this.data.page1ChoiceIndex = index
    this.RefreshPage1()
end

this.Page2BuyCommand = function(goodsId)
if goodsId == NewPlayerLimitEquipMgr.EquipLockGoodsIDList[1] then
        LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitEquipAddPopup, this.data.isShowPage1, function(goodsId)
            this.OnClickGoodsBuy(goodsId)
        end);
    else
        this.OnClickGoodsBuy(goodsId)
    end
end

this.OnClickGoodsBuy = function(goodsId)
    if this.data.isPaying then
        return
    end
    this.data.isPaying = true
    this.data.chargeId = goodsId
    LuaMgr.LuaOnAskPay(goodsId);
end

this.GetLeftTimeText = function(leftTime)
    local timeStr = "%s : %s : %s"
    if leftTime < 0 then
        return timeStr
    end
    local h, m, s = GetTimeHMS(leftTime)
    return string.format(timeStr, h, m, s)
end

this.GetGoodsName = function(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    return LuaMgr.GetLangText(charge.NameLan)
end

this.GetDefaultGoodsItem = function()
    return {
        goodsID = "",
        weaponId = "",
        name = "",
        desc = "",
        leftTimeStr = "",
        priceStr = "",
        heroPic = nil,
        isSelect = false,
        onClick = nil,
        onBuy = nil,
        isPage1 = false,
        isActive = false,
    }
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
        this.data.isPaying=false;
        this.RefreshPage();
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

            this.data.isPaying=false;
            this.RefreshPage();
        end

    end, nil, true);
end

this.OnGoodsItemShow = function()
    this.data.shouldPlayShowAnim = false
    if this.data.showIndex <= 0 then
        this.data.showIndex = this.data.showIndex + 1
        return
    end
    local itemList = nil
    local len = 0
    if this.data.isShowPage1 then
        itemList = this.data.page1GoodsItems
        len = #this.data.page1GoodsItemDatas
    else
        itemList = this.data.page2GoodsItems
        len = #this.data.page2GoodsItemDatas
    end
    if this.data.showIndex > len then
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRShowTimer)
        return
    end
    itemList[this.data.showIndex]:PlayAnim()
    this.data.showIndex = this.data.showIndex + 1
end

return vm({
    data = data,
    command = command,
    hook = hook
})