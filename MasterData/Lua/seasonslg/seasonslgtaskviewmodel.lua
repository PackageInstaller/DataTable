require("SeasonSLG/TaskBarItem")
require("SeasonSLG/TaskWeekItem")
require("SeasonSLG/TaskDailyItem")
require("SeasonSLG/TaskDispatchItem")
require("SeasonSLG/TaskLivenessItem")
require("SeasonSLG/TaskRewardItem")
require("SeasonSLG/WorldTaskProgressItem")
require("SeasonSLG/SeasonSLGBuffItem")
require("SeasonSLG/HeroChoiceModel")

local this = {
    vm = nil,
    activeTab = 1,
    taskMap = {},
    dispatchList = {},
    dispatchSelectModel = nil,
    dispatchSelectData = nil,
    curStageRewardData = nil,
    refreshTime = nil,
    tabUIList = nil,
    weekTaskUIList = nil,
    dayTaskUIList = nil,
    dispatchUIList = nil,
    stageRewardUIList = nil,
    rewardItemList = nil,
    otherDispatchRewardUIList = nil,
    worldProgressUIList = nil,
    curWeekBuffUIList = nil,
    lastWeekBuffUIList = nil,
    worldTaskConfig = nil,
    worldTaskRewardList = {},
    lastWeekBuffKey = nil,
    curWeekBuffKey = nil,

    originRewardPopBGSize = Vector2(268, 200),
    originRewardPopContentSize = Vector2(205, 56.4),
}

local ui = {}

local data = {
    tabs = {
        { id = 1, name = "", selected = true },
        { id = 2, name = "", selected = false },
        { id = 3, name = "", selected = false },
    },
    refreshTimeText = "",
    weekValueText = "",
    dailyValueText = "",
    havaDisPatch = false,
    showEmpty = false,
}

local command = {
    tabCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SwitchTab(tonumber(param) or 1)
        end
    },
    taskJumpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local taskId = tostring(param)
            local taskCfg = this.taskMap[taskId]
            if taskCfg ~= nil and not IsNullOrEmpty(taskCfg.PageSkip) then
                FeatureManager.GotoViewModel(taskCfg.PageSkip)
            end
        end
    },
    taskRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickTaskItemReward(param)
        end
    },
    stageRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.ShowStageRewardPop(param)
        end
    },
    dispatchOpenCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.ShowDispatchSelectPanel(param)
        end
    },
    dispatchRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickDispatchExtraReward()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)

        this.tabUIList = UIListView.New(ui.tranBarContent)
        this.weekTaskUIList = UIScrollView.New(ui.goWeekScrollView)
        this.dayTaskUIList = UIScrollView.New(ui.goScrollView)
        this.dispatchUIList = UIScrollView.New(ui.goDispathScrollView)
        this.stageRewardUIList = UIScrollView.New(ui.goWeekLivenessScrollView.gameObject)
        this.otherDispatchRewardUIList = UIListView.New(ui.tranOtherDispatchRewardContent)
        this.worldProgressUIList = UIScrollView.New(ui.goWorldTaskProgressRewardScrollView)
        this.curWeekBuffUIList = UIListView.New(ui.curWeekContent.transform)
        this.lastWeekBuffUIList = UIListView.New(ui.lastWeekContent.transform)
        this.weekTaskUIList:SetParams()
        this.dayTaskUIList:SetParams()
        this.dispatchUIList:SetParams()
        this.stageRewardUIList:SetParams()
        this.worldProgressUIList:SetParams()

        if ui.btnTrffic ~= nil then
            ui.btnTrffic.onClick:AddListener(function()
                LuaMgr.ShowLuaPanel(UIName.SeasonSLGTrafficPermitViewModel);
            end)
        end
        if ui.btnRewardOtherDispatch ~= nil then
            ui.btnRewardOtherDispatch.onClick:AddListener(function()
                this.OnClickDispatchExtraReward()
            end)
        end
        if ui.btnWorldTaskGoto ~= nil then
            ui.btnWorldTaskGoto.onClick:AddListener(this.OnClickWorldTaskGoto)
        end
        RedMgr.Singleton:RegisterViewModel(UIName.SeasonSLGTaskViewModel);
    end,
    before_active = function(vm)
        this.activeTab = 1
        if vm.behaviour.Params == nil then
            return
        end
        if vm.behaviour.Params.Length > 0 then
            local tabId = tonumber(vm.behaviour.Params[0])
            if tabId ~= nil and tabId >= 1 and tabId <= 4 then
                this.activeTab = tabId
            end
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.OnHeartBeat)
        LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.OnHeartBeat)
        this.ParseData()
        HeroRedDataHelper.SetSeasonSLGRed()
        this.RefreshTabRed()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.OnHeartBeat)
        if this.tabUIList ~= nil then
            this.tabUIList:Clear()
        end
        if this.weekTaskUIList ~= nil then
            this.weekTaskUIList:Clear()
        end
        if this.dayTaskUIList ~= nil then
            this.dayTaskUIList:Clear()
        end
        if this.dispatchUIList ~= nil then
            this.dispatchUIList:Clear()
        end
        if this.stageRewardUIList ~= nil then
            this.stageRewardUIList:Clear()
        end
        this.ClearRewardItems()
        if this.otherDispatchRewardUIList ~= nil then
            this.otherDispatchRewardUIList:Clear()
        end
        if this.worldProgressUIList ~= nil then
            this.worldProgressUIList:Clear()
        end
        if this.curWeekBuffUIList ~= nil then
            this.curWeekBuffUIList:Clear()
        end
        if this.lastWeekBuffUIList ~= nil then
            this.lastWeekBuffUIList:Clear()
        end
        this.HideStageRewardPop()
        this.HideWorldProgressRewardPop()
        this.HideDispatchSelectPanel()
        this.lastWeekBuffKey = nil
        this.curWeekBuffKey = nil
            LuaMgr.RemoveTimer(TimerConst.SeasonSLGTaskRefreshTimer)
    end,
    before_destroy = function()
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.OnHeartBeat)
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGTaskRefreshTimer)
        if this.dispatchSelectModel ~= nil then
            this.dispatchSelectModel:Destroy()
            this.dispatchSelectModel = nil
        end
        UIListView.ClearItem("TaskBarItem")
        UIScrollView.ClearItem("TaskWeekItem")
        UIScrollView.ClearItem("TaskDailyItem")
        UIScrollView.ClearItem("TaskDispatchItem")
        UIScrollView.ClearItem("TaskLivenessItem")
        UIListView.ClearItem("TaskRewardItem")
        UIListView.ClearItem("SeasonSLGBuffItem")
        UIScrollView.ClearItem("WorldTaskProgressItem")
        if this.otherDispatchRewardUIList ~= nil then
            this.otherDispatchRewardUIList:Clear()
            this.otherDispatchRewardUIList = nil
        end
        if this.worldProgressUIList ~= nil then
            this.worldProgressUIList:Clear()
            this.worldProgressUIList = nil
        end
        if this.curWeekBuffUIList ~= nil then
            this.curWeekBuffUIList:Clear()
            this.curWeekBuffUIList = nil
        end
        if this.lastWeekBuffUIList ~= nil then
            this.lastWeekBuffUIList:Clear()
            this.lastWeekBuffUIList = nil
        end
        if this.rewardItemList ~= nil then
            for _, rewardItem in ipairs(this.rewardItemList) do
                rewardItem:Clear()
            end
            this.rewardItemList = nil
        end
        this.HideStageRewardPop()
        this.HideWorldProgressRewardPop()
        RedMgr.Singleton:RemoveViewModel(UIName.SeasonSLGTaskViewModel);
        this.vm = nil
    end
}

