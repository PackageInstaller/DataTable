require("ViewModel/SuiChuNaJi/ViewItem/SCNJBuffItem")
require("ViewModel/SuiChuNaJi/ViewItem/SCNJDifficultyItem")

local objs = {
    buffItem = {path = "template/BuffItem", type = UITool.GameObject},
    difficultyItem = {path = "template/DifficultyItem", type = UITool.GameObject},
    downTimeTxt = {path = "root/Middle/Title/DownTimeBG/DownTimeTxt", type = UITool.Text},
    totalScore = {path = "root/Middle/Left/TotalFirework/TotalNum", type = UITool.Text},
    phaseNum = {path = "root/Middle/Left/Progress/PhaseNum", type = UITool.Text},
    phasePrgressNum = {path = "root/Middle/Left/Progress/PhasePrgressNum", type = UITool.Text},
    processProgress = {path = "root/Middle/Left/Progress/ProgressFill/Fill", type = UITool.RectTransform},
    buffScroll = {path = "root/Middle/Right/BuffScroll", type = UITool.GameObject},
    difficultyScroll = {path = "root/Middle/Right/DifficultyScroll", type = UITool.GameObject},
    rewardBtn = {path = "root/Middle/RewardBtn", type = UITool.Button},
    helpBtn = {path = "root/Middle/HelpBtn", type = UITool.Button},
    intoBattleBtn = {path = "root/Middle/IntoBattleBtn", type = UITool.Button},
    syncTipsBtn = {path = "root/Middle/Left/Progress/SyncTipsBtn", type = UITool.Button},
    bgBtn = {path = "root/BG", type = UITool.Button},
    syncTipsObj = {path = "root/Middle/Left/SyncTips", type = UITool.GameObject}
}

local this = {

    lastSeletedItem = nil
}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.SCNJHomePanel)
    this.OnClickBgBtn()
    this.buffScrollUI = UIScrollView.New(this.buffScroll)
    this.difficultyScrollUI = UIScrollView.New(this.difficultyScroll)
end

this.before_active = function()
    this.Refresh()
end


this.OnClickRewardBtn = function()
    if SCNJData.CheckActivityRunning() == false then
        return
    end
    this.OnClickBgBtn()
    LuaMgr.ShowLuaPanel(UIName.SCNJRewardPanel)
end

this.OnClickHelpBtn = function()
    if SCNJData.CheckActivityRunning() == false then
        return
    end
    this.OnClickBgBtn()
    LuaMgr.ShowLuaPanel(UIName.SCNJHelpPopup)
end

this.OnClickIntoBattleBtn = function()
    if SCNJData.CheckActivityRunning() == false then
        return
    end
    this.OnClickBgBtn()
    local _, diffData = SCNJData.GetAllBuffDatasByID(SCNJData.GetCurSelectedDifficultyDataID())
    local data = {}
    data.data = diffData
    LuaMgr.ShowLuaPanel(UIName.SCNJTeamInfoPanel, data)
end

this.OnClickSyncTipsBtn = function()
    SetActive(this.syncTipsObj, this.syncTipsObj.activeSelf == false)
end

this.OnClickBgBtn = function()
    SetActive(this.syncTipsObj, false)
end


this.Refresh = function()
    SCNJData.CheckRed()
    local oldHotLevelData = SCNJData.GetOldServerHotData()
    local curHotLevelData = SCNJData.GetCurServerHotData()
    local fullLevelCond = oldHotLevelData.hotLevel < curHotLevelData.hotLevel
    local fullExpCond = oldHotLevelData.hotExp < curHotLevelData.hotExp
    if fullLevelCond or fullExpCond then
        local curUnionValue = SCNJData.GetUnionValue(curHotLevelData.hotLevel, curHotLevelData.hotExp)
        local serverProgressData = SCNJData.GetAllServerProgressData()
        local configData = nil
        for i = 1, #serverProgressData do
            local data = serverProgressData[i]
            if curUnionValue > data.UnionValue then
                configData = data
            else
                break
            end
        end
        local isFirstTip = oldHotLevelData.HadTipConfigData == nil
        local isNewTip = configData ~= nil and oldHotLevelData.HadTipConfigData ~= nil and oldHotLevelData.HadTipConfigData.UnionValue ~= configData.UnionValue
        if configData ~= nil and (isFirstTip or isNewTip) then
            LuaMgr.ShowLuaPanel(UIName.SCNDungeonProgressPopup, oldHotLevelData, curHotLevelData, configData)
            SCNJData.SetOldServerHotData(configData)
        end
    end
    this.totalScore.text = tostring(SCNJData.GetPlayerTotalScore())
    this.RefreshDifficultyScroll()
end

