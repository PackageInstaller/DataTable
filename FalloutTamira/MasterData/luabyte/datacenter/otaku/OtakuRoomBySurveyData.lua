local M = BaseClass("OtakuRoomBySurveyData", require("DataCenter.Otaku.BaseOtakuRoomData"))
local MessageId = Proto.MessageId

function M:OnInit()
    self.m_allHeros = {}  -- 所有任务已上阵的队员 key:heroId, value:expMissionId
    self.m_taskDatas = {} -- 当前所有任务数据       [ExpeditionTask]
    self.m_expMissionDic = {}
    self.m_awardCallback = nil
end

function M:OnUpdate(netUpdateType)
end

function M:OnDestory()
    self.m_allHeros = nil
    self.m_taskDatas = nil
    self.m_fastCallback = nil
    self.m_expMissionDic = nil
    self.m_awardCallback = nil
    self.m_awardAllCallback = nil
    if self.m_rsRefreshExpMission then
        local refMsg = MessageId.ResponseRefreshExpMission
        NetPack:UnRegistResponse(refMsg, self.m_rsRefreshExpMission)
        self.m_rsRefreshExpMission = nil
    end
    if self.m_rsBeginExpMission then
        local messageId = MessageId.ResponseBeginExpMission
        NetPack:UnRegistResponse(messageId, self.m_rsBeginExpMission)
        self.m_rsBeginExpMission = nil
    end
    if self.m_rsAwardExpMission then
        local messageId = MessageId.ResponseAwardExpMission
        NetPack:UnRegistResponse(messageId, self.m_rsAwardExpMission)
        self.m_rsAwardExpMission = nil
    end
    if self.m_rsAwardAllExpMission then
        local messageId = MessageId.ResponseAwardExpMissionAll
        NetPack:UnRegistResponse(messageId, self.m_rsAwardAllExpMission)
        self.m_rsAwardAllExpMission = nil
    end
    if self.m_rsFastExpMission then
        local messageId = MessageId.ResponseExpMissionFast
        NetPack:UnRegistResponse(messageId, self.m_rsFastExpMission)
        self.m_rsFastExpMission = nil
    end
end

function M:GetExtraData()
    return self.m_taskDatas
end

function M:GetShowRewardData()
    local houseLevelCfgs = self:LevelConfig()
    local nextLevel = self:Level() + 1
    if nextLevel > self:MaxLevel() then return {} end
    local showReward = houseLevelCfgs[nextLevel].showReward
    local dict = {}
    for i = 1, #showReward do
        table.insert(dict, {
            itemId = showReward[i],
            numType = ItemNumberType.NONE,
            itemNum = 1
        })
    end
    return dict
end

-- 远征剩余时间
function M:ExpRemainTime()
    return self:EndTick() - GameUtil.GetCurTimeTick()
end

-- 是否完成 名字统一 方便调用
function M:IsEnd()
    return self:ExpRemainTime() <= 0
end

function M:GetIdleTasks()
    local cfgIds = {}
    for _, v in pairs(self.m_taskDatas) do
        local num = #(v.Heroes or {})
        local cfgId = v.ConfigId or 0
        if (num == 0) and (cfgId ~= 0) then table.insert(cfgIds, v.ConfigId) end
    end
    return cfgIds
end

-- 其它空闲任务的主要条件英雄id
function M:GetOtherBasicHeroDic(configId)
    local dic = {}
    for _, v in pairs(self:GetIdleTasks()) do
        if v ~= configId then
            local cfg = self:GetExpMission(v) or {}
            for _, id in ipairs(cfg.parameter1 or {}) do dic[id] = cfg.name end
        end
    end
    return dic
end

function M:UpdateExtraData(taskData)
    if not taskData then return end
    local expId = taskData.ConfigId
    if expId > 0 then
        local cfg = self.m_expMissionDic[expId]
        if not cfg then
            cfg = ConfigHelper.GetCfgByLua("expMission", expId)
            self.m_expMissionDic[expId] = cfg
        end
        if not cfg then Logger.LogError("expMission is nil , id = " .. expId) end
        self.m_taskDatas[taskData.Id] = taskData
        for _, heroId in ipairs(taskData.Heroes or {}) do
            self.m_allHeros[heroId] = expId -- 英雄ID->远征表ID
        end
    else
        -- 段：ConfigId > 0是新增，否则为删除
        self.m_taskDatas[taskData.Id] = nil
    end
