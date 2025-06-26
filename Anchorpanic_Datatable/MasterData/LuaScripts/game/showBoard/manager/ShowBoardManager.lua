--[[   
     展示板
]]
module("showBoard.ShowBoardManager", Class.impl(Manager))

-- 展示板的展示英雄列表变化
SHOW_HERO_LIST_UPDATE = "SHOW_HERO_LIST_UPDATE"
-- 展示板的展示英雄选择变化
SHOW_HERO_SELECT = "SHOW_HERO_SELECT"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.m_showBoardHeroList = {}
    self.mSaveData = {}
    self.isDescending = false
end

-- 设置能够展示的英雄列表
function setShowBoardHeroList(self, tidList)
    self.m_showBoardHeroList = tidList
    self:dispatchEvent(showBoard.ShowBoardManager.SHOW_HERO_LIST_UPDATE)
end

-- 获取能够展示的英雄列表
function getShowBoardHeroList2(self)
    local heroScrollList = {}
    if (self.m_showBoardHeroList) then
        for i = 1, #self.m_showBoardHeroList do
            table.insert(heroScrollList, hero.HeroManager:getHeroVo(self.m_showBoardHeroList[i]))
        end
        table.sort(heroScrollList, function(a, b)
            -- 品质从大到小
            if (a.color > b.color) then
                return true
            end
            if (a.color < b.color) then
                return false
            end
            return false
        end)
    end
    return heroScrollList
end

-- 获取能够展示的英雄列表
function getShowBoardHeroList(self, selectSortType, selectFilterDic, isDescending)
    -- 美术资源只有这么几个，先临时只显示该列表
    local tempSearchList = nil
    local tidDic = {}
    local heroScrollList = {}
    if (self.m_showBoardHeroList) then
        for i = 1, #self.m_showBoardHeroList do
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.m_showBoardHeroList[i])
            if (tempSearchList == nil or table.indexof(tempSearchList, heroConfigVo.tid) ~= false) then
                local isEmptyDic = true
                local isSelect = false
                for type, dic in pairs(selectFilterDic) do
                    for subType, data in pairs(dic) do
                        isEmptyDic = false
                        if (type == showBoard.panelFilterType.CAMP) then
                            isSelect = subType == showBoard.filterSubTypeAll or heroConfigVo.camp == subType
                        end
                        if (type == showBoard.panelFilterType.COLOR) then
                            isSelect = subType == showBoard.filterSubTypeAll or heroConfigVo.color == subType
                        end
                        if (type == showBoard.panelFilterType.PROFESSION) then
                            isSelect = subType == showBoard.filterSubTypeAll or heroConfigVo.professionType == subType
                        end
                        if (type == showBoard.panelFilterType.DEFINE_TYPE) then
                            isSelect = subType == showBoard.filterSubTypeAll or heroConfigVo.defineType == subType
                        end
                        if (isSelect) then
                            break
                        end
                    end
                    if (isSelect == false) then
                        break
                    end
                end
                if (isEmptyDic or isSelect) then
                    local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
                    scrollVo:setDataVo(heroConfigVo)
                    table.insert(heroScrollList, scrollVo)
                    tidDic[scrollVo:getDataVo().tid] = true
                end
            end
        end
        if (selectSortType == showBoard.panelSortType.COLOR) then
            table.sort(heroScrollList, isDescending and self.__descendingColorFun or self.__ascendingColorFun)
        elseif (selectSortType == showBoard.panelSortType.NAME) then
            table.sort(heroScrollList, isDescending and self.__descendingNameLenFun or self.__ascendingNameLenFun)
        end
    end
    return heroScrollList, tidDic
end

-- 根据传入的英雄选择列表排序（3个for省不了）
function getHeroScrollList1(self, selectSortType, isDescending, heroScrollList)
    if (selectSortType == showBoard.panelSortType.LEVEL) then
        table.sort(heroScrollList, isDescending and self.__descendingLvlFun or self.__ascendingLvlFun)
    elseif (selectSortType == showBoard.panelSortType.COLOR) then
        table.sort(heroScrollList, isDescending and self.__descendingColorFun or self.__ascendingColorFun)
    elseif (selectSortType == showBoard.panelSortType.STAR_LVL) then
        table.sort(heroScrollList, isDescending and self.__descendingEvolutionLvlFun or self.__ascendingEvolutionLvlFun)
    elseif (selectSortType == showBoard.panelSortType.NAME) then
        table.sort(heroScrollList, isDescending and self.__descendingNameLenFun or self.__ascendingNameLenFun)
        -- elseif (selectSortType == showBoard.panelSortType.POWER) then
        --     table.sort(heroScrollList, isDescending and self.__descendingPowerFun or self.__ascendingPowerFun)
    end
    return heroScrollList
