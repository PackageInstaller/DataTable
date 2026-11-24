require("ViewModel/Draw/GiftCharacterTaskNewItem")
local this = {
    vm = nil,
    data = {
        taskList = { {
                         nameStr = "",
                         showReward = { id = "1", count = tostring(0), isCount = true, sizeDelta = Vector2(0, 0), rare = DefaultSprite, icon = DefaultTexture, scale = Vector3(0, 0, 0), isClick = true },
                         dynamicAvatarId = "",
                         isCanGet = false,
                         isFinish = false,
                         isProgress = false
                     } },
    },
    scrollView = nil,
    taskItemTemplate = nil,
    characterId = nil,
    curCardPoolId = "",
    redId = "16843"
}

local data = {
    totalProgressStr = "",
    totalProgressSlider = 0.0,
    progressTipsStr = "",
    tipsStr = "",
}

local command = {
    MaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.GiftCharacter14Popup);
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/TaskList/Scroll View").gameObject)
        this.taskItemTemplate = vm.behaviour.transform:Find("template/TaskItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.curCardPoolId = vm.behaviour.Params[0]
        this.characterId = ConfigMgr.Config.cardPools[this.curCardPoolId].characterShow[1]
        this.ParseData(true)
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true)
        UIScrollView.ClearItem("GiftCharacterTaskNewItem")
        LuaMgr.RemoveTimer(TimerConst.LimitCharacterTaskShowTimer)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("GiftCharacterTaskNewItem")
    end
}

this.ParseData = function(Init)
    this.SetTaskList()
end

this.SetTaskList = function()
    local characterId = this.characterId
    local cfgCharacter = ConfigMgr.Config.characterTable[characterId]
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByGroupId(ConfigHelper.GetActivityGroupIdByKey(ActivityKey.GiftCharacter14));
    table.sort(cfgCheckInQuest, function(a, b)
        return tonumber(a.id) < tonumber(b.id);
    end)
    local allCanGetTaskCount = 0
    local tempTaskList = {}
    for i, cfg in ipairs(cfgCheckInQuest) do
        local tempData = DataMgr.Player.quests[cfg.id]
        local progressValue = 0
        if tempData ~= nil then
            progressValue = tempData.progress
        end
        local state = DataExHelper.Check_RewardState(cfg.id)
        local taskData = {
            id = cfg.id,
            nameStr = string.format("%s*%s", LuaMgr.GetLangText(cfgCharacter.namelan), cfg.progress),
            isProgress = state == 1,
            isCanGet = state == 2,
            isFinish = state == 3,
            target = cfg.progress,
            progress = progressValue,
            OnClickArea = this.OnShowTaskRewardPreview,
            OnClickGetBtn = this.OnGetTaskReward,
            hide = true,
        }
        if cfg.eventType == 801 then
            allCanGetTaskCount = taskData.isCanGet and allCanGetTaskCount + 1 or allCanGetTaskCount
            taskData.dynamicAvatarId = this.GetItemDynamicAvatarID(cfg.showReward[1].id)
            taskData.showReward = cfg.showReward
            table.insert(tempTaskList, taskData)
        elseif cfg.eventType == 808 then
            local cardPoolCfg = ConfigMgr.Config.cardPools[this.curCardPoolId]
            this.vm.data.totalProgressStr = string.format(LuaMgr.GetLangText("GiftCharacter4Popup_0"),
                    LuaMgr.GetLangText(cardPoolCfg.nameLan), progressValue, cfg.progress)
            this.vm.data.totalProgressSlider = progressValue / cfg.progress
        end
    end
    table.sort(tempTaskList, function(a, b)
        if a.isFinish == b.isFinish then
            if a.isCanGet == b.isCanGet then
                return tonumber(a.id) < tonumber(b.id)
            else
                return a.isCanGet
            end
        else
            return not a.isFinish
        end
    end)
    this.data.taskList = tempTaskList

    local groupData
    local scrollData
    this.scrollView:Clear(false)
    local scrollDatas = {}
    for i, v in ipairs(this.data.taskList) do
        groupData = v
        groupData.index = i
        scrollData = UIScrollData.GetData(this.taskItemTemplate, "GiftCharacterTaskNewItem", 520, 80, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(500, 300)
    this.scrollView:SetData(scrollDatas, true)

    local index = this.scrollView:GetIndex()
    LuaMgr.AddTimer(TimerConst.LimitCharacterTaskShowTimer, function()
        if this.scrollView.itemMap[index] ~= nil then
            this.scrollView.itemMap[index]:PlayAnim("ActivityLimitCharacterTaskItem")
        end
        if this.scrollView.dataList[index] ~= nil then
            this.scrollView.dataList[index].data.hide = false
        end
        index = index + 1
        if index > #this.scrollView.dataList then
            LuaMgr.RemoveTimer(TimerConst.LimitCharacterTaskShowTimer)
        end
    end, 0.05, -1, true)
    RedMgr.Singleton:UpdateClientRedData(this.redId, allCanGetTaskCount)
    this.vm.data.progressTipsStr = ConfigMgr.LangGlobal("25701");
    this.vm.data.tipsStr = ConfigMgr.LangGlobal("26526");
end

this.GetItemDynamicAvatarID = function(pItemId)
    local rewardItemCfg = ConfigHelper.GetItemById(pItemId)
    if rewardItemCfg.type ~= 13 then

        return ""
    end
    if nil ~= ConfigMgr.Config.avatarFrames then
        for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
            if v.type == 1 and v.imgType == 2 and v.unlockType == 2 and v.unlock == pItemId then
                return v.id
            end
        end
    end
    return ""
end

this.OnGetTaskReward = function(pId)
    local askData = { questId = pId }
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        this.ParseData()
        LuaMgr.InvokeUIEventListeners(UIEventConst.GiftCharacterGetReward)
    end, nil, true)
end

this.OnShowTaskRewardPreview = function(pIndex)



end

return vm({
    data = data,
    command = command,
    hook = hook
})