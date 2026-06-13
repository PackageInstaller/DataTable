local M = BaseClass("EncounteZoneData") -- 遭遇战区域数据,含team

function M:__init(data,diffculty,createTick,zoneIdx)
    self.m_zoneCfg = data
    self.m_diffculty = diffculty
    self.m_zoneMissionCfgs = {} -- encounterMission表数据
    self.m_openTime = EncounterHelper.GetZoneOpenTime(createTick,diffculty,zoneIdx)
    self.m_zoneIdx = zoneIdx
    for _, id in ipairs(self.m_zoneCfg.missions) do
        local cfg = ConfigHelper.GetCfgByLua("encounterMission", id)
        table.insert(self.m_zoneMissionCfgs, cfg)
    end
end

function M:GetZoneIdx()
    return self.m_zoneIdx
end

function M:GetDiffculty()
    return self.m_diffculty
end

-- 遭遇战区域关卡通关数量
function M:GetZoneMissionPassCount()
    local state = self:ZoneState()
    if state == EncountConst.EEncountZoneState.EFailPass then
        return 0
    elseif state == EncountConst.EEncountZoneState.EAllPass then
        return 2
    end
    return 1
end

-- 遭遇战区域关卡可领奖数量
function M:GetZoneMissionAwardCount()
    local num = 0
    if self:CanGainReward(EncountConst.EEncountTeamType.ETeamA) then 
        num = num + 1 
    end
    if self:CanGainReward(EncountConst.EEncountTeamType.EteamB) then 
        num = num + 1 
    end
    return num
end

-- 获得未领奖数量
function M:GetZoneMissonUnAwardCount()
    local num = 0
    if not self:IsGainReward(0) then 
        num = num + 1 
    end
    if not self:IsGainReward(1) then 
        num = num + 1 
    end
    return num
end

function M:ZoneId()
    return self.m_zoneCfg.id
end

function M:ZoneNameId()
    return self.m_zoneCfg.name
end

function M:ZoneNameIdEn()
    return self.m_zoneCfg.nameEn
end

function M:ZoneDescId()
    return self.m_zoneCfg.des
end

function M:IconPath()
    return self.m_zoneCfg.icon
end

--通关状态
function M:ZoneState()
    if self:IsPassAll() then
        return EncountConst.EEncountZoneState.EAllPass
    end
    if self:IsPass(true) then 
        return EncountConst.EEncountZoneState.EFirstPass
    elseif self:IsPass(false) then 
        return EncountConst.EEncountZoneState.ESecondPass
    end
    -- for i,team in ipairs(self.m_teams) do
    --     if i == 1 and self:IsPass(team.TeamIdx) then 
    --         return EncountConst.EEncountZoneState.EFirstPass
    --     elseif i == 2 and self:IsPass(team.TeamIdx) then 
    --         return EncountConst.EEncountZoneState.ESecondPass
    --     end
    -- end
    return EncountConst.EEncountZoneState.EFailPass
end

--领奖状态
function M:ZoneGainRewardState()
    return self.m_rewardState
end

function M:GetAlreadyGain()
    if self.m_rewardState == nil then 
        self.m_rewardState = 0 
    end
    local num = 0 
    local gainedState =  self.m_rewardState % ( 1 << 8 )
    for i =  1 , 2 do 
        local flag = 1 << ( i - 1 )
        if gainedState & flag ~= 0 then 
            num = num + 1 
        end
    end
    return num
end

function M:GetAlreadyByTeamType(teamType)
    if self.m_rewardState == nil then 
        self.m_rewardState = 0 
    end
    local num = 0 
    local gainedState =  self.m_rewardState % ( 1 << 8 )
    local flag = 1 << ( teamType - 1 )
    if gainedState & flag ~= 0 then 
        return true
    end
    return false
end

--是否可领奖  EEncountTeamType
function M:CanGainReward(teamType)
    if self.m_rewardState == nil then 
        self.m_rewardState = 0 
    end
    local tmp = 1 << ( 8 + teamType - 1 )
    return tmp & self.m_rewardState > 0
end

function M:TeamMapPath(teamType)
    local missionCfg = self:GetMissionCfg(teamType)
    if missionCfg then
        return missionCfg.map
    end
    return ""
end

