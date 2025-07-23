--[[ 
-----------------------------------------------------
@filename       : FormationGuildWarAtkManager
@Description    : 联盟团战进攻管理器
-----------------------------------------------------
]]
module("formation.FormationGuildWarAtkManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- 获取出战中的队列id
function getFightTeamId(self)
    -- 服务器返回来的只有一个，是非出战状态，需客户端特殊处理
    local allTeamIdList = self:getAllTeamIdList()
    if (not table.empty(allTeamIdList)) then
        return allTeamIdList[1]
    end
end

-- 锚驴在哪个队伍里使用(列表)
function getPetUseTeamIds(self, petId)
    local teamList = {}
    if next(self:instance().mTempPetDic) then
        for k, v in pairs(self:instance().mTempPetDic) do
            if v == petId then
                table.insert(teamList, k)
            end
        end
    end
    return teamList
end

return _M