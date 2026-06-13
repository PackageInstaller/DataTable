-- 通用编队管理器 需要实现接口
local TeamConfMgr = BaseClass("TeamConfMgr", require("DataCenter.TeamConfig.BaseTeamDataGetter"))
local M = TeamConfMgr
local defaultTeamId = "defaultTeamId"
local MessageId = Proto.MessageId
local TeamNameOffset = 6
local TEAMNUM = 4

function M:__init()
    self._TempResponseLoadTeamCallbackTemp = NetPack:RegistResponse(MessageId.ResponseLoadTeam, Bind(self, self._ResponseLoadTeamCallback))
    self._TempResponseCreateTeamTeamCallback = NetPack:RegistResponse(MessageId.ResponseCreateTeam, Bind(self, self._ResponseCreateTeamCallback))
end

function M:GetInstance()
    if rawget(self, "Instance") == nil then
        rawset(self, "Instance", self.New())
    end
    assert(self.Instance ~= nil)
    return self.Instance
end

-- 获得team最大数据
function M:GetTeamMaxNum()
    return TEAMNUM
end

-- IDataGetter start
-- 用于在登录的时候初始化相关数据
function M:LoadData(callback)
    if self.teamDatas and #self.teamDatas > 0 then
        self._isloading = false
        self._dataLoaded = true
        self._errorCode = 0

        if callback then
            callback(self.teamDatas)
        end
        return
    end

    self._callback = callback
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:GetTeamByServer()
    self:_InitDefaultTeamId()
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

-- IDataGetter end

-- 初始化本地读取默认的编队id
function M:_InitDefaultTeamId()
    self.defaultId = PlayerPrefTools.GetPlayerPrefsInt(defaultTeamId, 1)
end

-- 本地记录默认编队id
function M:SetDefaultTeamId(defaultId)
    self.defaultId = defaultId
    PlayerPrefTools.SetPlayerPrefs(defaultTeamId, defaultId)
end

function M:GetDefaultTeamId()
    if not self.defaultId then
        self:_InitDefaultTeamId()
    end
    return self.defaultId
end

-- 通过id获取战队信息
function M:GetTeamById(teamId)
    if not self.teamDatas or not self.teamDatas[1] then
        self.teamDatas = {}
        local tempTeamData = {}
        self.teamDatas[1] = tempTeamData
        tempTeamData.TeamId = teamId
        tempTeamData.HeroLength = 1
        tempTeamData.Name = ConfigHelper.GetLocalString(TeamNameOffset + teamId)
        tempTeamData.Heroes = {110003}
        tempTeamData.CommanderSkills = {}
    end

    -- id从0开始
    return self.teamDatas[teamId]
end

-- 设置上阵的好友英雄数据 数据结构 FriendId = 好友id HeroData = herodatanew
function M:SetFriendHeroData(teamId, data)
    if not self.friendHeroData then
        self.friendHeroData = {}
    end

    self.friendHeroData[teamId] = data
end

-- 获取上阵的好友英雄数据 数据结构 FriendId = 好友id HeroData = herodatanew
function M:GetFriendHeroData(teamId)
    if not self.friendHeroData then
        return {}
    end
    return self.friendHeroData[teamId] or {}
end

-- 埋点获取有英雄的编队数量
function M:GetTeamNum()
    if not self.teamDatas then
        return 0
    end

    local teamNum = 0

    for k, v in pairs(self.teamDatas) do
        if v.Heroes and #v.Heroes > 0 then
            teamNum = teamNum + 1
        end
    end
    return teamNum
end

function M:GetShowHeros()
    local lockLvs = ConfigHelper.GetSystemParams(4)
    local lv = IPlayerData.level
    local showNum = 0

    for k = 0, lockLvs.Length - 1 do
        if lockLvs[k] <= lv then
            showNum = k + 1
        end
    end
    return showNum
end

function M:GetTeamName(teamId)
    local teamData = self:GetTeamById(teamId)

    if not teamData then
        local teamName = ConfigHelper.GetLocalString(TeamNameOffset + teamId)
        return teamName
    end

    local name = teamData.Name

    if not name or #name <= 0 then
        name = ConfigHelper.GetLocalString(TeamNameOffset + teamId)
    end
    return name
end

function M:GetTeamByServer()
    NetPack:SendMessage(MessageId.RequestLoadTeam, {})
end

-- 获取编队技能
function M:GetCommanderSkills(teamId)
    teamId = teamId or self:GetDefaultTeamId()
    local teamData = self:GetTeamById(teamId)

    if not teamData then
        return {}
    end

    return teamData.CommanderSkills
end

