
NewPlayerLimitSSRMgr = {
    IsInit = false,
GoodsExistDuration = 0,
CharacterGoodsHideTime = 8 * 60,
LevelUpCharacterGoodsHideTime = 2 * 60,
ThreeZZCharacterGoodsBuyHideTime = 5 * 60,
ThreeZZCharacterGoodsHideTime = 2 * 60,
SixZZCharacterGoodsHideTime = 5 * 60,
    HeroGoodsIDList = {},
CharacterGoodsPurchaseTimeSortMap = {},
GoodsTimeMap = { ["goodsId"] = {closeTime = 1732242864, openTime = 1732242864, status = 0} },
    
    firstShowNewPlayerLimitSSRPopup = false,
    isAddPageToPopupList = false,
    isAddAdPageToPopupList = false,
}
NewPlayerLimitSSRMgr.GoodsStatus = {
Hide = 0,
WaitShow = 1,
Showing = 2,
Bought = 3,
Close = 4,
}

function NewPlayerLimitSSRMgr.Init()
    if NewPlayerLimitSSRMgr.IsInit then
        return
    end
    NewPlayerLimitSSRMgr.IsInit = true
    NewPlayerLimitSSRMgr.GoodsExistDuration = ConfigMgr.Config.constants.NewPlayerLimitSSRTime
    NewPlayerLimitSSRMgr.CharacterGoodsHideTime = ConfigMgr.Config.constants.CharacterGoodsHideTime
    NewPlayerLimitSSRMgr.LevelUpCharacterGoodsHideTime = ConfigMgr.Config.constants.LevelUpCharacterGoodsHideTime
    NewPlayerLimitSSRMgr.ThreeZZCharacterGoodsBuyHideTime = ConfigMgr.Config.constants.ThreeZZCharacterGoodsBuyHideTime
    NewPlayerLimitSSRMgr.ThreeZZCharacterGoodsHideTime = ConfigMgr.Config.constants.ThreeZZCharacterGoodsHideTime
    NewPlayerLimitSSRMgr.SixZZCharacterGoodsHideTime = ConfigMgr.Config.constants.SixZZCharacterGoodsHideTime
    NewPlayerLimitSSRMgr.GoodsTimeMap = {}
    NewPlayerLimitSSRMgr.HeroGoodsIDList = {}
    table.insert(NewPlayerLimitSSRMgr.HeroGoodsIDList, ConfigMgr.Config.constants.NewPlayerLimitSSRHero1)
    table.insert(NewPlayerLimitSSRMgr.HeroGoodsIDList, ConfigMgr.Config.constants.NewPlayerLimitSSRHero2)
    table.insert(NewPlayerLimitSSRMgr.HeroGoodsIDList, ConfigMgr.Config.constants.NewPlayerLimitSSRHero3)
    
    LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRMgrTimer, NewPlayerLimitSSRMgr.UpdateTimer, 1, -1, false)
    LuaMgr.RemoveDataEventListener(NewPlayerLimitSSRMgr.OnChangeData);
    LuaMgr.AddDataEventListener(NewPlayerLimitSSRMgr.OnChangeData);
    LuaMgr.RemoveUIEventListener(UIEventConst.FirstMainPage, NewPlayerLimitSSRMgr.OnFirstMainPage);
    LuaMgr.AddUIEventListener(UIEventConst.FirstMainPage, NewPlayerLimitSSRMgr.OnFirstMainPage);
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,NewPlayerLimitSSRMgr.OnFirstMainPage)
    LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,NewPlayerLimitSSRMgr.OnFirstMainPage);
end

function NewPlayerLimitSSRMgr.RefreshData()
    if not NewPlayerLimitSSRMgr.IsInit then
        NewPlayerLimitSSRMgr.Init()
    end
    NewPlayerLimitSSRMgr.GoodsTimeMap = {}
ProgressCharacterGoodsTimeMap()
    RefreshCharacterGoodsPurchaseTimeSortMap()
end


function ProgressCharacterGoodsTimeMap()
    local curTime = LuaMgr.Timestamp()

