local M = BaseClass("StoryDataMgr", Singleton)
local CheckStr = string.isNullOrEmpty
local CheckTbl = table.isNullOrEmpty
local MessageId = Proto.MessageId
local tInsert = table.insert

function M:__init()
    self.m_shieldMissions = ConfigHelper.GetSystemParams(327) -- 需要屏蔽的关卡
    self.m_voiceEndHandler = Bind(self, self._SetVoiceCompleteTimer)
    self.m_oriTextSpeed = ConfigHelper.GetSystemParam(231)    -- 剧情文字播放速度
    self.m_nextStoryHandler = Bind(self, self.NextStory)
    self.m_fastSpeedPower = StoryConst.FastSpeed[1]           -- 快进倍率
    self.m_curTextSpeed = self.m_oriTextSpeed
    self.m_tempVoiceIsEnd = false
    self.m_storyEndCallback = nil
    self.m_storyRwdCallback = nil
    self.m_allStoryGroupDic = nil -- 所有剧情组
    self.m_createRoleStory = nil  -- 创角那一步的配置数据
    self.m_curStoryGroup = nil    -- 当前剧情组，key：[story.stepId]
    self.m_isOpenStory = false    -- 是否已经打开Story界面
    self.m_isCreateRole = nil     -- 是否创建角色剧情组
    self.m_isVoiceEnd = false
    self.m_selectSteps = nil      -- 已点击的选项步骤
    self.m_reviewList = nil       -- 剧情回顾数据（storyId，nameIds，dialogueId）
    self.m_voiceTimer = nil
    self.m_curStory = nil         -- 当前正在播放的剧情
    self.m_timeMode = nil         -- 时间倍率模式
    self.m_isAuto = nil
    self.m_isFast = nil           -- 快进
    self.m_skipNum = 0            -- 剧情跳过计数
end

function M:Dispose()
    if self.m_rsRenameRole then
        NetPack:UnRegistResponse(MessageId.ResponseRenameRole, self.m_rsRenameRole)
        self.m_rsRenameRole = nil
    end
    if self.m_rsStoryReward then
        NetPack:UnRegistResponse(MessageId.ResponseStoryReward, self.m_rsStoryReward)
        self.m_rsStoryReward = nil
    end

    self.m_isAuto = nil
    self.m_isFast = nil
    self.m_skipNum = nil
    self.m_timeMode = nil
    self.m_curStory = nil
    self.m_isVoiceEnd = nil
    self.m_voiceTimer = nil
    self.m_reviewList = nil
    self.m_selectSteps = nil
    self.m_isOpenStory = nil
    self.m_curTextSpeed = nil
    self.m_oriTextSpeed = nil
    self.m_isCreateRole = nil
    self.m_curStoryGroup = nil
    self.m_tempVoiceIsEnd = nil
    self.m_shieldMissions = nil
    self.m_fastSpeedPower = nil
    self.m_createRoleStory = nil
    self.m_voiceEndHandler = nil
    self.m_nextStoryHandler = nil
    self.m_storyRwdCallback = nil
    self.m_allStoryGroupDic = nil
    self.m_storyEndCallback = nil
end

function M:Cleanup()
end

---------------------初始化数据Begin----------------------

function M:_InitStoryData()
    self.m_allStoryGroupDic = {}
    local storyType = StoryConst.StoryType.CreateRole
    for _, story in pairs(ConfigHelper.GetCfgs("story") or {}) do
        local groupId = story.groupId
        local group = self.m_allStoryGroupDic[groupId]
        if not group then
            group = {}
        end
        group[story.stepId] = story
        self.m_allStoryGroupDic[groupId] = group
        if story.storyType == storyType then
            self.m_createRoleStory = story
        end
    end
end

---------------------初始化数据End----------------------

