--[[ 
-----------------------------------------------------
@filename       : FormationRogueLikeHeroSelectPanel
@Description    : 肉鸽选择战员
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationRogueLikeHeroSelectPanel', Class.impl(formation.FormationHeroSelectPanel))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationRogueLikeHeroSelectPanel.prefab")

function __getHeadSelectItem(self)
    return formation.FormationRogueLikeHeroSelectItem
end

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local fomationList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, self.mIsFilterUseState, self.m_isFindLike, self.m_isFindLock)
    local showRemoveVo = nil
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local isShowRemove = false
        if (self.tileFormationHeroVo and self.tileFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN and self.tileFormationHeroVo.heroId == heroVo.id and self.tileFormationHeroVo:getHeroTid() == heroVo.tid) then
            isShowRemove = true
        end

        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({ dataVo = heroVo, teamId = self.m_teamId, formationId = self.m_formationId, isShowRemove = isShowRemove, manager = self:getManager() })
        if (isShowRemove) then
            showRemoveVo = scrollVo
        else
            local isInFormation = self:getManager():isHeroInFormation(self.m_teamId, heroVo.id)
            if (isInFormation) then
                table.insert(fomationList, scrollVo)
            else
                local isInAssist = self:getManager():isHeroInAssist(self.m_teamId, heroVo.id)
                if(isInAssist)then
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

    self:filterList(scrollList)

    if (showRemoveVo) then
        table.insert(scrollList, 1, showRemoveVo)
    end

    return scrollList
end

function filterList(self,list)
    
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
