require("ViewModel/MiniBattle3/MiniBattle3EnemyLevelItem")
require("ViewModel/MiniBattle3/MiniBattle3BuffRewardItem")

local this = {
    vm = nil,
    plotId = "",
isUpDungeon = false,
curShowPage = 0,
    curLevelId = "",
    preLevelId = "",
selfChooseBuffLevelGroupIdList = {},
    curShowBuffGroupId = "",
    previewBuffId = "",
    enemyLevelList = {},
    enemyLevelScrollView = nil,
    EnemyLevelItemTemplate = nil,
    enemyBuffScrollView = nil,
    enemuBuffContentRect = nil,
    GoodsItemTemplate = nil,
    nextRefreshTime = 0,
    noBuffTipsToggleIsOn = false,
    levelRewardListRect = nil,
    animName = "",
};

local data = {
    showEnemyPage = false,
    showSelfPage = false,
    showDungeonRule = false,
    showEnemyLevelList = false,
    showBuffInfo = false,

    enemyBuffVMList = {
        { id = "", icon = DefaultSprite, name = "", select_1 = false, select_2 = false, lock = false, unlockEffect = false, animName = "", }
    },
    selfBuffVMList = {
        { id = "", icon = DefaultSprite, name = "", select_1 = false, select_2 = false, lock = false, unlockEffect = false, animName = "", }
    },
    selfBuffChooseLimit = "",

    ruleList = { { rule = "", anim = false, } },
    ruleCoinPreviewStr = "",
    ruleRewardCanGet = false,

    showLevelDifficultTips = false,

    curShowBuffTexture = DefaultSprite,
    curShowBuffName = "",
    curShowBuffDesc = "",
    showBuffPreviewBtn = false,
    showBuffUpGradeBtn = false,
    buffUpGradeConsumeIcon = DefaultTexture,
    buffUpGradeConsumeNum = "",
    showBuffChooseBtn_1 = false,
    showBuffChooseBtn_2 = false,
    buffChooseBtnText = "",
    chooseBtnImage_1 = false,
    chooseBtnImage_2 = false,

    showPreviewBuffTips = false,
    previewBuffDesc = "",

    dailyLeftCountStr = "",
    showNoBuffTips = false,
    noBuffTipsToggleOn = false,

    startBtnText = "",
}

