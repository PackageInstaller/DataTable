require("ViewModel/WJWY/Data/WJWYConst")
require("ViewModel/WJWY/ViewItem/WJWYLevelItem")

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


local SEARCH_LAYOUT_CONFIG = {
    oddCount = 5,
    evenCount = 4,
    itemWidth = 140,
    itemHeight = 175,
    gapX = 26,
    gapY = 30,
    paddingTop = 20,
    paddingBottom = 30,
    paddingLeft = nil,
}

local objs = {
    searchItemObj = { path = "template/SearchItem", type = "GameObject" },
    levelItemObj = { path = "template/LevelItem", type = "GameObject" },
    root = { path = "root", type = "RectTransform" },
    searchItemsBox = { path = "root/ScrollView/Viewport/SearchItemsBox", type = "RectTransform" },
    searchScrollView = { path = "root/ScrollView", type = "ScrollRect" },
    missionPanelBtn = { path = "root/missionPanelBtn", type = "Button" },
    missionBtn = { path = "root/Right/MissionBtn", type = "Button" },
    middle = { path = "root/Middle", type = "Transform" },
    scrollView = { path = "root/missionPanelBtn/imageBg/ScrollView", type = "GameObject" },
};

this.GetEventListByTap = function()
    local sourceList = WJWYData.GetActiveEventsByArea(WJWYConst.EventType.Play)
    local list = {}
    if sourceList ~= nil then
        for i, v in ipairs(sourceList) do
            table.insert(list, v)
        end
    end
    return list, WJWYConst.EventType.Play
end


this.OnBack = function()
    LuaMgr.Back()
end


this.SetData = function()
    WJWYData.CheckActivityRunning(true)
    if (this.eventList == nil) then
        this.eventList = {}
        local configQuest = DataExHelper.Check_ConfigQuestEventByText(WJWYConst.QuestEventID) or {};
        for k, v in pairs(configQuest) do
            table.insert(this.eventList, v)
        end
    end
    local cacheList = this.GetEventListByTap()
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
            local isUnlock, unlockDesc = WJWYData.CheckUnlock(v)
            cache.isUnlock = isUnlock
            cache.unlockDesc = unlockDesc
            cache.isfinish = WJWYData.CheckFinish(v)
            local key = DataMgr.Player.uid .. "WJWY_" .. v.id;
            cache.isNew = PlayerPrefs.GetInt(key) == 0
            cache.name = LuaMgr.GetLangText(v.namelan);
            cache.config = v
            table.insert(this.searchItemDataList, cache)
            if (cache.isfinish) then
                this.finishNum = this.finishNum + 1
            end
        end
        this.finishAll = this.finishNum == #_configList
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
            if obj.icon and not IsObjectNull(obj.icon) then
                SetActive(obj.icon.gameObject, v.isUnlock)
            end
            if obj.iconLock and not IsObjectNull(obj.iconLock) then
                SetActive(obj.iconLock.gameObject, not v.isUnlock)
            end
            if obj.iconFinish and not IsObjectNull(obj.iconFinish) then
                SetActive(obj.iconFinish.gameObject, v.isfinish)
            end
            if obj.textTitle and not IsObjectNull(obj.textTitle) then
                obj.textTitle.text = v.name or "";
            end
            if obj.textTitleLock and not IsObjectNull(obj.textTitleLock) then
                obj.textTitleLock.text = v.name or "";
            end
            local onclick = function()
                if (not v.isUnlock) then
                    local tip = v.unlockDesc
                    if IsNullOrEmpty(tip) then
                        tip = LuaMgr.GetLangText("FSMYLevelViewModel_0")
                    end
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tip)
                    return
                end
                this.selectedSearchItem = obj
                this.selectedSearchItem.config = v.config
                local key = DataMgr.Player.uid .. "WJWY_" .. v.config.id;
                PlayerPrefs.SetInt(key, 1);
                this.OnClickSmallBattleBtn()
            end
            if obj.btn and not IsObjectNull(obj.btn) then
                obj.btn.onClick:RemoveAllListeners()
                LuaMgr.AddClick(obj.btn, onclick)
            end
        end
    end
    local num1 = #this.searchItemCacheTab
    local num2 = #this.searchItemDataList
    if (num2 < num1) then
        for i = num2 + 1, num1 do
            if this.searchItemCacheTab[i] and this.searchItemCacheTab[i].Obj and this.searchItemCacheTab[i].Obj.go and not IsObjectNull(this.searchItemCacheTab[i].Obj.go) then
                SetActive(this.searchItemCacheTab[i].Obj.go, false)
            end
        end
    end

    this.UpdateSearchItemsLayout()
    this.ScrollToNewItem()
