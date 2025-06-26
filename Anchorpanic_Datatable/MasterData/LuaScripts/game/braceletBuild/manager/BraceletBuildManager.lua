module("braceletBuild.BraceletBuildManager", Class.impl(Manager))

-- 当前选择的装备或英雄改变
SELECTE_CHANGE = "SELECTE_CHANGE"

-- 手环材料选择
BRACELET_STRENGTHEN_MATERIAL = "BRACELET_STRENGTHEN_MATERIAL"

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- 析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
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

-- 判断自己战员有无穿戴的手环
function getHeroCanHaveEquip(self, heroId)
    local propsDic = bag.BagManager:getPropsDic(bag.BagType.Bracelets)
    for k, v in pairs(propsDic) do
        if v.heroId == heroId then
            return v
        end
    end

    return nil
end

-- 根据特殊详细规则获取页签对应的背包道具列表
function getDetailRuleEquipList(self, cusBagType, cusPageType, suitIdList, cusSlotPos, cusColorList, cusSortData, cusFilterHeroId)
    local slotPosList = cusSlotPos and {cusSlotPos} or nil
    local isHeroWear = cusSortData and cusSortData.isHeroWear
    local propsDic = bag.BagManager:getPropsDic(cusBagType)
    local list = {}
    for id, propsVo in pairs(propsDic) do
        if (bag.BagManager:isBelongPage(propsVo, cusPageType, suitIdList, slotPosList, cusColorList)) then
            if (isHeroWear) then
                table.insert(list, propsVo)
            else
                table.insert(list, propsVo)
            end
        end
    end
    local isDescending = cusSortData.isDescending
    local sortId = cusSortData.sortList[1]
    local sortFun = nil
    sortFun = braceletBuild.getSortFun(isDescending, sortId)
    table.sort(list, sortFun)
    return list
end

-- 获取页签对应的背包道具列表
function getEquipList(self, cusBagType, cusPageType, cusSuitId, cusSlotPos, cusSortData, cusFilterHeroId)
    local suitIdList = cusSuitId and {cusSuitId} or nil
    local slotPosList = cusSlotPos and {cusSlotPos} or nil
    local isHeroWear = cusSortData and cusSortData.isHeroWear
    local propsDic = bag.BagManager:getPropsDic(cusBagType)
    local list = {}
    for id, propsVo in pairs(propsDic) do
        if (bag.BagManager:isBelongPage(propsVo, cusPageType, suitIdList, slotPosList)) then
            if (isHeroWear) then
                table.insert(list, propsVo)
            else
                table.insert(list, propsVo)
            end
        end
    end
    local isDescending = cusSortData.isDescending
    local sortId = cusSortData.sortList[1]
    local sortFun = nil
    sortFun = braceletBuild.getSortFun(isDescending, sortId)
    table.sort(list, sortFun)
    return list
end

braceletBuild.getSortFun = function(isDescending, sortType)
    if (sortType == bag.BagSortType.LVL) then
        return isDescending and braceletBuild._descendingLvlFun or braceletBuild._ascendingLvlFun
    elseif (sortType == bag.BagSortType.COLOR) then
        return isDescending and braceletBuild._descendingColorFun or braceletBuild._ascendingColorFun
    elseif (sortType == bag.BagSortType.REMAKE) then
        return isDescending and braceletBuild._descendingRemakeFun or braceletBuild._ascendingRemakeFun
    elseif (sortType == bag.BagSortType.COUNT) then
        return isDescending and braceletBuild._descendingCountFun or braceletBuild._ascendingCountFun
    elseif (sortType == bag.BagSortType.ID) then
        return isDescending and braceletBuild._descendingIDFun or braceletBuild._ascendingIDFun
    elseif (sortType == bag.BagSortType.REFINE) then
        return isDescending and braceletBuild._descendingRefineFun or braceletBuild._ascendingRefineFun
    end
end

