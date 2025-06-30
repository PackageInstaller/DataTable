module("formation.FormationMainSupportManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法

function setData(self, type, dataId, data, callFun)
    super.setData(self, type, dataId, data, callFun)
    
    -- 是否第一次打开界面设置数据，仅为第一次设置数据时才为阵型空位填补剧情战员；每次关掉界面都会清掉非玩家自己的战员
    self.m_isFirstSet = true
end

-- 根据队列id获取阵型选择中的英雄列表
function getSelectFormationHeroList(self, teamId)
    local selectFormationHeroList = super.getSelectFormationHeroList(self, teamId)
    -- 如果有空位默认上阵剧情战员
    if(self.m_isFirstSet)then
        self.m_isFirstSet = false
        local posDic = {}
        for key, value in pairs(selectFormationHeroList) do
            posDic[value.heroPos] = true
        end
        local curMonsterIndex = 0
        local monsterUniqueTidList = self:instance():getData().data
        local filterMonUniqueTidList = {}
        for i = 1, #monsterUniqueTidList do
            local monTid = monsterUniqueTidList[i]
            local monsterTidVo = monster.MonsterManager:getMonsterVo(monTid)
            local isExistSame = false
            for i = 1, #selectFormationHeroList do
                local formationHeroVo = selectFormationHeroList[i]
                if (formationHeroVo:getHeroTid() == monsterTidVo.tid) then
                    isExistSame = true
                    break
                end
            end
            if(not isExistSame)then
                table.insert(filterMonUniqueTidList, monTid)
            end
        end

        local formationId = self:instance():getFightFormationId(teamId)
        local formationConfigList = self:instance():getFormationConfigVo(formationId):getFormationList()
        for i = 1, #formationConfigList do
            local pos = formationConfigList[i][1]
            -- local col_x = formationConfigList[i][2][1]
            -- local row_y = formationConfigList[i][2][2]
            if(not posDic[pos])then
                posDic[pos] = true
                curMonsterIndex = curMonsterIndex + 1
                if(curMonsterIndex <= #filterMonUniqueTidList)then
                    local monsterTidVo = monster.MonsterManager:getMonsterVo(filterMonUniqueTidList[curMonsterIndex])
                    local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
                    vo.heroPos = pos
                    vo.heroId = monsterTidVo.uniqueTid
                    vo.sourceType = formation.HERO_SOURCE_TYPE.MAIN_STORY
        
                    vo.m_heroTid = monsterTidVo.tid
                    vo.m_heroLvl = monsterTidVo.lvl
                    vo.m_evolutionLvl = monsterTidVo.evolutionLvl
                    table.insert(selectFormationHeroList, vo)
                else
                    break
                end
            end
        end
    end
    return selectFormationHeroList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
