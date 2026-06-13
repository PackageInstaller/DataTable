--遭遇战专用编队管理器
local EncounterConfMgr = BaseClass("EncounterConfMgr",require("DataCenter.TeamConfig.BaseTeamDataGetter"))
local M = EncounterConfMgr
local MessageId = Proto.MessageId
local EncounteData = require("DataCenter.Mission.EncounteData")
function M:__init()
    self._encounteData = nil
    self._isLoading = false
    self._callbacks = {}
    self.m_rsEnterEncounter = NetPack:RegistResponse( MessageId.ResponseEnterEncounter, Bind(self,self._OnResponseEnterEncounter))
    self._ResponseUpdateEncounterTeamHandler = NetPack:RegistResponse(MessageId.ResponseUpdateEncounterTeam,Bind(self,self._OnResponseUpdateEncounterTeam))
    self._OnResponseGarrisonHeroHandler = NetPack:RegistResponse(MessageId.ResponseGarrisonHero,Bind(self,self._OnResponseGarrisonHero))
    self._ResponseEncounterResetHandler = NetPack:RegistResponse(MessageId.ResponseEncounterReset,Bind(self,self._ResponseEncounterReset))
    self._RequestEncounterEndHandler = NetPack:RegistResponse(MessageId.ResponseEncounterEnd,Bind(self,self._ResponseEncounterEnd))
    self._RequestEncounterAwardsHandler = NetPack:RegistResponse(MessageId.ResponseEncounterAwards,Bind(self,self._ResponseEncounterAwards))
end

function M:GetInstance()
	if rawget(self, "Instance") == nil then
		rawset(self, "Instance", self.New())
	end
	assert(self.Instance ~= nil)
	return self.Instance
end

--设置A,B 1,2
function M:SetIndex(zoneIndex,abIndex)
    self._zoneIndex = zoneIndex
    self._curAbIndex = abIndex 
end

--获得team最大数据
function M:GetTeamMaxNum()
    return 1
end

--是否显示编队名称
function M:IsShowTeamName()
    return false
end

--interface BaseTeamDataGetter

function M:LoadData(callback)
    --NeedLastData 是否需要上次的数据
    if callback and not table.indexof(self._callbacks,callback) then 
        table.insert(self._callbacks,callback)
    end
    if self._encounteData then 
        if callback then 
            local list = {}
            if self._zoneIndex then 
                local arr = self._encounteData:GetTeams(self._zoneIndex)
                for i = 1 , #arr do 
                    local t = arr[i]
                    if t.TeamId == self._curAbIndex then 
                        table.insert(list,t)
                    end
                end
            end
            
            while #self._callbacks > 0 do 
                local callback = self._callbacks[1]
                table.remove(self._callbacks,1)
                callback(list,self._encounteData)
            end
            self._callbacks = {}
        end
        return 
    end
    local NeedLastData = 1
    if self._isLoading then 
        return
    end
    self._isLoading = true
    NetPack:SendMessage(MessageId.RequestEnterEncounter, { NeedLastData = NeedLastData })
end

function M:GetTeamById(teamId)
    --遭遇战teamId无意义
    local arr = self._encounteData:GetTeams(self._zoneIndex)
    for i = 1 , #arr do 
        local team = arr[i]
        if team.TeamId == self._curAbIndex then 
            return team
        end
    end
    return nil
end

--CHECK阵形，是否需要自动上阵
function M:CheckTeamData(abIdx)
    if abIdx ~= 0 then 
        return
    end
    local curItem = nil 
    local arr = self._encounteData:GetTeams(self._zoneIndex)
    for i = 1 , #arr do 
        local team = arr[i]
        if team.TeamId == abIdx then 
            curItem = team
        end
    end
    if curItem == nil or curItem.Heroes == nil or #curItem.Heroes == 0 then
        for idx = 1 , 5 do 
            if idx ~= self._zoneIndex then 
                local teamArr = self._encounteData:GetTeams(idx)
                local isBreak = false
                for i = 1 , #teamArr do 
                    local t = teamArr[i]
                    if t.Heroes and #t.Heroes > 0 then 
                        local newTeam = {}
                        newTeam.TeamId = 0
                        newTeam.Heroes = t.Heroes
                        newTeam.CommanderSkills = t.CommanderSkills
                        newTeam.HeroLength = #t.Heroes
                        newTeam.FriTeams = t.FriTeams
                        self._encounteData:UpdateTeamByCRoleTeam(self._zoneIndex,newTeam)
                        --保存阵型
                        self:RequestUpdateTeam(t)
                        isBreak = true
                        break
                    end
                end
                if isBreak then 
                    break
                end
            end
        end
    end
