module("bag.BagManager", Class.impl(Manager))

-------------------界面-----------------------------
-- 点击了装备套装
SELECT_EQUIP_SUIT = "SELECT_EQUIP_SUIT"
-- 点击了道具格子
SELECT_PROPS_GRID = "SELECT_PROPS_GRID"

-- 通知背包的每个item进行动画
START_BAG_ITEM_ACTION = "START_BAG_ITEM_ACTION"

-------------------事件-----------------------------
-- 初始化
BAG_INIT = "BAG_INIT"
-- 更新
BAG_UPDATE = "BAG_UPDATE"

-- 红点变动
BUBBLE_CHANGE = "BUBBLE_CHANGE"

-- 分解缓存变化
EVENT_BREAK_SHOW_UPDATE = "EVENT_BREAK_SHOW_UPDATE"
-- 出售缓存变化
EVENT_SELL_SHOW_UPDATE = "EVENT_SELL_SHOW_UPDATE"

-- 选择分解类型道具完成
EVENT_SELECT_TYPES_OVER = "EVENT_SELECT_TYPES_OVER"

------------------------------------------------------------
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
    -------------------配置数据-----------------------------
    self.mBreakBaseData = nil
    -------------------记录数据-----------------------------
    -- 背包容量
    self.mCapacityDic = {}
    -- 背包字典
    self.mBagDic = {}
    -- 红点字典
    self.mBubbleDic = {}

    -- 道具操作状态
    self.propsOpState = nil
    -- 分解列表
    self.mBreakList = nil
    -- 出售数据
    self.mSellData = nil

    -- 临时背包
    self.mTempDic = {}

    -- 登录
    self.mSignIn = true
    self.mOpenHeroDetail = false
    self.mBagTabArge = nil

    self.mIsShowBreakBraceletsTip = true
    self:setIsOpenEggProps(false)
end

-- 分解出售道具基础配置
function parseBreakConfigData(self)
    self.mBreakBaseData = {}
    local baseData = RefMgr:getData("decompose_sell_data")
    for key, data in pairs(baseData) do
        local vo = bag.BagBreakConfigVo.new()
        vo:parseData(key, data)
        if not self.mBreakBaseData[vo.type] then
            self.mBreakBaseData[vo.type] = {}
        end
        self.mBreakBaseData[vo.type][vo.tid] = vo
    end
end

-- 初始化
function initBag(self, msg)
    local bagType = msg.type
    self.mCapacityDic[bagType] = msg.capacity
    if (self.mBagDic[bagType] == nil) then
        self.mBagDic[bagType] = {}
    end
    local len = #msg.list
    for i = 1, len do
        local pt_prop_bag = msg.list[i]
        local propsVo = self.mBagDic[bagType][pt_prop_bag.id]
        -- 尽量保持原有对象
        if (not propsVo or propsVo.tid ~= pt_prop_bag.tid) then
            propsVo = props.PropsManager:getTypePropsVoByTid(pt_prop_bag.tid)
        end
        if (propsVo) then
            propsVo:setPropsBagMsgData(bagType, pt_prop_bag)
            self.mBagDic[bagType][propsVo.id] = propsVo
        else
            Debug:log_error("BagManager", "找不到tid为" .. msg.list[i].tid .. "的道具配置")
        end
    end
    if msg.is_last_data == 1 then
        self:updateBubble()
        self:dispatchEvent(self.BAG_INIT, {})
    end
end

