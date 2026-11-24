require("ViewModel/LHSA/LHSAConst")
require("ViewModel/LHSA/LHSALevelItem")

local this =
{
    tapIndex = nil,
    tabBoxTab = {},
    searchItemDataList = {},
    searchItemCacheTab = {},
    selectedSearchItem = nil,
    clickTime = 0,
    startDelay = nil,
    startDelay2 = nil,
    levelSV = nil,
    eventList = nil,
    finishNum = 0,
    finishAll = false,
};

local objs = {
    searchItemObj = { path = "template/SearchItem", type = "GameObject" },
    levelItemObj = { path = "template/LevelItem", type = "GameObject" },
    root = { path = "root", type = "RectTransform" },
    searchItemsBox = { path = "root/ScrollView/Viewport/SearchItemsBox", type = "RectTransform" },
    searchScrollView = { path = "root/ScrollView", type = "ScrollRect" },
    resultItemsBox = { path = "root/ResultItemsBox", type = "RectTransform" },
    missionPanelBtn = { path = "root/missionPanelBtn", type = "Button" },
    missionBtn = { path = "root/Right/MissionBtn", type = "Button" },
    resetBtn = { path = "root/Right/ResetBtn", type = "Button" },
    middle = { path = "root/Middle", type = "Transform" },
    scrollView = { path = "root/missionPanelBtn/imageBg/ScrollView", type = "GameObject" },
    totalScoreText = { path = "root/Right/Image/TextTotalScore", type = "Text" },
};

this.GetEventListByTap = function(tapIndex)
    local area = LHSALevel2StrType[tapIndex]
    local sourceList = LHSAMgr.GetActiveEventsByArea(area)
    local list = {}
    for i, v in ipairs(sourceList) do
        table.insert(list, v)
    end
    return list, area
end

this.OnClickTap = function(index)
    this.tapIndex = index
    this.SetData()
end


this.OnBack = function()
    LuaMgr.Back()
end


this.SetData = function()
    if (this.eventList == nil) then
        this.eventList = {}
        local configQuest = DataExHelper.Check_ConfigQuestEventByGroupId(32201) or {};
        for k, v in pairs(configQuest) do
            if (v.text == "LHSA") then
                table.insert(this.eventList, v)
            end
        end
    end
    if this.tapIndex == nil then
        this.tapIndex = 1
    end
    local constants = LHSAMgr.GetCaseConstants()
    local assessScoreMin = tonumber(constants.CaseAssessScoremin) or 0
    local assessScoreMax = tonumber(constants.CaseAssessScoremax) or 200
    local currentAssessScore = LHSAMgr.ClampNumber(
        tonumber(DataMgr.Player.CaseGame.CrtScore) or 0,
        assessScoreMin,
        assessScoreMax
    )
    local range = assessScoreMax - assessScoreMin
    local fill = 0

    if range > 0 then
        fill = (currentAssessScore - assessScoreMin) / range
    end

    fill = LHSAMgr.ClampNumber(fill, 0, 1)
    local percent = math.floor(fill * 100)
    local str = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31257")
    this.totalScoreText.text = string.format(str, percent, assessScoreMax)
    local config = LHSAMgr.FindAssessConfig(DataMgr.Player.CaseGame.CrtScore)
    local cacheList = this.GetEventListByTap(this.tapIndex)
    this.SetSearchItemData(cacheList)
    this.SetSearchItem()
    this.SetResultItem(config)
end

