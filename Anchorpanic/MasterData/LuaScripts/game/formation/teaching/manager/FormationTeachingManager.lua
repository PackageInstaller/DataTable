--[[ 
-----------------------------------------------------
@filename       : FormationTeachingManager
@Description    : 上阵教学
@date           : 2021-08-31 15:13:34
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationTeachingManager", Class.impl("game.formation.normal.manager.FormationManager"))


-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法
-- 获取出战中的队列id
function getFightTeamId(self)
    -- 服务器返回来的只有一个，是非出战状态，需客户端特殊处理
    local allTeamIdList = self:getAllTeamIdList()
    if (not table.empty(allTeamIdList)) then
        return allTeamIdList[1]
    end
end

-- 根据队列id获取出战中的阵型id
function getFightFormationId(self, teamId)
    local effectList = self:getData():getEffectParam()
    local formationId = effectList[1][1]
    return formationId
end

-- 获取剧情配置英雄tid列表
function getHeroList(self)
    local effectList = self:getData():getEffectParam()
    local heroTidList = effectList[1]
    local list = {}
    -- 位置1是阵形id
    for i = 2, #heroTidList do
        table.insert(list, heroTidList[i])
    end
    return list
end
-- 根据队列id获取阵型选择中的英雄列表
function getSelectFormationHeroList(self, teamId)
    if not self.mSelectHeroList then
        self.mSelectHeroList = {}
    end
    return self.mSelectHeroList
end

-- 根据队列id获取对应的阵型英雄列表
function __getFormationHeroListByTeamId(self, teamId)
    if not self.mSelectHeroList then
        self.mSelectHeroList = {}
    end
    return self.mSelectHeroList
end

-- 获取英雄列表有变化的队列id列表
function getChangeTeamIdList(self)
    local allTeamIdList = self:getAllTeamIdList()
    return allTeamIdList
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
