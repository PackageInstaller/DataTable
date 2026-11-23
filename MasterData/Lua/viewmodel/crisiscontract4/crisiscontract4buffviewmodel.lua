require("ViewModel/CrisisContract2/CrisisContract2EnemyBuffItem")
require("ViewModel/CrisisContract2/CrisisContract2SelfBuffItem")

local this = {
    vm = nil,

    dungeonId = "",

    enemyBuffList = {},
    enemyBuffScrollView = nil,
    enemyBuffItemTemplate = nil,

    selfBuffList = {},
    selfBuffScrollView = nil,
    selfBuffItemTemplate = nil,
    selfBuffChooseCount = 0,
    selfBuffLimitCount = 0,

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
    showWarningTips = false,
    noBuffTipsToggleOn = false,
    noBuffTipsToggleOff = false,
}

local command = {
    enemyBuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowType == 1 then
                return
            end
            this.SetCurScrollView(1)
        end
    },
    selfBuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowType == 2 then
                return
            end
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
            end
            for i, v in ipairs(this.selfBuffList) do
                v.Level = 0
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
                if v.Level > 0 then
                    table.insert(this.chooseBuffIdList, CrisisContract4Mgr.GetBuffIdByLevel(v.Id, v.Level))
                end
            end
            for i, v in ipairs(this.selfBuffList) do
                if v.Level > 0 then
                    selfBuffCount = selfBuffCount + 1
                    table.insert(this.chooseBuffIdList, CrisisContract4Mgr.GetBuffIdByLevel(v.Id, v.Level))
                end
            end
            if selfBuffCount == 0 and this.CheckShowNoSelfBuffTips() then
                return
            end
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.TeamRelay3, this.dungeonId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.TeamRelay3, this.dungeonId, this.chooseBuffIdList, this.GetCurSelectBuffTotalScore())
        end
    },
    NoBuffTipsConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.noBuffTipsToggleIsOn then
                local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
                PlayerPrefs.SetString(DataMgr.Player.uid .. "_CrisisContract4NoSelfBuff", curDataStr);
                PlayerPrefs.Save();
            end
            this.vm.data.showNoBuffTips = false
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.TeamRelay3, this.dungeonId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.TeamRelay3, this.dungeonId, this.chooseBuffIdList, this.GetCurSelectBuffTotalScore())
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
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.dungeonId = vm.behaviour.Params[0];
        this.InitData()
        this.RefreshData()

    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.enemyBuffScrollView:Clear(true)
        this.selfBuffScrollView:Clear(true)
        CrisisContract4Mgr.SaveChooseBuffList(this.dungeonId, this.enemyBuffList, this.selfBuffList)
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("CrisisContract2EnemyBuffItem")
        UIScrollView.ClearItem("CrisisContract2SelfBuffItem")
    end,
}

this.InitData = function()
    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(this.dungeonId)
    local levelCfg = CrisisContract4Mgr.GetLevelCfg(dungeonCfg.DiffId)
    this.initialCredit = levelCfg.Credit
    this.selfBuffLimitCount = ConfigMgr.Config.TeamRelayConstants.TeamRelay3SelfBuffLimit
    this.curShowType = 1
    this.vm.data.showNoBuffTips = false
    this.InitBuffList()
    this.UpdateBuffLevel()
end

this.InitBuffList = function()
    this.enemyBuffList = {}
    this.selfBuffList = {}
    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(this.dungeonId)
    if dungeonCfg ~= nil then
        for i, v in ipairs(dungeonCfg.BuffGroup) do
            local buffItem = {
                Id = v,
                Level = 0,
                MaxLevel = CrisisContract4Mgr.GetBuffMaxLevel(v),
            }
            table.insert(this.enemyBuffList, buffItem)
        end
    end
    local selfBuffIds = ConfigMgr.Config.TeamRelayConstants.TeamRelay3SelfBuffGroup
    for i, v in ipairs(selfBuffIds) do
        local buffItem = {
            Id = v,
            Level = 0,
            MaxLevel = CrisisContract4Mgr.GetBuffMaxLevel(v),
        }
        table.insert(this.selfBuffList, buffItem)
    end
end

this.UpdateBuffLevel = function()
    local chooseBuffMap = {}
    local chooseEnemyBuffList, chooseSelfBuffList = CrisisContract4Mgr.GetChooseBuffList(this.dungeonId)
    for _, buff in ipairs(chooseEnemyBuffList) do
        chooseBuffMap[buff.Id] = buff.Level
    end
    for _, buff in ipairs(chooseSelfBuffList) do
        chooseBuffMap[buff.Id] = buff.Level
    end
    for _, buff in ipairs(this.enemyBuffList) do
        if chooseBuffMap[buff.Id] then
            buff.Level = chooseBuffMap[buff.Id]
        end
    end
    for _, buff in ipairs(this.selfBuffList) do
        if chooseBuffMap[buff.Id] then
            buff.Level = chooseBuffMap[buff.Id]
        end
    end
end

this.RefreshData = function()
    this.SetCurScrollView(this.curShowType)
end