-- 更新
function update(self, msg)
    local bagType = msg.type
    local addList = {}
    local updateList = {}
    local delList = {}
    if (not self.mBagDic[msg.type]) then
        self.mBagDic[msg.type] = {}
    end
    local propsDic = self:getPropsDic(msg.type)
    local len = #msg.updateList
    for i = 1, len do
        local pt_prop_bag = msg.updateList[i]
        local isAdd = false
        local propsVo = nil
        if (propsDic[pt_prop_bag.id]) then
            isAdd = false
            propsVo = propsDic[pt_prop_bag.id] --此处直接取已有的数据进行更新，避免诸如装备vo的一些已请求的数据被清掉
        else
            isAdd = true
            propsVo = props.PropsManager:getTypePropsVoByTid(pt_prop_bag.tid)
        end

        if (propsVo) then
            propsVo:setPropsBagMsgData(bagType, pt_prop_bag)
            if (isAdd) then
                table.insert(addList, propsVo)
            else
                table.insert(updateList, propsVo)
            end
            propsDic[propsVo.id] = propsVo
        else
            Debug:log_error("BagManager", "找不到tid为" .. msg.updateList[i].tid .. "的道具配置")
        end
    end
    len = #msg.delList
    for i = 1, len do
        local id = msg.delList[i]
        if (propsDic[id]) then
            table.insert(delList, propsDic[id])
            propsDic[id] = nil
        end
    end
    self:updateBubble()
    self:dispatchEvent(self.BAG_UPDATE, {addList = addList, updateList = updateList, delList = delList})
end

-- 获取页签对应的背包道具列表
function getBagPagePropsList(self, cusPageType, cusSuitIdList, cusSlotPosList, cusColorList, cusSortData, cusBagType)
   
    local propsDic = self:getPropsDic(cusBagType)

    local needDic = {}
    if cusBagType == bag.BagTabType.NORMAL then
        local dic2 = self.mBagDic[bag.BagType.HeroFragment] and self.mBagDic[bag.BagType.HeroFragment] or {}
        for k, v in pairs(propsDic) do
            needDic[k] = v
        end
        for k, v in pairs(dic2) do
            needDic[k] = v
        end
    else
        needDic = propsDic
    end
    
    local list = {}
    for id, propsVo in pairs(needDic) do
        if (self:isBelongPage(propsVo, cusPageType, cusSuitIdList, cusSlotPosList, cusColorList)) then
            table.insert(list, propsVo)
        end
    end

    if cusSortData then
        -- 是否降序
        local isDescending = cusSortData.isDescending
        local sortList = cusSortData.sortList
        local function _sort(propsVo1, propsVo2)
            if (propsVo1 and propsVo2) then
                for i = 1, #sortList do
                    local sortFun = nil
                    if i == 1 then
                        -- 主排序按实际排序，其他默认降序
                        sortFun = bag.getSortFun(isDescending, sortList[i])
                    else
                        sortFun = bag.getSortFun(true, sortList[i])
                    end

                    local result = sortFun(propsVo1, propsVo2)
                    sortFun = nil
                    if (result ~= nil) then
                        return result
                    end
                end
            end
            return false
        end
        table.sort(list, _sort)
    end
    return list
end

-- 道具列表排序，降序
function sortPropsListByDescending(propsVo1, propsVo2)
    if (propsVo1 and propsVo2) then
        -- 品质从大到小
        if (propsVo1.color and propsVo2.color) then
            if (propsVo1.color > propsVo2.color) then
                return true
            end
            if (propsVo1.color < propsVo2.color) then
                return false
            end
        end
        -- -- 创建时间从大到小
        -- if (propsVo1.createdTime and propsVo2.createdTime) then
        --     if (propsVo1.createdTime > propsVo2.createdTime) then
        --         return true
        --     end
        --     if (propsVo1.createdTime < propsVo2.createdTime) then
        --         return false
        --     end
        -- end
        -- id从大到小
        if (propsVo1.id and propsVo2.id) then
            if (propsVo1.id > propsVo2.id) then
                return true
            end
            if (propsVo1.id < propsVo2.id) then
                return false
            end
        end
        -- tid从大到小
        if (propsVo1.tid and propsVo2.tid) then
            if (propsVo1.tid > propsVo2.tid) then
                return true
            end
            if (propsVo1.tid < propsVo2.tid) then
                return false
            end
        end
    end
    return false
end

