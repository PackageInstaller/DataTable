require("ViewModel/CrisisContract2/CrisisContract2EnemyBuffItem")
require("ViewModel/CrisisContract2/CrisisContract2SelfBuffItem")

local this = {
    vm = nil,

    plotId = "",
    curPlotCfg = nil,

    isInitEnemyList = false,
    enemyBuffList = {},
    enemyBuffScrollView = nil,
    enemyBuffItemTemplate = nil,

    isInitSelfList = false,
    selfBuffList = {},
    selfBuffScrollView = nil,
    selfBuffItemTemplate = nil,
    selfBuffChooseCount = 0,
    selfBuffChooseLimitCount = 0,

curShowType = 0,
    chooseBuffIdList = {},
    noBuffTipsToggleIsOn = false,
}

local data = {
    curScore = "",
    showEnemyBuffList = false,
    showSelfBuffList = false,
    selfChoosedBuffList = {
        { icon = DefaultSprite, name = "" }
    },
    curChooseCountStr = "",
    showNoBuffTips = false,
    noBuffTipsToggleOn = false,
    noBuffTipsToggleOff = false,
}

local command = {
    enemyBuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetCurScrollView(1)
        end
    },
    selfBuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetCurScrollView(2)
        end
    },
    selfChoosedBuffDelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1
            local delBuffGroup = this.vm.data.selfChoosedBuffList[index]
            if delBuffGroup == nil then
                return
            end
            local delBuffGroupId = delBuffGroup.id
            local newIndex = 1
            for i, v in ipairs(this.selfBuffList) do
                if v.Id == delBuffGroupId then
                    newIndex = i
                    break
                end
            end
            this.DelSelfBuffLevel(newIndex)
        end
    },
    clearCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            for i, v in ipairs(this.enemyBuffList) do
                v.Level = 0
                v.BuffInfo = CrisisContract2Mgr.GetBuffInfoByLevel(v.Id, v.Level)
            end

            for i, v in ipairs(this.selfBuffList) do
                v.Level = 0
                v.BuffInfo = CrisisContract2Mgr.GetBuffInfoByLevel(v.Id, v.Level)
            end
            this.RefreshList()
        end
    },
    startCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.chooseBuffIdList = {}
            local selfBuffCount = 0
            for i, v in ipairs(this.enemyBuffList) do
                if v.Level > 0 and v.BuffInfo ~= nil then
                    table.insert(this.chooseBuffIdList, string.format("%s_%s", v.Id, v.Level))
                end
            end
            for i, v in ipairs(this.selfBuffList) do
                if v.Level > 0 and v.BuffInfo ~= nil then
                    selfBuffCount = selfBuffCount + 1
                    table.insert(this.chooseBuffIdList, string.format("%s_%s", v.Id, v.Level))
                end
            end
            if selfBuffCount == 0 and this.CheckShowNoSelfBuffTips() then
                return
            end
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.crisiscontract2, this.plotId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.crisiscontract2, this.plotId, this.chooseBuffIdList, this.GetCurSelectBuffTotalScore())
        end
    },
    NoBuffTipsConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.noBuffTipsToggleIsOn then
                local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
                PlayerPrefs.SetString(DataMgr.Player.uid .. "_CrisisContract2NoSelfBuff", curDataStr);
                PlayerPrefs.Save();
            end
            this.vm.data.showNoBuffTips = false
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.crisiscontract2, this.plotId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.crisiscontract2, this.plotId, this.chooseBuffIdList, this.GetCurSelectBuffTotalScore())
        end
    },
    NoBuffTipsCancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showNoBuffTips = false
        end
    },
    NoBuffTipsToggleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.noBuffTipsToggleIsOn = not this.noBuffTipsToggleIsOn
            this.vm.data.noBuffTipsToggleOff = not this.noBuffTipsToggleIsOn
            this.vm.data.noBuffTipsToggleOn = this.noBuffTipsToggleIsOn
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm

        this.enemyBuffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/EnemyScrollView").gameObject)
        this.enemyBuffItemTemplate = vm.behaviour.transform:Find("template/EnemyBuffItem").gameObject
        this.selfBuffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/SelfScrollView").gameObject)
        this.selfBuffItemTemplate = vm.behaviour.transform:Find("template/SelfBuffItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.vm.data.showNoBuffTips = false
        this.plotId = vm.behaviour.Params[0];
        this.curPlotCfg = CrisisContract2Mgr.GetPlotConfig(this.plotId)
        this.selfBuffChooseLimitCount = this.curPlotCfg.SelfOptionLimit
        this.isInitEnemyList = false
        this.isInitSelfList = false
        this.curShowType = 0
        this.RefreshData()

    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        CrisisContract2Mgr.SaveChooseBuffList(this.plotId, this.enemyBuffList, this.selfBuffList)
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("CrisisContract2EnemyBuffItem")
        UIScrollView.ClearItem("CrisisContract2SelfBuffItem")
    end,
}

this.RefreshData = function()
    this.enemyBuffList, this.selfBuffList = CrisisContract2Mgr.GetAllBuffListByPlotId(this.plotId)
    local chooseEnemyBuffList, chooseSelfBuffList = CrisisContract2Mgr.GetChooseBuffListByPlotId(this.plotId)
    local chooseBuffMap = {}
    for i, v in ipairs(chooseEnemyBuffList) do
        chooseBuffMap[v.Id] = {
            level = v.Level,
            buffInfo = v.BuffInfo
        }
    end
    for i, v in ipairs(chooseSelfBuffList) do
        chooseBuffMap[v.Id] = {
            level = v.Level,
            buffInfo = v.BuffInfo
        }
    end
    for i, v in ipairs(this.enemyBuffList) do
        if chooseBuffMap[v.Id] ~= nil then
            v.Level = chooseBuffMap[v.Id].level
            v.BuffInfo = chooseBuffMap[v.Id].buffInfo
        end
    end
    for i, v in ipairs(this.selfBuffList) do
        if chooseBuffMap[v.Id] ~= nil then
            v.Level = chooseBuffMap[v.Id].level
            v.BuffInfo = chooseBuffMap[v.Id].buffInfo
        end
    end

    this.SetCurScrollView(1)
