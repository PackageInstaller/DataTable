require("ViewModel/Activity/ActivityLimitCharacterTaskItem")
local this = {
    vm = nil,
    data = {
        taskList = {{
                        nameStr = "",
                        showReward = {id="1",count=tostring(0),isCount=true,sizeDelta=Vector2(0,0),rare=DefaultSprite,icon=DefaultTexture,scale=Vector3(0,0,0),isClick=true},
                        dynamicAvatarId = "",
                        isCanGet = false,
                        isFinish = false,
                        isProgress = false
                    }},
    },
    spineCharacter=nil,
    scrollView = nil,
    taskItemTemplate = nil,
    characterId=nil,
    expireTime = 0,
    curCardPoolId = "",

    curShowTaskIndex = 0,

    previewAvatarId = "",
    previewAvatarFrameId = "",
    previewBgId = "",
    previewPlayerInfoSkinId = "",
    redId = "16061"
}

local data = {
    bodyPath = "",

    curTaskLevel = "",
    curTaskRewardStr = "",

    leftTimeStr = "",


    progressStr = "",
    totalProgressStr = "",
    totalProgressSlider = 0.0,

    showTaskRewardPreview = false,
    rewardPreviewIcon = DefaultSprite,
    rewardPreviewName = "",
    rewardPreviewDesc = "",
    rewardPreviewCount = "",
    taskRewardPreviewGotoBtn = false,

    tipsStr = "",
    showRule = false,
}

local command = {
    HideTaskRewardPreviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetTaskRewardPreview(false)
        end
    },
    TaskRewardPreviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetTaskRewardPreview(false)
            if not IsNullOrEmpty(this.previewAvatarId) then
                LuaMgr.ShowLuaPanel(UIName.SettingAvatarFramedViewModel, 1, this.previewAvatarId);
            elseif not IsNullOrEmpty(this.previewAvatarFrameId) then
                LuaMgr.ShowLuaPanel(UIName.SettingAvatarFramedViewModel, 2, this.previewAvatarFrameId);
            elseif not IsNullOrEmpty(this.previewBgId) then
                LuaMgr.ShowLuaPanel(UIName.SelectCharacterViewModel, this.previewBgId);
                HeroParameter.SaveActivityKey(ActivityKey.LimitCharacterTwo)
            elseif not IsNullOrEmpty(this.previewPlayerInfoSkinId) then
                FriendChatMgr.FriendPersonalHome(DataMgr.Player.uid,function(data)
                    LuaMgr.ShowLuaPanel(UIName.FriendPlayerInfoViewModel, data, nil, this.previewPlayerInfoSkinId)
                end)
            end
        end
    },
    GotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.ShowCardPoolPanel(this.curCardPoolId);
        end
    },
    ShowRuleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showRule = true
        end
    },
    HideRuleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showRule = false
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm=vm
        this.spineCharacter = vm.behaviour.transform:Find("root/Middle/Bg/Character/Body"):GetComponent("UISpineCharacter")
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Right/TaskList/Scroll View").gameObject)
        this.taskItemTemplate = vm.behaviour.transform:Find("template/TaskItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.ParseData(true)
    end,
    before_deactive = function(vm)
        if this.spineCharacter~=nil then
            this.spineCharacter:Clear()
        end
        this.scrollView:Clear(true)
        LuaMgr.RemoveTimer(TimerConst.LimitCharacterActivityTimer)
        LuaMgr.RemoveTimer(TimerConst.LimitCharacterTaskShowTimer)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("ActivityLimitCharacterTaskItem")
    end
}

this.ParseData=function(Init)
    this.SetPageInfo()
    if Init then
        this.SetCharacter()
        this.SetTimer()
    end
    this.SetTaskList()
    this.SetCurTaskInfo()
    this.SetTaskRewardPreview(false)
end

this.SetPageInfo = function()
    for i,v in pairs(ConfigMgr.Config.activityGroup) do
        if v.key == ActivityKey.LimitCharacterTwo then
            this.curCardPoolId = v.IconPanel[1]
            break
        end
    end
    local variables=DataExHelper.GetDataExByTag(ActivityKey.LimitCharacterTwo)
    this.characterId = ConfigMgr.Config.cardPools[this.curCardPoolId].characterShow[1]
    this.expireTime = variables.expireTime

    local playerPrefsKey = string.format("%s%s%s", DataMgr.Player.uid, ActivityKey.LimitCharacterTwo, this.curCardPoolId)
    PlayerPrefs.SetInt(playerPrefsKey, 1)
end

this.SetCharacter=function()
    local skinId = this.characterId.."001"
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, this.characterId, skinId)
    if path ~= "" then
        this.vm.data.bodyPath=path
    end
end