this.InitUI = function(prefab)
    local uiLink = prefab.gameObject:GetComponent("UILinkLua")
    ui.root = uiLink:Get("root")
    ui.Middle = uiLink:Get("Middle")
    ui.goPanelWeek = uiLink:Get("goPanelWeek")
    ui.goWeekScrollView = uiLink:Get("goWeekScrollView")
    ui.goPanelDay = uiLink:Get("goPanelDay")
    ui.goScrollView = uiLink:Get("goScrollView")
    ui.goPanelDispatch = uiLink:Get("goPanelDispatch")
    ui.goDispathScrollView = uiLink:Get("goDispathScrollView")
    ui.goWeekLivenessScrollView = uiLink:Get("goWeekLivenessScrollView"):GetComponent("RectTransform")
    ui.Left = uiLink:Get("Left")
    ui.Right = uiLink:Get("Right")
    ui.txtWeekValue = uiLink:Get("txtWeekValue"):GetComponent("Text")
    ui.txtDailyValue = uiLink:Get("txtDailyValue"):GetComponent("Text")
    ui.txtWorldProgressReward = uiLink:Get("txtWorldProgressReward"):GetComponent("Text")
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text")
    ui.tranLocContent = uiLink:Get("tranLocContent"):GetComponent("RectTransform")
    ui.tranBarContent = uiLink:Get("tranBarContent"):GetComponent("RectTransform")
    ui.tranOtherDispatchRewardContent = uiLink:Get("tranOtherDispatchRewardContent"):GetComponent("RectTransform")
    ui.tranRwardPop = uiLink:Get("tranRwardPop"):GetComponent("RectTransform")
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform")
    ui.tranRewardBG = uiLink:Get("tranRewardBG"):GetComponent("RectTransform")
    ui.tranWorldProgressRewardPop = uiLink:Get("tranWorldProgressRewardPop"):GetComponent("RectTransform")
    ui.btnTrffic = uiLink:Get("btnTrffic"):GetComponent("Button")
    ui.btnRewardOtherDispatch = uiLink:Get("btnRewardOtherDispatch"):GetComponent("Button")
    ui.goSelectCharacter = uiLink:Get("goSelectCharacter")
    if ui.tranRwardPop ~= nil then
        SetActive(ui.tranRwardPop.gameObject, false)
    end
    if ui.tranWorldProgressRewardPop ~= nil then
        SetActive(ui.tranWorldProgressRewardPop.gameObject, false)
    end

    ui.gobarItem = uiLink:Get("gobarItem")
    ui.goweekItem = uiLink:Get("goweekItem")
    ui.goweekLivenessItem = uiLink:Get("goweekLivenessItem")
    ui.godailyItem = uiLink:Get("godailyItem")
    ui.godispatchItem = uiLink:Get("godispatchItem")
    ui.gorewardItem = uiLink:Get("gorewardItem")

    ui.goPanelWorldTask = uiLink:Get("goWorldTask")
    ui.goProgressTag = uiLink:Get("goProgressTag"):GetComponent("RectTransform")
    ui.goworldProgressItem = uiLink:Get("goworldProgressItem")
    ui.goProgress = uiLink:Get("goProgress"):GetComponent("Image")
    ui.txtWorldTaskName = uiLink:Get("txtWorldTaskName"):GetComponent("Text")
    ui.txtWorldTaskLeftTime = uiLink:Get("txtWorldTaskLeftTime"):GetComponent("Text")
    ui.txtWorldTaskdesc = uiLink:Get("txtWorldTaskdesc"):GetComponent("Text")
    ui.txtWorldTaskProgress = uiLink:Get("txtWorldTaskProgress"):GetComponent("Text")
    ui.btnWorldTaskGoto = uiLink:Get("btnWorldTaskGoto"):GetComponent("Button")
    ui.txtWorldTaskProgressPercent = uiLink:Get("txtWorldTaskProgressPercent"):GetComponent("Text")
    ui.goWorldTaskProgressRewardScrollView = uiLink:Get("goWorldTaskProgressRewardScrollView"):GetComponent("RectTransform")
    ui.goPanelBuff = uiLink:Get("goPanelBuff")
    ui.curWeekContent = uiLink:Get("goCurWeek"):GetComponent("VerticalLayoutGroup")
    ui.lastWeekContent = uiLink:Get("goLastWeek"):GetComponent("VerticalLayoutGroup")
    ui.buffContent = uiLink:Get("goBuffContent"):GetComponent("VerticalLayoutGroup")
    ui.goBuffItem = uiLink:Get("goBuffItem")
end

this.ClearUI = function()
    ui = nil
end

this.GetScrollContent = function(scrollGo)
    if IsObjectNull(scrollGo) then
        return nil
    end
    local scrollRect = scrollGo:GetComponent("ScrollRect")
    if scrollRect ~= nil and scrollRect.content ~= nil then
        return scrollRect.content
    end
    return scrollGo.transform
end

this.GetPrefabSize = function(prefab, defaultWidth, defaultHeight)
    if IsObjectNull(prefab) then
        return defaultWidth, defaultHeight
    end
    local rect = prefab:GetComponent("RectTransform")
    if rect == nil then
        return defaultWidth, defaultHeight
    end
    local size = rect.sizeDelta
    local width = size.x > 0 and size.x or defaultWidth
    local height = size.y > 0 and size.y or defaultHeight
    return width, height
end

this.GetWorldProgressRewardText = function(cfg)
    if cfg == nil then
        return ""
    end
    local buffReward = cfg.BuffReward
    local buffId = nil
    if type(buffReward) == "table" then
        buffId = buffReward[1]
    else
        buffId = buffReward
    end
    if IsNullOrEmpty(buffId) or ConfigMgr.Config.SeasonalProduceBuffMap == nil then
        return ""
    end

    local buffConfig = ConfigMgr.Config.SeasonalProduceBuffMap[buffId] or ConfigMgr.Config.SeasonalProduceBuffMap[tostring(buffId)]
    if buffConfig ~= nil then
        return LuaMgr.GetLangText(buffConfig.NameLan);
    end
     buffConfig = ConfigMgr.Config.SeasonalBuffMap[buffId];
    if buffConfig~=nil then
        return LuaMgr.GetLangText(buffConfig.BuffDesLan);
    end

    return ""
end

local POPUP_SCREEN_MARGIN = 0

local POPUP_MASK_MIN_SIZE = 2000

