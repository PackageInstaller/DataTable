--[[-----------------------------------------------------
@filename       : PaintingMsgDataVo
@Description    : 皮肤商店插画数据
@date           : 2023-01-28 17:54:48
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module('purchase.PaintingMsgDataVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    -- 战员id与皮肤索引
    self.fashionDic = cusData.skin_id
    -- 消耗货币数量
    -- self.moneyCount = cusData.cost
    -- 兑换道具tid排序
    self.sort = cusData.sort
    -- -- 开始时间
    self.beginTime = cusData.begin_time
    -- -- 结束时间
    self.endTime = cusData.end_time
    -- --折扣万分比
    -- self.discount = cusData.discount
    -- 战员皮肤数据
    -- self.heroFashionData = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.fashionDic[1], self.fashionDic[2])
    -- 类型
    self.type = cusData.type
    -- 支付货币
    self.payType = cusData.pay_type
    -- 时装配置
    self.discountData = cusData.discount_time
    -- 折扣价格 用于折扣卡
    self.discountCost = cusData.discount_cost

    self.itemId = cusData.item_id
    -- self.canUpdate = 0 -- 无更新 --等待折扣 --正在折扣
end

function getMoneyTid(self)
    return self.payType
end

-- 折扣价格 用于折扣卡
function getDiscountCost(self)
    return self.discountCost
end

function getCanUpdate(self)
    local canUpdate = true
    local time = GameManager:getClientTime()
    if self.beginTime ~= 0 and self.endTime ~= 0 then
        return time < self.endTime
    end
    return true
end

function getMsgDataByTime(self)
    local time = GameManager:getClientTime()
    for _, data in pairs(self.discountData) do
        if time >= data.begin_time and time < data.end_time then
            return data
        end
    end
    return self.discountData[1]
end

function getMoneyCount(self)
    local data = self:getMsgDataByTime()
    return data.cost
end

-- 剩余时间
function getTime(self)
    local time = GameManager:getClientTime()

    for _, data in pairs(self.discountData) do
        if time >= data.begin_time and time < data.end_time then
            return data.end_time - time
        end
    end

    if self.beginTime ~= 0 and self.endTime ~= 0 then
        return self.endTime - time
    end
    return 0
end

-- 是否已售完/已持有
function getIsSellOut(self)
    return purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(self.id) and 1 or 2
end
-- 是否已穿戴
function getIsWear(self)

end

function getDiscount(self)
    local data = self:getMsgDataByTime()
    return data.discount / 100
    -- --转化成百分比
    -- local discount = self.discount / 100
    -- return discount
end

function getMoneyCount(self)
    local moneyTid = self:getMoneyTid()
    local data = self:getMsgDataByTime()
    if moneyTid == MoneyType.MONEY then
        return data.cost / 100
    else
        return data.cost
    end

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