function M:TriggerStoryByGroupIds(groupIds, missionId, triggerType, onCompleteCallback)
    if not table.arrayContains(self.m_shieldMissions, missionId) then
        local md = MissionDataMgr:GetInstance():GetMissionDataById(missionId)
        if md and not md:IsWordsMission() and md:IsWatchStory(triggerType) then
            return false
        end
    end
    local index = triggerType - 1
    local len = groupIds and groupIds.Length or 0
    if (len <= 0) or (missionId <= 0) or (len <= index) then
        return false
    end

    local groupId = groupIds[index]
    if groupId <= 0 then
        return false
    end
    self:_UpdateStoryStepGroup(groupId)
    local storyCfg = self:_GetStoryByGroupId(groupId)
    if not storyCfg then
        Logger.LogError("story is nil, 请 <color=yellow>@杜老师</color>, group = " .. tostring(groupId))
        return false
    end

    self:_SetStoryAction(storyCfg, onCompleteCallback)
    return true
end

-- 仅工具使用接口
function M:TriggerStoryByStoryId(storyId, onCompleteCallback)
    local storyCfg = ConfigHelper.GetCfg("story", storyId)
    if not storyCfg then
        return false
    end

    self:_UpdateStoryStepGroup(storyCfg.groupId)
    self:_SetStoryAction(storyCfg, onCompleteCallback)
    return true
end

function M:TriggerStoryByGroupId(groupId, missionId, onCompleteCallback)
    if groupId <= 0 then
        return false
    end
    self:_UpdateStoryStepGroup(groupId)
    local storyCfg = self:_GetStoryByGroupId(groupId)
    if not storyCfg then
        Logger.LogError("story is nil, 请 <color=yellow>@杜老师</color>, group = " .. tostring(groupId))
        return false
    end

    local isUnRepeat = storyCfg.typeParam == StoryConst.TypeParam.Unrepeatable
    local isPass = MissionDataMgr:GetInstance():IsMissionPassById(missionId)
    if isUnRepeat and isPass then
        return false
    end

    self:_SetStoryAction(storyCfg, onCompleteCallback)
    return true
end

function M:TriggerStoryByGroup(groupId, onCompleteCallback)
    if groupId <= 0 then
        return false
    end
    self:_UpdateStoryStepGroup(groupId)
    local storyCfg = self:_GetStoryByGroupId(groupId)
    if not storyCfg then
        Logger.LogError("story is nil, 请 <color=yellow>@杜老师</color>, group = " .. tostring(groupId))
        return false
    end

    self:_SetStoryAction(storyCfg, onCompleteCallback)
    return true
end

function M:CheckAndSendStoryReward(storyCfg, index, callback)
    if not CheckTbl(storyCfg.reward) or not CheckTbl(storyCfg.heroStoryId) then
        index = index - 1
        self:RequestStoryReward(storyCfg.id, index, callback)
    end
end

---------------------网络消息Begin----------------------

function M:RequestStoryReward(id, index, callback)
    if self.m_rsStoryReward then
        return
    end

    self.m_storyRwdCallback = callback

    local messageId = MessageId.ResponseStoryReward
    local handler = Bind(self, self.OnResponseStoryReward)
    self.m_rsStoryReward = NetPack:RegistResponse(messageId, handler)

    local request = { StoryId = id, StoryIndex = index }
    NetPack:SendMessage(MessageId.RequestStoryReward, request)
end

function M:OnResponseStoryReward(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsStoryReward)
    self.m_rsStoryReward = nil

    if result ~= 0 then
        if self.m_storyRwdCallback then
            self.m_storyRwdCallback()
            self.m_storyRwdCallback = nil
        end
        return
    end

    if not CheckTbl(msg.Data) then
        local items = {}
        for _, value in ipairs(msg.Data) do
            local num = items[value.Id] or 0
            items[value.Id] = num + value.Cnt
        end
        GameHelper.ItemTips(items, true)
    end
    if self.m_storyRwdCallback then
        self.m_storyRwdCallback()
        self.m_storyRwdCallback = nil
    end
end