local command = {
    showBuffDetailCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local chooseBuffList = this.GetChooseBuffList()
            LuaMgr.ShowLuaPanel(UIName.MiniBattle3BuffDetailPopup, chooseBuffList, this.curLevelId, this.curShowPage);
        end
    },
    switchEnemyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SwitchCurShowPage(1)
        end
    },
    switchSelfCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SwitchCurShowPage(2)
        end
    },
    buffItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            if this.curShowPage == 1 then
                local cardId = this.vm.data.enemyBuffVMList[index].id
                this.ShowBuffCardDetails(cardId)
            elseif this.curShowPage == 2 then
                local levelGroupId = this.vm.data.selfBuffVMList[index].levelGroupId
                this.SetChooseBuffInfo(levelGroupId)
            end
        end
    },
    buffPreviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not IsNullOrEmpty(this.previewBuffId) then
                local buffDescCfg = ConfigMgr.Config.DualBattleBuffDescMap[this.previewBuffId]
                this.vm.data.previewBuffDesc = LuaMgr.GetLangText(buffDescCfg.BuffDeslan)
                this.vm.data.showPreviewBuffTips = true
            end
        end
    },
    buffUpGradeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            MiniBattle3Mgr.UpGradeBuffLevel(this.curShowBuffGroupId, 1, function()
                LuaMgr.ShowLuaPanel(UIName.MiniBattle3UpGradeSuccessPopup, this.curShowBuffGroupId, 1)
                this.Refresh()
            end)
        end
    },
    buffChooseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.CheckSelfBuffIsChoosed(this.curShowBuffGroupId) then
                local len = #this.selfChooseBuffLevelGroupIdList
                for i = len, 1, -1 do
                    if this.selfChooseBuffLevelGroupIdList[i] == this.curShowBuffGroupId then
                        table.remove(this.selfChooseBuffLevelGroupIdList, i)
                        break
                    end
                end
            else
                if #this.selfChooseBuffLevelGroupIdList >= this.plotCfg.SelfOptionLimit then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26662"))
                    return
                end
                table.insert(this.selfChooseBuffLevelGroupIdList, this.curShowBuffGroupId)
            end
            this.Refresh()
        end
    },
    ruleRewardGetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if MiniBattle3Mgr.CheckDungeonRewardRed(this.plotId) then
                MiniBattle3Mgr.GetRewards(this.plotId, this.GetRewardsResponse)
            end
        end
    },
    maskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.showPreviewBuffTips then
                this.vm.data.showPreviewBuffTips = false
            end
        end
    },
    clearAllChooseBuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.selfChooseBuffLevelGroupIdList = {}
            this.Refresh()
        end
    },
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowPage == 1 then
                this.SwitchCurShowPage(2)
                return
            end
            if IsNullOrEmpty(this.curLevelId) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("25223"))
                return
            end
            if #this.selfChooseBuffLevelGroupIdList == 0 and this.CheckShowNoSelfBuffTips() then
                return
            end
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.DualBattle, this.plotId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.DualBattle, this.plotId);
        end
    },
    NoBuffTipsConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.noBuffTipsToggleIsOn then
                local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
                PlayerPrefs.SetString(DataMgr.Player.uid .. "_MiniBattle3NoSelfBuff", curDataStr);
                PlayerPrefs.Save();
            end
            this.vm.data.showNoBuffTips = false
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.DualBattle, this.plotId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.DualBattle, this.plotId)
        end
    },
    NoBuffTipsCancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showNoBuffTips = false
            this.SwitchCurShowPage(2)
        end
    },
    NoBuffTipsToggleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.noBuffTipsToggleIsOn = not this.noBuffTipsToggleIsOn
            this.vm.data.noBuffTipsToggleOn = this.noBuffTipsToggleIsOn
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.enemyLevelScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/Right/EnemyLevel/ScrollView").gameObject)
        this.EnemyLevelItemTemplate = vm.behaviour.transform:Find("template/EnemyLevelItem").gameObject
        this.enemyBuffScrollView = vm.behaviour.transform:Find("root/Middle/Group/Left/Enemy/EnemyScrollView").gameObject:GetComponent("RectTransform")
        this.enemuBuffContentRect = vm.behaviour.transform:Find("root/Middle/Group/Left/Enemy/EnemyScrollView/Viewport/Content").gameObject:GetComponent("RectTransform")
        this.GoodsItemTemplate = vm.behaviour.transform:Find("template/GoodsItem").gameObject
        this.levelRewardListRect = vm.behaviour.transform:Find("root/Middle/Group/Right/DungeonRule/Reward/Content").gameObject:GetComponent("RectTransform")
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
        MiniBattle3Mgr.SaveChooseBuffList(this.plotId, this.curLevelId, this.selfChooseBuffLevelGroupIdList)
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffTimer)
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffShowDelay);
    end,
    before_destroy = function(vm)
        this = nil;
        UIScrollView.ClearItem("MiniBattle3EnemyLevelItem")
    end
}

this.InitData = function()
    this.plotId = this.vm.behaviour.Params[0]
    this.plotCfg = ConfigMgr.Config.DualBattleMap[this.plotId]
    if this.plotCfg == nil then
        return
    end
    this.isUpDungeon = this.plotCfg.Type == 1
    this.nextRefreshTime = 0
    this.curShowPage = 1
    this.curLevelId = ""
    this.preLevelId = ""
    this.animName = "ani_MiniBattle3BuffPanel_BuffCardItem_001"
    this.selfChooseBuffLevelGroupIdList, this.curLevelId = MiniBattle3Mgr.GetChooseBuffListByPlotId(this.plotId)