end

--黑名单
function M:GetBlackList()
    local canGarrsion,heroIds,lockNum,garrsionListIds = self:GetChangeGarrsionData(self._zoneIndex)
    if canGarrsion then 
        return garrsionListIds
    end
    return nil
end

--interface BaseTeamDataGetter end

--周期结束
function M:IsCycleOver()
    return self._encounteData:IsLastCycleSettlement()
end

function M:NewSeasonStart()
    return self._encounteData:IsNewSeason()
end

-- 进入遭遇战
function M:_OnResponseEnterEncounter(_, result, msg)
    self._isLoading = false
    if result ~= 0 then
         return 
    end

    local data = EncounteData.New()
    data:UpdateData(msg)
    self._encounteData = data    
    if self._callbacks then 
        local list = {}
        if self._zoneIndex then 
            local arr = data:GetTeams(self._zoneIndex)
            for i = 1 , #arr do 
                local t = arr[i]
                if t.TeamId == self._curAbIndex then 
                    table.insert(list,t)
                end
            end
        end

        while #self._callbacks > 0 do 
            local callback = self._callbacks[1]
            table.remove(self._callbacks,1)
            callback(list,self._encounteData)
        end
        self._callbacks = {}
        
    end
end

--更新编队
function M:RequestUpdateTeam(teamData,idx)
    --此处要模拟添加角色
    local RequestUpdateEncounterTeam = {}
    local EncounterTeam = {}
    idx = idx or self._curAbIndex
    EncounterTeam.TeamIdx = idx
    EncounterTeam.Heroes = teamData.Heroes
    EncounterTeam.CommandSkills = teamData.CommanderSkills
    if idx == 1 then 
        EncounterTeam.GarrisonHeroIds = {} --驻守英雄
    end
    
    if teamData.FriTeams and #teamData.FriTeams > 0 then 
        EncounterTeam.FriTeam = teamData.FriTeams[1]
    end
    local zoneId = self._encounteData:GetZoneId(self._zoneIndex)
    RequestUpdateEncounterTeam.ZoneId = zoneId
    RequestUpdateEncounterTeam.Team = EncounterTeam
    self._requestEncounterTeam = EncounterTeam
    self._requestCRoleTeam = teamData
    self._requestCRoleTeam.TeamId = idx
    NetPack:SendMessage(MessageId.RequestUpdateEncounterTeam,RequestUpdateEncounterTeam)
end

--进入战斗
function M:EnterBattle()

    local zoneId , emissionIds,missionIds,teamIds = self._encounteData:GetBattleData(self._zoneIndex,self._curAbIndex)
    IBattle:EnterEncounterBattle(zoneId,emissionIds,missionIds,teamIds)
    --好友助战不用保存
    --self.friendHeroData = {}
    --self._encounteData = nil
end

--驻守数据
function M:GetChangeGarrsionData(index)
    return self._encounteData:GetGarrsionData(index)
end

--驻守
function M:Garrsion(heroIds,callback)
    if heroIds == nil or #heroIds == 0 then 
        return 
    end
    self._garrsionHeroIds = heroIds
    self._RequestGarrisonHeroCallback = callback
    local zoneId = self._encounteData:GetZoneId(self._zoneIndex)
    local RequestGarrisonHero = {}
    RequestGarrisonHero.ZoneId = zoneId
    RequestGarrisonHero.HeroIds = heroIds
    NetPack:SendMessage(MessageId.RequestGarrisonHero,RequestGarrisonHero)
end

--重置遭遇战
function M:ResetEncounter(callback)
    self._resetUncounterCallback = callback
    local zoneId = self._encounteData:GetZoneId(self._zoneIndex)
    local RequestEncounterReset = {}
    RequestEncounterReset.ZoneId = zoneId
    NetPack:SendMessage(MessageId.RequestEncounterReset,RequestEncounterReset)
end

