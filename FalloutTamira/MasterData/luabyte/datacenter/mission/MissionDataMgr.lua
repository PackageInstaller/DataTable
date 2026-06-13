--关卡数据管理器，继承自接口 IDataGetter
local M = BaseClass("MissionDataMgr", Singleton)

local mInsert = table.insert
local MessageId = Proto.MessageId
local EChapterType = ChapterConst.EChapterType
local CS_AllElite = CS.GameBase.JChapter.AllElite
local CS_AllNormal = CS.GameBase.JChapter.AllNormal

function M:__init()
    self:_InitData()

    local scoreHander = Bind(self, self.OnNotifyMissionScore)
    self.m_notityMissionScore = NetPack:RegistResponse(MessageId.NotifyMissionScore, scoreHander)

    local notifyHandler = Bind(self, self.OnNotifyUpdateChapter)
    self.m_rsUpdateChapter = NetPack:RegistResponse(MessageId.NotifyUpdateChapter, notifyHandler)

    local loadHandler = Bind(self, self.OnResponseLoadMission)
    self.m_rsLoadMission = NetPack:RegistResponse(MessageId.ResponseLoadMission, loadHandler)

    local resultHander = Bind(self, self.OnResponseBattleResult)
    self.m_rsBattleResult = NetPack:RegistResponse(MessageId.ResponseBattleResult, resultHander)

    local chapterHandler = Bind(self, self.OnResponseLoadChapter)
    self.m_rsLoadChapter = NetPack:RegistResponse(MessageId.ResponseLoadChapter, chapterHandler)

    local loadCopyHandler = Bind(self, self.OnResponseLoadCopyMission)
    self.m_rsLoadCopyMission = NetPack:RegistResponse(MessageId.ResponseLoadCopyMission, loadCopyHandler)

    self.m_uiVisble = Bind(self, self.OnUIVisbleEvent)
    self.m_levelUp = Bind(self, self.OnPlayerLevelUpEvent)
    self.m_saveHandler = Bind(self, self.OnResponseSaveMissionConfig)
    self.m_saveCopyMission = Bind(self, self.OnResponseSaveCopyMissionConfig)
    IGameEventMgr:RegisterEventHandleByTypeName("UIVisbleEvent", self.m_uiVisble)
    IGameEventMgr:RegisterEventHandleByTypeName("PlayerLevelUpEvent", self.m_levelUp)
end

--region IDataGetter
function M:LoadData()
    self._isLoading = true
    self._isReady = false
    self._errorCode = 0
    local req = {}
    req.Page = 1
    NetPack:SendMessage(MessageId.RequestLoadMission, req)
end

function M:IsLoading()
    return self._isLoading
end

function M:IsReady()
    return self._isReady
end

function M:ErrorCode()
    return self._errorCode
end

--regionend IDataGetter

