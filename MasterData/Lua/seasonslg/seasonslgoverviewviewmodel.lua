require("SeasonSLG/SeasonSLGOverviewCardItem")
require("SeasonSLG/SeasonSLGOverviewFilterItem")
require("SeasonSLG/SeasonSLGOverviewGridLevelUpItem")
require("SeasonSLG/SeasonSLGOverviewMiniGameItem")
require("SeasonSLG/SeasonSLGOverviewTabItem")
require("SeasonSLG/SeasonSLGDispatchItem")
require("SeasonSLG/SeasonSLGDispatchRewardItem")

local PANEL_NAME = "SeasonSLGOverviewViewModel"

local TabType = {
    Overview = 1,
    Grid = 2,
    Output = 3,
}

local SupportSubTabKey = "Support"

local GridSubTabKey = {
    Boss = "Boss",

    DispatchType2 = "DispatchType2",
    DispatchType3 = "DispatchType3",
    DispatchType4 = "DispatchType4",
    DispatchType5 = "DispatchType5",
    ResourceLevelUp = "ResourceLevelUp",

}


local DispatchSubTabConfigs = {
    { subTabKey = GridSubTabKey.DispatchType2, groupIndex = 2, langId = "LangGlobalLan_LangGlobal_name_34257" },
    { subTabKey = GridSubTabKey.DispatchType3, groupIndex = 3, langId = "LangGlobalLan_LangGlobal_name_34258" },
    { subTabKey = GridSubTabKey.DispatchType4, groupIndex = 4, langId = "LangGlobalLan_LangGlobal_name_34259" },
    { subTabKey = GridSubTabKey.DispatchType5, groupIndex = 5, langId = "LangGlobalLan_LangGlobal_name_34260" },
}


local DispatchSubTabMaxCount = 15


local ROOT_ANI_NAME = "ani_SeasonSLGOverviewPanel_root_001"

local RowType = {
    MiniGame = "MiniGame",
    GridLevelUp = "GridLevelUp",
    Dispatch = "Dispatch",
}

local this = {
    vm = nil,
    extraRewardMissionId = "S1T50101",
    curTab = TabType.Overview,
    curGridSubTab = GridSubTabKey.DispatchType2,
    curOutputSubTab = nil,
    curGridFilterResourceId = nil,
    overviewScrollView = nil,

    gridScrollView = nil,
    gridExtralRewardScrollView = nil,
    tabScrollView = nil,
    tabDatas = nil,
    gridFilterListView = nil,
    dangerEndTime = nil,
    overviewCardCount = 0,
    gridScrollViewOriginPosY = nil,
    gridScrollViewOriginHeight = nil,
    items = {},

    allDispatchGrid = {},
}

local data = {
    curTab = TabType.Overview,
    worldProgressText = "",
    worldProgressValue = 0,
    rankLikeText = "",
    dynamicList = {{desc = "",timeStr = ""},}
}

local command = {}

local function GetPanelName()
    return UIName ~= nil and UIName.SeasonSLGOverviewViewModel or PANEL_NAME
end

local function GetLink(uiLink, key, componentName)
    if uiLink == nil or key == nil then
        return nil
    end

    local gameObject = uiLink:Get(key)
    if gameObject == nil then
        return nil
    end
    if componentName == nil then
        return gameObject
    end
    return gameObject:GetComponent(componentName)
end

local function SetText(text, value)
    if text ~= nil then
        text.text = value or ""
    end
end

local function SetFillAmount(image, value)
    if image ~= nil then
        image.fillAmount = value or 0
    end
end

local function AddClick(btn, callback)
    if btn ~= nil then
        LuaMgr.AddClick(btn, callback)
    end
end

local function RemoveClick(btn, callback)
    if btn ~= nil then
        LuaMgr.RemoveClick(btn, callback)
    end
end

local function GetLangText(langId)
    if IsNullOrEmpty(langId) then
        return ""
    end
    return LuaMgr.GetLangText(langId)
end

local function GetGridTitle(cfgGrid)
    if cfgGrid == nil then
        return ""
    end
    return SeasonSLGMapMgr.GetGridName(cfgGrid.Id)
end

local function GetResourceName(itemId)
    if itemId == nil then
        return ""
    end
    return ConfigHelper.ItemName(tostring(itemId))
end


local function GetDispatchSubTabConfig(subTabKey)
    if subTabKey == nil then
        return nil
    end
    for i = 1, #DispatchSubTabConfigs do
        if DispatchSubTabConfigs[i].subTabKey == subTabKey then
            return DispatchSubTabConfigs[i]
        end
    end
    return nil
end


local function CheckIsDispatchSubTab(subTabKey)
    return GetDispatchSubTabConfig(subTabKey) ~= nil
end


local function GetDispatchGridGroupIndex(cfgGrid)
    if cfgGrid == nil then
        return nil
    end
    local gridType = tonumber(cfgGrid.GridType)
    if gridType == nil then
        return nil
    end
    return math.floor(gridType / 100)
end


local function GetDispatchGridLevel(cfgGrid)
    if cfgGrid == nil then
        return 0
    end
    local gridType = tonumber(cfgGrid.GridType)
    if gridType == nil then
        return 0
    end
    return gridType % 100
end


local function NormalizeCurGridSubTab()
    if this.curGridSubTab == GridSubTabKey.Boss or this.curGridSubTab == GridSubTabKey.ResourceLevelUp then
        return
    end
    if GetDispatchSubTabConfig(this.curGridSubTab) ~= nil then
        return
    end
    this.curGridSubTab = DispatchSubTabConfigs[1].subTabKey
end

local function GetPrefabSize(prefab)
    if prefab == nil then
        return 0, 0
    end
    local rect = prefab:GetComponent("RectTransform")
    if rect == nil then
        return 0, 0
    end
    local width = rect.sizeDelta.x
    local height = rect.sizeDelta.y
    if width <= 0 and rect.rect ~= nil then
        width = rect.rect.width
    end
    if height <= 0 and rect.rect ~= nil then
        height = rect.rect.height
    end
    return width, height
end

local function FormatCountDownTime(timeLeft)
    timeLeft = math.max(0, math.floor(timeLeft or 0))
    local day, hour, minute, second = GetTimeDHMS2(timeLeft)
    if day > 0 then
        return string.format("%d:%02d:%02d:%02d", day, hour, minute, second)
    end
    return string.format("%02d:%02d:%02d", hour, minute, second)
end

local function FormatAdditionText(value)
    value = tonumber(value) or 0
    local text = nil
    if math.floor(value) == value then
        text = tostring(value)
    else
        text = string.format("%.2f", value)
        text = string.gsub(text, "0+$", "")
        text = string.gsub(text, "%.$", "")
    end
    return "+" .. text .. "%"
end

local function FormatOutputRate(value)
    return "+" .. tostring(value or 0) .. LuaMgr.GetLangText("SeasonSLGOverviewViewModel_0")
end

local function GetSeasonId()
    return SeasonSLGMapMgr.curSeasonal ~= nil and SeasonSLGMapMgr.curSeasonal.Id or nil
end

local function GetTaskTabByType(taskType)
    if taskType == "S201" or taskType == "S202" then
        return 2
    end
    return 1
end

local function CountMembers(members)
    if type(members) ~= "table" then
        return 0
    end
    local count = 0
    for _, heroId in pairs(members) do
        if not IsNullOrEmpty(heroId) then
            count = count + 1
        end
    end
    return count
end

local function CheckTaskRequireComplete(taskCfg)
    if taskCfg == nil or IsNullOrEmpty(taskCfg.Require) then
        return true
    end
    if DataMgr.Player == nil then
        return false
    end
    local playerTasks = DataMgr.Player.SeasonalTasks or {}
    local requireTask = playerTasks[tostring(taskCfg.Require)]
    return requireTask ~= nil and requireTask.completed == true
end

local function GetTaskState(taskData)
    if taskData == nil then
        return 2
    end
    if taskData.completed == true then
        return 3
    end
    if (tonumber(taskData.current) or 0) >= (tonumber(taskData.target) or 0) then
        return 1
    end
    return 2
