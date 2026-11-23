require("ViewModel/Activity/NewPlayerLimitSSRMgr")

NewPlayerLimitEquipMgr = {
    IsInit = false,
GoodsExistDuration = 0,
EquipGoodsHideTime_1 = 8 * 60,
EquipGoodsHideTime_2 = 8 * 60,
EquipLockGoodsHideTime_1 = 2 * 60,
EquipLockGoodsHideTime_2 = 2 * 60,
EquipLockGoodsBuyHideTime = 2 * 60,
EquipRerollGoodsHideTime = 2 * 60,
EquipRerollGoodsBuyHideTime = 2 * 60,
    EquipGoodsIDList = {},
EquipLockGoodsIDList = {},
EquipRerollGoodsIDList = {},
    EquipItemDesc = {},
GoodsTimeMap = { ["goodsId"] = {closeTime = 1732242864, openTime = 1732242864, status = 0} },
    
    firstShowNewPlayerLimitEquipPopup = false,
    isAddPageToPopupList = false,
    isAddAdPageToPopupList = false,
}

function NewPlayerLimitEquipMgr.Init()
    if NewPlayerLimitEquipMgr.IsInit then
        return
    end
    NewPlayerLimitEquipMgr.IsInit = true
    NewPlayerLimitEquipMgr.GoodsExistDuration = ConfigMgr.Config.constants.NewPlayerJumpWeaponTime
    NewPlayerLimitEquipMgr.EquipGoodsHideTime_1 = ConfigMgr.Config.constants.NewPlayerJumpWeapon1
    NewPlayerLimitEquipMgr.EquipGoodsHideTime_2 = ConfigMgr.Config.constants.NewPlayerJumpWeapon2
    NewPlayerLimitEquipMgr.EquipLockGoodsHideTime_1 = ConfigMgr.Config.constants.NewPlayerJumpWeaponLock1
    NewPlayerLimitEquipMgr.EquipLockGoodsHideTime_2 = ConfigMgr.Config.constants.NewPlayerJumpWeaponLock2
    NewPlayerLimitEquipMgr.EquipLockGoodsBuyHideTime = ConfigMgr.Config.constants.NewPlayerJumpWeaponLockHideTime
    NewPlayerLimitEquipMgr.EquipRerollGoodsHideTime_2 = ConfigMgr.Config.constants.NewPlayerJumpWeaponReroll
    NewPlayerLimitEquipMgr.EquipRerollGoodsBuyHideTime = ConfigMgr.Config.constants.NewPlayerJumpWeaponRerollHideTime
    NewPlayerLimitEquipMgr.GoodsTimeMap = {}
    NewPlayerLimitEquipMgr.EquipGoodsIDList = {}
    table.insert(NewPlayerLimitEquipMgr.EquipGoodsIDList, ConfigMgr.Config.constants.NewPlayerJumpWeapon1Id)
    table.insert(NewPlayerLimitEquipMgr.EquipGoodsIDList, ConfigMgr.Config.constants.NewPlayerJumpWeapon2Id)
    table.insert(NewPlayerLimitEquipMgr.EquipGoodsIDList, ConfigMgr.Config.constants.NewPlayerJumpWeapon3Id)
    NewPlayerLimitEquipMgr.EquipLockGoodsIDList = ConfigMgr.Config.constants.NewPlayerJumpWeaponLockId
    NewPlayerLimitEquipMgr.EquipRerollGoodsIDList = ConfigMgr.Config.constants.NewPlayerJumpWeaponRerollId
    NewPlayerLimitEquipMgr.AllEquipUpgradeGoodsIDList = {}
    for i, v in ipairs(NewPlayerLimitEquipMgr.EquipLockGoodsIDList) do
        table.insert(NewPlayerLimitEquipMgr.AllEquipUpgradeGoodsIDList, v)
    end
    for i, v in ipairs(NewPlayerLimitEquipMgr.EquipRerollGoodsIDList) do
        table.insert(NewPlayerLimitEquipMgr.AllEquipUpgradeGoodsIDList, v)
    end

    NewPlayerLimitEquipMgr.EquipItemDesc = {LuaMgr.GetLangText("NewPlayerLimitEquipMgr_0"), LuaMgr.GetLangText("NewPlayerLimitEquipMgr_1"), LuaMgr.GetLangText("NewPlayerLimitEquipMgr_2")}

    NewPlayerLimitEquipMgr.firstShowNewPlayerLimitEquipPopup = false
    NewPlayerLimitEquipMgr.isAddPageToPopupList = false
    NewPlayerLimitEquipMgr.isAddAdPageToPopupList = false
    
    LuaMgr.AddTimer(TimerConst.NewPlayerLimitEquipMgrTimer, NewPlayerLimitEquipMgr.UpdateTimer, 1, -1, false)
    LuaMgr.RemoveDataEventListener(NewPlayerLimitEquipMgr.OnChangeData);
    LuaMgr.AddDataEventListener(NewPlayerLimitEquipMgr.OnChangeData);
    LuaMgr.RemoveUIEventListener(UIEventConst.FirstMainPage, NewPlayerLimitEquipMgr.OnFirstMainPage);
    LuaMgr.AddUIEventListener(UIEventConst.FirstMainPage, NewPlayerLimitEquipMgr.OnFirstMainPage);
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,NewPlayerLimitEquipMgr.OnFirstMainPage)
    LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,NewPlayerLimitEquipMgr.OnFirstMainPage);
