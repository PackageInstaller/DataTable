module('shop.ShopManager', Class.impl(Manager))

-- 商品数据更新
EVENT_SHOP_DATA_UPDATE = 'EVENT_SHOP_DATA_UPDATE'
-- 单个商品更新
EVENT_SHOP_ITEM_UPDATE = 'EVENT_SHOP_ITEM_UPDATE'
-- 商店数据
EVENT_SHOP_TYPE_UPDATE = 'EVENT_SHOP_TYPE_UPDATE'

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
    self.mShopShowList = nil
    self.mShopItemData = {}
    self.mShopTypeData = {}
    self.mIsRoll = false
end

-- 解析商店配置
function parseConfigData(self, cusData)
    self.mShopShowList = {}
    local baseData = RefMgr:getData("shop_show_data")
    for key, data in pairs(baseData) do
        local vo = shop.ShopShowVo.new()
        vo:parseConfigData(key, data)
        table.insert(self.mShopShowList, vo)
    end
    table.sort(self.mShopShowList, function(a, b)
        return a.sort < b.sort
    end)
end

-- 解析商店数据
function parseShopDataMsg(self, msg)
    for _, dic in pairs(self.mShopItemData) do
        for k, v in pairs(dic) do
            LuaPoolMgr:poolRecover(v)
        end
    end
    self.mShopItemData = {}

    for i, data in pairs(msg.shop_data) do
        local vo = LuaPoolMgr:poolGet(shop.ShopVo)
        vo:parseMsg(data)
        if not self.mShopItemData[vo:getType()] then
            self.mShopItemData[vo:getType()] = {}
        end
        self.mShopItemData[vo:getType()][vo:getId()] = vo
    end

    self:dispatchEvent(EVENT_SHOP_DATA_UPDATE)
end

--覆盖更新指定类型的商店数据
function updateShopData(self, msg)
    if not self.mShopItemData then
        self.mShopItemData = {}
    end

    self.mShopItemData[msg.shop_type] = {}

    for i, data in pairs(msg.shop_data) do
        local vo = LuaPoolMgr:poolGet(shop.ShopVo)
        vo:parseMsg(data)
        if not self.mShopItemData[vo:getType()] then
            self.mShopItemData[vo:getType()] = {}
        end
        self.mShopItemData[vo:getType()][vo:getId()] = vo
    end

    self:dispatchEvent(EVENT_SHOP_DATA_UPDATE)
end

--解析碎片商店规则配置
function priceFragmentsConfigData(self)
    self.mPriceFramgmentsConfigDic = {}
    local baseData = RefMgr:getData("fragment_price_data")
    for id, data in pairs(baseData) do
        local vo = shop.ShopFragmentRuleVo.new()
        vo:priceConfigData(id, data)
        self.mPriceFramgmentsConfigDic[id] = vo
    end
end

-- 更新个别商品数据
function parseShopDataUpdateMsg(self, msg)
    if not self.mShopItemData then
        logError("更新个别商品数据，但商店数据未初始化")
        return
    end
    for i, v in ipairs(msg.shop_data) do
        if not self.mShopItemData[v.type] then
            self.mShopItemData[v.type] = {}
        end
        local vo = self.mShopItemData[v.type][v.id]
        if not vo then
            vo = LuaPoolMgr:poolGet(shop.ShopVo)
        end
        vo:parseMsg(v)
        self.mShopItemData[vo:getType()][vo:getId()] = vo
    end

    self:dispatchEvent(EVENT_SHOP_DATA_UPDATE)
end

-- 购买返回
function parseShopBuyMsg(self, msg)
    local item = self:getShopItem(msg.shop_type, msg.shop_id)
    item.buy_times = item.buy_times + msg.num
    self:dispatchEvent(EVENT_SHOP_ITEM_UPDATE, {type = msg.shop_type, id = msg.shop_id})
end

-- 某类型商店数据更新
function parseShopTypeDataMsg(self, msg)
    local vo = LuaPoolMgr:poolGet(shop.ShopTypeVo)
    vo:parseMsg(msg)
    self.mShopTypeData[vo:getType()] = vo

    self:dispatchEvent(EVENT_SHOP_TYPE_UPDATE, msg.shop_type)
end