end

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.goTabItem = uiLink:Get("goTabItem");
    ui.goNormal = uiLink:Get("goNormal");
    ui.goSelected = uiLink:Get("goSelected");
    ui.goDisabled = uiLink:Get("goDisabled");
    ui.goFilterItem = uiLink:Get("goFilterItem");
    ui.goOverviewCardItem = uiLink:Get("goOverviewCardItem");
    ui.goEventItem = uiLink:Get("goEventItem");
    ui.goMiniGameItem = uiLink:Get("goMiniGameItem");
    ui.goGridLevelUpItem = uiLink:Get("goGridLevelUpItem");
    ui.goDispatchItem = uiLink:Get("goDispatchItem");
    ui.root = uiLink:Get("root");
    ui.rootAnimator = uiLink:Get("root"):GetComponent("Animator")
    ui.goRewardItem = uiLink:Get("goRewardItem");
    ui.Middle = uiLink:Get("Middle");
    ui.goOverviewSelected = uiLink:Get("goOverviewSelected");
    ui.goGridSelected = uiLink:Get("goGridSelected");
    ui.goOutputSelected = uiLink:Get("goOutputSelected");
    ui.goLeftOverviewInfo = uiLink:Get("goLeftOverviewInfo");
    ui.goLikeAction = uiLink:Get("goLikeAction");
    ui.gotabs = uiLink:Get("gotabs");
    ui.goOverview = uiLink:Get("goOverview");
    ui.goGrid = uiLink:Get("goGrid");
    ui.goDispatchExtral = uiLink:Get("goDispatchExtral");
    ui.goTaskCanGet = uiLink:Get("goTaskCanGet");
    ui.goTaskComplete = uiLink:Get("goTaskComplete");
    ui.goTaskIng = uiLink:Get("goTaskIng");
    ui.goOutput = uiLink:Get("goOutput");
    ui.goEmptySupport = uiLink:Get("goEmptySupport");
    ui.goSupport = uiLink:Get("goSupport");
    ui.goheadItem = uiLink:Get("goheadItem");
    ui.goFinish = uiLink:Get("goFinish");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtWorldProgress = uiLink:Get("txtWorldProgress"):GetComponent("Text");
    ui.txtRankLike = uiLink:Get("txtRankLike"):GetComponent("Text");
    ui.txtLikeNum = uiLink:Get("txtLikeNum"):GetComponent("Text");
    ui.txtdangerNextTime = uiLink:Get("txtdangerNextTime"):GetComponent("Text");
    ui.txtDesc = uiLink:Get("txtDesc"):GetComponent("Text");
    ui.textProgress = uiLink:Get("textProgress"):GetComponent("Text");
    ui.txtOutputRate = uiLink:Get("txtOutputRate"):GetComponent("Text");
    ui.txtTrafficAddtion = uiLink:Get("txtTrafficAddtion"):GetComponent("Text");
    ui.txtWorldProgressAddtion = uiLink:Get("txtWorldProgressAddtion"):GetComponent("Text");
    ui.txtExploreProgressAddtion = uiLink:Get("txtExploreProgressAddtion"):GetComponent("Text");
    ui.txtWorldExplore2Addtion = uiLink:Get("txtWorldExplore2Addtion"):GetComponent("Text");
    ui.txtTechAddtion = uiLink:Get("txtTechAddtion"):GetComponent("Text");
    ui.txtSelectSupport = uiLink:Get("txtSelectSupport"):GetComponent("Text");
    ui.txtSupportHeroName = uiLink:Get("txtSupportHeroName"):GetComponent("Text");
    ui.txtSupportHeroFightAddtion = uiLink:Get("txtSupportHeroFightAddtion"):GetComponent("Text");
    ui.txtSupportHeroExploreAddtion = uiLink:Get("txtSupportHeroExploreAddtion"):GetComponent("Text");
    ui.btnText = uiLink:Get("btnText"):GetComponent("Button");
    ui.btnOverview = uiLink:Get("btnOverview"):GetComponent("Button");
    ui.btnGrid = uiLink:Get("btnGrid"):GetComponent("Button");
    ui.btnOutput = uiLink:Get("btnOutput"):GetComponent("Button");
    ui.btnExtralReward = uiLink:Get("btnExtralReward"):GetComponent("Button");
    ui.btnSelectSupport = uiLink:Get("btnSelectSupport"):GetComponent("Button");
    ui.btnChangeSupport = uiLink:Get("btnChangeSupport"):GetComponent("Button");
    ui.btnChangeSupportCost = uiLink:Get("btnChangeSupportCost"):GetComponent("Button");
    ui.imgWorldProgress = uiLink:Get("imgWorldProgress"):GetComponent("Image");
    ui.ScrollViewEvent = uiLink:Get("ScrollViewEvent"):GetComponent("ScrollRect");
    ui.Scrollbar = uiLink:Get("Scrollbar"):GetComponent("ScrollRect");
    ui.ScrollViewTabs = uiLink:Get("ScrollViewTabs"):GetComponent("ScrollRect");
    ui.ScrollViewOverview = uiLink:Get("ScrollViewOverview"):GetComponent("ScrollRect");
    ui.ScrollViewGrid = uiLink:Get("ScrollViewGrid"):GetComponent("ScrollRect");
    ui.ScrollViewReward = uiLink:Get("ScrollViewReward"):GetComponent("ScrollRect");
    ui.transOutputFilters = uiLink:Get("transOutputFilters"):GetComponent("RectTransform");
    ui.rawIconOutput=uiLink:Get("rawIconOutput"):GetComponent("RawImage");
    ui.txtBuildAddtion=uiLink:Get("txtBuildAddtion"):GetComponent("Text");
    ui.txtSeasonBuffAddtion=uiLink:Get("txtSeasonBuffAddtion"):GetComponent("Text");

end


this.ClearUI = function()
    ui = nil
end

this.InitGridScrollViewLayout = function()
    if ui.ScrollViewGrid == nil then
        return
    end

    ui.rectScrollViewGrid = ui.ScrollViewGrid.gameObject:GetComponent("RectTransform")
    if ui.rectScrollViewGrid == nil then
        return
    end

    this.gridScrollViewOriginPosY = ui.rectScrollViewGrid.anchoredPosition.y
    this.gridScrollViewOriginHeight = ui.rectScrollViewGrid.sizeDelta.y
end

this.InitScrollViews = function()
    if ui.ScrollViewOverview ~= nil then
        this.overviewScrollView = UIScrollView.New(ui.ScrollViewOverview.gameObject)
        this.overviewScrollView:SetParams()
    end




    if ui.ScrollViewGrid ~= nil then
        this.gridScrollView = UIScrollView.New(ui.ScrollViewGrid.gameObject)
        this.gridScrollView:SetParams()
    end
    if ui.ScrollViewTabs ~= nil then
        this.tabScrollView = UIScrollView.New(ui.ScrollViewTabs.gameObject)
        this.tabScrollView:SetParams()
    end
end

this.InitListViews = function()
    if ui.transOutputFilters ~= nil then
        this.gridFilterListView = UIListView.New(ui.transOutputFilters)
    end
end

this.ClearScrollViews = function()
    if this.overviewScrollView ~= nil then
        this.overviewScrollView:Clear()
    end



    if this.gridScrollView ~= nil then
        this.gridScrollView:Clear()
    end
    if this.tabScrollView ~= nil then
        this.tabScrollView:Clear()

        this.tabDatas = nil
    end
    if this.gridExtralRewardScrollView ~= nil then
        this.gridExtralRewardScrollView:Clear()
    end
end

this.ClearListViews = function()
    if this.gridFilterListView ~= nil then
        this.gridFilterListView:Clear()
    end
end

this.DestroyScrollViews = function()
    this.ClearScrollViews()
    if this.overviewScrollView ~= nil then
        this.overviewScrollView:Destroy()
        this.overviewScrollView = nil
    end




    if this.gridExtralRewardScrollView ~= nil then
        this.gridExtralRewardScrollView:Destroy()
        this.gridExtralRewardScrollView = nil
    end
    if this.gridScrollView ~= nil then
        this.gridScrollView:Destroy()
        this.gridScrollView = nil
    end
    if this.tabScrollView ~= nil then
        this.tabScrollView:Destroy()
        this.tabScrollView = nil
        this.tabDatas = nil
    end
end

this.DestroyListViews = function()
    this.ClearListViews()
    if this.gridFilterListView ~= nil then
        this.gridFilterListView:Destroy()
        this.gridFilterListView = nil
    end
end

this.AddEvents = function()
    AddClick(ui.btnOverview, this.OnClickOverview)
    AddClick(ui.btnGrid, this.OnClickGrid)
    AddClick(ui.btnOutput, this.OnClickOutput)
    AddClick(ui.btnLikeAction, this.OnClickLikeAction)
    AddClick(ui.btnSelectSupport, this.OnClickSelectSupport)
    AddClick(ui.btnChangeSupport, this.OnClickChangeSupport)
    AddClick(ui.btnChangeSupportCost, this.OnClickChangeSupportCost)
    AddClick(ui.btnExtralReward, this.OnClickGridExtralReward)
    LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGWorldProgressChange, this.OnOverviewDataChanged)
    LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGTimedEventTrigger, this.OnOverviewDataChanged)
    LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGTimedEventEnd, this.OnOverviewDataChanged)
    LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGNoticeTrigger, this.OnOverviewDataChanged)
    LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGNoticeEnd, this.OnOverviewDataChanged)
    LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGOverViewReciveAllDispatch, this.AskAllDispatchReward);
end

this.RemoveEvents = function()
    RemoveClick(ui.btnOverview, this.OnClickOverview)
    RemoveClick(ui.btnGrid, this.OnClickGrid)
    RemoveClick(ui.btnOutput, this.OnClickOutput)
    RemoveClick(ui.btnLikeAction, this.OnClickLikeAction)
    RemoveClick(ui.btnSelectSupport, this.OnClickSelectSupport)
    RemoveClick(ui.btnChangeSupport, this.OnClickChangeSupport)
    RemoveClick(ui.btnChangeSupportCost, this.OnClickChangeSupportCost)
    RemoveClick(ui.btnExtralReward, this.OnClickGridExtralReward)
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGWorldProgressChange, this.OnOverviewDataChanged)
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGTimedEventTrigger, this.OnOverviewDataChanged)
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGTimedEventEnd, this.OnOverviewDataChanged)
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGNoticeTrigger, this.OnOverviewDataChanged)
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGNoticeEnd, this.OnOverviewDataChanged)
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGOverViewReciveAllDispatch, this.AskAllDispatchReward)
    this.StopDangerCountDown()
end

this.OnClickClose = function()
    LuaMgr.HidePanel(GetPanelName())
end


this.PlayRootAni = function()
    if ui.rootUIAnimator ~= nil then
        ui.rootUIAnimator.AnimationName = ROOT_ANI_NAME
    elseif ui.rootAnimator ~= nil then
        ui.rootAnimator:Play(ROOT_ANI_NAME, 0, 0)
    end
end

this.OnClickOverview = function()
    local changed = this.curTab ~= TabType.Overview
    this.SwitchTab(TabType.Overview)
    if changed then
        this.PlayRootAni()
    end
end

this.OnClickGrid = function()
    local changed = this.curTab ~= TabType.Grid
    this.SwitchTab(TabType.Grid)
    if changed then
        this.PlayRootAni()
    end
