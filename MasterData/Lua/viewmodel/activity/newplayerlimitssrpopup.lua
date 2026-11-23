require("ViewModel/Activity/NewPlayerLimitSSRGoodsItem")

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
    templateItem = nil,
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
            LuaMgr.HidePanel(UIName.NewPlayerLimitSSRPopup)
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

            local curBuyIndex, boughtIndex, goodsIndex = 0, 0, 0
            local twoCharacterGoodsId, characterId, otherCharacterId = "", "", ""
            for index, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
                for i, v in ipairs(goodsList) do
                    if v == choiceGoodsId then
                        goodsIndex = i
                        curBuyIndex = index
                    end

                    if i == 1 and NewPlayerLimitSSRMgr.IsBoughtGoods(v) then
                        twoCharacterGoodsId = goodsList[7]
                        boughtIndex = index
                    end
                end
            end
            for i, v in ipairs(ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList) do
                if i == curBuyIndex then
                    characterId = v
                end
                if i ~= curBuyIndex and i ~= boughtIndex then
                    otherCharacterId = v
                end
            end
            if goodsIndex == 2 then
                local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[twoCharacterGoodsId]
                if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
                    LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitSSRAddPopup, characterId, otherCharacterId, twoCharacterGoodsId, choiceGoodsId, function()
                        this.OnClickGoodsBuy(twoCharacterGoodsId)
                    end, function()
                        this.OnClickGoodsBuy(choiceGoodsId)
                    end);
                end
            else
                this.OnClickGoodsBuy(choiceGoodsId)
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.characterGoodsContent = vm.behaviour.transform:Find("root/Middle/obj/page_1/CharacterList"):GetComponent("RectTransform");
        this.page2Content = vm.behaviour.transform:Find("root/Middle/obj/page_2/Scroll View/Viewport/Content"):GetComponent("RectTransform");
        this.templateItem = this.vm.behaviour.transform:Find("template/NewPlayerLimitSSRGoodsItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.Init()
        if not NewPlayerLimitSSRMgr.CheckActivityIsShown() then
            ApiMgr.Request("set_purchase_event_time",{},true,function(re)
                this.RefreshPage()
            end,nil,true)
        else
            this.RefreshPage()
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        NewPlayerLimitSSRMgr.RefreshData()
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRTimer);
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRCheckStatusTimer)
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRShowTimer)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.NewPlayerLimitSSRRefresh,this.RefreshPage);
        LuaMgr.RemoveUIEventListener(UIEventConst.ClosePopPanel, this.ClosePopPanel);
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.Init = function()
    this.data.isShowPage1 = true
    this.data.page1ChoiceIndex = 1
    this.data.shouldPlayShowAnim = true
    NewPlayerLimitSSRMgr.firstShowNewPlayerLimitSSRPopup = false
    LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
    LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
    LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
    LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
    LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
    LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
    LuaMgr.RemoveUIEventListener(UIEventConst.NewPlayerLimitSSRRefresh,this.RefreshPage);
    LuaMgr.AddUIEventListener(UIEventConst.NewPlayerLimitSSRRefresh, this.RefreshPage)
    LuaMgr.RemoveUIEventListener(UIEventConst.ClosePopPanel, this.ClosePopPanel);
    LuaMgr.AddUIEventListener(UIEventConst.ClosePopPanel, this.ClosePopPanel);
end

this.RefreshPage = function()
    NewPlayerLimitSSRMgr.RefreshData()
    this.data.allWaitShowGoodsId = {}
    this.data.isPaying=false;
    this.data.chargeId=nil;
this.RefreshPage1()
this.RefreshPage2()

    if #this.data.allWaitShowGoodsId > 0 then
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRTimer)
        ApiMgr.Request("set_goods_display_time", { GoodsID = this.data.allWaitShowGoodsId}, true, function()
            NewPlayerLimitSSRMgr.isAddPageToPopupList = false
            this.RefreshPage()
        end, nil, true, true);
    else
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRTimer, this.UpdateLeftTimer, 1, -1, true)
    end
