local M = BaseClass("EncounteData") -- 遭遇战数据
local tInsert = table.insert
local EncounteZoneData = require("DataCenter.Mission.EncounteZoneData")
local Difficulty = {
    [EncountConst.EEncountDifficult.ESimple] = ConfigHelper.GetLocalString(4079), --"普通",
    [EncountConst.EEncountDifficult.EMedium] = ConfigHelper.GetLocalString(4080), --"中等",
    [EncountConst.EEncountDifficult.EDifficulty] = ConfigHelper.GetLocalString(4081), --"困难",
}

function M:__init(encountCfg)
    self.m_difficulty = 0
    self.m_zoneDatas = {}
    self.m_lastZoneDatas = {} --上周期数据
    self.m_award = {} -- 上一周期奖励
    self.m_encountCfg = encountCfg -- engagement表数据
end

--上一局是周期结算
function M:IsLastCycleSettlement()
    if self.m_encountCfg == nil then 
        return false,false
    end
    local flag = self.m_encountCfg.season * 100 + self.m_encountCfg.id
    local isLast = self:GetLastCycleId() ~= 0 and self:GetLastCycleId() ~=  self.m_encountCfg.id
    local saveFlag = PlayerPrefTools.GetPlayerPrefsInt("settlement",0 ) 
    if saveFlag ~= 0 and saveFlag ~= flag and isLast then 
        isLast = true
    else
        isLast = false
    end
    PlayerPrefTools.SetPlayerPrefs("settlement",flag)
    --是否有新的词条
    if isLast then 
        local lastEncountCfg = ConfigHelper.GetCfg( "engagement", self:GetLastCycleId() )
        if #self.m_encountCfg.seasonEntry > 0 and #lastEncountCfg.seasonEntry > 0 then 
            return isLast ,self.m_encountCfg.seasonEntry[1] ~= lastEncountCfg.seasonEntry[1]
        end
        if #self.m_encountCfg.seasonEntry > 0 and #lastEncountCfg.seasonEntry == 0 then 
            return isLast ,true
        end 
        return isLast , false
    end
    return isLast,false
end

--当前是新的赛季
function M:IsNewSeason()
    if self:GetLastCycleId() == 0 then 
        return false
    end
    local lastEngagementCfg = ConfigHelper.GetCfg("engagement",self:GetLastCycleId() )
    local saveSeason = PlayerPrefTools.GetPlayerPrefsInt("season",0 ) 
    local isNewSeason = lastEngagementCfg.season ~= self.m_encountCfg.season
    if isNewSeason and saveSeason ~= self.m_encountCfg.season then 
        isNewSeason = true
    else
        isNewSeason = false
    end
    PlayerPrefTools.SetPlayerPrefs("season",self.m_encountCfg.season)
    return isNewSeason
end



-- 剩余展示时间
function M:RemainShowTime()
    if not self.m_encountCfg then return 0 end
    local curTime = TimeUtil.GetNowTimeStamp()
    local showTime = self.m_encountCfg.showTime
    return showTime - curTime
end

-- 背景图资源
function M:GetBackground()
    if not self.m_encountCfg then return "" end
    return self.m_encountCfg.background
end

-- 赛季名称
function M:SeasonNameId()
    return self.m_encountCfg.seasonName
end

-- 获取周期开启时间段
function M:GetOpenTimeZone()
    local startTime ,endTime =  EncounterHelper.GetZoneTimeRange(self.m_createTick,self:GetDifficulty())
    --周期开始时间段就是以周期创建时间
    startTime  = self.m_createTick
    local startStr = TimeUtil.GetTimeFormat(startTime, "%y/%m/%d %H:%M")
    local endStr = TimeUtil.GetTimeFormat(endTime, "%y/%m/%d %H:%M")
    return string.format("周期时间: %s - %s", startStr, endStr)
end

-- 周期创建时间
function M:GetCreateTick()
    return self.m_createTick
