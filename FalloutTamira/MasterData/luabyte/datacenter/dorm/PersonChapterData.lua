local M = BaseClass("PersonChapterData") -- 个人副本数据

function M:__init(info, heroId, endTime)
    self.m_heroId = heroId
    self.m_missionDatas = {}
    self.m_passMissionDic = {}
    self.m_endTime = endTime or 0 -- 个人副本活动结束时间
    self.m_chapterId = info.ChapterId
    self.m_lastMissionId = info.LastMissionId
    self.m_chapter = ConfigHelper.GetCfgByLua("chapter", self.m_chapterId)
    if not self.m_chapter then Logger.LogError("chapter is nil, @锵锵, id = " .. self.m_chapterId) end
    self:_InitMissionList()
end

function M:_InitMissionList()
    local allMission = self.m_chapter:GetAllMission()
    for j = 0, allMission.Length - 1, 1 do
        local mission = allMission[j]
        local missionId = mission.id
        table.insert(self.m_missionDatas, {
            Index = j + 1,
            MissionCfg = mission,
            MissionId = missionId,
            FirstLock = function()
                return GameHelper.CSGetFirstLockReason(mission.openCondition)
            end,
            IsPrePass = function() -- 前面一关是否通关
                local preMission = mission.PrevMission
                if not preMission then return true end
                return self.m_passMissionDic[preMission.id] or false
            end,
            IsPass = function()
                return self.m_passMissionDic[missionId] or false
            end,
            HeroId = function()
                return self.m_heroId
            end,
            IsOpen = function()
                return self:IsOpen()
            end
        })
    end
    self:UpdateLastMissionId(self.m_lastMissionId)
end

function M:UpdateLastMissionId(missionId)
    self.m_lastMissionId = missionId
    if missionId == 0 then return end

    for _, v in ipairs(self.m_missionDatas) do
        local id = v.MissionId
        self.m_passMissionDic[id] = true
        if id == missionId then break end
    end
end

function M:GetChapter()
    return self.m_chapter
end

function M:ChapterId()
    return self.m_chapterId
end

function M:HeroId()
    return self.m_heroId
end

function M:GetAllMissions()
    return self.m_missionDatas
end

function M:LastUnlockData()
    for _, md in ipairs(self.m_missionDatas) do
        -- 正在进行的关卡
        if not md.IsPass() then return md end
    end
    return self.m_missionDatas[#self.m_missionDatas]
end

function M:IsPassMission(missionId)
    return self.m_passMissionDic[missionId] or false
end

function M:EndTime()
    return self.m_endTime
end

function M:IsOpen()
    if self:EndTime() == 0 then return true end
    return TimeUtil.GetNowTimeStamp() < self:EndTime()
end

return M