braceletBuild._descendingRemakeFun = function(propsVo1, propsVo2)
    if #propsVo1.m_remakePosAttrList == #propsVo2.m_remakePosAttrList then
        if (propsVo1.color == propsVo2.color) then
            if propsVo1.tid and propsVo2.tid then
                return propsVo1.tid > propsVo2.tid
            end
        else
            return propsVo1.color > propsVo2.color
        end
    else
        return #propsVo1.m_remakePosAttrList > #propsVo2.m_remakePosAttrList
    end
    return nil
end

braceletBuild._ascendingRemakeFun = function(propsVo1, propsVo2)
    if #propsVo1.m_remakePosAttrList == #propsVo2.m_remakePosAttrList then
        if (propsVo1.color == propsVo2.color) then
            if propsVo1.tid and propsVo2.tid then
                return propsVo1.tid < propsVo2.tid
            end
        else
            return propsVo1.color < propsVo2.color
        end
    else
        return #propsVo1.m_remakePosAttrList < #propsVo2.m_remakePosAttrList
    end
    return nil
end

braceletBuild._descendingLvlFun = function(propsVo1, propsVo2)
    if propsVo1.strengthenLvl == propsVo2.strengthenLvl then
        if (propsVo1.color == propsVo2.color) then
            if propsVo1.tid and propsVo2.tid then
                return propsVo1.tid > propsVo2.tid
            end
        else
            return propsVo1.color > propsVo2.color
        end
    else
        return propsVo1.strengthenLvl > propsVo2.strengthenLvl
    end
    return nil
end

braceletBuild._ascendingLvlFun = function(propsVo1, propsVo2)
    if propsVo1.strengthenLvl == propsVo2.strengthenLvl then
        if (propsVo1.color == propsVo2.color) then
            if propsVo1.tid and propsVo2.tid then
                return propsVo1.tid < propsVo2.tid
            end
        else
            return propsVo1.color < propsVo2.color
        end
    else
        return propsVo1.strengthenLvl < propsVo2.strengthenLvl
    end
    return nil
end

braceletBuild._descendingColorFun = function(propsVo1, propsVo2)
    if propsVo1.color == propsVo2.color then

        if propsVo1.tid and propsVo2.tid then
            return propsVo1.tid > propsVo2.tid
        end
    else
        return propsVo1.color > propsVo2.color
    end
    return nil
end

braceletBuild._ascendingColorFun = function(propsVo1, propsVo2)
    if propsVo1.color == propsVo2.color then
        if propsVo1.tid and propsVo2.tid then
            return propsVo1.tid < propsVo2.tid
        end
    else
        return propsVo1.color < propsVo2.color
    end
    return nil
end

braceletBuild._descendingRefineFun = function(propsVo1, propsVo2)
    if propsVo1.refineLvl == propsVo2.refineLvl then
        if (propsVo1.color == propsVo2.color) then
            if propsVo1.tid and propsVo2.tid then
                return propsVo1.tid > propsVo2.tid
            end
        else
            return propsVo1.color > propsVo2.color
        end
    else
        return propsVo1.refineLvl > propsVo2.refineLvl
    end
    return nil
end

braceletBuild._ascendingRefineFun = function(propsVo1, propsVo2)
    if propsVo1.refineLvl == propsVo2.refineLvl then
        if (propsVo1.color == propsVo2.color) then
            if propsVo1.tid and propsVo2.tid then
                return propsVo1.tid < propsVo2.tid
            end
        else
            return propsVo1.color < propsVo2.color
        end
    else
        return propsVo1.refineLvl < propsVo2.refineLvl
    end
    return nil
end

-- 获取最小精炼等级
function getMinRefineLvl(self, braceletsTid)
    local minRefineLvl = 0
    if (braceletsTid ~= nil) then
        local refineLvlDic = self:getRefineDic(braceletsTid)
        for refineLvl, vo in pairs(refineLvlDic) do
            if (refineLvl <= minRefineLvl) then
                minRefineLvl = refineLvl
            end
        end
    else
        for tid, refineLvlDic in pairs(self.m_braceletsRefineDic) do
            for refineLvl, vo in pairs(refineLvlDic) do
                if (refineLvl <= minRefineLvl) then
                    minRefineLvl = refineLvl
                end
            end
        end
    end
    return minRefineLvl
end