local twoChoiceOneGoods = nil
    local threeChoiceOneGoodsPurchaseTime = 0
    local isBoughtThreeChoiceOne = false
    for listIndex, goodsIdList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
        local goodsId = goodsIdList[1]
if NewPlayerLimitSSRMgr.IsBoughtGoods(goodsId) then
            NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)

            NewPlayerLimitSSRMgr.GoodsTimeMap[goodsIdList[2]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            NewPlayerLimitSSRMgr.GoodsTimeMap[goodsIdList[3]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)

            local list1, list2 = GetOtherTwoGoodsList(listIndex)
            NewPlayerLimitSSRMgr.GoodsTimeMap[list1[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            NewPlayerLimitSSRMgr.GoodsTimeMap[list2[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            NewPlayerLimitSSRMgr.GoodsTimeMap[list1[7]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            NewPlayerLimitSSRMgr.GoodsTimeMap[list2[7]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
            threeChoiceOneGoodsPurchaseTime = NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(goodsId)
            twoChoiceOneGoods = {}
            table.insert(twoChoiceOneGoods, goodsIdList[7])
            table.insert(twoChoiceOneGoods, list1[2])
            table.insert(twoChoiceOneGoods, list2[2])
            table.insert(twoChoiceOneGoods, list1[3])
            table.insert(twoChoiceOneGoods, list2[3])
            isBoughtThreeChoiceOne = true
            break
        end
    end
    if not isBoughtThreeChoiceOne then

        if DataMgr.Player.purchaseEventTime == 0 then
            for i, v in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
                NewPlayerLimitSSRMgr.GoodsTimeMap[v[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
            end
        else
            local closeTime = DataMgr.Player.purchaseEventTime + NewPlayerLimitSSRMgr.GoodsExistDuration
if curTime <= closeTime then
                for i, v in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
                    NewPlayerLimitSSRMgr.GoodsTimeMap[v[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Showing, closeTime)
                end
else

                for i, v in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
                    NewPlayerLimitSSRMgr.GoodsTimeMap[v[1]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
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
                NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
                twoChoiceOneGoodsPurchaseTime = NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(goodsId)
if i == 1 then
for j = 2, #twoChoiceOneGoods do
                        NewPlayerLimitSSRMgr.GoodsTimeMap[twoChoiceOneGoods[j]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                    end
                elseif i == 2 then

                    for j = 1, #twoChoiceOneGoods do
                        if j ~= 2 and j ~= 5 then
                            NewPlayerLimitSSRMgr.GoodsTimeMap[twoChoiceOneGoods[j]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                        end
                    end
                    oneChoiceOneGoods = twoChoiceOneGoods[5]
                elseif i == 3 then

                    for j = 1, #twoChoiceOneGoods do
                        if j ~= 3 and j ~= 4 then
                            NewPlayerLimitSSRMgr.GoodsTimeMap[twoChoiceOneGoods[j]] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                        end
                    end
                    oneChoiceOneGoods = twoChoiceOneGoods[4]
                end
                isBoughtTwoChoiceOne = true
                break
            end
        end
        if not isBoughtTwoChoiceOne then
            local showTime = threeChoiceOneGoodsPurchaseTime + NewPlayerLimitSSRMgr.CharacterGoodsHideTime
            for i = 1, 3 do
                local goodsId = twoChoiceOneGoods[i]
if curTime <= showTime then
                    NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0, showTime)
else
                    local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(goodsId)
if displayTime == 0 then
                        NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
else
                        TwoChoiceOneShowTime = displayTime
                        local closeTime = displayTime + NewPlayerLimitSSRMgr.GoodsExistDuration
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
            NewPlayerLimitSSRMgr.GoodsTimeMap[oneChoiceOneGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
        else
            local showTime = twoChoiceOneGoodsPurchaseTime + NewPlayerLimitSSRMgr.CharacterGoodsHideTime
if curTime <= showTime then
                NewPlayerLimitSSRMgr.GoodsTimeMap[oneChoiceOneGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
            else
                local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(oneChoiceOneGoods)
if displayTime == 0 then
                    NewPlayerLimitSSRMgr.GoodsTimeMap[oneChoiceOneGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
else
                    OneChoiceOneShowTime = displayTime
                    local closeTime = displayTime + NewPlayerLimitSSRMgr.GoodsExistDuration
                    SetGoodsShowingOrClose(oneChoiceOneGoods, closeTime, curTime)
                end
            end
        end
    end

    if DataMgr.Player.purchaseEventTime == 0 then
        return
    end
ProgressUpgradeCharacterGoodsTimeMap(isBoughtThreeChoiceOne, isBoughtTwoChoiceOne, isBoughtOneChoiceOne, TwoChoiceOneShowTime, OneChoiceOneShowTime)
end


function ProgressUpgradeCharacterGoodsTimeMap(isBoughtThreeChoiceOne, isBoughtTwoChoiceOne, isBoughtOneChoiceOne, TwoChoiceOneShowTime, OneChoiceOneShowTime) 
    local curTime = LuaMgr.Timestamp()
    for listIndex, goodsIdList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
        local characterId = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[listIndex]
if DataMgr.Player.characters[characterId] ~= nil then
local levelUpGoods = goodsIdList[4]
if NewPlayerLimitSSRMgr.IsBoughtGoods(levelUpGoods) then
                NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
            else
                local level = GetCharacterLevelByListIndex(listIndex)
                local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(levelUpGoods)
if displayTime > 0 then
if level >= 70 then
                        NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                    else
                        local closeTime = displayTime + NewPlayerLimitSSRMgr.GoodsExistDuration
                        SetGoodsShowingOrClose(levelUpGoods, closeTime, curTime)
                    end
                else
if level > 30 then
                        NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
                    else
if IsBougthCharacterGoods(listIndex) then
                            NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                        else
if isBoughtThreeChoiceOne then
if isBoughtTwoChoiceOne then
if isBoughtOneChoiceOne then

                                    else
if OneChoiceOneShowTime > 0 then
                                            local showTime = OneChoiceOneShowTime + NewPlayerLimitSSRMgr.LevelUpCharacterGoodsHideTime
                                            if curTime <= showTime then
                                                NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
                                            else
                                                NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                                            end
                                        else

                                        end
                                    end
                                else
if TwoChoiceOneShowTime > 0 then
                                        local showTime = TwoChoiceOneShowTime + NewPlayerLimitSSRMgr.LevelUpCharacterGoodsHideTime
                                        if curTime <= showTime then
                                            NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
                                        else
                                            NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                                        end
                                    else

                                    end
                                end
                            else
                                local showTime = DataMgr.Player.purchaseEventTime + NewPlayerLimitSSRMgr.LevelUpCharacterGoodsHideTime
                                if curTime <= showTime then
                                    NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
                                else
                                    NewPlayerLimitSSRMgr.GoodsTimeMap[levelUpGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                                end
                            end
                        end
                    end
                end
            end

local threeZZGoods = goodsIdList[5]
if NewPlayerLimitSSRMgr.IsBoughtGoods(threeZZGoods) then
                NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
            else
                local level = GetCharacterLevelByListIndex(listIndex)
                local displayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(threeZZGoods)
                if displayTime > 0 then
                    local closeTime = displayTime + NewPlayerLimitSSRMgr.GoodsExistDuration
                    SetGoodsShowingOrClose(threeZZGoods, closeTime, curTime)
                else
if IsBougthCharacterGoods(listIndex) then
local characterGoodsPurchaseTime = GetCharacterGoodsPurchaseTime(listIndex)
if level > 30 then
                            NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
else
                            local showTime = characterGoodsPurchaseTime + NewPlayerLimitSSRMgr.ThreeZZCharacterGoodsBuyHideTime
                            if curTime <= showTime then
                                NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0, showTime)
                            else
                                NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                            end
                        end
else
if isBoughtThreeChoiceOne then
if isBoughtTwoChoiceOne then
if isBoughtOneChoiceOne then

                                else
if OneChoiceOneShowTime > 0 then
                                        local showTime = OneChoiceOneShowTime + NewPlayerLimitSSRMgr.ThreeZZCharacterGoodsHideTime
                                        if curTime <= showTime then
                                            NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
                                        else
                                            NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                                        end
                                    else

                                    end
                                end
                            else
if TwoChoiceOneShowTime > 0 then
                                    local showTime = TwoChoiceOneShowTime + NewPlayerLimitSSRMgr.ThreeZZCharacterGoodsHideTime
                                    if curTime <= showTime then
                                        NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
                                    else
                                        NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                                    end
                                else

                                end
                            end
                        else
                            local showTime = DataMgr.Player.purchaseEventTime + NewPlayerLimitSSRMgr.ThreeZZCharacterGoodsHideTime
                            if curTime <= showTime then
                                NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0 ,showTime)
                            else
                                NewPlayerLimitSSRMgr.GoodsTimeMap[threeZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                            end
                        end
                    end
                end
            end

local sixZZGoods = goodsIdList[6]
if NewPlayerLimitSSRMgr.IsBoughtGoods(sixZZGoods) then
                NewPlayerLimitSSRMgr.GoodsTimeMap[sixZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Bought)
            else
                local sixZZGoodsDisplayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(sixZZGoods)
if NewPlayerLimitSSRMgr.IsBoughtGoods(threeZZGoods) then
                    if sixZZGoodsDisplayTime == 0 then
                        NewPlayerLimitSSRMgr.GoodsTimeMap[sixZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                    else
                        local closeTime = sixZZGoodsDisplayTime + NewPlayerLimitSSRMgr.GoodsExistDuration
                        SetGoodsShowingOrClose(sixZZGoods, closeTime, curTime)
                    end
else
                    local threeZZGoodsDisplayTime = NewPlayerLimitSSRMgr.GetGoodsDisplayTime(threeZZGoods)
                    if threeZZGoodsDisplayTime > 0 then
                        local showTime = threeZZGoodsDisplayTime + NewPlayerLimitSSRMgr.SixZZCharacterGoodsHideTime
                        if curTime <= showTime then
                            NewPlayerLimitSSRMgr.GoodsTimeMap[sixZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Hide, 0, showTime)
                        else
                            if sixZZGoodsDisplayTime == 0 then
                                NewPlayerLimitSSRMgr.GoodsTimeMap[sixZZGoods] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.WaitShow)
                            else
                                local closeTime = sixZZGoodsDisplayTime + NewPlayerLimitSSRMgr.GoodsExistDuration
                                SetGoodsShowingOrClose(sixZZGoods, closeTime, curTime)
                            end
                        end
                    end
                end
            end
        end
    end
end


function RefreshCharacterGoodsPurchaseTimeSortMap()
    NewPlayerLimitSSRMgr.CharacterGoodsPurchaseTimeSortMap = {}
    local heroIDList = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList
    local sortTable = {}
    for i = 1, #heroIDList do
        local purchaseTime = GetCharacterGoodsPurchaseTime(i)
        table.insert(sortTable, {
            characterID = heroIDList[i],
            value = purchaseTime == 0 and 2393562896 or purchaseTime
        })
    end
    table.sort(sortTable, function(a, b) return a.value < b.value end)
    for i, v in ipairs(sortTable) do
        NewPlayerLimitSSRMgr.CharacterGoodsPurchaseTimeSortMap[v.characterID] = i
    end
end


function NewPlayerLimitSSRMgr.UpdateTimer()
    if not ActivityMgr.IsNewPlayerLimitSSRActivityOpen() then
        NewPlayerLimitSSRMgr.IsInit = false
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRMgrTimer)
        return
    end
if not LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
        return
    end
    if LuaMgr.IsGuide() or PopUpMgr.Count() > 0 or LuaMgr.IsPanelOpen(UIName.NoticeSlapfaceViewModel) or LuaMgr.IsPanelOpen("Laigu.ViewModel.TakeCard.NewCardShowViewModel")
        or LuaMgr.IsPanelOpen("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel") or LuaMgr.IsPanelOpen(UIName.NewCardSkinViewModel) or LuaMgr.IsPanelOpen(UIName.ItemGetViewModel) or LuaMgr.IsPanelOpen(UIName.BalatroLaunchPanel) then
        return
    end

    if LuaMgr.IsPanelOpen(UIName.MainPageViewModel) and not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitSSRPopup) and (not NewPlayerLimitSSRMgr.CheckActivityIsShown() or NewPlayerLimitSSRMgr.firstShowNewPlayerLimitSSRPopup) then
        LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitSSRPopup)
        return
    end
    local curTime = LuaMgr.Timestamp()
    for listIndex, goodsList in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
        for goodsIndex = 1, #goodsList do
            local goodsId = goodsList[goodsIndex]
            local goodsData = NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId]
            if goodsData ~= nil then
                if goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.WaitShow or (goodsData.status == NewPlayerLimitSSRMgr.GoodsStatus.Hide and curTime > goodsData.openTime) then
                    NewPlayerLimitSSRMgr.RefreshData()
                    if (goodsIndex == 2 or goodsIndex == 3) and not NewPlayerLimitSSRMgr.isAddPageToPopupList then
                        if not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitSSRAdPopup) then
                            NewPlayerLimitSSRMgr.isAddPageToPopupList = true
                            if LuaMgr.IsPanelOpen(UIName.NewPlayerLimitSSRPopup) then
                                LuaMgr.InvokeUIEventListeners(UIEventConst.NewPlayerLimitSSRRefresh);
                            else
                                if LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
                                    LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitSSRPopup)
                                else
                                    PopUpMgr.Insert(UIName.NewPlayerLimitSSRPopup);
                                end
                            end
                        end
                    elseif (goodsIndex == 4 or goodsIndex == 5 or goodsIndex == 6) and not NewPlayerLimitSSRMgr.isAddAdPageToPopupList then
                        if not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitSSRPopup) and not LuaMgr.IsPanelOpen(UIName.NewPlayerLimitSSRAdPopup) then
                            NewPlayerLimitSSRMgr.isAddAdPageToPopupList = true
                            if LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
                                LuaMgr.ShowLuaPanel(UIName.NewPlayerLimitSSRAdPopup)
                            else
                                PopUpMgr.Insert(UIName.NewPlayerLimitSSRAdPopup);
                            end
                        end
                    end
                end
            end
        end
    end
end

function NewPlayerLimitSSRMgr.GetNewPlayerLimitEntranceTimerStr()
    if not NewPlayerLimitSSRMgr.CheckActivityIsShown() then
        return ""
    end
    
    local curTime = LuaMgr.Timestamp()
    local isShow = false
    local minLeftTime = 2078385396
    for k, v in pairs(NewPlayerLimitSSRMgr.GoodsTimeMap) do
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

function NewPlayerLimitSSRMgr.CheckActivityIsShown()
    return DataMgr.Player.accountVersion == 1 and DataMgr.Player.purchaseEventTime > 0
end

function NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(goodsId)
    local purchaseTime = DataMgr.Player.shop.purchaseTime
    if IsNull(purchaseTime) or next(purchaseTime) == nil then
        return 0
    end
    return purchaseTime[goodsId] ~= nil and purchaseTime[goodsId] or 0
end

function NewPlayerLimitSSRMgr.GetGoodsDisplayTime(goodsId)
    local goodsDisplayTime = DataMgr.Player.goodsDisplayTime
    if IsNull(goodsDisplayTime) or next(goodsDisplayTime) == nil then
        return 0
    end
    return goodsDisplayTime[goodsId] ~= nil and goodsDisplayTime[goodsId] or 0
end

function NewPlayerLimitSSRMgr.IsBoughtGoods(goodsId)
    local records = DataMgr.Player.shop.records
    if IsNull(records) or next(records) == nil then
        return false
    end
    return records[goodsId] == 1
end

function NewPlayerLimitSSRMgr.GetGoodsPriceSymbol(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    local Symbol = ""
    if charge.ChargeGroup~=nil and charge.ChargeGroup~="" then
        local chargeChanel=ConfigHelper.GetChargeChannel(charge.ChargeGroup)
        Symbol = chargeChanel.CurrencySymbol
    end
    return Symbol
end

function NewPlayerLimitSSRMgr.GetGoodsPrice(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    local Price = ""
    if charge.ChargeGroup~=nil and charge.ChargeGroup~="" then
        local chargeChanel=ConfigHelper.GetChargeChannel(charge.ChargeGroup)
        Price = chargeChanel.PriceShow
    end
    return tonumber(Price)
end

function NewPlayerLimitSSRMgr.GetGoodsPriceStr(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    local RMBPrice = ""
    if charge.ChargeGroup~=nil and charge.ChargeGroup~="" then
        local chargeChanel=ConfigHelper.GetChargeChannel(charge.ChargeGroup)
        RMBPrice=chargeChanel.CurrencySymbol..chargeChanel.PriceShow
    end
    return RMBPrice
end


function GetOtherTwoGoodsList(index)
    local list1 = nil
    local list2 = nil
    for i, v in ipairs(NewPlayerLimitSSRMgr.HeroGoodsIDList) do
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


function IsBougthCharacterGoods(listIndex)
    local isBought = false
    isBought = isBought or NewPlayerLimitSSRMgr.IsBoughtGoods(NewPlayerLimitSSRMgr.HeroGoodsIDList[listIndex][1])
    isBought = isBought or NewPlayerLimitSSRMgr.IsBoughtGoods(NewPlayerLimitSSRMgr.HeroGoodsIDList[listIndex][2])
    isBought = isBought or NewPlayerLimitSSRMgr.IsBoughtGoods(NewPlayerLimitSSRMgr.HeroGoodsIDList[listIndex][3])
    local list1, list2 = GetOtherTwoGoodsList(listIndex)
    isBought = isBought or NewPlayerLimitSSRMgr.IsBoughtGoods(list1[7])
    isBought = isBought or NewPlayerLimitSSRMgr.IsBoughtGoods(list2[7])
    return isBought
end


function GetCharacterGoodsPurchaseTime(listIndex)
    local purchaseTime = 0
    purchaseTime = math.max(purchaseTime, NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(NewPlayerLimitSSRMgr.HeroGoodsIDList[listIndex][1]))
    purchaseTime = math.max(purchaseTime, NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(NewPlayerLimitSSRMgr.HeroGoodsIDList[listIndex][2]))
    purchaseTime = math.max(purchaseTime, NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(NewPlayerLimitSSRMgr.HeroGoodsIDList[listIndex][3]))
    local list1, list2 = GetOtherTwoGoodsList(listIndex)
    purchaseTime = math.max(purchaseTime, NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(list1[7]))
    purchaseTime = math.max(purchaseTime, NewPlayerLimitSSRMgr.GetGoodsPurchaseTime(list2[7]))
    return purchaseTime
end

function GetCharacterLevelByListIndex(listIndex)
    local level = 0
    local characterId = ConfigMgr.Config.constants.NewPlayerLimitSSRHeroList[listIndex]
    local data = DataMgr.Player.characters[characterId]
    if data == nil then return level end
    level = data.level
    return level
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
        NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Showing, closeTime)
    else
        NewPlayerLimitSSRMgr.GoodsTimeMap[goodsId] = GetGoodsTimeItem(NewPlayerLimitSSRMgr.GoodsStatus.Close)
    end
end

function NewPlayerLimitSSRMgr.OnChangeData(data)
    local type=tostring(data[0]);
    if type ~= "characters" then return end;
    NewPlayerLimitSSRMgr.RefreshData()
end

function NewPlayerLimitSSRMgr.OnFirstMainPage()
    NewPlayerLimitSSRMgr.firstShowNewPlayerLimitSSRPopup = true
end

return NewPlayerLimitSSRMgr;