end

this.OnClickOutput = function()
    local changed = this.curTab ~= TabType.Output
    this.SwitchTab(TabType.Output)
    if changed then
        this.PlayRootAni()
    end
end

this.OnClickLikeAction = function()

end

this.OnClickSelectSupport = function()

end

this.OnClickChangeSupport = function()

end

this.OnClickChangeSupportCost = function()

end

this.OnOverviewDataChanged = function()
    if this.vm == nil then
        return
    end
    this.RefreshOverview(this.BuildOverviewData())
end

this.OnClickGridRow = function(itemData)
    if itemData == nil or itemData.gridId == nil then
        return
    end
    SeasonSLGMapMgr.JumpToMapGrid(itemData.gridId)
end

this.OnClickTaskCard = function(itemData)
    if itemData == nil or itemData.taskConfig == nil then
        return
    end

    local taskCfg = itemData.taskConfig
    if itemData.taskState == 1 then
        LuaMgr.ShowLuaPanel(UIName.SeasonSLGTaskViewModel, itemData.taskTab or 1)
        return
    end
    if IsNullOrEmpty(taskCfg.PageSkip) then
        LuaMgr.ShowLuaPanel(UIName.SeasonSLGTaskViewModel, itemData.taskTab or 1)
        return
    end
    if taskCfg.PageSkip[1] == "1" then
        SeasonSLGMapMgr.JumpToMapGrid(taskCfg.PageSkip[2])
    elseif taskCfg.PageSkip[1] == "2" then
        FeatureManager.GotoViewModel(taskCfg.PageSkip[2])
    end
end

this.OnClickGridSubTab = function(itemData)
    if itemData == nil or itemData.subTabKey == nil then
        return
    end
    if this.curGridSubTab == itemData.subTabKey then
        return
    end
    this.curGridSubTab = itemData.subTabKey
    this.RefreshGrid(this.BuildGridData())
    this.PlayRootAni()
end

this.OnClickGridExtralReward = function()
    local missionInfo = DataMgr.Player.SeasonalTasks[this.extraRewardMissionId]
    local getRewardStatus = this.GetMissionStatus(missionInfo)
    if getRewardStatus == SeasonSLGConst.SeasonSLGTaskStatusDef.Seasonal_TaskReward then
        SeasonSLGAPI.OnAskTaskReward(this.extraRewardMissionId,
        function(result)
            local re = json.decode(result)
            local rewardData = json.encode(re.result)
            LuaMgr.ShowItemRewared(rewardData)
            this.RefreshGridExtralReward()
        end)
    end
end

this.SwitchTab = function(tabType)
    this.curTab = tabType or TabType.Overview
    this.vm.data.curTab = this.curTab

    SetActive(ui.goOverview, false)
    SetActive(ui.goGrid, this.curTab == TabType.Grid)
    SetActive(ui.goOutput, this.curTab == TabType.Output)
    SetActive(ui.goLeftOverviewInfo, this.curTab == TabType.Overview)
    SetActive(ui.gotabs, this.curTab ~= TabType.Overview)
    if ui.transOutputFilters ~= nil and this.curTab ~= TabType.Grid then
        SetActive(ui.transOutputFilters.gameObject, false)
    end

    SetActive(ui.goOverviewSelected, this.curTab == TabType.Overview)
    SetActive(ui.goGridSelected, this.curTab == TabType.Grid)
    SetActive(ui.goOutputSelected, this.curTab == TabType.Output)
    SetActive(ui.goFinish, this.curTab == TabType.Overview and this.overviewCardCount <= 0)
    this.RefreshSupport(nil)

    this.RemoveRefreshDispatchTimer()
    if this.curTab == TabType.Grid then
        this.RefreshGrid(this.BuildGridData())
        this.StartRefreshDispatchTimer()
    elseif this.curTab == TabType.Output then
        local datas = this.BuildOutputData()
        this.curOutputSubTab = datas.subTabs[1].subTabKey
        datas.subTabs[1].selected = true
        datas = this.BuildOutputData()
        this.RefreshOutput(datas)
        this.OutPutItemIcon(datas.subTabs[1].resourceId)
    end
    this.RefreshTabRed()
end

this.ClearItems = function(groupName)
    if this.items[groupName] == nil then
        return
    end
    for i = #this.items[groupName], 1, -1 do
        local item = this.items[groupName][i]
        if item ~= nil then
            item:Destroy()
        end
        this.items[groupName][i] = nil
    end
end

this.ClearAllItems = function()
    for groupName, _ in pairs(this.items) do
        this.ClearItems(groupName)
    end
    this.ClearScrollViews()
    this.ClearListViews()
end

this.CreateItem = function(groupName, template, parent, itemClass)
    if template == nil or parent == nil or itemClass == nil then
        return nil
    end
    if this.items[groupName] == nil then
        this.items[groupName] = {}
    end

    local gameObject = LuaMgr.InstantiateGO(template, parent.transform, false)
    if gameObject == nil then
        return nil
    end
    SetActive(gameObject, true)

    local item = itemClass.New()
    item.gameObject = gameObject
    item.transform = gameObject.transform
    item:Init()
    table.insert(this.items[groupName], item)
    return item
end

this.Refresh = function()
    this.RefreshOverview(this.BuildOverviewData())
    if this.curTab == TabType.Grid then
        this.RefreshGrid(this.BuildGridData())
    elseif this.curTab == TabType.Output then
        local datas = this.BuildOutputData()
        this.curOutputSubTab = datas.subTabs[1].subTabKey
        datas.subTabs[1].selected = true
        datas = this.BuildOutputData()
        this.RefreshOutput(datas)
    else
        this.RefreshSupport(nil)
    end
end

this.BuildOverviewData = function()
    local progressValue,current,target = this.GetWorldTaskProgressRate()
    local percent =math.floor(current / target * 1000)
    local progressText = ""
    if percent % 10 == 0 then
        progressText = string.format("%.f%%",percent / 10.0)
    else
        progressText = string.format("%.1f%%",percent / 10.0)
    end

    local data = {}
    data.worldProgressText = progressText
    data.worldProgressValue = progressValue
    data.likeText = ""
    data.overviewCards = this.BuildOverviewCards()


    data.dynamicRows = {}
    if SeasonSLGTimeEventMgr ~= nil and SeasonSLGTimeEventMgr.GetNoticeOverviewList ~= nil then
        local noticeOverviewList = SeasonSLGTimeEventMgr.GetNoticeOverviewList()
        for i = 1, #noticeOverviewList do
            local noticeItem = noticeOverviewList[i]
            if noticeItem ~= nil and noticeItem.config ~= nil then
                table.insert(data.dynamicRows, {
                    desc = SeasonSLGTimeEventMgr.GetNoticeDesc(noticeItem.config),
                    timeStr = SeasonSLGTimeEventMgr.FormatNoticeRecordTime(noticeItem.time),
                    sort = noticeItem.time,
                })
            end
        end
    end
    data.danger = this.BuildDangerData()




    return data
end

this.GetWorldTaskProgressRate = function()
    local config = SeasonSLGMapMgr.GetActiveSeasonTaskConfig()
    if config == nil or DataMgr.Player == nil then
        return 0,0,0
    end
    local playerTasks = DataMgr.Player.SeasonalTasks or {}
    local taskData = playerTasks[tostring(config.Id)] or playerTasks[config.Id]
    if taskData == nil then
        return 0,0,0
    end
    local current = tonumber(taskData.current) or 0
    local target = tonumber(taskData.target) or 0
    if target <= 0 then
        return 0,0,0
    end
    local worldTaskRewardList = SeasonSLGMapMgr.GetWorldTaskRewardConfigList()
    local curPro = 0
    local targetPro = 0
    for index, cfg in ipairs(worldTaskRewardList) do
        local temptargetProgress = SeasonSLGMapMgr.GetTaskTarget(cfg)
        local tempcurProgress = SeasonSLGMapMgr.GetTaskCurrent(cfg)
        if targetPro <= temptargetProgress then
            targetPro = temptargetProgress
        end
        if curPro <= tempcurProgress then
            curPro = tempcurProgress
        end
    end
    return math.max(0, math.min(1, curPro / target)),curPro,target
end

this.BuildMissionData = function()
    local result = {
        title = "",
        desc = "",
        haveGoto = false,
        config = nil,
        state = nil,
        tab = nil,
    }
    local seasonId = GetSeasonId()
    if seasonId == nil then
        return result
    end
    if DataMgr.Player == nil then
        return result
    end

    local list = {}
    local playerTasks = DataMgr.Player.SeasonalTasks or {}
    local nowTime = LuaMgr.Timestamp()
    for _, cfg in pairs(ConfigMgr.Config.SeasonalTaskMap or {}) do
        if cfg.Type == "S203"
                and SeasonSLGMapMgr.CheckTaskOpen(cfg, nowTime)
                and CheckTaskRequireComplete(cfg) then
            local mission = playerTasks[tostring(cfg.Id)] or playerTasks[cfg.Id]
            local current = 0
            local target = 0
            local completed = false
            if mission ~= nil then
                current = mission.current or 0
                target = mission.target or 0
                completed = mission.completed == true
            end
            local state = GetTaskState({
                current = current,
                target = target,
                completed = completed,
            })
            table.insert(list, {
                index = cfg.Sort,
                config = cfg,
                state = state,
            })
        end
    end

    table.sort(list, function(a, b)
        if a.state ~= b.state then
            return a.state < b.state
        end
        return tostring(a.index) > tostring(b.index)
    end)

    if #list <= 0 then
        return result
    end
    result.config = list[1].config
    result.title = GetLangText(list[1].config.NameLan)
    result.desc = GetLangText(list[1].config.DescLan)
    result.haveGoto = not IsNullOrEmpty(list[1].config.PageSkip) and #list[1].config.PageSkip > 0
    result.state = list[1].state
    result.tab = GetTaskTabByType(list[1].config.Type)
    return result
