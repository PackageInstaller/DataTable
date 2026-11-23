require("ViewModel/XingHaiXuYu/ViewItem/CeHuiItem")
require("ViewModel/XingHaiXuYu/ViewItem/CeHuiRewardItem")
require("ViewModel/XingHaiXuYu/ViewItem/CeHuiRuleItem")
require("ViewModel/XingHaiXuYu/Data/XingHaiConst")


local this = {
    gridCount = 9,
    ruleItemCount = 3,
    rewardItemCount = 6,

    gridItemUIs = {},

    ruleItemUIs = {},

    rewardItemUIs = {},

    lookingStatus = XingHaiConst.LookStatus.Idle,
isAutoLook = false,
gridWorldPos = {},
effectPools = {},
currencyCounts = {},
tempAddCurrencyCounts = {},
    effectActivePools = {},
    effectActivePoolsRule = {},
    ruleWorldPos = {},
    currencyPos = nil,
    rewardPos = nil,
    randomSeed = nil,
randomTimes = 0,
    canElimilateDic = {}
}

local objs = {
    commonItemPrefab = {path = "template/CommonItemPrefab", type = UITool.GameObject},
    effectPrefab = {path = "template/UI_goUIEffect_trail", type = UITool.GameObject},
    lookOnceBtn = {path = "root/Middle/Group/Left/LookOnceBtn", type = UITool.Button},
    lookAutoBtn = {path = "root/Middle/Group/Left/LookAutoBtn", type = UITool.Button},
    lookOncePriceText = {path = "root/Middle/Group/Left/LookOnceBtn/Price", type = UITool.Text},
    lookOncePriceIcon = {path = "root/Middle/Group/Left/LookOnceBtn/Price/Icon", type = UITool.RawImage},
    lookAutoPriceText = {path = "root/Middle/Group/Left/LookAutoBtn/Price", type = UITool.Text},
    lookAutoPriceIcon = {path = "root/Middle/Group/Left/LookAutoBtn/Price/Icon", type = UITool.RawImage},
    lookAutoText = {path = "root/Middle/Group/Left/LookAutoBtn/Title", type = UITool.Text},
    isFastToggle = {path = "root/Middle/Group/Left/LookAutoBtn/FastCheckBox", type = UITool.Toggle},
    downTimeTxt = {path = "root/Middle/Group/DownTimeBG/DownTimeTxt", type = UITool.Text},
    progressDesc = {path = "root/Middle/Group/Right/ProgreesObj/ProgressDesc", type = UITool.Text},
    progressText = {path = "root/Middle/Group/Right/ProgreesObj/ProgressText", type = UITool.Text},
    progress = {path = "root/Middle/Group/Right/ProgreesObj/Progress", type = UITool.Image},
    randomRewardBtn = {path = "root/Middle/Group/Right/RewardBG/RandomReward", type = UITool.Button},
    randomRewardLimitCount = {path = "root/Middle/Group/Right/RewardBG/RandomReward/TextBG/Text", type = UITool.Text},
    randomRewardNormalObj = {path = "root/Middle/Group/Right/RewardBG/RandomReward/Normal", type = UITool.GameObject},
    randomRewardCangetObj = {path = "root/Middle/Group/Right/RewardBG/RandomReward/CanGet", type = UITool.GameObject},
    randomRewardPanel = {path = "root/Middle/Group/RandomRewardPanel", type = UITool.Button},
    randomRewardScorll = {path = "root/Middle/Group/RandomRewardPanel/Group/ScrollView", type = UITool.GameObject},
    currencyPosTrans = {path = "root/Middle/Group/EffectParent/CurrencyPos", type = UITool.Transform},
    rewardPosTrans = {path = "root/Middle/Group/EffectParent/RewardPos", type = UITool.Transform},
    effectParent = {path = "root/Middle/Group/EffectParent", type = UITool.RectTransform},
    randomRewardAnim = {path = "root/Middle/Group/Right/RewardBG/RandomReward", type = UITool.Animator},
    lookAutoBtnAnim = {path = "root/Middle/Group/Left/LookAutoBtn/_Star", type = UITool.Animator}
}