-- 判断道具是否属于对应的页签类型
function isBelongPage(self, cusPropsVo, cusPageType, cusSuitIdList, cusSlotPosList, cusColorList)
    if (cusPageType == bag.BagTabType.EQUIP) then
        if (cusPropsVo.type == PropsType.EQUIP and cusPropsVo.subType < PropsEquipSubType.SLOT_7) then
            if (not cusColorList or table.indexof(cusColorList, cusPropsVo.color) ~= false) then
                if (not cusSlotPosList or table.indexof(cusSlotPosList, cusPropsVo.subType) ~= false) then
                    if (not cusSuitIdList or table.indexof(cusSuitIdList, equip.EquipSuitManager.All_SUIT_EQUIP_ID) ~= false) then
                        return true
                    else
                        local equipConfigVo = equip.EquipManager:getEquipConfigVo(cusPropsVo.tid)
                        if (table.indexof(cusSuitIdList, equipConfigVo.suitId) ~= false) then
                            return true
                        end
                    end
                end
            end
        end
    elseif (cusPageType == bag.BagTabType.BRACELETS) then
        if (cusPropsVo.subType == PropsEquipSubType.SLOT_7) then
            return true
        end
    elseif (cusPageType == bag.BagTabType.ORDER) then
        if (cusPropsVo.type == PropsType.ORDER) then
            return true
        end
    elseif (cusPageType == bag.BagTabType.NORMAL) then
        if (cusPropsVo.type == PropsType.NORMAL) then
            if (cusPropsVo.isCanUse == false) then
                return true
            end
        elseif cusPropsVo.type == PropsType.HERO_FRAGMENT then
            return true
        end
    elseif (cusPageType == bag.BagTabType.CONSUME) then
        if (cusPropsVo.type == PropsType.NORMAL ) then
            if (cusPropsVo.isCanUse == true) then
                return true
            end
        end
    -- elseif (cusPageType == bag.BagTabType.HERO_FRAGMENT) then
    --     if (cusPropsVo.type == PropsType.HERO_FRAGMENT) then
    --         return true
    --     end
    elseif (cusPageType == bag.BagTabType.RAWMAT) then
        if (cusPropsVo.type == PropsType.RAWMAT) then
            if (cusPropsVo.isCanUse == false) then
                return true
            end
        end
    elseif (cusPageType == bag.BagTabType.HEROEGG) then
        if (cusPropsVo.type == PropsType.HEROEGG) then
            if (cusPropsVo.isCanUse == false) then
                return true
            end
        end
    end
    return false
end

-- 获取背包上限
function getBagMaxCount(self, cusBagType)
    local count = 0
    if (cusBagType == nil) then
        local bagTypeDic = bag.BagType
        for bagTypeName, bagType in pairs(bagTypeDic) do
            count = count + (self.mCapacityDic[bagType] or 0)
        end
    else
        count = self.mCapacityDic[cusBagType] or 0
    end
    return count
end

-- 背包是否已满（newCount 新增入包数量，不传则当前背包状态）
function bagIsFull(self, newCount, cusBagType)
    local capacity = 0
    local allCount = 0
    if (cusBagType == nil) then
        local bagTypeDic = bag.BagType
        for bagTypeName, bagType in pairs(bagTypeDic) do
            local propsDic = self:getPropsDic(bagType)
            local count = table.nums(propsDic)
            allCount = allCount + count
        end

        for bagType, _capacity in pairs(self.mCapacityDic) do
            capacity = capacity + _capacity
        end
    else
        allCount = table.nums(self:getPropsDic(cusBagType))
        capacity = self:getBagMaxCount(cusBagType)
    end

    if newCount and newCount > 0 then
        if allCount + newCount > capacity then
            return true
        end
    else
        if allCount >= capacity then
            return true
        end
    end
    return false
end

-- 获取获取道具字典
function getAllPropsDic(self)
    return self.mBagDic or {}
end

-- 获取道具字典
function getPropsDic(self, cusBagType)
    -- --特殊处理 合并了背包和英雄碎片
    -- if cusBagType == bag.BagType.Bag then
    --     local list1 = self.mBagDic[cusBagType] and self.mBagDic[cusBagType] or {}
    --     local list2 = self.mBagDic[bag.BagType.HeroFragment] and self.mBagDic[bag.BagType.HeroFragment] or {}
    --     -- for i = 1,#list2 do
    --     --     table.insert(list1,list2[i])
    --     -- end
    --     -- return list1
    --     return table.merge(list1, list2)
    --     --return
    -- end

    if (cusBagType) then
        return self.mBagDic[cusBagType] or {}
    else
        return {}
    end
