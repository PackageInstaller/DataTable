require("ViewModel/MiniBattle4/MiniBattle4CharacterItem")
require("ViewModel/MiniBattle4/MiniBattle4BuffCardGroup")
require("ViewModel/MiniBattle4/MiniBattle4BuffCardItem")
require("ViewModel/MiniBattle4/MiniBattle4LevelItem")

local this = {
    vm = nil,
    plotId = "",
    curShowPage = 1,


    levelScrollView = nil,
    levelItemTemplate = nil,
    curLevelId = "",

    buffScrollView = nil,
    buffCardGroupTemplate = nil,
    buffCardItemTemplate = nil,


    curHelpId = "",
    characterListView = nil,
    characterTemplate = nil,
};

local data = {
    showLevel = false,
    showHelp = false,
    leftCountTipsStr = "",
    showDangerWarningStr = "",
    curHelpChaBuffDescStr = "",
    showWarning = false,
    warningToggleOn = false,
}

local command = {
    levelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowPage == 1 then
                return
            end
            this.SetCurShowPage(1)
        end
    },
    helpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowPage == 2 then
                return
            end
            this.SetCurShowPage(2)
        end
    },
    buffDetailCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle4BuffDetailPopup, this.curLevelId);
        end
    },
    helpChaDetailsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if IsNullOrEmpty(this.curHelpId) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MiniBattle4BuffViewModel_0"))
                return
            end
            local monsterInfoJson = MiniBattle4Mgr.GetMonsterDataJson(this.curHelpId)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", this.curHelpId, ActivityKey.DualBattle2, monsterInfoJson);
        end
    },
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowPage == 1 then
                this.SetCurShowPage(2)
                return
            end
            if IsNullOrEmpty(this.curHelpId) and not this.IsSkipWarningToday() then
                this.vm.data.warningToggleOn = true
                this.vm.data.showWarning = true
                return
            end
            this.EnterBattlePrepare()
        end
    },
    WarningConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.warningToggleOn then
                local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
                PlayerPrefs.SetString(DataMgr.Player.uid .. "_MiniBattle4HelpChaWarning", curDataStr);
                PlayerPrefs.Save();
            end
            this.vm.data.showWarning = false
            this.EnterBattlePrepare()
        end
    },
    WarningCancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showWarning = false
            this.SetCurShowPage(2)
        end
    },
    WarningToggleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.warningToggleOn = not this.vm.data.warningToggleOn
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.levelScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/LevelPage/Left/LevelScrollView").gameObject)
        this.buffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/LevelPage/Right/BuffScrollView").gameObject)
        this.characterListView = UIListView.New(vm.behaviour.transform:Find("root/Middle/Group/HelpPage/CharacterList/List"));
        this.levelItemTemplate = vm.behaviour.transform:Find("template/LevelItem").gameObject
        this.buffCardGroupTemplate = vm.behaviour.transform:Find("template/BuffCardGroup").gameObject
        this.buffCardItemTemplate = vm.behaviour.transform:Find("template/BuffCardItem").gameObject
        this.characterTemplate = vm.behaviour.transform:Find("template/CharacterItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);

        this.InitParameter()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.levelScrollView:Clear()
        this.buffScrollView:Clear()
        this.characterListView:Clear()
        LuaMgr.RemoveTimer(TimerConst.MiniBattle4LevelDelay);
        LuaMgr.RemoveTimer(TimerConst.MiniBattle4CharacterDelay);
    end,
    before_destroy = function(vm)
        this = nil;
        UIScrollView.ClearItem("MiniBattle4LevelItem")
        UIScrollView.ClearItem("MiniBattle4BuffCardGroup")
        UIListView.ClearItem("MiniBattle4CharacterItem")
    end
}

this.InitParameter = function()
    this.plotId = this.vm.behaviour.Params[0]
    this.plotCfg = MiniBattle4Mgr.GetPlotCfg(this.plotId)
    this.curShowPage = 1
    this.curLevelId = MiniBattle4Mgr.GetSelectedLevel(this.plotId)
    this.curHelpId = MiniBattle4Mgr.GetSelectedHelp(this.plotId)
    local leftCount, totalCount = MiniBattle4Mgr.GetSeriesLeftChallengeCount(this.plotCfg.SeriesId)
    this.vm.data.leftCountTipsStr = string.format(LuaMgr.GetLangText("MiniBattle4BuffViewModel_1"), leftCount, totalCount)
    this.vm.data.showWarning = false
    this.InitLevelList()
    this.InitHelpCharacters()
end

this.RefreshData = function()
    this.SetCurShowPage(this.curShowPage)
end

this.SetCurShowPage = function(type)
    this.curShowPage = type
    if this.curShowPage == 1 then
        this.ShowLevelPage()
    elseif this.curShowPage == 2 then
        this.ShowHelpPage()
    end
    this.vm.data.showLevel = this.curShowPage == 1
    this.vm.data.showHelp = this.curShowPage == 2
