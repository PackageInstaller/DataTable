module("equipBuild.EquipStrengthenManager", Class.impl(Manager))

-- 装备强化材料选择
EQUIP_STRENGTHEN_MATERIAL_SELECT = "EQUIP_STRENGTHEN_MATERIAL_SELECT"

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.m_strengthenDic = nil
    self.m_breakUpDic = nil
    self.m_maxBreakUpRankDic = nil
    -- 当前选择的英雄id
    self.m_heroId = nil
    -- 当前选择装备的id
    self.m_equipId = nil
end

function setHeroId(self, heroId)
    if (heroId == self.m_heroId) then
        return
    end
    self.m_heroId = heroId
    self:dispatchEvent(self.SELECTE_CHANGE, {})
end

function getHeroId(self)
    return self.m_heroId
end

function setEquipId(self, equipId)
    if (equipId == self.m_equipId) then
        return
    end
    self.m_equipId = equipId
    self:dispatchEvent(self.SELECTE_CHANGE, {})
end

function getEquipId(self)
    return self.m_equipId
end

function setOpenEquipVo(self, equipVo)
    self.mOpenEquipVo = equipVo
end

function getOpenEquipVo(self)
    return self.mOpenEquipVo
end

function getEquipVo(self, equipId, heroId)
    equipId = equipId and equipId or self.m_equipId
    heroId = heroId and heroId or self.m_heroId
    local equipVo = nil
    if (heroId and heroId > 0) then
        local heroVo = hero.HeroManager:getHeroVo(heroId)
        equipVo = heroVo:getEquipById(equipId)
    else
        equipVo = bag.BagManager:getPropsVoById(equipId)
    end
    return equipVo
end

-- 初始化配置表
function parseStrengthenConfig(self)
    self.m_strengthenDic = {}
    local baseData = RefMgr:getData("equip_levelup_data")
    for tid, data in pairs(baseData) do
        for lvl, voData in pairs(data.levelup_attr) do
            local vo = equipBuild.EquipStrengthenConfigVo.new()
            vo:parseConfigData(lvl, voData)
            if (not self.m_strengthenDic[tid]) then
                self.m_strengthenDic[tid] = {}
            end
            if (not self.m_strengthenDic[tid][vo.lvl]) then
                self.m_strengthenDic[tid][vo.lvl] = {}
            end
            self.m_strengthenDic[tid][vo.lvl] = vo
        end
    end
end

-- 初始化配置表
function parseBreakUpConfig(self)
    self.m_breakUpDic = {}
    self.m_maxBreakUpRankDic = {}
    local baseData = RefMgr:getData("equip_breakup_data")
    for tid, data in pairs(baseData) do
        for rank, voData in pairs(data.equip_breakup) do
            local vo = equipBuild.EquipBreakUpConfigVo.new()
            vo:parseConfigData(rank, voData)
            if (not self.m_breakUpDic[tid]) then
                self.m_breakUpDic[tid] = {}
            end
            if (not self.m_breakUpDic[tid][vo.rank]) then
                self.m_breakUpDic[tid][vo.rank] = {}
            end
            self.m_breakUpDic[tid][vo.rank] = vo

            if (not self.m_maxBreakUpRankDic[tid] or self.m_maxBreakUpRankDic[tid] < vo.rank) then
                self.m_maxBreakUpRankDic[tid] = vo.rank
            end
        end
    end
end

-- 根据装备部位、装备tid、强化等级获取强化配置
function getStrengthenConfigVo(self, cusSlotPos, cusTid, cusLvl)
    if (not self.m_strengthenDic) then
        self:parseStrengthenConfig()
    end
    -- local suitId = equip.EquipManager:getSuitIdByEquipTid(cusTid)
    if (not self.m_strengthenDic[cusTid] or not self.m_strengthenDic[cusTid][cusLvl]) then
        return nil
    end
    return self.m_strengthenDic[cusTid][cusLvl]
end