end

this.Refresh = function()
    this.SetPageInfo()
    this.SetCurShowPage(this.curShowPage)
    this.PlayAnim()
end

this.SetPageInfo = function()
    local dailyTotalCount = this.isUpDungeon and ConfigMgr.Config.constants.DualBattleUpLimit or ConfigMgr.Config.constants.DualBattleDownLimit
    local dailyUseCount = this.isUpDungeon and MiniBattle3Mgr.GetUpDailyBattleCount() or MiniBattle3Mgr.GetDownDailyBattleCount()
    local str = this.isUpDungeon and LuaMgr.GetLangText("MiniBattle3BuffViewModel_4") or
            LuaMgr.GetLangText("MiniBattle3BuffViewModel_5")
    this.vm.data.dailyLeftCountStr = string.format(str, dailyTotalCount - dailyUseCount, dailyTotalCount)
    this.vm.data.showNoBuffTips = false
end

this.SwitchCurShowPage = function(showPage)
    if this.curShowPage == showPage then
        return
    end
    this.preLevelId = ""
    this.animName = "ani_MiniBattle3BuffPanel_BuffCardItem_001"
    this.SetCurShowPage(showPage)
    this.PlayAnim()
end

this.SetCurShowPage = function(type)
    this.curShowPage = type
    this.vm.data.showEnemyPage = false
    this.vm.data.showSelfPage = false
    this.vm.data.showDungeonRule = false
    this.vm.data.showEnemyLevelList = false
    this.vm.data.showBuffInfo = false
    if this.curShowPage == 1 then
        if this.isUpDungeon then
            this.OnChooseLevel(this.curLevelId)
            this.SetDungeonRuleInfo()
        else
            this.SetEnemyLevelListData()
            this.OnChooseLevel(this.curLevelId)
        end
        this.vm.data.startBtnText = LuaMgr.GetLangText("MiniBattle3BuffViewModel_6")
        this.vm.data.showEnemyPage = true
    elseif this.curShowPage == 2 then
        this.SetSelfBuffVMList()
        this.SetChooseBuffInfo(this.curShowBuffGroupId)
        this.vm.data.startBtnText = LuaMgr.GetLangText("MiniBattle3BuffViewModel_7")
        this.vm.data.showSelfPage = true
    end
end

this.SetDungeonRuleInfo = function()
    this.vm.data.showDungeonRule = true
    local ruleCfgs = ConfigMgr.Config.constants.DualLevelInfo
    local tempList = {}
    for i, v in ipairs(ruleCfgs) do
        table.insert(tempList, { rule = ConfigMgr.LangGlobal(v), anim = false })
    end
    this.vm.data.ruleList = tempList

    local levelCfg = ConfigMgr.Config.DualBattleBuffMap[this.curLevelId]
    local levelStatus = MiniBattle3Mgr.GetDungeonLevelRewardStatus(this.curLevelId)
    this.vm.data.ruleCoinPreviewStr = levelCfg.Coin
    if this.rewardList == nil then
        this.rewardList = {}
    end
    local itemCount = 0
    if not IsNull(levelCfg.Reward) then
        itemCount = #levelCfg.Reward
        local itemConfig = nil
        for i = 1, itemCount do
            if #this.rewardList < i then
                table.insert(this.rewardList, MiniBattle3BuffRewardItem.New(this.levelRewardListRect, this.GoodsItemTemplate))
            end
            itemConfig = table.Copy(ConfigMgr.Config.itemMap[levelCfg.Reward[i].id])
            itemConfig["count0"] = levelCfg.Reward[i].count
            local itemData = {
                index = i,
                itemConfig = itemConfig,
                status = levelStatus
            }
            this.rewardList[i]:SetData(itemData)
        end
    end
    for i = itemCount + 1, #this.rewardList do
        this.rewardList[i]:Hide()
    end
    this.vm.data.ruleRewardCanGet = MiniBattle3Mgr.CheckDungeonRewardRed(this.plotId)