this.SetSearchItemData = function(_configList)
    this.searchItemDataList = {}
    this.finishNum = 0
    if (_configList ~= nil and #_configList > 0) then
        for i, v in ipairs(_configList) do
            local cache = {}
            cache.id = v.id
            cache.icon = v.type;
            local inUnlockTime, unlockEventName = LHSAMgr.CheckEventIsUnLockTime(v)
            cache.unlockTime = unlockEventName
            cache.isUnlock = inUnlockTime and LHSAMgr.CheckEventIsUnLock(v)
            cache.isfinish = LHSAMgr.CheckEventIsComplete(v)
            local key = DataMgr.Player.uid .. "LHSA_" .. v.id;
            cache.isNew = PlayerPrefs.GetInt(key) == 0






            cache.name = LuaMgr.GetLangText(v.namelan);
            cache.config = v
            local eventId = DataMgr.Player.CaseGame.LevelEventMap[v.id]
            if eventId ~= nil then
                local eventConfig = LHSAMgr.GetMapConfig("CaseEventMap", eventId)
                cache.nameTitle = LHSAMgr.GetConfigText(eventConfig.EventName, eventConfig.EventNameLan)
            else
                cache.nameTitle = ""
            end

            table.insert(this.searchItemDataList, cache)
            if (cache.isfinish) then
                this.finishNum = this.finishNum + 1
            end
        end
        this.finishAll = this.finishNum == #_configList
        SetActive(this.resetBtn.gameObject, false)
    end
end

this.ScrollToNewItem = function()
    local targetIndex = nil
    for i, v in ipairs(this.searchItemDataList) do
        if v.isNew and not v.isfinish and v.isUnlock then
            targetIndex = i
            break
        end
    end
    if not targetIndex then
        for i, v in ipairs(this.searchItemDataList) do
            if v.isNew and v.isUnlock then
                targetIndex = i
                break
            end
        end
    end

    if targetIndex and #this.searchItemDataList > 0 then

        local colCount = 5
        local totalRows = math.ceil(#this.searchItemDataList / colCount)
        local targetRow = math.ceil(targetIndex / colCount)

        local ratio = 0
        if totalRows > 1 then
            ratio = (targetRow - 1) / (totalRows - 1)
        end
        ratio = math.max(0, math.min(1, ratio))

        local doScroll = function()
            local scrollRect = this.searchScrollView
            if scrollRect then
                if scrollRect.horizontal then
                    scrollRect.horizontalNormalizedPosition = ratio
                end
                if scrollRect.vertical then
                    scrollRect.verticalNormalizedPosition = 1 - ratio
                end
            end
        end


        if this.searchItemsBox then
            UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(this.searchItemsBox)
        end

        doScroll()

        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
        this.startDelay = coroutine_runner.start(function()
            coroutine_runner.wait(0)
            if this.searchItemsBox then
                UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(this.searchItemsBox)
            end
            doScroll()
        end)
    end
end


this.SetSearchItem = function()
    if (#this.searchItemDataList > 0) then
        for i, v in ipairs(this.searchItemDataList) do
            if (this.searchItemCacheTab[i] == nil or this.searchItemCacheTab[i].Obj == nil) then
                this.searchItemCacheTab[i] = {}
                this.searchItemCacheTab[i].Obj = this.GetObj(this.searchItemsBox)
            end
            local obj = this.searchItemCacheTab[i].Obj

            SetActive(obj.go, true)
            obj.icon.sprite = LuaMgr.GetSprite("LHSA", "ui_hd_lhsa_gq_main_sp_" .. this.CheckShowPlayIcon(v));
            obj.textName.text = v.name;
            obj.textTitle.text = v.nameTitle;
            SetActive(obj.typeImg2.gameObject, not v.isfinish and v.isUnlock)
            SetActive(obj.typeImg.gameObject, v.isfinish)
            SetActive(obj.selectedImg.gameObject, false)
            if (v.isUnlock) then
                obj.textTitle.text = v.nameTitle;
            else
                obj.textTitle.text = "";
            end
            if (v.isfinish) then
                obj.typeImg.sprite = LuaMgr.GetSprite("LHSA", "ui_hd_lhsa_gq_main_sp_" .. this.CheckShowPlayType(v));
            end
            SetActive(obj.imageFinish.gameObject, false);
            SetActive(obj.effect.gameObject, v.isNew and not v.isfinish and v.isUnlock)
            local onclick = function()
                if (not v.isUnlock) then
                    if (v.unlockTime ~= nil) then
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, v.unlockTime)
                    else
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FSMYLevelViewModel_0"))
                    end
                    return
                end
                this.selectedSearchItem = obj
                this.selectedSearchItem.config = v.config
                local key = DataMgr.Player.uid .. "LHSA_" .. v.config.id;
                PlayerPrefs.SetInt(key, 1);
                this.OnClickSmallBattleBtn()
            end
            obj.btn.onClick:RemoveAllListeners()

            LuaMgr.AddClick(obj.btn, onclick)
        end
    end
    local num1 = #this.searchItemCacheTab
    local num2 = #this.searchItemDataList
    if (num2 < num1) then
        for i = num2 + 1, num1 do
            if this.searchItemCacheTab[i] and this.searchItemCacheTab[i].Obj then
                SetActive(this.searchItemCacheTab[i].Obj.go, false)
            end
        end
    end

    this.ScrollToNewItem()
end

this.GetObj = function(tf)
    local go = LuaMgr.InstantiateGO(this.searchItemObj, tf, false)
    local cache = {}
    cache.go = go
    cache.btn = go.transform:GetComponent("Button")
    cache.icon = go.transform:Find("icon"):GetComponent("Image");
    cache.textTitle = go.transform:Find("TextTitle"):GetComponent("Text");
    cache.typeImg = go.transform:Find("typeImg"):GetComponent("Image");
    cache.typeImg2 = go.transform:Find("typeImg2");
    cache.selectedImg = go.transform:Find("selectedImg");
    cache.textName = go.transform:Find("ImageBg/TextName"):GetComponent("Text");
    cache.imageFinish = go.transform:Find("ImageBg/ImageFinish"):GetComponent("Image");
    cache.effect = go.transform:Find("effect");
    return cache
end

this.SetResultItem = function(curConfig)
    if not ConfigMgr or not ConfigMgr.Config or not ConfigMgr.Config.CaseAssessMap then
        return
    end

    local configs = LHSAMgr.GetSortedAssessConfigs()
    local startNum = #this.searchItemDataList
    local iconStrs = { "yz", "zl", "wz", "wjs" }
    local finishIconStrs = { "wc1", "wc3", "wc2" }
    for index, assessConfig in ipairs(configs) do
        startNum = startNum + 1
        local nameLan = LuaMgr.GetLangText(assessConfig.AssessTextLan)
        local content = LuaMgr.GetLangText(assessConfig.ContentTextLan)
        local isFinish = DataMgr.Player.CaseGame.FinishAss[assessConfig.Id] ~= nil
        if (this.searchItemCacheTab[startNum] == nil or this.searchItemCacheTab[startNum].Obj == nil) then
            this.searchItemCacheTab[startNum] = {}
            this.searchItemCacheTab[startNum].Obj = this.GetObj(this.resultItemsBox)
        end
        local obj = this.searchItemCacheTab[startNum].Obj
        SetActive(obj.go, true)
        obj.textTitle.text = "";
        local iconStr = iconStrs[4]
        if (isFinish) then
            iconStr = iconStrs[index]
            local finishIcon = finishIconStrs[index]
            obj.imageFinish.sprite = LuaMgr.GetSprite("LHSA", "ui_hd_lhsa_gq_main_sp_" .. finishIcon);
            obj.textTitle.text = content;
        end
        local key = DataMgr.Player.uid .. "LHSAFinish_" .. assessConfig.Id;
        obj.isNew = PlayerPrefs.GetInt(key) == 0
        SetActive(obj.effect.gameObject, obj.isNew and isFinish)
        SetActive(obj.imageFinish.gameObject, isFinish);
        obj.icon.sprite = LuaMgr.GetSprite("LHSA", "ui_hd_lhsa_gq_main_sp_" .. iconStr);
        obj.textName.text = nameLan;
        SetActive(obj.typeImg2.gameObject, false)
        SetActive(obj.typeImg.gameObject, false)
        SetActive(obj.selectedImg.gameObject,
            curConfig ~= nil and curConfig.Id == assessConfig.Id and isFinish and this.finishAll)
        local onclick = function()
            if (not isFinish) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                    LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_" .. (31265 + index)))
                return
            end
            local key = DataMgr.Player.uid .. "LHSAFinish_" .. assessConfig.Id;
            PlayerPrefs.SetInt(key, 1);
            LuaMgr.PlayNovel(assessConfig.NarrativeId, function()
                LuaMgr.Back()
            end);
        end
        obj.btn.onClick:RemoveAllListeners()

        LuaMgr.AddClick(obj.btn, onclick)
    end
end

this.PlaySearchItem = function()
    local bPlay = LHSAMgr.GetPlayerAnimation()
    if (bPlay) then
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
        end

        this.startDelay2 = coroutine_runner.start(function()
            for i, v in ipairs(this.searchItemDataList) do
                coroutine_runner.wait(0.1)
                local obj = this.searchItemCacheTab[i].Obj
                SetActive(obj.go, true)
            end
            LHSAMgr.SetPlayerAnimation(false)
        end)
    end
end

this.CheckShowPlayIcon = function(_config)
    if (_config.isUnlock) then
        if (_config.isfinish) then
            local state = LHSAMgr.CheckGameState(_config.config.id)
            if (state == 1) then
                return "yz"
            elseif (state == 0) then
                return "wz"
            end
        else
            return "zl"
        end
    else
        return "wjs"
    end
end

this.CheckShowPlayType = function(_config)
    if (_config.isfinish) then
        local state = LHSAMgr.CheckGameState(_config.config.id)
        if (state == 1) then
            return "yz1"
        elseif (state == 0) then
            return "yz2"
        end
    end
end

this.OnClickMission = function()
    if not this.CheckActivityRunning() then
        return
    end
    this.SetLevelList()
    SetActive(this.missionPanelBtn.gameObject, true)
end

this.OnClickReset = function()
    local data = {}
    data.content = LuaMgr.GetLangText("LHSALevelViewModel_0")
    data.callback = function()
        ApiMgr.Request("caseGame/resetCase", {}, true,
            function(result)
                this.SetData()
            end, nil, true, true);
    end
    LuaMgr.ShowLuaPanel(UIName.LHSAGameResultViewModel, data)
end


this.OnClickMissionPanelClose = function()
    SetActive(this.missionPanelBtn.gameObject, false)
end


this.SetLevelList = function()
    table.sort(this.eventList, function(a, b)
        local state1 = DataExHelper.Check_RewardState(a.id) % 3;
        local state2 = DataExHelper.Check_RewardState(b.id) % 3;
        if (state1 == state2) then
            return a.sort < b.sort;
        elseif state1 < state2 then
            return false
        else
            return true
        end
    end)
    this.levelSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.eventList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.levelItemObj, "LHSALevelItem", 566, 95,
            {
                config = this.eventList[i],
                totalList = this.eventList,
                callback = function()
                    HeroRedDataHelper.SetLHSARed()
                    RedMgr.Singleton:Refresh()
                    this.SetLevelList()
                end
            });
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(566, 448);
    this.levelSV:SetPadding(0, 10, 0, 0);
    this.levelSV:SetData(scrollDatas, true);
end

this.OnClickSmallBattleBtn = function()
    if not this.CheckActivityRunning() then
        return
    end
    if (this.selectedSearchItem == nil) then
        return
    end
    local config = this.selectedSearchItem.config
    if config == nil then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.LHSAGameViewModel, config);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission);
        LuaMgr.AddClick(this.resetBtn, this.OnClickReset);
        LuaMgr.AddClick(this.missionPanelBtn, this.OnClickMissionPanelClose);
        RedMgr.Singleton:RegisterViewModel(UIName.LHSALevelViewModel);
        this.levelSV = UIScrollView.New(this.scrollView);
    end,
    before_active = function(vm)
        LHSAMgr.SetPlayerAnimation(true)
        HeroRedDataHelper.SetLHSARed()
        RedMgr.Singleton:Refresh()
        this.OnClickTap(5)
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.OnFirstMainPage()
    end,
    before_deactive = function(vm)
        this.OnClickMissionPanelClose()
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
        end
        this.levelSV:Clear(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission);
        LuaMgr.RemoveClick(this.resetBtn, this.OnClickReset);
        LuaMgr.RemoveClick(this.missionPanelBtn, this.OnClickMissionPanelClose);
        if (this.tabBoxTab ~= nil and #this.tabBoxTab > 0) then
            for i = 1, #this.tabBoxTab do
                LuaMgr.RemoveClick(this.tabBoxTab[i].btn, this.tabBoxTab[i].btnFunc)
            end
        end
        UIScrollView.ClearItem("LHSALevelItem");
        RedMgr.Singleton:RemoveViewModel(UIName.LHSALevelViewModel);
    end
}

this.OnFirstMainPage = function()
    local key = DataMgr.Player.uid .. "LHSA"
    local cache = PlayerPrefs.GetInt(key)
    if cache == 1 then
        return
    end
    PlayerPrefs.SetInt(key, 1)
    local constants = LHSAMgr.GetCaseConstants()
    if not LHSAMgr.IsEmpty(constants.FirstStory) then
        LuaMgr.PlayNovel(constants.FirstStory, function()
            LuaMgr.ShowLuaPanel(UIName.LHSALevelViewModel);
        end)
    end
end


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.LHSA) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end

return vm({
    data = data,
    command = command,
    hook = hook
})