end

-- 额外附加数据
function M:ExtraData(data)
    self.m_allHeros = {}
    self.m_taskDatas = {}
    self.m_expMissionDic = {}
    for _, task in pairs(data or {}) do
        self:UpdateExtraData(task)
    end
end

-- 请求开始远征
function M:RqBeginExpMission(id, heroIds, isUseFood)
    if self.m_rsBeginExpMission then return end

    local request = {
        ExpMissionId = id, --远征id
        Heroes = heroIds,  --选择的英雄id
        Foods = isUseFood,
    }
    local msgId = MessageId.ResponseBeginExpMission
    local handler = Bind(self, self.OnRsBeginExpMission)
    self.m_rsBeginExpMission = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(MessageId.RequestBeginExpMission, request)
end

-- 开始远征
function M:OnRsBeginExpMission(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsBeginExpMission)
    self.m_rsBeginExpMission = nil
    if result ~= 0 then return end

    local taskData = msg.ExpMissionTask
    self:UpdateExtraData(taskData)
    local expMission = self:GetExpMission(taskData.ConfigId) or {}
    local conditionA = SurveyHelper.CheckHeroCond(expMission.limit1, expMission.parameter1, taskData.Heroes)
    local conditionB = SurveyHelper.CheckHeroCond(expMission.limit2, expMission.parameter2, taskData.Heroes)
    --调查仓埋点
    EventMgr:Broadcast(UIMessageNames.EXPMISSION_UPDATE, taskData)
    -- local dataKey = { "task_id", "condition_a", "condition_b" }
    local dataValues = { tostring(taskData.ConfigId), tostring(conditionA), tostring(conditionB) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_intelligence, dataValues)
end

-- 远征完成，领取奖励
function M:RqAwardExpMission(expMissionId, callback)
    if self.m_rsAwardExpMission then return end

    self.m_awardCallback = callback
    local messageId = MessageId.ResponseAwardExpMission
    local handler = Bind(self, self.OnRsAwardExpMission)
    self.m_rsAwardExpMission = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(MessageId.RequestAwardExpMission, { ExpMissionId = expMissionId })
end

-- 领取远征奖励
function M:OnRsAwardExpMission(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsAwardExpMission)
    self.m_rsAwardExpMission = nil
    if result ~= 0 then return end

    local expId = msg.ExpMissionId
    local oldData = self.m_taskDatas[expId]
    for _, heroId in ipairs(oldData.Heroes or {}) do
        self.m_allHeros[heroId] = nil
    end
    self.m_expMissionDic[oldData.ConfigId] = nil
    local newData = msg.NewExpMission
    self:UpdateExtraData(newData)

    if self.m_awardCallback then
        self.m_awardCallback(oldData.Pos, newData)
        self.m_awardCallback = nil
    end

    -- 显示奖励
    self:_ShowAwards(msg.Awards or {}, oldData.EventId)

    --调查仓领取奖励埋点
    -- local dataKey = { "task_id" }
    local dataValues = { tostring(msg.ExpMissionId) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_intelligence_get, dataValues)
end

-- 请求刷新远征任务 刷新类型 (1 普通, 2 钻石)
function M:RsRefreshExpMission(refType)
    if self.m_rsRefreshExpMission then return end

    local msgId = MessageId.ResponseRefreshExpMission
    local handler = Bind(self, self.OnRsRefreshExpMission)
    self.m_rsRefreshExpMission = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(MessageId.RequestRefreshExpMission, {})
end

