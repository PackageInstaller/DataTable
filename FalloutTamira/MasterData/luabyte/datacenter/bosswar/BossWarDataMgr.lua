local M = BaseClass("BossWarDataMgr", Singleton)
local BossWarData = require("DataCenter.BossWar.BossWarData")
local MessageId = Proto.MessageId

function M:__init()
    self.m_bossWarCond = nil   -- Boss战开放条件
    self.m_level = 0           -- boss难度等级
    self.m_bossDatas = {}      -- BossWarData数据
    self.m_weekWordDic = {}    -- 本周词条
    self.m_nextRefreshTick = 0 -- 下次刷新时间
    self.m_timeHandler = Bind(self, self.OnTimeOut)
end

function M:Dispose()
    if self.m_rsBossWarInfo then
        local messageId = MessageId.ResponseBossBattleInfo
        NetPack:UnRegistResponse(messageId, self.m_rsBossWarInfo)
        self.m_rsBossWarInfo = nil
    end
    if self.m_rsFirstChests then
        local messageId = MessageId.ResponseBossBattleFirstChests
        NetPack:UnRegistResponse(messageId, self.m_rsFirstChests)
        self.m_rsFirstChests = nil
    end
    if self.m_rsCycleChests then
        local messageId = MessageId.ResponseBossBattleChests
        NetPack:UnRegistResponse(messageId, self.m_rsCycleChests)
        self.m_rsCycleChests = nil
    end

    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    self.m_bossDatas = nil
    self.m_timeHandler = nil
    self.m_weekWordDic = nil
    self.m_bossWarCond = nil
    self.m_infoCallback = nil
    self.m_firstCallback = nil
    self.m_cycleCallback = nil
end

---------------------IDataGetter Begin-----------------
--用于在登录的时候初始化相关数据
function M:LoadData()
    self._errorCode = 0
    if self:LockId() > 0 then
        self._isloading = false
        self._dataLoaded = true
    else
        self._isloading = true
        self._dataLoaded = false
        self:ReqBossBattleInfo()
    end
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

---------------------IDataGetter End-------------------

function M:_SortWords(words)
    table.sort(words, function(a, b)
        if a.maptype == b.maptype then
            return a.id < b.id           -- 2. bossMapcondition表id 小到大
        else
            return a.maptype < b.maptype -- 1. bossMapcondition表maptype 小到大
        end
    end)
end

function M:_CleanUpWriteWords()
    local stamp = TimeUtil.GetTimeStamp(5)
    if stamp ~= PlayerPrefTools.GetPlayerPrefsInt("BossWordsRefresh", -1) then
        for _, data in ipairs(self:GetBossDatas() or {}) do
            for _, cfg in pairs(data:GetWordDic()) do
                data:UpdateWords(cfg) --取消
            end
        end
        PlayerPrefTools.SetPlayerPrefs("BossWordsRefresh", stamp)
    end
end

function M:_StartTimer()
    self:_CleanUpWriteWords()
    if self.m_timer then self.m_timer:Stop() end
    local second = TimeUtil.GetRefreshInterval(5)
    self.m_timer = TimerManager:GetInstance():GetTimer(second + 1, self.m_timeHandler, self, true)
    self.m_timer:Start()
end

function M:OnTimeOut()
    self:_StartTimer()
    EventMgr:Broadcast(UIMessageNames.BOSS_WORDS_REFRESH)
end

-- 进入Boss战前先 请求boss战信息
function M:ReqBossBattleInfo(callback)
    if self.m_rsBossWarInfo then
        self._isloading = false
        self._dataLoaded = true
        return
    end

    local id = self:LockId()
    if id > 0 then
        local openCondition = ConfigHelper.GetCfgByLua("openCondition", id)
        if openCondition then
            GameHelper.TipsById(openCondition.tips)
        else
            Logger.LogError("[openCondition] is nil, id = " .. id)
        end
    else
        self.m_infoCallback = callback
        local messageId = MessageId.ResponseBossBattleInfo
        local handler = Bind(self, self.OnRspBossBattleInfo)
        self.m_rsBossWarInfo = NetPack:RegistResponse(messageId, handler)
        NetPack:SendMessage(MessageId.RequestBossBattleInfo, {})
    end
end

function M:OnRspBossBattleInfo(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsBossWarInfo)
    self.m_rsBossWarInfo = nil
    self._errorCode = result
    self._dataLoaded = true
    self._isloading = false
    if result ~= 0 then return end

    self.m_bossDatas = {}
    self.m_weekWordDic = {}
    self.m_level = msg.Level
    self.m_nextRefreshTick = msg.NextRefreshTick
    for _, id in ipairs(msg.Words or {}) do
        local cfg = ConfigHelper.GetCfgByLua("bossMapcondition", id)
        if cfg then
            self.m_weekWordDic[id] = cfg
        else
            Logger.LogError("bossMapcondition is nil, @四叶, id = " .. id)
        end
    end
    for _, value in ipairs(msg.Bosses or {}) do
        local data = BossWarData.New(value)
        for id, cfg in pairs(data:GetWordDic()) do
            if not self.m_weekWordDic[id] then
                data:UpdateWords(cfg)
            end
        end
        table.insert(self.m_bossDatas, data)
    end

    table.sort(self.m_bossDatas, function(a, b)
        return a:BossWarId() < b:BossWarId() -- 四叶：id小到大
    end)

    self:_StartTimer()
    if self.m_infoCallback then
        self.m_infoCallback()
        self.m_infoCallback = nil
    end
    IRedPointMgr:ForceCheck(RedPointConst.BossWarFirstRedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.BossWarChestRedPointChecker)
