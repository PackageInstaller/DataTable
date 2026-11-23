
NewPlayerLimitBreakMgr = {
    IsInit = false,
    NewbieGiftDisplayTime = 0,
NewbieGiftContinueTime = 0,
NewbieGiftCharacter = {},
    GoodsIDList = {},
    GoodsStateMap = {},

    firstShowNewPlayerLimitBreakPopup = false,
    isAddPageToPopupList = false,
    isAddAdPageToPopupList = false,
    PrefsKey = "NewPlayerLimitBreak"
}
NewPlayerLimitBreakMgr.GoodsStatus = {
Lock = 1,
Showing = 2,
Bought = 3,
}

function NewPlayerLimitBreakMgr.Init()
    if NewPlayerLimitBreakMgr.IsInit then
        return
    end
    NewPlayerLimitBreakMgr.IsInit = true
    NewPlayerLimitBreakMgr.NewbieGiftContinueTime = ConfigMgr.Config.constants.NewbieGiftContinueTime
    NewPlayerLimitBreakMgr.NewbieGiftCharacter = ConfigMgr.Config.constants.NewbieGiftCharacter

    NewPlayerLimitBreakMgr.GoodsStateMap = {}
    NewPlayerLimitBreakMgr.GoodsIDList = ConfigMgr.Config.constants.NewbieGiftUnlock


    LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRMgrTimer, NewPlayerLimitBreakMgr.UpdateTimer, 1, -1, false)
    LuaMgr.RemoveDataEventListener(NewPlayerLimitBreakMgr.OnChangeData);
    LuaMgr.AddDataEventListener(NewPlayerLimitBreakMgr.OnChangeData);
end


function NewPlayerLimitBreakMgr.RefreshData()
    if not NewPlayerLimitBreakMgr.IsInit then
        NewPlayerLimitBreakMgr.Init()
        NewPlayerLimitBreakMgr.OnFirstMainPage()
    end
    NewPlayerLimitBreakMgr.GoodsStateMap = {}
    ProgressGoodsTimeMap()
end

function ProgressGoodsTimeMap()
    for listIndex, goodsIdList in ipairs(NewPlayerLimitBreakMgr.GoodsIDList) do
        local goodsId = goodsIdList[1]
        local lockId = goodsIdList[2]
        if lockId == "0" or NewPlayerLimitBreakMgr.IsBoughtGoods(lockId) then
            NewPlayerLimitBreakMgr.GoodsStateMap[goodsId] = NewPlayerLimitBreakMgr.GoodsStatus.Showing
            if NewPlayerLimitBreakMgr.IsBoughtGoods(goodsId) then
                NewPlayerLimitBreakMgr.GoodsStateMap[goodsId] = NewPlayerLimitBreakMgr.GoodsStatus.Bought
            end
        else
            NewPlayerLimitBreakMgr.GoodsStateMap[goodsId] = NewPlayerLimitBreakMgr.GoodsStatus.Lock
        end
        if (listIndex == 1 and NewPlayerLimitBreakMgr.NewbieGiftDisplayTime == 0) then
            local DisplayTime = NewPlayerLimitBreakMgr.GetGoodsDisplayTime(goodsId)
            if DisplayTime > 0 then
                NewPlayerLimitBreakMgr.NewbieGiftDisplayTime = DisplayTime
            else
                ApiMgr.Request("set_goods_display_time", { GoodsID = { goodsId } }, true, function()
                    NewPlayerLimitBreakMgr.isAddPageToPopupList = false
                    DisplayTime = NewPlayerLimitBreakMgr.GetGoodsDisplayTime(goodsId)
                    NewPlayerLimitBreakMgr.NewbieGiftDisplayTime = DisplayTime
                end, nil, true, true);
            end
        end
    end
end










function NewPlayerLimitBreakMgr.UpdateTimer()
    if not ActivityMgr.CheckShowPlayerLimitBreakPopup() then
        NewPlayerLimitBreakMgr.IsInit = false
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRMgrTimer)
        return
    end
if not LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
        return
    end
    if LuaMgr.IsGuide() or PopUpMgr.Count() > 0 or LuaMgr.IsPanelOpen(UIName.NoticeSlapfaceViewModel) or LuaMgr.IsPanelOpen("Laigu.ViewModel.TakeCard.NewCardShowViewModel")
        or LuaMgr.IsPanelOpen("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel") or LuaMgr.IsPanelOpen(UIName.NewCardSkinViewModel) or LuaMgr.IsPanelOpen(UIName.ItemGetViewModel)
        or LuaMgr.IsPanelOpen(UIName.BalatroLaunchPanel) or LuaMgr.IsPanelOpen(UIName.NewPlayerLimitBreakPopup) then
        return
    end



    if LuaMgr.IsPanelOpen(UIName.MainPageViewModel) and not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitBreakPopup) and (NewPlayerLimitBreakMgr.CheckActivityIsShown() and NewPlayerLimitBreakMgr.firstShowNewPlayerLimitBreakPopup) then
        LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitBreakPopup)
        return
    end
end



function NewPlayerLimitBreakMgr.GetNewPlayerLimitEntranceTimerStr()
    if not ActivityMgr.CheckShowPlayerLimitBreakPopup() then
        return ""
    end
    local curTime = LuaMgr.Timestamp()
    local minLeftTime = 0
    if (NewPlayerLimitBreakMgr.NewbieGiftDisplayTime > 0) then
        minLeftTime = NewPlayerLimitBreakMgr.NewbieGiftDisplayTime + NewPlayerLimitBreakMgr.NewbieGiftContinueTime -
            curTime
    end
    if minLeftTime <= 0 then
        return ""
    end
    local h, m, s = GetTimeHMS(minLeftTime)
    return string.format("%s:%s:%s", h, m, s);