end

this.SetCurScrollView = function(type)
    if this.curShowType == type then
        return
    end
    this.curShowType = type
    this.vm.data.showEnemyBuffList = this.curShowType == 1
    this.vm.data.showSelfBuffList = this.curShowType == 2
    this.RefreshList()
end

this.SetEnemyBuffList = function()
    if this.isInitEnemyList then
        return
    end
    this.isInitEnemyList = true
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #this.enemyBuffList
    for i = 1, #this.enemyBuffList do
        groupData = this.enemyBuffList[i]
        groupData.index = i
        groupData.onClickAdd = this.AddEnemyBuffLevel
        groupData.onClickDel = this.DelEnemyBuffLevel
        scrollData = UIScrollData.GetData(this.enemyBuffItemTemplate, "CrisisContract2EnemyBuffItem", 1180, 85, groupData)
        table.insert(scrollDatas, scrollData)
    end

    this.enemyBuffScrollView:Clear(false)
    this.enemyBuffScrollView:SetPadding(0, 0, 0, 0)
    this.enemyBuffScrollView:SetParams(1223, 432)
    this.enemyBuffScrollView:SetData(scrollDatas, true)
end

this.SetSelfBuffList = function()
    if this.isInitSelfList then
        return
    end
    this.isInitSelfList = true
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #this.selfBuffList
    for i = 1, #this.selfBuffList do
        groupData = this.selfBuffList[i]
        groupData.index = i
        groupData.onClickAdd = this.AddSelfBuffLevel
        groupData.onClickDel = this.DelSelfBuffLevel
        scrollData = UIScrollData.GetData(this.selfBuffItemTemplate, "CrisisContract2SelfBuffItem", 825, 85, groupData)
        table.insert(scrollDatas, scrollData)
    end

    this.selfBuffScrollView:Clear(false)
    this.selfBuffScrollView:SetPadding(0, 0, 0, 0)
    this.selfBuffScrollView:SetParams(868, 432)
    this.selfBuffScrollView:SetData(scrollDatas, true)
end

this.RefreshList = function()
    if this.curShowType == 1 then
        this.SetEnemyBuffList()
        this.enemyBuffScrollView:Refresh()
    elseif this.curShowType == 2 then
        this.SetSelfBuffList()
        local tempList = {}
        for i, v in ipairs(this.selfBuffList) do
            if v.Level > 0 then
                table.insert(tempList, { id = v.Id, icon = v.BuffInfo.Icon, name = v.BuffInfo.Name })
            end
        end
        this.vm.data.selfChoosedBuffList = tempList
        this.selfBuffChooseCount = #tempList
        this.vm.data.curChooseCountStr = string.format("<color=#FFFFFF>%d</color>/%d", this.selfBuffChooseCount, this.selfBuffChooseLimitCount)
        this.selfBuffScrollView:Refresh()
    end

    this.vm.data.curScore = this.GetCurSelectBuffTotalScore()
end


this.GetCurSelectBuffTotalScore = function()
local initialCredit = this.curPlotCfg.InitialCredit
    local totalScore = initialCredit
    for i, v in ipairs(this.enemyBuffList) do
        totalScore = totalScore + v.BuffInfo.Score
    end
    return totalScore
end

this.AddEnemyBuffLevel = function(index)
    this.AddBuffLevel(this.enemyBuffList, index)
end

this.DelEnemyBuffLevel = function(index)
    this.DelBuffLevel(this.enemyBuffList, index)
end

this.AddSelfBuffLevel = function(index)
    if this.selfBuffChooseCount >= this.selfBuffChooseLimitCount then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("25001"));
        return
    end
    this.AddBuffLevel(this.selfBuffList, index)
end

this.DelSelfBuffLevel = function(index)
    this.DelBuffLevel(this.selfBuffList, index)
end

this.AddBuffLevel = function(buffList, index)
    local selfBuffInfo = buffList[index]
    local curLevel = selfBuffInfo.Level
    if curLevel == selfBuffInfo.MaxLevel then
        return
    end
    selfBuffInfo.Level = curLevel + 1
    selfBuffInfo.BuffInfo = CrisisContract2Mgr.GetBuffInfoByLevel(selfBuffInfo.Id, selfBuffInfo.Level)
    this.RefreshList()
end

this.DelBuffLevel = function(buffList, index)
    local selfBuffInfo = buffList[index]
    local curLevel = selfBuffInfo.Level
    if curLevel == 0 then
        return
    end
    selfBuffInfo.Level = curLevel - 1
    selfBuffInfo.BuffInfo = CrisisContract2Mgr.GetBuffInfoByLevel(selfBuffInfo.Id, selfBuffInfo.Level)
    this.RefreshList()
end

this.CheckShowNoSelfBuffTips = function()
    local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
    local savedDataStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "_CrisisContract2NoSelfBuff", "");
    if savedDataStr == curDataStr then
        return false
    end
    this.noBuffTipsToggleIsOn = true
    this.vm.data.noBuffTipsToggleOff = not this.noBuffTipsToggleIsOn
    this.vm.data.noBuffTipsToggleOn = this.noBuffTipsToggleIsOn
    this.vm.data.showNoBuffTips = true
    return true
end

return vm({
    data = data,
    command = command,
    hook = hook
})