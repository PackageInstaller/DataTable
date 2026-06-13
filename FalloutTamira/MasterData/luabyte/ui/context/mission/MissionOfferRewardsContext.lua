local M = BaseClass("MissionOfferRewardsContext", BaseContext)

function M:Open()
    self.m_isBattleBack = false
    local datas = ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.OFFER_ACTIVITY_COPY)
    for _, data in ipairs(datas or {}) do
        if data:IsOpen() then -- 只会开一个
            self.m_activityId = data:ActivityId()
            self.m_itemIds = data:ActivityCfg().itemSpecial
            if data:LockId() > 0 then
                GameHelper.TipsByLockId(data:LockId())
                return
            end
            MissionDataMgr:GetInstance():GetWantedBattleInfo(self.m_activityId, function(lv, exp, awardLv, kv)
                self.m_level = lv          -- 悬赏等级
                self.m_lvExp = exp         -- 悬赏经验
                self.m_awardLv = awardLv   -- 已领取奖励的悬赏等级
                self.m_missionWordDic = kv -- 关卡进度数据 key-wanted id, value-词条掩码
                if not self.m_wanted then
                    local id = self:_GetTodayWantedId()
                    if id > 0 then
                        self.m_wanted = ConfigHelper.GetCfgByLua("wanted", id)
                        if not self.m_wanted then Logger.LogError("wanted is nil, 检查配置, id = " .. id) end
                    end
                end
                self:_Show(data, self.m_wanted)
            end)
            return
        end
    end
    GameHelper.TipsById(1055) -- 活动未开放
end

function M:IsUseItem()
    return self.m_isUseItem or false
end

function M:GetMissionId()
    if not self.m_wanted then return 0 end
    return self.m_wanted.missionID
end

function M:OnClose()
    local msgId = Proto.MessageId.ResponseWantedBattleReward
    NetPack:UnRegistResponse(msgId, self.m_rsWantedAward)
    self.m_isUseItem = nil
    self.m_rsWantedAward = nil
    self.m_awardCallback = nil
end

