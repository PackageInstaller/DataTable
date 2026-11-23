require("ViewModel/MiniBattle2/MiniBattle2BuffCardGroup")
require("ViewModel/MiniBattle2/MiniBattle2BuffCardItem")
require("ViewModel/MiniBattle2/MiniBattle2EnemyLevelItem")
require("ViewModel/MiniBattle2/MiniBattle2BuffRewardItem")

local ScrollParam = {
    EnemyLevel = { class = "MiniBattle2EnemyLevelItem", itemWidth = 457, itemHeight = 93, scrollWidth = 457, scrollHeight = 426 },
    EnemyBuff = { class = "MiniBattle2BuffCardGroup", itemWidth = 657, itemHeight = 274, scrollWidth = 692, scrollHeight = 411 },
    SelfBuff = { class = "MiniBattle2BuffCardGroup", itemWidth = 657, itemHeight = 274, scrollWidth = 692, scrollHeight = 411 },
    SelfAllBuff = { class = "MiniBattle2BuffCardGroup", itemWidth = 457, itemHeight = 274, scrollWidth = 457, scrollHeight = 426 },
}

local this = {
    vm = nil,
    plotId = "",
curShowPage = 0,
    curLevelId = "",
    selfChooseBuffList = {},
    noBuffTipsToggleIsOn = false,
    
    enemyLevelList = {},
    enemyBuffCardList = {},
    selfBuffCardList = {},
    selfAllBuffCardList = {},

    enemyLevelScrollView = nil,
    enemyBuffScrollView = nil,
    selfBuffScrollView = nil,
    selfAllBuffScrollView = nil,
    EnemyLevelItemTemplate = nil,
    BuffCardGroupTemplate = nil,
    BuffCardItemTemplate = nil,
    GoodsItemTemplate = nil,
    timerList = {},
};

local data = {
    showEnemy = false,
    showSelf = false,
    scorePreviewStr = "",
    dailyLeftCountStr = "",
    enemyInfoStr_Hp = "",
    enemyInfoStr_Atk = "",
    enemyInfoStr_Def = "",
    selfInfoStr = "",
    selfBuffEmpty = false,
    showNoBuffTips = false,
    noBuffTipsToggleOn = false,
    noBuffTipsToggleOff = false,
}

local command = {
    showBuffDetailCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle2BuffDetailPopup, this.selfChooseBuffList, this.curLevelId, this.curShowPage);
        end
    },
    switchEnemyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetCurShowPage(1)
        end
    },
    switchSelfCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetCurShowPage(2)
        end
    },
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if IsNullOrEmpty(this.curLevelId) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("25223"))
                return
            end
            if #this.selfChooseBuffList == 0 and this.CheckShowNoSelfBuffTips() then
                return
            end
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.MiniBattlenew, this.plotId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.MiniBattlenew, this.plotId);
        end
    },
    NoBuffTipsConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.noBuffTipsToggleIsOn then
                local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
                PlayerPrefs.SetString(DataMgr.Player.uid .. "_MiniBattle2NoSelfBuff", curDataStr);
                PlayerPrefs.Save();
            end
            this.vm.data.showNoBuffTips = false
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.MiniBattlenew, this.plotId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.MiniBattlenew, this.plotId)
        end
    },
    NoBuffTipsCancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showNoBuffTips = false
            this.SetCurShowPage(2)
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
        this.enemyLevelScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/Right/EnemyLevel/ScrollView").gameObject)
        this.enemyBuffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/Left/Enemy/EnemyScrollView").gameObject)
        this.selfBuffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/Left/Self/SelfScrollView").gameObject)
        this.selfAllBuffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/Right/SelfAllBuff/ScrollView").gameObject)
        this.EnemyLevelItemTemplate = vm.behaviour.transform:Find("template/EnemyLevelItem").gameObject
        this.BuffCardGroupTemplate = vm.behaviour.transform:Find("template/BuffCardGroup").gameObject
        this.BuffCardItemTemplate = vm.behaviour.transform:Find("template/BuffCardItem").gameObject
        this.GoodsItemTemplate = vm.behaviour.transform:Find("template/GoodsItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.InitData()
        this.Refresh()
        LuaMgr.AddTimer(TimerConst.MiniBattleNewBuffTimer, this.UpdateTimer, 1, -1, true)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        MiniBattle2Mgr.SaveChooseBuffList(this.plotId, this.curLevelId, this.selfChooseBuffList)
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffTimer)
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffShowDelay);
    end,
    before_destroy = function(vm)
        this = nil;
        UIScrollView.ClearItem("MiniBattle2EnemyLevelItem")
        UIScrollView.ClearItem("MiniBattle2BuffCardGroup")
    end
}