this.GetPopupContentExtentX = function(popup)
    local left = 0
    local right = 0
    local popupWidth = popup.rect.width
    local hasContent = false
    for i = 0, popup.childCount - 1 do
        local childRect = popup:GetChild(i):GetComponent("RectTransform")
        if childRect ~= nil then
            local width = childRect.rect.width
            local height = childRect.rect.height
            if width > 0 and not (width >= POPUP_MASK_MIN_SIZE and height >= POPUP_MASK_MIN_SIZE) then
                local anchorMinX = childRect.anchorMin.x
                local anchorMaxX = childRect.anchorMax.x
                local childPivotX = childRect.pivot.x
                local pivotOffsetX = (anchorMinX - popup.pivot.x) * popupWidth
                        + childRect.anchoredPosition.x
                        + (anchorMaxX - anchorMinX) * popupWidth * childPivotX
                left = math.min(left, pivotOffsetX - width * childPivotX)
                right = math.max(right, pivotOffsetX + width * (1 - childPivotX))
                hasContent = true
            end
        end
    end
    if not hasContent then
        left = -popupWidth * popup.pivot.x
        right = popupWidth * (1 - popup.pivot.x)
    end
    return left, right
end

this.SetPopupPosition = function(popup, itemTransform)
    if popup == nil then
        return
    end

    local hostRect = nil
    if popup.parent ~= nil then
        hostRect = popup.parent:GetComponent("RectTransform")
    end

    if hostRect ~= nil then
        local anchorOffsetX = (popup.anchorMin.x - hostRect.pivot.x) * hostRect.rect.width
                + (popup.anchorMax.x - popup.anchorMin.x) * hostRect.rect.width * popup.pivot.x

        local targetX = anchorOffsetX + popup.anchoredPosition.x
        if itemTransform ~= nil then
            local itemRect = itemTransform:GetComponent("RectTransform")
            if itemRect ~= nil then
                targetX = LuaMgr.World2Local(itemRect.position, hostRect).x
            end
        end

        local screenWidth = LuaMgr.GetScreenWidth()
        if screenWidth == nil or screenWidth <= 0 then
            screenWidth = LuaMgr.ScreenWidth()
        end
        local contentLeft, contentRight = this.GetPopupContentExtentX(popup)
        local halfWidth = screenWidth * 0.5 - POPUP_SCREEN_MARGIN
        local minX = -halfWidth - contentLeft
        local maxX = halfWidth - contentRight
        if targetX < minX then
            targetX = minX
        elseif targetX > maxX then
            targetX = maxX
        end

        popup.anchoredPosition = Vector2(targetX - anchorOffsetX, popup.anchoredPosition.y)
    elseif itemTransform ~= nil then
        local itemRect = itemTransform:GetComponent("RectTransform")
        if itemRect ~= nil then
            local pos = popup.position
            pos.x = itemRect.position.x
            popup.position = pos
        end
    end

    SetActive(popup.gameObject, true)
end

this.ParseData = function()
    SeasonSLGMapMgr.CheckSeasonalData()
    this.taskMap = ConfigMgr.Config.SeasonalTaskMap or {}

    this.SetTabsData()
    this.SetRefreshTime()
    this.RefreshAllContent()
    this.StartRefreshTimer()
end

this.OnHeartBeat = function()
    if this.vm == nil then
        return
    end
    this.taskMap = ConfigMgr.Config.SeasonalTaskMap or {}
    this.dispatchList = SeasonSLGEventMgr.GetDispatchTaskList() or {}
    this.SetRefreshTime()
    this.RefreshAllContent()
end

this.RefreshTabsData = function()
    local tabs = {
        { id = 1, name = LuaMgr.GetLangText("SeasonSlGTaskViewModel_3"), selected = false },
        { id = 2, name = LuaMgr.GetLangText("SeasonSlGTaskViewModel_4"), selected = false },
        { id = 3, name = LuaMgr.GetLangText("SeasonSlGTaskViewModel_5"), selected = false },
    }
    if this.GetActiveWorldTaskConfig() ~= nil then
        table.insert(tabs, { id = 4, name = LuaMgr.GetLangText("SeasonSlGTaskViewModel_6"), selected = false })
    end
    data.tabs = tabs
    if this.vm ~= nil and this.vm.data ~= nil then
        this.vm.data.tabs = data.tabs
    end
end

this.CheckTabExists = function(tabId)
    for _, tabData in ipairs(data.tabs) do
        if tabData.id == tabId then
            return true
        end
    end
    return false
end

this.SetTabsData = function()
    this.RefreshTabsData()
    if not this.CheckTabExists(this.activeTab) then
        this.activeTab = 1
    end
    for i = 1, #data.tabs do
        data.tabs[i].selected = (i == this.activeTab)
    end

    if this.UpdateInstantiatedTabsData() then
        return
    end

    local list = {}
    for _, v in ipairs(data.tabs) do
        local item = {
            id = v.id,
            name = v.name,
            selected = v.selected,
            callBack = function(tabIndex)
                this.SwitchTab(tabIndex)
            end,
        }
        table.insert(list, UIListData.GetData(ui.gobarItem, "TaskBarItem", item))
    end
    if this.tabUIList ~= nil then
        this.tabUIList:SetData(list)
    end
end

this.UpdateInstantiatedTabsData = function()
    if this.tabUIList == nil
            or this.tabUIList.dataList == nil
            or this.tabUIList.itemMap == nil
            or #this.tabUIList.dataList ~= #data.tabs then
        return false
    end

    for i, tabData in ipairs(data.tabs) do
        local listData = this.tabUIList.dataList[i]
        if listData == nil or listData.data == nil or this.tabUIList.itemMap[listData.id] == nil then
            return false
        end
        listData.data.id = tabData.id
        listData.data.name = tabData.name
        listData.data.selected = tabData.selected
        listData.data.callBack = function(tabIndex)
            this.SwitchTab(tabIndex)
        end
    end

    for _, listData in ipairs(this.tabUIList.dataList) do
        local item = this.tabUIList.itemMap[listData.id]
        item:SetData(listData)
    end
    return true
end

this.GetTaskState = function(taskData)
    if taskData == nil then
        return 2
    end
    if taskData.completed then
        return 3
    end
    if taskData.current >= taskData.target then
        return 1
    end
    return 2
end


this.GetTaskGroupByTab = function(tabId)
    if tabId == 1 then
        return "S201"
    elseif tabId == 2 then
        return "S203"
    end
    return ""
end

this.GetStageRewardGroupByTab = function(tabId)
    if tabId == 1 then
        return "S202"
    elseif tabId == 2 then
        return "S204"
    end
    return ""
end

this.CheckTaskRequireComplete = function(taskCfg)
    if taskCfg == nil or IsNullOrEmpty(taskCfg.Require) then
        return true
    end
    local playerTasks = DataMgr.Player.SeasonalTasks or {}
    local requireTask = playerTasks[tostring(taskCfg.Require)]
    return requireTask ~= nil and requireTask.completed
end