end

this.GetObj = function(tf)
    local go = LuaMgr.InstantiateGO(this.searchItemObj, tf, false)
    local cache = {}
    cache.go = go
    cache.rectTransform = go:GetComponent("RectTransform")
    cache.btn = go.transform:GetComponent("Button")
    cache.icon = go.transform:Find("icon")
    cache.iconLock = go.transform:Find("iconLock")
    cache.iconFinish = go.transform:Find("iconFinish")
    local textTitleTrans = go.transform:Find("TextTitle1")
    if textTitleTrans ~= nil then
        cache.textTitle = textTitleTrans:GetComponent("Text");
    end
    textTitleTrans = cache.iconLock:Find("TextTitle")
    if textTitleTrans ~= nil then
        cache.textTitleLock = textTitleTrans:GetComponent("Text");
    end
    return cache
end


this.UpdateSearchItemsLayout = function()
    local totalCount = #this.searchItemDataList
    if totalCount <= 0 then
        return
    end

    local maxRow = 1
    for i = 1, totalCount do
        local itemCache = this.searchItemCacheTab[i]
        if itemCache and itemCache.Obj and itemCache.Obj.go and not IsObjectNull(itemCache.Obj.go) then
            local pos, row, col = this.GetSearchItemPosByIndex(i)
            if row > maxRow then
                maxRow = row
            end

            local rt = itemCache.Obj.rectTransform
            if rt == nil or IsObjectNull(rt) then
                rt = itemCache.Obj.go:GetComponent("RectTransform")
                itemCache.Obj.rectTransform = rt
            end
            if rt and not IsObjectNull(rt) then
                rt.anchorMin = Vector2(0, 1)
                rt.anchorMax = Vector2(0, 1)
                rt.pivot = Vector2(0.5, 0.5)
                rt.sizeDelta = Vector2(SEARCH_LAYOUT_CONFIG.itemWidth, SEARCH_LAYOUT_CONFIG.itemHeight)
                rt.anchoredPosition = pos
            end
        end
    end


    local cfg = SEARCH_LAYOUT_CONFIG
    local stepY = cfg.itemHeight + cfg.gapY
    local totalHeight = cfg.paddingTop + (maxRow - 1) * stepY + cfg.itemHeight + cfg.paddingBottom
    if this.searchItemsBox and not IsObjectNull(this.searchItemsBox) then
        local currentWidth = this.searchItemsBox.sizeDelta.x
        if currentWidth <= 0 then
            currentWidth = 898
        end
        this.searchItemsBox.sizeDelta = Vector2(currentWidth, totalHeight)
    end
end