-- 获取最大强化等级
function getMaxStrengthenLvl(self, cusTid)
    if (not self.m_strengthenDic) then
        self:parseStrengthenConfig()
    end
    local _maxLvl = #self.m_strengthenDic[cusTid]

    -- for _, data in pairs(self.m_strengthenDic[cusTid]) do
    --     if _maxLvl < data.equipTargetLvl then
    --         _maxLvl = data.equipTargetLvl
    --     end
    -- end
    return _maxLvl
end

-- 根据装备tid和装备的突破阶数获取突破配置
function getBreakUpConfigVo(self, cusPropsTid, cusRank)
    if (not self.m_breakUpDic) then
        self:parseBreakUpConfig()
    end
    return self.m_breakUpDic[cusPropsTid][cusRank]
end

-- 获取最大突破阶段
function getMaxBreakUpRank(self, cusPropsTid)
    if (not self.m_maxBreakUpRankDic) then
        self:parseBreakUpConfig()
    end
    return self.m_maxBreakUpRankDic[cusPropsTid]
end

-- 根据装备vo判断装备是否可以突破
function isCanBreakUp(self, cusEquipVo)
    local isCanBreakUp = false
    if (cusEquipVo.tuPoRank < self:getMaxBreakUpRank(cusEquipVo.tid)) then
        local breakUpConfigVo = self:getBreakUpConfigVo(cusEquipVo.tid, cusEquipVo.tuPoRank)

        if (breakUpConfigVo and cusEquipVo.strengthenLvl >= breakUpConfigVo.equipTargetLvl) then
            isCanBreakUp = true
        end
    end
    return isCanBreakUp
end

-- 根据使用效果类型获取滚动列表数据源（会过滤已穿戴的）
function getPropsScrollList(self, cusEffectType, exceptPropsId, selectSortType, isDescending, selectFilterDic)
    local propsScrollList = {}
    local idDic = {}
    local bagDic = bag.BagManager:getAllPropsDic()
    for bagType, propsDic in pairs(bagDic) do
        for id, propsVo in pairs(propsDic) do
            if (propsVo.id ~= exceptPropsId and
            (propsVo.effectType == cusEffectType or (propsVo.type == PropsType.EQUIP and propsVo.heroId <= 0 and
            self:getStrengthenConfigVo(propsVo.subType, propsVo.tid, propsVo.strengthenLvl)))) then
                local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
                scrollVo:setDataVo(propsVo)
                scrollVo:setArgs(0)
                table.insert(propsScrollList, scrollVo)
                idDic[scrollVo:getDataVo().id] = true
            end
        end
    end

    if selectFilterDic then
        propsScrollList = self:getFilterList(propsScrollList, selectFilterDic)
    end
    if selectSortType then
        self:sortHandler(propsScrollList, selectSortType, isDescending)
    end
    return propsScrollList, idDic
end

-- 返回筛选后的列表
function getFilterList(self, list, selectFilterDic, isFilterHeroWear)
    local propsScrollList = {}
    local idDic = {}
    for _, scrollVo in pairs(list) do
        local propsVo = scrollVo:getDataVo()
        if (propsVo.type == PropsType.EQUIP and propsVo.subType ~= PropsEquipSubType.SLOT_7 and
        self:getStrengthenConfigVo(propsVo.subType, propsVo.tid, propsVo.strengthenLvl)) then
            local isEmptyDic = true
            local isSelect = false
            for type, dic in pairs(selectFilterDic) do
                for subType, data in pairs(dic) do
                    isEmptyDic = false
                    if (type == equipBuild.panelFilterType.COLOR) then
                        isSelect = subType == equipBuild.filterSubTypeAll or propsVo.color == subType
                    end
                    if (type == equipBuild.panelFilterType.SUIT) then
                        local dic = equip.EquipManager:getSuitEquipDic(subType)
                        isSelect = subType == equipBuild.filterSubTypeAll or (dic[propsVo.tid] ~= nil)
                    end
                    if (type == equipBuild.panelFilterType.POS) then
                        isSelect = subType == equipBuild.filterSubTypeAll or propsVo.subType == subType
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
                table.insert(propsScrollList, scrollVo)
                idDic[scrollVo:getDataVo().id] = true
            end
        end
        if propsVo.type == PropsType.NORMAL then
            local isFiler = false
            for type, dic in pairs(selectFilterDic) do
                for subType, data in pairs(dic) do
                    if subType ~= equipBuild.filterSubTypeAll then
                        isFiler = true
                    end
                end
            end
            if not isFiler then
                table.insert(propsScrollList, scrollVo)
                idDic[scrollVo:getDataVo().id] = true
            end

        end
    end
    return propsScrollList, idDic