this.CheckTabRed = function(tabId)
    local nowTime = LuaMgr.Timestamp()
    local taskMap = this.taskMap or ConfigMgr.Config.SeasonalTaskMap or {}
    if tabId == 1 or tabId == 2 then
        local taskGroup = this.GetTaskGroupByTab(tabId)
        local stageGroup = this.GetStageRewardGroupByTab(tabId)
        for _, cfg in pairs(taskMap) do
            local cfgType = tostring(cfg.Type)
            if (cfgType == taskGroup or cfgType == stageGroup)
                    and SeasonSLGMapMgr.CheckTaskOpen(cfg, nowTime)
                    and this.CheckTaskRequireComplete(cfg)
                    and SeasonSLGMapMgr.CheckTaskRewardCanGet(cfg) then
                return true
            end
        end
        return false
    elseif tabId == 3 then
        local extraRewards = this.BuildDispatchExtraRewardList()
        return extraRewards ~= nil and #extraRewards > 0
    elseif tabId == 4 then
        return false
    end
    return false
end


this.RefreshTabRed = function()
    local tabs = data.tabs or {
        { id = 1 }, { id = 2 }, { id = 3 }, { id = 4 },
    }
    for _, tabData in ipairs(tabs) do
        local tabId = tabData.id
        local hasRed = this.CheckTabRed(tabId)
        RedMgr.Singleton:UpdateClientRedData("18007_" .. tabId, hasRed and 1 or 0)
    end
    RedMgr.Singleton:Refresh()
end

this.BuildMissionList = function(tabId)
    local group = this.GetTaskGroupByTab(tabId)
    local list = {}
    local playerTasks = DataMgr.Player.SeasonalTasks or {}
    local nowTime = LuaMgr.Timestamp()
    for _, cfg in pairs(this.taskMap or {}) do
        if cfg.Type == group
                and SeasonSLGMapMgr.CheckTaskOpen(cfg, nowTime)
                and this.CheckTaskRequireComplete(cfg) then
            local mission = playerTasks[cfg.Id]
            local current = 0
            local target = 0
            local groupCurrent = 0
            local groupTarget = 0
            local completed = false
            local remainingTimes = 0
            if mission ~= nil then
                current = mission.current
                target = mission.target
                groupCurrent = mission.groupCurrent
                groupTarget = mission.groupTarget
                completed = mission.completed
                remainingTimes = mission.remainingTimes

                local state = this.GetTaskState({
                    current = current,
                    target = target,
                    completed = completed,
                })

                local item = {
                    id = cfg.Id,
                    config = cfg,
                    current = current,
                    target = target,
                    groupCurrent = groupCurrent,
                    groupTarget = groupTarget,
                    remainingTimes = remainingTimes,
                    completed = completed,
                    canGet = state == 1,
                    isDone = state == 3,
                    isProgress = state == 2,
                    state = state,
                    jumpCallBack = function()
                        this.OnClickTaskJump(cfg.Id)
                    end,
                    rewardCallBack = function()
                        this.OnClickTaskItemReward(cfg.Id)
                    end,
                }
                local prefab = tabId == 1 and ui.godailyItem or ui.goweekItem
                local className = tabId == 1 and "TaskDailyItem" or "TaskWeekItem"
                local width, height = this.GetPrefabSize(prefab, 520, 100)
                table.insert(list, UIScrollData.GetData(prefab, className, width, height, item))
            end
        end
    end
    table.sort(list, function(a, b)
        local da = a.data
        local db = b.data
        if da.state ~= db.state then
            return da.state < db.state
        end
        return tonumber(da.config.Sort) < tonumber(db.config.Sort)
    end)
    return list
end

this.GetCurrentProgress = function(tabId)
    local group = this.GetStageRewardGroupByTab(tabId)
    local max = 0
    local playerTasks = DataMgr.Player.SeasonalTasks or {}
    local nowTime = LuaMgr.Timestamp()
    for _, cfg in pairs(this.taskMap or {}) do
        if cfg.Type == group and SeasonSLGMapMgr.CheckTaskOpen(cfg, nowTime) then
            local mission = playerTasks[cfg.Id]
            if mission ~= nil and (mission.current or 0) > max then
                max = mission.current or 0
            end
        end
    end
    return max
end

this.IsStageRewarded = function(key)
    local records = DataMgr.Player.SeasonalTasks or {}
    return records[key] ~= nil and records[key].completed
end

this.BuildStageRewardList = function(tabId)
    local group = this.GetStageRewardGroupByTab(tabId)
    local list = {}
    local nowTime = LuaMgr.Timestamp()
    for k, cfg in pairs(this.taskMap or {}) do
        if cfg.Type == group and SeasonSLGMapMgr.CheckTaskOpen(cfg, nowTime) then
            local targetProgress = tonumber(cfg.Condition.Count) or 0
            local taskInfo = DataMgr.Player.SeasonalTasks[cfg.Id]
            local item = {
                config = cfg,
                currentProgress = taskInfo and taskInfo.current or 0,
                targetProgress = targetProgress,
                rewarded = this.IsStageRewarded(k),
                onClick = function(param) this.ShowStageRewardPop(param)  end,
            }
            local width, height = this.GetPrefabSize(ui.goweekLivenessItem, 100, 100)
            table.insert(list, UIScrollData.GetData(ui.goweekLivenessItem, "TaskLivenessItem", width, height, item))
        end
    end
    table.sort(list, function(a, b)
        return (a.data.config.Sort or 0) < (b.data.config.Sort or 0)
    end)
    return list
end

this.SetTaskContent = function(tabId)
    local list = this.BuildMissionList(tabId)
    if tabId == 1 then
        if this.dayTaskUIList ~= nil then
            this.dayTaskUIList:Clear()
            this.dayTaskUIList:SetData(list)
        end
    elseif tabId == 2 then
        if this.weekTaskUIList ~= nil then
            this.weekTaskUIList:Clear()
            this.weekTaskUIList:SetData(list)
        end
    end
end

this.SetStageRewardContent = function(tabId)
    local list = this.BuildStageRewardList(tabId);

    if this.stageRewardUIList ~= nil then
        this.stageRewardUIList:Clear();
        this.stageRewardUIList:SetData(list);
    end
end


this.ClearRewardItems = function()
    if this.rewardItemList == nil then
        return
    end
    for _, rewardItem in ipairs(this.rewardItemList) do
        rewardItem:Hide()
    end
end