this.GetSearchItemPosByIndex = function(index)
    local cfg = SEARCH_LAYOUT_CONFIG
    local cycleSize = cfg.oddCount + cfg.evenCount
    local cycle = math.floor((index - 1) / cycleSize)
    local rem = (index - 1) % cycleSize

    local row, col, isEven
    if rem < cfg.oddCount then

        row = cycle * 2 + 1
        col = rem + 1
        isEven = false
    else

        row = cycle * 2 + 2
        col = (rem - cfg.oddCount) + 1
        isEven = true
    end

    local stepX = cfg.itemWidth + cfg.gapX
    local stepY = cfg.itemHeight + cfg.gapY


    local paddingLeft = cfg.paddingLeft
    if paddingLeft == nil then
        local boxWidth = (this.searchItemsBox and not IsObjectNull(this.searchItemsBox) and this.searchItemsBox.rect.width > 0) and
            this.searchItemsBox.rect.width or
            898
        local oddTotalWidth = cfg.oddCount * cfg.itemWidth + (cfg.oddCount - 1) * cfg.gapX
        paddingLeft = math.max(0, (boxWidth - oddTotalWidth) * 0.5)
    end


    local startX = paddingLeft + cfg.itemWidth * 0.5
    local posX = startX + (col - 1) * stepX
    if isEven then

        posX = posX + stepX * 0.5
    end


    local startY = -(cfg.paddingTop + cfg.itemHeight * 0.5)
    local posY = startY - (row - 1) * stepY

    return Vector2(posX, posY), row, col
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
            if not v.isfinish and v.isUnlock then
                targetIndex = i
                break
            end
        end
    end

    if targetIndex then
        this.ScrollToIndex(targetIndex)
    end
end




this.ScrollToIndex = function(targetIndex, immediate)
    local totalCount = #this.searchItemDataList
    if targetIndex == nil or targetIndex < 1 or targetIndex > totalCount or totalCount <= 0 then
        return
    end

    local pos, targetRow, _ = this.GetSearchItemPosByIndex(targetIndex)
    local _, totalRows, _ = this.GetSearchItemPosByIndex(totalCount)

    local doScroll = function()
        local scrollRect = this.searchScrollView
        if not scrollRect or IsObjectNull(scrollRect) then
            return
        end

        local viewport = scrollRect.viewport
        local viewportHeight = 0
        if viewport and not IsObjectNull(viewport) then
            viewportHeight = viewport.rect.height
        elseif scrollRect.transform and not IsObjectNull(scrollRect.transform) then
            local rt = scrollRect.transform:GetComponent("RectTransform")
            if rt then
                viewportHeight = rt.rect.height
            end
        end

        local contentHeight = (this.searchItemsBox and not IsObjectNull(this.searchItemsBox)) and
            this.searchItemsBox.sizeDelta.y or 0
        local maxScrollY = contentHeight - viewportHeight

        if maxScrollY > 0 and viewportHeight > 0 then

            local itemCenterY = -pos.y
            local targetContentY = itemCenterY - viewportHeight * 0.5
            targetContentY = math.max(0, math.min(maxScrollY, targetContentY))
            local normalizedPos = 1 - (targetContentY / maxScrollY)
            scrollRect.verticalNormalizedPosition = math.max(0, math.min(1, normalizedPos))
        elseif totalRows > 1 then
            local ratio = (targetRow - 1) / (totalRows - 1)
            scrollRect.verticalNormalizedPosition = 1 - math.max(0, math.min(1, ratio))
        else
            scrollRect.verticalNormalizedPosition = 1
        end
    end

    if immediate then
        doScroll()
    else
        doScroll()
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
            this.startDelay = nil
        end
        this.startDelay = coroutine_runner.start(function()
            coroutine_runner.wait(0)
            doScroll()
            this.startDelay = nil
        end)
    end
end

this.PlaySearchItem = function()
    local bPlay = WJWYData.GetPlayerAnimation()
    if (bPlay) then
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
            this.startDelay2 = nil
        end

        this.startDelay2 = coroutine_runner.start(function()
            for i, v in ipairs(this.searchItemDataList) do
                coroutine_runner.wait(0.1)
                if this.searchItemCacheTab[i] and this.searchItemCacheTab[i].Obj and this.searchItemCacheTab[i].Obj.go and not IsObjectNull(this.searchItemCacheTab[i].Obj.go) then
                    SetActive(this.searchItemCacheTab[i].Obj.go, true)
                end
            end
            WJWYData.SetPlayerAnimation(false)
            this.startDelay2 = nil
        end)
    end
end

