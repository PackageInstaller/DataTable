--[[ 
-----------------------------------------------------
@filename       : FormationApostlesHeroSelectPanel
@Description    : 使徒之战2
@date           : 2021-05-18 14:22:12
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationApostlesHeroSelectPanel', Class.impl(formation.FormationHeroSelectPanel))

function __getHeadSelectItem(self)
    return formation.FormationApostlesHeroSelectItem
end

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, self.mIsFilterUseState, self.m_isFindLike, self.m_isFindLock)
    local showRemoveVo = nil
    local lockList = self:getManager():getData().data[1]
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local lockState = 0
        if(lockList ~= nil) then 
            if table.indexof(lockList, heroVo.id) then 
                lockState = 1
            end
        end
        local isShowRemove = false
        if(self.tileFormationHeroVo 
        and self.tileFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN 
        and self.tileFormationHeroVo.heroId == heroVo.id 
        and self.tileFormationHeroVo:getHeroTid() == heroVo.tid)then
            isShowRemove = true
        end

        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({dataVo = heroVo, teamId = self.m_teamId, formationId = self.m_formationId, isShowRemove = isShowRemove, manager = self:getManager(), lockState = lockState})
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

    if(showRemoveVo)then
        table.insert(scrollList, 1, showRemoveVo)
    end

    return scrollList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
