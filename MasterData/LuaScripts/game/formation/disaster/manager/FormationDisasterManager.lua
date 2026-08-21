--[[ 
-----------------------------------------------------
@filename       : FormationDisasterManager
@Description    : 灾厄阵型管理器

@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]

module("formation.FormationDisasterManager", Class.impl("game.formation.normal.manager.FormationManager"))
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
    return {}
    -- local teamList = {}
    -- if next(self:instance().mTempPetDic) then
    --     for k, v in pairs(self:instance().mTempPetDic) do
    --         if v == petId then
    --             table.insert(teamList, k)
    --         end
    --     end
    -- end
    -- return teamList
end

function getFightFormationId(self, teamId)
    local lock, formationId = self:isLockFormation()
    if lock == 1 then
        return formationId
    end

    teamId = teamId and teamId or self:getFightTeamId()
    local teamVo = self:getTeamVoByTeamId(teamId)
    if (teamVo) then
        return teamVo.formationId
    end
end


function setIsReadTeamId(self,id,isImi)
    self.isReadId = id
    self.isImi = isImi
end

function getIsReadTeamId(self)
    return self.isReadId, self.isImi 
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]