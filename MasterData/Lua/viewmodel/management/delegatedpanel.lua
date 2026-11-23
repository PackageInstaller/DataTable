require("ViewModel/Management/ViewItem/DelegatedItem")

local objs = {
    delegatePrefab = {path = "template/DelegatePrefab", type = UITool.GameObject},
    itemParent = {path = "template/ItemParent", type = UITool.GameObject},
    delegateScrollView = {path = "root/Middle/ScrollView", type = UITool.ScrollRect},
    rewardScrollView = {path = "root/Middle/ContentGroup/RewardParent", type = UITool.ScrollRect},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    noCompleteTips = {path = "root/Middle/NoCompleteTips", type = UITool.GameObject},
    completeTips = {path = "root/Middle/CompleteTips", type = UITool.GameObject},
    desc = {path = "root/Middle/ContentGroup/Desc", type = UITool.Text},
    contentGroup = {path = "root/Middle/ContentGroup", type = UITool.GameObject},
    playBtn = {path = "root/Middle/ContentGroup/PlayBtn", type = UITool.Button},
    replayBtn = {path = "root/Middle/ContentGroup/ReplayBtn", type = UITool.Button},
    gameGotObj = {path = "root/Middle/ContentGroup/BG", type = UITool.GameObject},
    gotCount = {path = "root/Middle/ContentGroup/BG/GotCount", type = UITool.Text}
}

local this = {
    toggleNames = {"ToggleAll", "ToggleNoCompleted", "ToggleCompleted"},
    curSelectPage = 1
}

this.before_awake = function()
    this.delegateListView = UIScrollView.New(this.delegateScrollView)
    this.rewardListView = UIScrollView.New(this.rewardScrollView)
    this.toggleNodes = {}
    RedMgr.Singleton:RegisterViewModel(UIName.DelegatedPanel)
    for i = 1, #this.toggleNames do
        local name = this.toggleNames[i]

        local toggleNode = CommonToggleItem.New(this[name], nil, false, i, this.ClickPageToggle)
        this.toggleNodes[i] = toggleNode
        local data = {}
        toggleNode:SetData(data)
        toggleNode:SetIsOn(i == 1)
    end
end

this.before_active = function()
    RedMgr.Singleton:SetRedState(ManagementConst.RedPoint.Delegate, ManagementData.CheckExistNoCompleteDelegate())
    local needOpen, curSelectPage = ManagementData.NeedOpenDelegate()
    if needOpen == true then
        this.curSelectPage = curSelectPage
        for i = 1, #this.toggleNodes do
            local toggleNode = this.toggleNodes[i]
            toggleNode:SetIsOn(this.curSelectPage == i)
            toggleNode.toggle.isOn = this.curSelectPage == i
        end
    end
    this.SwitchPage()
    ManagementData.SetNeedOpenDelegate(false, nil)
end

this.ClickPageToggle = function(index, value)
    if value == true then
        this.curSelectPage = index
        this.SwitchPage()
        for i = 1, #this.toggleNodes do
            local toggleNode = this.toggleNodes[i]
            toggleNode:SetIsOn(index == i)
        end
        if this.curSelectPage == ManagementConst.DelegeateType.NoComplete then
            RedMgr.Singleton:FrushRedCondition(ManagementConst.RedPoint.Delegate)
            RedMgr.Singleton:SetRedState(ManagementConst.RedPoint.Delegate, 0, UIName.ManagementHomePanel)
            RedMgr.Singleton:SetRedState(ManagementConst.RedPoint.Delegate, 0, UIName.DelegatedPanel)
            ManagementData.CheckExistNoCompleteDelegate()
        end
    end
end

this.SwitchPage = function()
    SetActive(this.noCompleteTips, false)
    SetActive(this.completeTips, false)
    SetActive(this.contentGroup, true)
    this.allDatas = ManagementData.GetDelegatedData(this.curSelectPage)
    this.delegateListView:Clear(false)
    if #this.allDatas == 0 then
        SetActive(this.noCompleteTips, this.curSelectPage == ManagementConst.DelegeateType.NoComplete)
        SetActive(this.completeTips, this.curSelectPage == ManagementConst.DelegeateType.Completed)
        SetActive(this.contentGroup, false)
        return
    end
    this.RefreshList()
end