-- 0为 A  ，1 为B 
function M:GetBattleData(index)
    local encounterMissionCfg = nil 
    if index == 0 then
        encounterMissionCfg = self.m_zoneMissionCfgs[1]
    elseif index == 1 then
        encounterMissionCfg = self.m_zoneMissionCfgs[2]
    else
        return nil 
    end
    return self:ZoneId(),{encounterMissionCfg.id},{encounterMissionCfg.missionId},{index}
end

--获得驻守数据
function M:GetGarrsionData()
    local passCount = self:GetZoneMissionPassCount()
    if passCount == 0 then 
        return false,nil,self.m_zoneCfg.Lock,{}
    end
    --先看A有没有数量，如果有，则可以更换
    local teamA = self:GetTeam(0,true)  
    if teamA then 
        return true,teamA.Heroes,self.m_zoneCfg.Lock,teamA.GarrisonHeroIds
    end
    return false,nil,self.m_zoneCfg.Lock,{}
end

--更新A的驻阵数据
function M:UpdateGarrsion(heroIds)
    local teamA = self:GetTeam(0,true) 
    if teamA then 
        teamA.GarrisonHeroIds = heroIds
    end
    --要把B中的上阵从驻守中删除
    local teamB = self:GetTeam(1,true)
    local teamBconfig = self:GetTeam(1,false)
    local arr = {}
    if teamB and teamB.Heroes then 
        table.insert( arr,teamB.Heroes )
    elseif teamBconfig and teamBconfig.Heroes then 
        table.insert( arr,teamBconfig.Heroes )
    end
    for i = 1 , #arr do 
        local heroes = arr[i]
        for j = 1 , #heroIds do 
            local hId = heroIds[j]
            table.removebyvalue(heroes,hId)
        end
    end
end

--获得遭遇战驻阵数量
function M:GetLockNum()
    return self.m_zoneCfg.Lock
end

function M:GetEMissionCfg(teamType)
    local encounterMissionCfg
    if teamType == EncountConst.EEncountTeamType.ETeamA then
        encounterMissionCfg = self.m_zoneMissionCfgs[1]
    elseif teamType == EncountConst.EEncountTeamType.EteamB then
        encounterMissionCfg = self.m_zoneMissionCfgs[2]
    end
    return encounterMissionCfg
end

function M:GetMissionCfg(teamType)
    local encounterMissionCfg
    if teamType == EncountConst.EEncountTeamType.ETeamA then
        encounterMissionCfg = self.m_zoneMissionCfgs[1]
    elseif teamType == EncountConst.EEncountTeamType.EteamB then
        encounterMissionCfg = self.m_zoneMissionCfgs[2]
    end
    if encounterMissionCfg then
        local missionId = encounterMissionCfg.missionId
        return ConfigHelper.GetCfgByLua("mission", missionId)
    end
    return nil
end

function M:GetMissionStage(teamType)
    local missionCfg = self:GetMissionCfg(teamType)
    if missionCfg then
        return ConfigHelper.GetCfgByLua("stage", missionCfg.stageId)
    end
    return nil
end

function M:ZoneMissions()
    return self.m_zoneCfg.missions
end

function M:ZoneRewardPreview()
    return self.m_zoneCfg.preview
end

-- 中等难度词条
function M:ZoneMediumEntryDesc()
    return self.m_zoneCfg.weakenEntryDes
end

-- 中等难度词条名字
function M:ZoneMediumEntryNames()
    return self.m_zoneCfg.weakenEntryNames,self.m_zoneCfg.weakenEntryNamesEn
end

-- 困难难度词条
function M:ZoneHardEntryDesc()
    return self.m_zoneCfg.entryDes
end

-- 困难难度词条名字
function M:ZoneHardEntryNames()
    return self.m_zoneCfg.entryNames,self.m_zoneCfg.entryNamesEn or {}
end