end

-- 根据id获取背包中的物品
function getPropsVoById(self, cusId, cusBagType)
    if (cusBagType) then
        local propsDic = self:getPropsDic(cusBagType)
        return propsDic[cusId]
    else
        local bagTypeDic = bag.BagType
        for bagTypeName, bagType in pairs(bagTypeDic) do
            local propsDic = self:getPropsDic(bagType)
            if (propsDic[cusId]) then
                return propsDic[cusId]
            end
        end
    end
end

-- 根据tid获取背包中的物品
function getPropsListByTid(self, cusTid, expectId, cusBagType, cusExcludeLock)
    local propsList = {}
    if (cusBagType) then
        local propsDic = self:getPropsDic(cusBagType)
        for id, propsVo in pairs(propsDic) do
            if (propsVo.id ~= expectId and propsVo.tid == cusTid) then
                if not cusExcludeLock or (cusExcludeLock and propsVo.isLock ~= 1) then
                    table.insert(propsList, propsVo)
                end
            end
        end
    else
        local bagTypeDic = bag.BagType
        for bagTypeName, bagType in pairs(bagTypeDic) do
            local propsDic = self:getPropsDic(bagType)
            for id, propsVo in pairs(propsDic) do
                if (propsVo.id ~= expectId and propsVo.tid == cusTid) then
                    if not cusExcludeLock or (cusExcludeLock and propsVo.isLock ~= 1) then
                        table.insert(propsList, propsVo)
                    end
                end
            end
        end
    end

    return propsList
end

-- 根据tid获取指定背包中的物品的总数量，不指定背包则默认检查所有背包
function getPropsCountByTid(self, cusTid, cusBagType)
    local count = 0
    if (cusBagType) then
        local propsDic = self:getPropsDic(cusBagType)
        for id, propsVo in pairs(propsDic) do
            if (propsVo.tid == cusTid) then
                count = count + propsVo.count
            end
        end
    else
        local bagTypeDic = bag.BagType
        for bagTypeName, bagType in pairs(bagTypeDic) do
            local propsDic = self:getPropsDic(bagType)
            for id, propsVo in pairs(propsDic) do
                if (propsVo.tid == cusTid) then
                    count = count + propsVo.count
                end
            end
        end
    end
    return count
end

-- 根据主类型和子类型获取道具列表
function getPropsListByType(self, cusType, cusSubType, cusBagType)
    local propsList = {}
    if (cusBagType) then
        local propsDic = self:getPropsDic(cusBagType)
        for id, propsVo in pairs(propsDic) do
            if (propsVo.type == cusType) then
                if (cusSubType == nil) then
                    table.insert(propsList, propsVo)
                else
                    if (cusSubType == propsVo.subType) then
                        table.insert(propsList, propsVo)
                    end
                end
            end
        end
    else
        local bagTypeDic = bag.BagType
        for bagTypeName, bagType in pairs(bagTypeDic) do
            local propsDic = self:getPropsDic(bagType)
            for id, propsVo in pairs(propsDic) do
                if (propsVo.type == cusType) then
                    if (cusSubType == nil) then
                        table.insert(propsList, propsVo)
                    else
                        if (cusSubType == propsVo.subType) then
                            table.insert(propsList, propsVo)
                        end
                    end
                end
            end
        end
    end
    return propsList
end

-- 根据效果类型获取道具列表
function getPropsListByEffect(self, cusEffectType, cusBagType)
    local propsList = {}
    if (cusBagType) then
        local propsDic = self:getPropsDic(cusBagType)
        for id, propsVo in pairs(propsDic) do
            if (propsVo.effectType == cusEffectType) then
                table.insert(propsList, propsVo)
            end
        end
    else
        local bagTypeDic = bag.BagType
        for bagTypeName, bagType in pairs(bagTypeDic) do
            local propsDic = self:getPropsDic(bagType)
            for id, propsVo in pairs(propsDic) do
                if (propsVo.effectType == cusEffectType) then
                    table.insert(propsList, propsVo)
                end
            end
        end
    end
    return propsList
