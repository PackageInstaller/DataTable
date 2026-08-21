module("equipBuild.EquipRemakeManager", Class.impl(Manager))

-- 装备强化材料选择
EQUIP_REMAKE_MATERIAL_SELECT = "EQUIP_REMAKE_MATERIAL_SELECT"

-- 装备强化材料选择 多选
EQUIP_REMAKE_MATERIAL_SELECT_MUL = "EQUIP_REMAKE_MATERIAL_SELECT_MUL"

--构造函数
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
    self.m_equipRemakeDic = nil
end

function __parseConfigData(self)
    self.m_equipRemakeDic = {}
    local baseData = RefMgr:getData('equip_remake_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(equipBuild.EquipRemakeVo)
        ro:parseData(key, data)
        self.m_equipRemakeDic[key] = ro
    end
end

-- 获取装备改造数据
function getEquipRemakeVo(self, equipTid)
    if (not self.m_equipRemakeDic) then
        self:__parseConfigData()
    end
    local vo = self.m_equipRemakeDic[equipTid]
    return self.m_equipRemakeDic[equipTid]
end

-- 判断背包中是否包含有能够改造的装备
function isHasRemakeEquip(self)
    if (not self.m_equipRemakeDic) then
        self:__parseConfigData()
    end
    local isHas = false
    for tid, equipRemakeConfigVo in pairs(self.m_equipRemakeDic) do
        local count = bag.BagManager:getPropsCountByTid(tid, bag.BagType.Equip)
        if (count > 0) then
            isHas = true
            break
        end
    end
    return isHas
end

-- 判断装备是否能改造
function isEquipCanRemake(self, equipTid)
    return self:getEquipRemakeVo(equipTid) ~= nil
end

-- 获取装备能改造的部位数量
function getRemakeCount(self, equipTid)
    local remakeCount = 0
    if (self:isEquipCanRemake(equipTid)) then
        local remakeCongiVo = self:getEquipRemakeVo(equipTid)
        remakeCount = remakeCongiVo:getLimit()
    end
    return remakeCount
end

-- 根据使用效果类型获取滚动列表数据源
function getPropsScrollList(self, equipTidList, exceptId, selectSortType, isDescending, selectFilterDic)
    local scrollList = {}
    for i = 1, #equipTidList do
        local equipTid = equipTidList[i]
        local equipList = bag.BagManager:getPropsListByTid(equipTid, exceptId, nil, false)
        for j = 1, #equipList do
            if (equipList[j].heroId <= 0 and not equipBuild.EquipPlanManager:isInEquipPlan(equipList[j])) then
                local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
                scrollVo:setDataVo(equipList[j])
                table.insert(scrollList, scrollVo)
            end
        end
    end

    if selectFilterDic then
        scrollList = self:getFilterList(scrollList, selectFilterDic)
    end
    if selectSortType then
        self:sortHandler(scrollList, selectSortType, isDescending)
    end

    return scrollList
end

-- 返回筛选后的列表
function getFilterList(self, list, selectFilterDic)
    local propsScrollList = {}
    local idDic = {}
    for _, scrollVo in pairs(list) do
        local propsVo = scrollVo:getDataVo()
        if (propsVo.type == PropsType.EQUIP and self:getEquipRemakeVo(propsVo.tid)) then
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
        elseif (selectSortType == equipBuild.panelSortType.POS) then
            table.sort(propsScrollList, isDescending and self.__descendingPosFun or self.__ascendingPosFun)
        end
    else
        if (not selectSortType or selectSortType == equipBuild.panelSortType.DEFAULT) then
            table.sort(propsScrollList, self.sortDefaultLock)
        elseif (selectSortType == equipBuild.panelSortType.LEVEL) then
            table.sort(propsScrollList, isDescending and self.__descendingLvlLockFun or self.__ascendingLvlLockFun)
        elseif (selectSortType == equipBuild.panelSortType.COLOR) then
            table.sort(propsScrollList, isDescending and self.__descendingColorLockFun or self.__ascendingColorLockFun)
        elseif (selectSortType == equipBuild.panelSortType.POS) then
            table.sort(propsScrollList, isDescending and self.__descendingPosLockFun or self.__ascendingPosLockFun)
        end

    end
end

-- 按照升序排列
function sortDefault(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then return true end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then return false end
    -- 品质从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then return true end
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then return false end
    end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end

-- 按照升序排列
function sortDefaultLock(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then return true end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then return false end
    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end
    -- 品质从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then return true end
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then return false end
    end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end

-- 等级从大到小
function __descendingLvlFun(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then return true end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then return false end

    if selectVo1:getDataVo().type == PropsType.NORMAL and selectVo2:getDataVo().type == PropsType.NORMAL then
        -- 品质从小到大
        if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
        if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then return true end
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then return false end
    end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end

-- 等级从大到小
function __descendingLvlLockFun(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then return true end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then return false end
    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end
    if selectVo1:getDataVo().type == PropsType.NORMAL and selectVo2:getDataVo().type == PropsType.NORMAL then
        -- 品质从小到大
        if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
        if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then return true end
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then return false end
    end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end
-- 等级从小到大
function __ascendingLvlFun(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then return true end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then return false end

    if selectVo1:getDataVo().type == PropsType.NORMAL and selectVo2:getDataVo().type == PropsType.NORMAL then
        -- 品质从小到大
        if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
        if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then return true end
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then return false end
    end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end
-- 等级从小到大
function __ascendingLvlLockFun(selectVo1, selectVo2)
    -- 普通类道具优先
    if (selectVo1:getDataVo().type < selectVo2:getDataVo().type) then return true end
    if (selectVo1:getDataVo().type > selectVo2:getDataVo().type) then return false end
    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end

    if selectVo1:getDataVo().type == PropsType.NORMAL and selectVo2:getDataVo().type == PropsType.NORMAL then
        -- 品质从小到大
        if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
        if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end
    end

    if selectVo1:getDataVo().type == PropsType.EQUIP and selectVo2:getDataVo().type == PropsType.EQUIP then
        if (selectVo1:getDataVo().strengthenLvl < selectVo2:getDataVo().strengthenLvl) then return true end
        if (selectVo1:getDataVo().strengthenLvl > selectVo2:getDataVo().strengthenLvl) then return false end
    end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end

-- 品质从大到小
function __descendingColorFun(selectVo1, selectVo2)
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return false end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end
    return false
end

function __descendingPosFun(selectVo1,selectVo2)
    if (selectVo1:getDataVo().subType < selectVo2:getDataVo().subType) then return true end
    if (selectVo1:getDataVo().subType > selectVo2:getDataVo().subType) then return false end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end
    return false
end

-- 品质从大到小
function __descendingColorLockFun(selectVo1, selectVo2)
    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return false end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end

function __descendingPosLockFun(selectVo1,selectVo2)
    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end
    if (selectVo1:getDataVo().subType < selectVo2:getDataVo().subType) then return true end
    if (selectVo1:getDataVo().subType > selectVo2:getDataVo().subType) then return false end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end

-- 品质从小到大
function __ascendingColorFun(selectVo1, selectVo2)
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end
    return false
end

function __ascendingPosFun(selectVo1,selectVo2)
    if (selectVo1:getDataVo().subType > selectVo2:getDataVo().subType) then return true end
    if (selectVo1:getDataVo().subType < selectVo2:getDataVo().subType) then return false end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end
    return false
end
-- 品质从小到大
function __ascendingColorLockFun(selectVo1, selectVo2)
    -- 锁定的排最后
    if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().createdTime < selectVo2:getDataVo().createdTime) then return true end
    if (selectVo1:getDataVo().createdTime > selectVo2:getDataVo().createdTime) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end

function __ascendingPosLockFun(selectVo1, selectVo2)
       -- 锁定的排最后
       if (selectVo1:getDataVo().isLock < selectVo2:getDataVo().isLock) then
        return true
    end
    if (selectVo1:getDataVo().isLock > selectVo2:getDataVo().isLock) then
        return false
    end
    if (selectVo1:getDataVo().subType > selectVo2:getDataVo().subType) then return true end
    if (selectVo1:getDataVo().subType < selectVo2:getDataVo().subType) then return false end

    -- 创建时间从小到大
    if (selectVo1:getDataVo().color < selectVo2:getDataVo().color) then return true end
    if (selectVo1:getDataVo().color > selectVo2:getDataVo().color) then return false end
    -- 按照id排序从小到大
    if (selectVo1:getDataVo().id < selectVo2:getDataVo().id) then return true end
    if (selectVo1:getDataVo().id > selectVo2:getDataVo().id) then return false end

    return false
end

function parseRemakeAttrData(self)
    self.mRemakeAttrDic = {}
    local baseData = RefMgr:getData('equip_remake_show_data') 
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(equipBuild.EquipRemakeShowDataVo)
        ro:parseData(key, data)
        self.mRemakeAttrDic[key] = ro
    end
end

function getRemakeAttrData(self)
    if self.mRemakeAttrDic == nil then
        self:parseRemakeAttrData(self)
    end
    return self.mRemakeAttrDic  
end

function getRemakeAttrDataById(self,id)
    if self.mRemakeAttrDic == nil then
        self:parseRemakeAttrData(self)
    end
    return self.mRemakeAttrDic[id]
end

function setNeedRemakeAgentInfo(self,equipVo,needPos,selectAttId,selectAttColor)
    self.needEquipVo = equipVo
    self.needPos = needPos
    self.selectAttIdList = selectAttId
    self.selectAttColorList = selectAttColor
end

function getNeedRemakeAgentInfo(self)
    return self.needEquipVo,self.needPos,self.selectAttIdList,self.selectAttColorList
end

function setSelectPropsList(self,propsVoList)
    self.selectPropsVoList = propsVoList
end

function getSelectPropsList(self)
    return self.selectPropsVoList
end

function changePropsInfo(self,propsVo)
end

function setCurrentIsAgentOpt(self,isAgentOpt)
    self.isAgentOpt = isAgentOpt
end

function getIsAgentOpt(self)
    return self.isAgentOpt
end

function setAgentSuc(self,isAgentSuc)
    self.isAgentSuc = isAgentSuc    
end

function getAgentSuc(self)
    local isAgentSuc = self.isAgentSuc
    self.isAgentSuc = false
    return isAgentSuc
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]