-- 获取最大精炼等级
function getMaxRefineLvl(self, braceletsTid)
    local maxRefineLvl = 0
    if (braceletsTid ~= nil) then
        local refineLvlDic = self:getRefineDic(braceletsTid)
        for refineLvl, vo in pairs(refineLvlDic) do
            if (refineLvl >= maxRefineLvl) then
                maxRefineLvl = refineLvl
            end
        end
    else
        for tid, refineLvlDic in pairs(self.m_braceletsRefineDic) do
            for refineLvl, vo in pairs(refineLvlDic) do
                if (refineLvl >= maxRefineLvl) then
                    maxRefineLvl = refineLvl
                end
            end
        end
    end
    return maxRefineLvl
end

-- 判断手环是否可以精炼
function isCanRefine(self, cusTid)
    return self:getRefineDic(cusTid) ~= nil
end

-- 初始化配置表
function parseConfigData(self)
    self.m_braceletsRefineDic = {}
    local baseData = RefMgr:getData("bracelets_refine_data")
    for braceletsTid, data in pairs(baseData) do
        for key, voData in pairs(data.attr) do
            local vo = braceletBuild.BraceletRefineConfigVo.new()
            vo:parseConfigData(braceletsTid, voData)
            if (not self.m_braceletsRefineDic[braceletsTid]) then
                self.m_braceletsRefineDic[braceletsTid] = {}
            end
            self.m_braceletsRefineDic[braceletsTid][vo.refineLvl] = vo
        end
    end
end

-- 取配置数据Vo
function getRefineConfigVo(self, braceletsTid, refineLvl)
    return self:getRefineDic(braceletsTid)[refineLvl]
end

-- 取配置数据字典
function getRefineDic(self, braceletsTid)
    if (not self.m_braceletsRefineDic) then
        self:parseConfigData()
    end
    return self.m_braceletsRefineDic[braceletsTid]
end

----------------------------------------------------------------------------------------------------------

-- 根据使用效果类型获取滚动列表数据源
function getPropsScrollList(self, cusEffectType, exceptPropsId, selectSortType, isDescending, selectFilterDic, colorList)
    local propsScrollList = {}
    local idDic = {}
    local bagDic = bag.BagManager:getAllPropsDic()
    for bagType, propsDic in pairs(bagDic) do
        for id, propsVo in pairs(propsDic) do
            if (propsVo.id ~= exceptPropsId and
                (propsVo.effectType == cusEffectType or (propsVo.type == PropsType.EQUIP and propsVo.heroId <= 0 and
                    equipBuild.EquipStrengthenManager:getStrengthenConfigVo(propsVo.subType, propsVo.tid,
                    propsVo.strengthenLvl)))) then
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
            if (propsVo.type == PropsType.EQUIP and propsVo.subType == PropsEquipSubType.SLOT_7 and
            equipBuild.EquipStrengthenManager:getStrengthenConfigVo(propsVo.subType, propsVo.tid, propsVo.strengthenLvl)) then
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

-- 获得相同的手环
function getIdenticalBraceletList(self, tid, selfId)
    local retList = {}
    local propsDic = bag.BagManager:getPropsDic(bag.BagType.Bracelets)
    for id, propsVo in pairs(propsDic) do
        -- 排除已穿戴 排除自身
        if propsVo.heroId <= 0 and propsVo.tid == tid and propsVo.id ~= selfId then
            local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollVo:setDataVo(propsVo)
            scrollVo:setArgs(0)
            scrollVo:setSelect(false)
            table.insert(retList, scrollVo)
        end
    end

    return retList
end