end

-- ==================================分解出售====================================
-- 获取道具分解出售对应的数据
function getBreakBaseData(self, cusTid, cusType)
    if not self.mBreakBaseData then
        self:parseBreakConfigData()
    end
    if not self.mBreakBaseData[cusType][cusTid] then
        logError(string.format("没有对应的%s配置 tid：%s", (cusType == 1 and "出售" or "分解"), cusTid))
    end
    return self.mBreakBaseData[cusType][cusTid]
end

-- 分解缓存列表
function getBreakList(self)
    if not self.mBreakList then
        self.mBreakList = {}
    end
    return self.mBreakList
end

-- 存入分解id
function setBreakProps(self, cusId)
    local state = nil
    local idx = table.indexof(self:getBreakList(), cusId)
    if idx ~= false then
        table.remove(self:getBreakList(), idx)
        state = 0
    else
        table.insert(self:getBreakList(), cusId)
        state = 1
    end

    bag.BagManager:dispatchEvent(bag.BagManager.EVENT_BREAK_SHOW_UPDATE, {state = state, id = cusId})
    GameDispatcher:dispatchEvent(EventName.BAG_BREAK_UPDATE_VIEW)
end

function setBreakPropsList(self, args)
    local type = args.type
    local state = args.state
    local list = args.list
    for i, v in ipairs(list) do
        local idx = table.indexof(self:getBreakList(), v)
        if idx ~= false and state == 0 then
            table.remove(self:getBreakList(), idx)
        end
        if idx == false and state == 1 then
            table.insert(self:getBreakList(), v)
        end
    end
    bag.BagManager:dispatchEvent(bag.BagManager.EVENT_BREAK_SHOW_UPDATE)
    GameDispatcher:dispatchEvent(EventName.BAG_BREAK_UPDATE_VIEW)
    -- self:dispatchEvent(self.BAG_UPDATE, { addList = {}, updateList = {}, delList = {} })
end
-- 出售缓存数据
function getSellData(self)
    return self.mSellData
end
-- 设置出售道具数据
function setSellData(self, cusNum, cusId)
    if not self.mSellData then
        self.mSellData = {}
    end
    self.mSellData.id = cusId or self.mSellData.id
    self.mSellData.num = cusNum
    if cusId then
        bag.BagManager:dispatchEvent(bag.BagManager.EVENT_SELL_SHOW_UPDATE)
        self:dispatchEvent(self.BAG_UPDATE, {addList = {}, updateList = {}, delList = {}})
    end
end
-- 清除售出、分解数据
function clearSellBreakData(self)
    self.mSellData = nil
    self.mBreakList = nil
end

--获取是否处于分解列表
function getBreakSelect(self, cusVo)
    local breakList = self:getBreakList()
    local sellData = self:getSellData()
    if sellData and cusVo.id == sellData.id then
        return true
    end
    if breakList and table.indexof(breakList, cusVo.id) ~= false then
        return true
    end
    return false
end

-- ==================================红点====================================
-- 设置可操作数据
function setFlagValue(self, cusPageType, cusValue)
    if (self.mBubbleDic[cusPageType] == nil and cusValue == false) then
        self.mBubbleDic[cusPageType] = cusValue
        return
    end
    if (self.mBubbleDic[cusPageType] ~= cusValue) then
        self.mBubbleDic[cusPageType] = cusValue
        self:dispatchEvent(self.BUBBLE_CHANGE, {tabType = cusPageType, isBubble = cusValue})
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_BAG, cusValue)
    end
end

-- 获取可操作数据值
function getFlagValue(self, cusPageType)
    return self.mBubbleDic[cusPageType] or false
end