this.InitData = function()
    this.plotId = this.vm.behaviour.Params[0]
    this.plotCfg = ConfigMgr.Config.MiniBattleNewMap[this.plotId]
    if this.plotCfg == nil then
        return
    end
    this.timerList = {}
    this.enemyBuffCardList = {}
    this.selfAllBuffCardList = {}
    this.curShowPage = 0
    this.curLevelId = ""
    this.selfChooseBuffList, this.curLevelId = MiniBattle2Mgr.GetChooseBuffListByPlotId(this.plotId)
    local dailyTotalCount = ConfigMgr.Config.constants.MiniBattleNewLimit
    local dailyUseCount = MiniBattle2Mgr.GetDailyBattleCount()
    this.vm.data.dailyLeftCountStr = string.format(LuaMgr.GetLangText("MiniBattle2BuffViewModel_0"),
            dailyTotalCount - dailyUseCount, dailyTotalCount)
    this.vm.data.showNoBuffTips = false
end

this.Refresh = function()
    this.SetCurShowPage(1)
end

this.SetCurShowPage = function(type)
    if this.curShowPage == type then
        return
    end
    this.curShowPage = type
    this.vm.data.showEnemy = this.curShowPage == 1
    this.vm.data.showSelf = this.curShowPage == 2
    this.RefreshList()
end

this.RefreshList = function()
    if this.curShowPage == 1 then
        this.SetEnemyLevelList()
    elseif this.curShowPage == 2 then
        this.SetSelfBuffCardList()
        this.SetSelfAllBuffCardList()
    end
end

this.SetEnemyLevelList = function()
    this.enemyLevelList = {}
    local levelCfgs = ConfigMgr.Config.MiniBattleNewBuffMap
    local levelList = this.plotCfg.EnemyOption
    local curTime = LuaMgr.Timestamp()
    for i, v in ipairs(levelList) do
        local levelCfg = levelCfgs[v]
        local levelData = {
            id = v,
            name = LuaMgr.GetLangText(levelCfg.OptionDescLan),
            reward = levelCfg.Reward,
            isSelect = v == this.curLevelId,
            onClick = this.OnClickLevelItem,
            status = MiniBattle2Mgr.GetDungeonLevelRewardStatus(v),
            goodsItem = this.GoodsItemTemplate,
            animBool = false,
        }
        local unlockTime = MiniBattle2Mgr.GetDungeonLevelUnlockTime(v)
        levelData.isLock = curTime < unlockTime
        levelData.lockTips = os.date(LuaMgr.GetLangText("MiniBattle2BuffViewModel_1"), unlockTime)
        this.timerList[v] = unlockTime
        table.insert(this.enemyLevelList, levelData)
    end

    table.sort(this.enemyLevelList, function(a, b)
        return a.id < b.id
    end)
    this.OnChooseLevel(this.curLevelId)
    local index = this.enemyLevelScrollView:GetIndex()
    LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffShowDelay)
    LuaMgr.AddTimer(TimerConst.MiniBattleNewBuffShowDelay,function()
        if this.enemyLevelScrollView.itemMap[index] ~= nil then
            SetActive(this.enemyLevelScrollView.itemMap[index].AnimatorObj,true)
            index = index + 1
        else
            for i = 1, #this.enemyLevelList do
                this.enemyLevelList[i].animBool = true
            end
            LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffShowDelay)
        end
    end,0.05,-1,true)
end