function M:RequestRename(roleName, notGuide)
    if self.m_rsRenameRole then
        return
    end
    if notGuide == nil then
        notGuide = false
    end

    if roleName then
        local messageId = MessageId.ResponseRenameRole
        local handler = Bind(self, self.OnResponseRenameRole)
        self.m_rsRenameRole = NetPack:RegistResponse(messageId, handler)

        local request = { Type = notGuide, RoleName = roleName }
        NetPack:SendMessage(MessageId.RequestRenameRole, request)
    end
end

function M:OnResponseRenameRole(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsRenameRole)
    self.m_rsRenameRole = nil

    if result ~= 0 then
        return
    end

    EventMgr:Broadcast(UIMessageNames.CREATE_ACCOUNT_SUCCESS, msg.RoleName)
    local data = { msg.RoleName, INetPack.accountId }
    if not msg.Type then -- 起名
        IBuriedPointDataMgr:SubmitData(BuriedPointConst.CreateRole, data)
    else                 -- 改名字
        IBuriedPointDataMgr:SubmitData(BuriedPointConst.UpdateName, data)
    end
end

---------------------网络消息End----------------------

---------------------事件消息Begin--------------------

function M:NextStoryByIndex(index)
    self:_StopFastTimer()
    local nextStory = self:_GetNextStory(index)
    if nextStory then
        self.m_curStory = nextStory
        self:_RefreshStoryAction(nextStory)

        if self:IsStoryNextInFast() then
            local delay = self:GetDialogueShowTime()
            self.m_fastTimer = TimerManager:GetInstance():GetTimer(delay, self.m_nextStoryHandler, self, true, nil, true)
            self.m_fastTimer:Start()
        end
    else
        EventMgr:Broadcast(UIMessageNames.STORY_END)
        self.m_isAuto = false
        self.m_isFast = false
        self:_StopFastTimer()
    end
end

function M:NextStory()
    if self.m_curStory then
        self:NextStoryByIndex(1)
    end
end

function M:NextStoryDelay(delayTime)
    self:_StopNextStoryTimer()
    self.m_nextStoryTimer = TimerManager:GetInstance():GetTimer(delayTime, self.m_nextStoryHandler, self, true, nil, true)
    self.m_nextStoryTimer:Start()
end

function M:StartAuto()
    self.m_isAuto = true
    self.m_curTextSpeed = self.m_oriTextSpeed
    if self:_IsNextInAuto() then
        self:NextStory()
    end
end

function M:StopAuto()
    self.m_isAuto = false
    self:_StopVoiceCompleteTimer()
    -- self.m_isVoiceEnd = false
    -- self.m_tempVoiceIsEnd = false
end

function M:StartFast()
    self.m_isFast = true
    self.m_curTextSpeed = self.m_oriTextSpeed * self.m_fastSpeedPower

    -- IsGuide:guide模式自动和快进不生效，手动快进时跳过IsStoryNextInFast判断
    if self:IsStoryNextInFast() or self:IsGuide() then
        if not self.m_fastTimer then
            GameHelper.PlayAudioById(30208)
            self.m_isVoiceEnd = false
            local delay = self:GetDialogueShowTime()
            self.m_fastTimer = TimerManager:GetInstance():GetTimer(delay, self.m_nextStoryHandler, self, true, nil, true)
            self.m_fastTimer:Start()
        end
    end
end

function M:SetFastSpeedMultiplier()
    local speeds = StoryConst.FastSpeed
    local len = #speeds
    for i, value in ipairs(speeds) do
        if self.m_fastSpeedPower == value then
            if i ~= len then
                self.m_fastSpeedPower = speeds[i + 1]
            else
                self.m_fastSpeedPower = speeds[1]
            end
            break
        end
    end
    self.m_curTextSpeed = self.m_oriTextSpeed * self.m_fastSpeedPower
    return self.m_fastSpeedPower
end