this.BatchInitNode = function()
    for i = 1, this.gridCount do
        local tempData = {}
        local name = "GridItem" .. i
        tempData.path = "root/Middle/Group/Left/GridParent/" .. name
        tempData.type = UITool.GameObject
        objs[name] = tempData
    end
    for i = 1, this.ruleItemCount do
        local tempData = {}
        local name = "RuleItem" .. i
        tempData.path = "root/Middle/Group/Right/RuleBG/" .. name
        tempData.type = UITool.GameObject
        objs[name] = tempData
    end
    for i = 1, this.rewardItemCount do
        local tempData = {}
        local name = "RewardItem" .. i
        tempData.path = "root/Middle/Group/Right/RewardBG/" .. name
        tempData.type = UITool.GameObject
        objs[name] = tempData
    end

    for i = 1, #XingHaiConst.CehuiGetItemIDs do
        local tempData = {}
        local name = "textNum" .. i
        tempData.path = string.format("root/Middle/Group/EffectParent/TopBarItem%d/Group/textNum", i)
        tempData.type = UITool.Text
        objs[name] = tempData

        local name1 = "btnClick" .. i
        local tempData1 = {}
        tempData1.path = string.format("root/Middle/Group/EffectParent/TopBarItem%d/Group/btnClick", i)
        tempData1.type = UITool.Button
        objs[name1] = tempData1

        local name2 = "textNumAnim" .. i
        local tempData2 = {}
        tempData2.path = tempData.path
        tempData2.type = UITool.Animator
        objs[name2] = tempData2
    end
end

this.before_awake = function()
    this.randomRewardScorllUI = UIScrollView.New(this.randomRewardScorll)
    for i = 1, this.gridCount do
        local name = "GridItem" .. i
        local obj = this[name]
        local item = CeHuiItem.New(obj, i)
        table.insert(this.gridItemUIs, item)
        local newObj = LuaMgr.InstantiateGO(obj, this.effectParent, false)
        newObj.transform.position = obj.transform.position
        this.gridWorldPos[i] = newObj.transform.localPosition
        SetActive(newObj, false)
    end
    for i = 1, this.ruleItemCount do
        local name = "RuleItem" .. i
        local obj = this[name]
        local item = CeHuiRuleItem.New(obj, i)
        table.insert(this.ruleItemUIs, item)
        this.ruleWorldPos[i] = obj.transform.position
    end
    for i = 1, this.rewardItemCount do
        local name = "RewardItem" .. i
        local obj = this[name]
        local item = CeHuiRewardItem.New(obj, i)
        table.insert(this.rewardItemUIs, item)
    end
    this.currencyPos = this.currencyPosTrans.anchoredPosition
    this.rewardPos = this.rewardPosTrans.anchoredPosition
    this.needItem = ConfigMgr.Config.BangGameConstants["BangCost"][1]
    this.allIconConfig = ConfigMgr.Config.BangGameConstants["RandomSticker"]
    this.randomRewardGoalScore = ConfigMgr.Config.BangGameConstants["RandomNeed"][1].count
    local needCountStr = tostring(this.needItem.count)
    this.lookOncePriceText.text = needCountStr
    this.lookAutoPriceText.text = needCountStr
    this.lookOncePriceIcon.texture = GetItemHomeIcon(this.needItem.id)
    this.lookAutoPriceIcon.texture = GetItemHomeIcon(this.needItem.id)

    local ruleConstKey = {"DoubleReward", "TribleReward", "AllReward"}
    this.ruleConstDatas = {}
    for i = 1, #ruleConstKey do
        local key = ruleConstKey[i]
        local config = ConfigMgr.Config.BangGameConstants[key]
        this.ruleConstDatas[i] = config
        local item = this.ruleItemUIs[i]
        item:SetData(config)
    end
end

this.before_active = function()
    this.lookingStatus = XingHaiConst.LookStatus.Idle
    if this.allExchangeConfigs == nil then
        this.allExchangeConfigs = DataExHelper.Check_ConfigQuestEventByGroupId(XingHaiConst.CeHuiExchangeGroupID)
    end
    SetActive(this.randomRewardPanel.gameObject, false)
    this.isFastToggle.isOn = XingHaiData.GetCeHuiPlayerPrefs()
    this.isPlayAnim = false
    this.RefreshExchange()
    this.ResetLookStatus()
    this.SetInitGrid()

    this.lastGridDatas = DataMgr.Player.BumperGame.Icons
    this.lookAutoBtnAnim.enabled = false
    for i = 1, #XingHaiConst.CehuiGetItemIDs do
        local itemID = XingHaiConst.CehuiGetItemIDs[i]
        local itemCount = PlayerItemMgr.GetItemCountById(itemID)
        this.currencyCounts[itemID] = itemCount
    end
    this.tempAddCurrencyCounts = {}
    for key, itemID in pairs(XingHaiConst.CehuiGetItemIDs) do
        this.tempAddCurrencyCounts[itemID] = PlayerItemMgr.GetItemCountById(itemID)
    end
    this.CheckItemEnough()
    this.RefreshOwnerCurrency()
    this.RefreshRandomReward()