end

-- 根据指定条件获取英雄列表（3个for省不了）
function getHeroScrollList(self, cusHeroList, selectSortType, isDescending, selectFilterDic, filterSameHero, isFindCanUse, isFindLike, isFindLock, isInit)
    self:SetSaveTheData(cusHeroList, selectSortType, isDescending, selectFilterDic, filterSameHero, isFindCanUse, isFindLike, isFindLock, isInit)
    local heroList = cusHeroList or hero.HeroManager:getHeroList(false)
    local isFilter = nil
    for i = #heroList, 1, -1 do
        isFilter = false
        if (not isFilter and isFindCanUse and not hero.HeroUseCodeManager:getIsCanUse(heroList[i].id, false)) then
            isFilter = true
        end
        if (not isFilter) then
            if (isFindLike and heroList[i].isLike ~= 1) then
                if (not isFindLock or heroList[i].isLock ~= 1) then
                    isFilter = true
                end
            elseif (isFindLock and heroList[i].isLock ~= 1) then
                if (not isFindLike or heroList[i].isLike ~= 1) then
                    isFilter = true
                end
            end
        end
        if (isFilter) then
            table.remove(heroList, i)
        end
    end

    local idDic = {}
    local heroScrollList = {}
    for _, dataVo in pairs(heroList) do
        local isEmptyDic = true
        local isSelect = false
        if (selectFilterDic) then
            for type, dic in pairs(selectFilterDic) do
                for subType, data in pairs(dic) do
                    isEmptyDic = false
                    if (type == showBoard.panelFilterType.CAMP) then
                        isSelect = subType == showBoard.filterSubTypeAll or dataVo.camp == subType
                    end
                    if (type == showBoard.panelFilterType.STAR_LVL) then
                        isSelect = subType == showBoard.filterSubTypeAll or (self:getHeroStarLevel(dataVo.evolutionLvl) == subType)
                    end
                    if (type == showBoard.panelFilterType.ELEMENT) then
                        isSelect = subType == showBoard.filterSubTypeAll or dataVo.eleType == subType
                    end

                    if (type == showBoard.panelFilterType.COLOR) then
                        isSelect = subType == showBoard.filterSubTypeAll or dataVo.color == subType
                    end
                    if (type == showBoard.panelFilterType.PROFESSION) then
                        isSelect = subType == showBoard.filterSubTypeAll or dataVo.professionType == subType
                    end
                    if (type == showBoard.panelFilterType.DEFINE_TYPE) then
                        isSelect = subType == showBoard.filterSubTypeAll or dataVo.defineType == subType
                    end
                    if (isSelect) then
                        break
                    end
                end
                if (isSelect == false) then
                    break
                end
            end
        end
        if (isEmptyDic or isSelect) then
            local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollVo:setDataVo(dataVo)
            table.insert(heroScrollList, scrollVo)
            if (dataVo.__cname == hero.HeroVo.__cname) then
                idDic[dataVo.id] = true
            end
        end
    end
    if (filterSameHero) then
        heroScrollList = self:filterSame(heroScrollList)
    end

    -- if isInit then
    --     if selectSortType == showBoard.panelSortType.POWER then
    --         table.sort(heroScrollList, isDescending and self.__descendingPowerFunByUse or self.__ascendingPowerFunByUse)
    --     end
    -- else
    if (selectSortType == showBoard.panelSortType.LEVEL) then
        table.sort(heroScrollList, isDescending and self.__descendingLvlFun or self.__ascendingLvlFun)
    elseif (selectSortType == showBoard.panelSortType.COLOR) then
        table.sort(heroScrollList, isDescending and self.__descendingColorFun or self.__ascendingColorFun)
    elseif (selectSortType == showBoard.panelSortType.STAR_LVL) then
        table.sort(heroScrollList, isDescending and self.__descendingEvolutionLvlFun or self.__ascendingEvolutionLvlFun)
    elseif (selectSortType == showBoard.panelSortType.NAME) then
        table.sort(heroScrollList, isDescending and self.__descendingNameLenFun or self.__ascendingNameLenFun)
        -- elseif (selectSortType == showBoard.panelSortType.POWER) then
        --     if isInit then
        --         table.sort(heroScrollList, isDescending and self.__descendingPowerFunByUse or self.__ascendingPowerFunByUse)
        --     else
        --         table.sort(heroScrollList, isDescending and self.__descendingPowerFun or self.__ascendingPowerFun)
        --     end
    elseif selectSortType == showBoard.panelSortType.BUILDSKILL then
        self.isDescending = isDescending
        table.sort(heroScrollList, self.__RelateSkillFunc)
    elseif selectSortType == showBoard.panelSortType.SETTLEIN then
        table.sort(heroScrollList, self.__SettleinSortFun)
    elseif selectSortType == showBoard.panelSortType.STAMINA then
        --战员疲劳排序
        table.sort(heroScrollList, isDescending and self.__descendingStaminaFun or self.__ascendingStaminaFun)
    end
    -- end

    return heroScrollList, idDic