end

this.BuildOverviewCards = function()
    local cards = {}
    local unexploredGridCard = this.BuildUnexploredGridCard()
    if unexploredGridCard ~= nil then
        table.insert(cards, unexploredGridCard)
    end

    local taskCard = this.BuildTaskReminderCard()
    if taskCard ~= nil then
        table.insert(cards, taskCard)
    end

    local dispatchCard = this.BuildDispatchReminderCard()
    if dispatchCard ~= nil then
        table.insert(cards, dispatchCard)
    end

    local timedEventCard = this.BuildNearestTimedEventCard()
    if timedEventCard ~= nil then
        table.insert(cards, timedEventCard)
    end
    return cards
end

this.BuildUnexploredGridCard = function()
    local cfgGrid = this.FindFirstUnexploredGrid()
    if cfgGrid == nil then
        return nil
    end

    local desc = GetGridTitle(cfgGrid)
    if IsNullOrEmpty(desc) then
        desc = LuaMgr.GetLangText("SeasonSLGOverviewViewModel_1")
    end
    return {
        gridId = cfgGrid.Id,
        title = LuaMgr.GetLangText("SeasonSLGOverviewViewModel_2"),
        haveGoto = true,
        desc = desc,
        callBack = this.OnClickGridRow,
    }
end

this.FindFirstUnexploredGrid = function()
    return SeasonSLGMapMgr.GetNearestUnexploredGrid(nil,false)
end

this.BuildTaskReminderCard = function()
    local missionData = this.BuildMissionData()
    if missionData.config == nil or missionData.state == 3 then
        return nil
    end

    local desc = missionData.title
    if not IsNullOrEmpty(missionData.desc) then
        desc = desc .. " " .. missionData.desc
    end
    return {
        taskConfig = missionData.config,
        taskState = missionData.state,
        taskTab = missionData.tab,
        haveGoto = missionData.haveGoto,
        title = LuaMgr.GetLangText("SeasonSLGOverviewViewModel_3"),
        desc = desc,
        callBack = this.OnClickTaskCard,
    }
end

this.BuildDispatchReminderCard = function()
    local dispatchItem = this.FindLastUnfilledDispatchTask()
    if dispatchItem == nil then
        return nil
    end
    return {
        gridId = dispatchItem.gridId,
        haveGoto = true,
        title = LuaMgr.GetLangText("SeasonSLGOverviewViewModel_4"),
        desc = LuaMgr.GetLangText("SeasonSLGOverviewViewModel_5"),
        callBack = this.OnClickGridRow,
    }
end

this.FindLastUnfilledDispatchTask = function()
    if DataMgr.Player == nil or SeasonSLGMapMgr.DispatchGridMap == nil then
        return nil
    end
    local dispatchList = SeasonSLGEventMgr.GetDispatchTaskList() or {}
    table.sort(dispatchList, function(a, b)
        return tonumber(a.gridId) < tonumber(b.gridId)
    end)

    local result = nil
    for i = 1, #dispatchList do
        if this.CheckDispatchTaskUnfilled(dispatchList[i]) then
            result = dispatchList[i]
        end
    end
    return result
end

this.CheckDispatchTaskUnfilled = function(dispatchItem)
    if dispatchItem == nil or dispatchItem.gridId == nil then
        return false
    end

    local cfgGrid = SeasonSLGMapMgr.DispatchGridMap[tostring(dispatchItem.gridId)]
    local functionData = cfgGrid ~= nil and cfgGrid.Function or nil
    if functionData == nil then
        return false
    end

    local guardData = dispatchItem.data or {}
    local guardId1 = functionData[2]
    local guardId2 = functionData[3]
    local cfgGuard1 = ConfigMgr.Config.SeasonalGridGuardMap[tostring(guardId1)]
    local cfgGuard2 = ConfigMgr.Config.SeasonalGridGuardMap[tostring(guardId2)]

    if cfgGuard1 ~= nil and CountMembers(guardData.Members1) < (tonumber(cfgGuard1.Count) or 0) then
        return true
    end
    if cfgGuard2 ~= nil then
        local worldCount = tonumber(cfgGuard2.WorldNum) or tonumber(cfgGuard2.Count) or 0
        if CountMembers(guardData.Members2) < worldCount then
            return true
        end
    end
    return false
end

this.BuildNearestTimedEventCard = function()
    local timedEvent, triggerTime = this.GetNearestFutureTimedEvent()
    if timedEvent == nil then
        return nil
    end

    local desc = GetLangText(timedEvent.DescLan)
    return {
        gridId = this.GetTimedEventJumpGrid(timedEvent),
        title = LuaMgr.GetLangText("SeasonSLGOverviewViewModel_6"),
        haveGoto = this.GetTimedEventJumpGrid(timedEvent) ~= nil,
        desc = desc,
        countDown = triggerTime,
        callBack = this.OnClickGridRow,
    }
end

this.GetNearestFutureTimedEvent = function()
    local timedEventList = SeasonSLGTimeEventMgr.timedEventList
    if timedEventList == nil then
        return nil, nil
    end

    local nowTime = LuaMgr.Timestamp()
    local nearestEvent = nil
    local nearestTime = nil
    for _, cfg in pairs(timedEventList) do
        local triggerTime = this.GetTimedEventAbsoluteTriggerTime(cfg)
        if triggerTime ~= nil and triggerTime > nowTime then
            if nearestTime == nil or triggerTime < nearestTime then
                nearestEvent = cfg
                nearestTime = triggerTime
            end
        end
    end
    return nearestEvent, nearestTime
end

this.GetTimedEventAbsoluteTriggerTime = function(config)
    if config == nil then
        return nil
    end
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return nil
    end
    return startTime + (SeasonSLGTimeEventMgr.GetTimedEventTriggerTime(config) or 0)
end

this.GetTimedEventJumpGrid = function(config)
    if config == nil or config.CoverGridID == nil or #config.CoverGridID <= 0 then
        return nil
    end
    return config.CoverGridID[1]
end

this.BuildDangerData = function()
    local timedEvent, triggerTime = this.GetNearestFutureTimedEvent()
    if timedEvent == nil then
        return {
            desc = LuaMgr.GetLangText("SeasonSLGOverviewViewModel_7"),
            endTime = nil,
        }
    end

    return {
        desc = GetLangText(timedEvent.DescLan),
        endTime = triggerTime,
    }
end

this.BuildGridData = function()
    local filters = {}
    if this.curGridSubTab == GridSubTabKey.ResourceLevelUp then
        filters = this.BuildGridFilterData()
    end
    return {
        subTabs = this.BuildGridSubTabData(),
        filters = filters,
        rows = this.BuildGridRows(this.curGridSubTab),
    }
end

this.BuildOutputData = function()
    local additionData = this.BuildOutputAdditionData()
    return {
        subTabs = this.BuildOutputSubTabData(),
        outputRateText = this.BuildOutputRateText(),
        trafficAddtionText = additionData.trafficAddtionText,
        worldProgressAddtionText = additionData.worldProgressAddtionText,
        techAddtion = additionData.techAddtionText,
        buildAddtionText = additionData.buildAddtionText,
        seasonBuffAddtionText = additionData.seasonBuffAddtionText,
        supportData = this.BuildOutputSupportData(),
    }
end

this.BuildOutputSupportData = function()
    return {
        hasSupport = false,
        heroName = "",
        fightAddtionText = "",
        exploreAddtionText = "",
        headData = nil,
    }
end

this.BuildOutputRateText = function()
    local resourceId = this.curOutputSubTab
    if resourceId == nil or resourceId == SupportSubTabKey then
        return FormatOutputRate(0)
    end
    return FormatOutputRate(SeasonSLGMapMgr.GetResourceOutputRate(resourceId))
end

this.BuildOutputAdditionData = function()
    local resourceId = this.curOutputSubTab
    if resourceId == nil or resourceId == SupportSubTabKey then
        return {
            trafficAddtionText = FormatAdditionText(0),
            worldProgressAddtionText = FormatAdditionText(0),
            techAddtionText = FormatAdditionText(0),
            buildAddtionText = FormatAdditionText(0),
            seasonBuffAddtionText = FormatAdditionText(0),
        }
    end

    local techBuffDic = SeasonSLGTechMgr.GetProduceBuff()
    local techBuffPercent = techBuffDic ~= nil and techBuffDic[resourceId] or 0
    return {
        trafficAddtionText = FormatAdditionText(this.GetTrafficPermitProduceAddition(resourceId)),
        worldProgressAddtionText = FormatAdditionText(this.GetWorldProgressProduceAddition(resourceId)),
        techAddtionText = FormatAdditionText(techBuffPercent/100),
        buildAddtionText = FormatAdditionText(this.GetBuildProduceAddition(resourceId)),
        seasonBuffAddtionText = FormatAdditionText(this.GetSeasonBuffProduceAddition(resourceId)),
    }
end

this.GetTrafficPermitProduceAddition = function(resourceId)
    local result = 0
    local passConfigList = SeasonSLGMapMgr.GetSeasonSLGPassConfigList()
    local cfgThemePass = {}
    for i, v in ipairs(passConfigList or {}) do
        if SeasonSLGMapMgr.PassesIsCurRuning(v) == 0 then
            cfgThemePass = v
            break
        end
    end
    local isCharge = SeasonSLGMapMgr.IsSeasonSLGPassPaid(cfgThemePass)
    if isCharge then
        result = result + this.GetProduceAdditionByBuffIds(resourceId, cfgThemePass.SeasonBuff)

    end


















    return result
