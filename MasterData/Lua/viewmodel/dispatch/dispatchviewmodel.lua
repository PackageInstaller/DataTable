







require("ViewModel/Dispatch/ListViewItem/DispatchHeroGroup")
require("ViewModel/Dispatch/ListViewItem/DispatchCondItem")
require("ViewModel/Dispatch/ListViewItem/DispatchStageToggle")
local objs = {
    characterHeadGroup = {path = "template/CharacterHeadGroup", type = UITool.GameObject},
    characterHead = {path = "template/CharacterHead", type = UITool.GameObject},
    listCharacterHeadCell = {path = "template/ListCharacterHeadCell", type = UITool.GameObject},
    condItem = {path = "template/CondItem", type = UITool.GameObject},
    rootAni = {path = "root", type = UITool.Animator},
    dispatchBeforeObj = {path = "root/Middle/DispatchRightGroup/DispatchBefore", type = UITool.GameObject},
    characterHeadScroll = {path = "root/Middle/DispatchRightGroup/DispatchBefore/ScrollView", type = UITool.GameObject},
    baseCondParent = {path = "root/Middle/DispatchRightGroup/NormalGroup/BaseCondParent", type = UITool.Transform},
    extraCondParent = {path = "root/Middle/DispatchRightGroup/ParticularGroup/AdditionCondParent", type = UITool.Transform},
    selectHoreParent = {path = "root/Middle/DispatchRightGroup/SelectHoreParent", type = UITool.Transform},
    rewardParent = {path = "root/Middle/DispatchRightGroup/RewardParent", type = UITool.Transform},
    filterBtn = {path = "root/Middle/DispatchRightGroup/DispatchBefore/FilterButton", type = UITool.Button},
    dispatchingTimeText = {path = "root/Middle/DispatchRightGroup/Dispatching/DownTimeText", type = UITool.Text},
    endScoreText = {path = "root/Middle/DispatchRightGroup/EndScore", type = UITool.Text},
    dispatchBtn = {path = "root/Middle/DispatchRightGroup/DispatchBtn", type = UITool.Button},
    dispatchEndBtn = {path = "root/Middle/DispatchRightGroup/DispatchEndBtn", type = UITool.Button},
    dispatchCallbackBtn = {path = "root/Middle/DispatchRightGroup/Dispatching", type = UITool.Button},
    dispatchingObj = {path = "root/Middle/DispatchRightGroup/Dispatching", type = UITool.GameObject},
    reputationName = {path = "root/Middle/DispatchRightGroup/ProgressBG/LevelName", type = UITool.Text},
    reputationTitle = {path = "root/Middle/DispatchRightGroup/ProgressBG/_ReputationTitle", type = UITool.GameObject},
    reputationCount = {path = "root/Middle/DispatchRightGroup/ProgressBG/ReputationText", type = UITool.Text},
    reputationHintBtn = {path = "root/Middle/DispatchRightGroup/ProgressBG/ReputationHintBtn", type = UITool.Button},
    reputationProgress = {path = "root/Middle/DispatchRightGroup/ProgressBG/Progress/Slider", type = UITool.Image},
    beforeStageToggleGroup = {path = "root/Middle/DispatchRightGroup/DispatchBtn/StageToggleGroup", type = UITool.ToggleGroup},
    beforeStageToggleTemplete = {path = "root/Middle/DispatchRightGroup/DispatchBtn/StageToggleGroup/StageTemplate", type = UITool.GameObject},
    noneHeroObj = {path = "root/Middle/DispatchRightGroup/DispatchBefore/NoneHeroImg", type = UITool.GameObject},
    btnBack = {path = "root/Left/BtnBack", type = UITool.Button},
    maskBtnBack = {path = "root/Mask", type = UITool.Button},
    animRoot = {path = "root", type = UITool.Animator}
}

local this = {

    firstToggle = nil,

    selectHeroItems = {},

    selectTimeHour = 0,

    RewardItems = {},
    enterView = "ani_DispatchViewModel_root_01",
    heroListAniName = "ani_DispatchViewModel_root_02",
    exitAniName = "ani_DispatchViewModel_root_03"
}

