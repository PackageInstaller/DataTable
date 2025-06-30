--[[
-----------------------------------------------------
@filename       : FormationGuildBossImitateManager
@Description    : 地图探索副本
@date           : 2023-10-23 16:07:44
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]

module("formation.FormationGuildBossImitateManager", Class.impl("game.formation.normal.manager.FormationManager"))

function getFightTeamId(self)
    -- 服务器返回来的只有一个，是非出战状态，需客户端特殊处理
    local allTeamIdList = self:getAllTeamIdList()
    if (not table.empty(allTeamIdList)) then
        return allTeamIdList[1]
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