this.RefreshDifficultyScroll = function()
    this.difficultyScrollUI:Clear(false)
    local allDatas = SCNJData.GetAllDifficultyDatas()
    local scrollDatas = {}
    local moveToIndex = 1
    for i = 1, #allDatas do
        local data = {}
        data.data = allDatas[i]
        data.isSelected = false
        data.index = i
        data.isLast = i == #allDatas
        data.clickCallback = this.OnSelectedDifficultyItem
        if SCNJData.GetCurSelectedDifficultyDataID() == nil then
            SCNJData.SetCurSelectedDifficultyDataID(allDatas[1].ID)
            data.isSelected = true
            moveToIndex = 1
        elseif SCNJData.GetCurSelectedDifficultyDataID() == allDatas[i].ID then
            data.isSelected = true
            moveToIndex = i
        end
        local scrollData = UIScrollData.GetData(this.difficultyItem, "SCNJDifficultyItem", 168, 105, data)
        table.insert(scrollDatas, scrollData)
    end
    this.difficultyScrollUI:SetParams(146, 424)
    this.difficultyScrollUI:SetData(scrollDatas, true)
    this.difficultyScrollUI:MoveToIndex(moveToIndex)
end

this.RefreshBuffScroll = function(allDatas)
    this.buffScrollUI:Clear(false)
    local scrollDatas = {}
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.OnClickCallback = this.OnClickBuffCallback
        local scrollData = UIScrollData.GetData(this.buffItem, "SCNJBuffItem", 248, 90, data)
        table.insert(scrollDatas, scrollData)
    end
    this.buffScrollUI:SetParams(248, 424)
    this.buffScrollUI:SetData(scrollDatas, true)
end



this.OnSelectedDifficultyItem = function(item)
    if this.lastSeletedItem ~= nil then
        this.lastSeletedItem:OnSelected(false)
    end
    this.lastSeletedItem = item
    this.lastSeletedItem:OnSelected(true)
    SCNJData.SetCurSelectedDifficultyDataID(item.data.data.ID)
    local selectedDataID = item.data.data.ID
    local buffDatas = SCNJData.GetAllBuffDatasByID(selectedDataID)
    this.RefreshBuffScroll(buffDatas)
end



this.OnClickBuffCallback = function(item)
    LuaMgr.ShowLuaPanel(UIName.SCNJBuffInfoPopup, item.data)
end

this.OnRefreshTime = function()
    this.downTimeTxt.text = SCNJData.GetRemainTimeStr()
end

this.OnRefreshProcessData = function()
    this.totalScore.text = tostring(SCNJData.GetPlayerTotalScore())
    local hotData = SCNJData.GetCurServerHotData()
    this.phaseNum.text = tostring(hotData.hotLevel)
    local maxExp = ConfigMgr.Config.TeamRelayConstants.HeatProgress
    local percentNum = hotData.hotExp / maxExp
    percentNum = math.min(percentNum, 1)
    this.phasePrgressNum.text = string.format("%.0f%%", percentNum * 100)
    this.processProgress.sizeDelta = Vector2(percentNum * 344, this.processProgress.sizeDelta.y)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.rewardBtn, this.OnClickRewardBtn)
        LuaMgr.AddClick(this.helpBtn, this.OnClickHelpBtn)
        LuaMgr.AddClick(this.intoBattleBtn, this.OnClickIntoBattleBtn)
        LuaMgr.AddClick(this.syncTipsBtn, this.OnClickSyncTipsBtn)
        LuaMgr.AddClick(this.bgBtn, this.OnClickBgBtn)
        LuaMgr.AddUIEventListener(UIEventConst.SCNJHelpSuccess, this.Refresh)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.vmBehaviour = vm.behaviour
        LuaMgr.AddTimer(TimerConst.SCNJDownTimer, this.OnRefreshTime, 60, -1, true)
        LuaMgr.AddTimer(TimerConst.SCNJDownProcessTimer, this.OnRefreshProcessData, 3600, -1, true)
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SCNJDownTimer)
        LuaMgr.RemoveTimer(TimerConst.SCNJDownProcessTimer)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickRewardBtn)
        LuaMgr.RemoveClick(this.helpBtn, this.OnClickHelpBtn)
        LuaMgr.RemoveClick(this.intoBattleBtn, this.OnClickIntoBattleBtn)
        LuaMgr.RemoveClick(this.syncTipsBtn, this.OnClickSyncTipsBtn)
        LuaMgr.RemoveClick(this.bgBtn, this.OnClickBgBtn)
        LuaMgr.RemoveUIEventListener(UIEventConst.SCNJHelpSuccess, this.Refresh)
        UIScrollView.ClearItem("SCNJBuffItem")
        UIScrollView.ClearItem("SCNJDifficultyItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)