--[[
    悬赏红点:
    1.每日首次进入前显示红点
    2.有可领取未领取的奖励时显示红点
]]
function M:CheckAwardRedPoint(callback)
    if not self.m_awardLv or not self.m_level then
        local datas = ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.OFFER_ACTIVITY_COPY)
        for _, data in ipairs(datas or {}) do
            if data:IsOpen() then -- 只会开一个
                self.m_activityId = data:ActivityId()
                self.m_itemIds = data:ActivityCfg().itemSpecial
                MissionDataMgr:GetInstance():GetWantedBattleInfo(self.m_activityId, function(lv, exp, awardLv, kv)
                    self.m_level = lv          -- 悬赏等级
                    self.m_lvExp = exp         -- 悬赏经验
                    self.m_awardLv = awardLv   -- 已领取奖励的悬赏等级
                    self.m_missionWordDic = kv -- 关卡进度数据 key-wanted id, value-词条掩码
                    if TimeUtil.IsToday(PlayerPrefTools.GetPlayerPrefsInt("OfferRewardStamp", 0), TimeUtil.DailyRefreshTime) then
                        if callback then callback(self.m_awardLv < self.m_level) end
                    else
                        local cfgs = self:GetCurWantedLevelCfgs() or {}
                        local maxLvCfg = cfgs[#cfgs] or {}
                        if callback then callback(self.m_awardLv < (maxLvCfg.wantedLevel or 0)) end -- 奖励没领完时，首次进入前默认显示红点
                    end
                end)
                return
            end
        end
        if callback then callback(false) end
    else
        if callback then callback(self.m_awardLv < self.m_level) end
    end
end

function M:GetCurActivityWanteds()
    if not self.m_wantedGroupDic then
        self.m_wantedGroupDic = {}
        for _, wanted in pairs(ConfigHelper.GetCfgsByLua("wanted") or {}) do
            local id = wanted.activityId
            if not self.m_wantedGroupDic[id] then self.m_wantedGroupDic[id] = {} end
            table.insert(self.m_wantedGroupDic[id], wanted)
        end
        for _, group in pairs(self.m_wantedGroupDic) do
            table.sort(group, function(a, b) return a.id < b.id end)
        end
    end
    return self.m_wantedGroupDic[self.m_activityId]
end

function M:GetCurWantedLevelCfgs()
    if not self.m_wantedLevelGroupDic then
        self.m_wantedLevelGroupDic = {}
        for _, cfg in pairs(ConfigHelper.GetCfgsByLua("activityWantedReward") or {}) do
            local id = cfg.activityId
            if not self.m_wantedLevelGroupDic[id] then self.m_wantedLevelGroupDic[id] = {} end
            table.insert(self.m_wantedLevelGroupDic[id], cfg)
        end
        for _, group in pairs(self.m_wantedLevelGroupDic) do
            table.sort(group, function(a, b) return a.wantedLevel < b.wantedLevel end)
        end
    end
    return self.m_wantedLevelGroupDic[self.m_activityId]
end

-- 悬赏词条掩码
function M:GetWantedWordMaskById(id)
    if not self.m_missionWordDic then return 0 end
    return self.m_missionWordDic[id] or 0
end

function M:GetWantedLevel()
    return self.m_level
end

function M:GetWantedExp()
    return self.m_lvExp
end

function M:GetWantedAwardLevel()
    return self.m_awardLv
end

function M:CurWantedId()
    if not self.m_wanted then return 0 end
    return self.m_wanted.id
end

function M:CurActivityId()
    return self.m_activityId
end

function M:CurItemSpecial()
    return self.m_itemIds
end

function M:CurWordMask()
    local mask = 0
    for i, id in ipairs(self.m_wanted and self.m_wanted.mapConditionId or {}) do
        if self.m_wordDic[id] then mask = (1 << (i - 1)) | mask end
    end
    return mask
end

function M:IsBattleBack()
    return self.m_isBattleBack
end

-- 是从战后返回的
function M:BattleBack()
    self.m_isBattleBack = true
end

-- 选中词条
function M:SelectKeyWords()
    local keyWords = {}
    for id, isSelect in pairs(self.m_wordDic or {}) do
        if isSelect then
            local mcrandom = ConfigHelper.GetCfgByLua("mcrandom", id)
            if mcrandom then
                table.insert(keyWords, mcrandom.Mpid)
            else
                Logger.LogError("mcrandom is nil, @四叶, id = " .. id)
            end
        end
    end
    return keyWords
end

-- 领取悬赏奖励
function M:SendWantedBattleReward(activityId, callback)
    if self.m_rsWantedAward then return end

    self.m_awardCallback = callback
    local msgId = Proto.MessageId.ResponseWantedBattleReward
    local handler = Bind(self, self.OnResponseWantedBattleReward)
    self.m_rsWantedAward = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(Proto.MessageId.RequestWantedBattleReward, { ActivityId = activityId })
end

function M:OnResponseWantedBattleReward(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsWantedAward)
    self.m_rsWantedAward = nil
    if result ~= 0 then return end

    self.m_awardLv = msg.Rewarded
    if self.m_awardCallback then
        self.m_awardCallback(msg.Awards)
        self.m_awardCallback = nil
    end
end

function M:UpdateWanted(wanted)
    self.m_wanted = wanted
    PlayerPrefTools.SetPlayerPrefs("ChooseWanted", Json.encode({
        Time = TimeUtil.GetNowTimeStamp(),
        WantedId = self.m_wanted.id
    }))
end

function M:DataRecord(wordDic, isUseItem)
    self.m_wordDic = wordDic
    self.m_isUseItem = isUseItem
end

-- 获取当前等级需要的经验
function M:GetLevelTotalExp(lv)
    local group = self:GetCurWantedLevelCfgs() or {}
    for i = lv, #group do
        local v = group[i]
        if v and (lv == v.wantedLevel) then return v.wantedExp end
    end
    return 0
end

function M:_GetTodayWantedId()
    local infoStr = PlayerPrefTools.GetPlayerPrefsString("ChooseWanted", "")
    if string.isNullOrEmpty(infoStr) then return 0 end
    local hour, tbl = TimeUtil.DailyRefreshTime, Json.decode(infoStr) or {}
    return TimeUtil.IsToday(tbl.Time or 0, hour) and tbl.WantedId or 0
end

return M