-- 刷新远征任务
function M:OnRsRefreshExpMission(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsRefreshExpMission)
    self.m_rsRefreshExpMission = nil
    if result ~= 0 then return end

    for _, newTask in ipairs(msg.Tasks or {}) do
        local oldData = self.m_taskDatas[newTask.Id]
        local oldPos = oldData and oldData.Pos or nil
        if oldData then self.m_expMissionDic[oldData.ConfigId] = nil end
        self:UpdateExtraData(newTask)
        EventMgr:Broadcast(UIMessageNames.EXPMISSION_REFRESH, oldPos, newTask)
    end
end

-- 远征任务一键领取
function M:RqAwardExpMissionAll(callback, ids)
    if self.m_rsAwardAllExpMission then return end
    self.ids = ids
    self.m_awardAllCallback = callback

    local msgId = MessageId.ResponseAwardExpMissionAll
    local handler = Bind(self, self.OnRsAwardExpMissionAll)
    self.m_rsAwardAllExpMission = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(MessageId.RequestAwardExpMissionAll, {})
end

--领取所有远征奖励
function M:OnRsAwardExpMissionAll(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsAwardAllExpMission)
    self.m_rsAwardAllExpMission = nil
    if result ~= 0 then return end

    for _, newTask in ipairs(msg.NewExpMission or {}) do
        local oldData = self.m_taskDatas[newTask.Id]
        for _, heroId in ipairs(oldData.Heroes or {}) do
            self.m_allHeros[heroId] = nil
        end
        self.m_expMissionDic[oldData.ConfigId] = nil
        self:UpdateExtraData(newTask)
        EventMgr:Broadcast(UIMessageNames.EXPMISSION_REFRESH, oldData.Pos, newTask)
    end

    if self.m_awardAllCallback then
        self.m_awardAllCallback()
        self.m_awardAllCallback = nil
    end

    self:_ShowAwards(msg.Awards or {}, 0)
    IRedPointMgr:ForceCheck(RedPointConst.WishjourneyRedPointChecker)

    --调查仓领取奖励埋点
    local taskId
    for k, v in pairs(self.ids) do
        if k == 1 then
            taskId = tostring(v)
        else
            taskId = taskId .. "," .. tostring(v)
        end
    end
    -- local dataKey = { "task_id" }
    local dataValues = { taskId }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_intelligence_get, dataValues)
end

-- 一键完成远征任务
function M:RqExpMissionFast(expMissionId, callback)
    if self.m_rsFastExpMission then return end

    self.m_fastCallback = callback

    local msgId = MessageId.ResponseExpMissionFast
    local handler = Bind(self, self.OnRsExpMissionFast)
    self.m_rsFastExpMission = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(MessageId.RequestExpMissionFast, { ExpMissionId = expMissionId })
end

function M:OnRsExpMissionFast(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsFastExpMission)
    self.m_rsFastExpMission = nil
    if result ~= 0 then return end

    local taskData = msg.Expedition
    self:UpdateExtraData(taskData)
    EventMgr:Broadcast(UIMessageNames.EXPMISSION_UPDATE, taskData)
    if self.m_fastCallback then
        self.m_fastCallback()
        self.m_fastCallback = nil
    end
end

-- 获取当前所有已上阵任务的队员
function M:GetAllHeros()
    return self.m_allHeros
end