end

this.CheckSeasonPassPaid = function(passConfig, passData)
    if passData == nil or IsNull(passData.payRecord) then
        return false
    end
    local charge1 = passConfig.Charge1 and passConfig.Charge1[1]
    local charge2 = passConfig.Charge2 and passConfig.Charge2[1]
    local isPayCharge1=SeasonSLGMapMgr.IsSeasonSLGChargeAvailable(charge1);
    if not isPayCharge1 then
       return true;
    end
    if not IsNull(passConfig.Charge4) then
        for i,v in ipairs(passConfig.Charge4) do
            if not SeasonSLGMapMgr.IsSeasonSLGChargeAvailable(v[1]) then
                return true;
            end
        end
    end
    return false;

end

this.GetWorldProgressProduceAddition = function(resourceId)
    if ConfigMgr.Config.SeasonalProgressReward == nil then
        return 0
    end

    local result = 0
    local curProgress = tonumber(SeasonSLGTimeEventMgr.GetWorldProgress()) or 0
    for _, progressConfig in pairs(ConfigMgr.Config.SeasonalProgressReward) do
        if curProgress >= (tonumber(progressConfig.Progress) or 0) then
            result = result + this.GetProduceAdditionByBuffIds(resourceId, progressConfig.AreaBuff)
        end
    end
    return result
end


this.GetBuildProduceAddition = function(resourceId)
    if SeasonSLGMapMgr.WorldBuildGridMap == nil or ConfigMgr.Config.SeasonalGridWorldBuildMap == nil then
        return 0
    end

    local result = 0
    for gridId, cfgGrid in pairs(SeasonSLGMapMgr.WorldBuildGridMap) do
        local buildId = cfgGrid ~= nil and cfgGrid.Function ~= nil and cfgGrid.Function[2] or nil
        local cfgBuild = buildId ~= nil and ConfigMgr.Config.SeasonalGridWorldBuildMap[buildId] or nil
        if cfgBuild ~= nil then
            local eventProgress = SeasonSLGMapMgr.MapStateData ~= nil and SeasonSLGMapMgr.MapStateData.EventProgress or nil
            local progressData = eventProgress ~= nil and eventProgress[tostring(gridId)] or nil
            local progress = progressData ~= nil and tonumber(progressData.Progress) or nil
            local level = this.CalcBuildLevel(progress, cfgBuild.CostMatCount)
            local rewardBuff = cfgBuild.RewardBuff
            if level >= 1 and rewardBuff ~= nil and #rewardBuff >= level then
                result = result + this.GetProduceAdditionByBuffIds(resourceId, { rewardBuff[level] })
            end
        end
    end
    return result
end


this.CalcBuildLevel = function(progress, costMatCount)
    if progress == nil or IsNull(costMatCount) or TableIsNull(costMatCount) then
        return 0
    end
    local level = 0
    for i = 1, #costMatCount do
        if progress >= (tonumber(costMatCount[i]) or 0) then
            level = i
        end
    end
    return level
end


this.GetSeasonBuffProduceAddition = function(resourceId)
    return this.GetProduceAdditionByBuffIds(resourceId, SeasonSLGMapMgr.GetCurWeekBuffIds())
end

this.GetProduceAdditionByBuffIds = function(resourceId, buffIds)
    if buffIds == nil or ConfigMgr.Config.SeasonalProduceBuffMap == nil then
        return 0
    end

    local result = 0
    for i = 1, #buffIds do
        local buffId = buffIds[i]
        local buffConfig = ConfigMgr.Config.SeasonalProduceBuffMap[buffId] or ConfigMgr.Config.SeasonalProduceBuffMap[tostring(buffId)]
        result = result + this.GetProduceBuffValue(buffConfig, resourceId)
    end
    return result
end

this.CheckProduceBuffMatchResource = function(buffConfig, resourceId)
    return this.GetProduceBuffResourceIndex(buffConfig, resourceId) ~= nil
end

this.GetProduceBuffResourceIndex = function(buffConfig, resourceId)
    if buffConfig == nil or buffConfig.Type == nil then
        return nil
    end
    for i = 1, #buffConfig.Type do
        if tostring(buffConfig.Type[i]) == tostring(resourceId) then
            return i
        end
    end
    return nil
end

this.GetProduceBuffValue = function(buffConfig, resourceId)
    if buffConfig == nil or buffConfig.Para1 == nil then
        return 0
    end
    local index = this.GetProduceBuffResourceIndex(buffConfig, resourceId)
    if index == nil then
        return 0
    end

    local value = nil
    if type(buffConfig.Para1) == "table" then
        value = tonumber(buffConfig.Para1[index]) or 0
    else
        value = tonumber(buffConfig.Para1) or 0
    end
    return value / 100
end

this.BuildGridSubTabData = function()
    NormalizeCurGridSubTab()
    local tabs = {












    }


    for i = 1, #DispatchSubTabConfigs do
        local cfgSubTab = DispatchSubTabConfigs[i]
        table.insert(tabs, {
            subTabKey = cfgSubTab.subTabKey,
            name = GetLangText(cfgSubTab.langId),
        })
    end

    for i = 1, #tabs do
        tabs[i].selected = tabs[i].subTabKey == this.curGridSubTab
        tabs[i].callBack = this.OnClickGridSubTab
    end
    return tabs
end

this.BuildGridFilterData = function()
    local filters = {}
    local gridMap = SeasonSLGMapMgr.ProduceListGridMap
    if gridMap == nil then
        return filters
    end

    local resourceList = {}
    local addedMap = {}
    for _, cfgGrid in pairs(gridMap) do
        if cfgGrid ~= nil
                and not IsNull(cfgGrid.Function)
                and #cfgGrid.Function > 0
                and cfgGrid.Function[1] == "4" then
            local key = cfgGrid.Function[2]
            local cfgResourceMap = ConfigMgr.Config.SeasonalGridResourceMap
            local cfgResource = cfgResourceMap ~= nil and (cfgResourceMap[key] or cfgResourceMap[tostring(key)]) or nil
            local resourceId = cfgResource ~= nil and cfgResource.Type or nil
            local resourceKey = resourceId ~= nil and tostring(resourceId) or nil
            if resourceKey ~= nil and addedMap[resourceKey] ~= true then
                addedMap[resourceKey] = true
                table.insert(resourceList, resourceId)
            end
        end
    end
    table.sort(resourceList, function(a, b)
        return tostring(a) < tostring(b)
    end)

    if this.curGridFilterResourceId ~= nil and addedMap[tostring(this.curGridFilterResourceId)] ~= true then
        this.curGridFilterResourceId = nil
    end

    table.insert(filters, {
        filterAll = true,
        name = LuaMgr.GetLangText("SeasonSLGOverviewViewModel_8"),
        selected = this.curGridFilterResourceId == nil,
        callBack = this.OnClickGridFilter,
    })

    for i = 1, #resourceList do
        local resourceId = resourceList[i]
        table.insert(filters, {
            resourceId = resourceId,
            name = GetResourceName(resourceId),
            selected = this.curGridFilterResourceId ~= nil and tostring(this.curGridFilterResourceId) == tostring(resourceId),
            callBack = this.OnClickGridFilter,
        })
    end
    return filters
end

this.BuildGridRows = function(gridSubType)
    local rows = {}
    local gridMap = this.GetCurGridSubTabMap()
    if gridMap == nil then
        return rows
    end

    for _, cfgGrid in pairs(gridMap) do
        local row = this.BuildGridRow(cfgGrid)
        if row ~= nil then
            table.insert(rows, row)
        end
    end
    if CheckIsDispatchSubTab(gridSubType) then

        table.sort(rows, function(a, b)
            local dispatchStatusA = tonumber(a.dispatchStatus) or 0
            local dispatchStatusB = tonumber(b.dispatchStatus) or 0
            if dispatchStatusA ~= dispatchStatusB then
                return dispatchStatusA > dispatchStatusB
            end
            local gridLevelA = tonumber(a.gridLevel) or 0
            local gridLevelB = tonumber(b.gridLevel) or 0
            if gridLevelA ~= gridLevelB then
                return gridLevelA > gridLevelB
            end
            return tonumber(a.gridId) < tonumber(b.gridId)
        end)
    else
        table.sort(rows, function(a, b)
            return tonumber(a.gridId) < tonumber(b.gridId)
        end)
    end
    return rows
end


this.BuildAllDispatchGrid = function()
    this.allDispatchGrid = {}
    for _, cfgGrid in pairs(SeasonSLGMapMgr.DispatchGridMap) do
        local gridId = cfgGrid.Id
        local functionType = cfgGrid.Function[1]
        local functionParam = cfgGrid.Function[2]
        local complete = SeasonSLGMapMgr.CheckBlockEventsIsComplete(gridId)
        if functionType == "4" and complete then

            table.insert(this.allDispatchGrid, cfgGrid)
        elseif functionType == "10" then
            local unLock = complete
            if not unLock then
                unLock=SeasonSLGMapMgr.CheckBlockIsUnLock(gridId,false);
            end
            if complete or (unLock and (cfgGrid.Empty==0 or cfgGrid.Empty==4)) then
                local wordDispatch=ConfigMgr.Config.SeasonalGridWorldGuardMap[functionParam]
                if not IsNull(wordDispatch) then
                    table.insert(this.allDispatchGrid, cfgGrid)
                end
            end
        end
    end
    return this.allDispatchGrid
end