end

this.ShowLevelPage = function()
    this.OnClickLevelItem(this.curLevelId, true)
    this.MoveToSelectedLevelItem()
    this.PlayLevelListDelayAnim()
end

this.ShowHelpPage = function()
    this.OnClickCharacterItem(this.curHelpId)
    this.PlayCharacterListDelayAnim()
end

this.InitLevelList = function()
    local levelList = {}
    for i, v in ipairs(this.plotCfg.EnemyOption) do
        local levelCfg = MiniBattle4Mgr.GetLevelCfg(v)
        local unlockTime = MiniBattle4Mgr.GetLevelUnlockTime(v)
        local status = MiniBattle4Mgr.GetPlotLevelStatus(v)
        local levelData = {
            levelId = v,
            descStr = LuaMgr.GetLangText(levelCfg.OptionDescLan),
            bgResName = levelCfg.BgResources,
            rewards = levelCfg.Reward,
            isSelected = false,
            isCanGet = status == 0,
            isFinished = status == 2,
            sort = status,
            onClick = this.OnClickLevelItem
        }
        table.insert(levelList, levelData)
    end
    table.sort(levelList, function(a, b)
        if a.sort == b.sort then
            return a.levelId < b.levelId
        else
            return a.sort < b.sort
        end
    end)

    if IsNullOrEmpty(this.curLevelId) then
        this.curLevelId = levelList[1].levelId
    end

    local scrollData, scrollDatas = {}, {}
    local groupData = nil

    for i, v in ipairs(levelList) do
        groupData = v
        scrollData = UIScrollData.GetData(this.levelItemTemplate, "MiniBattle4LevelItem", 448, 112 + 5, groupData)
        table.insert(scrollDatas, scrollData)
    end

    this.levelScrollView:Clear(false)
    this.levelScrollView:SetPadding(0, 0, -17, 0)
    this.levelScrollView:SetParams(470, 390)
    this.levelScrollView:SetData(scrollDatas, true)
end

this.MoveToSelectedLevelItem = function()
    for i, v in ipairs(this.levelScrollView.dataList) do
        if v.isSelect then
            this.levelScrollView:MoveToIndex(i)
            break
        end
    end
end

this.PlayLevelListDelayAnim = function()
    local index = this.levelScrollView:GetIndex()
    LuaMgr.RemoveTimer(TimerConst.MiniBattle4LevelDelay)
    LuaMgr.AddTimer(TimerConst.MiniBattle4LevelDelay, function()
        if this.levelScrollView.itemMap[index] ~= nil then
            SetActive(this.levelScrollView.itemMap[index].AnimatorObj, true)
            index = index + 1
        else
            for i = 1, #this.levelScrollView.dataList do
                this.levelScrollView.dataList[i].data.animBool = true
            end
            LuaMgr.RemoveTimer(TimerConst.MiniBattle4LevelDelay)
        end
    end, 0.05, -1, true)
end

this.InitHelpCharacters = function()
    local seriesCfg = MiniBattle4Mgr.GetSeriesCfg(this.plotCfg.SeriesId)
    local lockedChaMap = MiniBattle4Mgr.GetLockedCharacterMap(this.plotCfg.SeriesId)
    this.characterListView:Clear();
    local len = #seriesCfg.ActorList;
    if (len > 0) then
        local listData;
        local characterDatas = {};
        for i = 1, len do
            local chaId = seriesCfg.ActorList[i]
            local itemData = {
                monsterId = chaId,
                isShow = false,
                onClick = this.OnClickCharacterItem,
                isSelected = false,
                isLocked = false
            }
            if lockedChaMap[chaId] ~= nil then
                if lockedChaMap[chaId] == this.plotId then
                    itemData.isSelected = true
                    this.curHelpId = chaId
                else
                    itemData.isLocked = true
                end
            end
            listData = UIListData.GetData(this.characterTemplate, "MiniBattle4CharacterItem", itemData);
            table.insert(characterDatas, listData);
        end
        this.characterListView:SetData(characterDatas);
    end
end

this.PlayCharacterListDelayAnim = function()
    local index = 1
    LuaMgr.RemoveTimer(TimerConst.MiniBattle4CharacterDelay)
    LuaMgr.AddTimer(TimerConst.MiniBattle4CharacterDelay, function()
        if this.characterListView.itemMap[index] ~= nil then
            SetActive(this.characterListView.itemMap[index].group, true)
            index = index + 1
        else
            for i = 1, #this.characterListView.dataList do
                this.characterListView.dataList[i].data.isShow = true
            end
            LuaMgr.RemoveTimer(TimerConst.MiniBattle4CharacterDelay)
        end
    end, 0.09, -1, true);
