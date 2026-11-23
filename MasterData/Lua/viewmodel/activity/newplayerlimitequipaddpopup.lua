
local this = {
    vm = nil,
    data = {
addGoodsId = "",
choiceGoodsId = "",
        level3GoodsId = "",
        curChoiceIndex = 0,
        otherChoiceIndex = 0,
    },
    leftgoodsItemTr1 = nil,
    leftgoodsItemTr2 = nil,
    rightgoodsItemTr = nil,
}

local data = {
    priceStr_1 = "",
    priceStr_2 = "",
    priceStr_3 = "",
    desc = "",
    
    confirmPriceStr = "",
    cancelPriceStr = "",
}

local command = {
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.data.clickCommand ~= nil then
                this.data.clickCommand(this.data.addGoodsId)
            end
            LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAddPopup)
        end
    },
    cancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.data.clickCommand ~= nil then
                this.data.clickCommand(this.data.choiceGoodsId)
            end
            LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAddPopup)
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.data.clickCommand ~= nil then
                this.data.clickCommand(this.data.choiceGoodsId)
            end
            LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAddPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm

        this.leftgoodsItemTr1 = this.vm.behaviour.transform:Find("root/Middle/obj/Content/leftCharacter1"):GetComponent("RectTransform")
        this.leftgoodsItemTr2 = this.vm.behaviour.transform:Find("root/Middle/obj/Content/leftCharacter2"):GetComponent("RectTransform")
        this.rightgoodsItemTr = this.vm.behaviour.transform:Find("root/Middle/obj/Content/rightCharacter"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            local isPage1 = vm.behaviour.Params[0]
            if isPage1 then
                this.data.curChoiceIndex = vm.behaviour.Params[1]
                this.data.otherChoiceIndex = vm.behaviour.Params[2]
                this.data.choiceGoodsId = vm.behaviour.Params[3]
                this.data.addGoodsId = vm.behaviour.Params[4]
                this.data.clickCommand = vm.behaviour.Params[5]

                local choiceEquipId = ConfigMgr.Config.constants.NewPlayerJumpWeaponId[this.data.curChoiceIndex]
                local choiceEquipConfig = ConfigMgr.Config.equipments[choiceEquipId]
                local otherEquipId = ConfigMgr.Config.constants.NewPlayerJumpWeaponId[this.data.otherChoiceIndex]
                local otherEquipConfig = ConfigMgr.Config.equipments[otherEquipId]
                this.vm.data.priceStr_1 = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.choiceGoodsId)
                this.vm.data.priceStr_2 = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.choiceGoodsId)
                this.vm.data.priceStr_3 = NewPlayerLimitSSRMgr.GetGoodsPriceStr(NewPlayerLimitEquipMgr.EquipGoodsIDList[this.data.otherChoiceIndex][3])
                this.vm.data.confirmPriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.addGoodsId)
                this.vm.data.cancelPriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.choiceGoodsId)
                this.vm.data.desc = ConfigMgr.LangGlobal("17502") .. LuaMgr.GetLangText(otherEquipConfig.NameLan)

                local choiceGoodsItem = this.GetDefaultGoodsItem()
                choiceGoodsItem.goodsID = this.data.choiceGoodsId
                choiceGoodsItem.weaponId = choiceEquipId
                choiceGoodsItem.heroPic = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/NewPlayerLimitEquip/ui_plt_xsth2_zt%s.png", this.data.curChoiceIndex))
                choiceGoodsItem.name = LuaMgr.GetLangText(choiceEquipConfig.NameLan)
                choiceGoodsItem.desc = NewPlayerLimitEquipMgr.EquipItemDesc[this.data.curChoiceIndex]
                choiceGoodsItem.isPage1 = true
                choiceGoodsItem.isActive = true
                local tempItem1 = NewPlayerLimitEquipGoodsItem.New(this.leftgoodsItemTr1)
                tempItem1.transform.anchoredPosition = Vector2(0, 0);
                tempItem1:SetData(1, choiceGoodsItem)
                tempItem1:Show2()
                local tempItem2 = NewPlayerLimitEquipGoodsItem.New(this.leftgoodsItemTr2)
                tempItem2.transform.anchoredPosition = Vector2(0, 0);
                tempItem2:SetData(1, choiceGoodsItem)
                tempItem2:Show2()

                local addGoodsItem = this.GetDefaultGoodsItem()
                addGoodsItem.goodsID = this.data.addGoodsId
                addGoodsItem.weaponId = otherEquipId
                addGoodsItem.heroPic = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/NewPlayerLimitEquip/ui_plt_xsth2_zt%s.png", this.data.otherChoiceIndex))
                addGoodsItem.name = LuaMgr.GetLangText(otherEquipConfig.NameLan)
                addGoodsItem.desc = NewPlayerLimitEquipMgr.EquipItemDesc[this.data.otherChoiceIndex]
                addGoodsItem.isPage1 = true
                addGoodsItem.isActive = true
                local tempItem3 = NewPlayerLimitEquipGoodsItem.New(this.rightgoodsItemTr)
                tempItem3.transform.anchoredPosition = Vector2(0, 0);
                tempItem3:SetData(1, addGoodsItem)
                tempItem3:Show2()
            else
                this.data.clickCommand = vm.behaviour.Params[1]
                this.data.choiceGoodsId = NewPlayerLimitEquipMgr.EquipLockGoodsIDList[1]
                this.data.addGoodsId = NewPlayerLimitEquipMgr.EquipLockGoodsIDList[2]
                this.data.level3GoodsId = NewPlayerLimitEquipMgr.EquipLockGoodsIDList[3]
                this.vm.data.priceStr_1 = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.choiceGoodsId)
                this.vm.data.priceStr_2 = NewPlayerLimitSSRMgr.GetGoodsPriceSymbol(this.data.addGoodsId) .. (NewPlayerLimitSSRMgr.GetGoodsPrice(this.data.addGoodsId) - NewPlayerLimitSSRMgr.GetGoodsPrice(this.data.choiceGoodsId))
                this.vm.data.priceStr_3 = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.level3GoodsId)
                this.vm.data.confirmPriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.addGoodsId)
                this.vm.data.cancelPriceStr = NewPlayerLimitSSRMgr.GetGoodsPriceStr(this.data.choiceGoodsId)
                
                local descStr = ""
                local _cfgChargeMap= ConfigMgr.Config.charge
                local charge=_cfgChargeMap[this.data.level3GoodsId];
                if charge ~= nil and charge.Reward ~= nil then
                    for i,v in ipairs(charge.Reward) do
                        local itemConfig = ConfigMgr.Config.itemMap[v.id]
                        descStr = descStr .. string.format("%sx%d", LuaMgr.GetLangText(itemConfig.nameLan), v.count)
                        if i < #charge.Reward then
                            descStr = descStr .. LuaMgr.GetLangText("NewPlayerLimitEquipAddPopup_0")
                        end
                    end
                end
                this.vm.data.desc = ConfigMgr.LangGlobal("17503") .. descStr

                local choiceGoodsItem = this.GetDefaultGoodsItem()
                choiceGoodsItem.goodsID = this.data.choiceGoodsId
                choiceGoodsItem.heroPic = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/NewPlayerLimitEquip/ui_plt_xsth2_lb_txd.png"))
                choiceGoodsItem.name = this.GetGoodsName(this.data.choiceGoodsId)
                choiceGoodsItem.isPage1 = false
                choiceGoodsItem.isActive = true
                local tempItem1 = NewPlayerLimitEquipGoodsItem.New(this.leftgoodsItemTr1)
                tempItem1.transform.anchoredPosition = Vector2(0, 0);
                tempItem1:SetData(1, choiceGoodsItem)
                tempItem1:SetRewardItems()
                tempItem1:Show2()
                local tempItem2 = NewPlayerLimitEquipGoodsItem.New(this.leftgoodsItemTr2)
                tempItem2.transform.anchoredPosition = Vector2(0, 0);
                tempItem2:SetData(1, choiceGoodsItem)
                tempItem2:SetRewardItems()
                tempItem2:Show2()

                local addGoodsItem = this.GetDefaultGoodsItem()
                addGoodsItem.goodsID = this.data.level3GoodsId
                addGoodsItem.heroPic = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/NewPlayerLimitEquip/ui_plt_xsth2_lb_txd.png"))
                addGoodsItem.name = this.GetGoodsName(this.data.level3GoodsId)
                addGoodsItem.isPage1 = false
                addGoodsItem.isActive = true
                local tempItem3 = NewPlayerLimitEquipGoodsItem.New(this.rightgoodsItemTr)
                tempItem3.transform.anchoredPosition = Vector2(0, 0);
                tempItem3:SetData(1, addGoodsItem)
                tempItem3:SetRewardItems()
                tempItem3:Show2()
            end

            
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

this.UpdateLeftTimer = function()
    local curTime = LuaMgr.Timestamp()
    local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[this.data.choiceGoodsId]
    if goodsData ~= nil and goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
        local leftTime = goodsData.closeTime - curTime
        if leftTime < 0 then
            LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAddPopup)
        end
        return
    end
    LuaMgr.HidePanel(UIName.NewPlayerLimitEquipAddPopup)
end

this.GetGoodsName = function(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    return LuaMgr.GetLangText(charge.NameLan)
end
return vm({
    data = data,
    command = command,
    hook = hook
})