--设置助战
function M:SetFriendHeroData(teamId,friendHero)
    --teamId无意义
    local zd = self._encounteData:GetZoneDataByIdx(self._zoneIndex)
    if zd then 
        zd:SetFriend(self._curAbIndex,friendHero)
    end
    local team = zd:GetTeam(self._curAbIndex,false)
    self:RequestUpdateTeam(team)
    M.super.SetFriendHeroData(self,self._curAbIndex,friendHero)
end

--获得助战
function M:GetFriendHeroData(teamId)
    --teamId无意义
    return M.super.GetFriendHeroData(self,self._curAbIndex)
end

--开战最低战员限制,即必须要这么多人才行
function M:CheckMinFighter(num)
    --B未限制
    if self._curAbIndex == 1 then 
        return num >= 1 
    end
    local canGarrsion,heroIds,lockNum,garrsionListIds = self:GetChangeGarrsionData(self._zoneIndex)
    if lockNum == nil then 
        lockNum = 1
    end
    if num < lockNum then 
        GameHelper.Tips(string.format(ConfigHelper.GetLocalString(5855),lockNum))
        return false
    end
    return true
end


--助战是否可以更换
function M:CanChangeFriendHelp()
    -- 当前为A关可以更换助战 
    -- if self._curAbIndex == 0 then 
    --     return true
    -- end
    -- -- 当前为B关，但无助战可以更换
    -- local bFriend = self:GetFriendHeroData()
    -- if bFriend == nil then 
    --     return true
    -- end
    -- local aFriend = nil 
    -- self.friendHeroData = self.friendHeroData or {}
    -- aFriend = self.friendHeroData[0]
    -- --当前为B关，但是A关有助战，则不能换
    -- if aFriend and aFriend.HeroId and aFriend.HeroId > 0 then 
    --     GameHelper.Tips("驻守在A关的助战角色不允许更换(请提供语言ID)")
    --     return false
    -- end
    return true
end

function M:_ResponseEncounterReset(_,result,msg)
    if result ~= 0 then 
        return
    end
    self._encounteData:ResetPass(self._zoneIndex)
    self.friendHeroData = {}
    if self._resetUncounterCallback then 
        self._resetUncounterCallback(self._encounteData)
    end
    self._resetUncounterCallback = nil
end

--遭遇战结算之后，清除缓存，下次进来会重新拉数据
function M:_ResponseEncounterEnd(_,result,msg)
    if result ~= 0 then 
        return 
    end
    local zd = self._encounteData:GetZoneDataByIdx(self._zoneIndex)
    --设置通关状态
    zd:SetPassState(msg.State)
    self._curFightZoneId = msg.ZoneId
    self._encounteData = nil
end

function M:_AwardArr2Table( passAward , key, awardArr )
    if key == "" or key == nil then 
        return
    end
    if passAward[key] or awardArr == nil then 
        return
    end
    passAward = passAward or {}
    local awardTable = {}
    for i = 1, #awardArr / 2 do
        local itemId = awardArr[i * 2 - 1]
        local itemNum = awardArr[i * 2]
        awardTable[itemId] = itemNum
    end
    
    if table.count(awardTable) == 0 then 
        return
    end
    passAward[key] = awardTable
end

function M:_OnResponseGarrisonHero(_,result,msg)
    if result ~= 0 then 
        return 
    end
    self._encounteData:UpdateGarrsion(self._zoneIndex,self._garrsionHeroIds)
    if self._RequestGarrisonHeroCallback  then 
        self._RequestGarrisonHeroCallback(self._garrsionHeroIds)
    end
    self._RequestGarrisonHeroCallback = nil

    --开战时，如果是A关卡，则复制A阵容到B
    local arr = self._encounteData:GetTeams(self._zoneIndex)
    local teamA = nil 
    local teamB = nil
    for i = 1 , #arr do 
        local team = arr[i]
        if team.TeamId == 0 then 
            teamA = team 
        elseif team.TeamId == 1 then
            teamB = team
        end
    end
    --直接将A的阵型复制到B
    if teamA and teamB == nil or teamB.Heroes == nil or #teamB.Heroes == 0 then 
        local CRoleTeam = {}
        CRoleTeam.TeamId = 1
        CRoleTeam.Heroes = {}
        for _, v in ipairs(teamA.Heroes) do
            -- body
            if not table.indexof(self._garrsionHeroIds,v) then 
                table.insert(CRoleTeam.Heroes,v)
            end
        end
        CRoleTeam.HeroLength = #CRoleTeam.Heroes
        CRoleTeam.CommanderSkills = table.arrayCopy(teamA.CommanderSkills)
        CRoleTeam.FriTeams = table.arrayCopy(teamA.FriTeams)
        self:RequestUpdateTeam(CRoleTeam,1)
    end