end

this.RefreshBuffList = function()
    local levelCfg = MiniBattle4Mgr.GetLevelCfg(this.curLevelId)
    if levelCfg.Warning == 1 then
        this.vm.data.showDangerWarningStr = LuaMgr.GetLangText("MiniBattle4BuffViewModel_2")
    else
        this.vm.data.showDangerWarningStr = ""
    end
    local buffList = {}
    for i, v in ipairs(levelCfg.BuffGroup) do
        local buffCardData = MiniBattle4Mgr.GetBuffCardInfo(v)
        if buffCardData ~= nil then
            buffCardData.onClick = this.ShowBuffCardDetails
            buffCardData.onClickDetails = this.ShowBuffCardDetails
            table.insert(buffList, buffCardData)
        end
    end

    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #buffList
    local groupItemCount = 3
    local index = 1
    while index <= len do
        groupData = {
            itemTemplate = this.buffCardItemTemplate,
            itemDataList = {}
        }
        for i = 0, 2 do
            if index + i <= len then
                table.insert(groupData.itemDataList, buffList[index + i])
            end
        end
        scrollData = UIScrollData.GetData(this.buffCardGroupTemplate, "MiniBattle4BuffCardGroup", 700, 288, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + groupItemCount
    end

    this.buffScrollView:Clear(false)
    this.buffScrollView:SetPadding(0, 0, -12, 0)
    this.buffScrollView:SetParams(700, 419)
    this.buffScrollView:SetData(scrollDatas, true)
end


this.IsSkipWarningToday = function()
    local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
    local savedDataStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "_MiniBattle4HelpChaWarning", "");
    return savedDataStr == curDataStr
end

this.EnterBattlePrepare = function()
    if IsNullOrEmpty(this.curLevelId) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("25223"))
        return
    end
    ActivityBattlePrepareMgr.SetMembers(ActivityKey.DualBattle2, this.plotId)
    LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.DualBattle2, this.plotId, this.curLevelId, this.curHelpId);
end


this.OnClickLevelItem = function(levelId, isInit)
    this.curLevelId = levelId
    if not isInit then
        local status = MiniBattle4Mgr.GetPlotLevelStatus(levelId)
        if status == 0 then
            MiniBattle4Mgr.GetRewards(this.plotId, this.GetRewardsResponse)
            return
        end
    end
    
    for i = 1, #this.levelScrollView.dataList do
        this.levelScrollView.dataList[i].data.isSelected = this.levelScrollView.dataList[i].data.levelId == this.curLevelId
        if this.levelScrollView.itemMap[i] ~= nil then
            this.levelScrollView.itemMap[i]:Refresh()
        end
    end
    this.RefreshBuffList()
    MiniBattle4Mgr.SaveSelectedLevel(this.curLevelId)
end

this.GetRewardsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil and not IsNull(data.result.Rewards)) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        this.curLevelId = ""
        this.InitLevelList()
        this.ShowLevelPage()
    end
end

this.OnClickCharacterItem = function(helpId)
    this.curHelpId = helpId
    for i = 1, #this.characterListView.dataList do
        this.characterListView.dataList[i].data.isSelected = this.characterListView.dataList[i].data.monsterId == this.curHelpId
        if this.characterListView.itemMap[i] ~= nil then
            this.characterListView.itemMap[i]:Refresh()
        end
    end
    local buffDescStr = ""
    if IsNullOrEmpty(this.curHelpId) then
        buffDescStr = LuaMgr.GetLangText("MiniBattle4BuffViewModel_3")
    else
        buffDescStr =  LuaMgr.GetLangText("MiniBattle4BuffViewModel_4")
        local monsterInfo = MiniBattle4Mgr.GetMonsterInfo(this.curHelpId)
        local actorBuffs = monsterInfo.dualBattleCfg.ActorBuff
        for i, v in ipairs(actorBuffs) do
            local buffDescCfg = MiniBattle4Mgr.GetBuffDescCfg(v)
            local buffName = LuaMgr.GetLangText(buffDescCfg.BuffNamelan)
            local buffdesc = LuaMgr.GetLangText(buffDescCfg.BuffDeslan)
            buffDescStr = string.format("%s\n——%s：%s\n", buffDescStr, buffName, buffdesc)
        end
        buffDescStr = string.format("%s\n%s", buffDescStr, ConfigMgr.LangGlobal("29523"))
    end
    this.vm.data.curHelpChaBuffDescStr = buffDescStr
    
    MiniBattle4Mgr.SaveSelectedHelp(this.plotId, this.curHelpId)
end

this.ShowBuffCardDetails = function(cardId)
    LuaMgr.ShowLuaPanel(UIName.MiniBattle4BuffCardInfoPopup, cardId);
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})