this.before_awake = function()
    SetActive(this.reputationTitle, false)
    this.reputationCount.alignment = UnityEngine.TextAnchor.MiddleRight
    local reputationCountRect = this.reputationCount.transform:GetComponent(UITool.RectTransform)
    this.reputationCount.transform.pivot = Vector2(1, 0.5)
    reputationCountRect.sizeDelta = Vector2(350, 30)
    this.reputationCount.transform.anchoredPosition = Vector2(258.5, 9.2)
    this.characterHeadScrollView = UIScrollView.New(this.characterHeadScroll)
    this.InitDispatchWaitView()
end

this.InitDispatchWaitView = function()
    for i = 1, 6 do
        local item = DispatchHeroItem.New(this.characterHead, this.selectHoreParent, 0.85, this.OpenLeftUI)
        table.insert(this.selectHeroItems, item)
        item:SetData1(nil)
    end
    local toggleOptionCfg = ConfigMgr.Config.DispatchConstants.DispatchTimeOption
    local hourStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23715")
    this.toggleNodes = {}
    for i = 1, #toggleOptionCfg do
        local value = toggleOptionCfg[i]

        local toggleNode = DispatchStageToggle.New(this.beforeStageToggleTemplete, this.beforeStageToggleGroup.transform, true, i, this.ClickTimeOptionToggle)
        this.toggleNodes[i] = toggleNode
        local data = {}
        local hourNum = math.floor(value / 3600)
        data.nocheckText = hourNum .. hourStr
        data.checkText = hourNum .. hourStr
        toggleNode:SetData(data)
        if i == 1 then
            this.selectTimeHour = hourNum
            this.beforeSelectStage = i
            this.firstToggle = toggleNode
            this.firstToggle.toggle.isOn = true
            this.firstToggle:SetIsOn(true)
        else
            toggleNode.toggle.isOn = false
            toggleNode:SetIsOn(false)
        end
    end
end

this.ClickTimeOptionToggle = function(index, value)
    if value == true then
        this.beforeSelectStage = index
        local timeSecond = ConfigMgr.Config.DispatchConstants.DispatchTimeOption[this.beforeSelectStage]
        this.selectTimeHour = math.floor(timeSecond / 3600)
        this.SetDispatchEndScore()
        local func = function()
            this.SetRewardItem()
        end
        LuaMgr.NextFrame(func, 2)
        for i = 1, #this.toggleNodes do
            local toggleNode = this.toggleNodes[i]
            toggleNode:SetIsOn(index == i)
        end
    end
end

this.before_active = function()
    this.rootAni:Play(this.enterView)
    this.dispatchData = DispatchData.GetDispatchData(this.zoneGroup)
    DispatchData.RefreshDispatchedHero()

    HeroParameter.EmptyListParam()
    this.RefreshRightUI()
    this.SetLeftDispatchObjVis(false)
end





this.OpenLeftUI = function(item)

    if this.dispatchData.status ~= DispatchData.StrongholdStatus.DispatchWait or this.dispatchBeforeObj.activeSelf == true then
        return
    end
    this.SetLeftDispatchObjVis(true)
    this.RefreshLeftUI(true)
end

this.SetLeftDispatchObjVis = function(visible)
    if visible == true then
        this.animRoot:Play(this.heroListAniName)
    end
    SetActive(this.dispatchBeforeObj, visible)
end

