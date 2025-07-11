--[[   
     英雄阵型选择界面
]]
module("formation.FormationMainSupportHeroSelectPanel", Class.impl(formation.FormationHeroSelectPanel))

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, self.mIsFilterUseState, self.m_isFindLike, self.m_isFindLock)
    local showRemoveVo = nil
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local isShowRemove = false
        if(self.tileFormationHeroVo 
        and self.tileFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN 
        and self.tileFormationHeroVo.heroId == heroVo.id 
        and self.tileFormationHeroVo:getHeroTid() == heroVo.tid)then
            isShowRemove = true
        end

        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({dataVo = heroVo, teamId = self.m_teamId, formationId = self.m_formationId, isShowRemove = isShowRemove, manager = self:getManager()})
        if(isShowRemove)then
            showRemoveVo = scrollVo
        else
            local isInFormation = self:getManager():isHeroInFormation(self.m_teamId, heroVo.id)
            if (isInFormation) then
                table.insert(scrollList, 1, scrollVo)
            else
                local isInAssist = self:getManager():isHeroInAssist(self.m_teamId, heroVo.id)
                if(isInAssist)then
                    table.insert(scrollList, 1, scrollVo)
                else
                    table.insert(scrollList, scrollVo)
                end
            end
        end
    end

    -- 支援怪物列表
    local monsterUniqueTidList = self:getManager():getData().data
    for i = #monsterUniqueTidList, 1, -1 do
        local monsterTidVo = monster.MonsterManager:getMonsterVo(monsterUniqueTidList[i])
        local isShowRemove = false
        if(self.tileFormationHeroVo 
        and self.tileFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.MAIN_STORY 
        and self.tileFormationHeroVo.heroId == monsterTidVo.uniqueTid
        and self.tileFormationHeroVo:getHeroTid() == monsterTidVo.tid)then
            isShowRemove = true
        end
        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({dataVo = monsterTidVo, teamId = self.m_teamId, formationId = self.m_formationId, isShowRemove = isShowRemove, manager = self:getManager()})
        if(isShowRemove)then
            showRemoveVo = scrollVo
        else
            table.insert(scrollList, 1, scrollVo)
        end
    end

    if(showRemoveVo)then
        table.insert(scrollList, 1, showRemoveVo)
    end

    return scrollList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
