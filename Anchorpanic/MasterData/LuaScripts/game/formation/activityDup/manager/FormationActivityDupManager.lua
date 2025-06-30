module("formation.FormationActivityDupManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法

-- -- 根据队列id获取出战中的阵型id (活动固定阵形)
-- function getFightFormationId(self, teamId)
--     local tempData = self:getData()
--     local formationId = tempData[1]
--     return formationId
-- end
function setData(self, type, dataId, data, callFun)
    super.setData(self, type, dataId, data, callFun)

    -- 是否第一次打开界面设置数据，仅为第一次设置数据时才为阵型空位填补剧情战员；每次关掉界面都会清掉非玩家自己的战员
    self.m_isFirstSet = true
end

-- 根据阵型id、列、行获取指定的阵型格子次序
function getFormationTilePos(self, formationId, colIndex, rowIndex)
    local formationConfigVo = self:getFormationConfigVo(formationId)

    local storyRo = self:getData()
    local tempData = storyRo:getEffectParam()

    if formationConfigVo then
        local formationConfigList = formationConfigVo:getFormationList()
        for i = 1, #formationConfigList do
            local pos = formationConfigList[i][1]
            local col_x = formationConfigList[i][2][1]
            local row_y = formationConfigList[i][2][2]
            if (col_x == colIndex and row_y == rowIndex) then
                for j = 2, #tempData do
                    if pos == tempData[j][1] then
                        -- 平民占位
                        return 0
                    end
                end
                return pos
            end
        end
    end
    return 0
end


-- 获取配置表里对应阵型的可上阵英雄数量
function getFormationHeroMaxCount(self, formationId)
    return 5
end

-- 根据队列id获取阵型选择中的英雄列表
function getSelectFormationHeroList(self, teamId)
    local selectFormationHeroList = super.getSelectFormationHeroList(self, teamId)
    -- 如果有空位默认上阵剧情战员
    if (self.m_isFirstSet) then
        self.m_isFirstSet = false
        local posDic = {}

        local curMonsterIndex = 0

        local storyRo = self:instance():getData()
        local tempData = storyRo:getEffectParam()

        local formationId = tempData[1]
        local formationDic = self:instance():getFormationConfigVo(formationId)
        local formationConfigList = formationDic:getFormationList()

        for i = 2, #tempData do
            posDic[tempData[i][1]] = true
        end

        for i = #selectFormationHeroList, 1, -1 do
            local vo = selectFormationHeroList[i]
            if posDic[vo.heroPos] then
                table.remove(selectFormationHeroList, i)
                -- elseif vo.heroPos > self:getFormationHeroMaxCount() then -- 6个变5个位置的时候会有显示问题，超过位置的下架，但是会影响正常6个位置的，所以先屏蔽
                --     table.remove(selectFormationHeroList, i)
            end
        end

        for j = #selectFormationHeroList, 1, -1 do
            local formationHeroVo = selectFormationHeroList[j]
            local hasPos = false
            for i = 1, #formationConfigList do
                local pos = formationConfigList[i][1]
                if (formationHeroVo.heroPos == pos) then
                    hasPos = true
                    break
                end
            end
            if not hasPos then
                -- 战员站在没开放的位置上，移除
                table.remove(selectFormationHeroList, j)
            end
        end
    end
    return selectFormationHeroList
end

-- 操作队列对应的英雄列表
-- teamId：操作的队列id
-- formationId：操作的阵型id
-- selectHeroId：选择的英雄的id
-- selectHeroTid：选择的英雄的tid
-- selectHeroSourceType：选择的英雄的类型
-- targetPos：要替换的目标格子位置
function setSelectFormationHeroList(self, teamId, formationId, selectHeroId, selectHeroTid, selectHeroSourceType,
targetPos, isCheckCan)
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
            if (targetFormationHeroVo.heroId == selectHeroId) then
                -- 删除英雄，判断是否出战队列，是出战队列则需要保留至少一个我方英雄，不是出战队列则可以全部下阵
                if (teamId == self:getFightTeamId()) then
                    -- 判断删除后是否留有至少一个玩家自己的英雄
                    if (selectHeroSourceType == formation.HERO_SOURCE_TYPE.OWN) then
                        local ownCount = self:getSelectFilterHeroCount(teamId, formation.HERO_SOURCE_TYPE.OWN)
                        if (ownCount <= 1 and targetFormationHeroVo.heroId == selectHeroId) then
                            if (#allFormationHeroList > ownCount) then
                                gs.Message.Show(_TT(1267))
                            else
                                gs.Message.Show(_TT(1252))
                            end
                            return false
                        end
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
                self:validateCaptain(teamId)
                self:dispatchEvent(self.UPDATE_TEAM_FORMATION_DATA, { targetPos = targetPos })
                return false
            else
                -- 交换英雄
                targetFormationHeroVo.heroPos, selectFormationHeroVo.heroPos = selectFormationHeroVo.heroPos,
                targetFormationHeroVo.heroPos
            end
        else
            -- 更换英雄，判断是否出战队列，是出战队列则需要保留至少一个我方英雄，不是出战队列则可以全部下阵
            if (teamId == self:getFightTeamId()) then
                -- 判断更换后是否留有至少一个玩家自己的英雄
                if (selectHeroSourceType ~= formation.HERO_SOURCE_TYPE.OWN) then
                    local ownCount = self:getSelectFilterHeroCount(teamId, formation.HERO_SOURCE_TYPE.OWN)
                    if (ownCount <= 1 and targetFormationHeroVo.heroId ~= selectHeroId) then
                        if (targetFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
                            gs.Message.Show(_TT(1267))
                            return false
                        end
                    end
                end
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
            if (isCheckCan) then
                local updateAssistHeroVo = self:getSelectTeamAssistHeroVoById(teamId, selectHeroId, selectHeroSourceType)
                if (updateAssistHeroVo) then
                    isCan = false
                    local result = self:setSelectTeamAssistHeroList(teamId, formationId, targetFormationHeroVo.heroId,
                    targetFormationHeroVo:getHeroTid(), selectHeroSourceType, updateAssistHeroVo.heroPos, false)
                    if (result) then
                        isCan = true
                    end
                end
            end

            if (isCan) then
                targetFormationHeroVo.heroId = selectHeroId
                targetFormationHeroVo.heroPos = targetFormationHeroVo.heroPos
                targetFormationHeroVo.sourceType = selectHeroSourceType

                local heroVo = hero.HeroManager:getHeroVo(targetFormationHeroVo.heroId)
                if heroVo then
                    AudioManager:playHeroCVByFieldName(heroVo.tid, "join_voice")
                end
            end
        end
    else
        -- 更换位置或添加英雄
        if (selectFormationHeroVo) then
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
            local allCount = self:getSelectFilterHeroCount(teamId, formation.HERO_SOURCE_TYPE.OWN)
            if (allCount >= heroMaxCount) then
                gs.Message.Show(_TT(1255) .. heroMaxCount)
                return false
            end

            -- 确保在出战中的相同英雄被移除成功才允许添加到助战
            local isCan = true
            if (isCheckCan) then
                local delAssistHeroVo = self:getSelectTeamAssistHeroVoById(teamId, selectHeroId, selectHeroSourceType)
                if (delAssistHeroVo) then
                    isCan = false
                    local result = self:setSelectTeamAssistHeroList(teamId, formationId, selectHeroId, selectHeroTid,
                    selectHeroSourceType, delAssistHeroVo.heroPos, false)
                    if (result) then
                        isCan = true
                    end
                end
            end

            if (isCan) then
                -- 添加英雄
                local addFormationHeroVo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
                addFormationHeroVo.heroId = selectHeroId
                addFormationHeroVo.heroPos = targetPos
                addFormationHeroVo.sourceType = selectHeroSourceType
                table.insert(allFormationHeroList, addFormationHeroVo)

                local heroVo = hero.HeroManager:getHeroVo(addFormationHeroVo.heroId)
                if heroVo then
                    AudioManager:playHeroCVByFieldName(heroVo.tid, "join_voice")
                end
            end
        end
    end
    self:validateCaptain(teamId)
    self:dispatchEvent(self.UPDATE_TEAM_FORMATION_DATA, { targetPos = targetPos })
    return true
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]