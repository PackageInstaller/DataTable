require("ViewModel/Management/ViewItem/EarningCoinItem")
local objs = {
    effectPrefab = {path = "template/UI_goUIEffect_trail", type = UITool.GameObject},
    effectPosObj = {path = "template/EffectPosObj", type = UITool.GameObject},
    effectParent = {path = "root/Middle/EffectParent", type = UITool.RectTransform},
    currencyPosTrans = {path = "root/Middle/EffectParent/CurrencyPos", type = UITool.Transform},
    delegatedBtn = {path = "root/Middle/DelegatedBtn", type = UITool.Button},
    hardDelegatedBtn = {path = "root/Middle/HardDelegatedBtn", type = UITool.Button},
    passBtn = {path = "root/Middle/PassBtn", type = UITool.Button},
    shopBtn = {path = "root/Middle/ShopBtn", type = UITool.Button},
    rewardBtn = {path = "root/Middle/RewardBtn", type = UITool.Button},
    novelBtn = {path = "root/Middle/NovelBtn", type = UITool.Button},
    collectMedalBtn = {path = "root/Middle/Title/CollectBtn", type = UITool.Button},
    downTimeTxt = {path = "root/Middle/Title/DownTimeBG/DownTimeTxt", type = UITool.Text},
    collectText = {path = "root/Middle/Title/CollectBtn/CollectText", type = UITool.Text},
    levelGroup = {path = "root/Middle/LevelGroup", type = UITool.Button},
    earningsSpeed = {path = "root/Middle/LevelGroup/EarningsSpeed", type = UITool.Text},
    levelTxt = {path = "root/Middle/LevelGroup/LevelTxt", type = UITool.Text},
    maxLevelFlag = {path = "root/Middle/LevelGroup/LevelTxt/MaxLevelFlag", type = UITool.GameObject},
    normalLevelFlag = {path = "root/Middle/LevelGroup/LevelTxt/NormalLevelFlag", type = UITool.GameObject},
    luckyGroup = {path = "root/LuckyGroup", type = UITool.GameObject},
    luckyRewardParent = {path = "root/LuckyGroup/RewardParent", type = UITool.Transform},
    luckyGetBtn = {path = "root/LuckyGroup/GetBtn", type = UITool.Button},
    levelUpGroup = {path = "root/LevelUpGroup", type = UITool.Button},
    uplevelBtn = {path = "root/LevelUpGroup/UplevelBtn", type = UITool.Button},
    upBeforeLevel = {path = "root/LevelUpGroup/InfoGroup/LevelGroup/UpBeforeLevel", type = UITool.Text},
    upAfterLevel = {path = "root/LevelUpGroup/InfoGroup/LevelGroup/UpAfterLevel", type = UITool.Text},
    uplevelMaxLevelFlag = {path = "root/LevelUpGroup/InfoGroup/LevelGroup/MaxLevelFlag", type = UITool.GameObject},
    upLevelEffect = {path = "root/LevelUpGroup/InfoGroup/LevelGroup/Effect", type = UITool.GameObject},
    upSpeedEffect = {path = "root/LevelUpGroup/InfoGroup/SpeedGroup/Effect", type = UITool.GameObject},
    upBeforeSpeed = {path = "root/LevelUpGroup/InfoGroup/SpeedGroup/UpBeforeSpeed", type = UITool.Text},
    upAfterSpeed = {path = "root/LevelUpGroup/InfoGroup/SpeedGroup/UpAfterSpeed", type = UITool.Text},
    uplevelearningsTxt = {path = "root/LevelUpGroup/UplevelBtn/TotalEarningsGroup/EarningsTxt", type = UITool.Text},
    infoGroup = {path = "root/LevelUpGroup/InfoGroup", type = UITool.Transform},
    collectConfirmGroup = {path = "root/CollectConfirmGroup", type = UITool.Button},
    maxTimeFlag = {path = "root/CollectConfirmGroup/MaxTimeFlag", type = UITool.GameObject},
    confirmCollectBtn = {path = "root/CollectConfirmGroup/GetBtn", type = UITool.Button},
    curLevel = {path = "root/CollectConfirmGroup/CurLevel", type = UITool.Text},
    collectMaxLevelFlag = {path = "root/CollectConfirmGroup/MaxLevelFlag", type = UITool.GameObject},
    managementTime = {path = "root/CollectConfirmGroup/Time", type = UITool.Text},
    collectCoinCount = {path = "root/CollectConfirmGroup/TotalEarningsGroup/EarningsTxt", type = UITool.Text}
}

