local this = {
    vm = nil,
    data = {
buffCfgMap = {},
selectBuff = {},
        taskList = {},
        previewSelectBuffMap = {},
    },
}
local GRIDLINECOUNT = 3
local BUFFITEMCOLOR = UnityEngine.Color(1.0, 1.0, 1.0, 1);
local BUFFITEMCOLORHALFALPHA = UnityEngine.Color(1.0, 1.0, 1.0, 0.5);
local TASKLISTWIDTH = 293
local TASKLISTHEIGHT = 720
local MAXTASKLISTWIDTH = 350

local data = {
    taskSizeDelta = Vector2.zero,
    taskList = { { title = "", isConflict = false, isSelect = false, isFinished = false, animName = "", animIsLoop = false, buffList = {{id = "", icon = DefaultSprite, isShow = false}}}},
    taskAnchPos = Vector2.zero,
    ratingSprite = DefaultSprite,
    buffTagList = { { indexIcon = DefaultSprite, desc = "", animName = "", animIsLoop = false}},
    scoreNum_1 = DefaultSprite,
    scoreNum_2 = DefaultSprite,
    scoreNumActive_2 = false,

    buffItemGridDatas = { {isActive = false, isConflict = false, isSelect = false, isLock = false, icon = DefaultSprite, iconColor = BUFFITEMCOLOR,
                           leftLineActive = false, upLineActive = false, greenLineActive = false, blackLineActive = false}}, 
    delayShowTaskItemIndex = 1,
}

local command = {
    taskItemClickCommond = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            this.OnClickTaskItem(index)
        end
    },
    buffGridItemClickCommond = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            this.OnClickBuffGridItem(index)
        end
    },
    clearCommond = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.data.selectBuff = {}
            this.RefreshData()
        end
    },
    startCommond = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local curActivityEvent = nil
            local eventId = ""
            for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.area == ActivityKey.crisiscontract and v.type==2 then
                    eventId = v.id
                    curActivityEvent = ConfigMgr.Config.dungeonMap[v.eventParam]
                end
            end
            if curActivityEvent == nil then
                return
            end
            local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
            enterDungeonParams.eventId = eventId
            enterDungeonParams.dungeonId = curActivityEvent.id
            local extraList = {}
            table.insert(extraList, "crisiscontract")
            for k, v in pairs(this.data.selectBuff) do
                if not IsNullOrEmpty(v) then
                    if IsNullOrEmpty(this.data.buffCfgMap[v].BuffId) and not IsNullOrEmpty(this.data.buffCfgMap[v].BattleTurnEnd) then
                        enterDungeonParams.battleTurnEnd = this.data.buffCfgMap[v].BattleTurnEnd
                    end
                    table.insert(extraList, v)
                end
            end
            enterDungeonParams.extraParams = extraList
            BattlePrepareMgr.BattlePrepare(enterDungeonParams, {UIName.CrisisContractBuffViewModel})
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local addWidth = LuaMgr.GetScreenAddWidth()
        local taskListWidth = math.min(TASKLISTWIDTH + addWidth, MAXTASKLISTWIDTH)
        this.vm.data.taskSizeDelta = Vector2(taskListWidth, TASKLISTHEIGHT)
        this.InitData()
        this.RefreshData()
        
        this.vm.data.delayShowTaskItemIndex = 1
        LuaMgr.RemoveTimer(TimerConst.CrisisContractBuffTaskItemShow);
        LuaMgr.AddTimer(TimerConst.CrisisContractBuffTaskItemShow, this.DelayShowTaskItem, 0.1, -1, false)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.CrisisContractBuffTaskItemShow);
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.InitData = function()
this.InitTaskList()
this.InitBuffGrid()
end

this.RefreshData = function()
this.RefreshTaskList()
this.RefreshBuffTagList()
this.RefreshBuffGrid()
end

this.InitTaskList = function()
    this.data.buffCfgMap = {}
    local buffCfgList = ActivityMgr.GetActivityBuffList(ActivityKey.crisiscontract)
    for i, v in ipairs(buffCfgList) do
        this.data.buffCfgMap[v.Id] = v
    end
    local taskCfgList = {}
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByGroupId(2000);
    table.sort(cfgCheckInQuest,function(a,b) return tonumber(a.id)<tonumber(b.id); end)
    for i, v in ipairs(cfgCheckInQuest) do
        if v.eventType == 602 then
            table.insert(taskCfgList, v)
        end
    end
    
    this.data.taskList = {}
    for i,cfg in ipairs(taskCfgList) do
        local state=DataExHelper.Check_RewardState(cfg.id)
        local taskData = {
            id = cfg.id,
            title = "",
            isSelect = false,
            isConflict = false,
            isFinished = state == 2 or state == 3,
            animName = "ani_CrisisContractBuffPanel_Taskitem003",
            animIsLoop = true,
            buffList = {}
        }
        for i = 1, 3 do
            local buffItemData = { id = "", icon = DefaultSprite, isShow = false}
            local buffKey = cfg.conditionArgs[i]
            if cfg.conditionArgs ~= nil and buffKey ~= nil then
                local buffCfg = this.data.buffCfgMap[buffKey]
                if buffCfg ~= nil then
                    buffItemData.id = buffKey
                    buffItemData.icon = LuaMgr.GetSprite("BuffIcon", buffCfg.BuffIcon)
                    buffItemData.isShow = true
                end
            end
            table.insert(taskData.buffList, buffItemData)
        end
        table.insert(this.data.taskList, taskData)
    end