end


this.OnClickLookOnceBtn = function()
    if XingHaiData.CheckActivityRunning(ActivityKey.NewCelebration) == false then
        return
    end
    if this.lookingStatus ~= XingHaiConst.LookStatus.Idle then
        local contentTips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26508")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, contentTips)
        return
    end
    this.isAutoLook = false
    this.RequestRandomSeed()
end


this.OnClickLookAutoBtn = function()
    if XingHaiData.CheckActivityRunning(ActivityKey.NewCelebration) == false then
        return
    end
    if this.CheckItemEnough(true) == false then
        return
    end
    if this.isAutoLook == false then

        if this.isPlayAnim == true then
            local contentTips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20023")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, contentTips)
            return
        end
        this.isAutoLook = true
        this.lookAutoBtnAnim.enabled = true
        this.lookAutoText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26507")

        this.tempAddCurrencyCounts = {}
        for key, itemID in pairs(XingHaiConst.CehuiGetItemIDs) do
            this.tempAddCurrencyCounts[itemID] = PlayerItemMgr.GetItemCountById(itemID)
        end
        this.randomTimes = 0
        this.RequestRandomSeed()
    else
        this.isAutoLook = false
        this.lookAutoBtnAnim.enabled = false
        this.lookingStatus = XingHaiConst.LookStatus.Idle
        this.lookAutoText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26506")
        this.CheckItemEnough()
        this.ReportRes()
    end
end


this.OnClickRandomRewardBtn = function()
    if XingHaiData.CheckActivityRunning(ActivityKey.NewCelebration) == false then
        return
    end
    if this.lookingStatus ~= XingHaiConst.LookStatus.Idle then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26508")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local data = XingHaiData.GetXingZhiCeHuiData()
    if data.canGet == false then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26520")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local onSucc = function(res)
        local re = json.decode(res)
        if re.code ~= 0 then
            return
        end
        local reseult = re.result
        SetActive(this.randomRewardPanel.gameObject, true)
        this.RefreshRandomRewardPanel(reseult.Reward.Items)
    end
    local data = {}
    ApiMgr.Request("bumperGame/random_rewards", data, true, onSucc, nil, true)
end


this.OnClickRandomRewardPanel = function()
    SetActive(this.randomRewardPanel.gameObject, false)
end

this.OnClickTopBarItem1 = function()
    this.OpenCurrencyItemInfo(XingHaiConst.CehuiGetItemIDs[1])
end
this.OnClickTopBarItem2 = function()
    this.OpenCurrencyItemInfo(XingHaiConst.CehuiGetItemIDs[2])
end

this.OpenCurrencyItemInfo = function(itemId)
    HeroRedDataHelper.ClearBackPackGiftRed(itemId, true)
    local itemConfig = ConfigMgr.Config.itemMap[itemId]
    if itemConfig.Poke == 1 then
        return
    end
    LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, itemId, true, true, true)
end


this.RequestRandomSeed = function()
    this.randomSeed = LuaMgr.Timestamp()
    this.lookingStatus = XingHaiConst.LookStatus.StartTurnOver
    if this.isAutoLook == false then
        this.RequestLook()
    end
end

this.ReportRes = function()
    if this.randomTimes == 0 then
        return
    end
    local icons = {}
    for i = 1, this.gridCount do
        table.insert(icons, this.lastGridDatas[i])
    end
    local data = {
        Icons = icons,
        Num = this.randomTimes,
        Reward = this.tempAddCurrencyCounts
    }
    local onSucc = function(res)
        this.randomTimes = 0
    end
    ApiMgr.Request("bumperGame/observation2", data, true, onSucc, nil, false)
end

this.RequestLook = function()
    if this.CheckItemEnough(true) == false then
        this.lookAutoBtnAnim.enabled = false
        this.ResetLookStatus()
        this.ReportRes()
        return
    end
    this.OnRequestSuccess(this.GetRandomReward())
    this.randomTimes = this.randomTimes + 1
end