this.RefreshLeftUI = function(isActive)
    local allCharacter = this.GetAllCharacter()
    local characterCount = #allCharacter
    local rowMaxCount = 4
    local viewportMaxCount = 4
    local rowCount = characterCount <= 0 and 0 or 1
    if characterCount > viewportMaxCount then
        if characterCount % rowMaxCount == 0 then
            rowCount = math.floor(characterCount / rowMaxCount)
        else
            rowCount = math.floor(characterCount / rowMaxCount) + 1
        end
    end
    this.characterHeadScrollView:Clear()
    local groupWidth, groupHight = 492, 125
    local scrollDatas = {}
    for i = 1, rowCount do
        local groupData = {}
        groupData.prefab = this.listCharacterHeadCell
        groupData.scale = 1
        groupData.list = {}
        groupData.callback = this.OnSelectHero
        groupData.itemCount = rowMaxCount
        local lastPos = (i - 1) * rowMaxCount
        for j = 1, rowMaxCount do
            local tempData = allCharacter[lastPos + j]
            if tempData ~= nil then
                table.insert(groupData.list, tempData)
            end
        end
        local scrollData = UIScrollData.GetData(this.characterHeadGroup, "DispatchHeroGroup", groupWidth, groupHight, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.characterHeadScrollView:SetParams(groupWidth, 483)
    this.characterHeadScrollView:SetData(scrollDatas, true)
    SetActive(this.noneHeroObj, allCharacter == nil or #allCharacter == 0)
end


this.ClickFilter = function()
    this.jobType = this.jobType == nil and CharacterJob.All or this.jobType
    this.sortType = this.sortType == nil and HeroSortType.Level or this.sortType
    this.sequenceType = this.sequenceType == nil and SequenceType.FromBigToSmall or this.sequenceType
    HeroParameter.SaveListParam(this.jobType, this.sortType, this.sequenceType, 0, 1)
    LuaMgr.ShowLuaPanel(UIName.FilterSortViewModel)
end

this.GetAllCharacter = function()
    this.jobType = HeroParameter.paramBool and HeroParameter.jobType or CharacterJob.All
    this.sortType = HeroParameter.paramBool and HeroParameter.sortType or HeroSortType.Level
    this.sequenceType = HeroParameter.paramBool and HeroParameter.sequenceType or SequenceType.FromBigToSmall
    local heroDic = {}
    local characters = DataMgr.Player.characters

    local rightSelectHeroDic = {}
    for key, value in pairs(this.selectHeroItems) do
        if value.data ~= nil then
            rightSelectHeroDic[value.data.heroID] = value.gameObject.transform:GetSiblingIndex() + 1
        end
    end
    for key, value in pairs(characters) do
        local tempData = {}
        local heroConfig = ConfigMgr.Config.characterTable[key]
        tempData.name = LuaMgr.GetLangText(heroConfig.namelan)
        tempData.rare = HeroMgr.GetHeroNowRare(heroConfig.id)
        tempData.id = heroConfig.id
        tempData.heroID = heroConfig.id
        tempData.level = value.level
        tempData.star = value.star
        tempData.createTime = value.createTime
        tempData.selectIndex = 0
        tempData.selected = false
        local heroDispachData = DispatchData.GetHeroData(this.dispatchData.id, heroConfig.id)
        if this.jobType == CharacterJob.All or (heroConfig ~= nil and this.jobType == heroConfig.job) then
            tempData.selectIndex = rightSelectHeroDic[key]
            if heroDispachData ~= nil and tempData.selectIndex ~= nil and tempData.selectIndex > 0 then
                tempData.selected = heroDispachData.isSelected or heroDispachData.isDispatching
            elseif tempData.selectIndex == nil or tempData.selectIndex == 0 then

                DispatchData.SelectHero(this.dispatchData.id, tempData.id, false, false, false)
            end
            local isFullExtraCond = this.HeroIsFullExtraCond(tempData)
            tempData.isFullExtraCond = isFullExtraCond
            heroDic[tempData.heroID] = tempData
        end
    end
    local heroList = {}
    for key, value in pairs(heroDic) do
        if DispatchData.CheckHeroBeDispatched(key, this.dispatchData.id) == false then
            table.insert(heroList, value)
        end
    end

    if #heroList > 1 then
        if this.sortType == HeroSortType.Level then
            table.sort(heroList, this.LevelSort)
        elseif this.sortType == HeroSortType.Rare then
            table.sort(heroList, this.RareSort)
        elseif this.sortType == HeroSortType.Star then
            table.sort(heroList, this.StarSort)
        elseif this.sortType == HeroSortType.Time then
            table.sort(heroList, this.TimeSort)
        end
    end
    return heroList
end




this.LevelSort = function(a, b)
    if a.selected == true and b.selected == false then
        return true
    elseif a.selected == false and b.selected == true then
        return false
    end
    if a.isFullExtraCond == true and b.isFullExtraCond == false then
        return true
    elseif a.isFullExtraCond == false and b.isFullExtraCond == true then
        return false
    end
    if a.level ~= b.level then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.LevelSortBigToSmall(a, b)
        else
            return HeroMgr.LevelSortSmallToBig(a, b)
        end
    elseif a.rare ~= b.rare then
        return HeroMgr.RareSortBigToSmall(a, b)
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a, b)
    end
    return HeroMgr.HeroIdSort(a, b)
end


this.RareSort = function(a, b)
    if a.selected == true and b.selected == false then
        return true
    elseif a.selected == false and b.selected == true then
        return false
    end
    if a.isFullExtraCond == true and b.isFullExtraCond == false then
        return true
    elseif a.isFullExtraCond == false and b.isFullExtraCond == true then
        return false
    end
    if a.rare ~= b.rare then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.RareSortBigToSmall(a, b)
        else
            return HeroMgr.RareSortSmallToBig(a, b)
        end
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a, b)
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a, b)
    end
    return HeroMgr.HeroIdSort(a, b)