this.RefreshList = function()
    local scrollDatas = {}
    local allDatas = this.allDatas
    local len = #allDatas
    for i = 1, len do
        local data = allDatas[i]
        data.clickCallback = this.OnClickItem
        local scrollData = UIScrollData.GetData(this.delegatePrefab, "DelegatedItem", 224, 70, data)
        if i == 1 then
            this.selectData = data
            ManagementData.SetDelegateSeletedID(data.ID)
            this.RefreshPage()
        end
        table.insert(scrollDatas, scrollData)
    end
    this.delegateListView:SetParams(245, 369)
    this.delegateListView:SetData(scrollDatas, true)
    this.showIndex = 1
    this.showList = this.delegateListView.screenList
    for _, v in pairs(this.showList) do
        SetActive(v.gameObject, false)
    end
    LuaMgr.AddTimer(TimerConst.ManagementDelayShowItem, this.OnDelayRefreshItem, 0.05, -1, false)
end


this.OnDelayRefreshItem = function()
    if (this.showIndex > #this.showList) then
        LuaMgr.RemoveTimer(TimerConst.ManagementDelayShowItem)
        return
    end
    local item = this.showList[this.showIndex]
    SetActive(item.gameObject, true)
    this.showIndex = this.showIndex + 1
end

this.RefreshPage = function()
    if this.selectData == nil then
        return
    end
    for key, name in pairs(DelegatedItem.FlagName) do
        local obj = this[name]
        SetActive(obj, key == this.selectData.type)
    end
    this.desc.text = this.selectData.desc
    this.rewardListView:Clear()
    local scrollDatas = {}
    local allDatas = this.selectData.reward
    local len = NumTool.GetLen(allDatas)
    for i = 1, len do
        local data = allDatas[i]
        local scrollData = UIScrollData.GetData(this.itemParent, "CommonRewardItem", 80, 80, data)
        table.insert(scrollDatas, scrollData)
    end
    this.rewardListView:SetParams(282, 84)
    this.rewardListView:SetData(scrollDatas)
    SetActive(this.playBtn.gameObject, this.selectData.isFinish == false)
    SetActive(this.replayBtn.gameObject, this.selectData.isFinish == true)
    SetActive(this.gameGotObj, this.selectData.type == ManagementConst.PassNumType.Event)
    if this.selectData.type == ManagementConst.PassNumType.Event then
        local gameData = ManagementGameData.GetPassData(this.selectData.config.eventParam)
        local maxGetRewardCount = gameData.config.limit[1].count
        local serverData = ManagementData.GetMiniGameData(gameData.ID)
        local reputation = 0
        if serverData ~= nil then
            reputation = serverData.reputation
            reputation = math.min(reputation, maxGetRewardCount)
        end
        this.gotCount.text = string.format("%d/%d", reputation, maxGetRewardCount)
        if reputation >= maxGetRewardCount then
            local lanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27121")
            this.gotCount.text = string.format(lanStr, reputation, maxGetRewardCount)
        end
    end
end



this.OnClickItem = function(item)
    this.selectData = item.data
    if this.selectData == nil then
        return
    end
    ManagementData.SetDelegateSeletedID(this.selectData.ID)
    this.RefreshPage()
    this.delegateListView:Refresh()
end

this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.DelegatedPanel)
end

this.OnIntoDelegate = function()
    if this.selectData == nil then
        LuaDebug.error("147 this.OnIntoDelegate error : this.selectData is nil")
        return
    end
    if this.selectData.type == ManagementConst.PassNumType.Event then
        local data = {}
        data.passID = this.selectData.config.eventParam
        data.name = this.selectData.name
        LuaMgr.ShowLuaPanel(UIName.ManagementGamePanel, data)
    else
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = this.selectData.config.id
        enterDungeonParams.dungeonId = this.selectData.config.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
        ManagementData.SetNeedOpenDelegate(true, this.curSelectPage)
    end
    LuaMgr.HidePanel(UIName.DelegatedPanel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for key, name in pairs(DelegatedItem.FlagName) do
            local data = {}
            data.path = "root/Middle/ContentGroup/" .. name
            data.type = UITool.GameObject
            objs[name] = data
        end
        for key, name in pairs(this.toggleNames) do
            local data = {}
            data.path = "root/Middle/StageToggleGroup/" .. name
            data.type = UITool.GameObject
            objs[name] = data
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose)
        LuaMgr.AddClick(this.maskBtn, this.OnClickClose)
        LuaMgr.AddClick(this.playBtn, this.OnIntoDelegate)
        LuaMgr.AddClick(this.replayBtn, this.OnIntoDelegate)

        this.before_awake()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.playBtn, this.OnIntoDelegate)
        LuaMgr.RemoveClick(this.replayBtn, this.OnIntoDelegate)
        UIScrollView.ClearItem("DelegatedItem")
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