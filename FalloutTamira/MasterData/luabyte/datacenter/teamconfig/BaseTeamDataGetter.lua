-- 编队获得数据基类
local BaseTeamDataGetter = BaseClass("BaseTeamDataGetter")
local M = BaseTeamDataGetter
local _notTips = false

function M:__init()
    self._defaultTeamId = 1
end

-- 获得team最大数据
function M:GetTeamMaxNum()
    return 4
end

-- 加载数据
function M:LoadData(callback)

end

-- 通过teamId获得team数据
function M:GetTeamById(teamId)

end

-- 设置默认teamId
function M:SetDefaultTeamId(teamId)
    self._defaultTeamId = teamId
end

-- 获得默认teamId
function M:GetDefaultTeamId()
    return self._defaultTeamId
end

-- 获得指挥官技能
function M:GetCommanderSkills(teamId)
    local teamData = self:GetTeamById(teamId)
    if not teamData then
        return {}
    end
    return teamData.CommanderSkills or {}
end

-- 黑名单，这些黑名单不允许上阵，
function M:GetBlackList()
    return nil
end

-- 助战是否可以更换
function M:CanChangeFriendHelp()
    return true
end

-- 添加英雄的时候需要判断数量
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

function M:IsSameSelf(teamIdx, heroId)
    local FriendHero = self:GetFriendHeroData(teamId)
    if FriendHero == nil or not FriendHero.FriendId then
        return
    end
    return FriendHero.HeroData:GetHeroId() == heroId
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

function M:SetFriendHeroData(teamId, friendHero)
    if not self.friendHeroData then
        self.friendHeroData = {}
    end
    self.friendHeroData[teamId] = friendHero
end

function M:GetFriendHeroData(teamId)
    if not self.friendHeroData then
        return {}
    end
    return self.friendHeroData[teamId] or {}
end

-- 本次不提示编队平均等级过低(所有战斗模式都使用统一的提示逻辑)
function M:GetNotTips()
    return _notTips
end

function M:SetNotTips(state)
    _notTips = state
end

-- 获得编队名称
function M:GetTeamName(teamId)
    local teamData = self:GetTeamById(teamId)
    if not teamData then
        local teamName = ConfigHelper.GetLocalString(7 + teamId)
        return teamName
    end
    local name = teamData.Name
    if not name or #name <= 0 then
        name = ConfigHelper.GetLocalString(7 + teamId)
    end
    return name
end

-- 是否显示好友助战
function M:IsShowFriendHero()
    return true
end

-- 是否显示编队名称
function M:IsShowTeamName()
    return true
end

-- 更新编队
function M:RequestUpdateTeam(teamData)

end

-- 创建编队
function M:RequestCreateTeam(CRoleTeam)

end

-- 开战前是否需要激活队伍
function M:NeedActiveTeam()
    return true
end

-- 开战最低战员限制,即必须要这么多人才行
function M:CheckMinFighter(num)
    return num >= 1
end

function M:SetBattle(battle, jumpBattleMissionId)
    self.battle = battle
    self.jumpBattleMissionId = jumpBattleMissionId or self._battleMissionId
end

return M