end


this.StarSort = function(a, b)
    if a.selected == true and b.selected == false then
        return true
    elseif a.selected == false and b.selected == true then
        return false
    end
    if a.isFullExtraCond == true and b.isFullExtraCond == false then
        return true
    elseif a.isFullExtraCond == false and b.isFullExtraCond == true then
        return false
    end
    if a.star ~= b.star then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.StarSortBigToSmall(a, b)
        else
            return HeroMgr.StarSortSmallToBig(a, b)
        end
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a, b)
    elseif a.rare ~= b.rare then
        return HeroMgr.RareSortBigToSmall(a, b)
    end
    return HeroMgr.HeroIdSort(a, b)
end


this.TimeSort = function(a, b)
    if a.selected == true and b.selected == false then
        return true
    elseif a.selected == false and b.selected == true then
        return false
    end
    if a.isFullExtraCond == true and b.isFullExtraCond == false then
        return true
    elseif a.isFullExtraCond == false and b.isFullExtraCond == true then
        return false
    end
    if a.time ~= b.time then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.TimeSortEarlyToLate(a, b)
        else
            return HeroMgr.TimeSortLateToEarly(a, b)
        end
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a, b)
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a, b)
    elseif a.rare ~= b.rare then
        return HeroMgr.RareSortBigToSmall(a, b)
    end
    return HeroMgr.HeroIdSort(a, b)
end








this.RefreshRightUI = function()
    if this.BaseCondItem == nil then

        this.BaseCondItem = {}
    end
    if this.ExtraCondItem == nil then

        this.ExtraCondItem = {}
    end
    if this.selectHeroItems == nil then

        this.selectHeroItems = {}
    end
    local heroList = DispatchData.GetHeroList(this.dispatchData.id)
    local baseCondDatas = this.GetBaseCondData(heroList)
    local extraCondDatas = this.GetExtraCondData(heroList)
    this.SetConditonItem(this.BaseCondItem, baseCondDatas, this.baseCondParent)
    this.SetConditonItem(this.ExtraCondItem, extraCondDatas, this.extraCondParent)
    this.extraCondDatas = extraCondDatas
    this.SetDispatchEndScore()

    this.RefreshSelectedHero(heroList)
    this.SetRewardItem()
    LuaMgr.RemoveTimer(TimerConst.DispatchEnd)
    SetActive(this.dispatchBtn.gameObject, false)
    SetActive(this.dispatchingObj, false)
    SetActive(this.dispatchEndBtn.gameObject, false)
    SetActive(this.btnBack.gameObject, false)
    if this.dispatchData.status == DispatchData.StrongholdStatus.Dispatching then
        LuaMgr.AddTimer(TimerConst.DispatchEnd, this.OnTimer, 1, -1, true)
        SetActive(this.dispatchingObj, true)
    elseif this.dispatchData.status == DispatchData.StrongholdStatus.DispatchWait then
        SetActive(this.dispatchBtn.gameObject, true)
        SetActive(this.btnBack.gameObject, true)
    elseif this.dispatchData.status == DispatchData.StrongholdStatus.DispatchEnd then
        SetActive(this.dispatchEndBtn.gameObject, true)
    end
    local h, m, s = GetTimeHMS2(this.dispatchData.endTime - LuaMgr.Timestamp())
    this.dispatchingTimeText.text = string.format("%02d:%02d:%02d", h, m, s)

    local curReputition, nextNeedReputation = DispatchData.GetPlayerReputationData()
    local lanText = LuaMgr.GetLangText("DispatchViewModel_UI_15")
    if nextNeedReputation == 0 then
        this.reputationCount.text = string.format("%s %d/Max", lanText, curReputition)
        this.reputationProgress.fillAmount = 1
    else
        this.reputationCount.text = string.format("%s %d/%d", lanText, curReputition, nextNeedReputation)
        this.reputationProgress.fillAmount = curReputition / nextNeedReputation
    end
    local curLevel = DataMgr.Player.DispatchRegular.level
    local curLevelData = DispatchData.GetReputationDataByLevel(curLevel)
    if curLevelData ~= nil then
        this.reputationName.text = LuaMgr.GetLangText(curLevelData.config.LevelNameLan)
    else
        this.reputationName.text = "Error:" .. curLevel
    end