end

function NewPlayerLimitEquipMgr.RefreshData()
    if not NewPlayerLimitEquipMgr.IsInit then
        NewPlayerLimitEquipMgr.Init()
    end
    NewPlayerLimitEquipMgr.GoodsTimeMap = {}
ProgressEquipGoodsTimeMap()
end


function ProgressEquipGoodsTimeMap()
    local curTime = LuaMgr.Timestamp()
    local threeChoiceOneGoodsDisplayTime = GetLevelOneGoodsDisplayTime()

local twoChoiceOneGoods = nil
    local threeChoiceOneGoodsPurchaseTime = 0
    local isBoughtThreeChoiceOne = false
    for listIndex, goodsIdList in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
        local goodsId = goodsIdList[1]
if NewPlayerLimitSSRMgr.IsBoughtGoods(goodsId) then
            NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)

            NewPlayerLimitEquipMgr.GoodsTimeMap[goodsIdList[2]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            NewPlayerLimitEquipMgr.GoodsTimeMap[goodsIdList[3]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)

            local list1, list2 = GetOtherTwoGoodsList(listIndex)
            NewPlayerLimitEquipMgr.GoodsTimeMap[list1[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            NewPlayerLimitEquipMgr.GoodsTimeMap[list2[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            NewPlayerLimitEquipMgr.GoodsTimeMap[list1[4]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            NewPlayerLimitEquipMgr.GoodsTimeMap[list2[4]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            threeChoiceOneGoodsPurchaseTime = NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(goodsId)
            twoChoiceOneGoods = {}
            table.insert(twoChoiceOneGoods, goodsIdList[4])
            table.insert(twoChoiceOneGoods, list1[2])
            table.insert(twoChoiceOneGoods, list2[2])
            table.insert(twoChoiceOneGoods, list1[3])
            table.insert(twoChoiceOneGoods, list2[3])
            isBoughtThreeChoiceOne = true
            break
        end
    end
    if not isBoughtThreeChoiceOne then

        if threeChoiceOneGoodsDisplayTime == 0 then
            for i, v in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
                NewPlayerLimitEquipMgr.GoodsTimeMap[v[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
            end
        else
            local closeTime = threeChoiceOneGoodsDisplayTime + NewPlayerLimitEquipMgr.GoodsExistDuration
if curTime <= closeTime then
                for i, v in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
                    NewPlayerLimitEquipMgr.GoodsTimeMap[v[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Showing, closeTime)
                end
else

                for i, v in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
                    NewPlayerLimitEquipMgr.GoodsTimeMap[v[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                end
            end
        end
    end


    local oneChoiceOneGoods = nil
    local twoChoiceOneGoodsPurchaseTime = 0
    local isBoughtTwoChoiceOne = false
    local TwoChoiceOneShowTime = 0
    if twoChoiceOneGoods ~= nil then
        for i = 1, 3 do
            local goodsId = twoChoiceOneGoods[i]
if NewPlayerLimitSSRMgr.IsBoughtGoods(goodsId) then
                NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
                twoChoiceOneGoodsPurchaseTime = NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(goodsId)
if i == 1 then
for j = 2, #twoChoiceOneGoods do
                        NewPlayerLimitEquipMgr.GoodsTimeMap[twoChoiceOneGoods[j]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                    end
                elseif i == 2 then

                    for j = 1, #twoChoiceOneGoods do
                        if j ~= 2 and j ~= 5 then
                            NewPlayerLimitEquipMgr.GoodsTimeMap[twoChoiceOneGoods[j]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                        end
                    end
                    oneChoiceOneGoods = twoChoiceOneGoods[5]
                elseif i == 3 then

                    for j = 1, #twoChoiceOneGoods do
                        if j ~= 3 and j ~= 4 then
                            NewPlayerLimitEquipMgr.GoodsTimeMap[twoChoiceOneGoods[j]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                        end
                    end
                    oneChoiceOneGoods = twoChoiceOneGoods[4]
                end
                isBoughtTwoChoiceOne = true
                break
            end
        end
        if not isBoughtTwoChoiceOne then
            local showTime = threeChoiceOneGoodsPurchaseTime + NewPlayerLimitEquipMgr.EquipGoodsHideTime_1
            for i = 1, 3 do
                local goodsId = twoChoiceOneGoods[i]
if curTime <= showTime then
                    NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0, showTime)
else
                    local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(goodsId)
if displayTime == 0 then
                        NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
else
                        TwoChoiceOneShowTime = displayTime
                        local closeTime = displayTime + NewPlayerLimitEquipMgr.GoodsExistDuration
                        SetGoodsShowingOrClose(goodsId, closeTime, curTime)
                    end
                end
            end
        end
    end


    local isBoughtOneChoiceOne = false
    local OneChoiceOneShowTime = 0
    if oneChoiceOneGoods ~= nil then
if NewPlayerLimitSSRMgr.IsBoughtGoods(oneChoiceOneGoods) then
            isBoughtOneChoiceOne = true
            NewPlayerLimitEquipMgr.GoodsTimeMap[oneChoiceOneGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
        else
            local showTime = twoChoiceOneGoodsPurchaseTime + NewPlayerLimitEquipMgr.EquipGoodsHideTime_2
if curTime <= showTime then
                NewPlayerLimitEquipMgr.GoodsTimeMap[oneChoiceOneGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
            else
                local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(oneChoiceOneGoods)
if displayTime == 0 then
                    NewPlayerLimitEquipMgr.GoodsTimeMap[oneChoiceOneGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
else
                    OneChoiceOneShowTime = displayTime
                    local closeTime = displayTime + NewPlayerLimitEquipMgr.GoodsExistDuration
                    SetGoodsShowingOrClose(oneChoiceOneGoods, closeTime, curTime)
                end
            end
        end
    end

    if threeChoiceOneGoodsDisplayTime == 0 then
        return
    end
ProgressUpgradeEquipGoodsTimeMap(isBoughtThreeChoiceOne, threeChoiceOneGoodsDisplayTime, threeChoiceOneGoodsPurchaseTime)
end


function ProgressUpgradeEquipGoodsTimeMap(isBoughtThreeChoiceOne, threeChoiceOneDisplayTime, threeChoiceOnePurchaseTime)
    local curTime = LuaMgr.Timestamp()
local lockGoods_one = NewPlayerLimitEquipMgr.EquipLockGoodsIDList[1]
local lockGoods_add = NewPlayerLimitEquipMgr.EquipLockGoodsIDList[2]
local lockGoods_two = NewPlayerLimitEquipMgr.EquipLockGoodsIDList[3]

local isBoughtLockGoodsOne = NewPlayerLimitSSRMgr.IsBoughtGoods(lockGoods_one)
    local LockGoodsDisplayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(lockGoods_one)
    local LockGoodsPurchaseTime = NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(lockGoods_one)

    local completedAreaEvent = DataMgr.Player.completedAreaEvents[ConfigMgr.Config.constants.NewPlayerJumpWeaponLockIdCondition[2][1]]

    if completedAreaEvent == nil then
        return
    end
if NewPlayerLimitSSRMgr.IsBoughtGoods(lockGoods_one) then
        NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_one] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
        NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_add] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)

        local showTime = LockGoodsPurchaseTime + NewPlayerLimitEquipMgr.EquipLockGoodsHideTime_2
if curTime <= showTime then
            NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_two] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
        else
            local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(lockGoods_two)
if displayTime == 0 then
                NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_two] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
else
                local closeTime = displayTime + NewPlayerLimitEquipMgr.GoodsExistDuration
                SetGoodsShowingOrClose(lockGoods_two, closeTime, curTime)
            end
        end
elseif NewPlayerLimitSSRMgr.IsBoughtGoods(lockGoods_add) then
        NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_one] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
        NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_add] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
        NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_two] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
    else



        local showTime = isBoughtThreeChoiceOne and (threeChoiceOnePurchaseTime + NewPlayerLimitEquipMgr.EquipLockGoodsBuyHideTime) or (threeChoiceOneDisplayTime + NewPlayerLimitEquipMgr.EquipGoodsHideTime_1)
if curTime <= showTime then
            NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_one] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
            NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_add] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
        else
            local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(lockGoods_one)
if displayTime == 0 then
                NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_one] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                NewPlayerLimitEquipMgr.GoodsTimeMap[lockGoods_add] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
else
                local closeTime = displayTime + NewPlayerLimitEquipMgr.GoodsExistDuration
                SetGoodsShowingOrClose(lockGoods_one, closeTime, curTime)
                SetGoodsShowingOrClose(lockGoods_add, closeTime, curTime)
            end
        end
    end

    if LockGoodsDisplayTime == 0 then
        return
    end
ProgressEquipRerollGoodsTimeMap(isBoughtLockGoodsOne, LockGoodsDisplayTime, LockGoodsPurchaseTime)
end


function ProgressEquipRerollGoodsTimeMap(isBoughtLockGoodsOne, LockGoodsDisplayTime, LockGoodsPurchaseTime)
    local curTime = LuaMgr.Timestamp()
local rerollGoods = NewPlayerLimitEquipMgr.EquipRerollGoodsIDList[1]

if NewPlayerLimitSSRMgr.IsBoughtGoods(rerollGoods) then
        NewPlayerLimitEquipMgr.GoodsTimeMap[rerollGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
    else


        local showTime = isBoughtLockGoodsOne and (LockGoodsPurchaseTime + NewPlayerLimitEquipMgr.EquipRerollGoodsBuyHideTime) or (LockGoodsDisplayTime + NewPlayerLimitEquipMgr.EquipRerollGoodsHideTime)
if curTime <= showTime then
            NewPlayerLimitEquipMgr.GoodsTimeMap[rerollGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
        else
            local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(rerollGoods)
if displayTime == 0 then
                NewPlayerLimitEquipMgr.GoodsTimeMap[rerollGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
else
                local closeTime = displayTime + NewPlayerLimitEquipMgr.GoodsExistDuration
                SetGoodsShowingOrClose(rerollGoods, closeTime, curTime)
            end
        end
    end
end


function NewPlayerLimitEquipMgr.UpdateTimer()
    if not ActivityMgr.IsNewPlayerLimitEquipActivityOpen() then
        NewPlayerLimitEquipMgr.IsInit = false
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitEquipMgrTimer)
        return
    end
if not LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
        return
    end
    if LuaMgr.IsGuide() or PopUpMgr.Count() > 0 or LuaMgr.IsPanelOpen(UIName.NoticeSlapfaceViewModel) or LuaMgr.IsPanelOpen("Laigu.ViewModel.TakeCard.NewCardShowViewModel")
        or LuaMgr.IsPanelOpen("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel") or LuaMgr.IsPanelOpen(UIName.NewCardSkinViewModel) or LuaMgr.IsPanelOpen(UIName.ItemGetViewModel) then
        return
    end
    if LuaMgr.IsPanelOpen(UIName.NewPlayerLimitSSRPopup) or LuaMgr.IsPanelOpen(UIName.NewPlayerLimitSSRAdPopup) or LuaMgr.IsPanelOpen(UIName.NewPlayerLimitSSRAddPopup) then
        return
    end

    if LuaMgr.IsPanelOpen(UIName.MainPageViewModel) and not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitEquipPopup) and (not NewPlayerLimitEquipMgr.CheckActivityIsShown() or NewPlayerLimitEquipMgr.firstShowNewPlayerLimitEquipPopup) then
        LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitEquipPopup)
        return
    end
    local curTime = LuaMgr.Timestamp()
    for listIndex, goodsList in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
        for goodsIndex = 1, #goodsList do
            local goodsId = goodsList[goodsIndex]
            local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil then
                if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Hide and curTime > goodsData.openTime) then
                    NewPlayerLimitEquipMgr.RefreshData()
                    if (goodsIndex == 2 or goodsIndex == 3) and not NewPlayerLimitEquipMgr.isAddPageToPopupList then
                        if not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitEquipAdPopup) then
                            NewPlayerLimitEquipMgr.isAddPageToPopupList = true
                            if LuaMgr.IsPanelOpen(UIName.NewPlayerLimitEquipPopup) then
                                LuaMgr.InvokeUIEventListeners(UIEventConst.NewPlayerLimitEquipRefresh);
                            else
                                if LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
                                    LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitEquipPopup)
                                else
                                    PopUpMgr.Insert(UIName.NewPlayerLimitEquipPopup);
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    for i, goodsId in ipairs(NewPlayerLimitEquipMgr.AllEquipUpgradeGoodsIDList) do
        local goodsData = NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId]
        if goodsData ~= nil then
            if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Hide and curTime > goodsData.openTime) then
                NewPlayerLimitSSRMgr.RefreshData()
                if (i ~= 2) and not NewPlayerLimitEquipMgr.isAddAdPageToPopupList then
                    if not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitEquipPopup) and not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitEquipAdPopup) then
                        NewPlayerLimitEquipMgr.isAddAdPageToPopupList = true
                        if LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
                            LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitEquipAdPopup)
                        else
                            PopUpMgr.Insert(UIName.NewPlayerLimitEquipAdPopup);
                        end
                    end
                end
            end
        end
    end