-- 遍历标志字典，有值为1返回true,否则返回flase
function getIsFlag(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BAG)
    if not isOpen then
        return false
    end
    for bagPageType, value in pairs(self.mBubbleDic) do
        if (value) then
            return true
        end
    end
    return false
end

-- 更新红点
function updateBubble(self)
    local equipBubble = false
    local normalBubble = false
    local consumeBubble = false
    local bagTypeDic = bag.BagType
    local consumeRedPointHelper = {}
    for _, bagType in pairs(bagTypeDic) do
        local propsDic = self:getPropsDic(bagType)
        for id, propsVo in pairs(propsDic) do
            if (not equipBubble and self:checkEquipBubble(propsVo)) then
                equipBubble = true
            end
            if (not normalBubble and self:checkNormalBubble(propsVo)) then
                normalBubble = true
            end
            if propsVo.isCanUse then
                if propsVo.effectType ~= UseEffectType.ADD_STAMINA then
                    consumeBubble = self:checkConsumeBubble(propsVo)
                elseif propsVo.effectType == UseEffectType.USE_GET_HEROEGG then
                    local hasCount = bag.BagManager:getPropsCountByTid(propsVo.tid)
                    local needCount = propsVo.effectList[1] 
                    if hasCount >= needCount then
                        consumeBubble = self:checkConsumeBubble(propsVo)
                    end
                end
            end
        end
    end

    -- if next(consumeRedPointHelper) then
    --     for i = 1, #consumeRedPointHelper do
    --         if consumeRedPointHelper[i] then
    --             consumeBubble = true
    --             break
    --         end
    --     end
    -- end
    self:setFlagValue(bag.BagTabType.EQUIP, equipBubble)
    self:setFlagValue(bag.BagTabType.NORMAL, normalBubble)
    self:setFlagValue(bag.BagTabType.CONSUME, consumeBubble)
end

-- 检查芯片页签是否有红点
function checkEquipBubble(self, cusPropsVo)
    return false
end

-- 检查物资页签是否有红点
function checkNormalBubble(self, cusPropsVo)
    if cusPropsVo.effectType == UseEffectType.ADD_DISCOUNT_ITEM then
        return read.ReadManager:isModuleRead(ReadConst.DISCOUNT_BUBBLE, cusPropsVo.tid)
    end
end

-- 检查用品页签是否有红点
function checkConsumeBubble(self, cusPropsVo)
    return self:checkIsNewAdd(cusPropsVo)
end

-- 检查道具是否新加入
function checkIsNewAdd(self, cusPropsVo)
    if (cusPropsVo.tid == MoneyTid.ANTIEPIDEMIC_SERUM_TID) then
        return false
    end
    if cusPropsVo.effectType == UseEffectType.ADD_DISCOUNT_ITEM then
        return read.ReadManager:isModuleRead(ReadConst.DISCOUNT_BUBBLE, cusPropsVo.tid)
    end
    if cusPropsVo.isCanUse then
        return read.ReadManager:isModuleRead(ReadConst.CONSUME_TABVIEW, 1)
    end
    return read.ReadManager:isModuleRead(ReadConst.NORMALBAGITEM, cusPropsVo.tid)
end

--手环分解是否点击不再弹出tips
function setBreakBraceletsShowTips(self, value)
    self.mIsShowBreakBraceletsTip = value
end

function getBreakBraceletsShowTips(self)
    return self.mIsShowBreakBraceletsTip
end

function setBreakHeroEggShowTips(self,value)
    self.mIsShowBreakHeroEggTip = value 
end

function getBreakHeroEggShowTips(self)
    return self.mIsShowBreakHeroEggTip
end

--检查道具是否满足数量
function checkPropsCountIsEnough(self, itemId, needNum, isNoTips)
    local ownNum = self:getPropsCountByTid(itemId)
    if ownNum < needNum then
        if not isNoTips then
            gs.Message.Show(_TT(60518))
        end
        return false
    end
    return true
end

function setIsOpenEggProps(self, b)
    self.isOpenEggProps = b
end

function getIsOpenEggProps(self)
    local b = self.isOpenEggProps
    self.isOpenEggProps = false
    return b
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
