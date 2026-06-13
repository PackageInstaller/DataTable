local M = BaseClass("MissionData")

local ETeamType = EnumConst.ETeamType
local EChapterType = ChapterConst.EChapterType
local EMissionType = ChapterConst.EMissionType

function M:__init(missionCfg)
    self.m_lastTimeSatr = 0  -- 上次的通关星级
    self.m_lastSweepFlag = 0 -- 上次是否开启扫荡
    self.m_missionCfg = missionCfg
    self.m_chapter = missionCfg.Chapter
    self.m_mType = self.m_chapter.type
    self.m_subType = self.m_chapter.subType
    -- Star:通关星级, FirstTick:首通时间, Count:通关总次数记录
    -- DailyRec:日常通关, AwardMask:奖励掩码, ClientConfig:客户端配置
    self.m_missionInfo = nil
end

function M:Update(info)
    self:UpdateLastData()
    self.m_missionInfo = info
end

function M:GetFixHeroLevel(id)
    if not self.m_missionCfg or id <= 0 then return 0 end
    local adHero = self.m_missionCfg.adHero
    local adLevel = self.m_missionCfg.adLevel
    for i = 0, adHero.Length - 1 do
        if adHero[i] == id then return adLevel[i] end
    end
    return 0
end

function M:GetFixHeroStartLevel(id)
    if not self.m_missionCfg or id <= 0 then return 0 end
    local adHero = self.m_missionCfg.adHero
    local adStar = self.m_missionCfg.adStar
    for i = 0, adHero.Length - 1 do
        if adHero[i] == id then return adStar[i] end
    end
    return 0
end

function M:GetFixHeroBreakLevel(id)
    if not self.m_missionCfg or id <= 0 then return 0 end
    local adHero = self.m_missionCfg.adHero
    local adBreak = self.m_missionCfg.adBreak
    for i = 0, adHero.Length - 1 do
        if adHero[i] == id then return adBreak[i] end
    end
    return 0
end

-- 获取通关星级
function M:GetStar()
    return self.m_missionInfo and self.m_missionInfo.Star or 0
end

-- 首通时间
function M:GetFirstPassTick()
    return self.m_missionInfo and self.m_missionInfo.FirstTick or 0
end

-- 通关次数(扫荡不加次数)
function M:GetPassCount()
    return self.m_missionInfo and self.m_missionInfo.Count or 0
end

-- 日常通关记录
function M:GetDailyRec()
    return self.m_missionInfo and self.m_missionInfo.DailyRec or 0
end

function M:GetMissionId()
    return self.m_missionCfg and self.m_missionCfg.id or 0
end

-- 字段：mopUpState, triggerMask
function M:ClientConfig()
    local configStr = self.m_missionInfo and self.m_missionInfo.ClientConfig or ""
    if string.isNullOrEmpty(configStr) then return nil end
    return Json.decode(configStr)
end

function M:UpdateClientConfig(value)
    if not self.m_missionInfo then return end
    self.m_missionInfo.ClientConfig = value
end

-- 扫荡状态 1：未选中，2：选中,跟UIState状态一致
function M:MopUpState()
    local config = self:ClientConfig()
    return config and config.mopUpState or 1
end

-- 是否看过剧情
function M:IsWatchStory(triggerType)
    if triggerType == StoryConst.TriggerType.PreWar then
        local keyName = "TriggerMask" .. self:GetMissionId()
        local value = PlayerPrefTools.GetPlayerPrefsInt(keyName, 0)
        if ((value >> triggerType) & 1) == 1 then return true end
    end
    local config = self:ClientConfig()
    if not config then return false end
    local mask = config.triggerMask or 0
    return (mask >> triggerType) & 1 == 1
end

-- 剧情关卡
function M:IsWordsMission()
    if not self.m_missionCfg then return false end
    return self.m_missionCfg.wordsMission == 1
end

function M:GetMissionCfg()
    return self.m_missionCfg
end

-- 下一个关卡配置ID
function M:GetNextMissionId()
    local nextMission = self:GetNextMissionCfg()
    return nextMission and nextMission.id or 0