this.SetEnemyBuffCardList = function()
    if TableIsNull(this.enemyBuffCardList) then
        this.allEnemyBuffList = {}
        local allBuffList = MiniBattle2Mgr.GetDungeonAllEnemyBuff(this.plotId)
        for i, v in ipairs(allBuffList) do
            local buffCardData = MiniBattle2Mgr.GetBuffCardInfo(v)
            buffCardData.isSelect = this.CheckEnemyBuffIsChoosed(v)
            buffCardData.onClick = this.ShowBuffCardDetails
            buffCardData.onClickDetails = this.ShowBuffCardDetails
            table.insert(this.enemyBuffCardList, buffCardData)
        end
        this.RefreshScrollView("EnemyBuff", this.enemyBuffCardList, this.enemyBuffScrollView, 3, false)
    else
        for i, v in ipairs(this.enemyBuffCardList) do
            this.enemyBuffCardList[i].isSelect = this.CheckEnemyBuffIsChoosed(v.id)
        end
        this.RefreshScrollView("EnemyBuff", this.enemyBuffCardList, this.enemyBuffScrollView, 3, true)
    end
end

this.SetSelfBuffCardList = function()
    this.selfBuffCardList = {}
    for i, v in ipairs(this.selfChooseBuffList) do
        local buffCardData = MiniBattle2Mgr.GetBuffCardInfo(v)
        buffCardData.onClick = this.ShowBuffCardDetails
        buffCardData.onClickDetails = this.ShowBuffCardDetails
        table.insert(this.selfBuffCardList, buffCardData)
    end
    local selfChooseBuffCount = #this.selfBuffCardList
    this.vm.data.selfBuffEmpty = selfChooseBuffCount == 0
    this.RefreshScrollView("SelfBuff", this.selfBuffCardList, this.selfBuffScrollView, 3)

    this.vm.data.selfInfoStr = string.format("%d/%d", selfChooseBuffCount, this.plotCfg.SelfOptionLimit)
end

this.SetSelfAllBuffCardList = function()
    if TableIsNull(this.selfAllBuffCardList) then
        this.selfAllBuffCardList = {}
        local allBuffList = this.plotCfg.SelfOption
        for i, v in ipairs(allBuffList) do
            local buffCardData = MiniBattle2Mgr.GetBuffCardInfo(v)
            buffCardData.isSelect = this.CheckSelfBuffIsChoosed(v)
            buffCardData.onClick = this.OnClickSelfAllBuffCardItem
            buffCardData.onClickDetails = this.ShowBuffCardDetails
            table.insert(this.selfAllBuffCardList, buffCardData)
        end
        this.RefreshScrollView("SelfAllBuff", this.selfAllBuffCardList, this.selfAllBuffScrollView, 2, false)
    else
        for i, v in ipairs(this.selfAllBuffCardList) do
            this.selfAllBuffCardList[i].isSelect = this.CheckSelfBuffIsChoosed(v.id)
        end
        this.RefreshScrollView("SelfAllBuff", this.selfAllBuffCardList, this.selfAllBuffScrollView, 2, true)
    end
end

this.RefreshScrollView = function(key, dataList, scrollView, groupItemCount, isRefresh)
    if isRefresh then
        scrollView:Refresh()
    else
        local scrollData, scrollDatas = {}, {}
        local groupData = nil
        local len = #dataList
        local param = ScrollParam[key]
        local index = 1
        while index <= len do
            if groupItemCount == 1 then
                groupData = dataList[index]
                scrollData = UIScrollData.GetData(this.EnemyLevelItemTemplate, param.class, param.itemWidth, param.itemHeight, groupData)
            else
                groupData = {
                    itemTemplate = this.BuffCardItemTemplate,
                    itemDataList = {}
                }
                for i = 0, groupItemCount - 1 do
                    if index + i <= len then
                        table.insert(groupData.itemDataList, dataList[index + i])
                    end
                end
                scrollData = UIScrollData.GetData(this.BuffCardGroupTemplate, param.class, param.itemWidth, param.itemHeight, groupData)
            end
            table.insert(scrollDatas, scrollData)
            index = index + groupItemCount
        end
        scrollView:Clear(false)
        scrollView:SetPadding(0, 0, 0, 0)
        scrollView:SetParams(param.scrollWidth, param.scrollHeight)
        scrollView:SetData(scrollDatas, true)
    end
end

this.OnClickLevelItem = function(levelData)
    if levelData.isLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, levelData.lockTips)
    else
        if levelData.status == 0 then
            MiniBattle2Mgr.GetRewards(this.plotId, this.GetRewardsResponse)
        else
            if this.curLevelId ~= levelData.id then
                this.OnChooseLevel(levelData.id, true)
            end
        end
    end