function M:Cleanup()
    self._isReady = false
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseLoadMission, self.m_rsLoadMission)
    NetPack:UnRegistResponse(MessageId.ResponseLoadChapter, self.m_rsLoadChapter)
    NetPack:UnRegistResponse(MessageId.ResponseBattleResult, self.m_rsBattleResult)
    NetPack:UnRegistResponse(MessageId.NotifyUpdateChapter, self.m_rsUpdateChapter)
    NetPack:UnRegistResponse(MessageId.NotifyMissionScore, self.m_notityMissionScore)
    NetPack:UnRegistResponse(MessageId.ResponseLoadCopyMission, self.m_rsLoadCopyMission)

    NetPack:UnRegistResponse(MessageId.ResponseSweepBattle, self.m_rsSweepBattle)
    NetPack:UnRegistResponse(MessageId.ResponseChapterAward, self.m_rsChapterAward)
    NetPack:UnRegistResponse(MessageId.ResponseSaveMissionConfig, self.m_rsSaveConfig)
    NetPack:UnRegistResponse(MessageId.ResponseEnterEncounter, self.m_rsEnterEncounter)
    NetPack:UnRegistResponse(MessageId.ResponseGetWantedBattleInfo, self.m_rsWantedInfo)
    NetPack:UnRegistResponse(MessageId.ResponseActivitySweepBattle, self.m_rsCopySweepBattle)
    NetPack:UnRegistResponse(MessageId.ResponseSaveCopyMissionConfig, self.m_rsSaveCopyConfig)

    IGameEventMgr:UnRegisterEventHandleByTypeName("UIVisbleEvent", self.m_uiVisble)
    IGameEventMgr:UnRegisterEventHandleByTypeName("PlayerLevelUpEvent", self.m_levelUp)

    self.m_rsLoadMission = nil
    self.m_rsLoadChapter = nil
    self.m_rsBattleResult = nil
    self.m_rsUpdateChapter = nil
    self.m_rsLoadCopyMission = nil
    self.m_notityMissionScore = nil

    self.m_rsWantedInfo = nil
    self.m_rsSaveConfig = nil
    self.m_rsSweepBattle = nil
    self.m_rsChapterAward = nil
    self.m_rsEnterEncounter = nil
    self.m_rsSaveCopyConfig = nil
    self.m_rsCopySweepBattle = nil

    self.m_levelUp = nil
    self.m_uiVisble = nil
    self.m_doubleData = nil
    self.m_lastHardId = nil
    self.m_wantedCond = nil
    self.m_loadCopyDic = nil
    self.m_saveHandler = nil
    self.m_loadChapter = nil
    self.m_saveCallback = nil
    self.m_popupMission = nil
    self.m_sweepCallback = nil
    self.m_isloadingCopy = nil
    self.m_missionIdxDic = nil
    self.m_roleChapterDic = nil
    self.m_roleMissionDic = nil
    self.m_missionDataDic = nil
    self.m_wantedCallback = nil
    self.m_saveCopyMission = nil
    self.m_resTeachMission = nil
    self.m_isloadingChapter = nil
    self.m_dailyRefreshTime = nil
    self.m_saveCopyCallback = nil
    self.m_cptAwardCallback = nil
    self.m_copySweepCallback = nil
end

function M:_InitMissionDatas()
    if not self.m_missionDataDic then
        self.m_missionDataDic = {}
        local missionCfgs = ConfigHelper.GetCfgs("mission")
        local MissionData = require("DataCenter.Mission.MissionData")
        for i = 0, missionCfgs.Length - 1 do
            local cfg = missionCfgs[i]
            self.m_missionDataDic[cfg.id] = MissionData.New(cfg)
        end
    end
end

function M:_InitData()
    self.m_lastHardId = 0   -- 最新困难关卡ID
    self.m_loadCopyDic = {} -- 已请求数据的活动副本
    self.m_loadChapter = nil
    self.m_popupMission = nil
    self.m_roleMissionDic = {} -- 所有通关数据字典
    self.m_missionDataDic = nil
    self.m_roleChapterDic = nil

    self.m_isloadingCopy = false
    self.m_isloadingChapter = false
end

function M:OnResponseLoadMission(_, result, msg)
    --self._isLoading = false
    self._isReady = true
    self._errorCode = result

    if result ~= 0 then return end

    for _, roleMission in ipairs(msg.Data or {}) do
        self:_UpdateRoleMission(roleMission)
    end
    local totalPage = math.ceil(msg.Total / msg.Count)
    -- 分页加载
    if msg.Page < totalPage then
        local req = {}
        req.Page = msg.Page + 1
        NetPack:SendMessage(MessageId.RequestLoadMission, req)
        return
    end
    local ids = ActivityDataMgr:GetInstance():GetActivityChapterIds()
    if #ids > 0 then NetPack:SendMessage(MessageId.RequestLoadCopyMission, { ChapterIds = ids }) end
end

--副本关卡加载完成
function M:OnResponseLoadCopyMission(_, result, msg)
    self.m_isloadingCopy = false
    self._isReady = true
    if result ~= 0 then return end

    for _, roleMission in ipairs(msg.Data or {}) do
        self:_UpdateRoleMission(roleMission)
    end
    for _, cptId in ipairs(msg.ChapterIds or {}) do
        if cptId > 0 then
            -- 防止每次调用都发送请求协议
            if not self.m_loadCopyDic[cptId] then self.m_loadCopyDic[cptId] = cptId end
            if self.m_loadChapter then
                local callbackList = self.m_loadChapter[cptId]
                for _, callback in ipairs(callbackList or {}) do
                    if callback then callback() end
                end
                self.m_loadChapter[cptId] = nil
            end
        end
    end