this.GetRandomReward = function()
    if this.randomSeed == nil then
        this.ResetLookStatus()
        return
    end
    local needRandomCount = this.emptyGridCount
    local tempGridDatas = table.Copy(this.lastGridDatas)
    local elmentNumDatas = {}
    for key, value in pairs(tempGridDatas) do
        elmentNumDatas[value] = (elmentNumDatas[value] or 0) + 1
    end
    local tempConfigDatas = {}
    for key, value in pairs(this.allIconConfig) do
        local data = {}
        data.config = value
        data.gridIndex = tonumber(value[1])
        data.randomCount = elmentNumDatas[data.gridIndex] or 0
        tempConfigDatas[data.gridIndex] = data
    end

    local randomIndexDatas = {}
    math.randomseed(LuaMgr.Timestamp())
    while true do
        if #randomIndexDatas >= needRandomCount then
            break
        end
        local canRandomDatas = {}
        for key, value in pairs(tempConfigDatas) do
            if value.randomCount < 3 then
                table.insert(canRandomDatas, value)
            end
        end
        if #canRandomDatas == 0 then
            break
        end
        local randomIndex = math.random(1, #canRandomDatas)
        local randomData = canRandomDatas[randomIndex]
        local randomGridIndex = randomData.gridIndex
        table.insert(randomIndexDatas, randomGridIndex)
        tempConfigDatas[randomGridIndex].randomCount = tempConfigDatas[randomGridIndex].randomCount + 1
    end
    local index = 1

    for key, value in pairs(tempGridDatas) do
        if value == 0 then
            tempGridDatas[key] = randomIndexDatas[index]
            index = index + 1
        end
    end


    local before = table.Copy(tempGridDatas)
    local after = {}
    local needElimilateDic = {}
    for key, iconID in pairs(tempGridDatas) do
        if needElimilateDic[iconID] == nil then
            needElimilateDic[iconID] = 1
        else
            needElimilateDic[iconID] = needElimilateDic[iconID] + 1
        end
    end

    local rewardStearDic = {}
    local isFullElimate = true
    for i = 1, this.gridCount do
        local iconID = tempGridDatas[i]
        if needElimilateDic[iconID] >= 3 then
            isFullElimate = false
            after[i] = 0
        elseif needElimilateDic[iconID] >= 2 then
            isFullElimate = false
            after[i] = 0
        else
            after[i] = iconID
        end
    end

    for key, value in pairs(needElimilateDic) do
        local rewardStear = 0
        if value >= 3 then
            rewardStear = 2
        elseif value >= 2 then
            rewardStear = 1
        end
        if rewardStear ~= 0 then
            rewardStearDic[rewardStear] = (rewardStearDic[rewardStear] or 0) + 1
        end
    end
    if isFullElimate == true then
        for i = 1, this.gridCount do
            after[i] = 0
        end
        rewardStearDic[3] = 1
    end

    local costItemID = this.needItem.id
    local costItemCount = this.needItem.count * this.emptyGridCount
    this.tempAddCurrencyCounts[costItemID] = this.tempAddCurrencyCounts[costItemID] - costItemCount
    if this.tempAddCurrencyCounts[costItemID] < 0 then
        LuaDebug.error("370=====================")
    end
    for key, value in pairs(rewardStearDic) do
        local rewardConfig = this.ruleConstDatas[key]
        for key1, value1 in pairs(rewardConfig) do
            local itemID = value1.id
            local count = value1.count * value
            this.tempAddCurrencyCounts[itemID] = (this.tempAddCurrencyCounts[itemID] or 0) + count
        end
    end
    for key, value in pairs(this.tempAddCurrencyCounts) do
        this.tempAddCurrencyCounts[key] = math.max(0, value)
    end
    return before, after
end

this.CheckItemEnough = function(isNeedTip)
    local needCount = this.needItem.count
    local ownerCount = this.tempAddCurrencyCounts[this.needItem.id]
    local emptyGridCount = 0
    for key, value in pairs(this.lastGridDatas) do
        if value == 0 then
            emptyGridCount = emptyGridCount + 1
        end
    end
    needCount = this.needItem.count * emptyGridCount
    this.emptyGridCount = emptyGridCount
    local needCountStr = ""
    if ownerCount < needCount then
        needCountStr = string.format("<color=#FF0000>%d</color>", needCount)
        this.lookAutoPriceText.text = needCountStr
        this.ResetLookStatus()
        if isNeedTip == true then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26522")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        end
        return false
    else
        needCountStr = string.format("<color=#FFFFFF>%d</color>", needCount)
        this.lookAutoPriceText.text = needCountStr
    end
    return true
end

this.ResetLookStatus = function()
    this.lookingStatus = XingHaiConst.LookStatus.Idle
    this.isAutoLook = false
    this.lookAutoText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26506")
end


this.OnRequestSuccess = function(resBefore, resAfter)
    if resBefore == nil or resAfter == nil then
        return
    end
    local strBefore, strAfter, strlast = "", "", ""
    for i = 1, 9 do
        strlast = strlast .. "|" .. this.lastGridDatas[i]
        strBefore = strBefore .. "|" .. resBefore[i]
        strAfter = strAfter .. "|" .. resAfter[i]
    end
    local deltaGrid, deltaGridCount = this.GetNewGrid(this.lastGridDatas, resBefore)
    this.lastGridDatas = table.Copy(resAfter)
    if deltaGrid == nil or deltaGridCount == 0 then
        return
    end
    this.deltaGrid = deltaGrid


    local idsToIndexDic = {}
    for i = 1, #resBefore do
        local id = resBefore[i]
        if idsToIndexDic[id] == nil then
            idsToIndexDic[id] = {}
        end
        if id ~= 0 then
            table.insert(idsToIndexDic[id], i)
        end
    end

    local canElimilateDic = {}
    local canElimilateCount = 0
    for key, value in pairs(idsToIndexDic) do
        if #value > 1 then
            canElimilateDic[key] = value
            canElimilateCount = canElimilateCount + 1
        end
    end
    this.canElimilateCount = canElimilateCount
    this.canElimilateDic = canElimilateDic

    if this.canElimilateCount == 0 then
        this.canElimilateCount = this.gridCount
        for key, value in pairs(idsToIndexDic) do
            canElimilateDic[key] = value
        end
    end
    if this.lookCoroutine then
        coroutine_runner.stop(this.lookCoroutine)
        this.lookCoroutine = nil
    end
    this.lookCoroutine = coroutine_runner.start(this.PlayAnimate)
end

this.PlayAnimate = function()
    this.isPlayAnim = true
    local step1AnimTime = XingHaiConst.Step1AniTime
    local step2AnimTime = XingHaiConst.Step2AniTime
    local step3AnimTime = 0.3
    local step4AnimTime = 0.1
    local isDoubleSpeed = this.isFastToggle.isOn == true
    if this.isAutoLook == true and isDoubleSpeed then
        step1AnimTime = step1AnimTime / 2.0
        step2AnimTime = step2AnimTime / 2.0
        step3AnimTime = step3AnimTime / 2.0
        step4AnimTime = step4AnimTime / 2.0
    end
    if isDoubleSpeed then
        XingHaiData.PlaySound(XingHaiConst.DoubleSpeedAudioName)
    else
        XingHaiData.PlaySound(XingHaiConst.NormalSpeedAudioName)
    end

    local delta1 = 0
    for key, value in pairs(this.deltaGrid) do
        local effect = this.GetEffectObj()
        table.insert(this.effectActivePools, effect)
        SetActive(effect.gameObject, true)
        local endPos = this.gridWorldPos[key]
        effect.transform:DOLocalMove(endPos, step1AnimTime)
        delta1 = delta1 + 1
    end
    this.SetShowCurencyCount(-delta1, 0)
    this.RefreshOwnerCurrency()

    coroutine_runner.wait(step1AnimTime)
    for key, value in pairs(this.deltaGrid) do
        this.gridItemUIs[key]:SetIcon(value)
    end

    for key, value in pairs(this.effectActivePools) do
        SetActive(value.gameObject, false)
        LuaMgr.DestroyGO(value.gameObject)
    end
    this.effectActivePools = {}

    coroutine_runner.wait(step3AnimTime)
    local canElimilateCount = this.canElimilateCount
    local canElimilateDic = this.canElimilateDic
    if canElimilateCount > 0 then
        if canElimilateCount == this.gridCount then
            local status = 3
            this.ruleItemUIs[status]:PlayAnim(isDoubleSpeed)
            this.effectActivePoolsRule = {}
            for key, value in pairs(canElimilateDic) do
                local effect = this.GetEffectObj(this.gridWorldPos[key])
                this.effectActivePoolsRule[key] = effect
                SetActive(effect.gameObject, true)
                local endPos = this.rewardPosTrans.localPosition
                effect.transform:DOLocalMove(endPos, step2AnimTime)

            end
            coroutine_runner.wait(step2AnimTime)

            local lookRewardConfig = this.ruleConstDatas[status]
            local getRewardCount1 = 0
            local getRewardCount2 = 0
            if type(lookRewardConfig) == "table" then
                getRewardCount1 = lookRewardConfig[1].count
                getRewardCount2 = lookRewardConfig[2].count
            end
            this.SetShowCurencyCount(getRewardCount1, getRewardCount2)
            this.PlayCurrencyAnim(getRewardCount1, getRewardCount2)
            this.RefreshOwnerCurrency()

            for _, value in pairs(this.effectActivePoolsRule) do
                value.transform.localPosition = this.currencyPosTrans.localPosition
                SetActive(value.gameObject, false)
                LuaMgr.DestroyGO(value.gameObject)
            end
            this.effectActivePoolsRule = {}
            for i = 1, #this.lastGridDatas do
                local iconID = this.lastGridDatas[i]
                local itemUI = this.gridItemUIs[i]
                itemUI:SetIcon(iconID, isDoubleSpeed, step2AnimTime)
            end
        else
            for key, value in pairs(canElimilateDic) do
                local status = 0
                if #value > 2 then
                    status = 2
                elseif #value > 1 then
                    status = 1
                end
                if status > 0 then
                    this.ruleItemUIs[status]:PlayAnim(isDoubleSpeed)
                    this.effectActivePoolsRule[key] = {}
                    for _, posIndex in ipairs(value) do
                        local effect = this.GetEffectObj(this.gridWorldPos[posIndex])
                        table.insert(this.effectActivePoolsRule[key], effect)
                        SetActive(effect.gameObject, true)
                        local endPos = this.rewardPosTrans.localPosition
                        effect.transform:DOLocalMove(endPos, step2AnimTime)
                    end

                    coroutine_runner.wait(step2AnimTime)
                    local lookRewardConfig = this.ruleConstDatas[status]
                    local getRewardCount1 = 0
                    local getRewardCount2 = 0
                    if type(lookRewardConfig) == "table" then
                        getRewardCount1 = lookRewardConfig[1].count
                        getRewardCount2 = lookRewardConfig[2].count
                    end
                    this.SetShowCurencyCount(getRewardCount1, getRewardCount2)
                    this.PlayCurrencyAnim(getRewardCount1, getRewardCount2)
                    this.RefreshOwnerCurrency()
                    for _, value in pairs(this.effectActivePoolsRule[key]) do
                        value.transform.localPosition = this.currencyPosTrans.localPosition
                        SetActive(value.gameObject, false)
                        LuaMgr.DestroyGO(value.gameObject)
                    end
                    this.effectActivePoolsRule[key] = {}
                    for i = 1, #this.lastGridDatas do
                        for _, posIndex in pairs(value) do
                            if posIndex == i then
                                local iconID = this.lastGridDatas[i]
                                local itemUI = this.gridItemUIs[i]
                                itemUI:SetIcon(iconID, isDoubleSpeed, step2AnimTime)
                            end
                        end
                    end
                end
            end
        end

        coroutine_runner.wait(step4AnimTime)
        for key, value in pairs(this.currencyCounts) do
            this.currencyCounts[key] = this.tempAddCurrencyCounts[key] or 0
        end

        if this.isAutoLook == true then
            this.lookingStatus = XingHaiConst.LookStatus.StartTurnOver
        end
        this.RefreshRandomReward()
    else
        if this.isAutoLook == true then
            this.lookingStatus = XingHaiConst.LookStatus.StartTurnOver
        end
        this.RefreshRandomReward()
    end
    this.isPlayAnim = false
end

this.ResetAnimate = function()
    if this.lookCoroutine then
        coroutine_runner.stop(this.lookCoroutine)
        this.lookCoroutine = nil
    end
    for key, value in pairs(this.effectActivePools) do
        LuaMgr.DestroyGO(value.gameObject)
    end
    this.effectActivePools = {}

    local canElimilateDic = this.canElimilateDic or {}
    for key, value in pairs(canElimilateDic) do
        if type(this.effectActivePoolsRule[key]) == "table" then
            for _, obj in pairs(this.effectActivePoolsRule[key]) do
                if not IsNull(obj) then
                    LuaMgr.DestroyGO(obj.gameObject)
                end
            end
        else
            local obj = this.effectActivePoolsRule[key]
            if not IsNull(obj) and not IsNull(obj.gameObject) then
                LuaMgr.DestroyGO(obj.gameObject)
            end
        end
    end
    this.canElimilateDic = {}
end

this.SetShowCurencyCount = function(delta1, delta2)
    local itemID1 = XingHaiConst.CehuiGetItemIDs[1]
    local itemID2 = XingHaiConst.CehuiGetItemIDs[2]
    if delta1 ~= 0 then
        this.currencyCounts[itemID1] = this.currencyCounts[itemID1] + delta1
    end
    if delta2 ~= 0 then
        this.currencyCounts[itemID2] = this.currencyCounts[itemID2] + delta2
    end
end

this.PlayCurrencyAnim = function(delta1, delta2)
    if delta1 ~= 0 then
        local name = "textNumAnim1"
        local anim = this[name]
        anim:Play("ani_XingZhiCeHuiPanel_textNum", 0, 0)
    end
    if delta2 ~= 0 then
        local name = "textNumAnim2"
        local anim = this[name]
        anim:Play("ani_XingZhiCeHuiPanel_textNum", 0, 0)
    end
end

this.RefreshOwnerCurrency = function()
    for i = 1, #XingHaiConst.CehuiGetItemIDs do
        local name = "textNum" .. i
        local itemID = XingHaiConst.CehuiGetItemIDs[i]
        local itemCount = this.currencyCounts[itemID] or 0
        itemCount = math.max(0, itemCount)
        this[name].text = LuaMgr.NumFormat(itemCount)
    end
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



this.GetNewGrid = function(beforeDatas, afterDatas)
    if beforeDatas == nil or afterDatas == nil then
        LuaDebug.error("前后数据不能为空" .. table.tostring(beforeDatas) .. "===" .. table.tostring(afterDatas))
        return nil
    end
    if NumTool.GetLen(beforeDatas) ~= NumTool.GetLen(afterDatas) then
        LuaDebug.error("前后数据长度不一致")
        return nil
    end
    local newGrid = {}
    local newGridCount = 0
    for i = 1, #beforeDatas do
        local beforeData = beforeDatas[i]
        local afterData = afterDatas[i]
        if beforeData ~= afterData then
            newGrid[i] = afterData
            newGridCount = newGridCount + 1
        end
    end
    return newGrid, newGridCount
end


this.OnRequestFaild = function(res)
end



this.OnExchangeCallback = function(item)
    if XingHaiData.CheckActivityRunning(ActivityKey.NewCelebration) == false then
        return
    end
    if this.lookingStatus ~= XingHaiConst.LookStatus.Idle then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26508")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local config = item.data.config
    local buyCount = 0
    local questData = DataMgr.Player.quests[config.id]
    if questData ~= nil then
        buyCount = config.progress - questData.progress
    end
    if buyCount <= 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18343"))
        return
    end
    local count = DataHelper.GetItemCountById(config.cost[1].id)
    count = math.floor(count / config.cost[1].count)
    if (buyCount > count) then
        buyCount = count
    end
    if (buyCount <= 0) then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26523")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local onActivityBuyTip = function(count)
        DataExHelper.EX_ShopConvert(config.id, count, this.ExchangeCallback)
    end
    LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel, config.showReward[1], config.cost, buyCount, onActivityBuyTip)