end

function getHeroStarLevel(self, star)
    if star == nil then
        return 0
    else
        local showIntegers = math.modf(star / 2)
        return showIntegers
    end
end

-- 取相同英雄第一个显示的
function filterSame(self, cusHeroScrollList)
    local sameList = {}
    for _, heroScrollVo in pairs(cusHeroScrollList) do
        local heroVo = heroScrollVo:getDataVo()
        if sameList[heroVo.tid] == nil then
            sameList[heroVo.tid] = {}
        end
        table.insert(sameList[heroVo.tid], heroScrollVo)
    end

    local heroScrollList = {}
    for tid, list in pairs(sameList) do
        table.insert(heroScrollList, list[1])
    end
    return heroScrollList
end

-- 修改保存数据
function SetSaveTheData(self, cusHeroList, selectSortType, isDescending, selectFilterDic, filterSameHero, isFindCanUse, isFindLike, isFindLock, isInit)
    self.mSaveData = { cusHeroListVo = cusHeroList, selectSortTypeVo = selectSortType, isDescendingVo = isDescending, selectFilterDicVo = selectFilterDic, filterSameHeroVo = filterSameHero, isFindCanUseVo = isFindCanUse, isFindLikeVo = isFindLike, isFindLockVo = isFindLock, isInitVo = isInit }