end

function M:_OnResponseUpdateEncounterTeam(_,result,msg)
    if result ~= 0 then 
        return 
    end
    self._encounteData:UpdateTeamByCRoleTeam(self._zoneIndex,self._requestCRoleTeam )
    EventMgr:Broadcast(UIMessageNames.UPDATETEAM)
end

--创建编队
function M:RequestCreateTeam(CRoleTeam)
    --此处要模拟删除角色
    self:RequestUpdateTeam(CRoleTeam)
end

--开战前是否需要激活队伍
function M:NeedActiveTeam()
    return false
end

function M:GetEncounterData()
    return self._encounteData
end

--当前进度的选区
function M:GetCurZoneIdx()
    local encounterData = self:GetEncounterData()
    local zoneDatas = encounterData:GetZoneDatas()
    for idx, zone in ipairs(zoneDatas) do
        -- body
        if zone:ZoneId() == self._curFightZoneId then 
            if zone:IsPassAll() then 
                return 0
            end
            return idx
        end
    end
    return 0
end

--是否可奖励 返回 可领，是否已领
function M:GanGainReward(zoneIdx,teamType)
    local encounterZoneData  = self._encounteData:GetZoneDataByIdx(zoneIdx)
    local canGain = encounterZoneData:CanGainReward(teamType)
    if canGain then 
        return canGain,false
    end
    local alreadyGain = encounterZoneData:GetAlreadyByTeamType(teamType)
    local isPass = encounterZoneData:IsPass(teamType==EncountConst.EEncountTeamType.ETeamA)
    if isPass then 
        return canGain,alreadyGain
    end
    return canGain,alreadyGain
end

--领奖
function M:GainEncounterAward(zoneIdx,missionId,callback)
    local zoneId = 0
    if zoneIdx > 0 then 
        local encounterData = EncounterConfMgr:GetInstance():GetEncounterData()
        local encounterZoneData = encounterData:GetZoneDataByIdx(zoneIdx)
        zoneId = encounterZoneData:ZoneId()
    end
    
    local obj = {}
    obj.ZoneId = zoneId and zoneId or 0
    obj.EncounterMissionId = missionId and missionId or 0
    NetPack:SendMessage(Proto.MessageId.RequestEncounterAwards,obj)
    self._gainEncounterAwardCallback = callback
end

function M:_ResponseEncounterAwards(_,result,msg)
    if result ~= 0 then 
        return
    end
    
    --设置领奖状态
    if msg.RewardStates then 
        for _,v in ipairs( msg.RewardStates) do
            local zd = self._encounteData:GetZoneById(v.ZoneId)
            zd:SetRewardState(v.RewardState)
        end
    end
    
    local awardData = {}
    for _,kv in ipairs(msg.Award) do
        if awardData[kv.Id] then
            awardData[kv.Id] = awardData[kv.Id] + kv.Cnt
        else
            awardData[kv.Id] = kv.Cnt
        end
    end

    EventMgr:Broadcast(UIMessageNames.ENCOUNT_GAIN_AWARD)

    GameHelper.ShowGetItems(awardData)
    if self._gainEncounterAwardCallback then 
        self._gainEncounterAwardCallback(msg.Award)
    end
    self._gainEncounterAwardCallback = nil

    IRedPointMgr:ForceCheck(RedPointConst.EncounterNewCycleRedPointChecker)
end

function M:GetAllMissionId()
    local encounterData = EncounterConfMgr:GetInstance():GetEncounterData()
    local zoneData = encounterData:GetZoneDatas()
    local zoneIds = {}
    local missionId = {}
    for k1, v1 in pairs(zoneData) do
        local emissions = v1:ZoneMissions()
        for k2, v2 in pairs(emissions) do
            local cfg = ConfigHelper.GetCfgByLua("encounterMission", v2)
            table.insert(zoneIds,v1:ZoneId())
            table.insert(missionId,cfg.missionId)
        end
    end
    return zoneIds,missionId
end

return M 