end

this.SetEnemyLevelListData = function()
    this.enemyLevelList = {}
    local levelCfgs = ConfigMgr.Config.DualBattleBuffMap
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
            status = MiniBattle3Mgr.GetDungeonLevelRewardStatus(v),
            goodsItem = this.GoodsItemTemplate,
            animBool = false,
        }
        local unlockTime = MiniBattle3Mgr.GetDungeonLevelUnlockTime(v)
        levelData.isLock = curTime < unlockTime
        levelData.lockTips = os.date(LuaMgr.GetLangText("MiniBattle2BuffViewModel_1"), unlockTime)

        if levelData.isLock then
            if this.nextRefreshTime == 0 then
                this.nextRefreshTime = unlockTime
            else
                this.nextRefreshTime = math.min(this.nextRefreshTime, unlockTime)
            end
        end
        table.insert(this.enemyLevelList, levelData)
    end

    table.sort(this.enemyLevelList, function(a, b)
        return a.id < b.id
    end)
    this.vm.data.showEnemyLevelList = true
end

this.OnChooseLevel = function(levelId, isClick)
    local selectIndex = 1
    if MiniBattle3Mgr.CheckDungeonLevelIsUnLock(levelId) then
        this.curLevelId = levelId
        local levelCfg = ConfigMgr.Config.DualBattleBuffMap[this.curLevelId]
        this.vm.data.showLevelDifficultTips = levelCfg.Warning == 1
        selectIndex = this.GetSelectLevelItemIndex(this.curLevelId)
        if selectIndex < 5 then
            selectIndex = 1
        end
    end

    if this.vm.data.showEnemyLevelList then
        if isClick then
            this.enemyLevelScrollView:Refresh()
        else
            local scrollData, scrollDatas = {}, {}
            local groupData = nil
            local len = #this.enemyLevelList
            local index = 1
            while index <= len do
                groupData = this.enemyLevelList[index]
                scrollData = UIScrollData.GetData(this.EnemyLevelItemTemplate, "MiniBattle3EnemyLevelItem", 476, 75, groupData)
                table.insert(scrollDatas, scrollData)
                index = index + 1
            end
            this.enemyLevelScrollView:Clear(false)
            this.enemyLevelScrollView:SetPadding(0, 0, 0, 0)
            this.enemyLevelScrollView:SetParams(479, 344)
            this.enemyLevelScrollView:SetData(scrollDatas, true)
            this.enemyLevelScrollView:MoveToIndex(selectIndex)
        end
    end
    this.SetEnemyBuffVMList()
    this.PlayNewBuffUnlockEffect()
end

this.SetEnemyBuffVMList = function()
    local tempList = {}
    local allBuffList = MiniBattle3Mgr.GetDungeonAllEnemyBuff(this.plotId)
    for i, v in ipairs(allBuffList) do
        local buffInfo = MiniBattle3Mgr.GetBuffCardInfo(v)
        buffInfo.select_1 = false
        buffInfo.select_2 = false
        buffInfo.lock = not this.CheckEnemyBuffIsChoosed(v)
        buffInfo.unlockEffect = false
        buffInfo.animName = this.animName
        table.insert(tempList, buffInfo)
    end
    this.vm.data.enemyBuffVMList = tempList
    this.animName = ""
end