local this = {

    earingCoinItems = {},

    rewardCache = {},
    gridWorldPos = {},
    effectPools = {},
    levelLanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27107"),
    coinSpeedLanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27112")
}

this.before_awake = function()
    this.coinObjs = {
        this.levelGroup.gameObject,
        this.delegatedBtn.gameObject,
        this.hardDelegatedBtn.gameObject,
        this.passBtn.gameObject,
        this.shopBtn.gameObject,
        this.rewardBtn.gameObject
    }
    RedMgr.Singleton:RegisterViewModel(UIName.ManagementHomePanel)
    this.InitCoinItems(this.coinObjs)
    this.InitCollectEffectParam(this.coinObjs)
end

this.before_active = function()
    SetActive(this.collectConfirmGroup.gameObject, false)
    SetActive(this.levelUpGroup.gameObject, false)
    SetActive(this.luckyGroup, false)
    ManagementData.CheckRed()
    local noCompleteDelegateRed = ManagementData.CheckExistNoCompleteDelegate()
    RedMgr.Singleton:SetRedState(ManagementConst.RedPoint.Delegate, noCompleteDelegateRed)
    this.Refresh()
    this.OnAfterBattle()
end

this.OnAfterBattle = function()
    if ManagementData.CheckActivityRunning(true) == false then
        return
    end
    local needOpenDelegate, _ = ManagementData.NeedOpenDelegate()
    if needOpenDelegate == true then
        LuaMgr.ShowLuaPanel(UIName.DelegatedPanel)
    end
end

this.BatchInitNode = function()
    for i = 1, #ManagementConst.FixItemIDs do
        local tempData = {}
        local name = "textNum" .. i
        tempData.path = string.format("root/Middle/EffectParent/TopBarItem%d/Group/textNum", i)
        tempData.type = UITool.Text
        objs[name] = tempData

        local name1 = "btnClick" .. i
        local tempData1 = {}
        tempData1.path = string.format("root/Middle/EffectParent/TopBarItem%d/Group/btnClick", i)
        tempData1.type = UITool.Button
        objs[name1] = tempData1

        local name2 = "textNumAnim" .. i
        local tempData2 = {}
        tempData2.path = tempData.path
        tempData2.type = UITool.Animator
        objs[name2] = tempData2
    end
end



this.OnClickDelegatedBtn = function()
    if ManagementData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DelegatedPanel)
    end
end
this.OnClickHardDelegatedBtn = function()
    if ManagementData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.HardDelegatedPanel)
    end
end
this.OnClickPassBtn = function()
    if ManagementData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel)
    end
end
this.OnClickShopBtn = function()
    if ManagementData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ManagementShopPanel)
    end
end
this.OnClickRewardBtn = function()
    if ManagementData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DelegatedRewardPanel)
    end
end
this.OnClickNovelBtn = function()
    if ManagementData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ManagementNovelPanel)
    end
end
this.OnClickMedalCollectBtn = function()
    if ManagementData.CheckActivityRunning() then
        local medalDatas = ManagementConst.MedalActivityID1
        LuaMgr.ShowLuaPanel(UIName.ActivityCollectPanel, medalDatas, "#CF54AE")
    end
end

this.OnClickBackBtn = function()
    if this.luckyGroup.gameObject.activeSelf == true then
        SetActive(this.luckyGroup.gameObject, false)
        this.vmBehaviour:UpdateTopBar("", nil)
    end
    if this.levelUpGroup.gameObject.activeSelf == true then
        SetActive(this.levelUpGroup.gameObject, false)
        this.vmBehaviour:UpdateTopBar("", nil)
    end
    if this.collectConfirmGroup.gameObject.activeSelf == true then
        SetActive(this.collectConfirmGroup.gameObject, false)
        this.vmBehaviour:UpdateTopBar("", nil)
    end
