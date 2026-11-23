require("ViewModel/FSMY/FSMYConst")
require("ViewModel/FSMY/FSMYLevelItem")

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
    maxScore = 0,
};

local objs = {
    searchItemObj = { path = "template/SearchItem", type = "GameObject" },
    levelItemObj = { path = "template/LevelItem", type = "GameObject" },
    root = { path = "root", type = "RectTransform" },
    searchItemsBox = { path = "root/SearchItemsBox", type = "RectTransform" },
    missionPanelBtn = { path = "root/missionPanelBtn", type = "Button" },
    missionBtn = { path = "root/Left/MissionBtn", type = "Button" },
    middle = { path = "root/Middle", type = "Transform" },
    scrollView = { path = "root/missionPanelBtn/imageBg/ScrollView", type = "GameObject" },
    lineBox1 = { path = "root/Bg/LineBox1", type = "Transform" },
    lineBox2 = { path = "root/Bg/LineBox2", type = "Transform" },
    totalScoreText = { path = "root/Right/Image/TextTotalScore", type = "Text" },
};

this.GetEventListByTap = function(tapIndex)
    local area = FSMYLevel2StrType[tapIndex]
    local sourceList = FSMYMgr.GetActiveEventsByArea(area)
    local list = {}
    for i, v in ipairs(sourceList) do
        table.insert(list, v)
    end
    return list, area
end

