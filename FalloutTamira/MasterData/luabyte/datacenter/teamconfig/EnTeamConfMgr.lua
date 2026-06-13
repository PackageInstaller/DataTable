--- 遭遇战 编队信息
local EnTeamConfMgr = BaseClass("EnTeamConfMgr", Singleton)
local M = EnTeamConfMgr
local MessageId = Proto.MessageId
local tInsert = table.insert
function M:GetPlandAId()
    return self._teamType.PlandA
end

function M:GetPlandBId()
    return self._teamType.PlandB
end

--获得已上锁英雄
function M:GetLockedHeroIds()
    --只可能有1队的英雄被锁
    local temaIdxs = { self:GetPlandAId(), self:GetPlandBId() }
    for _, teamIdx in ipairs(temaIdxs) do
        if self:IsPass(teamIdx) then
            return self:GetHeroIdsByType(teamIdx)
        end
    end
    return {}
end

--获得遭遇战开战数据
function M:GetMissionProtoData(selectIdx)
    local zoneId = self._zoneData:ZoneId()
    local emissionIds = self._zoneData:ZoneMissions()
    local selectEmissionId = emissionIds[selectIdx + 1]
    local emissions = { selectEmissionId }
    local teamIdxs = { selectIdx }
    local mCfg = ConfigHelper.GetCfg("encounterMission", selectEmissionId)
    local missionIds = { mCfg.missionId }
    for tmpIdx, emId in ipairs(emissionIds) do
        if emId ~= selectEmissionId and not self:_IsPassByEmission(emId) then
            tInsert(emissions, emId)
            mCfg = ConfigHelper.GetCfg("encounterMission", emId)
            tInsert(missionIds, mCfg.missionId)
            tInsert(teamIdxs, tmpIdx - 1)
        end
    end
    return zoneId, emissions, emissions, teamIdxs
end

function M:GetFriendHeroDataById(teamId)
    if not self._friendDatas then
        return nil
    end
    return self._friendDatas[teamId]
end

function M:GetFriendHeroIdByTeamId(teamId)
    local teamData = self:GetFriendHeroDataById(teamId)
    if teamData and teamData.FriendId then
        local csHeroData = teamData.HeroData
        return csHeroData:GetHeroId()
    end
    return 0
end

function M:SetFriendHeroDataById(teamId, heroData)
    if not self._friendDatas then
        self._friendDatas = {}
    end
    self._friendDatas[teamId] = heroData
end

function M:GetHeroIdsByType(type)
    local ids = {}
    local data = self._teamData:GetTeam(type)
    if data and data.Heroes then
        for i, v in ipairs(data.Heroes) do
            if v > 0 then
                tInsert(ids, v)
            end
        end
    end
    return ids
end

--查找英雄的编队信息 Return 编队ID、上阵索引
function M:FindHero(heroId)
    local index = nil
    local teamId = nil

    for i, v in pairs(self._teamData:GetTeams()) do
        index = MapUtil.FindKey(v.Heroes, function(v) return (v == heroId) end)
        if index ~= nil then
            teamId = v.TeamIdx
            return teamId, index
        end
    end
    return teamId, index
end

function M:FindFriendHero(friendId, heroId)
    for i, v in pairs(self._teamType) do
        local data = self:GetFriendHeroDataById(v)
        if data.FriendId then
            if data.FriendId == friendId and data.HeroData:GetHeroId() == heroId then
                return v
            end
        end
    end

    return
end

-- 清空队伍
function M:ClaerPlandHeroList(type)
    local teamData = self._teamData:GetTeam(type)
    teamData.Heroes = {}
    self:_SendRequestCreateTeam(type, {})
end

function M:_IsPassByEmission(emissionId)
    local emissionIds = self._zoneData:ZoneMissions()
    local idx = table.indexof(emissionIds, emissionId)
    if idx then
        local teamIdx = idx - 1
        return self:IsPass(teamIdx)
    end
    return false
end

-- 是否通关
function M:IsPass(type)
    return self._teamData:IsPass(type)