this.BuildDispatchSubTabGrids = function(groupIndex)
    local grids = {}
    local allDispatchGrid = this.BuildAllDispatchGrid()
    for i = 1, #allDispatchGrid do
        local cfgGrid = allDispatchGrid[i]
        if GetDispatchGridGroupIndex(cfgGrid) == groupIndex then
            table.insert(grids, cfgGrid)
        end
    end

    table.sort(grids, function(a, b)
        local gridLevelA = GetDispatchGridLevel(a)
        local gridLevelB = GetDispatchGridLevel(b)
        if gridLevelA ~= gridLevelB then
            return gridLevelA > gridLevelB
        end
        return tonumber(a.Id) < tonumber(b.Id)
    end)

    if #grids > DispatchSubTabMaxCount then
        for i = #grids, DispatchSubTabMaxCount + 1, -1 do
            grids[i] = nil
        end
    end
    return grids
end




this.CheckDispatchSubTabRed = function(groupIndex)
    if DataMgr.Player == nil then
        return false
    end
    local grids = this.BuildDispatchSubTabGrids(groupIndex)
    if grids == nil or #grids == 0 then
        return false
    end
    for i = 1, #grids do
        local cfgGrid = grids[i]
        if cfgGrid ~= nil and not IsNull(cfgGrid.Function) and #cfgGrid.Function > 0 then
            local functionType = cfgGrid.Function[1]
            local tempDispatchInfo = nil
            if functionType == "4" and DataMgr.Player.SeasonalResource ~= nil then
                tempDispatchInfo = DataMgr.Player.SeasonalResource[cfgGrid.Id]
            elseif functionType == "10" and DataMgr.Player.SeasonalWorldGuard ~= nil then
                tempDispatchInfo = DataMgr.Player.SeasonalWorldGuard[cfgGrid.Id]
            end
            if tempDispatchInfo ~= nil then
                local produceTime = tonumber(tempDispatchInfo.ProduceTime)
                if produceTime ~= nil and produceTime > 0
                        and SeasonSLGEventMgr.GetDisPatchStatus(tempDispatchInfo.Members, produceTime)
                                == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward then
                    return true
                end
            end
        end
    end
    return false
end


this.RefreshTabRed = function()
    for i = 1, #DispatchSubTabConfigs do
        local cfgSubTab = DispatchSubTabConfigs[i]
        local hasRed = this.CheckDispatchSubTabRed(cfgSubTab.groupIndex)
        local tabName = GetLangText(cfgSubTab.langId)
        RedMgr.Singleton:UpdateClientRedData("18006_" .. tabName, hasRed and 1 or 0)
    end
    if this.curTab == TabType.Output and this.tabDatas ~= nil then
        for _, tabData in ipairs(this.tabDatas) do
            if tabData.name ~= nil then
                RedMgr.Singleton:UpdateClientRedData("18006_" .. tabData.name, 0)
            end
        end
    end
    HeroRedDataHelper.SetSeasonSLGRed()
    RedMgr.Singleton:Refresh()
end

this.GetCurGridSubTabMap = function()
    NormalizeCurGridSubTab()
    if this.curGridSubTab == GridSubTabKey.Boss then
        return SeasonSLGMapMgr.BossGridMap
    end
    local cfgSubTab = GetDispatchSubTabConfig(this.curGridSubTab)
    if cfgSubTab ~= nil then
        return this.BuildDispatchSubTabGrids(cfgSubTab.groupIndex)
    end
    if this.curGridSubTab == GridSubTabKey.ResourceLevelUp then
        return SeasonSLGMapMgr.ProduceListGridMap
    end
    return nil
end

this.BuildGridRow = function(cfgGrid)
    if cfgGrid == nil or IsNull(cfgGrid.Function) or #cfgGrid.Function == 0 then
        return nil
    end

    local functionType = cfgGrid.Function[1]
    if this.curGridSubTab == GridSubTabKey.Boss and functionType == "7" then
        return this.BuildBossGridRow(cfgGrid)
    elseif CheckIsDispatchSubTab(this.curGridSubTab) and (functionType == "4" or functionType == "10") then
        return this.BuildDispatchGridRow(cfgGrid)
    elseif this.curGridSubTab == GridSubTabKey.ResourceLevelUp and functionType == "4" then
        return this.BuildResourceLevelUpRow(cfgGrid)
    elseif this.curGridSubTab == GridSubTabKey.MiniGame and functionType == "6" then
        return this.BuildMiniGameRow(cfgGrid)
    end
    return nil
end

this.AskAllDispatchReward = function()
    if this.allDispatchGrid == nil or #this.allDispatchGrid<=0 then
        return
    end
    local resourceGrids = {}
    local havingResource = false
    local worldGuardGrids = {}
    local havingWorldGuard = false
    local tempDispatchInfo = {}
    for _, cfgGrid in pairs(this.allDispatchGrid) do
        local functionType = cfgGrid.Function[1]
        local funcKey = cfgGrid.Function[2]
        if functionType == "4" then
            tempDispatchInfo = DataMgr.Player.SeasonalResource[cfgGrid.Id]
            if not IsNull(tempDispatchInfo) then
                local dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(tempDispatchInfo.Members, tempDispatchInfo.ProduceTime)
                if dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward then
                    resourceGrids[cfgGrid.Id] = funcKey
                    havingResource = true
                end
            end
        elseif functionType == "10" then
            tempDispatchInfo = DataMgr.Player.SeasonalWorldGuard[cfgGrid.Id]
            if not IsNull(tempDispatchInfo) then
                local dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(tempDispatchInfo.Members, tempDispatchInfo.ProduceTime)
                if dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward then
                    worldGuardGrids[cfgGrid.Id] = funcKey
                    havingWorldGuard = true
                end
            end

        end

    end










    if havingWorldGuard or havingResource then

        SeasonSLGAPI.OnAskDispatchRewardMerge(worldGuardGrids,resourceGrids,function()



            this.RefreshGrid(this.BuildGridData())
            this.RefreshTabRed()
        end)
    end
end

this.BuildDispatchGridRowInfo = function (cfgGrid)
    local functionType = cfgGrid.Function[1]
    local canDispatchMemberCount = 6
    local functionKey = cfgGrid.Function[2]
    local gridName = SeasonSLGMapMgr.GetGridName(cfgGrid.Id)
    local locY,locX = SeasonSLGMapMgr.GetBlockLocByIndex(cfgGrid.Id)
    local strTitle = string.format("%s<color=#E9DDB0><size=18>（ %g，%g ）</size></color>", gridName, locX, locY)
    local produceItems = {}
    local limitLevel = 1
    local limitCardCount = 1
    local tempDispatchInfo = {}
    local dispacthTime = {}
    local patchNeedItemInfo = {}
    local complete = SeasonSLGMapMgr.CheckBlockEventsIsComplete(cfgGrid.Id)

    if functionType == "4" then
        local resourceDispatchInfo = DataMgr.Player.SeasonalResource[cfgGrid.Id]
        if not IsNull(resourceDispatchInfo) then
            tempDispatchInfo.Members = resourceDispatchInfo.Members
            tempDispatchInfo.ProduceTime = resourceDispatchInfo.ProduceTime
        end
        local cfgGirdRes=ConfigMgr.Config.SeasonalGridResourceMap[functionKey];
        if not IsNull(cfgGirdRes) then
            canDispatchMemberCount = cfgGirdRes.CountDispatch
        end
        local resourceLevelConfig = ConfigMgr.Config.SeasonalGridResourceLevelMap[cfgGirdRes.Level[1]]
        produceItems = resourceLevelConfig.ProduceItem
        limitLevel = resourceLevelConfig.MinLevel
        limitCardCount = resourceLevelConfig.MinCard
        dispacthTime = resourceLevelConfig.Time
        patchNeedItemInfo = resourceLevelConfig.ConsumeDispatch
    elseif functionType == "10" then
        local wordDispatch=ConfigMgr.Config.SeasonalGridWorldGuardMap[functionKey]
        local WorldGuardDispatchInfo = DataMgr.Player.SeasonalWorldGuard[cfgGrid.Id]
        if not IsNull(WorldGuardDispatchInfo) then
            tempDispatchInfo.Members = WorldGuardDispatchInfo.Members
            tempDispatchInfo.ProduceTime = WorldGuardDispatchInfo.ProduceTime
        end
        if not IsNull(wordDispatch) then
            produceItems = wordDispatch.ProduceItem
            limitLevel = wordDispatch.MinLevel
            limitCardCount = wordDispatch.MinCard
            dispacthTime = wordDispatch.Time
            patchNeedItemInfo = wordDispatch.ConsumeDispatch
        end
    end
    return {
        rowType = RowType.Dispatch,
        gridId = cfgGrid.Id,
        title = strTitle,
        desc = "",
        produceItemInfos = produceItems,
        heroLevelMin = limitLevel,
        patchHeroCountMin = limitCardCount,
        funcType = functionType,
        funcKeyId = functionKey,
        dispatchInfo = tempDispatchInfo,
        countDispatch = canDispatchMemberCount,
        dispatchTimeList = dispacthTime,
        dispatchNeedItem = patchNeedItemInfo,
        isGridComplete = complete,
        gridLevel = GetDispatchGridLevel(cfgGrid),
        dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(tempDispatchInfo.Members, tempDispatchInfo.ProduceTime),
    }
end

this.BuildCommonGridRow = function(cfgGrid)
    local title = GetGridTitle(cfgGrid)
    if IsNullOrEmpty(title) then
        title = tostring(cfgGrid.Id)
    end
    return {
        rowType = RowType.MiniGame,
        gridId = cfgGrid.Id,
        title = title,
        desc = "",
        callBack = this.OnClickGridRow,
    }
end

this.BuildBossGridRow = function(cfgGrid)
    local row = this.BuildCommonGridRow(cfgGrid)
    if row == nil then
        return nil
    end
    row.desc = this.BuildBossScoreText(cfgGrid)
    return row