end

this.RefreshPage1 = function()
    this.data.page1GoodsItemDatas = {}
    local curShowGoodsIndex = 0
    for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
        local characterId = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[listIndex]
        local heroConfig = ConfigMgr.Config.characterTable[characterId]
        local heroData = DataMgr.Player.characters[characterId]
        for i = 1, 3 do
            local goodsId = goodsList[i]
            local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil and (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing or goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow) then
                local item = this.GetDefaultGoodsItem()
                item.goodsID = goodsId
                item.heroPic = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(heroConfig.id, heroConfig.id.."001"))
                item.name = LuaMgr.GetLangText(heroConfig.namelan)
                item.job = LuaMgr.GetSprite("JobIcon", "job_" .. heroConfig.job)
                item.isPage1 = true
                item.shwoHasItem = true
                item.hasItem = heroData ~= nil
                item.onClick = this.OnChoicePage1Goods
                item.isActive = not this.data.shouldPlayShowAnim
                table.insert(this.data.page1GoodsItemDatas, item)

                if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or 
                        (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing and NewPlayerLimitSSRMgr.GetGoodsDisplayTime(goodsId) == 0) then
                    table.insert(this.data.allWaitShowGoodsId, goodsId)
                end
                curShowGoodsIndex = i
            end
        end

        local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[goodsList[7]]
        if goodsData ~= nil then
            if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing and NewPlayerLimitSSRMgr.GetGoodsDisplayTime(goodsList[7]) == 0) then
                table.insert(this.data.allWaitShowGoodsId, goodsList[7])
            end
        end
    end

    if #this.data.page1GoodsItemDatas == 0 then
        return
    end
    this.vm.data.page1TitleImg = LuaMgr.GetSprite("NewPlayerLimitSSR", "ui_plt_xsth_title_0" .. curShowGoodsIndex);
    if this.data.page1ChoiceIndex > #this.data.page1GoodsItemDatas then
        this.data.page1ChoiceIndex = 1
    end
    this.data.page1GoodsItemDatas[this.data.page1ChoiceIndex].isSelect = true
    local choiceGoodsId = this.data.page1GoodsItemDatas[this.data.page1ChoiceIndex].goodsID
    this.vm.data.page1PriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(choiceGoodsId)
    
    local index = 0
    for i, v in ipairs(this.data.page1GoodsItemDatas) do
        if i > #this.data.page1GoodsItems then
            local tempItem = NewPlayerLimitSSRGoodsItem.New(this.templateItem, this.characterGoodsContent)
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
    for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
        local heroConfig = ConfigMgr.Config.characterTable[ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[listIndex]]
        for i = 4, 6 do
            local goodsId = goodsList[i]
            local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
                local item = this.GetDefaultGoodsItem()
                local skin = this.GetGoodsSkin(listIndex, i, heroConfig)
                item.goodsID = goodsId
                item.heroPic = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(heroConfig.id, skin))
                item.name = this.GetGoodsName(goodsId)
                item.priceStr =  NewPlayerLimitSSRMgr.GetGoodsPriceStr(goodsId)
                item.onBuy = this.OnClickGoodsBuy
                item.isActive = not this.data.shouldPlayShowAnim
                if i == 4 then
                    item.level = 70
                    item.showUpIcon = true




                end
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
            local tempItem = NewPlayerLimitSSRGoodsItem.New(this.templateItem, this.page2Content)
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
        LuaMgr.HidePanel(UIName.NewPlayerLimitSSRPopup)
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

    for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
        for goodsIndex = 1, #goodsList do
            local goodsId = goodsList[goodsIndex]
            local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
                local leftTime = goodsData.closeTime - curTime 
                if leftTime < 0 then
                    needRefresh = true
                    break
                end