end




this.OnTriggerLucky = function(res)
    local datas = res.result.RandomGiftReward
    if NumTool.GetLen(datas) == 0 then
        return
    end
    this.vmBehaviour:UpdateTopBar("", this.OnClickBackBtn)
    SetActive(this.luckyGroup, true)
    for key, value in pairs(this.rewardCache) do
        SetActive(value.object, false)
    end
    local index = 1
    local scale = 0.8
    for key, count in pairs(datas) do
        local item = this.rewardCache[index]
        if item == nil then
            item = GoodsDataItem.New(this.luckyRewardParent)
            table.insert(this.rewardCache, item)
        end
        local itemConfig = ConfigMgr.Config.itemMap[key]
        local itemData = table.Copy(itemConfig)
        itemData.count0 = count
        item:SetData(1, itemData, 1, false, Vector3(scale, scale, scale), false)
        item:SetCount(nil, Vector2(-10, 10), Vector3.one)
        item:SetIconBg(false)
        index = index + 1
    end
end

this.OnClickLuckyGetBtn = function()
    SetActive(this.luckyGroup, false)
    this.vmBehaviour:UpdateTopBar("", nil)
end

this.OnClickBack = function()
    if this.luckyData ~= nil then
        return
    end
    LuaMgr.Back()
end

this.GetRewardItem = function()
    if this.rewardCache == nil then
        this.rewardCache = {}
    end
    local item = table.remove(this.rewardCache, 1)
    if item == nil then
        item = table.insert(this.rewardCache, item)
    end
    return item
end




this.OnClickLevelGroup = function()
    local maxReputationLevel = ManagementData.GetMaxReputationLevel()
    if DataMgr.Player.SmallShopData.Level >= maxReputationLevel then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27106")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end

    local totalCoin = ManagementData.GetLastGetCoinTime()
    if totalCoin > 0 then
        this.OnClickConfirmCollectBtn()
    end
    SetActive(this.levelUpGroup.gameObject, true)
    this.vmBehaviour:UpdateTopBar("", this.OnClickBackBtn)
    this.RefreshUpLevelUI()
end

this.RefreshUpLevelUI = function()
    local maxReputationLevel = ManagementData.GetMaxReputationLevel()
    local curLevel = DataMgr.Player.SmallShopData.Level
    local nextLevel = curLevel + 1
    nextLevel = math.min(nextLevel, maxReputationLevel)
    local deltaCount = 0
    if curLevel == 0 then
        deltaCount = ManagementData.GetLevelUpNeedItem(nextLevel).count
    else
        local uplevelBeforeCount = ManagementData.GetLevelUpNeedItem(curLevel).count
        local costReputationCount = ManagementData.GetLevelUpNeedItem(nextLevel).count
        deltaCount = costReputationCount - uplevelBeforeCount
    end
    this.upBeforeLevel.text = string.format(this.levelLanStr, curLevel)
    this.upAfterLevel.text = string.format(this.levelLanStr, nextLevel)
    local curSpeed = ManagementData.GetCoinSpeedByLevel(curLevel)
    local nextSpeed = ManagementData.GetCoinSpeedByLevel(nextLevel)
    this.upBeforeSpeed.text = string.format(this.coinSpeedLanStr, curSpeed * 12)
    this.upAfterSpeed.text = string.format(this.coinSpeedLanStr, nextSpeed * 12)
    this.uplevelearningsTxt.text = string.format("%d", deltaCount)
    SetActive(this.uplevelMaxLevelFlag, curLevel >= maxReputationLevel)
    local isMaxLevel = curLevel == maxReputationLevel
    SetActive(this.upBeforeLevel.gameObject, isMaxLevel == false)
    SetActive(this.upBeforeSpeed.gameObject, isMaxLevel == false)
    SetActive(this.uplevelBtn.gameObject, isMaxLevel == false)
    if isMaxLevel == false then
        this.infoGroup.localPosition = Vector3.zero
    else
        this.infoGroup.localPosition = Vector3(0, -25.5, 0)
    end
end