end
-- 获取保存数据
function GetSaveTheList(self, heroId)
    local list, idDic = self:getHeroScrollList(nil, self.mSaveData.selectSortTypeVo, self.mSaveData.isDescendingVo, self.mSaveData.selectFilterDicVo, self.mSaveData.filterSameHeroVo, false, self.mSaveData.isFindLikeVo, self.mSaveData.isFindLockVo, self.mSaveData.isInitVo)
    local heroIdList = {}
    if (not idDic[heroId]) then
        if (#list > 0) then
            local heroVo = hero.HeroManager:getHeroVo(heroId)
            if (heroVo and not heroVo:checkIsPreData()) then
                for i = #list, 1, -1 do
                    local Id = hero.HeroManager:getHeroIdByTid(list[i]:getDataVo().tid)
                    table.insert(heroIdList, 1, list[i]:getDataVo().id)
                end
            end
        end
    else
        for i = #list, 1, -1 do
            local Id = hero.HeroManager:getHeroIdByTid(list[i]:getDataVo().tid)
            table.insert(heroIdList, 1, list[i]:getDataVo().id)
        end
    end
    hero.HeroManager:setPanelShowHeroId(heroId)
    hero.HeroManager:setPanelShowHeroIdList(heroIdList)
end
--从可入驻到不可入驻
function __SettleinSortFun(a, b)
    local config_a = hero.HeroCuteManager:getHeroCuteConfigVo(a:getDataVo().tid)
    local config_b = hero.HeroCuteManager:getHeroCuteConfigVo(b:getDataVo().tid)
    if config_a ~= nil and config_b ~= nil then
        return false
    else
        if config_a == nil and config_b ~= nil then
            return false
        elseif config_a ~= nil and config_b == nil then
            return true
        else
            return false
        end
    end
end

--按照建筑技能排序 
function __RelateSkillFunc(selectVo1, selectVo2)
    local buildBaseHeroInfo1 = buildBase.BuildBaseHeroManager:getBuildHeroInfo(selectVo1:getDataVo().tid)
    local buildBaseHeroInfo2 = buildBase.BuildBaseHeroManager:getBuildHeroInfo(selectVo2:getDataVo().tid)
    local isAvailuable1 = hero.HeroCuteManager:getHeroCuteConfigVo(selectVo1:getDataVo().tid)
    local isAvailuable2 = hero.HeroCuteManager:getHeroCuteConfigVo(selectVo2:getDataVo().tid)
    local wight01, wight02 = 0, 0
    local wightType01, wightType02 = 0, 0
    for _, warShipSkillId in pairs(buildBaseHeroInfo1.skillList) do
        local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(warShipSkillId.skill_id)
        if skillVo.buildType == buildBase.BuildBaseManager.mNowBuildType then
            wight01 = 1
            wightType01 = warShipSkillId.skill_id
        end
    end

    for _, warShipSkillId in pairs(buildBaseHeroInfo2.skillList) do
        local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(warShipSkillId.skill_id)
        if skillVo.buildType == buildBase.BuildBaseManager.mNowBuildType then
            wight02 = 1
            wightType02 = warShipSkillId.skill_id
        end
    end

    if showBoard.ShowBoardManager.isDescending then
        wight01 = isAvailuable1 and wight01 or -1
        wight02 = isAvailuable2 and wight02 or -1
        if wight01 == wight02 then
            return wightType01 > wightType02
        else
            return wight01 > wight02
        end
    else
        wight01 = isAvailuable1 and wight01 or 99
        wight02 = isAvailuable2 and wight02 or 99
        if wight01 == wight02 then
            return wightType01 < wightType02
        else
            return wight01 < wight02
        end
    end
    return nil
end
-- 等级从大到小
function __descendingLvlFun(selectVo1, selectVo2)
    return hero.descendingLvlFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end
-- 等级从小到大
function __ascendingLvlFun(selectVo1, selectVo2)
    return hero.ascendingLvlFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end

-- 品质从大到小
function __descendingColorFun(selectVo1, selectVo2)
    return hero.descendingColorFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end
-- 品质从小到大
function __ascendingColorFun(selectVo1, selectVo2)
    return hero.ascendingColorFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end

-- 星级从大到小
function __descendingEvolutionLvlFun(selectVo1, selectVo2)
    return hero.descendingEvolutionLvlFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end
-- 星级从小到大
function __ascendingEvolutionLvlFun(selectVo1, selectVo2)
    return hero.ascendingEvolutionLvlFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end

-- 星级从大到小
function __descendingEvolutionLvlFun(selectVo1, selectVo2)
    return hero.descendingEvolutionLvlFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end
-- 星级从小到大
function __ascendingEvolutionLvlFun(selectVo1, selectVo2)
    return hero.ascendingEvolutionLvlFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end

-- 名称长度从大到小
function __descendingNameLenFun(selectVo1, selectVo2)
    return hero.descendingNameLenFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end
-- 名称长度从小到大
function __ascendingNameLenFun(selectVo1, selectVo2)
    return hero.ascendingNameLenFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end

-- 基建 战员疲劳长度从大到小
function __descendingStaminaFun(selectVo1, selectVo2)
    return hero.descendingStaminaFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end
-- 基建 战员疲劳长度从小到大
function __ascendingStaminaFun(selectVo1, selectVo2)
    return hero.ascendingStaminaFun(selectVo1:getDataVo(), selectVo2:getDataVo())
end
--战力从大到小
-- function __descendingPowerFunByUse(selectVo1, selectVo2)
--     return hero.descendingPowerFunByUse(selectVo1:getDataVo(), selectVo2:getDataVo())
-- end

-- --战力从小到大
-- function __ascendingPowerFunByUse(selectVo1, selectVo2)
--     return hero.ascendingPowerFunByUse(selectVo1:getDataVo(), selectVo2:getDataVo())
-- end

-- --战力从大到小不算出战
-- function __descendingPowerFun(selectVo1, selectVo2)
--     return hero.descendingPowerFun(selectVo1:getDataVo(), selectVo2:getDataVo())
-- end

-- --战力从小到大不算出战
-- function __ascendingPowerFun(selectVo1, selectVo2)
--     return hero.ascendingPowerFun(selectVo1:getDataVo(), selectVo2:getDataVo())
-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]