end

-- 遭遇战难度
function M:GetDifficulty()
    -- body
    return self.m_difficulty
end

--遭遇战上一次的难度
function M:GetLastDifficulty()
    return self.m_lastDifficulty
end

--遭遇战上一次的周期
function M:GetLastCycleId()
    return self.m_LastCycleId
end

function M:GetCycleId()
    return self.m_cycleId
end

--通过周期和难度获得所有区域
function M:_GetZoneIds( cycleId,diffculty)
    if cycleId == nil or cycleId == 0 then 
        return {}
    end
    local encountCfg = ConfigHelper.GetCfgByLua("engagement",cycleId)
    --现在没有难度区分
    local zonesIds = encountCfg.zonesId 
    -- if diffculty == EncountConst.EEncountDifficult.ESimple then 
    --     zonesIds = encountCfg.zonesId
    -- elseif diffculty == EncountConst.EEncountDifficult.EMedium then 
    --     zonesIds = encountCfg.zonesIdN
    -- elseif diffculty == EncountConst.EEncountDifficult.EDifficulty then
    --     zonesIds = encountCfg.zonesIdH
    -- end
    return zonesIds
end

-- 区域数据
function M:UpdateData(msg)
    self.m_difficulty = msg.Difficulty or EncountConst.EEncountDifficult.ESimple
    self.m_lastDifficulty = msg.LastDifficulty
    self.m_LastCycleId = msg.LastCycleId
    self.m_cycleId = msg.CycleId
    self.m_encountCfg = ConfigHelper.GetCfgByLua("engagement", msg.CycleId)
    self.m_zoneDatas = {}
    self.m_createTick = msg.CreateTick
    local zone = {}
    for _, value in ipairs(msg.Data) do
        zone[value.ZoneId] = value
    end
    local zonesIds = self:_GetZoneIds(msg.CycleId,msg.Difficulty)
    if zonesIds then 
        for idx, id in ipairs(zonesIds) do
            local cfg = ConfigHelper.GetCfgByLua("engagementZone", id)
            if cfg == nil then 
                Logger.LogError("engagementZone配置错误 " .. id )
            end
            local data = EncounteZoneData.New(cfg,self.m_difficulty,msg.CreateTick,idx)
            data:UpdateData(zone[id])
            tInsert(self.m_zoneDatas, data)
        end
    else
        Logger.Log("遭遇战获得区域列表失败:cycleId:"..tostring(msg.CycleId)..",Difficulty:".. tostring(msg.Difficulty))
    end
    
    --上一周期
    self.m_lastZoneDatas = {}
    local lastZone = {}
    if msg.LastData then 
        for _, value in ipairs(msg.LastData) do
            lastZone[value.ZoneId] = value
        end
    end
    
    zonesIds = self:_GetZoneIds(msg.LastCycleId,msg.Difficulty)
    for idx, id in ipairs(zonesIds) do
        local cfg = ConfigHelper.GetCfgByLua("engagementZone", id)
        if cfg == nil then 
            Logger.LogError("engagementZone配置错误 " .. id )
        else
            local data = EncounteZoneData.New(cfg,self.m_lastDifficulty,0,idx)
            data:UpdateData(lastZone[id])
            tInsert(self.m_lastZoneDatas,data)
        end
    end
    -- self.m_award = msg.Award
end

--更新编队
function M:UpdateTeamByCRoleTeam(index,cRoleTeam)
    if self.m_zoneDatas and #self.m_zoneDatas > 0 and index <= #self.m_zoneDatas then 
        local data = self.m_zoneDatas[index]
        data:UpdateTeamByCRoleTeam(cRoleTeam.TeamId,cRoleTeam)
    end
end

function M:GetTeams(index)
    if self.m_zoneDatas and #self.m_zoneDatas > 0 and index <= #self.m_zoneDatas then 
        local data = self.m_zoneDatas[index]
        return data:GetConfTeam()
    end
    return {}