-- 获取商店页面显示规则
function getShopShowList(self)
    if not self.mShopShowList then
        self:parseConfigData()
    end
    return self.mShopShowList
end
-- 获取对应类型的商店商品数据
function getShopItemData(self, cusType)
    return self.mShopItemData[cusType]
end

-- 获取对应类型的商店商品有序列表
function getShopItemList(self, cusType)
    local list = {}
    if not self:getShopItemData(cusType) then
        return list
    end
    for i, vo in pairs(self:getShopItemData(cusType)) do
        if vo:isEnoughPlayerLvl() then
            if vo:getType() == ShopType.COVENANT then
                if vo:getMinPrestigeSage() <= covenant.CovenantManager:getPerstigeStage() then
                    table.insert(list, vo)
                end
            else
                table.insert(list, vo)
            end
        end
    end
    table.sort(list, function(a, b)
        return a:getSort() < b:getSort()
    end)
    for i, vo in ipairs(list) do
        vo.tweenId = (2 * i) - 1
    end
    return list
end

--获取碎片商店配置
function getFragmentsRuleConfigData(self)
    if not self.mPriceFramgmentsConfigDic then
        self:priceFragmentsConfigData()
    end
    return self.mPriceFramgmentsConfigDic
end

--获取对应的碎片规则配置
function getFragmentsRuleConfigDataById(self, id)
    local data = self:getFragmentsRuleConfigData()[id]
    return data
end

-- 获取对应类型的商店数据
function getShopData(self, cusType)
    return self.mShopTypeData[cusType]
end

-- 获取一个商品数据 cusType 商店类型 cusId 商品id
function getShopItem(self, cusType, cusId)
    local shopData = self.mShopItemData[cusType]
    if not shopData then
        Debug:log_error('ShopManager', '不存在商店类型：', cusType)
        return nil
    end

    if not shopData[cusId] then
        Debug:log_error('ShopManager', '不存在商品Id：', cusId)
        return nil
    end
    return shopData[cusId]
end

-- 获取一个商品数据 cusType 商店类型 cusTid 商品tid
function getShopItemByTid(self, cusType, cusTid)
    local shopData = self.mShopItemData[cusType]
    if not shopData then
        -- Debug:log_error('ShopManager', '不存在商店类型：', cusType)
        print('ShopManager' .. '不存在商店类型：'..cusType)
        return nil
    end

    for id, shopVo in pairs(shopData) do
        if (shopVo.item_tid == cusTid) then
            return shopVo
        end
    end
    -- Debug:log_error('ShopManager', '不存在商品Tid：', cusTid)
    print('ShopManager' .. '不存在商品Tid：'..cusTid)
    return nil
end

-- 判断物品判断类型
function getPropsJudgeType(self, costTid, costCount)
    local hasCount = bag.BagManager:getPropsCountByTid(costTid)
    if (hasCount >= costCount) then
        return shop.PropsJudge.PROPS_ENOUGH
    else
        local needCount = costCount - hasCount
        local shopVo = shop.ShopManager:getShopItemByTid(ShopType.NOMAL, costTid)
        if (shopVo) then
            local remainTimes = 999999999
            if (shopVo.limit_count > 0) then
                remainTimes = shopVo.limit_count - shopVo.buy_times
            end
            -- 是否超过购买上限
            local needBuyTimes = math.ceil(needCount / shopVo.item_num)
            if (needBuyTimes <= remainTimes) then
                -- 是否足够货币
                local needMoney = needBuyTimes * shopVo.price
                if (MoneyUtil.judgeNeedMoneyCountByType(shopVo.pay_type, needMoney, false, false)) then
                    GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_PANEL, shopVo)
                    return shop.PropsJudge.MONEY_ENOUGH
                else
                    GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_PANEL, shopVo)
                    return shop.PropsJudge.MONEY_NOT_ENOUGH
                end
            else
                -- 会超过购买上限
                return shop.PropsJudge.BUY_TIMES_NOT_ENOUGH
            end
        else
            return shop.PropsJudge.PROPS_NOT_ENOUGH
        end
    end
end

--修改滑动显示
function setRoll(self, isRoll)
    self.mIsRoll = isRoll
end
--获取滚动状态
function getRollState(self)
    return self.mIsRoll
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]
