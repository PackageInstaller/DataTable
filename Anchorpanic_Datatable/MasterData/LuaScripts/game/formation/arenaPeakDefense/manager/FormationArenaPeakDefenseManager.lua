--[[ 
-----------------------------------------------------
@filename       : FormationArenaPeakDefenseManager
@Description    : 巅峰竞技场防守管理器
@date           : 2023-09-25 16:12:21
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationArenaPeakDefenseManager", Class.impl("game/formation/arenaPeakAttack/manager/FormationArenaPeakAttackManager"))

-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法

-- 获取出战中的队列id
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