end

function M:OnNotifyMissionScore(_, result, msg)
    if result ~= 0 then return end

    self:_UpdateRoleMission(msg.Data)
end

function M:_UpdateRoleMission(roleMission)
    local missionId = roleMission.MissionId
    local md = self:GetMissionDataById(missionId)
    if md then
        if md:IsMain() then -- 只更新主线关卡
            self:_UpdateNewMainMissionId(roleMission, md:GetChapter())
        elseif md:IsHard() then
            self:_UpdateLastHardMissionId(roleMission, md:GetChapter())
        elseif md:IsResource() then
            GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.ResLevelFinish)
        end
        md:Update(roleMission)
    else
        Logger.LogError("mission is null, @四叶看看, id = " .. missionId)
    end
    self:_InsertRoleMission(roleMission)
end

function M:_GetMissionIndexDic(chapter)
    if not self.m_missionIdxDic then self.m_missionIdxDic = {} end
    local dic = self.m_missionIdxDic[chapter.id]
    if not dic then
        dic = {}
        local stages = chapter.stages
        for i = 0, stages.Length - 1, 1 do dic[stages[i]] = i end
        self.m_missionIdxDic[chapter.id] = dic
    end
    return dic
end

-- 更新新的主线关卡
function M:_UpdateNewMainMissionId(roleMission, chapter)
    if roleMission.Count == 1 then
        local missionId = roleMission.MissionId
        local md = self:GetMissionDataById(missionId)
        local id, isNewMission = IPlayerData.missionId, false
        if id > 0 then
            local oldRoleMission = self.m_roleMissionDic[id]
            if oldRoleMission then
                local passTime = roleMission.FirstTick or 0
                if oldRoleMission.FirstTick < passTime then
                    isNewMission = true
                elseif oldRoleMission.FirstTick == passTime then -- 命令通关容错
                    if md and not md:IsBranch() then             -- 非分支关卡
                        local chapter2 = self:GetChapterByMissionId(id) or {}
                        if chapter2.id == chapter.id then
                            local idxDic = self:_GetMissionIndexDic(chapter)
                            if idxDic[id] < idxDic[missionId] then isNewMission = true end
                        else
                            if chapter2.number < chapter.number then isNewMission = true end
                        end
                    end
                end
            end
        else
            isNewMission = true
        end

        if isNewMission then
            if md and not md:IsBranch() then IPlayerData:SetMissionId(missionId) end
            GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.MainLevelFinish)
        end
    end
end

-- 更新最新精英关卡进度ID
function M:_UpdateLastHardMissionId(roleMission, chapter)
    local id = self.m_lastHardId
    local missionId = roleMission.MissionId
    if (id == 0) or (id == missionId) then
        self.m_lastHardId = missionId
    else
        local passTime = roleMission.FirstTick or 0
        local oldRoleMission = self.m_roleMissionDic[id]
        if oldRoleMission then
            local md = self:GetMissionDataById(missionId)
            if md and not md:IsBranch() then    -- 非分支关卡
                local prePassTime = oldRoleMission.FirstTick or 0
                if prePassTime == passTime then -- [命令通关]时间有可能一样
                    local chapter2 = self:GetChapterByMissionId(id) or {}
                    if chapter.id == chapter2.id then
                        local idxDic = self:_GetMissionIndexDic(chapter)
                        if idxDic[missionId] > idxDic[id] then -- 相同章节选索引大的
                            self.m_lastHardId = missionId
                        end
                    elseif chapter.number > chapter2.number then -- 不同章节选number大的
                        self.m_lastHardId = missionId
                    end
                elseif passTime > prePassTime then -- 不同时间戳选数字大的
                    self.m_lastHardId = missionId
                end
            end
        end
    end
    GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.EliteLevelFinish)
end