end

this.ExchangeCallback = function()
    local itemID = XingHaiConst.CehuiGetItemIDs[2]
    this.currencyCounts[itemID] = PlayerItemMgr.GetItemCountById(itemID)
    this.RefreshOwnerCurrency()
    this.RefreshExchange()
end


this.RefreshExchange = function()
    local quests = DataMgr.Player.quests
    local allDatas = {}
    if this.questEvents == nil then
        this.questEvents = DataExHelper.Check_ConfigQuestEventByText(XingHaiConst.QuestCelebrationShop)
    end
    local len = #this.questEvents
    for i = 1, len do
        local questConfig = this.questEvents[i]
        local questData = quests[questConfig.id]
        local data = {}
        data.config = questConfig
        data.totalCount = questConfig.progress
        data.cost = questConfig.cost[1]
        data.reward = questConfig.showReward[1]
        data.exchangeCount = 0
        data.rewardIsHide = i == 1
        data.exchangeCallback = this.OnExchangeCallback
        if questData ~= nil then
            data.exchangeCount = questData.progress
        end
        table.insert(allDatas, data)
    end
    for i = 1, #this.rewardItemUIs do
        local itemUI = this.rewardItemUIs[i]
        local data = allDatas[i]
        if data ~= nil then
            itemUI:SetData(data)
        end
    end