end

--获得战斗数据
function M:GetBattleData(index,battleIdx)
    if self.m_zoneDatas and #self.m_zoneDatas > 0 and index <= #self.m_zoneDatas then 
        local data = self.m_zoneDatas[index]
        return data:GetBattleData(battleIdx)
    end
    return nil
end

--获得驻守数据
function M:GetGarrsionData(index)
    if self.m_zoneDatas and #self.m_zoneDatas > 0 and index <= #self.m_zoneDatas then 
        local data = self.m_zoneDatas[index]
        return data:GetGarrsionData()
    end
    return false
end

--更新驻阵数据
function M:UpdateGarrsion(index,heroIds)
    if self.m_zoneDatas and #self.m_zoneDatas > 0 and index <= #self.m_zoneDatas then 
        local data = self.m_zoneDatas[index]
        data:UpdateGarrsion(heroIds)
    end
end

--重置通关
function M:ResetPass(index)
    if self.m_zoneDatas and #self.m_zoneDatas > 0 and index <= #self.m_zoneDatas then 
        local data = self.m_zoneDatas[index]
        data:ResetPass(0)
        data:ResetPass(1)
    end
end

function M:GetZoneId(index)
    if self.m_zoneDatas and #self.m_zoneDatas > 0 and index <= #self.m_zoneDatas then 
        local data = self.m_zoneDatas[index]
        return data:ZoneId()
    end
    return 0
end

function M:GetZoneById(id)
    if self.m_zoneDatas then 
        for _,data in ipairs(self.m_zoneDatas) do 
            if data:ZoneId() == id then 
                return data
            end
        end
    end
    return nil
end

--获得通关个数
function M:GetZoneMissionPassCount(index)
    if self.m_zoneDatas and #self.m_zoneDatas > 0 and index <= #self.m_zoneDatas then 
        local data = self.m_zoneDatas[index]
        return data:GetZoneMissionPassCount()
    end
end 

--获得当前选区的所有的词条，包含区域词条（赛季词条）、遭遇战关卡词条
function M:GetEntrys(emissionId)
    local entrys = {}
    if self.m_difficulty ~= EncountConst.EEncountDifficult.ESimple then
        for _,entryId in ipairs(self.m_encountCfg.seasonEntry) do 
            tInsert(entrys,entryId)
        end
    end
    
    local eMissionCfg = ConfigHelper.GetCfg("encounterMission",emissionId)
    for _,entryId in ipairs(eMissionCfg.entry) do 
        tInsert(entrys,entryId)
    end
    return entrys
end

--周期
-- function M:GetCycleId()
--     return self.m_encountCfg.id
-- end

-- 区域数据列表
function M:GetZoneDatas()
    return self.m_zoneDatas
end

function M:Diffculty()
    return self.m_difficulty
end

function M:DiffcultyTag()
    return Difficulty[self.m_difficulty]
end

function M:GetZoneDataByIdx(idx)
    return self.m_zoneDatas[idx]
end

-- 词条名称
function M:SeasonEntryName()
    return self.m_encountCfg.seasonEntryName
end

-- 词条描述
function M:SeasonEntryDesc()
    return self.m_encountCfg.seasonEntryDes
end

--词条头标
function M:SeaosonIcon()
    return self.m_encountCfg.seasonicon
end

--赛季（周期）词条
function M:SeasonEntry()
    return self.m_encountCfg.seasonEntry
end

-- 中等难度词条名字
function M:WeakenEntryNames()
    return self.m_encountCfg.seasonName
    --return self.m_encountCfg.weakenEntryNames
end

-- 中等难度词条描述
function M:WeakenEntryDescs()
    return self.m_encountCfg.seasonName
    --return self.m_encountCfg.weakenEntryDes
end

function M:GetAward()
    return self.m_award
end

--获得上次区域的信息
function M:GetLastZoneData()
    return self.m_lastZoneDatas
end

return M