function M:OnResponseBattleResult(_, result, msg)
    if result ~= 0 then return end
    TeamConfMgr:GetInstance():SetFriendHeroData(IPlayerData.GetActiveTeamId)
    local missionId = msg.MissionId
    local md = self:GetMissionDataById(missionId)
    if not md or md:IsMain() then return end -- 主线关卡不计入

    local roleMission = self.m_roleMissionDic[missionId]
    if roleMission then roleMission.Star = msg.Star end -- 不是新关卡
end

-- 进入遭遇战
function M:OnResponseEnterEncounter(teams, encounteData)
    local data = encounteData
    --周期结束，
    local isSettlement, wordchange = data:IsLastCycleSettlement()
    local cycleCallback = function()
        if wordchange then
            if wordchange then
                UIContextMgr:GetInstance():Show("EncounterSeasonOpen", data:GetDifficulty(), data:GetCycleId(),
                    function()
                        UIContextMgr:GetInstance():Show("EncounteMainUI", data)
                    end)
                return
            end
            UIContextMgr:GetInstance():Show("EncounteMainUI", data)
        else
            local fightingIdx = EncounterConfMgr:GetInstance():GetCurZoneIdx()
            if fightingIdx > 0 and self._fromBattle and self._isWin then
                UIContextMgr:GetInstance():Show("EncounterStageUI", encounteData, fightingIdx, self._fromBattle)
            else
                UIContextMgr:GetInstance():Show("EncounteMainUI", data)
            end
            self._fromBattle = false
        end
    end

    if isSettlement and data:GetLastDifficulty() < data:GetDifficulty() then
        UIContextMgr:GetInstance():Show("EncounterCycleSettlement", data:GetLastCycleId(),
            data:GetLastDifficulty(), data:GetCycleId(), data:GetDifficulty(), cycleCallback)
    else
        cycleCallback()
    end
end

function M:OnResponseLoadChapter(_, result, msg)
    self.m_isloadingChapter = false
    if result ~= 0 then
        self.m_loadChapter[EChapterType.ECT_None] = nil
        return
    end

    if not self.m_roleChapterDic then self.m_roleChapterDic = {} end
    for _, v in ipairs(msg.data) do self.m_roleChapterDic[v.ChapterId] = v end
    if self.m_loadChapter then
        local callbackList = self.m_loadChapter[EChapterType.ECT_None] --只处理为0的
        for _, callback in ipairs(callbackList or {}) do
            if callback then callback() end
        end
        self.m_loadChapter[EChapterType.ECT_None] = nil
    end
end

function M:OnNotifyUpdateChapter(_, result, msg)
    if result ~= 0 then return end

    local roleChapter = msg.data
    if not self.m_roleChapterDic then self.m_roleChapterDic = {} end
    self.m_roleChapterDic[roleChapter.ChapterId] = roleChapter
end

function M:GetChapterAward(request, callback)
    if self.m_rsChapterAward then return end

    self.m_cptAwardCallback = callback
    local msgId = MessageId.ResponseChapterAward
    local handler = Bind(self, self.OnResponseChapterAward)
    self.m_rsChapterAward = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(MessageId.RequestChapterAward, request)
end

-- 小于255为星级奖励，否则章节奖励
function M:OnResponseChapterAward(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsChapterAward)
    self.m_rsChapterAward = nil
    if result ~= 0 then return end

    if msg.Idx == 255 then
        self.m_roleChapterDic[msg.ChapterId].Status = 1
    end

    if self.m_cptAwardCallback then
        self.m_cptAwardCallback(msg)
        self.m_cptAwardCallback = nil
    end
end

-- 章节星级宝箱奖励是否可领取
function M:_GetChapterStarRewardStatus(chapter)
    local starLimit = chapter and chapter.starLimit or nil
    if not starLimit then return false end

    local roleChapter = self:GetRoleChapter(chapter.id)
    if not roleChapter then return false end

    local starNum = self:GetChapterTotalStars(chapter.id)
    for i = 0, starLimit.Length - 1, 1 do
        local status = ((roleChapter.AwardFlag >> i) & 1) == 0 -- true:没领 false：领过
        if status and (starNum >= starLimit[i]) then return true end
    end

    return false