this.OnClickLevelupBtn = function()
    local curLevel = DataMgr.Player.SmallShopData.Level
    local nextLevel = curLevel + 1
    local maxReputationLevel = ManagementData.GetMaxReputationLevel()
    if nextLevel > maxReputationLevel then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27116")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local costItem = ManagementData.GetLevelUpNeedItem(nextLevel)
    local deltaCount = 0
    if curLevel == 0 then
        deltaCount = costItem.count
    else
        local uplevelBeforeCount = ManagementData.GetLevelUpNeedItem(curLevel).count
        local costReputationCount = ManagementData.GetLevelUpNeedItem(nextLevel).count
        deltaCount = costReputationCount - uplevelBeforeCount
    end
    local itemServerData = DataMgr.Player.items[costItem.id]
    local ownerReputation = itemServerData and itemServerData.count0 or 0
    if deltaCount > ownerReputation then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27109")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    SetActive(this.upLevelEffect, true)
    SetActive(this.upSpeedEffect, true)
    local callBack = function()
        SetActive(this.upLevelEffect, false)
        SetActive(this.upSpeedEffect, false)
    end
    this.succTweenSeq = DOTWeen:Sequence()
    local during = 1
    this.succTweenSeq:AppendInterval(during):OnComplete(callBack)
    local data = {}
    local onSucc = function(result)
        local re = json.decode(result)
        this.Refresh()
        this.RefreshUpLevelUI()
        ManagementData.CheckRed()
        RedMgr.Singleton:Refresh()
    end
    ApiMgr.Request("smallShop/upgrade", data, true, onSucc, nil, true)
end

this.OnClickLevelUpGroup = function()
    SetActive(this.levelUpGroup.gameObject, false)
    this.vmBehaviour:UpdateTopBar("", nil)
end