end

this.InitBuffGrid = function()
    this.vm.data.buffItemGridDatas = {}
    this.data.selectBuff = {}
    local buffConfigList = ActivityMgr.GetActivityBuffList(ActivityKey.crisiscontract)
    
    local maxRow = 0
    for i, v in ipairs(buffConfigList) do
        if v.Row > maxRow then
            maxRow = v.Row
        end
    end
    table.sort(buffConfigList, function(a, b)
        if a.Row ~= b.Row then
            return a.Row < b.Row
        end
        return a.BuffLevel < b.BuffLevel
    end)
    local totalItemCount = maxRow * GRIDLINECOUNT
    local itemIndex = 1
    local tempTable = {}
    for i = 1, totalItemCount do
        local buffCfg = buffConfigList[itemIndex]
        local buffItem = {isActive = false}
        if i == (buffCfg.Row - 1) * 3 + buffCfg.BuffLevel then
            buffItem = {
                isActive = true,
                id = buffCfg.Id,
                buffId = buffCfg.BuffId,
                row = buffCfg.Row,
                column = buffCfg.BuffLevel,
                group = buffCfg.BuffGroup,
                icon = LuaMgr.GetSprite("BuffIcon", buffCfg.BuffIcon),
                isSelect = false,
                isLock = not ActivityMgr.GetActivityBuffUnlock(ActivityKey.crisiscontract, buffCfg.Id),
                isConflict = false,
                leftLineActive = false,
                upLineActive = false,
                greenLineActive = false,
                blackLineActive = false,
                iconColor = BUFFITEMCOLOR,
            }

            if next(buffCfg.UnlockType) ~= nil and #buffCfg.UnlockType >= 2 then
                if buffCfg.UnlockType[1] == "1" then
                    local preconditionBuffCfg = this.data.buffCfgMap[buffCfg.UnlockType[2]]
                    buffItem.leftLineActive = preconditionBuffCfg.Row == buffItem.row
                    buffItem.upLineActive = preconditionBuffCfg.Row == buffItem.row - 1
                    buffItem.greenLineActive = not buffItem.isLock
                    buffItem.blackLineActive = buffItem.isLock
                end
            end
            itemIndex = itemIndex + 1
        end
        table.insert(tempTable, buffItem)
    end
    this.vm.data.buffItemGridDatas = tempTable
end

this.RefreshTaskList = function()
    local tempTaskList = {}
    for i, taskData in ipairs(this.data.taskList) do
        local isSelect, isConflict = true, false
        for j, buffData in ipairs(taskData.buffList) do
            if not IsNullOrEmpty(buffData.id) then
                local buffCfg = this.data.buffCfgMap[buffData.id]
                local selectBuffID = this.data.selectBuff[buffCfg.BuffGroup]
                if IsNullOrEmpty(selectBuffID) or selectBuffID ~= buffData.id then
                    isSelect = false
                end
                if (not IsNullOrEmpty(selectBuffID)) and selectBuffID ~= buffData.id then
                    isConflict = true
                end
            end
        end
        
        taskData.title = isSelect and LuaMgr.GetLangText("CrisisContractBuffViewModel_0") or LuaMgr.GetLangText("CrisisContractBuffViewModel_1")
        taskData.isSelect = isSelect
        taskData.isConflict = isConflict
        table.insert(tempTaskList, taskData)
    end
    table.sort(tempTaskList, this.TaskSort)
    this.data.taskList = tempTaskList
    this.vm.data.taskList = tempTaskList
    this.vm.data.taskAnchPos = Vector2.zero
end

this.RefreshBuffTagList = function()
    local tempTagList = {}
    local totalScore = 0
    for k, buffKey in pairs(this.data.selectBuff) do
        local buffCfg = this.data.buffCfgMap[buffKey]
        if buffCfg ~= nil then
            totalScore = totalScore + buffCfg.BuffLevel
            local animName = "ani_CrisisContractBuffPanel_BuffTagItem_002"
            if this.data.previewSelectBuffMap[buffKey] == nil then
                animName = "ani_CrisisContractBuffPanel_BuffTagItem_001"
            end
            table.insert(tempTagList, {indexIcon = ActivityMgr.GetCrisisContractNumSprite(buffCfg.BuffLevel), desc = LuaMgr.GetLangText(buffCfg.BuffDesLan), sort = k, animName = animName, animIsLoop = true })
        end
    end
    table.sort(tempTagList, function(a, b) return a.sort < b.sort end)
    this.vm.data.ratingSprite = ActivityMgr.GetCrisisContractRatingImg(totalScore, false)
    this.vm.data.buffTagList = tempTagList
    this.data.previewSelectBuffMap = {}
    for k, v in pairs(this.data.selectBuff) do
        this.data.previewSelectBuffMap[v] = 1
    end
    this.SetScore(totalScore)