end

function M:_InsertRoleMission(roleMission)
    local missionId = roleMission.MissionId
    self.m_roleMissionDic[missionId] = roleMission
end

function M:IsMissionPassById(missionId)
    if missionId <= 0 then return false end
    local missionData = self:GetMissionDataById(missionId)
    return missionData and missionData:IsPass() or false
end

function M:IsMissionPass(mission)
    if not mission then return false end
    return self:IsMissionPassById(mission.id)
end

function M:GetPassCountById(missionId)
    if missionId <= 0 then return 0 end
    local missionData = self:GetMissionDataById(missionId)
    return missionData and missionData:GetPassCount() or 0
end

-- 章节是否通关
function M:IsPassedChapter(chapterId)
    local chapter = ConfigHelper.GetCfg("chapter", chapterId)
    if chapter then
        for id, _ in pairs(self:_GetMissionIndexDic(chapter) or {}) do
            local md = self:GetMissionDataById(id)
            if not md or not md:IsPass() then return false end
        end
        return true
    else
        Logger.LogError("chapter is nil. @四叶看看, id = " .. chapterId)
    end

    return false
end

function M:GetMissionDataById(id)
    if id <= 0 then return nil end
    self:_InitMissionDatas()
    return self.m_missionDataDic[id]
end

function M:GetNextMissionData()
    local missionId = IPlayerData.missionId
    if missionId <= 0 then
        missionId = GameHelper.GetParamter(101)
        return self:GetMissionDataById(missionId)
    else
        local md = self:GetMissionDataById(missionId)
        if md then
            local nextId = md:GetNextMissionId()
            return self:GetMissionDataById(nextId)
        else
            Logger.LogError("mission is nil. @四叶看看, id = " .. missionId)
        end
        return nil
    end
end

function M:GetNextMissionId()
    local nextData = self:GetNextMissionData()
    return nextData and nextData:GetMissionId() or 0
end

-- 后置分支关卡数组数据(排除主关卡)
function M:GetNextMissionsArry(missiodId)
    local md = self:GetMissionDataById(missiodId)
    local postArr = md and md:GetNextMissions() or nil
    if not postArr then return nil end
    local mds = {}
    for i = 0, postArr.Length - 1 do
        mInsert(mds, self:GetMissionDataById(postArr[i].id))
    end
    return mds
end

-- 最新通关的精英副本id
function M:GetLastHardMissionId()
    if self.m_lastHardId == 0 then return GameHelper.GetParamters(101)[1] end
    return self.m_lastHardId
end

-- 获取章节进度
function M:GetChapterProgress(chapter)
    local LinkMission = chapter.LinkMission
    if not chapter or IsNull(LinkMission) then return 0 end

    local PassNum, node = 0, LinkMission.First
    while node do
        if self:IsMissionPass(node.Value) then PassNum = PassNum + 1 end
        node = node.Next
    end

    return PassNum / LinkMission.Count
end

function M:GetChapterTotalStars(chapterId)
    local stars, chapter = 0, ConfigHelper.GetCfg("chapter", chapterId)
    if chapter then
        local md, posts
        for id, _ in pairs(self:_GetMissionIndexDic(chapter) or {}) do
            md = self:GetMissionDataById(id)
            if md then
                stars, posts = stars + md:GetStar(), md:GetPostStage()
                for i = 0, (posts and posts.Length or 0) - 1 do
                    md = self:GetMissionDataById(posts[i])
                    if md and md:IsBranch() then stars = stars + md:GetStar() end -- 分支关卡星级
                end
            end
        end
    else
        Logger.LogError("chapter is nil. @四叶看看, id = " .. chapterId)
    end

    return stars
end

function M:GetMissionStar(missionId)
    local md = self:GetMissionDataById(missionId)
    return md and md:GetStar() or 0
end