end

this.BuildBossScoreText = function(cfgGrid)
    local score = this.GetBossCurrentScore(cfgGrid)
    if score == nil then
        return LuaMgr.GetLangText("SeasonSLGOverviewViewModel_9")
    end
    return string.format(LuaMgr.GetLangText("SeasonSLGOverviewViewModel_10"), LuaMgr.NumFormat(score))
end

this.GetBossCurrentScore = function(cfgGrid)
    local rankData = SeasonSLGEventMgr.bossRankMap[gridId]
    if rankData ~= nil then
        return rankData.Score
    end
    return nil
end

this.BuildDispatchGridRow = function(cfgGrid)
    local row = this.BuildDispatchGridRowInfo(cfgGrid)
    if row == nil then
        return nil
    end
    row.desc = this.BuildDispatchDesc(cfgGrid)
    return row
end

this.BuildDispatchDesc = function(cfgGrid)
    if cfgGrid == nil or not SeasonSLGMapMgr.CheckBlockEventsIsComplete(cfgGrid.Id, false) then
        return LuaMgr.GetLangText("SeasonSLGOverviewViewModel_11")
    end

    local _, addRate = SeasonSLGMapMgr.GetDispatchGroupProduceInfo(
            cfgGrid.Function[2],
            this.GetDispatchMembers(cfgGrid.Id, 1),
            cfgGrid.Function[3],
            this.GetDispatchMembers(cfgGrid.Id, 2))
    return string.format(LuaMgr.GetLangText("SeasonSLGOverviewViewModel_12"), addRate or 0)
end

this.GetDispatchMembers = function(gridId, index)
    local guardData = this.GetDispatchGuardData(gridId)
    if guardData == nil then
        return {}
    end
    if index == 1 then
        return guardData.Members1 or {}
    elseif index == 2 then
        return guardData.Members2 or {}
    end
    return {}
end

this.GetDispatchGuardData = function(gridId)
    if DataMgr.Player == nil or DataMgr.Player.SeasonalGuard == nil then
        return nil
    end
    local guardMap = DataMgr.Player.SeasonalGuard
    return guardMap[gridId] or guardMap[tostring(gridId)]
end

this.BuildResourceLevelUpRow = function(cfgGrid)
    local key = cfgGrid.Function[2]
    local cfgResourceMap = ConfigMgr.Config.SeasonalGridResourceMap
    local cfgResource = cfgResourceMap ~= nil and (cfgResourceMap[key] or cfgResourceMap[tostring(key)]) or nil
    if cfgResource == nil then
        return nil
    end

    local resourceId = cfgResource.Type
    if this.curGridFilterResourceId ~= nil and tostring(this.curGridFilterResourceId) ~= tostring(resourceId) then
        return nil
    end

    return {
        rowType = RowType.GridLevelUp,
        gridId = cfgGrid.Id,
        title = ConfigMgr.LangGlobal(cfgResource.Name),
        desc = ConfigMgr.LangGlobal(cfgResource.GridDesc),
        levelText = string.format("Lv.%s", SeasonSLGEventMgr.GetGridResLevel(cfgGrid.Id)),
        callBack = this.OnClickGridRow,
    }
end

this.BuildMiniGameRow = function(cfgGrid)
    return {
        rowType = RowType.MiniGame,
        gridId = cfgGrid.Id,
        title = GetGridTitle(cfgGrid),
        scoreText = "",
        starCount = 0,
        finishedTimeText = "",
        callBack = this.OnClickGridRow,
    }
end

this.BuildOutputSubTabData = function()
    local tabs = {}
    local addedMap = {}
    local constants = SeasonSLGMapMgr.Constants()
    local resourceList = constants ~= nil and constants.SeasonalResource1 or nil






    if resourceList ~= nil then
        for i = 1, #resourceList do
            this.AddOutputResourceTab(tabs, addedMap, resourceList[i])
        end
    end

    local specialResourceList = constants ~= nil and constants.SeasonalResource2S1 or nil
    if specialResourceList ~= nil then
        local specialResourceId = SeasonSLGTimeEventMgr.CheckIsSecondActivity() and specialResourceList[2] or specialResourceList[1]
        this.AddOutputResourceTab(tabs, addedMap, specialResourceId)
    end
    for i = 1, #tabs do
        tabs[i].selected = tabs[i].subTabKey == this.curOutputSubTab
        tabs[i].callBack = this.OnClickOutputSubTab
    end
    return tabs
end

this.AddOutputResourceTab = function(tabs, addedMap, resourceId)
    if resourceId == nil or addedMap[resourceId] == true then
        return
    end
    addedMap[resourceId] = true
    table.insert(tabs, {
        subTabKey = resourceId,
        resourceId = resourceId,
        name = string.format(LuaMgr.GetLangText("SeasonSLGOverviewViewModel_13"), GetResourceName(resourceId)),
    })
end

this.OnClickGridFilter = function(itemData)
    if itemData == nil then
        return
    end
    if itemData.filterAll == true then
        if this.curGridFilterResourceId == nil then
            return
        end
        this.curGridFilterResourceId = nil
        this.RefreshGrid(this.BuildGridData())
        return
    end
    if itemData.resourceId == nil then
        return
    end
    if this.curGridFilterResourceId ~= nil and tostring(this.curGridFilterResourceId) == tostring(itemData.resourceId) then
        return
    end
    this.curGridFilterResourceId = itemData.resourceId
    this.RefreshGrid(this.BuildGridData())
end

this.OnClickOutputSubTab = function(itemData)
    if itemData == nil or itemData.subTabKey == nil then
        return
    end
    if this.curOutputSubTab == itemData.subTabKey then
        return
    end
    this.OutPutItemIcon(itemData.resourceId)
    this.curOutputSubTab = itemData.subTabKey
    this.RefreshOutput(this.BuildOutputData())
    this.PlayRootAni()
end

this.OutPutItemIcon=function(itemId)
    local path=ConfigHelper.GetItemIconPath(itemId)
    ui.rawIconOutput.texture=LuaMgr.GetTexture(path);
end

this.RefreshOverview = function(viewData)
    viewData = viewData or {}

    this.vm.data.worldProgressText = viewData.worldProgressText or ""
    this.vm.data.worldProgressValue = viewData.worldProgressValue or 0
    this.vm.data.rankLikeText = viewData.likeText or ""

    SetText(ui.txtWorldProgress, this.vm.data.worldProgressText)
    SetFillAmount(ui.imgWorldProgress, viewData.worldProgressValue)
    this.RefreshDanger(viewData.danger)

    local overviewCards = viewData.overviewCards or {}
    this.overviewCardCount = #overviewCards
    SetActive(ui.goFinish, this.curTab == TabType.Overview and this.overviewCardCount <= 0)
    this.RefreshUIScrollList(this.overviewScrollView, ui.goOverviewCardItem, "SeasonSLGOverviewCardItem", overviewCards, true)
    this.vm.data.dynamicList = viewData.dynamicRows

end




this.RefreshTabScrollView = function(subTabs)
    if this.tabScrollView == nil then
        return
    end
    subTabs = subTabs or {}

    local needRebuild = this.tabDatas == nil or #this.tabDatas ~= #subTabs
    if not needRebuild then
        for i = 1, #subTabs do
            local oldData = this.tabDatas[i]
            if oldData == nil or oldData.subTabKey ~= subTabs[i].subTabKey then
                needRebuild = true
                break
            end
        end
    end

    if needRebuild then

        this.tabDatas = subTabs
        this.RefreshUIScrollList(this.tabScrollView, ui.goTabItem, "SeasonSLGOverviewTabItem", subTabs, true)
        return
    end


    for i = 1, #this.tabDatas do
        local oldData = this.tabDatas[i]
        for k, v in pairs(subTabs[i]) do
            oldData[k] = v
        end
    end
    this.tabScrollView:Refresh()
end

this.RefreshGrid = function(viewData)
    viewData = viewData or {}
    if this.curTab == TabType.Grid then
        this.RefreshTabScrollView(viewData.subTabs)
    end

    local showFilter = this.curTab == TabType.Grid and this.curGridSubTab == GridSubTabKey.ResourceLevelUp
    if ui.transOutputFilters ~= nil then
        SetActive(ui.transOutputFilters.gameObject, showFilter)
    end
    if showFilter then
        this.RefreshUIList(this.gridFilterListView, ui.goFilterItem, "SeasonSLGOverviewFilterItem", viewData.filters)
    else
        this.ClearListViews()
    end
    this.RefreshGridScrollViewLayout(showFilter)
    this.RefreshGridRows(viewData.rows)
    this.RefreshGridExtralReward()
end

this.GetMissionStatus = function(missionInf)
    if IsNull(missionInf) then
        return SeasonSLGConst.SeasonSLGTaskStatusDef.Seasonal_TaskIng
    end
    if missionInf.completed then
        return SeasonSLGConst.SeasonSLGTaskStatusDef.Seasonal_TaskComplete
    end

    if missionInf.current>=missionInf.target then
        return SeasonSLGConst.SeasonSLGTaskStatusDef.Seasonal_TaskReward
    end

    return SeasonSLGConst.SeasonSLGTaskStatusDef.Seasonal_TaskIng
end

