--[[ 
-----------------------------------------------------
@filename       : FormationArenaPeakAttackManager
@Description    : 巅峰竞技场进攻管理器
@date           : 2023-09-25 16:12:21
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationArenaPeakAttackManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法

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

--[[ 替换语言包自动生成，请勿修改！
]]