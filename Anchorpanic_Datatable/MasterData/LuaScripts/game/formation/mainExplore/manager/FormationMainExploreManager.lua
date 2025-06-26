--[[ 
-----------------------------------------------------
@filename       : FormationMainExploreManager
@Description    : 主探索·副本备战
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]

module("formation.FormationMainExploreManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法

function setData(self, type, dataId, data, callFun)
    super.setData(self, type, dataId, data, callFun)
end

-- 获取出战的队列id列表
function getFightTeamIdList(self)
    local allTeamIdList = self:getAllTeamIdList()
    return allTeamIdList
end

-- 获取出战中的队列id
function getFightTeamId(self)
    -- 服务器返回来的只有一个，是非出战状态，需客户端特殊处理
    local allTeamIdList = self:getAllTeamIdList()
    if (not table.empty(allTeamIdList)) then
        return allTeamIdList[1]
    end
end

-- 给外部直接获取出战中的队列id
function getFightTeamId2(self, type, dataId)
    -- 服务器返回来的只有一个，是非出战状态，需客户端特殊处理
    local allTeamIdList = formation.getTeamIdListByType(type, dataId)
    if (not table.empty(allTeamIdList)) then
        return allTeamIdList[1]
    end
end

-- 操作队列对应的英雄列表
-- teamId：操作的队列id
-- formationId：操作的阵型id
-- selectHeroId：选择的英雄的id
-- selectHeroTid：选择的英雄的tid
-- selectHeroSourceType：选择的英雄的类型
-- targetPos：要替换的目标格子位置
function setSelectFormationHeroList(self, teamId, formationId, selectHeroId, selectHeroTid, selectHeroSourceType, targetPos, isCheckCan)
    local selectFormationHeroVo = nil
    local targetFormationHeroVo = nil
    local allFormationHeroList = self:getSelectFormationHeroList(teamId)
    for i = #allFormationHeroList, 1, -1 do
        if (allFormationHeroList[i].heroPos == targetPos) then
            targetFormationHeroVo = allFormationHeroList[i]
        end
        if (allFormationHeroList[i].heroId == selectHeroId) then
            selectFormationHeroVo = allFormationHeroList[i]
        end
    end
    if (targetFormationHeroVo) then
        -- 下阵英雄或交换英雄
        if (selectFormationHeroVo) then
            if(targetFormationHeroVo.heroId == selectHeroId)then
                -- 删除英雄，判断是否出战队列，是出战队列则需要保留至少一个我方英雄，不是出战队列则可以全部下阵
                if (teamId == self:getFightTeamId()) then
                    -- 迷宫特殊修改
                    -- -- 判断删除后是否留有至少一个玩家自己的英雄
                    -- if(selectHeroSourceType == formation.HERO_SOURCE_TYPE.OWN)then
                    --     local ownCount = self:getSelectFilterHeroCount(teamId, formation.HERO_SOURCE_TYPE.OWN)
                    --     if (ownCount <= 1 and targetFormationHeroVo.heroId == selectHeroId) then
                    --         if(#allFormationHeroList > ownCount)then
                    --             gs.Message.Show("请至少保留一个我方战员")
                    --         else
                    --             gs.Message.Show("不可下阵全部战员")
                    --         end
                    --         return false
                    --     end
                    -- end

                    -- 判断删除后是否留有至少一个英雄
                    local allCount = self:getSelectFilterHeroCount(teamId)
                    if(allCount <= 1)then
                        gs.Message.Show(_TT(1252))
                        return false
                    end
                end
                for i = #allFormationHeroList, 1, -1 do
                    local delFormationHeroVo = allFormationHeroList[i]
                    if (delFormationHeroVo.heroPos == targetPos) then
                        LuaPoolMgr:poolRecover(delFormationHeroVo)
                        table.remove(allFormationHeroList, i)
                        break
                    end
                end
            else
                -- 交换英雄
                targetFormationHeroVo.heroPos, selectFormationHeroVo.heroPos = selectFormationHeroVo.heroPos, targetFormationHeroVo.heroPos
            end
        else
            -- 更换英雄，判断是否出战队列，是出战队列则需要保留至少一个我方英雄，不是出战队列则可以全部下阵
            if (teamId == self:getFightTeamId()) then
                -- 迷宫特殊修改
                -- -- 判断更换后是否留有至少一个玩家自己的英雄
                -- if(selectHeroSourceType ~= formation.HERO_SOURCE_TYPE.OWN)then
                --     local ownCount = self:getSelectFilterHeroCount(teamId, formation.HERO_SOURCE_TYPE.OWN)
                --     if (ownCount <= 1 and targetFormationHeroVo.heroId ~= selectHeroId) then
                --         if(targetFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN)then
                --             gs.Message.Show("请至少保留一个我方战员")
                --             return false
                --         end
                --     end
                -- end
            end

            -- 更换英雄，判断选择能否上阵，当前选择的英雄是否存在当前阵型中，同一个阵型中不允许有相同tid的英雄
            for i = 1, #allFormationHeroList do
                local formationHeroVo = allFormationHeroList[i]
                -- 排除同一阵型格子
                if (formationHeroVo.heroPos ~= targetPos) then
                    -- 排除同一英雄id
                    if (formationHeroVo.heroId ~= selectHeroId) then
                        -- 过滤相同tid的
                        if (formationHeroVo:getHeroTid() == selectHeroTid) then
                            gs.Message.Show(_TT(1253))
                            return false
                        end
                    end
                end
            end

            -- 确保在助战中的相同英雄被替换成功才允许添加到助战
            local isCan = true
            if(isCheckCan)then
                local updateAssistHeroVo = self:getSelectTeamAssistHeroVoById(teamId, selectHeroId, selectHeroSourceType)
                if(updateAssistHeroVo)then
                    isCan = false
                    local result = self:setSelectTeamAssistHeroList(teamId, formationId, targetFormationHeroVo.heroId, targetFormationHeroVo:getHeroTid(), selectHeroSourceType, updateAssistHeroVo.heroPos, false)
                    if(result)then
                        isCan = true
                    end
                end
            end

            if(isCan)then
                targetFormationHeroVo.heroId = selectHeroId
                targetFormationHeroVo.heroPos = targetFormationHeroVo.heroPos
                targetFormationHeroVo.sourceType = selectHeroSourceType
                
                local heroVo = hero.HeroManager:getHeroVo(targetFormationHeroVo.heroId)
                if heroVo then
                    local orgData = heroVo:getConfigVo():getOrgData()
                    if orgData and orgData.join_voice then
                        AudioManager:playHeroCVOnReplace(orgData.join_voice)
                    end
                end
            end
        end
    else
        -- 更换位置或添加英雄
        if(selectFormationHeroVo)then
            -- 更换位置
            selectFormationHeroVo.heroPos = targetPos
        else
            -- 上阵英雄，判断能否上阵，当前选择的英雄是否存在当前阵型中，同一个阵型中不允许有相同tid的英雄
            for i = 1, #allFormationHeroList do
                local formationHeroVo = allFormationHeroList[i]
                -- 排除同一阵型格子
                if (formationHeroVo.heroPos ~= targetPos) then
                    -- 排除同一英雄id
                    if (formationHeroVo.heroId ~= selectHeroId) then
                        -- 过滤相同tid的
                        if (formationHeroVo:getHeroTid() == selectHeroTid) then
                            gs.Message.Show(_TT(1254))
                            return false
                        end
                    end
                end
            end
            -- 判断上阵的上限
            local heroMaxCount = self:getFormationHeroMaxCount(formationId)
            local allCount = self:getSelectFilterHeroCount(teamId)
            if (allCount >= heroMaxCount) then
                gs.Message.Show(_TT(1242, heroMaxCount))
                return false
            end
            
            -- 确保在出战中的相同英雄被移除成功才允许添加到助战
            local isCan = true
            if(isCheckCan)then
                local delAssistHeroVo = self:getSelectTeamAssistHeroVoById(teamId, selectHeroId, selectHeroSourceType)
                if(delAssistHeroVo)then
                    isCan = false
                    local result = self:setSelectTeamAssistHeroList(teamId, formationId, selectHeroId, selectHeroTid, selectHeroSourceType, delAssistHeroVo.heroPos, false)
                    if(result)then
                        isCan = true
                    end
                end
            end

            if(isCan)then
                -- 添加英雄
                local addFormationHeroVo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
                addFormationHeroVo.heroId = selectHeroId
                addFormationHeroVo.heroPos = targetPos
                addFormationHeroVo.sourceType = selectHeroSourceType
                table.insert(allFormationHeroList, addFormationHeroVo)
                
                local heroVo = hero.HeroManager:getHeroVo(addFormationHeroVo.heroId)
                if heroVo then
                    local orgData = heroVo:getConfigVo():getOrgData()
                    if orgData and orgData.join_voice then
                        AudioManager:playHeroCVOnReplace(orgData.join_voice)
                    end
                end
            end
        end
    end
    self:validateCaptain(teamId)
    self:dispatchEvent(self.UPDATE_TEAM_FORMATION_DATA, {})
    return true
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1254):	"不可上阵相同战员"
	语言包: _TT(1253):	"已有相同战员"
	语言包: _TT(1252):	"不可下阵全部战员"
]]