end



function NewPlayerLimitBreakMgr.CheckActivityIsShown()
    local goodsId = NewPlayerLimitBreakMgr.GoodsIDList[1][1]
    local curTime = LuaMgr.Timestamp()
    local leftTime = NewPlayerLimitBreakMgr.GetGoodsDisplayTime(goodsId) - curTime +
        NewPlayerLimitBreakMgr.NewbieGiftContinueTime
    local unlockCon = ConfigMgr.Config.constants.NewbieGiftPop;
    local lockCon = ConfigMgr.Config.constants.NewbieGiftNotPop;
    local record = DataMgr.Player.dungeonRecords;
    local recordFinish1 = record[unlockCon[1]] ~= nil and record[unlockCon[1]].completeCount > 0
    local recordFinish2 = record[lockCon[1]] == nil or record[lockCon[1]].completeCount <= 0
    local lvFinish = DataMgr.Player.level >= tonumber(unlockCon[2]) and DataMgr.Player.level <= tonumber(lockCon[2])
    if (recordFinish1 and recordFinish2 and lvFinish and leftTime > 0) then
        return true
    end
    return false
end




function NewPlayerLimitBreakMgr.GetGoodsPurchaseTime(goodsId)
    local purchaseTime = DataMgr.Player.shop.purchaseTime
    if IsNull(purchaseTime) or next(purchaseTime) == nil then
        return 0
    end
    return purchaseTime[goodsId] ~= nil and purchaseTime[goodsId] or 0
end




function NewPlayerLimitBreakMgr.GetGoodsDisplayTime(goodsId)
    local goodsDisplayTime = DataMgr.Player.goodsDisplayTime
    if IsNull(goodsDisplayTime) or next(goodsDisplayTime) == nil then
        return 0
    end
    return goodsDisplayTime[goodsId] ~= nil and goodsDisplayTime[goodsId] or 0
end




function NewPlayerLimitBreakMgr.IsBoughtGoods(goodsId)
    local records = DataMgr.Player.shop.records
    if IsNull(records) or next(records) == nil then
        return false
    end
    return records[goodsId] == 1
end




function NewPlayerLimitBreakMgr.GetGoodsPriceSymbol(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    local Symbol = ""
    if charge.ChargeGroup ~= nil and charge.ChargeGroup ~= "" then
        local chargeChanel = ConfigHelper.GetChargeChannel(charge.ChargeGroup)
        Symbol = chargeChanel.CurrencySymbol
    end
    return Symbol
end




function NewPlayerLimitBreakMgr.GetGoodsPrice(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    local Price = ""
    if charge.ChargeGroup ~= nil and charge.ChargeGroup ~= "" then
        local chargeChanel = ConfigHelper.GetChargeChannel(charge.ChargeGroup)
        Price = chargeChanel.PriceShow
    end
    return tonumber(Price)
end




function NewPlayerLimitBreakMgr.GetGoodsPriceStr(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    local RMBPrice = ""
    if charge.ChargeGroup ~= nil and charge.ChargeGroup ~= "" then
        local chargeChanel = ConfigHelper.GetChargeChannel(charge.ChargeGroup)
        RMBPrice = chargeChanel.CurrencySymbol .. chargeChanel.PriceShow
    end
    return RMBPrice
end



function NewPlayerLimitBreakMgr.OnChangeData(data)
    NewPlayerLimitBreakMgr.RefreshData()
end




function NewPlayerLimitBreakMgr.OnFirstMainPage()
    local key = DataMgr.Player.uid .. NewPlayerLimitBreakMgr.PrefsKey
    local cache = PlayerPrefs.GetInt(key)
    if cache == 1 then
        NewPlayerLimitBreakMgr.firstShowNewPlayerLimitBreakPopup = false
        return
    end
    PlayerPrefs.SetInt(key, 1)
    NewPlayerLimitBreakMgr.firstShowNewPlayerLimitBreakPopup = true
end

function NewPlayerLimitBreakMgr.GetGoodsStatus(goodsId)
    return NewPlayerLimitBreakMgr.GoodsStateMap[goodsId]
end

function NewPlayerLimitBreakMgr.CheckGetAll()
    local isGetAll = true
    if (#NewPlayerLimitBreakMgr.GoodsIDList > 0) then
        for k, v in pairs(NewPlayerLimitBreakMgr.GoodsIDList) do
            local id = v[1]
            isGetAll = NewPlayerLimitBreakMgr.GoodsStateMap[id]
            if (isGetAll == nil or isGetAll ~= NewPlayerLimitBreakMgr.GoodsStatus.Bought) then
                return false
            end
        end
    else
        return false
    end
    return true
end

function NewPlayerLimitBreakMgr.Clear()
    NewPlayerLimitBreakMgr.NewbieGiftDisplayTime = 0
    NewPlayerLimitBreakMgr.IsInit = false
    NewPlayerLimitBreakMgr.NewbieGiftDisplayTime = 0
    NewPlayerLimitBreakMgr.NewbieGiftContinueTime = 0
    NewPlayerLimitBreakMgr.NewbieGiftCharacter = {}
    NewPlayerLimitBreakMgr.GoodsIDList = {}
    NewPlayerLimitBreakMgr.GoodsStateMap = {}

    NewPlayerLimitBreakMgr.firstShowNewPlayerLimitBreakPopup = false
    NewPlayerLimitBreakMgr.isAddPageToPopupList = false
    NewPlayerLimitBreakMgr.isAddAdPageToPopupList = false
end

return NewPlayerLimitBreakMgr;