-- 打开遭遇战界面,isWin 只有在从战斗中进入才有效
function M:OpenEncountPanel(fromBattle, isWin)
    if fromBattle == nil then
        fromBattle = false
    end
    self._isWin = isWin
    self._fromBattle = fromBattle
    local openCfg = ConfigHelper.GetCfgByLua("functionOpen", 27) or {}
    local conditionLst = GameHelper.GetLockConditions(openCfg.openCondition)
    if #conditionLst > 0 then
        local cfg = ConfigHelper.GetCfgByLua("openCondition", conditionLst[1])
        if cfg then
            GameHelper.TipsById(cfg.tips)
        else
            Logger.LogError("openCondition is nil, @四叶看看, id = " .. conditionLst[1])
        end
        return false
    end

    -- if self.m_rsEnterEncounter then
    --      return
    -- end
    self._OnResponseEnterEncounterHandler = self._OnResponseEnterEncounterHandler or
        Bind(self, self.OnResponseEnterEncounter)
    EncounterConfMgr:GetInstance():LoadData(self._OnResponseEnterEncounterHandler)
end

function M:GetRoleChapter(chapterId)
    if not self.m_roleChapterDic then return nil end
    return self.m_roleChapterDic[chapterId]
end

function M:GetChapterByMissionId(missionId)
    local md = self:GetMissionDataById(missionId)
    return md and md:GetChapter() or nil
end

function M:LoadChapter(chapterId, action)
    --常规加载模式
    if not chapterId then chapterId = 0 end
    if (self.m_roleChapterDic and chapterId == 0) or self.m_loadCopyDic[chapterId] then
        if action then action() end
        return
    end
    if not self.m_loadChapter then self.m_loadChapter = {} end
    local callbacklist = self.m_loadChapter[chapterId] or {}
    if not table.indexof(callbacklist, action) then mInsert(callbacklist, action) end
    self.m_loadChapter[chapterId] = callbacklist
    if chapterId == 0 then
        --同一时间如果请求过多，则放在table中缓存
        if self.m_isloadingChapter then return end
        self.m_isloadingChapter = true
        NetPack:SendMessage(MessageId.RequestLoadChapter, {})
    else
        local chapterCfg = ConfigHelper.GetCfg("chapter", chapterId)
        if not chapterCfg then
            GameHelper.Tips("章节类型ID错误:" .. chapterId)
            return
        end
        if chapterCfg.type == EChapterType.ECT_Activity then
            if self.m_isloadingCopy then return end
            self.m_isloadingCopy = true
            NetPack:SendMessage(MessageId.RequestLoadCopyMission, { ChapterIds = { chapterId } })
        else
            if self.m_isloadingChapter then return end
            self.m_isloadingChapter = true
            NetPack:SendMessage(MessageId.RequestLoadChapter, {})
        end
    end
end

-- 是否可领章节奖励， 0为所有章节(主线，精英)，1为主线章节，2为精英章节，其他为章节id
function M:IsRoleChapterReward(chapterId)
    if not chapterId then chapterId = 0 end

    local idlist, isTotal = {}, chapterId == 0
    if isTotal or (chapterId == 1) then
        local chapters = CS_AllNormal()
        for i = 0, chapters.Length - 1, 1 do mInsert(idlist, chapters[i].id) end
    end
    if isTotal or (chapterId == 2) then
        local chapters = CS_AllElite()
        for i = 0, chapters.Length - 1, 1 do mInsert(idlist, chapters[i].id) end
    end
    if chapterId > 2 then mInsert(idlist, chapterId) end

    for _, cptId in ipairs(idlist) do
        local roleChapter = self:GetRoleChapter(cptId)
        local isPass = self:IsPassedChapter(cptId)
        local status = roleChapter and (roleChapter.Status == 0) or false
        if isPass and status then return true end
    end

    return false
end

-- 星级宝箱  0为所有章节 1为主线 2为精英 其余则为章节id
function M:IsRoleChapterStarReward(chapterId)
    if not chapterId then chapterId = 0 end

    if chapterId > 10 then
        local chapter = ConfigHelper.GetCfgByLua("chapter", chapterId)
        return self:_GetChapterStarRewardStatus(chapter)
    end

    if chapterId == 0 or chapterId == EChapterType.ECT_Main then
        local chapters = CS_AllNormal()
        for i = 0, chapters.Length - 1, 1 do
            if self:_GetChapterStarRewardStatus(chapters[i]) then return true end
        end
    end

    if chapterId == 0 or chapterId == EChapterType.ECT_Elite then
        local chapters = CS_AllElite()
        for i = 0, chapters.Length - 1, 1 do
            if self:_GetChapterStarRewardStatus(chapters[i]) then return true end
        end
    end

    return false