function M:UpdateData(data)
    if data then
        self.m_state = data.State -- 区域状态
        self.m_rewardState = data.RewardState and data.RewardState or 0 --AB关领奖状态
        self.m_teams = {}
        -- Team数据 { TeamIdx = 0 , Heroes = {1,2,2,32,32} , State = 0 ,CommandSkills = {1,2,3,4}}  state 是否上锁
        local aGarrsionIds = nil  
        for i = 1 , #data.Team do 
            local t = data.Team[i]
            local tmpTeamHeros = {}
            t.Heroes = t.Heroes or {}
            if i == 1 then 
                aGarrsionIds = t.GarrisonHeroIds or {}
            end
            for j = 1 , #t.Heroes do 
                local hId = t.Heroes[j]
                if i == 2 and aGarrsionIds and not table.indexof(aGarrsionIds,hId) then 
                    table.insert(tmpTeamHeros,hId)
                elseif data.GarrisonHeroIds == nil then
                    table.insert(tmpTeamHeros,hId)
                end
            end
            t.Heroes = tmpTeamHeros
            table.insert( self.m_teams,t)
        end
    else
        self.m_state = 0
        self.m_rewardState = 0
        self.m_teams = {}
    end
    self.m_enTeams = {}
    for i = 1 , #self.m_teams do 
        local team = self.m_teams[i]
        local o = {}
        o.TeamId = team.TeamIdx
        o.Heroes = team.Heroes
        o.HeroLength = 8
        o.CommanderSkills = team.CommandSkills
        o.FriTeams = {}
        --只有1个助战
        if team.FriTeam and team.FriTeam.HeroId > 0 then 
            table.insert(o.FriTeams,team.FriTeam)
        end
        table.insert(self.m_enTeams,o)
    end
end

--主要是check A上阵的英雄是否出现在B的驻守中
function M:CheckHeros()
    
end

--是否通关，参数isA = true 是A关，false 是B关
function M:IsPass(teamIdx)
    if type(teamIdx) == "boolean" then 
        local isA = teamIdx
        if isA then 
            teamIdx = 0
        else
            teamIdx = 1
        end
    end
    local bitNum = 0 
    bitNum = 2^teamIdx
    if self.m_state == nil then 
        self.m_state = 0 
    end
    local bitStr = BitAnd(self.m_state,bitNum)
    local bitNum = tonumber(bitStr)
    return bitNum > 0 
end

--设置通关状态
function M:SetPassState(state)
    self.m_state = state
end

--设置领奖状态
function M:SetRewardState(rewardState)
    if self.m_rewardState == nil then 
        self.m_rewardState = 0 
    end
    self.m_rewardState = rewardState
end

function M:GetOpenTime()
    return self.m_openTime 
end


--重置通关
function M:ResetPass(teamIdx)
    if teamIdx then 
        local tmpState = self.m_state >> 8
        self.m_state = tmpState << 8
    else
        self.m_state = 0
    end
    local teamServer = self:GetTeam(teamIdx,true)
    if teamServer then 
        teamServer.Heroes = {} 
        teamServer.CommandSkills = {}
        teamServer.FriTeam = nil
        teamServer.GarrisonHeroIds = {}
    end
    local teamEn = self:GetTeam(teamIdx,false)
    if teamEn then 
        teamEn.HeroLength = 0
        teamEn.Heroes = {}
        teamEn.CommanderSkills = {}
        teamEn.FriTeams = {}
    end
end

--是否领过奖，参数isA = true 是A关，false 是B关
function M:IsGainReward(teamIdx)
    if type(teamIdx) == "boolean" then 
        local isA = teamIdx
        if isA then 
            teamIdx = 0
        else
            teamIdx = 1
        end
    end
    local bitNum = 0 
    bitNum = 2^teamIdx
    if self.m_rewardState == nil then 
        self.m_rewardState = 0 
    end
    local stateNumStr = BitAnd(self.m_rewardState,bitNum)
    local stateNum = tonumber(stateNumStr)
    return stateNum > 0 
end

--更新
function M:UpdateTeamByCRoleTeam(teamIdx,CRoleTeam)
    if self.m_enTeams then 
        local exsit = false
        for i = 1 , #self.m_enTeams do 
            local enTeam = self.m_enTeams[i]
            if enTeam.TeamId == teamIdx then 
                self.m_enTeams[i] = CRoleTeam
                exsit = true
            end
        end
        if not exsit then 
            table.insert(self.m_enTeams,CRoleTeam)
        end
    end
    if self.m_teams then
        local t = {}
        t.TeamIdx = CRoleTeam.TeamId
        t.Heroes = CRoleTeam.Heroes
        if CRoleTeam.FriTeams and #CRoleTeam.FriTeams > 0 then 
            t.FriTeam = CRoleTeam.FriTeams[1]
        end
        t.CommandSkills = CRoleTeam.CommanderSkills
        t.GarrisonHeroIds = {} --驻守
        local exsit = false
        for i = 1 , #self.m_teams do
            local team = self.m_teams[i]
            if team.TeamIdx == teamIdx then
                self.m_teams[i] = t
                exsit = true
            end
        end
        if not exsit then 
            table.insert( self.m_teams,t)
        end
    end