end

this.OnTimer = function()
    local remainTime = this.dispatchData.endTime - LuaMgr.Timestamp()
    if remainTime < 0 then
        LuaMgr.RemoveTimer(TimerConst.DispatchEnd)
        this.dispatchData = DispatchData.GetDispatchData(this.zoneGroup)
        DispatchData.RefreshDispatchedHero()
        this.RefreshLeftUI()
        this.RefreshRightUI()
        return
    end
    local h, m, s = GetTimeHMS2(remainTime)
    this.dispatchingTimeText.text = string.format("%02d:%02d:%02d", h, m, s)
end

this.SetRewardItem = function()
    if this.zoneGroup == nil then
        return
    end
    if this.dispatchData == nil then
        this.dispatchData = DispatchData.GetDispatchData(this.zoneGroup)
    end
    for key, value in pairs(this.RewardItems) do
        SetActive(value.gameObject, false)
    end
    local items = this.RewardItems
    DispatchData.RefreshRewardData(this.dispatchData, this.beforeSelectStage)
    local rewardDatas = this.dispatchData.rewardDatas
    for i = 1, #rewardDatas do
        local tempData = rewardDatas[i]
        local item = items[i]
        if item == nil then
            item = GoodsDataItem.New(this.rewardParent)
            table.insert(items, item)
        else
            SetActive(item.gameObject, true)
        end
        local itemData = table.Copy(ConfigMgr.Config.itemMap[tempData.id])
        local scale = 0.75
        item:SetData(i, itemData, 1, false, Vector3(scale, scale, scale), false, false)
        item:SetCount(string.format("%d", tempData.count))
        item:SetIconBg(false)
    end
end

this.RefreshSelectedHero = function(heroList)
    for key, value in pairs(this.selectHeroItems) do
        value:SetData1(nil)
    end
    table.sort(this.selectHeroItems, this.OnSortSelctHeroItem)
    for i = 1, #heroList do
        local data = heroList[i]
        local item = this.selectHeroItems[i]
        item:SetData1(data)
    end
    for key, value in pairs(this.selectHeroItems) do
        if value.data == nil then
            SetActive(value.gameObject, this.dispatchData.status == DispatchData.StrongholdStatus.DispatchWait)
        end
    end
end

this.OnSortSelctHeroItem = function(data1, data2)
    return data1.gameObject.transform:GetSiblingIndex() < data2.gameObject.transform:GetSiblingIndex()
end