end

-- 悬赏详情
function M:GetWantedBattleInfo(activityId, callback)
    if self.m_rsWantedInfo then return end

    self.m_wantedCallback = callback
    local msgId = MessageId.ResponseGetWantedBattleInfo
    local infoHandler = Bind(self, self.OnRsGetWantedBattleInfo)
    self.m_rsWantedInfo = NetPack:RegistResponse(msgId, infoHandler)
    NetPack:SendMessage(MessageId.RequestGetWantedBattleInfo, { ActivityId = activityId })
end

function M:OnRsGetWantedBattleInfo(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsWantedInfo)
    self.m_rsWantedInfo = nil

    if result ~= 0 then return end

    if self.m_wantedCallback then
        self.m_wantedCallback(msg.Level, msg.Exp, msg.Rewarded, msg.Missions)
        self.m_wantedCallback = nil
    end
end

-- 是否是资源教学关卡
function M:IsResTeachMission(missionId)
    if missionId <= 0 then return false end
    if not self.m_resTeachMission then
        self.m_resTeachMission = CS.GameX.GameGlobal.resTeachMission
    end
    return missionId == self.m_resTeachMission
end

function M:NetSaveMissionConfig(missionId, config, callback)
    if self.m_rsSaveConfig then return end

    self.m_saveCallback = callback
    local msgId = MessageId.ResponseSaveMissionConfig
    self.m_rsSaveConfig = NetPack:RegistResponse(msgId, self.m_saveHandler)
    local request = { MissionId = missionId, Config = Json.encode(config) }
    NetPack:SendMessage(MessageId.RequestSaveMissionConfig, request)
end

function M:OnResponseSaveMissionConfig(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsSaveConfig)
    self.m_rsSaveConfig = nil
    if result ~= 0 then return end

    local md = self:GetMissionDataById(msg.MissionId)
    if md then md:UpdateClientConfig(msg.Config) end

    if self.m_saveCallback then
        self.m_saveCallback()
        self.m_saveCallback = nil
    end
end

function M:NetSaveCopyMissionConfig(missionId, chapterId, config, callback)
    if self.m_rsSaveCopyConfig then return end

    self.m_saveCopyCallback = callback
    local msgId = MessageId.ResponseSaveCopyMissionConfig
    self.m_rsSaveCopyConfig = NetPack:RegistResponse(msgId, self.m_saveCopyMission)
    local request = { ChapterId = chapterId, MissionId = missionId, Config = Json.encode(config) }
    NetPack:SendMessage(MessageId.RequestSaveCopyMissionConfig, request)
end

function M:OnResponseSaveCopyMissionConfig(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsSaveCopyConfig)
    self.m_rsSaveCopyConfig = nil
    if result ~= 0 then return end

    local md = self:GetMissionDataById(msg.MissionId)
    if md then md:UpdateClientConfig(msg.Config) end

    if self.m_saveCopyCallback then
        self.m_saveCopyCallback()
        self.m_saveCopyCallback = nil
    end
end

-- 普通副本扫荡
function M:ReqSweepBattle(nRequest, callback)
    if self.m_rsSweepBattle then return end
    self.Times = nRequest.Times
    IPlayerData.enterBattle_EXP = IPlayerData.Exp
    IPlayerData.enterBattle_Level = IPlayerData.level
    self.m_sweepCallback = callback
    local msgId = MessageId.ResponseSweepBattle
    local handler = Bind(self, self.OnRspSweepBattle)
    self.m_rsSweepBattle = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(MessageId.RequestSweepBattle, nRequest)
end