end


--获得A或B团队信息
function M:GetTeam(teamIdx,isForServer)
    if isForServer == nil then 
        isForServer = true
    end
    if isForServer then 
        if self.m_teams then
            for _,team in ipairs(self.m_teams) do
                if team.TeamIdx == teamIdx then
                    if team.CommandSkills == nil then 
                        team.CommandSkills = {}
                    end
                    return team
                end
            end
        end
        if self.m_teams == nil then 
            self.m_teams = {}
        end
        --A 的助战需要复制到B中
        local teamData = {TeamIdx=teamIdx,Heroes={},CommandSkills={},State=0,FriTeam=nil}
        table.insert(self.m_teams , teamData)
        return teamData
    end
    if self.m_enTeams then
        for i = 1 , #self.m_enTeams do 
            local enTeam = self.m_enTeams[i]
            if enTeam.TeamId == teamIdx then 
                return enTeam
            end
        end
        local t = {TeamId=teamIdx,FriTeams={}}
        table.insert(self.m_enTeams,t)
        return t 
    end
end

--设置助战
function M:SetFriend(teamIdx,friTeam)
    local teamServer = self:GetTeam(teamIdx,true)
    if friTeam then 
        teamServer.FriTeam = {FriendId=friTeam.FriendId,HeroId=friTeam.HeroData:GetHeroId()}
    else
        teamServer.FriTeam = nil
    end
    if friTeam == nil then 
        return
    end
    local teamCommon = self:GetTeam(teamIdx,false)
    teamCommon.FriTeams = teamCommon.FriTeams or {}
    for i = 1 , #teamCommon.FriTeams do 
        if teamCommon.FriTeams[i].HeroId ==  teamServer.FriTeam.FriendId then 
            return
        end
    end
    --只有一个助战
    teamCommon.FriTeams = {}
    table.insert(teamCommon.FriTeams,teamServer.FriTeam)
end

function M:GetFriend( teamIdx)
    local teamServer = self:GetTeam(teamIdx,true)
    return teamServer.FriTeam
end

--获得编队team
function M:GetConfTeam()
    -- B关卡自动上阵A关卡除驻守角色之外的角色
    if self.m_teams[1] and self.m_teams[1].GarrisonHeroIds and #self.m_teams[1].GarrisonHeroIds > 0 then 
        if self.m_teams[2] == nil then 
            self.m_teams[2] = {TeamIdx=1}
            self.m_enTeams[2] = {TeamId=1}
        end
        -- if self.m_teams[2] and ( self.m_teams[2].Heroes == nil or #self.m_teams[2].Heroes == 0 ) then 
        --     local garrisionHeroIds = self.m_teams[1].GarrisonHeroIds
        --     local team1Heros = self.m_enTeams[1].Heroes
        --     local commandSkills = {}
        --     if self.m_teams[1].CommandSkills then 
        --         for i = 1 , #self.m_teams[1].CommandSkills do 
        --             table.insert(commandSkills,self.m_teams[1].CommandSkills[i])
        --         end
        --     end

        --     local team2Heros = {}
        --     for i = 1 , #team1Heros do
        --         local hId = team1Heros[i]
        --         if not table.indexof(garrisionHeroIds,hId) then 
        --             table.insert(team2Heros, hId)
        --         end
        --     end
        --     self.m_enTeams[2].Heroes = team2Heros
        --     self.m_enTeams[2].CommanderSkills = commandSkills
        --     self.m_teams[2].Heroes = team2Heros
        --     self.m_teams[2].CommandSkills = commandSkills
        -- end
    end
    return self.m_enTeams
end

function M:GetTeams()
    return self.m_teams
end

-- 双点通关奖励
function M:Reward()
    return self.m_zoneCfg.reward
end

function M:Chose()
    return self.m_zoneCfg.chose
end

-- 一次通2关
function M:IsPassAll()
    -- local passNum = 0 
    return self:IsPass(true) and self:IsPass(false)
    -- for _,team in ipairs(self.m_teams) do
    --     passNum = passNum + 1 
    --     if not self:IsPass(team.TeamIdx) then 
    --         return false
    --     end
    -- end
    -- if passNum == 2 then 
    --     return true
    -- end
    -- return false
end

return M