end


this.RefreshRandomReward = function()
    local data = XingHaiData.GetXingZhiCeHuiData()
    local curGotNum = DataMgr.Player.BumperGame.DailyUseCount or 0
    local maxGotNum = ConfigMgr.Config.constants.RandomGiftLimit
    local curScore = data.curScore or 0
    local itemID = XingHaiConst.CehuiGetItemIDs[2]
    local addScore = (this.tempAddCurrencyCounts[itemID] or 0) - PlayerItemMgr.GetItemCountById(itemID)
    if addScore < 0 then
        addScore = 0
    end
    local finalScore = curScore + addScore
    this.progressText.text = string.format("%d/%d", finalScore, data.goalScore)
    this.progress.fillAmount = finalScore * 1.0 / data.goalScore
    this.randomRewardLimitCount.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26528"), curGotNum, maxGotNum)

    local canGet = finalScore >= this.randomRewardGoalScore
    local canGetReward = canGet and curGotNum < maxGotNum
    SetActive(this.randomRewardNormalObj, not canGetReward)
    SetActive(this.randomRewardCangetObj, canGetReward)
    this.randomRewardAnim.enabled = canGetReward
end


this.RealRefreshRandomReward = function()
    local data = XingHaiData.GetXingZhiCeHuiData()
    local curGotNum = DataMgr.Player.BumperGame.DailyUseCount or 0
    local maxGotNum = ConfigMgr.Config.constants.RandomGiftLimit
    local finalScore = data.curScore or 0
    this.progressText.text = string.format("%d/%d", finalScore, data.goalScore)
    this.progress.fillAmount = finalScore * 1.0 / data.goalScore
    this.randomRewardLimitCount.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26528"), curGotNum, maxGotNum)

    local canGet = finalScore >= this.randomRewardGoalScore
    local canGetReward = canGet and curGotNum < maxGotNum
    SetActive(this.randomRewardNormalObj, not canGetReward)
    SetActive(this.randomRewardCangetObj, canGetReward)
    this.randomRewardAnim.enabled = canGetReward