function M:OnRspSweepBattle(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsSweepBattle)
    self.m_rsSweepBattle = nil
    if result ~= 0 then return end

    local md = self:GetMissionDataById(msg.MissionId)
    if md then md:UpdateLastData() end
    IPlayerData.SetMopExp = md and md:EnergyCost() or 0

    if self.m_sweepCallback then
        self.m_sweepCallback(msg.Items, msg.TotalExp)
        self.m_sweepCallback = nil
    end
    --扫荡埋点
    local stageId = 0
    if md and md:GetMissionCfg() then
        stageId = md:GetMissionCfg().Stage.id
    end
    local dataValues = { stageId, self.Times }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.BattleSweep, dataValues)
end

-- 活动副本扫荡
function M:ReqCopySweepBattle(nRequest, callback)
    if self.m_rsCopySweepBattle then return end
    self.Times = nRequest.Times
    IPlayerData.enterBattle_EXP = IPlayerData.Exp
    IPlayerData.enterBattle_Level = IPlayerData.level
    self.m_copySweepCallback = callback
    local msgId = MessageId.ResponseActivitySweepBattle
    local handler = Bind(self, self.OnRspCopySweepBattle)
    self.m_rsCopySweepBattle = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(MessageId.RequestActivitySweepBattle, nRequest)
end

function M:OnRspCopySweepBattle(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsCopySweepBattle)
    self.m_rsCopySweepBattle = nil
    if result ~= 0 then return end

    local md = self:GetMissionDataById(msg.MissionId)
    if md then md:UpdateLastData() end
    IPlayerData.SetMopExp = md and md:EnergyCost() or 0

    if self.m_copySweepCallback then
        self.m_copySweepCallback(msg.Items, msg.TotalExp)
        self.m_copySweepCallback = nil
    end

    --扫荡埋点
    local stageId = 0
    if md and md:GetMissionCfg() then
        stageId = md:GetMissionCfg().Stage.id
    end
    local dataValues = { stageId, self.Times }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.BattleSweep, dataValues)
end

-- 显示关卡战后弹窗
function M:ShowPostMissionPopup()
    if self.m_popupMission then
        UIContextMgr:GetInstance():Show("FunctionLinkPopup", self.m_popupMission, Bind(self, self.ShowLoadingChapter))
        self.m_popupMission = nil
    else
        self:ShowLoadingChapter()
    end
end

function M:ShowLoadingChapter()
    local md = self:GetMissionDataById(IPlayerData.missionId)
    if md and md:IsMain() and md:IsTail() then
        local keyName = "chapter" .. md:GetChapterId()
        if PlayerPrefTools.GetPlayerPrefsInt(keyName) ~= 1 then
            UIContextMgr:GetInstance():Show("LoadingChapter", md:GetChapter())
        end
    end
end

-- 是否解锁扫荡
function M:IsUnlockMopup(missionId)
    local md = self:GetMissionDataById(missionId)
    return md and md:IsUnlockSweep() or false
end

-- 记录战斗的关卡
function M:PostMissionRecord(mission, isMop, battletype)
    if isMop or not mission then return end

    if battletype == EnumConst.EBattleStyle.Normal then
        if string.isNullOrEmpty(mission.jumpPicture) then return end

        local keyName = "PopupMission" .. tostring(mission.id)
        if PlayerPrefTools.GetPlayerPrefsInt(keyName, 0) == 0 then
            self.m_popupMission = mission
        end
    end
end

-- -- 关卡双倍数据
function M:GetDoubleData()
    if not self.m_doubleData then
        local data = require("DataCenter.Mission.MissionDoubleData")
        self.m_doubleData = data.New()
    end
    return self.m_doubleData
end

-- UI显示
function M:OnUIVisbleEvent(evt)
    local context = UIContextMgr:GetInstance():GetContext("HomeLevelUp")
    if context then context:LevelUpShow(evt) end
end

-- 升级事件
function M:OnPlayerLevelUpEvent(reslut)
    local context = UIContextMgr:GetInstance():GetContext("HomeLevelUp")
    if context then context:PlayerLevelUp(reslut) end
end

--根据章节Id获取关卡数据
function M:GetMissionDatasByChapterId(chapterId)
    local datas = {}
    for key, value in pairs(self.m_missionDataDic) do
        if value:GetChapterId() == chapterId then
            table.insert(datas, value:GetMissionCfg())
        end
    end
    return datas
end

return M