function M:StopFast()
    self.m_isFast = false
    self.m_curTextSpeed = self.m_oriTextSpeed
    self:_StopFastTimer()
end

function M:_StopFastTimer()
    if self.m_fastTimer then
        self.m_fastTimer:Stop()
        self.m_fastTimer = nil
    end
end

function M:SkipStory()
    self:_SetSkipNum()
    self:_SetSkipStory()
    if self.m_curStory and not CheckTbl(self.m_curStory.nextStepId) and self.m_curStory.nextStepId[1] > 0 then
        self:_RefreshStoryAction(self.m_curStory)
    else
        self:FinishStory()
    end
end

---------------------事件消息End----------------------

---------------------设置数据Begin--------------------

function M:_UpdateStoryStepGroup(groupId)
    self.m_curStoryGroup = self:_GetStoryGroup(groupId)
    self.m_isCreateRole = self:IsCreateRoleGroup(groupId)
end

function M:_StopNextStoryTimer()
    if self.m_nextStoryTimer then
        self.m_nextStoryTimer:Stop()
        self.m_nextStoryTimer = nil
    end
end

function M:_ResetStory()
    self:_StopFastTimer()
    self:_StopNextStoryTimer()
    self:_StopVoiceCompleteTimer()
    self.m_skipNum = 0
    self.m_isAuto = false
    self.m_isFast = false
    self.m_curStory = nil
    self.m_reviewList = {}
    self.m_selectSteps = nil
    self.m_isCreateRole = nil
    self.m_isVoiceEnd = false
    self.m_isOpenStory = false
    self.m_curStoryGroup = nil
    self.m_tempVoiceIsEnd = false
    self.m_curTextSpeed = self.m_oriTextSpeed
    self.m_fastSpeedPower = StoryConst.FastSpeed[1]
end

function M:FinishStory()
    if self.m_isCreateRole then
        GameHelper.SendCreateRoleGameOverEvent()
    end

    if self.m_curStory then
        local groupId = self.m_curStory.groupId
        local pointId = self.m_curStory.pointId
        if pointId > 0 then
            IBuriedPointDataMgr:SubmitStoryData(groupId, self.m_skipNum, pointId)
        end
        if not PlayerPrefabHelper.HasKey(groupId, true) then
            PlayerPrefabHelper.SetInt(groupId, groupId)
        end

        local missionId = self.m_curStory.missionId
        if not table.arrayContains(self.m_shieldMissions, missionId) then
            local tgType = self.m_curStory.type
            local keyName = "TriggerMask" .. missionId
            local triggerMask = PlayerPrefTools.GetPlayerPrefsInt(keyName, 0)
            if tgType == StoryConst.TriggerType.AfterWar then
                local md = MissionDataMgr:GetInstance():GetMissionDataById(missionId)
                if md and not md:IsWordsMission() and not md:IsWatchStory(tgType) then
                    local config = md:ClientConfig() or {}
                    config.triggerMask = triggerMask | (1 << tgType)
                    if md:IsActivity() then
                        MissionDataMgr:GetInstance():NetSaveCopyMissionConfig(missionId, md:GetChapterId(), config)
                    else
                        MissionDataMgr:GetInstance():NetSaveMissionConfig(missionId, config)
                    end
                end
            elseif tgType == StoryConst.TriggerType.PreWar then
                if triggerMask == 0 then
                    PlayerPrefTools.SetPlayerPrefs(keyName, 1 << tgType)
                end
            end
        end
    end

    self:_ResetStory()
    ITimeMgr:ChangeTimeMode(self.m_timeMode or EnumConst.TimeMode.GameNormal)
    UIContextMgr:GetInstance():Close("StoryUI")
    ResourceManager:GetInstance():RemoveUnusedAssets()

    if self.m_storyEndCallback then
        self.m_storyEndCallback()
        self.m_storyEndCallback = nil
    end
end

