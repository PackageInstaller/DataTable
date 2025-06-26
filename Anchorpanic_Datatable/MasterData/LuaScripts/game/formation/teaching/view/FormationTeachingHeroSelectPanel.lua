--[[ 
-----------------------------------------------------
@filename       : FormationTeachingHeroSelectPanel
@Description    : 上阵教学选择战员
@date           : 2021-09-01 14:18:12
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationTeachingHeroSelectPanel', Class.impl(formation.FormationHeroSelectPanel))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationHeroSelectPanel.prefab")

function __getHeadSelectItem(self)
    return formation.FormationTeachingHeroSelectItem
end

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local fomationList = {}
    local heroList = formation.FormationTeachingManager:getHeroList()
    local showRemoveVo = nil
    for i = 1, #heroList do
        local monsterTidVo = monster.MonsterManager:getMonsterVo(heroList[i])
        local isShowRemove = false
        if (self.tileFormationHeroVo
        and self.tileFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.TEACHING
        and self.tileFormationHeroVo.heroId == monsterTidVo.uniqueTid
        and self.tileFormationHeroVo:getHeroTid() == monsterTidVo.tid) then
            isShowRemove = true
        end
        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({ dataVo = monsterTidVo, teamId = self.m_teamId, formationId = self.m_formationId, isShowRemove = isShowRemove, manager = self:getManager() })
        if (isShowRemove) then
            showRemoveVo = scrollVo
        else
            table.insert(scrollList, 1, scrollVo)
        end
    end

    if (showRemoveVo) then
        table.insert(scrollList, 1, showRemoveVo)
    end

    return scrollList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