function M:CheckCondition(limit, params)
    if not params or (#params == 0) then return false end
    if limit == 1 then -- 上阵x与y角色
        for _, heroId in ipairs(params) do
            if self.m_allHeros[heroId] then return false end
            if not IHeroDataMgr:GetMyHeroDataById(heroId) then return false end
        end
    elseif limit == 2 then -- 上阵等级为x的y角色
        local heroId = params[2]
        if self.m_allHeros[heroId] then return false end
        local hd = IHeroDataMgr:GetMyHeroDataById(heroId)
        if not hd or hd:GetLevel() < params[1] then return false end
    elseif limit == 3 then -- 上阵突破等级为x的y角色
        local heroId = params[2]
        if self.m_allHeros[heroId] then return false end
        local hd = IHeroDataMgr:GetMyHeroDataById(heroId)
        if not hd or hd:GetBreakLevel() < params[1] then return false end
    elseif limit == 4 then -- 上阵核心等级为x的y角色
        local heroId = params[2]
        if self.m_allHeros[heroId] then return false end
        local hd = IHeroDataMgr:GetMyHeroDataById(heroId)
        if not hd or hd:GetCoreLevel() < params[1] then return false end
    elseif limit == 5 then -- 上阵x名y级角色
        local heros = IHeroDataMgr:GetHeros()
        local count, num, value = 0, params[1], params[2]
        for i = 0, heros.Count - 1 do
            local hd = heros[i]
            if not self.m_allHeros[hd:GetHeroId()] then
                if hd:GetLevel() >= value then
                    count = count + 1
                    if count >= num then return true end
                end
            end
        end
        return false
    elseif limit == 6 then -- 上阵x名突破等级为y的角色
        local heros = IHeroDataMgr:GetHeros()
        local count, num, value = 0, params[1], params[2]
        for i = 0, heros.Count - 1 do
            local hd = heros[i]
            if not self.m_allHeros[hd:GetHeroId()] then
                if hd:GetBreakLevel() >= value then
                    count = count + 1
                    if count >= num then return true end
                end
            end
        end
        return false
    elseif limit == 7 then -- 上阵x名y职业角色
        local heros = IHeroDataMgr:GetHeros()
        local count, num, value = 0, params[1], params[2]
        for i = 0, heros.Count - 1 do
            local hd = heros[i]
            if not self.m_allHeros[hd:GetHeroId()] then
                if hd:GetProfession() == value then
                    count = count + 1
                    if count >= num then return true end
                end
            end
        end
        return false
    elseif limit == 8 then -- 上阵X名Y等级的Z职业角色
        local heros = IHeroDataMgr:GetHeros()
        local num, lv, prof, count = params[1], params[2], params[3], 0
        for i = 0, heros.Count - 1 do
            local hd = heros[i]
            if not self.m_allHeros[hd:GetHeroId()] then
                if (hd:GetLevel() >= lv) and (hd:GetProfession() == prof) then
                    count = count + 1
                    if count >= num then return true end
                end
            end
        end
        return false
    end
    return true
end

-- 是否有可刷新的普通任务
function M:IsRefreshNormal()
    for _, taskData in pairs(self.m_taskDatas) do
        local expId = taskData.ConfigId
        local isNormal = self:GetExpMission(expId).complement ~= 1
        if (taskData.EndTick <= 0) and isNormal then return true end
    end
    return false
end

-- 获取已完成的远征任务数量
function M:GetJourneyFinishNum()
    local overNum, curTime = 0, TimeUtil.GetNowTimeStamp()
    for _, taskData in pairs(self.m_taskDatas or {}) do
        local endTime = taskData.EndTick
        if (endTime > 0) and (curTime >= endTime) then
            overNum = overNum + 1
        end
    end
    return overNum
end

-- 获取已完成远征任务的Id
function M:GetFinishSurveyIds()
    local ids, curTime = {}, TimeUtil.GetNowTimeStamp()
    for _, taskData in pairs(self.m_taskDatas or {}) do
        local endTime = taskData.EndTick
        if (endTime > 0) and (curTime >= endTime) then
            table.insert(ids, taskData.Id)
        end
    end
    return ids
end

function M:GetExpMission(expId)
    local cfg = self.m_expMissionDic[expId]
    if not cfg then
        cfg = ConfigHelper.GetCfgByLua("expMission", expId)
        self.m_expMissionDic[expId] = cfg
    end
    if not cfg then Logger.LogError("expMission is nil , id = " .. expId) end
    return cfg
end

-- 显示远征奖励
function M:_ShowAwards(awards, eventId)
    if #awards > 0 then
        local items = {}
        for _, item in ipairs(awards) do
            local num = items[item.Id] or 0
            items[item.Id] = item.Cnt + num
        end
        GameHelper.ShowJourneyRewards(items, nil, eventId)
    else
        -- 奖励有可能为空
        GameHelper.TipsById(4148)
    end
    GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.ExpeditionTasksRewarded)
end

return M