end

this.GetRewardsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil and not IsNull(data.result.Rewards)) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        this.RefreshList()
    end
end

this.OnChooseLevel = function(levelId, isClick)
    local selectIndex = 1
    if MiniBattle2Mgr.CheckDungeonLevelIsUnLock(levelId) then
        this.curLevelId = levelId
        local levelCfg = ConfigMgr.Config.MiniBattleNewBuffMap[this.curLevelId]
        this.vm.data.enemyInfoStr_Hp = ConfigMgr.LangGlobal(levelCfg.InitialBuffDesc1)
        this.vm.data.enemyInfoStr_Atk = ConfigMgr.LangGlobal(levelCfg.InitialBuffDesc2)
        this.vm.data.enemyInfoStr_Def = ConfigMgr.LangGlobal(levelCfg.InitialBuffDesc3)
        this.vm.data.scorePreviewStr = levelCfg.Credit
        selectIndex = this.GetSelectLevelItemIndex(this.curLevelId)
        if selectIndex < 5 then
            selectIndex = 1
        end
    else
        this.vm.data.enemyInfoStr_Hp = ""
        this.vm.data.enemyInfoStr_Atk = ""
        this.vm.data.enemyInfoStr_Def = ""
        this.vm.data.scorePreviewStr = "0"
    end
    
    this.RefreshScrollView("EnemyLevel", this.enemyLevelList, this.enemyLevelScrollView, 1, isClick)
    if not isClick then
        this.enemyLevelScrollView:MoveToIndex(selectIndex)
    end
    this.SetEnemyBuffCardList()
end

this.OnClickSelfAllBuffCardItem = function(buffId)
    local isFind = false
    for i = #this.selfChooseBuffList, 1, -1 do
        if this.selfChooseBuffList[i] == buffId then
            table.remove(this.selfChooseBuffList, i)
            isFind = true
            break
        end
    end
    if not isFind then
        if this.CheckSelfBuffChooseLimit() then
            table.insert(this.selfChooseBuffList, buffId)
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("25220"));
            return
        end
    end

    this.SetSelfBuffCardList()
    this.SetSelfAllBuffCardList()
end

this.ShowBuffCardDetails = function(cardId)
    LuaMgr.ShowLuaPanel(UIName.MiniBattle2BuffCardInfoPopup, cardId);
end

this.CheckSelfBuffIsChoosed = function(buffId)
    for i, v in ipairs(this.selfChooseBuffList) do
        if v == buffId then
            return true
        end
    end
    return false
end

this.CheckEnemyBuffIsChoosed = function(buffId)
    if IsNullOrEmpty(this.curLevelId) then
        return false
    end
    local levelCfg = ConfigMgr.Config.MiniBattleNewBuffMap[this.curLevelId]
    local chooseBuffList = levelCfg.BuffGroup
    for i, v in ipairs(chooseBuffList) do
        if v == buffId then
            return true
        end
    end
    return false
end

this.CheckSelfBuffChooseLimit = function()
    return #this.selfChooseBuffList < this.plotCfg.SelfOptionLimit
end

this.CheckShowNoSelfBuffTips = function()
    local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
    local savedDataStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "_MiniBattle2NoSelfBuff", "");
    if savedDataStr == curDataStr then
        return false
    end
    this.noBuffTipsToggleIsOn = true
    this.vm.data.noBuffTipsToggleOff = not this.noBuffTipsToggleIsOn
    this.vm.data.noBuffTipsToggleOn = this.noBuffTipsToggleIsOn
    this.vm.data.showNoBuffTips = true
    return true
end


this.GetSelectLevelItemIndex = function(levelId)
    local selectIndex = 0
    for i, v in ipairs(this.enemyLevelList) do
        v.isSelect = v.id == levelId
        if v.isSelect then
            selectIndex = i
        end
    end
    return selectIndex
end
this.UpdateTimer = function()
    for k, unlockTime in pairs(this.timerList) do
        if unlockTime <= 0 then
            this.timerList = {}
            this.Refresh()
            break
        end
        this.timerList[k] = this.timerList[k] - 1
    end
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})