this.SetCurScrollView = function(type)
    this.curShowType = type
    this.vm.data.showEnemyBuffList = this.curShowType == 1
    this.vm.data.showSelfBuffList = this.curShowType == 2
    this.RefreshList()
end

this.RefreshList = function(isRefresh)
    if this.curShowType == 1 then
        this.SetEnemyBuffList(isRefresh)
    elseif this.curShowType == 2 then
        this.SetSelfBuffList(isRefresh)
        this.SetSelfChooseBuffList()
    end
    this.vm.data.curScore = this.GetCurSelectBuffTotalScore()
    this.vm.data.showWarningTips = this.CheckIsDifficulty()
end

this.SetEnemyBuffList = function(isRefresh)
    if isRefresh then
        this.enemyBuffScrollView:Refresh()
        return
    end
    local scrollData, scrollDataList = {}, {}
    local groupData = nil
    local len = #this.enemyBuffList
    for i, v in ipairs(this.enemyBuffList) do
        groupData = v
        groupData.index = i
        groupData.onClickAdd = this.AddEnemyBuffLevel
        groupData.onClickDel = this.DelEnemyBuffLevel
        scrollData = UIScrollData.GetData(this.enemyBuffItemTemplate, "CrisisContract2EnemyBuffItem", 1180, 85, groupData)
        table.insert(scrollDataList, scrollData)
    end
    this.enemyBuffScrollView:Clear(false)
    this.enemyBuffScrollView:SetPadding(0, 0, 0, 0)
    this.enemyBuffScrollView:SetParams(1223, 432)
    this.enemyBuffScrollView:SetData(scrollDataList, true)
end

this.SetSelfBuffList = function(isRefresh)
    if isRefresh then
        this.selfBuffScrollView:Refresh()
        return
    end
    local scrollData, scrollDataList = {}, {}
    local groupData = nil
    local len = #this.selfBuffList
    for i, v in ipairs(this.selfBuffList) do
        groupData = v
        groupData.index = i
        groupData.onClickAdd = this.AddSelfBuffLevel
        groupData.onClickDel = this.DelSelfBuffLevel
        scrollData = UIScrollData.GetData(this.selfBuffItemTemplate, "CrisisContract2SelfBuffItem", 825, 85, groupData)
        table.insert(scrollDataList, scrollData)
    end
    this.selfBuffScrollView:Clear(false)
    this.selfBuffScrollView:SetPadding(0, 0, 0, 0)
    this.selfBuffScrollView:SetParams(868, 432)
    this.selfBuffScrollView:SetData(scrollDataList, true)
end

this.SetSelfChooseBuffList = function()
    local tempList = {}
    for i, v in ipairs(this.selfBuffList) do
        if v.Level > 0 then
            local buffInfo = CrisisContract4Mgr.GetBuffInfoByLevel(v.Id, v.Level)
            table.insert(tempList, { id = v.Id, icon = buffInfo.Icon, name = buffInfo.Name })
        end
    end
    this.vm.data.selfChoosedBuffList = tempList
    this.selfBuffChooseCount = #tempList
    this.vm.data.curChooseCountStr = string.format("<color=#FFFFFF>%d</color>/%d", this.selfBuffChooseCount, this.selfBuffLimitCount)
end


this.GetCurSelectBuffTotalScore = function()
    local totalScore = this.initialCredit
    for i, v in ipairs(this.enemyBuffList) do
        totalScore = totalScore + CrisisContract4Mgr.GetBuffScoreByLevel(v.Id, v.Level)
    end
    return totalScore
end

this.CheckIsDifficulty = function()
    local totalScore = this.GetCurSelectBuffTotalScore()
    return totalScore > ConfigMgr.Config.TeamRelayConstants.TeamRelay3Credit[#ConfigMgr.Config.TeamRelayConstants.TeamRelay3Credit]
end

this.AddEnemyBuffLevel = function(index)
    this.AddBuffLevel(this.enemyBuffList, index)
end

this.DelEnemyBuffLevel = function(index)
    this.DelBuffLevel(this.enemyBuffList, index)
end

this.AddSelfBuffLevel = function(index)
    if this.selfBuffChooseCount >= this.selfBuffLimitCount then
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
    if curLevel >= selfBuffInfo.MaxLevel then
        return
    end
    selfBuffInfo.Level = curLevel + 1
    this.RefreshList(true)
end

this.DelBuffLevel = function(buffList, index)
    local selfBuffInfo = buffList[index]
    local curLevel = selfBuffInfo.Level
    if curLevel <= 0 then
        return
    end
    selfBuffInfo.Level = curLevel - 1
    this.RefreshList(true)
end

this.CheckShowNoSelfBuffTips = function()
    local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
    local savedDataStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "_CrisisContract4NoSelfBuff", "");
    if savedDataStr == curDataStr then
        return false
    end
    this.noBuffTipsToggleIsOn = true
    this.vm.data.noBuffTipsToggleOff = not this.noBuffTipsToggleIsOn
    this.vm.data.noBuffTipsToggleOn = this.noBuffTipsToggleIsOn
    this.vm.data.showNoBuffTips = true
    return true
end

this.OnBack = function()
    LuaMgr.Back(this.dungeonId);
end

return vm({
    data = data,
    command = command,
    hook = hook
})