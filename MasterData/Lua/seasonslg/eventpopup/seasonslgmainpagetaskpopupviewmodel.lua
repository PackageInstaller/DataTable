require("SeasonSLG/SeasonSLGMainPageTaskItem")


local TASK_TYPE = "S601"
local ITEM_CLASS = "SeasonSLGMainPageTaskItem"
local ITEM_DEFAULT_WIDTH = 520
local ITEM_DEFAULT_HEIGHT = 61

local this = {
    vm = nil,
    taskUIList = nil,
    taskDataList = {},
    curProgress = 0,
    maxTarget = 0,
};

local ui = {}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.goTaskTemplate = uiLink:Get("goTaskTemplate");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.grid = uiLink:Get("grid"):GetComponent("GridLayoutGroup");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGMainPageTaskPopupViewModel)
    end)

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

this.InitScrollView = function()
    if ui.ScrollView == nil then
        return
    end
    this.taskUIList = UIScrollView.New(ui.ScrollView.gameObject)
    this.taskUIList:SetParams()
end

this.GetTaskRecord = function(cfg)
    if cfg == nil or DataMgr.Player == nil then
        return nil
    end
    local playerTasks = DataMgr.Player.SeasonalTasks or {}
    return playerTasks[tostring(cfg.Id)] or playerTasks[cfg.Id]
end

this.GetTaskTarget = function(cfg, record)
    local target = tonumber(record ~= nil and record.target) or 0
    if target <= 0 and cfg ~= nil and cfg.Condition ~= nil then
        target = tonumber(cfg.Condition.Count) or 0
    end
    return target
end

this.CheckTaskSeason = function(cfg)
    if cfg == nil or SeasonSLGMapMgr.curSeasonal == nil then
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

this.BuildTaskDataList = function()
    local list = {}
    local nowTime = LuaMgr.Timestamp()
    local curProgress = DataMgr.Player.Seasonal5300ItemConsumeDaily
    local maxTarget = SeasonSLGMapMgr.Constants().SeasonalMobilityMax
    for _, cfg in pairs(ConfigMgr.Config.SeasonalTaskMap or {}) do
        if tostring(cfg.Type) == TASK_TYPE
                and this.CheckTaskSeason(cfg)
                and this.CheckTaskInTime(cfg, nowTime) then
            local record = this.GetTaskRecord(cfg)
            local current = tonumber(record ~= nil and record.current) or 0
            local target = this.GetTaskTarget(cfg, record)
            local isDone = record ~= nil and record.completed == true
            local canGet = (not isDone) and target > 0 and current >= target
            table.insert(list, {
                id = cfg.Id,
                config = cfg,
                current = current,
                target = target,
                isDone = isDone,
                canGet = canGet,

                state = canGet and 1 or (isDone and 3 or 2),
                sort = tonumber(cfg.Sort) or 0,
            })
        end
    end
    table.sort(list, function(a, b)
        if a.state ~= b.state then
            return a.state < b.state
        end
        if a.sort ~= b.sort then
            return a.sort < b.sort
        end
        return tostring(a.config.Id) < tostring(b.config.Id)
    end)
    this.taskDataList = list
    curProgress = curProgress > maxTarget and maxTarget or curProgress
    this.curProgress = curProgress
    this.maxTarget = maxTarget
    return list
end

this.SetTitle = function()
    if ui.txtTitle ~= nil then
        ui.txtTitle.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34238"), tostring(this.curProgress or 0), tostring(this.maxTarget or 0))
    end
end

this.SetTaskContent = function()
    local dataList = this.BuildTaskDataList()
    if ui.goTaskTemplate == nil or this.taskUIList == nil then
        return
    end
    local list = {}
    local width, height = this.GetPrefabSize(ui.goTaskTemplate, ITEM_DEFAULT_WIDTH, ITEM_DEFAULT_HEIGHT)
    for _, taskData in ipairs(dataList) do
        taskData.rewardCallBack = function()
            this.OnClickTaskReward()
        end
        table.insert(list, UIScrollData.GetData(ui.goTaskTemplate, ITEM_CLASS, width, height, taskData))
    end
    this.taskUIList:Clear()
    this.taskUIList:SetData(list)
end

this.Refresh = function()
    this.SetTaskContent()
    this.SetTitle()
end

this.GetRewardableTaskIds = function()
    local taskIds = {}
    for _, taskData in ipairs(this.taskDataList or {}) do
        if taskData.canGet == true then
            table.insert(taskIds, taskData.config.Id)
        end
    end
    return taskIds
end

this.OnClickTaskReward = function()
    local taskIds = this.GetRewardableTaskIds()
    if #taskIds == 0 then
        return
    end
    SeasonSLGAPI.OnAskTaskReward(taskIds, function()
        this.Refresh()
        HeroRedDataHelper.SetSeasonSLGRed()
        RedMgr.Singleton:Refresh()
    end)
end

this.OnHeartBeat = function()
    if this.vm == nil then
        return
    end
    this.Refresh()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
        this.InitScrollView()
    end,
    before_active = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.OnHeartBeat)
        LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.OnHeartBeat)
        this.Refresh()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.OnHeartBeat)
        if this.taskUIList ~= nil then
            this.taskUIList:Clear()
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.OnHeartBeat)
        if this.taskUIList ~= nil then
            this.taskUIList:Clear()
        end
        UIScrollView.ClearItem(ITEM_CLASS)
        this.taskUIList = nil
        this.taskDataList = {}
        this.ClearUI();
    end
}


return vm({
    data = data,
    command = command,
    hook = hook
})