end

this.RefreshBuffGrid = function()
    for i, buffData in ipairs(this.vm.data.buffItemGridDatas) do
        if buffData.isActive then
            local buffCfg = this.data.buffCfgMap[buffData.id]
            local selectBuffID = ""
            if buffCfg ~= nil then
                selectBuffID = this.data.selectBuff[buffCfg.BuffGroup]
            end
            buffData.isSelect = buffData.id == selectBuffID
            buffData.isConflict = false
            if not IsNullOrEmpty(selectBuffID) and not buffData.isLock then
                buffData.isConflict = buffData.id ~= selectBuffID
            end
            local isHalfAlpha = buffData.isSelect or buffData.isConflict or buffData.isLock
            buffData.iconColor = isHalfAlpha and BUFFITEMCOLORHALFALPHA or BUFFITEMCOLOR
        end
    end
end

this.DelayShowTaskItem = function()
    if this.vm.data.delayShowTaskItemIndex > #this.vm.data.taskList then
        LuaMgr.RemoveTimer(TimerConst.CrisisContractBuffTaskItemShow);
        return
    end
    this.data.taskList[this.vm.data.delayShowTaskItemIndex].animName = "ani_CrisisContractBuffPanel_Taskitem002"
    this.vm.data.taskList[this.vm.data.delayShowTaskItemIndex].animName = "ani_CrisisContractBuffPanel_Taskitem001"
    this.vm.data.delayShowTaskItemIndex = this.vm.data.delayShowTaskItemIndex + 1
end

this.OnClickTaskItem = function(taskIndex)
    local taskData = this.data.taskList[taskIndex]

    if taskData.isSelect then
        local tempRemoveBuff = {}
        for i, buffData in ipairs(taskData.buffList) do
            if not IsNullOrEmpty(buffData.id) then
                local buffCfg = this.data.buffCfgMap[buffData.id]
                tempRemoveBuff[buffCfg.BuffGroup] = true
            end
        end
        for i, v in ipairs(this.data.taskList) do
            if v.isSelect and v.id ~= taskData.id then
                for j, buffData in ipairs(v.buffList) do
                    if not IsNullOrEmpty(buffData.id) then
                        local buffCfg = this.data.buffCfgMap[buffData.id]
                        tempRemoveBuff[buffCfg.BuffGroup] = false
                    end
                end
            end
        end

        for k, v in pairs(tempRemoveBuff) do
            if v then
                this.data.selectBuff[k] = ""
            end
        end
    else
        local tempSelectBuff = {}
        local isLock = false
        for i, buffData in ipairs(taskData.buffList) do
            if not IsNullOrEmpty(buffData.id) then
                local buffCfg = this.data.buffCfgMap[buffData.id]
                tempSelectBuff[buffCfg.BuffGroup] = buffData.id
                if not ActivityMgr.GetActivityBuffUnlock(ActivityKey.crisiscontract, buffData.id) then
                    isLock = true
                end
            end
        end
        if isLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("17100"));
            return
        end
        for k, v in pairs(tempSelectBuff) do
            this.data.selectBuff[k] = v
        end
    end
    this.RefreshData()
end

this.OnClickBuffGridItem = function(index)
    local buffData = this.vm.data.buffItemGridDatas[index]
    if buffData.isLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("17101"));
        return
    end
    this.data.selectBuff[buffData.group] = buffData.id == this.data.selectBuff[buffData.group] and "" or buffData.id
    this.RefreshData()
end

this.TaskSort = function(a, b)
    if a.isFinished == b.isFinished then
        if a.isConflict == b.isConflict then
            if a.isSelect == b.isSelect then
                return tonumber(a.id)<tonumber(b.id)
            else
                return a.isSelect
            end
        else
            return not a.isConflict
        end
    else
        return not a.isFinished
    end
end

this.SetScore = function(score)
    if score < 10 then
        this.vm.data.scoreNum_1 = ActivityMgr.GetCrisisContractNumSprite(score)
        this.vm.data.scoreNumActive_2 = false
    else
        local num_1 = math.floor(score / 10)
        local num_2 = score - num_1 * 10
        this.vm.data.scoreNum_1 = ActivityMgr.GetCrisisContractNumSprite(num_1)
        this.vm.data.scoreNum_2 = ActivityMgr.GetCrisisContractNumSprite(num_2)
        this.vm.data.scoreNumActive_2 = true
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})