end

function M:SetDailyRec(value)
    if not self.m_missionInfo then return end
    self.m_missionInfo.DailyRec = value
end

--  下一关配置表
function M:GetNextMissionCfg()
    return self.m_missionCfg and self.m_missionCfg.NextMission or nil
end

-- 当前章节类型
function M:ChapterType()
    local chapter = self:GetChapter()
    return chapter and chapter.type or EChapterType.ECT_None
end

function M:GetPostStage()
    return self.m_missionCfg and self.m_missionCfg.postStage or nil
end

-- 后置分支关卡，除主关卡
function M:GetNextMissions()
    return self.m_missionCfg and self.m_missionCfg.NextMissions or nil
end

function M:GetChapter()
    return self.m_chapter
end

-- 是否通关
function M:IsPass()
    return self.m_missionInfo and (self.m_missionInfo.FirstTick > 0) or false
end

-- 是否分支 1:分支
function M:IsBranch()
    return self.m_missionCfg and (self.m_missionCfg.branch == 1) or false
end

function M:IsSystemTeam()
    return self.m_missionCfg and (self.m_missionCfg.teamType == ETeamType.ETT_System) or false
end

function M:IsMain()
    return self.m_missionCfg and self.m_missionCfg.IsMain or false
end

function M:IsHard()
    return self.m_mType == EChapterType.ECT_Elite
end

function M:IsResource()
    return self.m_mType == EChapterType.ECT_Resource
end

function M:IsActivity()
    return self.m_mType == EChapterType.ECT_Activity
end

function M:IsEncounter()
    return self.m_mType == EChapterType.ECT_Encounter
end

function M:IsPersonal()
    return self.m_mType == EChapterType.ECT_Personal
end

-- 假面舞会关卡
function M:IsMaskedBall()
    return (self.m_subType == 1001) or (self.m_subType == 1002)
end

-- 平行宇宙关卡
function M:IsMultiverse()
    return (self.m_subType == 2001) or (self.m_subType == 2002)
end

-- 章节尾巴
function M:IsTail()
    return self.m_missionCfg and self.m_missionCfg.IsTail or false
end

-- 章节ID
function M:GetChapterId()
    local chapter = self:GetChapter()
    if chapter then return chapter.id end
    return 0
end

function M:IsDifficulty()
    return self.m_missionCfg and (self.m_missionCfg.difficulty == EMissionType.EMT_Hard) or false
end

-- 是否满星首通
function M:IsMaxStarFirstPass()
    local star = 3
    local chapter = self:GetChapter()
    if chapter then
        if chapter.type == EChapterType.ECT_Elite then
            star = 4
        elseif chapter.type == EChapterType.ECT_Activity and
            self:IsDifficulty()
        then
            star = 4
        end
    end
    local passStar = self:GetStar()
    if passStar >= star then
        if self:GetPassCount() == 1 then return true end
        if self.m_lastTimeSatr < passStar then return true end
    end

    return false
end

-- 是否显示扫荡
function M:IsShowFast()
    if not self.m_missionCfg then return false end
    return self.m_missionCfg.showFast == 0 -- 0:显示扫荡
end

-- 是否解锁扫荡 扫荡标记 1 能 0 不能
function M:IsUnlockSweep()
    if not self:IsShowFast() then return false end
    return self.m_missionInfo and (self.m_missionInfo.SweepFlag == 1) or false
end

-- 是否首次开启扫荡
function M:IsFirstOpenSweep()
    -- 扫荡标记 1 能 0 不能
    local sweepFlag = self.m_missionInfo and self.m_missionInfo.SweepFlag or 0
    return (self.m_lastSweepFlag == 0) and (sweepFlag == 1)
end

function M:UpdateLastData()
    if self.m_missionInfo then
        self.m_lastTimeSatr = self.m_missionInfo.Star
        self.m_lastSweepFlag = self.m_missionInfo.SweepFlag
    end
end

-- 关卡体力消耗
function M:EnergyCost()
    if not self.m_missionCfg then return 0 end
    return self.m_missionCfg.energyCost
end

return M