end

function M:IsAllPass()
    return self._teamData:IsPassAll()
end

--获得当前奖励{EncountConst.EEncountZoneBattleAward.EFirstPassGain={itemId1=itemNum1,itemId2=itemNum2,....},...}
function M:GetGainRewardState()
    self.m_lastRewardState = self.m_lastRewardState or 0
    local curState = self._teamData.m_rewardState
    local rewardDic = {}

    if self.m_lastRewardState == self._teamData.m_rewardState or self.m_lastRewardState == 3 then
        return rewardDic
    end

    for i = 1, 2 do
        local reward = nil
        if curState == 3 then
            if i ~= self.m_lastRewardState then
                local teamType = i
                local emissionCfg = self._teamData:GetEMissionCfg(teamType)
                reward = emissionCfg.reward
            end
        else
            if i == curState then
                local teamType = i
                local emissionCfg = self._teamData:GetEMissionCfg(teamType)
                reward = emissionCfg.reward
            end
        end

        if reward then
            local rewardObj = {}
            for i = 1, #reward / 2 do
                local itemId = reward[i * 2 - 1]
                local itemNum = reward[i * 2]
                rewardObj[itemId] = itemNum
            end
            rewardDic[i] = rewardObj
        end
    end

    if curState == 3 then
        reward = self._teamData:Reward()
        if reward then
            local rewardObj = {}
            for i = 1, #reward / 2 do
                local itemId = reward[i * 2 - 1]
                local itemNum = reward[i * 2]
                rewardObj[itemId] = itemNum
            end
            rewardDic[curState] = rewardObj
        end
    end

    return rewardDic
end

--解锁
function M:UnlockTeam(teamIdx, unlockCallback)
    self._unlockTeamIdx = teamIdx
    self._unlockCallback = unlockCallback
    NetPack:SendMessage(MessageId.RequestEncouterUnlockTeam, { ZoneId = self._teamData:ZoneId(), TeamIdx = teamIdx })
end

function M:_OnResponseEncouterUnlockTeam(msgId, result, msg)
    if result ~= 0 then
        return
    end
    self._teamData:ResetPass(self._unlockTeamIdx)
    if self._unlockCallback then
        self._unlockCallback()
    end
end

--设置指挥官技能(目前策划倾向A\B两个编队使用1套指挥官技能，暂时将两个编队的指挥官技能相同)
function M:SetCommandSkills(commandSkillIds)
    local team = self._teamData:GetTeam(self._teamType.PlandA)
    team.CommandSkills = commandSkillIds
    --只发1个，后面确定了之后再考虑改协议
    self:_SendRequestCreateTeam(self._teamType.PlandA)
end

--获得指挥官技能
function M:GetCommandSkills()
    local team = self._teamData:GetTeam(self._teamType.PlandA)
    return team.CommandSkills
end

-- 上阵英雄
function M:SetPlandHero(type, heroId)
    local teamData = self._teamData:GetTeam(type)
    tInsert(teamData.Heroes, heroId)
    self:_SendRequestCreateTeam(type)
end

-- 下阵英雄
function M:DownPlandHero(type, index)
    local teamData = self._teamData:GetTeam(type)
    table.remove(teamData.Heroes, index)
    self:_SendRequestCreateTeam(type)
end

-- 上阵好友英雄
function M:SetPlandFriendHero(type, data)
    self:_SendRequestCreateTeam(type, nil)
end

-- 下阵好友英雄
function M:DownPlandFriendHero(type)
    self:_SendRequestCreateTeam(type, nil)
end

--获得遭遇战编队信息 teamIdx为A，B关的teamIdx
function M:GetTeam(teamIdx)
    local team = self._teamData:GetTeam(teamIdx)
    -- team 对应proto中的EncounterTeam
    return team
end

--获得编队词条，含赛季和区域词条
function M:GetTeamEntry(teamIdx)

end