-- 获得当前激活编队的信息
function M:GetAcitveTeamHeroDatas()
    return self:GetTeamById(IPlayerData.GetActiveTeamId)
end

function M:GetDefaultTeamHeros()
    local teamData = self:GetTeamById(self:GetDefaultTeamId())
    if not teamData then
        return {}
    end
    return teamData.Heroes
end

-- 是否是重复英雄(好友英雄是否在自己编队中已经装备)
function M:IsSameFri(teamId, heroId)
    local teamData = self:GetTeamById(teamId)

    if not (teamData and teamData.Heroes and #teamData.Heroes > 0) then
        return
    end

    for _, v in pairs(teamData.Heroes) do
        if v == heroId then
            return true
        end
    end
    return
end

-- 是否是重复英雄(好友英雄是否已经装备该英雄)
function M:IsSameSelf(teamId, heroId)
    local FriendHero = self:GetFriendHeroData(teamId)

    if not FriendHero.FriendId then
        return
    end
    return FriendHero.HeroData:GetHeroId() == heroId
end

-- 更新战员信息
function M:_UpdataTeamDatas(data)
    if not self.teamDatas then
        self.teamDatas = {}
    end

    self.teamDatas[data.TeamId] = data
end

-- isWanted：悬赏模式
function M:OpenTeamConfUI(isTeach, battleMissionId, teamConfigStyle, heroId, battleStyle)
    self._isTeach = isTeach
    self._battleMissionId = battleMissionId
    self._teamConfigStyle = teamConfigStyle
    self._isOpenUI = true

    return UIContextMgr:GetInstance():Show(UIDefine.UITeamConfig, self._isTeach, self._battleMissionId, self._teamConfigStyle, heroId, battleStyle)
end

function M:GetBattleId()
    return self._battleMissionId
end

------------------------------------Start-------------------------------------------

-- 创建编队
function M:RequestCreateTeam(RoleTeam)
    -- Logger.LogError("AAAAAA 创建Req")
    local request = {}
    request.RoleTeam = RoleTeam
    NetPack:SendMessage(MessageId.RequestCreateTeam, request)
end

-- 更新和删除编队 Operate: 修改0，删除1
function M:RequestUpdateTeam(RoleTeam)
    -- Logger.LogError("更新和删除编队Req")
    self._TempResponseUpdateTeamCallback = NetPack:RegistResponse(MessageId.ResponseUpdateTeam, Bind(self, self._ResponseUpdateTeamCallback))
    local request = {}
    request.Operate = 0
    request.RoleTeam = RoleTeam
    NetPack:SendMessage(MessageId.RequestUpdateTeam, request)
end

-- 加载队伍
function M:_ResponseLoadTeamCallback(messagId, result, msg)
    -- Logger.LogError("请求编队回应")
    self._isloading = false
    self._dataLoaded = true
    self._errorCode = result

    if result ~= 0 then
        if self._callback then
            self._callback(nil)
        end
        return
    end

    self.teamDatas = {}

    for i = 1, #msg.Data do
        self:_UpdataTeamDatas(msg.Data[i])
    end

    -- 初始化遭遇战数据
    EnTeamConfMgr:GetInstance():LoadEnTeamData()

    if self._callback then
        self._callback(self.teamDatas)
    end

    self._callback = nil
end

-- 更新和删除队伍
function M:_ResponseUpdateTeamCallback(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseUpdateTeam, self._TempResponseUpdateTeamCallback)
    self._TempResponseUpdateTeamCallback = nil

    if result ~= 0 then
        return
    end

    self:_UpdataTeamDatas(msg.RoleTeam)
    EventMgr:Broadcast(UIMessageNames.UPDATETEAM)
end

-- 创建队伍
function M:_ResponseCreateTeamCallback(messagId, result, msg)
    if result ~= 0 then
        return
    end

    self:_UpdataTeamDatas(msg.RoleTeam)
    EventMgr:Broadcast(UIMessageNames.UPDATETEAM)
end

------------------------------------End-------------------------------------------

-------------------------------跳转数据Start--------------------------------------

function M:SetBattle(battle, jumpBattleMissionId)
    self.battle = battle
    self.jumpBattleMissionId = jumpBattleMissionId or self._battleMissionId
end

-- 包小威
function M:SetBattleType(battleStyle)
    self.battleStyle = battleStyle
end

-------------------------------跳转数据End--------------------------------------

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseLoadTeam, self._TempResponseLoadTeamCallbackTemp)
    self._TempResponseLoadTeamCallbackTemp = nil

    NetPack:UnRegistResponse(MessageId.ResponseCreateTeam, self._TempResponseCreateTeamTeamCallback)
    self._TempResponseCreateTeamTeamCallback = nil
end

return TeamConfMgr