function M:_SetStoryAction(storyCfg, onCompleteCallback)
    if storyCfg.type == StoryConst.TriggerType.AfterWar then
        GameHelper.StoryAfterWarEvent()
    end
    self.m_isAuto = false
    self.m_curStory = storyCfg
    self:_RefreshStoryAction(storyCfg)
    self.m_storyEndCallback = onCompleteCallback
    self.m_timeMode = ITimeMgr.modeInt
    local moduleId = IModuleMgr:GetCurModuleId()
    if moduleId == EnumConst.ModuleNotify.Battle then
        ITimeMgr:ChangeTimeMode(EnumConst.TimeMode.BattlePause)
    end
end

function M:_RefreshStoryAction(storyCfg)
    local storyType = storyCfg.storyType
    local EStoryType = StoryConst.StoryType
    if storyType == EStoryType.CreateRole then
        local nickName = IPlayerData.NickName
        if not CheckStr(nickName) and not string.startswith(nickName, "guest_") then
            self:NextStoryByIndex(1)
        else
            if not CheckTbl(storyCfg.nextStepId) then
                -- 创角在结尾
                if storyCfg.nextStepId[1] == 0 then
                    self:FinishStory()
                end
                --取名已经进入了结算阶段
                INetPack.gameNetState = CS.NetBase.EGameNetState.EGNS_Combat_Settlement
                UIContextMgr:GetInstance():Show("CreateAccountUI")
            end
        end
    elseif storyType == EStoryType.Timeline then
        UIContextMgr:GetInstance():Close("StoryUI")
        GameHelper.PlayTimelineAssetById(storyCfg.storyTypeParam, function()
            self:NextStoryByIndex(1)
        end, true)
    else
        if not self.m_isOpenStory then
            self.m_isOpenStory = true
            UIContextMgr:GetInstance():Show("StoryUI", storyCfg)
        else
            EventMgr:Broadcast(UIMessageNames.STORY_REFRESH, storyCfg)
        end
    end
end

function M:AddReviewStory(storyCfg, index)
    local storyId = storyCfg.id
    if not self:_ContainsReviewStory(storyId) then
        local cmderType = storyCfg.commanderType
        local rspType = StoryConst.ResponseType
        if (storyCfg.roleTalk > 0) or (cmderType == rspType.Selection) then
            if not self.m_reviewList then self.m_reviewList = {} end
            local nameIds = storyCfg.roleName
            local dialogueId = storyCfg.roleTalk
            local cmderTalk = storyCfg.commanderTalk
            if index and not CheckTbl(cmderTalk) then
                nameIds = { 481 }
                dialogueId = cmderTalk[index]
            end
            local review = { storyId = storyId, nameIds = nameIds, dialogueId = dialogueId }
            tInsert(self.m_reviewList, review)
        end
    end
end

function M:_SetSkipStory()
    local ECreateRole = StoryConst.StoryType.CreateRole
    local ESkipWay = StoryConst.SkipWay.On
    local isLoop = true
    while isLoop do
        if not self.m_curStory then return end
        self:CheckAndSendStoryReward(self.m_curStory, 1)
        local nextStepIds = self.m_curStory.nextStepId
        if nextStepIds then
            if nextStepIds[1] > 0 then
                local repeatStep = self.m_curStory.repeatStep
                local nextStep = (repeatStep > 0) and repeatStep or nextStepIds[1]
                local nextStory = self:_GetStoryByStepId(nextStep)
                -- 创角时停下
                if nextStory then
                    if (nextStory.storyType == ECreateRole) or (nextStory.skipWay == ESkipWay) then
                        isLoop = false
                    end
                end
                self.m_curStory = nextStory
            else
                isLoop = false
            end
        else
            isLoop = false
        end
    end
end

function M:AddRepeatSelect(storyCfg, index)
    if storyCfg.repeatStep <= 0 then
        return
    end

    local nextSteps = storyCfg.nextStepId
    local step = nextSteps[index]
    if CheckTbl(self.m_selectSteps) then
        self.m_selectSteps = {}
        tInsert(self.m_selectSteps, step)
    else
        if not table.contains(self.m_selectSteps, step) then
            tInsert(self.m_selectSteps, step)
        end
    end