this.SetSelfBuffVMList = function()
    local tempList = {}
    local buffGroupCfgs = ConfigMgr.Config.DualBattleBuffLevelMap
    local chooseBuffCount = 0
    for k, v in pairs(buffGroupCfgs) do
        local level = MiniBattle3Mgr.GetBuffLevel(v.Id)
        local buffInfo = MiniBattle3Mgr.GetBuffCardInfo(v.GroupId[level])
        buffInfo.levelGroupId = v.Id
        buffInfo.select_1 = this.CheckSelfBuffIsChoosed(v.Id)
        buffInfo.select_2 = this.curShowBuffGroupId == v
        buffInfo.lock = false
        buffInfo.unlockEffect = false
        buffInfo.animName = this.animName
        table.insert(tempList, buffInfo)
        chooseBuffCount = chooseBuffCount + (buffInfo.select_1 and 1 or 0)
    end
    table.sort(tempList, function(a, b)
        return a.levelGroupId < b.levelGroupId
    end)
    this.vm.data.selfBuffVMList = tempList
    this.vm.data.selfBuffChooseLimit = string.format(LuaMgr.GetLangText("MiniBattle3BuffViewModel_1"), chooseBuffCount, this.plotCfg.SelfOptionLimit)

    LuaMgr.NextFrame(function()
        for i, v in ipairs(this.vm.data.selfBuffVMList) do
            v.animName = ""
        end
    end)
    this.animName = ""
end

this.PlayNewBuffUnlockEffect = function()
    if IsNullOrEmpty(this.preLevelId) or this.preLevelId == this.curLevelId then
        this.preLevelId = this.curLevelId
        return
    end
    local curLevelBuffs = ConfigMgr.Config.DualBattleBuffMap[this.curLevelId].BuffGroup
    local preLevelBuffs = ConfigMgr.Config.DualBattleBuffMap[this.preLevelId].BuffGroup
    local preLevelBuffMap = {}
    local newUnlockBuffMap = {}
    for i, v in ipairs(preLevelBuffs) do
        preLevelBuffMap[v] = true
    end
    for i, v in ipairs(curLevelBuffs) do
        if preLevelBuffMap[v] == nil then
            newUnlockBuffMap[v] = true
        end
    end

    if next(newUnlockBuffMap) ~= nil then
        for i, v in ipairs(this.vm.data.enemyBuffVMList) do
            if newUnlockBuffMap[v.id] and this.CheckEnemyBuffItemIsShow(i) then
                v.unlockEffect = true
            end
        end
    end
    this.preLevelId = this.curLevelId
end

this.CheckEnemyBuffItemIsShow = function(index)
    local scrollHeight = this.enemyBuffScrollView.sizeDelta.y
    local showMiny = this.enemuBuffContentRect.anchoredPosition.y + 10
    local showMaxy = showMiny + scrollHeight
    local itemMinY = 5 + math.floor((index - 1) / 4) * (164 + 3)
    local itemMaxY = itemMinY + 164
    return (itemMinY + 30) <= showMaxy and (itemMaxY - 70) >= showMiny
end

this.SetChooseBuffInfo = function(buffGroupId)
    if IsNullOrEmpty(buffGroupId) then
        buffGroupId = this.vm.data.selfBuffVMList[1].levelGroupId
    end
    this.curShowBuffGroupId = buffGroupId
    local buffGroupCfg = ConfigMgr.Config.DualBattleBuffLevelMap[buffGroupId]
    local maxLevel = #buffGroupCfg.GroupId
    local level = MiniBattle3Mgr.GetBuffLevel(buffGroupId)
    local buffInfo = MiniBattle3Mgr.GetBuffCardInfo(buffGroupCfg.GroupId[level])
    local isMax = level == maxLevel
    this.previewBuffId = isMax and "" or buffGroupCfg.GroupId[level + 1]
    this.vm.data.curShowBuffTexture = buffInfo.icon
    this.vm.data.curShowBuffName = buffInfo.name
    this.vm.data.curShowBuffDesc = buffInfo.desc
    this.vm.data.showBuffPreviewBtn = not isMax
    this.vm.data.showBuffUpGradeBtn = not isMax
    this.vm.data.showBuffChooseBtn_1 = not isMax
    this.vm.data.showBuffChooseBtn_2 = isMax
    if not isMax then
        local cost = ConfigMgr.Config.constants.DualBattleCoin
        local costCount = buffGroupCfg.Cost[level]
        local item = DataMgr.Player.items[cost]
        local itemCount = item ~= nil and item.count0 or 0;
        this.vm.data.buffUpGradeConsumeIcon = GetItemHomeIcon(cost)
        this.vm.data.buffUpGradeConsumeNum = string.format("<color=%s>%d</color>", itemCount >= costCount and "#c2b49d" or "#c31f36", costCount);
    end
    if this.CheckSelfBuffIsChoosed(this.curShowBuffGroupId) then
        this.vm.data.chooseBtnImage_1 = true
        this.vm.data.chooseBtnImage_2 = false
        this.vm.data.buffChooseBtnText = LuaMgr.GetLangText("MiniBattle3BuffViewModel_2")
    else
        this.vm.data.chooseBtnImage_1 = false
        this.vm.data.chooseBtnImage_2 = true
        this.vm.data.buffChooseBtnText = LuaMgr.GetLangText("MiniBattle3BuffViewModel_3")
    end

    local len = #this.vm.data.selfBuffVMList
    for i = 1, len do
        this.vm.data.selfBuffVMList[i].select_2 = this.vm.data.selfBuffVMList[i].levelGroupId == this.curShowBuffGroupId
    end
    this.vm.data.showBuffInfo = true