this.InitCoinItems = function(coinObjs)
    for i = 1, #coinObjs do
        local coinObj = coinObjs[i]
        local coinItem = EarningCoinItem.New(coinObj, this.OnCollectCoin)
        table.insert(this.earingCoinItems, #this.earingCoinItems + 1, coinItem)
    end
end

this.RefreshCoinItems = function()
    local maxReputationLevel = ManagementData.GetMaxReputationLevel()
    this.levelTxt.text = string.format("%d/%d", DataMgr.Player.SmallShopData.Level, maxReputationLevel)
    SetActive(this.maxLevelFlag, DataMgr.Player.SmallShopData.Level >= maxReputationLevel)
    SetActive(this.normalLevelFlag, ManagementData.CheckCanLevelUp())
    local totalCoin, earningSpeedRate = ManagementData.GetLastGetCoinTime()
    local speedRateStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27110")
    this.earningsSpeed.text = string.format(speedRateStr, earningSpeedRate * 12)
    if totalCoin == 0 then
        for key, value in pairs(this.earingCoinItems) do
            SetActive(value.coinBtn.gameObject, false)
        end
        return
    end
    if this.managementValue == nil then
        this.managementValue = {}
        for i = 1, #ConfigMgr.Config.constants.ManagementValueSplit do
            table.insert(this.managementValue, #this.managementValue + 1, tonumber(ConfigMgr.Config.constants.ManagementValueSplit[i]))
        end
    end
    this.earingCoinItems[1]:SetCount(totalCoin)
    SetActive(this.earingCoinItems[1].coinBtn.gameObject, true)
    local costCoinNum = 0
    for i = 2, #this.earingCoinItems - 1 do
        local item = this.earingCoinItems[i]
        local ratio = this.managementValue[i - 1]
        local allocate = math.floor(ratio * totalCoin * 0.01)
        costCoinNum = costCoinNum + allocate
        item:SetCount(allocate)
        SetActive(item.coinBtn.gameObject, true)
    end
    this.earingCoinItems[#this.earingCoinItems]:SetCount(totalCoin - costCoinNum)
    SetActive(this.earingCoinItems[#this.earingCoinItems].coinBtn.gameObject, true)
end

this.OnCollectCoin = function()
    local totalCoin, _, lastGetTime = ManagementData.GetLastGetCoinTime()
    if totalCoin < 1 then
        return
    end
    SetActive(this.collectConfirmGroup.gameObject, true)
    this.vmBehaviour:UpdateTopBar("", this.OnClickBackBtn)
    this.curLevel.text = string.format(this.levelLanStr, DataMgr.Player.SmallShopData.Level)
    local maxReputationLevel = ManagementData.GetMaxReputationLevel()
    SetActive(this.collectMaxLevelFlag, DataMgr.Player.SmallShopData.Level == maxReputationLevel)
    local curTime = LuaMgr.Timestamp()
    local deltaTime = curTime - lastGetTime
    local hour, _, _ = GetTimeHMS2(deltaTime)
    local maxHour = 24
    hour = math.min(hour, maxHour)
    SetActive(this.maxTimeFlag, hour == maxHour)
    local timeStr = ""
    if hour < 1 then
        timeStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27114")
    else
        timeStr = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27113"), hour)
    end
    this.managementTime.text = timeStr
    this.collectCoinCount.text = string.format("+%d", totalCoin)
end

this.OnClickConfirmCollectBtn = function()
    local data = {}
    this.vmBehaviour:UpdateTopBar("", nil)
    local onSucc = function(result)
        SetActive(this.collectConfirmGroup.gameObject, false)
        local re = json.decode(result)
        this.luckyData = re
        if this.collectCor ~= nil then
            coroutine_runner.stop(this.collectCor)
            this.collectCor = nil
        end
        ManagementData.CheckRed()
        this.collectCor = coroutine_runner.start(this.PlayCollectAnim)
    end
    ApiMgr.Request("smallShop/collect", data, true, onSucc, nil, true)
end

this.OnCollectConfirmGroup = function()
    SetActive(this.collectConfirmGroup.gameObject, false)
    this.vmBehaviour:UpdateTopBar("", nil)
end


this.InitOwnerCurrency = function()
    this.currencyCounts = {}
    for i = 1, #ManagementConst.FixItemIDs do
        local itemID = ManagementConst.FixItemIDs[i]
        local itemServerData = DataMgr.Player.items[itemID]
        local itemCount = itemServerData and itemServerData.count0 or 0
        this.currencyCounts[itemID] = itemCount
    end
    this.RefreshOwnerCurrency()
    ManagementData.CheckRed()
    RedMgr.Singleton:Refresh()
end


this.RefreshOwnerCurrency = function()
    for i = 1, #ManagementConst.FixItemIDs do
        local name = "textNum" .. i
        local itemID = ManagementConst.FixItemIDs[i]
        local itemCount = this.currencyCounts[itemID] or 0
        itemCount = math.max(0, itemCount)
        this[name].text = LuaMgr.NumFormat(itemCount)
    end
end


this.InitCollectEffectParam = function(coinObjs)
    this.currencyPos = this.currencyPosTrans.anchoredPosition
    this.gridWorldPos = {}
    for i = 2, #coinObjs do
        local obj = coinObjs[i]
        local newObj = LuaMgr.InstantiateGO(this.effectPosObj, this.effectParent, false)
        newObj.transform.position = obj.transform.position
        this.gridWorldPos[i] = newObj.transform.localPosition
        SetActive(newObj, false)
    end
end

this.PlayCollectAnim = function()
    this.isPlayAnim = true
    local step1AnimTime = ManagementConst.Step1AniTime
    this.effectActivePools = {}
    for key, startPos in pairs(this.gridWorldPos) do
        local effect = this.GetEffectObj(startPos)
        table.insert(this.effectActivePools, effect)
        SetActive(effect.gameObject, true)
        effect.transform:DOLocalMove(this.currencyPosTrans.localPosition, step1AnimTime)
    end
    coroutine_runner.wait(step1AnimTime)

    for key, value in pairs(this.effectActivePools) do
        SetActive(value.gameObject, false)
        LuaMgr.DestroyGO(value.gameObject)
    end
    coroutine_runner.wait(step1AnimTime)
    if this.luckyData ~= nil then
        this.OnTriggerLucky(this.luckyData)
    end
    this.luckyData = nil
    this.RefreshCoinItems()
    this.InitOwnerCurrency()
end

this.GetEffectObj = function(pos)
    if #this.effectPools > 0 then
        local obj = table.remove(this.effectPools)
        if pos ~= nil then
            obj.transform.localPosition = pos
        else
            obj.transform.anchoredPosition = this.currencyPos
        end
        return obj
    end
    local objNew = LuaMgr.InstantiateGO(this.effectPrefab, this.effectParent, false)
    if pos ~= nil then
        objNew.transform.localPosition = pos
    else
        objNew.transform.anchoredPosition = this.currencyPos
    end
    return objNew
end




this.OnUpdateMedalCollect = function()
    local medalActivityID1 = ManagementConst.MedalActivityID1
    local finishMedalCount1 = DataExHelper.GetMedalFinishCount(medalActivityID1)
    local medalList1 = DataExHelper.GetMedalList(medalActivityID1)

    local totalFinishMedalCount = finishMedalCount1
    this.medalList = {}
    this.AddMedalList(medalList1)
    this.collectText.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), totalFinishMedalCount, #this.medalList)
    PlayerMedalMgr.CheckMedalPopup(medalActivityID1)
end

this.AddMedalList = function(list)
    for key, value in pairs(list) do
        table.insert(this.medalList, value)
    end
end


this.Refresh = function()
    SetActive(this.luckyGroup, false)
    this.OnUpdateMedalCollect()
    this.RefreshCoinItems()
    this.InitOwnerCurrency()
end

this.OnRefreshTime = function()
    this.downTimeTxt.text = ManagementData.GetRemainTimeStr()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.delegatedBtn, this.OnClickDelegatedBtn)
        LuaMgr.AddClick(this.hardDelegatedBtn, this.OnClickHardDelegatedBtn)
        LuaMgr.AddClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.AddClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.AddClick(this.rewardBtn, this.OnClickRewardBtn)
        LuaMgr.AddClick(this.novelBtn, this.OnClickNovelBtn)
        LuaMgr.AddClick(this.collectMedalBtn, this.OnClickMedalCollectBtn)
        LuaMgr.AddClick(this.levelGroup, this.OnClickLevelGroup)
        LuaMgr.AddClick(this.uplevelBtn, this.OnClickLevelupBtn)
        LuaMgr.AddClick(this.confirmCollectBtn, this.OnClickConfirmCollectBtn)
        LuaMgr.AddClick(this.luckyGetBtn, this.OnClickLuckyGetBtn)
        LuaMgr.AddClick(this.levelUpGroup, this.OnClickLevelUpGroup)
        LuaMgr.AddClick(this.collectConfirmGroup, this.OnCollectConfirmGroup)
        LuaMgr.AddUIEventListener(UIEventConst.ManagementRefreshCurrency, this.InitOwnerCurrency)
        this.before_awake()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.vmBehaviour = vm.behaviour
        LuaMgr.AddTimer(TimerConst.ManagementDownTimer, this.OnRefreshTime, 60, -1, true)
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.ManagementDownTimer)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.delegatedBtn, this.OnClickDelegatedBtn)
        LuaMgr.RemoveClick(this.hardDelegatedBtn, this.OnClickHardDelegatedBtn)
        LuaMgr.RemoveClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickRewardBtn)
        LuaMgr.RemoveClick(this.novelBtn, this.OnClickNovelBtn)
        LuaMgr.RemoveClick(this.collectMedalBtn, this.OnClickMedalCollectBtn)
        LuaMgr.RemoveClick(this.levelGroup, this.OnClickLevelGroup)
        LuaMgr.RemoveClick(this.uplevelBtn, this.OnClickLevelupBtn)
        LuaMgr.RemoveClick(this.confirmCollectBtn, this.OnClickConfirmCollectBtn)
        LuaMgr.RemoveClick(this.luckyGetBtn, this.OnClickLuckyGetBtn)
        LuaMgr.RemoveClick(this.levelUpGroup, this.OnClickLevelUpGroup)
        LuaMgr.RemoveClick(this.collectConfirmGroup, this.OnCollectConfirmGroup)
        LuaMgr.RemoveUIEventListener(UIEventConst.ManagementRefreshCurrency, this.InitOwnerCurrency)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)