function setSelectMaterialData(self, dataList)
    if ((dataList == nil or #dataList <= 0) and self.mMaterialDataList) then
        for i = 1, #self.mMaterialDataList do
            self.mMaterialDataList[i]:setArgs(0)
            self.mMaterialDataList[i]:setSelect(false)
            LuaPoolMgr:poolRecover(self.mMaterialDataList[i])
        end
    end
    self.mMaterialDataList = dataList

    GameDispatcher:dispatchEvent(EventName.SELECT_MATERIAL_CHANGE_EVENT)
end

function getSelectMaterialData(self)
    return self.mMaterialDataList or {}
end

function updateSelectRefineVo(self, materialVo)
    self.mSelectMaterialVo = materialVo
    GameDispatcher:dispatchEvent(EventName.SELECT_REFINE_CHANGE_EVENT)
end

function getSelectRefineVo(self)
    return self.mSelectMaterialVo
end

-- huo
function getKeyToValue(self, key, dic)
    for k, v in pairs(dic) do
        if v.key == key then
            return v.value
        end
    end
    return 0
end

-- 芯片统一参数设置
function setBraceletsInfo(self, vo, showBraceletsGo)
    local contentTran = showBraceletsGo.transform:Find("mContent").transform

    local fac = 0.6
    local sizeS = 1 - (1624 / 750 - gs.Screen.width / gs.Screen.height) * fac
    sizeS = gs.Mathf.Clamp(sizeS, 1 - fac, 1)
    gs.TransQuick:Scale(contentTran, sizeS, sizeS, sizeS)

    local eff02 = showBraceletsGo.transform:Find("mContent/bottom/fxColor_02").gameObject
    local eff03 = showBraceletsGo.transform:Find("mContent/bottom/fxColor_03").gameObject
    local eff04 = showBraceletsGo.transform:Find("mContent/bottom/fxColor_04").gameObject

    local effList = {eff02, eff03, eff04}

    local eff02top = showBraceletsGo.transform:Find("mContent/top/fxColor_top_02").gameObject
    local eff03top = showBraceletsGo.transform:Find("mContent/top/fxColor_top_03").gameObject
    local eff04top = showBraceletsGo.transform:Find("mContent/top/fxColor_top_04").gameObject
    local effTopList = {eff02top, eff03top, eff04top}

    for i = 1, #effList do
        effList[i]:SetActive(vo.color == i + 1)
    end

    for i = 1, #effTopList do
        effTopList[i]:SetActive(vo.color == i + 1)
    end

    local icon = showBraceletsGo.transform:Find("mContent/mImgBraceletsIcon"):GetComponent(ty.AutoRefImage)
    local color = showBraceletsGo.transform:Find("mContent/mImgBraceletsColor"):GetComponent(ty.AutoRefImage)
    local colorRight = showBraceletsGo.transform:Find("mContent/mImgBraceletsColorRight"):GetComponent(ty.AutoRefImage)

    icon:SetImg(UrlManager:getBraceletIconUrl(vo.tid), false)
    color:SetImg(UrlManager:getNraceletColorUrl(vo.color), false)
    colorRight:SetImg(UrlManager:getNraceletRightColorUrl(vo.color), false)
end

-------------------------------------------------------------------------烙痕
function getBraceletsCanEmpower(self, tid)
    if not self.m_braceletsEmpowerConfig then
        self.m_braceletsEmpowerConfig = {}

        local baseData = RefMgr:getData("mark_remake_data")
        for braceletsTid, data in pairs(baseData) do
            self.m_braceletsEmpowerConfig[braceletsTid] = 1
        end
    end

    return self.m_braceletsEmpowerConfig[tid] ~= nil
end

function getBraceletsRemakeShowConfig(self)
    if not self.m_braceletsEmpowerShowConfig then
        self.m_braceletsEmpowerShowConfig = {}

        local baseData = RefMgr:getData("mark_remake_show_data")
        for attrType, data in pairs(baseData) do
            self.m_braceletsEmpowerShowConfig[attrType] = {min_value = data.min_value, max_value = data.max_value}
        end
    end

    return self.m_braceletsEmpowerShowConfig
end

function getBraceletsEmpowerCost(self, type)
    if not self.m_braceletsEmpowerCostConfig then
        self.m_braceletsEmpowerCostConfig = {}

        local baseData = RefMgr:getData("equip_remake_cost_data")
        for costType, data in pairs(baseData) do
            self.m_braceletsEmpowerCostConfig[costType] = {cost = data.cost, coin_cost = data.coin_cost}
        end
    end

    return self.m_braceletsEmpowerCostConfig[type]
end

return _M