end

this.OnClickLevelItem = function(levelData)
    if levelData.isLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, levelData.lockTips)
    else
        if levelData.status == 0 then
            MiniBattle3Mgr.GetRewards(this.plotId, this.GetRewardsResponse)
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
        this.Refresh()
    end
end

this.ShowBuffCardDetails = function(cardId)
    LuaMgr.ShowLuaPanel(UIName.MiniBattle3BuffCardInfoPopup, cardId);
end

this.CheckSelfBuffIsChoosed = function(buffGroupId)
    for i, v in ipairs(this.selfChooseBuffLevelGroupIdList) do
        if v == buffGroupId then
            return true
        end
    end
    return false
end

this.CheckEnemyBuffIsChoosed = function(buffId)
    if IsNullOrEmpty(this.curLevelId) then
        return false
    end
    local levelCfg = ConfigMgr.Config.DualBattleBuffMap[this.curLevelId]
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
    local savedDataStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "_MiniBattle3NoSelfBuff", "");
    if savedDataStr == curDataStr then
        return false
    end
    this.noBuffTipsToggleIsOn = true
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

this.GetChooseBuffList = function()
    local chooseBuffList = {}
    for i, v in ipairs(this.selfChooseBuffLevelGroupIdList) do
        local buffId = MiniBattle3Mgr.GetBuffIdByLevelGroupId(v)
        if buffId ~= nil then
            table.insert(chooseBuffList, buffId)
        end
    end
    return chooseBuffList
end

this.PlayAnim = function()
    if this.curShowPage == 1 then
        if this.isUpDungeon then
            this.PlayAnim_DungeonRule()
        else
            this.PlayAnim_EnemyLevelList()
        end
    end
end

this.PlayAnim_DungeonRule = function()
end

this.PlayAnim_EnemyLevelList = function()
    local index = this.enemyLevelScrollView:GetIndex()
    LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffShowDelay)
    LuaMgr.AddTimer(TimerConst.MiniBattleNewBuffShowDelay, function()
        if this.enemyLevelScrollView.itemMap[index] ~= nil then
            SetActive(this.enemyLevelScrollView.itemMap[index].AnimatorObj, true)
            index = index + 1
        else
            for i = 1, #this.enemyLevelList do
                this.enemyLevelList[i].animBool = true
            end
            LuaMgr.RemoveTimer(TimerConst.MiniBattleNewBuffShowDelay)
        end
    end, 0.05, -1, true)
end

this.UpdateTimer = function()
    if this.nextRefreshTime <= 0 then
        return
    end
    local curTime = LuaMgr.Timestamp()
    if this.nextRefreshTime <= curTime then
        this.nextRefreshTime = 0
        this.Refresh()
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