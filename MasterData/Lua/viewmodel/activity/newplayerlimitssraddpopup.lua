
local this = {
    vm = nil,
    data = {
goodsId = "",
choiceGoodsId = "",
    },
    leftgoodsItemTr1 = nil,
    leftgoodsItemTr2 = nil,
    rightgoodsItemTr = nil,
}

local data = {
    priceStr = "",
    desc = "",
    
    confirmPriceStr = "",
    cancelPriceStr = "",
}

local command = {
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.data.confirmCommand ~= nil then
                this.data.confirmCommand(this.data.goodsId)
            end
            LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAddPopup)
        end
    },
    cancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.data.cancelCommand ~= nil then
                this.data.cancelCommand(this.data.choiceGoodsId)
            end
            LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAddPopup)
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.data.cancelCommand ~= nil then
                this.data.cancelCommand(this.data.choiceGoodsId)
            end
            LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAddPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm

        this.templateItem = this.vm.behaviour.transform:Find("template/NewPlayerLimitSSRGoodsItem").gameObject
        this.leftgoodsItemTr1 = this.vm.behaviour.transform:Find("root/Middle/obj/Content/leftCharacter1"):GetComponent("RectTransform")
        this.leftgoodsItemTr2 = this.vm.behaviour.transform:Find("root/Middle/obj/Content/leftCharacter2"):GetComponent("RectTransform")
        this.rightgoodsItemTr = this.vm.behaviour.transform:Find("root/Middle/obj/Content/rightCharacter"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 2 then
            local characterId = vm.behaviour.Params[0]
            local otherCharacterId = vm.behaviour.Params[1]
            this.data.goodsId = vm.behaviour.Params[2]
            this.data.choiceGoodsId = vm.behaviour.Params[3]
            this.data.confirmCommand = vm.behaviour.Params[4]
            this.data.cancelCommand = vm.behaviour.Params[5]

            local heroConfig = ConfigMgr.Config.characterTable[characterId]
            local otherHeroConfig = ConfigMgr.Config.characterTable[otherCharacterId]
            this.vm.data.priceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.choiceGoodsId)
            this.vm.data.confirmPriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.goodsId)
            this.vm.data.cancelPriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.choiceGoodsId)
            this.vm.data.desc = ConfigMgr.LangGlobal("17501") .. LuaMgr.GetLangText(otherHeroConfig.namelan)
            
            local item = this.GetDefaultGoodsItem()
            item.goodsID = ""
            item.heroPic = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(heroConfig.id, heroConfig.id.."001"))
            item.name = LuaMgr.GetLangText(heroConfig.namelan)
            item.job = LuaMgr.GetSprite("JobIcon", "job_" .. heroConfig.job)
            item.isPage1 = true
            item.isActive = true
            local tempItem1 = NewPlayerLimitSSRGoodsItem.New(this.templateItem, this.leftgoodsItemTr1)
            tempItem1.transform.anchoredPosition = Vector2(0, 0);
            tempItem1:SetData(1, item)
            tempItem1:Show2()
            local tempItem2 = NewPlayerLimitSSRGoodsItem.New(this.templateItem, this.leftgoodsItemTr2)
            tempItem2.transform.anchoredPosition = Vector2(0, 0);
            tempItem2:SetData(1, item)
            tempItem2:Show2()

            local item2 = this.GetDefaultGoodsItem()
            item.goodsID = ""
            item.heroPic = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(otherHeroConfig.id, otherHeroConfig.id.."001"))
            item.name = LuaMgr.GetLangText(otherHeroConfig.namelan)
            item.job = LuaMgr.GetSprite("JobIcon", "job_" .. otherHeroConfig.job)
            item.isPage1 = true
            item.isActive = true
            local tempItem3 = NewPlayerLimitSSRGoodsItem.New(this.templateItem, this.rightgoodsItemTr)
            tempItem3.transform.anchoredPosition = Vector2(0, 0);
            tempItem3:SetData(1, item)
            tempItem3:Show2()
            
            LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRAddTimer, this.UpdateLeftTimer, 1, -1, true)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRAddTimer);
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

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

this.UpdateLeftTimer = function()
    local curTime = LuaMgr.Timestamp()
    local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[this.data.choiceGoodsId]
    if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
        local leftTime = goodsData.closeTime - curTime
        if leftTime < 0 then
            LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAddPopup)
        end
        return
    end
    LuaMgr.HidePanel(UIName.NewPlayerLimitSSRAddPopup)
end

return vm({
    data = data,
    command = command,
    hook = hook
})