this.SetSelectedHero = function(heroList, heroData)
    for key, value in pairs(this.selectHeroItems) do
        if value.data ~= nil and heroData.selected == false and heroData.id == value.data.heroID then
            value:SetData1(nil)
            value.gameObject.transform:SetSiblingIndex(#this.selectHeroItems - 1)
            break
        end
    end

    if heroData.selected == true then
        local selectHeroData = nil
        for key, value in pairs(heroList) do
            if value.heroID == heroData.id then
                selectHeroData = value
                break
            end
        end
        if selectHeroData == nil then
            LuaDebug.error("this.SetSelectedHero invalid heroData")
            return
        end
        local item = this.GetHeroUIItem()
        item:SetData1(selectHeroData)
        item.gameObject.transform:SetSiblingIndex(#heroList - 1)
    end
end


this.GetHeroUIItem = function()
    local items = this.selectHeroItems
    local item = nil
    for key, value in pairs(items) do
        if value.data == nil then
            return value
        end
    end
    if item == nil then
        item = DispatchHeroItem.New(this.characterHead, this.selectHoreParent, 0.85)
        table.insert(this.selectHeroItems, item)
    end
    return item
end


this.SetConditonItem = function(items, datas, itemParent)
    local conditionDatas = datas.conditionData
    for i = 1, #conditionDatas do
        local data = conditionDatas[i]
        local item = items[i]
        if item == nil then
            item = DispatchCondItem.New(this.condItem, itemParent)
            table.insert(items, item)
        end
        SetActive(item.gameObject, true)
        item:SetData(data)
    end
end

this.GetBaseCondData = function(heroList)
    local data = {}
    local conditionData = {}
    data.fullCondNum = 0
    data.conditionData = conditionData
    data.fullCondScore = this.dispatchData.curTaskConfig.BaseReputation
    for key, condCfg in pairs(this.dispatchData.curTaskConfig.BaseCond) do
        local tempData = this.GetCondIsFullData(condCfg, heroList, true)
        tempData.index = key
        tempData.isBaseCond = true
        if tempData.isFull == true then
            data.fullCondNum = data.fullCondNum + 1
        end
        conditionData[key] = tempData
    end
    return data
end

this.GetExtraCondData = function(heroList)
    local data = {}
    local conditionData = {}
    data.conditionData = conditionData
    data.fullCondScore = 0
    local extraCondConfig = this.dispatchData.curTaskConfig.ExtraCredit
    for key, condCfg in pairs(this.dispatchData.curTaskConfig.ExtraCond) do
        local tempData = this.GetCondIsFullData(condCfg, heroList, false)
        tempData.index = key
        tempData.isBaseCond = false
        tempData.score = extraCondConfig[key]
        conditionData[key] = tempData
        if tempData.isFull == true then
            data.fullCondScore = data.fullCondScore + tempData.score
        end
    end
    return data
end

this.GetCondIsFullData = function(condCfg, heroList, isBaseCond)
    local tempData = {}
    local value1 = condCfg[1]
    if value1 == DispatchData.DispatchCondType.Count then
        local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22001")
        tempData.text = string.format(content, tonumber(condCfg[2]))
        tempData.isFull = DispatchData.CheckCondition(heroList, condCfg, isBaseCond)
    elseif value1 == DispatchData.DispatchCondType.Rare then
        local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22102")
        local rareName = this.GetRareName(tonumber(condCfg[2]))
        tempData.text = string.format(content, rareName, tonumber(condCfg[3]))
        tempData.isFull = DispatchData.CheckCondition(heroList, condCfg, isBaseCond)
    elseif value1 == DispatchData.DispatchCondType.Hero then
        local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22101")
        local characterConfig = ConfigMgr.Config.characterTable[condCfg[2]]
        local characterName = LuaMgr.GetLangText(characterConfig.namelan)
        tempData.text = string.format(content, characterName)
        tempData.isFull = DispatchData.CheckCondition(heroList, condCfg, isBaseCond)
    elseif value1 == DispatchData.DispatchCondType.Job then
        local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22318")
        local jobConfig = ConfigMgr.Config.jobs[condCfg[2]]
        local jobName = LuaMgr.GetLangText(jobConfig.NameLan)
        tempData.text = string.format(content, jobName, tonumber(condCfg[3]))
        tempData.isFull = DispatchData.CheckCondition(heroList, condCfg, isBaseCond)
    end
    return tempData
end

this.HeroIsFullExtraCond = function(hero)
    local heroList = {}
    table.insert(heroList, hero)
    for key, value in pairs(this.dispatchData.curTaskConfig.ExtraCond) do

        if key == 1 then
            local isFull = DispatchData.CheckExtraCondition(heroList, value)
            if isFull then
                return isFull
            end
        end
    end
    return false
end

this.GetRareName = function(rare)
    if rare == 2 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2360")
    elseif rare == 3 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2361")
    elseif rare == 4 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2362")
    end
    return "NULL"
end





this.OnSelectHero = function(heroItem)
    local heroData = heroItem.data
    heroItem:SetSelected(false)
    if heroData.selected == true then
        DispatchData.SelectHero(this.dispatchData.id, heroData.id, false, false, true)
    else
        local selectRes = DispatchData.SelectHero(this.dispatchData.id, heroData.id, true, false, true)
        if selectRes == false then
            local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22308")

            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(tips, 6))
            return
        end
    end
    local heroDispachData = DispatchData.GetHeroData(this.dispatchData.id, heroData.id)
    if heroDispachData == nil then
        heroData.selected = false
    else
        heroData.selected = heroDispachData.isSelected or heroDispachData.isDispatching
    end
    local heroList = DispatchData.GetHeroList(this.dispatchData.id)
    local baseCondDatas = this.GetBaseCondData(heroList)
    local extraCondDatas = this.GetExtraCondData(heroList)
    this.SetConditonItem(this.BaseCondItem, baseCondDatas, this.baseCondParent)
    this.SetConditonItem(this.ExtraCondItem, extraCondDatas, this.extraCondParent)
    this.SetSelectedHero(heroList, heroData)
    this.extraCondDatas = extraCondDatas
    this.SetDispatchEndScore()
    this.RefreshLeftUI()
end

this.SetDispatchEndScore = function()
    if this.dispatchData == nil or this.extraCondDatas == nil then
        return
    end
    local selectTimeHour = this.selectTimeHour
    if this.dispatchData.status == DispatchData.StrongholdStatus.Dispatching then
        selectTimeHour = math.floor(this.dispatchData.needTime / 3600)
    end
    local extraCondDatas = this.extraCondDatas
    local endScoreStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22310")
    local baseScore = this.dispatchData.curTaskConfig.BaseReputation
    local endbaseScore = baseScore * selectTimeHour
    local endExtraScore = extraCondDatas.fullCondScore * selectTimeHour
    local extraScoreStr = BalatroUtil.ColorText("#449E7F", tostring(endExtraScore))
    this.endScoreText.text = string.format(endScoreStr, endbaseScore, extraScoreStr, endbaseScore + endExtraScore)
end

this.OpenReputationView = function()
    LuaMgr.ShowLuaPanel(UIName.DispatchReputationPopup)
end

this.OnDispatch = function()
    local maxCount = ConfigMgr.Config.DispatchConstants.DispatchDailyLimit
    local remainCount = maxCount - (DataMgr.Player.dailyCount.dispatchRegular or 0)
    if remainCount <= 0 then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23717")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        return
    end
    this.heroList = DispatchData.GetHeroList(this.dispatchData.id)
    local baseCondDatas = this.GetBaseCondData(this.heroList)
    if baseCondDatas.fullCondNum < #baseCondDatas.conditionData then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22312")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        return
    end
    local members = {}
    local pos = 0
    for key, value in pairs(this.dispatchData.heroDic) do
        members[tostring(pos)] = value.heroID
        pos = pos + 1
    end
    local data = {}
    data.Items = {}
    data.Items[tostring(this.dispatchData.id)] = {
        Stage = this.beforeSelectStage - 1,
        Members = members
    }
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        this.dispatchData = DispatchData.GetDispatchData(this.zoneGroup)
        DispatchData.RefreshDispatchedHero()
        this.RefreshLeftUI()
        this.RefreshRightUI()
        local configValue = ConfigMgr.Config.DispatchConstants.DispatchTimeOption[this.beforeSelectStage]
        local data = {}
        data.status = DispatchData.StatusChangeType.DispatchSucc
        data.heroList = this.heroList
        data.dispatchTime = configValue
        local callBack = function()
            this.OnBack()
            LuaMgr.InvokeUIEventListeners(UIEventConst.DispatchStatusChange, data)
        end
        local sequence = DOTWeen:Sequence()
        sequence:AppendInterval(0):OnComplete(callBack)
        this.rootAni:Play("ani_DispatchViewModel_root_03")
    end
    ApiMgr.Request("dispatchRegular/start", data, true, callback, nil, true)
end

this.OnGetReward = function()
    local data = {
        Ids = {this.dispatchData.id}
    }
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        local reward = json.encode(res.result.Rewards)
        LuaMgr.ShowItemRewared(reward)
        this.dispatchData = DispatchData.GetDispatchData(this.zoneGroup)
        DispatchData.RefreshDispatchedHero()
        this.RefreshLeftUI()
        this.RefreshRightUI()
        local data = {}
        data.status = DispatchData.StatusChangeType.GetRewardSucc
        data.storyID = res.result.StoryId
        LuaMgr.InvokeUIEventListeners(UIEventConst.DispatchStatusChange, data)
        this.OnBack()
    end
    ApiMgr.Request("dispatchRegular/taskReward", data, true, callback, nil, true)
end

this.OnCallback = function()
    local data = {}
    data.clickCallbacks = {}
    data.btnTextStrs = {}
    data.clickCallbacks[ConfirmCommonPanel.BtnType.Confirm] = this.ConfirmCallback
    data.contentStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23716")
    LuaMgr.ShowLuaPanel(UIName.ConfirmCommonPanel, ConfirmCommonPanel.MsgBoxType.ImageButton, data)
end

this.ConfirmCallback = function()
    local data = {
        Ids = {this.dispatchData.id}
    }
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        this.dispatchData = DispatchData.GetDispatchData(this.zoneGroup)
        DispatchData.RefreshDispatchedHero()
        this.RefreshRightUI()
        LuaMgr.InvokeUIEventListeners(UIEventConst.DispatchStatusChange)
    end
    ApiMgr.Request("dispatchRegular/cancel", data, true, callback, nil, true)
end

this.OnBack = function()
    DispatchData.SaveArchives()
    if this.closeCallback ~= nil then
        this.closeCallback()
    end
    LuaMgr.HidePanel(UIName.DispatchViewModel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.filterBtn, this.ClickFilter)
        LuaMgr.AddClick(this.btnBack, this.OnBack)
        LuaMgr.AddClick(this.maskBtnBack, this.OnBack)
        LuaMgr.AddClick(this.dispatchBtn, this.OnDispatch)
        LuaMgr.AddClick(this.dispatchEndBtn, this.OnGetReward)
        LuaMgr.AddClick(this.dispatchCallbackBtn, this.OnCallback)
        LuaMgr.AddClick(this.reputationHintBtn, this.OpenReputationView)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        this.zoneGroup = vm.behaviour.Params[0].zoneGroup
        this.closeCallback = vm.behaviour.Params[0].closeCallback
        this.before_active()
        LuaMgr.AddUIEventListener(UIEventConst.UpdateHeroList, this.RefreshLeftUI)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList, this.RefreshLeftUI)
        LuaMgr.RemoveTimer(TimerConst.DispatchEnd)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.filterBtn, this.ClickFilter)
        LuaMgr.RemoveClick(this.btnBack, this.OnBack)
        LuaMgr.RemoveClick(this.maskBtnBack, this.OnBack)
        LuaMgr.RemoveClick(this.dispatchBtn, this.OnDispatch)
        LuaMgr.RemoveClick(this.dispatchEndBtn, this.OnGetReward)
        LuaMgr.RemoveClick(this.dispatchCallbackBtn, this.OnCallback)
        LuaMgr.RemoveClick(this.reputationHintBtn, this.OpenReputationView)
        UIScrollView.ClearItem("DispatchHeroGroup")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)