this.SetTaskList = function()
    local characterId = this.characterId
    local cfgCharacter=ConfigMgr.Config.characterTable[characterId]
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByGroupId(ConfigHelper.GetActivityGroupIdByKey(ActivityKey.LimitCharacterTwo));
    table.sort(cfgCheckInQuest,function(a,b) return tonumber(a.id)<tonumber(b.id); end)
    local allCanGetTaskCount = 0
    local tempTaskList = {}
    for i,cfg in ipairs(cfgCheckInQuest) do
        local tempData = DataMgr.Player.quests[cfg.id]
        local state = DataExHelper.Check_RewardState(cfg.id)
        local rewardItem = cfg.showReward[1]
        local taskData = {
            id = cfg.id,
            nameStr = string.format("%s*%s", LuaMgr.GetLangText(cfgCharacter.namelan), i),
            isProgress = state == 1,
            isCanGet = state == 2,
            isFinish = state == 3,
            showReward = rewardItem,
            dynamicAvatarId = this.GetItemDynamicAvatarID(rewardItem.id),
            target = i,
            progress = tempData.progress,
            OnClickArea = this.OnShowTaskRewardPreview,
            OnClickGetBtn = this.OnGetTaskReward,
            hide = true,
        }
        if cfg.EventType == 801 then
            allCanGetTaskCount = taskData.isCanGet and allCanGetTaskCount + 1 or allCanGetTaskCount
            table.insert(tempTaskList, taskData)
        elseif cfg.EventType == 808 then
            local cardPoolCfg = ConfigMgr.Config.cardPools[this.curCardPoolId]
            this.vm.data.totalProgressStr = string.format(LuaMgr.GetLangText("ActivityLimitCharacterTwoViewModel_3"), LuaMgr.GetLangText(cardPoolCfg.nameLan), tempData.progress, cfg.progress)
        end
    end
    table.sort(tempTaskList, function(a, b)
        if a.isFinish == b.isFinish then
            if a.isCanGet == b.isCanGet then
                return tonumber(a.id)<tonumber(b.id)
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
        scrollData = UIScrollData.GetData(this.taskItemTemplate, "ActivityLimitCharacterTaskItem", 520, 80, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(520, 390)
    this.scrollView:SetData(scrollDatas, true)

    local index = this.scrollView:GetIndex()
    LuaMgr.AddTimer(TimerConst.LimitCharacterTaskShowTimer,function()
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
    end,0.05,-1,true)

    local listLength = #tempTaskList
    local curProgress = 0
    for i, v in ipairs(tempTaskList) do
        curProgress = v.progress > curProgress and v.progress or curProgress
    end
    this.vm.data.progressStr = string.format(LuaMgr.GetLangText("ActivityLimitCharacterTwoViewModel_0"), curProgress, listLength)
    this.vm.data.progressSlider = curProgress / listLength
    tempTaskList = {}
    RedMgr.Singleton:UpdateClientRedData(this.redId, allCanGetTaskCount)

    this.vm.data.tipsStr = ConfigMgr.LangGlobal("22501");
end

this.SetCurTaskInfo = function()
    local lastCanGetTaskIndex = 1
    local isAllFinish = true
    for i, v in ipairs(this.data.taskList) do
        if v.isCanGet then
            lastCanGetTaskIndex = i
        end
        if not v.isFinish then
            isAllFinish = false
        end
    end
    if isAllFinish then
        lastCanGetTaskIndex = #this.data.taskList
    end

    local taskData = this.data.taskList[lastCanGetTaskIndex]
    this.vm.data.curTaskLevel = taskData.target
    this.vm.data.curTaskRewardStr = LuaMgr.GetLangText(ConfigHelper.GetItemById(taskData.showReward.id).nameLan)
end

this.SetTimer=function()
    LuaMgr.RemoveTimer(TimerConst.LimitCharacterActivityTimer)
    LuaMgr.AddTimer(TimerConst.LimitCharacterActivityTimer, this.OnUpdate, 1, -1, true)
end

this.OnUpdate = function()
    local remainTime = this.expireTime - LuaMgr.Timestamp()
    local d, h, m, s = GetTimeDHMS2(remainTime)
    d = d <= 0 and "0" or tostring(d)
    h = h < 10 and "0" .. h or tostring(h)
    m = m < 10 and "0" .. m or tostring(m)
    s = s < 10 and "0" .. s or tostring(s)
    this.vm.data.leftTimeStr = string.format(LuaMgr.GetLangText("ActivityLimitCharacterTwoViewModel_1"),d,h,m,s)
end

this.SetTaskRewardPreview = function(isOn)
    if isOn then
        local taskData = this.data.taskList[this.curShowTaskIndex]
        this.vm.data.rewardPreviewIcon = LuaMgr.GetSprite("ActivityLimitCharacter", "ui_hd_dptq_mgkj_lb_2_0" .. taskData.target)
        local rewardItemId = taskData.showReward.id
        local rewardItemCfg = ConfigHelper.GetItemById(rewardItemId)
        if rewardItemCfg ~= nil then
            this.vm.data.rewardPreviewName = LuaMgr.GetLangText(rewardItemCfg.nameLan)
            this.vm.data.rewardPreviewDesc = LuaMgr.GetLangText(rewardItemCfg.DescriptionLan)
            this.vm.data.rewardPreviewCount = string.format(LuaMgr.GetLangText("ActivityLimitCharacterTwoViewModel_2"), DataHelper.GetItemCountById(rewardItemId))
        end

        this.vm.data.taskRewardPreviewGotoBtn = this.GetPreviewTypeAndId(rewardItemId)

    end
    this.vm.data.showTaskRewardPreview = isOn
end

this.GetPreviewTypeAndId = function(itemId)
    this.previewAvatarId = ""
    this.previewAvatarFrameId = ""
    this.previewBgId = ""
    this.previewPlayerInfoSkinId = ""
    local rewardItemCfg = ConfigHelper.GetItemById(itemId)
if rewardItemCfg.type ~= 13 then
        return false
    end





















    local bgSwitchMap = ConfigMgr.Config.BGSwitchMap;
    for k, v in pairs(bgSwitchMap) do
        if not IsNull(v.UnlockItem1) and #v.UnlockItem1 > 1 and v.UnlockItem1[1] == itemId then
            this.previewBgId = v.Id
            return true
        end
    end
    return false
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
    local askData={questId = pId}
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re=json.decode(result)
        local data=json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        this.ParseData()
    end,nil,true)
end

this.OnShowTaskRewardPreview = function(pIndex)
    this.curShowTaskIndex = pIndex
    this.SetTaskRewardPreview(true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})