end

function M:_SetSkipNum()
    self.m_skipNum = self.m_skipNum + 1
end

function M:SetVoiceComplete(isComplete, delay)
    if not delay or (delay == 0) then
        self.m_isVoiceEnd = isComplete
        return
    end
    self.m_tempVoiceIsEnd = isComplete
    self.m_voiceTimer = TimerManager:GetInstance():GetTimer(delay, self.m_voiceEndHandler, self, true, nil, true)
    self.m_voiceTimer:Start()
end

function M:_SetVoiceCompleteTimer()
    self.m_isVoiceEnd = self.m_tempVoiceIsEnd
end

function M:_StopVoiceCompleteTimer()
    if self.m_voiceTimer then
        self.m_voiceTimer:Stop()
        self.m_voiceTimer = nil
    end
end

---------------------设置数据End----------------------

---------------------获取数据Begin--------------------

function M:GetStoryId()
    if not self.m_curStory then return 0 end
    return self.m_curStory.id
end

-- 上一个剧情配置
function M:GetLastStory(storyCfg)
    local stepId = storyCfg.stepId
    for _, story in pairs(self.m_curStoryGroup or {}) do
        for _, step in ipairs(story.nextStepId or {}) do
            if stepId == step then
                return story
            end
        end
    end
    return nil
end

function M:GetStory()
    return self.m_curStory
end

function M:GetRepeatSelects()
    return self.m_selectSteps
end

function M:GetReviewStories()
    return self.m_reviewList
end

function M:GetSpeed()
    return self.m_curTextSpeed
end

function M:GetFastSpeedMultiplier()
    return self.m_fastSpeedPower
end

function M:_GetStoryByStepId(stepId)
    if not self.m_curStoryGroup then
        return nil
    end
    return self.m_curStoryGroup[stepId]
end

-- 剧情组配置第一步的数据
function M:_GetStoryByGroupId(groupId)
    local group = self:_GetStoryGroup(groupId)
    if not group then
        return nil
    end
    local firstStory = nil
    for stepId, story in pairs(group) do
        if firstStory then
            if stepId < firstStory.stepId then
                firstStory = story
            end
        else
            firstStory = story
        end
    end
    return firstStory
end

function M:_GetNextStory(index)
    local nextStepIds = self.m_curStory.nextStepId
    local stepId = nextStepIds and nextStepIds[index] or 0
    if stepId > 0 then
        local nextStoryCfg = self:_GetStoryByStepId(stepId)
        if nextStoryCfg then
            local repeatStep = nextStoryCfg.repeatStep -- 循环剧情
            if repeatStep > 0 and self:_IsRepeatEnd(nextStoryCfg) then
                nextStoryCfg = self:_GetStoryByStepId(repeatStep)
                self.m_selectSteps = nil
            end
        end
        return nextStoryCfg
    end
    return nil
end

function M:GetDialogueShowTime()
    local showTime = 0
    if self.m_curTextSpeed > 0 then
        local content = ConfigHelper.GetLocalStringByPlayerName(self.m_curStory.roleTalk)
        content = string.replaceRichText(content)
        local num = string.utf8len(content)
        showTime = num / self.m_curTextSpeed + 0.1
    end
    return showTime
end

function M:_GetStoryGroup(groupId)
    if not self.m_allStoryGroupDic then
        self:_InitStoryData()
    end
    return self.m_allStoryGroupDic[groupId]
end

---------------------获取数据End----------------------

---------------------数据判断Begin--------------------

function M:IsCrossBgStory(storyCfg)
    local lastStory = self:GetLastStory(storyCfg)
    if lastStory then
        local curRes, lastRes = storyCfg.res, lastStory.res
        return not CheckStr(lastRes) and not CheckStr(curRes) and (curRes ~= lastRes)
    end
    return false