this.SetRewardContent = function(stageRewardData)
    this.ClearRewardItems()
    if stageRewardData == nil or stageRewardData.config == nil or ui.tranRewardContent == nil then
        return
    end
    local rewardList = stageRewardData.config.Reward
    if IsNull(rewardList) or #rewardList == 0 then
        return
    end
    local originBGSize = this.originRewardPopBGSize
    local originContentSize = this.originRewardPopContentSize
    local stepBGSizeX = 350 - originBGSize.x
    local stepContentSizeX = 400 - originContentSize.x
    ui.tranRewardBG.sizeDelta = Vector2(originBGSize.x + stepBGSizeX * (#rewardList - 2), 200)
    ui.tranRewardContent.sizeDelta = Vector2(originContentSize.x + stepContentSizeX * (#rewardList - 2), 56.4)
    if this.rewardItemList == nil then
        this.rewardItemList = {}
    end
    for i, reward in ipairs(rewardList) do
        local itemConfig = ConfigMgr.Config.itemMap[reward.id]
        if itemConfig ~= nil then
            if this.rewardItemList[i] == nil then
                this.rewardItemList[i] = GoodsDataItem.New(ui.tranRewardContent)
            end
            local itemData = table.Copy(itemConfig)
            itemData.count0 = reward.count
            SetActive(this.rewardItemList[i].gameObject, true)
            this.rewardItemList[i]:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 0.6), false)
        end
    end
end

this.IsTaskType = function(cfg, taskType)
    return cfg ~= nil and tostring(cfg.Type) == tostring(taskType)
end

this.CheckTaskSeason = function(cfg)
    if cfg == nil then
        return false
    end
    if SeasonSLGMapMgr.curSeasonal == nil then
        return true
    end
    return tostring(cfg.SeasonalID) == tostring(SeasonSLGMapMgr.curSeasonal.Id)
end

this.CheckTaskInTime = function(cfg, nowTime)
    if cfg == nil then
        return false
    end
    nowTime = nowTime or LuaMgr.Timestamp()
    local startTime = tonumber(cfg.StartTime) or 0
    local endTime = tonumber(cfg.EndTime) or 0
    if startTime > 0 and nowTime < startTime then
        return false
    end
    if endTime > 0 and nowTime >= endTime then
        return false
    end
    return true
end

this.GetActiveWorldTaskConfig = function()
    local nowTime = LuaMgr.Timestamp()
    for _, cfg in pairs(this.taskMap or {}) do
        if this.IsTaskType(cfg, "S899")
                and this.CheckTaskSeason(cfg)
                and this.CheckTaskInTime(cfg, nowTime) then
            return cfg
        end
    end
    return nil
end

this.GetTaskRewarded = function(cfg)
    local record = SeasonSLGMapMgr.GetTaskRecord(cfg)
    return record ~= nil and record.completed == true
end

this.FormatWorldTaskLeftTime = function(timeLeft)
    timeLeft = math.max(0, math.floor(timeLeft or 0))
    local day, hour, min, sec = GetTimeDHMS2(timeLeft)
    if day > 0 then
        return string.format(LuaMgr.GetLangText("SeasonSlGTaskViewModel_7"), day, hour, min)
    end
    if hour > 0 then
        return string.format(LuaMgr.GetLangText("SeasonSlGTaskViewModel_8"), hour, min)
    end
    return string.format(LuaMgr.GetLangText("SeasonSlGTaskViewModel_9"), min, sec)
end

this.UpdateWorldTaskTimeText = function()
    if this.worldTaskConfig == nil or ui.txtWorldTaskLeftTime == nil then
        return
    end
    local endTime = tonumber(this.worldTaskConfig.EndTime) or 0
    if endTime <= 0 then
        ui.txtWorldTaskLeftTime.text = ""
        return
    end
    local timeLeft = endTime - LuaMgr.Timestamp()
    if timeLeft <= 0 then
        ui.txtWorldTaskLeftTime.text = LuaMgr.GetLangText("SeasonSlGTaskViewModel_10")
        if this.activeTab == 4 then
            this.activeTab = 1
            this.RefreshAllContent()
        end
        return
    end
    ui.txtWorldTaskLeftTime.text = LuaMgr.GetLangText("SeasonSlGTaskViewModel_11") .. this.FormatWorldTaskLeftTime(timeLeft)
end

this.SetWorldTaskProgressRewardContent = function(curProgress,totalProgress)
    if this.worldProgressUIList == nil then
        return
    end
    local list = {}
    local maxProgress = 0
    this.worldTaskRewardList = SeasonSLGMapMgr.GetWorldTaskRewardConfigList()
    for index, cfg in ipairs(this.worldTaskRewardList) do
        local targetProgress = SeasonSLGMapMgr.GetTaskTarget(cfg)
        local curPro = SeasonSLGMapMgr.GetTaskCurrent(cfg)
        if maxProgress <= targetProgress then
            maxProgress = targetProgress
        end
        if curProgress <= curPro then
            curProgress = curPro
        end
        local rewarded = this.GetTaskRewarded(cfg)
        local item = {
            index = index,
            config = cfg,
            currentProgress = curProgress,
            targetProgress = targetProgress,
            rewarded = rewarded,
            canGet = curProgress >= targetProgress and not rewarded,
            onClick = this.OnClickWorldTaskProgressReward,
        }
        table.insert(list, UIScrollData.GetData(ui.goworldProgressItem, "WorldTaskProgressItem", 172,183,item))
    end
    this.worldProgressUIList:Clear()
    this.worldProgressUIList:SetData(list)



    local rate = this.GetProgress(list,curProgress);
    if ui.goProgress ~= nil then
        ui.goProgress.fillAmount = rate
    end
    local percent =math.floor(curProgress / totalProgress * 1000)
    if percent % 10 == 0 then
        ui.txtWorldTaskProgressPercent.text = string.format("%.f%%",percent / 10.0)
        ui.txtWorldTaskProgress.text = string.format(LuaMgr.GetLangText("SeasonSlGTaskViewModel_12"), percent / 10.0)
    else
        ui.txtWorldTaskProgressPercent.text = string.format("%.1f%%",percent / 10.0)
        ui.txtWorldTaskProgress.text = string.format(LuaMgr.GetLangText("SeasonSlGTaskViewModel_13"), percent / 10.0)
    end
    ui.goProgressTag.anchoredPosition = Vector2(ui.goProgress.transform.sizeDelta.x * rate,0)
end

this.GetProgress=function(list,curPro)
    local step={0.2,0.45,0.69,0.94}
    local curIndex=0;
    local preTargetProgress=0;
    for i,v in ipairs(list) do
        if curPro<v.data.targetProgress then
            local tempStep=(curPro-preTargetProgress)/(v.data.targetProgress-preTargetProgress)
            if curIndex==0 then
                return tempStep*step[1];
            end
            return step[curIndex]+tempStep*(step[i]-step[curIndex]);
        else
            curIndex=curIndex+1;
            preTargetProgress=v.data.targetProgress;
        end
    end
    return 1;
end


this.SetWorldTaskContent = function()
    this.worldTaskConfig = this.GetActiveWorldTaskConfig()
    if this.worldTaskConfig == nil then
        if this.worldProgressUIList ~= nil then
            this.worldProgressUIList:Clear()
        end
        return
    end

    local curProgress = SeasonSLGMapMgr.GetTaskCurrent(this.worldTaskConfig)
    local targetProgress = SeasonSLGMapMgr.GetTaskTarget(this.worldTaskConfig)
    local rate = targetProgress > 0 and curProgress / targetProgress or 0
    if ui.txtWorldTaskName ~= nil then
        ui.txtWorldTaskName.text = LuaMgr.GetLangText(this.worldTaskConfig.NameLan)
    end
    if ui.txtWorldTaskdesc ~= nil then
        ui.txtWorldTaskdesc.text = LuaMgr.GetLangText(this.worldTaskConfig.DescLan)
    end

    this.UpdateWorldTaskTimeText()
    this.SetWorldTaskProgressRewardContent(curProgress,targetProgress)
end

this.OnClickWorldTaskGoto = function()
    if this.worldTaskConfig == nil then
        this.worldTaskConfig = this.GetActiveWorldTaskConfig()
    end
    if this.worldTaskConfig ~= nil and not IsNullOrEmpty(this.worldTaskConfig.PageSkip) then
        if this.worldTaskConfig.PageSkip[1] == "1" then
            SeasonSLGMapMgr.JumpToMapGrid(this.worldTaskConfig.PageSkip[2])
        elseif this.worldTaskConfig.PageSkip[1] == "2" then
            FeatureManager.GotoViewModel(this.worldTaskConfig.PageSkip[2])
        elseif this.worldTaskConfig.PageSkip[1] == "3" then
            SeasonSLGMapMgr.JumpToNearMyGrid(this.worldTaskConfig.PageSkip[2])
        end
    end
end

this.OnClickWorldTaskProgressReward = function(rewardData)
    if rewardData == nil or rewardData.config == nil then
        return
    end




            this.ShowWorldProgressRewardPop(rewardData)







end

this.ShowWorldProgressRewardPop = function(rewardData)
    if rewardData == nil or rewardData.config == nil or ui.tranWorldProgressRewardPop == nil then
        return
    end
    local rewardText = this.GetWorldProgressRewardText(rewardData.config)
    if IsNullOrEmpty(rewardText) then
        return
    end
    if ui.txtWorldProgressReward ~= nil then
        ui.txtWorldProgressReward.text = rewardText
    end
    this.SetPopupPosition(ui.tranWorldProgressRewardPop, rewardData.itemTransform)
    if ui.tranRwardPop ~= nil then
        SetActive(ui.tranRwardPop.gameObject, false)
    end
end

this.HideWorldProgressRewardPop = function()
    if ui.txtWorldProgressReward ~= nil then
        ui.txtWorldProgressReward.text = ""
    end
    if ui.tranWorldProgressRewardPop ~= nil then
        SetActive(ui.tranWorldProgressRewardPop.gameObject, false)
    end
end

this.GetRewardableTaskIdsByType = function(taskType)
    local taskIds = {}
    local playerTasks = DataMgr.Player.SeasonalTasks or {}
    local nowTime = LuaMgr.Timestamp()
    for _, cfg in pairs(this.taskMap or {}) do
        if this.IsTaskType(cfg, taskType)
                and this.CheckTaskSeason(cfg)
                and this.CheckTaskInTime(cfg, nowTime) then
            local taskData = playerTasks[tostring(cfg.Id)] or playerTasks[cfg.Id]
            if taskData ~= nil
                    and taskData.completed ~= true
                    and (tonumber(taskData.current) or 0) >= (tonumber(taskData.target) or 0) then
                table.insert(taskIds, cfg.Id)
            end
        end
    end
    return taskIds
end

this.OnClickTaskItemReward = function(taskId)
    if this.vm == nil then
        return
    end
    local taskCfg = this.taskMap[tostring(taskId)]
    if taskCfg == nil then
        return
    end
    if not this.CheckTaskRequireComplete(taskCfg) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGTaskViewModel_14"))
        return
    end
    local taskIds = this.GetRewardableTaskIdsByType(taskCfg.Type)
    if #taskIds <= 0 then
        return;
    end
    SeasonSLGAPI.OnAskTaskReward(taskIds,
            function(result)
                local re = json.decode(result)
                local rewardData = json.encode(re.result)
                LuaMgr.ShowItemRewared(rewardData)
                this.RefreshTabRed()
                this.OnHeartBeat()
            end)
end

this.OnClickTaskJump = function(taskId)
    local taskCfg = this.taskMap[tostring(taskId)] or this.taskMap[taskId]
    if taskCfg ~= nil and not IsNullOrEmpty(taskCfg.PageSkip) then
        if taskCfg.PageSkip[1] == "1" then
            SeasonSLGMapMgr.JumpToMapGrid(taskCfg.PageSkip[2])
        elseif taskCfg.PageSkip[1] == "2" then
            FeatureManager.GotoViewModel(taskCfg.PageSkip[2])
        elseif taskCfg.PageSkip[1] == "3" then
            SeasonSLGMapMgr.JumpToNearMyGrid(taskCfg.PageSkip[2])
        end

    end
end

this.SetDispatchContent = function()
    local list = {}
    for _, v in ipairs(this.dispatchList or {}) do
        local gridCfg=SeasonSLGMapMgr.gridMap[v.gridId]
        local functionData=gridCfg~=nil and gridCfg.Function or nil
        if functionData~=nil then
            local item = {
                gridId = v.gridId,
                guardId1 = functionData[2],
                guardId2 = functionData[3],
                data = v.data or {},
                openCallBack = function(dispatchItem)
                    this.ShowDispatchSelectPanel(dispatchItem)
                end,
                dispatchCallBack = function(dispatchItem)
                    SeasonSLGEventMgr.CheckDispatchTimedEvent(dispatchItem:GetGridId())
                    SeasonSLGAPI.OnAskDispatch(
                            dispatchItem:GetGridId(),
                            dispatchItem:GetGuardId1(),
                            dispatchItem:GetGuardId2(),
                            dispatchItem:GetMembers(1),
                            dispatchItem:GetMembers(2),
                            this.OnHeartBeat)
                end,
                rewardCallBack = this.OnClickDispatchExtraReward,
            }
            local width, height = this.GetPrefabSize(ui.godispatchItem, 520, 140)
            table.insert(list, UIScrollData.GetData(ui.godispatchItem, "TaskDispatchItem", width, height, item))
        end
    end
    if this.dispatchUIList ~= nil then
        this.dispatchUIList:Clear()
        this.dispatchUIList:SetData(list)
    end
    this.vm.data.showEmpty = #list == 0
    this.vm.data.havaDisPatch = #list ~= 0
end

this.AddRewardCountToMap = function(rewardMap, orderList, itemId, count)
    if itemId == nil or tostring(itemId) == "" then
        return
    end
    local itemId = tostring(itemId)
    local count = tonumber(count) or 0
    if count <= 0 then
        return
    end
    if rewardMap[itemId] == nil then
        rewardMap[itemId] = { id = itemId, count = 0 }
        table.insert(orderList, itemId)
    end
    rewardMap[itemId].count = rewardMap[itemId].count + count
end

this.IsDispatchGuardData = function(guardData)
    return type(guardData) == "table"
            and (guardData.ExtraProduce ~= nil
            or guardData.LastProduceTime ~= nil
            or guardData.Id1 ~= nil
            or guardData.Id2 ~= nil)
end

this.ForEachDispatchGuardData = function(callBack)
    if callBack == nil or DataMgr.Player == nil then
        return
    end
    local guardMap = DataMgr.Player.SeasonalGuard
    if guardMap == nil then
        return
    end
    if this.IsDispatchGuardData(guardMap) then
        callBack(nil, guardMap)
        return
    end
    for gridId, guardData in pairs(guardMap) do
        if this.IsDispatchGuardData(guardData) then
            callBack(gridId, guardData)
        end
    end
end

this.AddExtraProduceToMap = function(rewardMap, orderList, extraProduce)
    if type(extraProduce) ~= "table" then
        return
    end
    for itemId, count in pairs(extraProduce) do
        this.AddRewardCountToMap(rewardMap, orderList, itemId, count)
    end
end

this.AddAllDispatchExtraProduceToMap = function(rewardMap, orderList)
    this.ForEachDispatchGuardData(function(gridId, guardData)
        this.AddExtraProduceToMap(rewardMap, orderList, guardData.ExtraProduce)
    end)
end

this.BuildDispatchExtraRewardList = function()
    local rewardMap = {}
    local orderList = {}
    this.AddAllDispatchExtraProduceToMap(rewardMap, orderList)

    local list = {}
    for _, itemId in ipairs(orderList) do
        local reward = rewardMap[itemId]
        table.insert(list, UIListData.GetData(ui.gorewardItem, "TaskRewardItem", { reward = reward }))
    end
    return list
end

this.RefreshDispatchExtraRewardContent = function()
    local list = this.BuildDispatchExtraRewardList()
    if this.otherDispatchRewardUIList ~= nil then
        this.otherDispatchRewardUIList:Clear()
        this.otherDispatchRewardUIList:SetData(list)
    end
    if ui.btnRewardOtherDispatch ~= nil then
        ui.btnRewardOtherDispatch.interactable = #list > 0
    end
end

this.HasDispatchMembers = function(members)
    if type(members) ~= "table" then
        return false
    end
    for _, heroId in pairs(members) do
        if not IsNullOrEmpty(heroId) then
            return true
        end
    end
    return false
end

this.IsGuardDispatching = function(guardData)
    if type(guardData) ~= "table" then
        return false
    end
    return not IsNullOrEmpty(guardData.Id)
            or not IsNullOrEmpty(guardData.Id1)
            or not IsNullOrEmpty(guardData.Id2)
            or this.HasDispatchMembers(guardData.Members)
            or this.HasDispatchMembers(guardData.Members1)
            or this.HasDispatchMembers(guardData.Members2)
end

this.HasDispatchInMap = function(guardMap)
    if type(guardMap) ~= "table" then
        return false
    end
    if this.IsGuardDispatching(guardMap) then
        return true
    end
    for _, guardData in pairs(guardMap) do
        if this.IsGuardDispatching(guardData) then
            return true
        end
    end
    return false
end

this.CheckHaveDispatch = function()
    if DataMgr.Player == nil then
        return false
    end
    return this.HasDispatchInMap(DataMgr.Player.SeasonalGuard)
            or this.HasDispatchInMap(DataMgr.Player.SeasonalWorldGuard)
end

this.OnClickDispatchExtraReward = function()
    if this.vm == nil then
        return
    end
    if #this.BuildDispatchExtraRewardList() <= 0 then
        return
    end
    ApiMgr.Request("seasonal/guard/extra_rewards", {}, true, function(result)
        local re = json.decode(result)
        local rewardData = json.encode(re.result)
        LuaMgr.ShowItemRewared(rewardData)
        this.OnHeartBeat()
    end, nil, true, false)
end


this.RefreshBuffUIList = function(buffUIList, displayList)
    if buffUIList == nil or ui.goBuffItem == nil then
        return
    end
    local list = {}
    for _, buffData in ipairs(displayList or {}) do
        table.insert(list, UIListData.GetData(ui.goBuffItem, "SeasonSLGBuffItem", buffData))
    end
    buffUIList:SetData(list)
end


this.RefreshBuffContent = function()
    if this.vm == nil then
        return
    end
    local lastWeekIds = SeasonSLGMapMgr.GetLastWeekBuffIds()
    local curWeekIds = SeasonSLGMapMgr.GetCurWeekBuffIds()
    local lastWeekKey = table.concat(lastWeekIds, ",")
    local curWeekKey = table.concat(curWeekIds, ",")
    if this.lastWeekBuffKey ~= lastWeekKey then
        this.lastWeekBuffKey = lastWeekKey
        this.RefreshBuffUIList(this.lastWeekBuffUIList, SeasonSLGMapMgr.GetLastWeekBuffDisplayList())
    end
    if this.curWeekBuffKey ~= curWeekKey then
        this.curWeekBuffKey = curWeekKey
        this.RefreshBuffUIList(this.curWeekBuffUIList, SeasonSLGMapMgr.GetCurWeekBuffDisplayList())
    end
end

this.RefreshAllContent = function()
    if this.activeTab == 4 and this.GetActiveWorldTaskConfig() == nil then
        this.activeTab = 1
    end
    this.SetTabsData()

    data.dailyValueText = tostring(this.GetCurrentProgress(1))
    data.weekValueText = tostring(this.GetCurrentProgress(2))
    if ui.txtDailyValue ~= nil then
        ui.txtDailyValue.text = data.dailyValueText
    end
    if ui.txtWeekValue ~= nil then
        ui.txtWeekValue.text = data.weekValueText
    end

    if this.activeTab == 1 then
        this.SetTaskContent(1)
        this.SetStageRewardContent(1)
        this.HideStageRewardPop()
        this.HideWorldProgressRewardPop()
        if this.otherDispatchRewardUIList ~= nil then
            this.otherDispatchRewardUIList:Clear()
        end
        this.SetDispatchVisibility(false)
        this.SetTaskVisibility(false, true, false, false)
    elseif this.activeTab == 2 then
        this.SetTaskContent(2)
        this.SetStageRewardContent(2)
        this.HideStageRewardPop()
        this.HideWorldProgressRewardPop()
        if this.otherDispatchRewardUIList ~= nil then
            this.otherDispatchRewardUIList:Clear()
        end
        this.SetDispatchVisibility(false)
        this.SetTaskVisibility(true, false, false, false)
    elseif this.activeTab == 4 then
        this.SetWorldTaskContent()
        this.HideStageRewardPop()
        this.HideWorldProgressRewardPop()
        this.SetDispatchVisibility(false)
        if this.stageRewardUIList ~= nil then
            this.stageRewardUIList:Clear()
        end
        this.ClearRewardItems()
        if this.otherDispatchRewardUIList ~= nil then
            this.otherDispatchRewardUIList:Clear()
        end
        this.SetTaskVisibility(false, false, false, true)
    elseif this.activeTab == 3 then
        this.RefreshBuffContent()
        this.HideStageRewardPop()
        this.HideWorldProgressRewardPop()
        this.SetDispatchVisibility(false)
        if this.stageRewardUIList ~= nil then
            this.stageRewardUIList:Clear()
        end
        this.ClearRewardItems()
        if this.otherDispatchRewardUIList ~= nil then
            this.otherDispatchRewardUIList:Clear()
        end
        this.SetTaskVisibility(false, false, false, false, true)
    else
        this.dispatchList = SeasonSLGEventMgr.GetDispatchTaskList() or {}
        this.SetDispatchContent()
        this.RefreshDispatchExtraRewardContent()
        if this.stageRewardUIList ~= nil then
            this.stageRewardUIList:Clear()
        end
        this.ClearRewardItems()
        this.HideWorldProgressRewardPop()
        this.SetDispatchVisibility(true)
        this.SetTaskVisibility(false, false, true, false)
    end
    this.UpdateTimeText()
end

this.SetTaskVisibility = function(showWeek, showDay, showDispatch, showWorldTask, showBuff)
    showBuff = showBuff == true
    SetActive(ui.goPanelWeek, showWeek)
    SetActive(ui.goPanelDay, showDay)
    SetActive(ui.goPanelDispatch, showDispatch)
    SetActive(ui.goPanelWorldTask, showWorldTask)
    SetActive(ui.goPanelBuff, showBuff)
    SetActive(ui.goWeekScrollView, showWeek)
    SetActive(ui.goScrollView, showDay)
    SetActive(ui.goDispathScrollView, showDispatch)
    SetActive(ui.goWeekLivenessScrollView.gameObject, showWeek or showDay)
end

this.SetDispatchVisibility = function(show)
    if ui.btnRewardOtherDispatch ~= nil then
        SetActive(ui.btnRewardOtherDispatch.gameObject, show)
    end
    if not show then
        this.HideDispatchSelectPanel()
    end
end

this.SwitchTab = function(tabId)
    this.activeTab = tabId
    this.HideStageRewardPop()
    this.HideDispatchSelectPanel()
    this.SetTabsData()
    this.RefreshAllContent()
    this.RefreshTabRed()
end

this.ShowStageRewardPop = function(stageRewardData)
    if stageRewardData == nil or ui.tranRwardPop == nil then
        return
    end

    if stageRewardData.currentProgress >= stageRewardData.targetProgress then
        this.OnClickTaskItemReward(stageRewardData.config.Id)
        return
    end

    this.curStageRewardData = stageRewardData
    this.SetRewardContent(stageRewardData)

    this.SetPopupPosition(ui.tranRwardPop, stageRewardData.itemTransform)
    if ui.tranWorldProgressRewardPop ~= nil then
        SetActive(ui.tranWorldProgressRewardPop.gameObject, false)
    end
end

this.HideStageRewardPop = function()
    this.curStageRewardData = nil
    this.ClearRewardItems()
    if ui.tranRwardPop ~= nil then
        SetActive(ui.tranRwardPop.gameObject, false)
    end
end

this.ShowDispatchSelectPanel = function(dispatchItem)
    if dispatchItem == nil then
        return
    end

    this.dispatchSelectData = dispatchItem
    if ui.goSelectCharacter ~= nil then
        SetActive(ui.goSelectCharacter, true)
    end

    if this.dispatchSelectModel == nil and not IsObjectNull(ui.goSelectCharacter) then
        this.dispatchSelectModel = HeroChoiceModel.New(ui.goSelectCharacter.transform)
    end

    if this.dispatchSelectModel == nil then
        return
    end

    local selectList = this.GetDispatchMemberList(dispatchItem)
    local fitterList = this.GetDispatchFitterList(dispatchItem)
    this.dispatchSelectModel:SetData(selectList, function(newHeroIdList)
        this.UpdateDispatchMemberList(dispatchItem, newHeroIdList)
    end, fitterList)
    this.dispatchSelectModel:PlayAnimation()
end

this.HideDispatchSelectPanel = function()
    if this.dispatchSelectModel ~= nil then
        this.dispatchSelectModel:Clear()
    end
    this.dispatchSelectData = nil
    if ui.goSelectCharacter ~= nil then
        SetActive(ui.goSelectCharacter, false)
    end
    if ui.goSelectCharacterScrollView ~= nil then
        SetActive(ui.goSelectCharacterScrollView, false)
    end
end

this.GetDispatchMemberList = function(dispatchItem)
    local result = {}
    if dispatchItem == nil then
        return result
    end
    local members = dispatchItem:GetMembers(dispatchItem:GetDispatchIndex())
    for _, heroId in ipairs(members or {}) do
        table.insert(result, heroId)
    end
    return result
end

this.GetDispatchFitterList = function(dispatchItem)
    local result = {}
    if dispatchItem == nil then
        return result
    end
    local members = dispatchItem:GetOtherMembers(dispatchItem:GetDispatchIndex())
    for _, heroId in ipairs(members or {}) do
        table.insert(result, heroId)
    end
    return result
end

this.UpdateDispatchMemberList = function(dispatchItem, newHeroIdList)
    if dispatchItem == nil then
        return
    end
    dispatchItem:SetMembers(dispatchItem:GetDispatchIndex(), newHeroIdList)
    dispatchItem:SetData(dispatchItem.rawData)

end

this.SetRefreshTime = function()
    local nowTime = LuaMgr.Timestamp()
    local localNow = os.date("!*t", nowTime + 8 * 3600)
    local refresh = os.time({
        year = localNow.year,
        month = localNow.month,
        day = localNow.day,
        hour = 4,
        min = 0,
        sec = 0,
    }) - 8 * 3600
    if nowTime >= refresh then
        refresh = refresh + 24 * 3600
    end
    this.refreshTime = refresh
    this.UpdateTimeText()
end

this.GetEarliestDispatchLastProduceTime = function()
    local earliestTime = nil
    this.ForEachDispatchGuardData(function(gridId, guardData)
        local lastProduceTime = tonumber(guardData.LastProduceTime or guardData.lastProduceTime)
        if lastProduceTime ~= nil and lastProduceTime > 0 then
            if earliestTime == nil or lastProduceTime < earliestTime then
                earliestTime = lastProduceTime
            end
        end
    end)
    return earliestTime
end

this.UpdateDispatchElapsedTimeText = function()
    local earliestTime = this.GetEarliestDispatchLastProduceTime()
    if earliestTime == nil then
        data.refreshTimeText = ""
    else
        local elapsedTime = math.max(0, LuaMgr.Timestamp() - earliestTime)
        local day, hour, min = GetTimeDHM2(elapsedTime)
        data.refreshTimeText = string.format(LuaMgr.GetLangText("SeasonSlGTaskViewModel_15"), day, hour, min)
    end
    if ui.txtTime ~= nil then
        ui.txtTime.text = data.refreshTimeText
    end
end

this.UpdateRefreshTimeText = function()
    if this.refreshTime == nil then
        data.refreshTimeText = ""
        return
    end
    local remain = math.max(0, this.refreshTime - LuaMgr.Timestamp())
    local day, hour, min = GetTimeDHM2(remain)
    data.refreshTimeText = string.format(LuaMgr.GetLangText("SeasonSlGTaskViewModel_16"), day, hour, min)
    if ui.txtTime ~= nil then
        ui.txtTime.text = data.refreshTimeText
    end
end

this.UpdateTimeText = function()




    if this.activeTab == 4 then
        this.UpdateWorldTaskTimeText()
        return
    end
    this.UpdateRefreshTimeText()
end

this.StartRefreshTimer = function()
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGTaskRefreshTimer)
    LuaMgr.AddTimer(TimerConst.SeasonSLGTaskRefreshTimer, function()
        if this.vm == nil then
            return
        end
        this.UpdateTimeText()
    end, 1, -1, true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})