this.RefreshGridExtralReward = function()
    if this.gridExtralRewardScrollView == nil then
        this.gridExtralRewardScrollView = UIScrollView.New(ui.ScrollViewReward.gameObject)
        this.gridExtralRewardScrollView:SetParams()
    end
    local missionInfo = DataMgr.Player.SeasonalTasks[this.extraRewardMissionId]
    local targetProgress = 0
    local curProgress = 0
    local getRewardStatus = this.GetMissionStatus(missionInfo)
    SetActive(ui.goTaskCanGet, getRewardStatus == SeasonSLGConst.SeasonSLGTaskStatusDef.Seasonal_TaskReward)
    SetActive(ui.goTaskComplete, getRewardStatus == SeasonSLGConst.SeasonSLGTaskStatusDef.Seasonal_TaskComplete)
    SetActive(ui.goTaskIng, getRewardStatus == SeasonSLGConst.SeasonSLGTaskStatusDef.Seasonal_TaskIng)
    if not IsNull(missionInfo) then
        targetProgress = missionInfo.target
        curProgress = missionInfo.current
    end
    local cfgMisssion = ConfigMgr.Config.SeasonalTaskMap[this.extraRewardMissionId]
    local reward = {}
    if not IsNull(cfgMisssion) then
        if targetProgress == 0 then
            targetProgress = tonumber(cfgMisssion.Condition.Count) or 0
        end
        reward = cfgMisssion.Reward
    end
    ui.textProgress.text = string.format(LuaMgr.GetLangText("SeasonSLGOverviewViewModel_14"), curProgress, targetProgress)
    local rewardData = {}
    if not IsNull(reward) then
        for i = 1, #reward do
            local listItemTemp = reward[i]
            local dataItem = {}
            dataItem.ItemId = listItemTemp.id
            dataItem.ItemCount = listItemTemp.count
            dataItem.CurrentProgress = curProgress
            dataItem.TargetProgress = targetProgress

            local className = "SeasonSLGDispatchRewardItem"
            local template = ui.goRewardItem
            if template ~= nil then
                local width, height = GetPrefabSize(template)
                table.insert(rewardData, UIScrollData.GetData(template, className, width, height, dataItem))
            end
        end
    end
    this.gridExtralRewardScrollView:SetData(rewardData, true)
end

this.RefreshGridScrollViewLayout = function(showFilter)
    if ui.rectScrollViewGrid == nil then
        return
    end

    local pos = ui.rectScrollViewGrid.anchoredPosition
    local size = ui.rectScrollViewGrid.sizeDelta
    if showFilter then
        ui.rectScrollViewGrid.anchoredPosition = Vector2(pos.x, -91)
        ui.rectScrollViewGrid.sizeDelta = Vector2(size.x, 496)
    else
        ui.rectScrollViewGrid.anchoredPosition = Vector2(pos.x, this.gridScrollViewOriginPosY or pos.y)
        ui.rectScrollViewGrid.sizeDelta = Vector2(size.x, this.gridScrollViewOriginHeight or size.y)
    end

    if this.gridScrollView ~= nil then
        this.gridScrollView:SetParams()
    end
end

this.RefreshOutput = function(viewData)
    viewData = viewData or {}
    this.RefreshSupport(viewData.supportData)
    SetText(ui.txtOutputRate, viewData.outputRateText)
    SetText(ui.txtTrafficAddtion, viewData.trafficAddtionText)
    SetText(ui.txtWorldProgressAddtion, viewData.worldProgressAddtionText)
    SetText(ui.txtTechAddtion, viewData.techAddtion)
    SetText(ui.txtBuildAddtion, viewData.buildAddtionText)
    SetText(ui.txtSeasonBuffAddtion, viewData.seasonBuffAddtionText)
    if this.curTab == TabType.Output then
        this.RefreshTabScrollView(viewData.subTabs)
    end
end

this.RefreshSupport = function(supportData)
    supportData = supportData or {}
    local isOutputTab = this.curTab == TabType.Output
    local isSupportTab = isOutputTab and this.curOutputSubTab == SupportSubTabKey
    local hasSupport = supportData.hasSupport == true

    SetActive(ui.goOutput, isOutputTab and not isSupportTab)
    SetActive(ui.goEmptySupport, isSupportTab and not hasSupport)
    SetActive(ui.goSupport, isSupportTab and hasSupport)

    SetText(ui.txtSupportHeroName, supportData.heroName)
    SetText(ui.txtSupportHeroFightAddtion, supportData.fightAddtionText)
    SetText(ui.txtSupportHeroExploreAddtion, supportData.exploreAddtionText)
end

this.RefreshGridRows = function(list)
    if this.gridScrollView == nil then
        return
    end
    if list == nil then
        this.gridScrollView:Clear(true)
        return
    end

    local scrollDatas = {}
    for i = 1, #list do
        local dataItem = list[i]
        local rowData = dataItem
        local rowType = nil
        if rowData ~= nil then
            rowType = rowData.rowType
        end
        local className = "SeasonSLGOverviewCardItem"
        local template = ui.goOverviewCardItem

        if rowType == RowType.MiniGame then
            className = "SeasonSLGOverviewMiniGameItem"
            template = ui.goMiniGameItem
        elseif rowType == RowType.GridLevelUp then
            className = "SeasonSLGOverviewGridLevelUpItem"
            template = ui.goGridLevelUpItem
        elseif rowType == RowType.Dispatch then
            className = "SeasonSLGDispatchItem"
            template = ui.goDispatchItem
        end

        if template ~= nil then
            local width, height = GetPrefabSize(template)
            table.insert(scrollDatas, UIScrollData.GetData(template, className, width, height, dataItem))
        end
    end
    this.gridScrollView:SetData(scrollDatas, true)
end

this.RefreshDanger = function(dangerData)
    this.StopDangerCountDown()
    dangerData = dangerData or {}
    SetText(ui.txtDesc, dangerData.desc)
    this.dangerEndTime = dangerData.endTime
    this.RefreshDangerCountDown()
    if this.dangerEndTime ~= nil and this.dangerEndTime - LuaMgr.Timestamp() > 0 then
        LuaMgr.AddTimer(TimerConst.SeasonSLGOverviewDangerCountDown, this.OnDangerCountDownTimer, 1, -1, true)
    end
end

this.OnDangerCountDownTimer = function()
    this.RefreshDangerCountDown()
end

this.RefreshDangerCountDown = function()
    if this.dangerEndTime == nil then
        SetText(ui.txtdangerNextTime, "")
        return
    end

    local timeLeft = this.dangerEndTime - LuaMgr.Timestamp()
    if timeLeft <= 0 then
        this.StopDangerCountDown()
        this.RefreshOverview(this.BuildOverviewData())
        return
    end
    SetText(ui.txtdangerNextTime, FormatCountDownTime(timeLeft))
end

this.StopDangerCountDown = function()
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGOverviewDangerCountDown)
    this.dangerEndTime = nil
end

this.RefreshUIScrollList = function(scrollView, template, className, list, reset)
    if scrollView == nil then
        return
    end
    if template == nil or className == nil then
        scrollView:Clear(reset)
        return
    end
    if list == nil then
        scrollView:Clear(reset)
        return
    end

    local width, height = GetPrefabSize(template)
    local scrollDatas = {}
    for i = 1, #list do
        table.insert(scrollDatas, UIScrollData.GetData(template, className, width, height, list[i]))
    end
    scrollView:SetData(scrollDatas, reset)
end

this.RefreshUIList = function(listView, template, className, list)
    if listView == nil then
        return
    end
    listView:Clear()
    if template == nil or className == nil or list == nil then
        return
    end

    local listDatas = {}
    for i = 1, #list do
        table.insert(listDatas, UIListData.GetData(template, className, list[i]))
    end
    listView:SetData(listDatas)
end

this.RefreshItemList = function(groupName, itemClass, template, parent, list)
    this.ClearItems(groupName)
    if list == nil or itemClass == nil or template == nil or parent == nil then
        return
    end

    for i = 1, #list do
        local item = this.CreateItem(groupName, template, parent, itemClass)
        if item ~= nil then
            item:SetData({ data = list[i] })
        end
    end
end

this.OnDisptchTimeRefreshEvent = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGOverViewDispatchTime);
    this.RefreshTabRed()
end

this.StartRefreshDispatchTimer = function()
    LuaMgr.AddTimer(TimerConst.SeasonSLGOverviewView_DispatchTimeRefresh, this.OnDisptchTimeRefreshEvent, 1, -1, true)
end

this.RemoveRefreshDispatchTimer = function()
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGOverviewView_DispatchTimeRefresh)
end

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
        this.InitGridScrollViewLayout()
        this.InitScrollViews()
        this.InitListViews()
        RedMgr.Singleton:RegisterViewModel(UIName.SeasonSLGOverviewViewModel);
    end,
    before_active = function(vm)
        vm.behaviour:UpdateTopBar("", this.OnBack);
        DispatchSubTabMaxCount = SeasonSLGMapMgr.Constants().SeasonalSentListMax or 15
        this.AddEvents()
        this.SwitchTab(this.curTab)
        this.Refresh()
        this.RefreshTabRed()
    end,
    before_deactive = function(vm)
        this.RemoveRefreshDispatchTimer()
        this.RemoveEvents()
        this.ClearAllItems()
    end,
    before_destroy = function()
        this.ClearAllItems()
        this.DestroyScrollViews()
        this.DestroyListViews()
        UIScrollView.ClearItem("SeasonSLGOverviewCardItem")
        UIScrollView.ClearItem("SeasonSLGOverviewTabItem")
        UIScrollView.ClearItem("SeasonSLGOverviewMiniGameItem")
        UIScrollView.ClearItem("SeasonSLGOverviewGridLevelUpItem")
        UIScrollView.ClearItem("SeasonSLGDispatchItem")
        UIScrollView.ClearItem("SeasonSLGDispatchRewardItem")
        UIListView.ClearItem("SeasonSLGOverviewFilterItem")
        this.ClearUI()
        RedMgr.Singleton:RemoveViewModel(UIName.SeasonSLGOverviewViewModel);
        this.vm = nil
    end
}

return vm({
    data = data,
    command = command,
    hook = hook,
})