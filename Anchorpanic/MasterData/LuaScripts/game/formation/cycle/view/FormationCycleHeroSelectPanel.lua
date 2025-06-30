module('fomation.FormationCycleHeroSelectPanel', Class.impl(formation.FormationHeroSelectPanel))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationCycleHeroSelectPanel.prefab")

-- 初始化
function configUI(self)
    super.configUI(self)
end

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local fomationList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType,
        self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, self.mIsFilterUseState, self.m_isFindLike,
        self.m_isFindLock)
    local showRemoveVo = nil
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local isShowRemove = false
        if (self.tileFormationHeroVo and self.tileFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN and
            self.tileFormationHeroVo.heroId == heroVo.id and self.tileFormationHeroVo:getHeroTid() == heroVo.tid) then
            isShowRemove = true
        end

        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({
            dataVo = heroVo,
            teamId = self.m_teamId,
            formationId = self.m_formationId,
            isShowRemove = isShowRemove,
            manager = self:getManager()
        })
        if (isShowRemove) then
            showRemoveVo = scrollVo
        else
            local isInFormation = self:getManager():isHeroInFormation(self.m_teamId, heroVo.id)
            if (isInFormation) then
                table.insert(fomationList, scrollVo)
            else
                local isInAssist = self:getManager():isHeroInAssist(self.m_teamId, heroVo.id)
                if (isInAssist) then
                    table.insert(fomationList, scrollVo)
                else
                    table.insert(scrollList, scrollVo)
                end
            end
        end
    end
    for i, v in ipairs(scrollList) do
        table.insert(fomationList, v)
    end

    scrollList = fomationList

    if (showRemoveVo) then
        table.insert(scrollList, 1, showRemoveVo)
    end

    local filterList = self:filterList(scrollList)
    return filterList
end

function filterList(self, list)
    local filterList = {}
    local heroIds = cycle.CycleManager:getHeroList()
    for i = 1, #list do
        if table.indexof01(heroIds, list[i].m_dataVo.dataVo.id) > 0 then
            table.insert(filterList, list[i])
        end
    end
    return filterList
end

-- 非激活
function deActive(self)
    super.deActive(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_FORMATION_HERO_SELECT_PANEL)
end


return _M