end

-- 将传入的列表进行排序
function sortHandler(self, propsScrollList, selectSortType, isDescending, isSortLock)
    if not isSortLock then
        if (not selectSortType or selectSortType == equipBuild.panelSortType.DEFAULT) then
            table.sort(propsScrollList, self.sortDefault)
        elseif (selectSortType == equipBuild.panelSortType.LEVEL) then
            table.sort(propsScrollList, isDescending and self.__descendingLvlFun or self.__ascendingLvlFun)
        elseif (selectSortType == equipBuild.panelSortType.COLOR) then
            table.sort(propsScrollList, isDescending and self.__descendingColorFun or self.__ascendingColorFun)
        end
    else
        if (not selectSortType or selectSortType == equipBuild.panelSortType.DEFAULT) then
            table.sort(propsScrollList, self.sortDefaultLock)
        elseif (selectSortType == equipBuild.panelSortType.LEVEL) then
            table.sort(propsScrollList, isDescending and self.__descendingLvlLockFun or self.__ascendingLvlLockFun)
        elseif (selectSortType == equipBuild.panelSortType.COLOR) then
            table.sort(propsScrollList, isDescending and self.__descendingColorLockFun or self.__ascendingColorLockFun)
        end

    end
end

-- 按照升序排列
function sortDefault(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then
            return true
        end
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then
            return false
        end
    end

    -- 品质从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return false
    end

    -- 创建时间从小到大
    -- if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then
    --     return true
    -- end
    -- if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then
    --     return false
    -- end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end

    return false
end

-- 按照升序排列
function sortDefaultLock(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then
            return true
        end
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then
            return false
        end
    end

    -- 品质从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end

    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end

    return false
end

-- 等级从大到小
function __descendingLvlFun(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then
            return true
        end
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then
            return false
        end
    end

    -- if selectVo1:getDataVo().type == PropsType.NORMAL and selectVo2:getDataVo().type == PropsType.NORMAL then
    -- 品质从小到大
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end

    return false
end

-- 等级从大到小
function __descendingLvlLockFun(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then
            return true
        end
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then
            return false
        end
    end

    -- 品质从小到大
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end


    return false
end
-- 等级从小到大
function __ascendingLvlFun(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then
            return true
        end
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then
            return false
        end
    end

    -- 品质从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end

    return false
end
-- 等级从小到大
function __ascendingLvlLockFun(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then
            return true
        end
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then
            return false
        end
    end

    -- 品质从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end

    return false
end

-- 品质从大到小
function __descendingColorFun(selectVo1, selectVo2)

    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end
    return false
end

-- 品质从大到小
function __descendingColorLockFun(selectVo1, selectVo2)

    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end

    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end

    return false
end
-- 品质从小到大
function __ascendingColorFun(selectVo1, selectVo2)

    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end

    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end
    return false
end
-- 品质从小到大
function __ascendingColorLockFun(selectVo1, selectVo2)

    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then
        return true
    end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then
        return false
    end
    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end

    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then
        return true
    end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then
        return false
    end

    -- 按照id排序从小到大
    if (selectVo1:getDataVo().tid < selectVo2:getDataVo().tid) then
        return true
    end
    if (selectVo1:getDataVo().tid > selectVo2:getDataVo().tid) then
        return false
    end

    return false
end

-- 获取装备突破材料是否足够
function getIsEnoughBreakUp(self, heroId, equipId)
    local equipVo = equipBuild.EquipBuildManager:getEquipVo(equipId, heroId)
    local breakUpConfigVo = self:getBreakUpConfigVo(equipVo.tid, equipVo.tuPoRank + 1)

    local isEnough = true
    local list = breakUpConfigVo.costPropsList
    for i = 1, #list do
        local bagCount = bag.BagManager:getPropsCountByTid(list[i].tid)
        if (list[i].count > bagCount) then
            isEnough = false
        end
    end
    return isEnough
end

-- 根据物品vo获取物品的转换经验、需要的货币tid和货币数量
function getConvertExp(self, propsVo)
    local convertExp = 0
    local needMoneyTid = 0
    local needMoneyCount = 0

    if propsVo then
        if (propsVo.type == PropsType.EQUIP) then
            local strengthConfigVo = self:getStrengthenConfigVo(propsVo.subType, propsVo.tid, propsVo.strengthenLvl)
            convertExp = strengthConfigVo.convertExp + propsVo.effectList[1]
            needMoneyTid = strengthConfigVo.costMoneyTid
            -- 所需费用 = 道具等级额外费用 + 道具基础费用
            needMoneyCount = strengthConfigVo.costMoneyCount + propsVo.effectList[3]
        else
            convertExp = propsVo.effectList[1]
            needMoneyTid = propsVo.effectList[2]
            -- 所需费用 = 道具基础费用
            needMoneyCount = propsVo.effectList[3]
        end
        return convertExp, needMoneyTid, needMoneyCount
    else
        return 0, 0, 0
    end
    -- Debug:log_info("getConvertExp",propsVo.type .."  "..PropsType.EQUIP.."  "..convertExp.."  "..needMoneyTid.."  "..needMoneyCount)
end

-- 获取装备强化界面的排序字典
function getPanelSortData(self)
    if (not self.m_panelSortType) then
        self.m_panelSortType = {
            COLOR = "COLOR",
            SUIT = "SUIT"
        }
    end
    if (not self.m_panelSortTypeDic) then
        self.m_panelSortTypeDic = {}
        self.m_panelSortTypeDic[self.m_panelSortType.COLOR] =        { ColorType.GREEN, ColorType.BLUE, ColorType.VIOLET, ColorType.ORANGE }
        self.m_panelSortTypeDic[self.m_panelSortType.SUIT] = {}
        local suitConfigList = equip.EquipSuitManager:getSuitConfigList()
        for i = 1, #suitConfigList do
            table.insert(self.m_panelSortTypeDic[self.m_panelSortType.SUIT], suitConfigList[i].suitId)
        end
    end
    if (not self.m_panelSortTypeList) then
        self.m_panelSortTypeList = { self.m_panelSortType.COLOR, self.m_panelSortType.SUIT }
    end
    return self.m_panelSortType, self.m_panelSortTypeList, self.m_panelSortTypeDic
end

-- 获取指定装备强化两个指定等级之间的经验差
function getExpByStrengthLvl(self, equipVo, cusLvl1, cusLvl2)
    local exp = 0
    for strengthLvl = cusLvl1, cusLvl2 - 1 do
        local strengthConfigVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(equipVo.subType, equipVo.tid,
        strengthLvl)
        exp = exp + strengthConfigVo.needExp
    end
    return exp
end

function setSelectMaterialData(self, dataList)
    if ((dataList == nil or #dataList <= 0) and self.m_materialDataList) then
        for i = 1, #self.m_materialDataList do
            self.m_materialDataList[i]:setArgs(0)
            self.m_materialDataList[i]:setSelect(false)
            LuaPoolMgr:poolRecover(self.m_materialDataList[i])
        end
    end
    self.m_materialDataList = dataList
    GameDispatcher:dispatchEvent(EventName.SELECT_MATERIAL_CHANGE_EVENT)
end

function getSelectMaterialData(self)
    return self.m_materialDataList or {}
end

function getKeyToValue(self, key, dic)
    for k, v in pairs(dic) do
        if v.key == key then
            return v.value
        end
    end
    return 0
end

-- 析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]