end

-- 是否是创建角色关卡
function M:IsCreateRoleMission(missionId)
    if not self.m_allStoryGroupDic then self:_InitStoryData() end
    return self.m_createRoleStory and (self.m_createRoleStory.missionId == missionId) or false
end

-- 是否创建角色剧情组
function M:IsCreateRoleGroup(groupId)
    if not self.m_allStoryGroupDic then self:_InitStoryData() end
    local cr_story = self.m_createRoleStory
    if cr_story then
        local group = self:_GetStoryGroup(groupId)
        if group then
            local createId = cr_story.groupId
            if (createId > 0) and (groupId == createId) then
                local story = group[cr_story.stepId]
                return story and (story.id == cr_story.id) or false
            end
        end
    end
    return false
end

function M:_ContainsReviewStory(id)
    for _, story in ipairs(self.m_reviewList or {}) do
        if story.storyId == id then return true end
    end
    return false
end

function M:_IsRepeatEnd(storyCfg)
    local isEnd = false
    if not CheckTbl(self.m_selectSteps) then
        local rspType, cmderType = StoryConst.ResponseType, storyCfg.commanderType
        if (cmderType == rspType.Selection) or (cmderType == rspType.RoleEffect) or (cmderType == rspType.RoleMagnifier) then
            isEnd = #self.m_selectSteps == (#storyCfg.commanderTalk)
        elseif cmderType == rspType.BgEffect then
            isEnd = #self.m_selectSteps == (#storyCfg.commanderTalk / 2)
        end
    end
    return isEnd
end

function M:IsAsideOrNoVoiceInAuto()
    local story = self.m_curStory
    if not self.m_isAuto or not story or not (story.commanderType == StoryConst.ResponseType.None) then return false end
    return (story.roleTalk > 0) and CheckTbl(story.guide) and (CheckTbl(story.roleName) or (story.voice == 0))
end

function M:IsAsideOrNoVoice()
    local story = self.m_curStory
    if not story or not (story.commanderType == StoryConst.ResponseType.None) then return false end
    return (story.roleTalk > 0) and CheckTbl(story.guide) and (CheckTbl(story.roleName) or (story.voice == 0))
end

function M:_IsNextInAuto()
    local story = self.m_curStory
    if not story or not (story.commanderType == StoryConst.ResponseType.None) then return false end
    return self.m_isAuto and (story.roleTalk > 0) and CheckTbl(story.guide) and self.m_isVoiceEnd
end

-- 快进模式是否自动下一条剧情
function M:IsStoryNextInFast()
    local story = self.m_curStory
    if not self.m_isFast or not story then return false end
    if not (story.commanderType == StoryConst.ResponseType.None) then return false end
    -- 创角 或者 交互类型 时 roleTalk 应该为0 ，否则错误
    return (story.roleTalk > 0) and CheckTbl(story.commanderTalk) and CheckTbl(story.guide)
end

function M:IsGuide()
    local story = self.m_curStory
    return story and not CheckTbl(story.guide)
end

function M:IsAuto()
    return self.m_isAuto
end

function M:IsFast()
    return self.m_isFast
end

function M:IsAutoOrFast()
    return self.m_isAuto or self.m_isFast
end

function M:IsVoiceComplete()
    return self.m_isVoiceEnd
end

---------------------数据判断End----------------------

---------------------CmdResponse Begin---------------

function M:CmdResponseDialogue(storyCfg, index)
    self:AddReviewStory(storyCfg, index)
    self:CheckAndSendStoryReward(storyCfg, index)
    self:AddRepeatSelect(storyCfg, index)
    self:NextStoryByIndex(index)
end

function M:CmdResponseEffect(storyCfg, index)
    self:CheckAndSendStoryReward(storyCfg, index)
    self:AddRepeatSelect(storyCfg, index)
    self:NextStoryByIndex(index)
end

---------------------CmdResponse End-----------------

return M