end

-- 难度等级
function M:DifficultyLevel()
    return self.m_level
end

-- 下次刷新时间
function M:NextRefreshTick()
    return self.m_nextRefreshTick
end

-- boss战数据 3条
function M:GetBossDatas()
    return self.m_bossDatas
end

function M:GetBossDataById(id)
    for _, data in ipairs(self.m_bossDatas or {}) do
        if data:BossWarId() == id then return data end
    end
    return nil
end

function M:LockId()
    if not self.m_bossWarCond then
        self.m_bossWarCond = GameHelper.GetParamters(353) -- Boss战开放条件
    end

    return GameHelper.CSGetFirstLockReason(self.m_bossWarCond)
end

-- 本周词条
function M:GetWeekWords()
    local words = {}
    for _, cfg in pairs(self.m_weekWordDic) do
        table.insert(words, cfg)
    end
    self:_SortWords(words)
    return words
end

-- 显示远征奖励
function M:_ShowAwards(awards)
    local itemDic = {}
    for _, item in ipairs(awards or {}) do
        local num = itemDic[item.Id] or 0
        itemDic[item.Id] = item.Cnt + num
    end
    GameHelper.ShowGetItems(itemDic)
end

-- 请求boss战首通奖励, 如果BossWarId和Step都为0, 为一键领取
function M:ReqBossBattleFirstChests(nRequest, callback)
    if self.m_rsFirstChests then return end

    self.m_firstCallback = callback
    local messageId = MessageId.ResponseBossBattleFirstChests
    local handler = Bind(self, self.OnRspBossBattleFirstChests)
    self.m_rsFirstChests = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(MessageId.RequestBossBattleFirstChests, nRequest)
end

function M:OnRspBossBattleFirstChests(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsFirstChests)
    self.m_rsFirstChests = nil
    if result ~= 0 then return end

    for _, value in ipairs(msg.Masks or {}) do
        local data = self:GetBossDataById(value.BossWarId)
        if data then data:UpdateFirstMask(value.Mask) end
    end
    self:_ShowAwards(msg.Awards)
    if self.m_firstCallback then
        self.m_firstCallback()
        self.m_firstCallback = nil
    end
end

-- 请求boss战奖励, 如果Step都为0, 为一键领取
function M:ReqBossBattleChests(nRequest, callback)
    if self.m_rsCycleChests then return end

    self.m_cycleCallback = callback
    self.m_chestBossWarId = nRequest.BossWarId
    local messageId = MessageId.ResponseBossBattleChests
    local handler = Bind(self, self.OnRspBossBattleChests)
    self.m_rsCycleChests = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(MessageId.RequestBossBattleChests, nRequest)
end

function M:OnRspBossBattleChests(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsCycleChests)
    self.m_rsCycleChests = nil
    local id = self.m_chestBossWarId
    self.m_chestBossWarId = nil
    if result ~= 0 then return end

    local data = self:GetBossDataById(id)
    if data then data:UpdateChestMask(msg.ChestMask) end
    self:_ShowAwards(msg.Awards)
    if self.m_cycleCallback then
        self.m_cycleCallback()
        self.m_cycleCallback = nil
    end
end

-- 挑战奖励红点 0:所有关卡
function M:CheckFirstRedPoint(bossWarId)
    for _, data in ipairs(self:GetBossDatas() or {}) do
        local id = data:BossWarId()
        if (bossWarId == 0) or (bossWarId == id) then
            local stage, stageNum, percent = data:BloodStage()
            for i, _ in ipairs(data:FirstChests()) do
                local idx = i - 1
                if not data:IsGetFirstChest(idx) then
                    local isPass = (percent <= 0) and ((stage + 1) >= stageNum)
                    if (idx < stage) or isPass then return true end
                    break
                end
            end
        end
    end
    return false
end

-- Boss奖励红点 0:所有关卡
function M:CheckChestRedPoint(bossWarId)
    for _, data in ipairs(self:GetBossDatas() or {}) do
        local id = data:BossWarId()
        if (bossWarId == 0) or (bossWarId == id) then
            local stage, stageNum, percent = data:BloodStage()
            for i, _ in ipairs(data:FirstChests()) do
                local idx = i - 1
                if not data:IsGetChest(idx) then
                    local isPass = (percent <= 0) and ((stage + 1) >= stageNum)
                    if (idx < stage) or isPass then return true end
                    break
                end
            end
        end
    end
    return false
end

-- 是否结算后首次进入Boss战红点
function M:CheckNewWarRedPoint()
    if (self:LockId() > 0) or (self:DifficultyLevel() <= 1) then return false end
    local timeStamp = self:NextRefreshTick()
    return PlayerPrefTools.GetPlayerPrefsInt("BossRefreshTick", -1) ~= timeStamp
end

return M