function M:_SendRequestCreateTeam(type)
    local teamData = self._teamData:GetTeam(type)
    --data = data or self:GetFriendHeroDataById(type)

    -- 获取上阵英雄id
    local myTeam = {}
    for i, v in pairs(teamData.Heroes) do
        tInsert(myTeam, v)
    end
    -- 获取好友英雄id
    -- local friendTeam = nil
    -- if data.FriendId then
    --     friendTeam = { FriendId = data.FriendId, HeroId = data.HeroData:GetHeroId()}
    -- end

    self:_SendRefreshTeam(type, teamData.CommandSkills, myTeam)
end

function M:_SendRefreshTeam(type, commandSkills, myTeam)
    local roleTeam = self:_GetTeamData(type, commandSkills, myTeam)
    local request = {}
    request.Team = roleTeam
    request.ZoneId = self._zoneData:ZoneId()
    NetPack:SendMessage(MessageId.RequestUpdateEncounterTeam, request)
end

--创建更新编队的协议数据
function M:_GetTeamData(teamIdx, commandSkills, heroIds)
    -- teamIdx = 0 表示A编队 ， teamIdx = 1 表示B编队
    local EncounterTeam = {}
    EncounterTeam.TeamIdx = teamIdx
    EncounterTeam.Heroes = heroIds
    EncounterTeam.CommandSkills = commandSkills
    EncounterTeam.State = 0 ---状态不用传，仅表示结构
    return EncounterTeam
end

function M:SetEncouter(EncounteData, idx)
    self._encounteData = EncounteData
    self._zoneData = self._encounteData:GetZoneDataByIdx(idx)
    self._teamData = self._zoneData
end

--记录进入战斗，用于结算时一共打了几场
function M:RecordEnterBattle()
    self.m_lastRewardState = self._teamData.m_rewardState
end

function M:GetEncounterData()
    return self._encounteData
end

--加载遭遇战 AB 编队(弃用)
function M:LoadEnTeamData()
    -- self._teamData = { [self._teamType.PlandA] = {}, [self._teamType.PlandB] = {} }
    -- for _,v in pairs(self._teamType) do
    --     local myTeam = TeamConfMgr:GetInstance():GetTeamById(v)

    --     if myTeam then
    --         for _,l in ipairs(myTeam.Heroes) do
    --             local data = {}
    --             data.heroId = l
    --             tInsert(self._teamData[v], data)
    --         end

    --         if #myTeam.FriTeams > 0 then
    --             FriendDataMgr:GetInstance():SendRequestHeroData(myTeam.FriTeams[1].HeroId, myTeam.FriTeams[1].FriendId, Bind(self, self._LoadEnTeamFriendData, myTeam.TeamId))
    --         end
    --     end
    -- end
end

function M:_OnResponseEncounterEnd(msgId, result, msg)
    if result ~= 0 or self._teamData == nil then
        return
    end
    if self._teamData:ZoneId() == msg.ZoneId then
        self._teamData:SetPassState(msg.State)
        self._teamData:SetRewardState(msg.RewardState)
    end

end

function M:__init()
    self._teamType = {
        PlandA = 0,
        PlandB = 1
    }
    self._friendDatas = {}
    self._friendDatas[self._teamType.PlandA] = {}
    self._friendDatas[self._teamType.PlandB] = {}
    self._ResponseEncounterEndHandle = NetPack:RegistResponse(MessageId.ResponseEncounterEnd,
        Bind(self, self._OnResponseEncounterEnd))
    --self._ResponseEncouterUnlockTeamHandle = NetPack:RegistResponse(MessageId.ResponseEncouterUnlockTeam,Bind(self,self._OnResponseEncouterUnlockTeam))
end

function M:Dispose()
    self._LoadTeam = nil
    --NetPack:UnRegistResponse(MessageId.ResponseEncouterUnlockTeam,self._ResponseEncouterUnlockTeamHandle)
    NetPack:UnRegistResponse(MessageId.ResponseEncounterEnd, self._ResponseEncounterEndHandle)
end

return EnTeamConfMgr