if goodsIndex == 1 or goodsIndex == 2 or goodsIndex == 3 or goodsIndex == 7 then
                    this.data.isPage1Open = true
                    this.vm.data.page1LeftTimeStr = LuaMgr.GetLangText("NewPlayerLimitSSRPopup_1") .. this.GetLeftTimeText(leftTime)
else
                    this.data.isPage2Open = true
                    for i, v in ipairs(this.data.page2GoodsItems) do
                        if v.data.goodsID == goodsId then
                            v:SetTimerStr(this.GetLeftTimeText(leftTime))
                        end
                    end
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

this.GetHeroGroupIndex = function(index)
    local characterID = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[index]
    return NewPlayerLimitSSRMgr.CharacterGoodsPurchaseTimeSortMap[characterID]
end

this.GetGoodsName = function(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    return LuaMgr.GetLangText(charge.NameLan)
end

this.GetGoodsSkin = function(listIndex, goodsIndex, heroConfig)
    local skinTable = ConfigMgr.Config.characterSkins[heroConfig.id]
    local skin = skinTable[1]
    if goodsIndex == 4 then
        for i = 1, #skinTable do
            if skinTable[i].skinType == 2 then
                skin = skinTable[i].skinID
                break
            end
        end
    elseif goodsIndex == 5 then
        for i = 1, #skinTable do
            if skinTable[i].skinType == 1 then
                skin = skinTable[i].skinID
                break
            end
        end
    elseif goodsIndex == 6 then
        skin = ConfigMgr.Config.constants.NewPlayerLimitSSR6Skin[listIndex]
    end
    return skin
end

this.GetDefaultGoodsItem = function()
    return {
        goodsID = "",
        name = "",
        zzStr = "",
        level = 0,
        leftTimeStr = "",
        priceStr = "",
        heroPic = nil,
        job = nil,
        isSelect = false,
        onClick = nil,
        onBuy = nil,
        isPage1 = false,
        showUpIcon = false,
        shwoHasItem = false,
        hasItem = false,
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
        if not this.CheckRewardIsLevelUpImmed(this.data.chargeId) then
            this.data.isPaying=false;
            this.RefreshPage();
        end
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
            if not this.CheckRewardIsLevelUpImmed(this.data.chargeId) then
                this.RefreshPage();
            end
        end

    end, nil, true);
end

this.CheckRewardIsLevelUpImmed = function(chargeId)
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[chargeId];
    if charge.Reward == nil then
        return false
    end

    local index = 1
    for i,v in ipairs(charge.Reward) do
        local itemId = v.id
        local itemConfig = ConfigHelper.GetItemById(itemId)
        if itemConfig ~= nil and itemConfig.UseType ~= nil and itemConfig.UseType == "4" then
            for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
                for goodsIndex = 1, #goodsList do
                    local goodsId = goodsList[goodsIndex]
                    if goodsId == chargeId then
                        local characterId = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[listIndex]
                        local itemCharacterUp = ConfigMgr.Config.ItemsCharacterUp[itemId];
                        if (itemCharacterUp ~= nil) then
                            local obj = {characterId = characterId, itemId = itemId};
                            local objStr = json.encode(obj);
                            this.data.LevelUpImmedParam = {
                                characterId = characterId,
                                itemCharacterUp = itemCharacterUp,
                                objStr = objStr
                            }
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

this.ClosePopPanel = function(data)
    if this.data.LevelUpImmedParam == nil then
        return
    end
    local popName = tostring(data[0])
    if popName == UIName.ItemGetViewModel then
        LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", this.data.LevelUpImmedParam.characterId, nil, 
                this.data.LevelUpImmedParam.itemCharacterUp.Level, this.data.LevelUpImmedParam.itemCharacterUp.Talent, this.data.LevelUpImmedParam.objStr);
        this.data.LevelUpImmedParam = nil
        this.RefreshPage();
    end
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