end

function NewPlayerLimitEquipMgr.GetNewPlayerLimitEntranceTimerStr()
    if not NewPlayerLimitEquipMgr.CheckActivityIsShown() then
        return ""
    end
    
    local curTime = LuaMgr.Timestamp()
    local isShow = false
    local minLeftTime = 2078385396
    for k, v in pairs(NewPlayerLimitEquipMgr.GoodsTimeMap) do
        if v.status == NewPlayerLimitSSRMgr.GoodsStatus.Showing then
            local tempLeftTime = v.closeTime - curTime
            if tempLeftTime > 0 and tempLeftTime <= minLeftTime then
                isShow = true
                minLeftTime = tempLeftTime
            end
        end
    end
    if minLeftTime < 0 or not isShow then
        return ""
    end
    local h, m, s = GetTimeHMS(minLeftTime)
    return string.format("%s:%s:%s", h, m, s);
end

function NewPlayerLimitEquipMgr.CheckActivityIsShown()
    return DataMgr.Player.specialPurchase2 == 1 and GetLevelOneGoodsDisplayTime() > 0
end

function GetLevelOneGoodsDisplayTime()
    return NewPlayerLimitSSRMgr.GetGoodsDisplayTime(NewPlayerLimitEquipMgr.EquipGoodsIDList[1][1])
end


function GetOtherTwoGoodsList(index)
    local list1 = nil
    local list2 = nil
    for i, v in ipairs(NewPlayerLimitEquipMgr.EquipGoodsIDList) do
        if i ~= index then
            if list1 == nil then
                list1 = v
            else
                list2 = v
            end
        end
    end
    return list1, list2
end
function GetGoodsTimeItem(status, closeTime, openTime)
    return {
        closeTime = closeTime == nil and 0 or closeTime,
        openTime = openTime == nil and 0 or openTime,
        status = status
    }
end

function SetGoodsShowingOrClose(goodsId, closeTime, curTime)
    if curTime <= closeTime then
        NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Showing, closeTime)
    else
        NewPlayerLimitEquipMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
    end
end

function NewPlayerLimitEquipMgr.OnChangeData(data)
    local type=tostring(data[0]);
    if type ~= "equipments" then return end;
    NewPlayerLimitEquipMgr.RefreshData()
end

function NewPlayerLimitEquipMgr.OnFirstMainPage()
    NewPlayerLimitEquipMgr.firstShowNewPlayerLimitEquipPopup = true
end

return NewPlayerLimitEquipMgr;