this.OnClickMission = function()
    if not this.CheckActivityRunning() then
        return
    end
    this.SetLevelList()
    if this.missionPanelBtn and not IsObjectNull(this.missionPanelBtn) then
        SetActive(this.missionPanelBtn.gameObject, true)
    end
end


this.OnClickMissionPanelClose = function()
    if this.missionPanelBtn and not IsObjectNull(this.missionPanelBtn) then
        SetActive(this.missionPanelBtn.gameObject, false)
    end
end


this.SetLevelList = function()
    if this.eventList == nil or #this.eventList == 0 then
        if this.levelSV ~= nil then
            this.levelSV:Clear(false)
        end
        return
    end
    table.sort(this.eventList, function(a, b)
        local state1 = DataExHelper.Check_RewardState(a.id) % 3;
        local state2 = DataExHelper.Check_RewardState(b.id) % 3;
        if (state1 == state2) then
            return (a.sort or 0) < (b.sort or 0);
        elseif state1 < state2 then
            return false
        else
            return true
        end
    end)
    if this.levelSV ~= nil then
        this.levelSV:Clear(false);
        local scrollDatas = {};
        local len = #this.eventList;
        for i = 1, len do
            local scrollData = UIScrollData.GetData(this.levelItemObj, "WJWYLevelItem", 564, 95,
                {
                    config = this.eventList[i],
                    totalList = this.eventList,
                    callback = function()
                        this.SetLevelList()
                        WJWYData.CheckRedPoint()
                        RedMgr.Singleton:Refresh()
                    end
                });
            table.insert(scrollDatas, scrollData);
        end
        this.levelSV:SetParams(564, 283);
        this.levelSV:SetData(scrollDatas, true);
    end
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
    LuaMgr.ShowLuaPanel(UIName.WJWYGamePanel, config);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission);
        LuaMgr.AddClick(this.missionPanelBtn, this.OnClickMissionPanelClose);
        RedMgr.Singleton:RegisterViewModel(UIName.WJWYLevelPanel);
        this.levelSV = UIScrollView.New(this.scrollView);
    end,
    before_active = function(vm)
        WJWYData.SetPlayerAnimation(true)
        WJWYData.CheckRedPoint()
        RedMgr.Singleton:Refresh()
        this.SetData()
        vm.behaviour:UpdateTopBar("", this.OnBack);
    end,
    before_deactive = function(vm)
        this.OnClickMissionPanelClose()
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
            this.startDelay = nil
        end
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
            this.startDelay2 = nil
        end
        if this.levelSV ~= nil then
            this.levelSV:Clear(true);
        end
    end,
    before_destroy = function()
        if this.missionBtn ~= nil and not IsObjectNull(this.missionBtn) then
            LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission);
        end
        if this.missionPanelBtn ~= nil and not IsObjectNull(this.missionPanelBtn) then
            LuaMgr.RemoveClick(this.missionPanelBtn, this.OnClickMissionPanelClose);
        end
        if (this.tabBoxTab ~= nil and #this.tabBoxTab > 0) then
            for i = 1, #this.tabBoxTab do
                if this.tabBoxTab[i].btn ~= nil and not IsObjectNull(this.tabBoxTab[i].btn) then
                    LuaMgr.RemoveClick(this.tabBoxTab[i].btn, this.tabBoxTab[i].btnFunc)
                end
            end
            this.tabBoxTab = {}
        end
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
            this.startDelay = nil
        end
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
            this.startDelay2 = nil
        end
        if this.levelSV ~= nil then
            this.levelSV:Clear(true)
            this.levelSV:Destroy()
            this.levelSV = nil
        end
        UIScrollView.ClearItem("WJWYLevelItem");
        RedMgr.Singleton:RemoveViewModel(UIName.WJWYLevelPanel);
        this.searchItemCacheTab = {}
        this.searchItemDataList = {}
        this.selectedSearchItem = nil
        this.eventList = nil
    end
}

this.CheckActivityRunning = function(isStatic)
    return WJWYData.CheckActivityRunning(isStatic)
end

return vm({
    data = data,
    command = command,
    hook = hook
})