end

this.SetInitGrid = function()
    local curData = DataMgr.Player.BumperGame.Icons
    if #curData ~= this.gridCount then
        return
    end
    for i = 1, #curData do
        local iconIndex = curData[i]
        local item = this.gridItemUIs[i]
        item:SetIcon(iconIndex)
    end
end

this.RefreshRandomRewardPanel = function(datas)
    if type(datas) ~= "table" then
        return
    end
    local scrollDatas = {}
    this.randomRewardScorllUI:Clear()
    for key, data in pairs(datas) do
        local scrollData = UIScrollData.GetData(this.commonItemPrefab, "CommonRewardItem", 140, 168, data)
        table.insert(scrollDatas, scrollData)
    end
    this.randomRewardScorllUI:SetParams(586.7, 168)
    this.randomRewardScorllUI:SetData(scrollDatas, true)
    this.RealRefreshRandomReward()
end


this.OnRefreshTime = function()
    this.downTimeTxt.text = XingHaiData.GetRemainTimeStr()
end

this.TimeScale = function(timeScale)
    UnityEngine.Time.timeScale = timeScale
end

this.OnUpdate = function()
    if this.isAutoLook ~= true then
        return
    end
    if this.lookingStatus == XingHaiConst.LookStatus.Idle then
        return
    end
    if this.lookingStatus == XingHaiConst.LookStatus.StartTurnOver then
        if this.CheckItemEnough() == false then
            this.ReportRes()
            return
        end
        this.RequestLook()
        this.lookingStatus = XingHaiConst.LookStatus.TurnOvering
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.lookOnceBtn, this.OnClickLookOnceBtn)
        LuaMgr.AddClick(this.lookAutoBtn, this.OnClickLookAutoBtn)
        LuaMgr.AddClick(this.randomRewardBtn, this.OnClickRandomRewardBtn)
        LuaMgr.AddClick(this.randomRewardPanel, this.OnClickRandomRewardPanel)
        local name1, name2 = "btnClick1", "btnClick2"
        LuaMgr.AddClick(this[name1], this.OnClickTopBarItem1)
        LuaMgr.AddClick(this[name2], this.OnClickTopBarItem2)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.before_active()
        LuaMgr.AddUpdate(this.OnUpdate)
        LuaMgr.AddTimer(TimerConst.XingZhiCeHuiTimer, this.OnRefreshTime, 60, -1, true)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveUpdate(this.OnUpdate)
        LuaMgr.RemoveTimer(TimerConst.XingZhiCeHuiTimer)
        XingHaiData.SaveCeHuiPlayerPrefs(this.isFastToggle.isOn)
        this.ReportRes()
        this.ResetAnimate()
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.lookOnceBtn, this.OnClickLookOnceBtn)
        LuaMgr.RemoveClick(this.lookAutoBtn, this.OnClickLookAutoBtn)
        LuaMgr.RemoveClick(this.randomRewardBtn, this.OnClickRandomRewardBtn)
        LuaMgr.RemoveClick(this.randomRewardPanel, this.OnClickRandomRewardPanel)
        local name1, name2 = "btnClick1", "btnClick2"
        LuaMgr.RemoveClick(this[name1], this.OnClickTopBarItem1)
        LuaMgr.RemoveClick(this[name2], this.OnClickTopBarItem2)
        UIScrollView.ClearItem("CeHuiRewardItem")
        UIScrollView.ClearItem("CommonRewardItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)