this.AppendRandomGameEvents = function(cacheList)
    local hackGame = DataMgr.Player.HackGame
    if hackGame == nil or hackGame.RandomIds == nil then
        return
    end

    for k, v in pairs(hackGame.RandomIds) do
        local config = ConfigMgr.Config.HackGameCoordinatesMap[v]
        if config then
            local levelConfig = ConfigMgr.Config.HackGameLevelMap[config.LevelId]
            if levelConfig then
                local cache = {}
                cache.id = config.LevelId
                cache.type = 3;
                cache.classId = "event;" .. config.Coordinates;
                cache.eventParam = config.LevelId
                cache.namelan = levelConfig.DnameLan;
                cache.area = FSMYLevelType.Play
                cache.isBonus = true
                table.insert(cacheList, cache)
                if (RedMgr.Singleton:CheckRedCondition("18108")) then
                    RedMgr.Singleton:FrushRedCondition("18108")
                    FSMYMgr.redEventMap[config.LevelId] = 1
                end
            end
        end
    end
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
        local configQuest = DataExHelper.Check_ConfigQuestEventByGroupId(31201) or {};
        for k, v in pairs(configQuest) do
            if (v.text == "FSMY") then
                table.insert(this.eventList, v)
            end
        end
    end
    if this.tapIndex == nil then
        this.tapIndex = 1
    end
    local cacheList, area = this.GetEventListByTap(this.tapIndex)

    if area == FSMYLevelType.Play then
        local lastItem = cacheList[#cacheList]
        if lastItem ~= nil and FSMYMgr.CheckEventIsComplete(lastItem) then
            local requestTapIndex = this.tapIndex
            ApiMgr.Request("hackGame/chooseRandom", {}, true, function(result)
                if this.tapIndex ~= requestTapIndex then
                    return
                end
                this.AppendRandomGameEvents(cacheList)
                this.SetSearchItemData(cacheList)
                this.SetSearchItem()
            end, nil, true, true);
            return
        end
    end
    this.SetSearchItemData(cacheList)
    this.SetSearchItem()
end

this.SetSearchItemData = function(_configList)
    this.searchItemDataList = {}
    this.finishNum = 0
    if (_configList ~= nil and #_configList > 0) then
        for i, v in ipairs(_configList) do
            local cache = {}
            cache.id = v.id
            cache.icon = v.type;
            cache.isUnlock = FSMYMgr.CheckEventIsUnLock(v)
            cache.isfinish = FSMYMgr.CheckEventIsComplete(v)
            local key = DataMgr.Player.uid .. "FSMY_" .. v.id;
            cache.isNew = PlayerPrefs.GetInt(key) == 0
            local levelConfig = ConfigMgr.Config.HackGameLevelMap[v.id]
            cache.name = levelConfig and LuaMgr.GetLangText(levelConfig.DnameLan) or LuaMgr.GetLangText(v.namelan);
            local list = nil
            if v.classId ~= nil and v.classId ~= "" then
                list = NumTool.split(v.classId, ";");
            end
            local posList = nil
            if list and #list >= 2 then
                posList = NumTool.split(list[2], ",");
            end
            if (posList ~= nil and #posList >= 2) then
                cache.pos = { posList[1], posList[2] }
            end
            cache.config = v
            if cache.pos ~= nil then
                table.insert(this.searchItemDataList, cache)
                if (cache.isfinish) then
                    this.finishNum = #this.searchItemDataList
                end
            else
                LuaDebug.error("Config Error: FSMY event position is empty, id=" .. tostring(v.id))
            end
        end
    end
end

this.SetSearchItem = function()
    this.maxScore = 0
    if (#this.searchItemDataList > 0) then
        for i, v in ipairs(this.searchItemDataList) do
            if (this.searchItemCacheTab[i] == nil or this.searchItemCacheTab[i].Obj == nil) then
                this.searchItemCacheTab[i] = {}
                local go = LuaMgr.InstantiateGO(this.searchItemObj, this.searchItemsBox, false)
                local cache = {}
                cache.go = go
                cache.btn = go.transform:GetComponent("Button")
                cache.icon = go.transform:Find("icon"):GetComponent("Image");
                cache.imageBg = go.transform:Find("ImageBg"):GetComponent("Image");
                cache.textName = go.transform:Find("ImageBg/TextName"):GetComponent("Text");
                cache.imageStarBg = go.transform:Find("ImageStarBg");
                cache.imageRed = go.transform:Find("ImageRed");
                cache.imageCloud = go.transform:Find("ImageCloud");
                cache.effect = go.transform:Find("vfx_saoguang");
                this.searchItemCacheTab[i].Obj = cache
            end
            local obj = this.searchItemCacheTab[i].Obj
            obj.go.transform.localPosition = Vector3(tonumber(v.pos[1]), tonumber(v.pos[2]), 0)
            local bPlay = FSMYMgr.GetPlayerAnimation()
            SetActive(obj.go, not bPlay)
            local showStr = this.CheckShowPlayIcon(v)
            obj.icon.sprite = LuaMgr.GetSprite("FSMY", "ui_hd_tymt_xyx_gk_" .. showStr);
            obj.textName.text = v.name;
            SetActive(obj.imageRed.gameObject, FSMYMgr.redEventMap[v.id] ~= nil)
            SetActive(obj.imageStarBg.gameObject, v.isfinish)
            SetActive(obj.effect.gameObject, v.isNew and not v.isfinish and v.isUnlock)
            if (v.isfinish) then
                this.CheckShowStarNum(v.config, obj.imageStarBg)
            end
            SetActive(obj.imageCloud.gameObject, v.config.isBonus)
            local onclick = function()
                if (not v.isUnlock) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FSMYLevelViewModel_0"))
                    return
                end
                this.selectedSearchItem = obj
                this.selectedSearchItem.config = v.config
                local key = DataMgr.Player.uid .. "FSMY_" .. v.config.id;
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
    this.PlaySearchItem()
    this.totalScoreText.text = this.maxScore
end

this.CheckShowStarNum = function(_config, starBox)
    local levelConfig = ConfigMgr.Config.HackGameLevelMap[_config.id]
    if not levelConfig then return end
    local hackGame = DataMgr.Player.HackGame
    local curScore = hackGame and hackGame.LevelScoreMap and hackGame.LevelScoreMap[_config.id] or 0
    this.maxScore = this.maxScore + curScore
    for i, v in ipairs(levelConfig.Conditions) do
        local star = starBox:GetChild(i - 1):GetChild(0)
        if (v <= curScore) then
            star.gameObject:SetActive(true)
        else
            star.gameObject:SetActive(false)
        end
    end
end

this.PlaySearchItem = function()
    local bPlay = FSMYMgr.GetPlayerAnimation()
    if (bPlay) then
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
        end
        this.ShowLine(false)
        this.startDelay2 = coroutine_runner.start(function()
            for i, v in ipairs(this.searchItemDataList) do
                coroutine_runner.wait(0.1)
                local obj = this.searchItemCacheTab[i].Obj
                SetActive(obj.go, true)
            end
            FSMYMgr.SetPlayerAnimation(false)
            this.ShowLine(true)
        end)
    else
        this.ShowLine(true)
    end
end

this.ShowLine = function(bShow)
    for i = 0, this.lineBox1.childCount - 1 do
        local line = this.lineBox1:GetChild(i)
        SetActive(line.gameObject, bShow and i >= this.finishNum)
    end
    for i = 0, this.lineBox2.childCount - 1 do
        local line = this.lineBox2:GetChild(i)
        SetActive(line.gameObject, bShow and i < this.finishNum)
    end
end


this.CheckShowPlayIcon = function(_config)
    if (_config.isUnlock) then
        if (_config.isfinish) then
            return "ywc"
        else
            if (_config.config.isBonus) then
                return "yjs_bonus"
            else
                return "yjs"
            end
        end
    else
        return "wjs"
    end
end

this.OnClickMission = function()
    if not this.CheckActivityRunning() then
        return
    end
    this.SetLevelList()
    SetActive(this.missionPanelBtn.gameObject, true)
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
        scrollData = UIScrollData.GetData(this.levelItemObj, "FSMYLevelItem", 760, 95,
            {
                config = this.eventList[i],
                callback = function()
                    HeroRedDataHelper.SetFSMYRed()
                    RedMgr.Singleton:Refresh()
                    this.SetLevelList()
                end
            });
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(948, 611);
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
    local area = config.area
    if (area == FSMYLevelType.Repeat or area == FSMYLevelType.Main or area == FSMYLevelType.Difficult) then
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = config.id
        enterDungeonParams.dungeonId = config.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    elseif (area == FSMYLevelType.Play) then
        LuaMgr.ShowLuaPanel(UIName.FSMYGameViewModel, config);
    elseif (area == FSMYLevelType.Story) then
        LuaMgr.PlayNovel(config.eventParam, function()
            if (this.tapIndex == nil) then
                LuaMgr.ShowLuaPanel(UIName.FSMYLevelViewModel);
            else
                LuaMgr.ShowLuaPanel(UIName.FSMYLevelViewModel, this.tapIndex);
            end
        end);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission);
        LuaMgr.AddClick(this.missionPanelBtn, this.OnClickMissionPanelClose);
        RedMgr.Singleton:RegisterViewModel(UIName.FSMYLevelViewModel);
        this.levelSV = UIScrollView.New(this.scrollView);
    end,
    before_active = function(vm)
        FSMYMgr.SetPlayerAnimation(true)
        HeroRedDataHelper.SetFSMYRed()
        RedMgr.Singleton:Refresh()
        if vm.behaviour.Params ~= nil and vm.behaviour.Params.Length > 0 then
            this.tapIndex = vm.behaviour.Params[0]
            this.OnClickTap(this.tapIndex)
        else
            this.SetData();
        end
        vm.behaviour:UpdateTopBar("" .. this.tapIndex, this.OnBack);
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
        LuaMgr.RemoveClick(this.missionPanelBtn, this.OnClickMissionPanelClose);
        if (this.tabBoxTab ~= nil and #this.tabBoxTab > 0) then
            for i = 1, #this.tabBoxTab do
                LuaMgr.RemoveClick(this.tabBoxTab[i].btn, this.tabBoxTab[i].btnFunc)
            end
        end
        UIScrollView.ClearItem("FSMYLevelItem");
        RedMgr.Singleton:RemoveViewModel(UIName.FSMYLevelViewModel);
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.FSMY) then
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