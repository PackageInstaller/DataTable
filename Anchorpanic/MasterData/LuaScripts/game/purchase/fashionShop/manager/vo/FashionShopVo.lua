--[[-----------------------------------------------------
@filename       : FashionShopVo
@Description    : 皮肤商店商品数据
@date           : 2023-01-28 17:54:48
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.FashionShopVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    -- 战员id与皮肤索引
    self.fashionDic = cusData.skin_id
    -- 消耗货币数量
    -- self.moneyCount = cusData.cost
    -- 兑换道具tid排序
    self.sort = cusData.sort
    -- -- 开始时间
    -- self.beginTime = cusData.begin_time
    -- -- 结束时间
    -- self.endTime = cusData.end_time
    -- --折扣万分比
    -- self.discount = cusData.discount
    -- 战员皮肤数据
    self.heroFashionData = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.fashionDic[1], self.fashionDic[2])
    -- 类型
    self.type = cusData.type
    -- 支付货币
    self.payType = cusData.pay_type
    -- 时装配置
    self.discountData = cusData.discount_time
    -- 折扣价格 用于折扣卡
    self.discountCost = cusData.discount_cost

    self.itemId = cusData.item_id
    --self.canUpdate = 0 -- 无更新 --等待折扣 --正在折扣
end

-- 折扣价格 用于折扣卡
function getDiscountCost(self)
    return self.discountCost
end

function getCanUpdate(self)
    if #self.discountData == 1 then
        return false
    end

    local canUpdate = true
    local time = GameManager:getClientTime()
    for _, data in pairs(self.discountData) do
        if data.begin_time ~= 0 and data.end_time ~= 0 then
            if time > data.end_time then
                canUpdate = false
            end
        end
    end
    return canUpdate
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

-- 获取皮肤名称
function getFashionName(self)
    if not self.heroFashionData then
        logError("战员tid" .. self.fashionDic[1] .. "皮肤编号id：" .. self.fashionDic[2])
    end
    return self.heroFashionData:getName()
end

function getMoneyTid(self)
    return self.payType
end

-- 获取战员名称
function getHeroName(self)
    return self.heroFashionData:getHeroName()
end

function getColour(self)
    return self.heroFashionData:getColour()
end

-- 剩余时间
function getTime(self)
    local time = GameManager:getClientTime()

    local data = self:getMsgDataByTime()
    if data.begin_time ~= 0 and data.end_time ~= 0 then
        return data.end_time - time
    end
    return 0
end

-- 皮肤系列
function getFashionSeries(self)
    return self.heroFashionData:getFashionSeries()
end

-- 当前皮肤介绍
function getFashionDsc(self)
    return self.heroFashionData:getFashionDsc()
end

-- 是否已售完/已持有
function getIsSellOut(self)
    return table.indexof(purchase.FashionShopManager:getFashionedTidList(), self.id)
end
-- 是否已穿戴
function getIsWear(self)
    local heroWearVo = fashion.FashionManager:getHeroWearingFashionVo(fashion.Type.CLOTHES,
    hero.HeroManager:getHeroIdByTid(self.fashionDic[1]))
    local isWear = false
    if heroWearVo and heroWearVo.fashionId == self.fashionDic[2] then
        isWear = true
    end
    return isWear
end

-- 穿戴
function onClickWearHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_HERO_WEAR_FASHION, {
        fashionType = fashion.Type.CLOTHES,
        heroId = hero.HeroManager:getHeroIdByTid(self.fashionDic[1]),
        fashionId = self.fashionDic[2]
    })
end

-- 获取半身像资源
function getShadowIcon(self)
    local url = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and "fashionShop_Har/" or "fashionShop/"
    return UrlManager:getIconPath(url .. self.heroFashionData.fashionIcon)
end

-- 获取皮肤立绘资源
function getFashionShowUrl(self)
    local url = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and "heroRecord_Har/" or "heroRecord/"
    return UrlManager:getBgPath(url .. self.heroFashionData:getUrlBody())
end

-- 获取当前战员tid
function getHeroTid(self)
    return self.fashionDic[1]
end

-- 皮肤id
function getFashionId(self)
    return self.fashionDic[2]
end

-- 获取当前皮肤模型model
function getFashionModel(self)
    return self.heroFashionData.model
end
-- 获取战员model
function getHeroModel(self)
    return hero.HeroManager:getHeroConfigVo(self:getHeroTid()):getHeroModel()
end

-- 获取当前皮肤模型model（优先高模）
function getFashionUIModel(self)
    if self.heroFashionData.highModel and self.heroFashionData.highModel ~= "" then
        return self.heroFashionData.highModel
    end
    return self.heroFashionData.model
end

-- 获取当前皮肤是否是限时皮肤
-- function getIsFashionTime(self)
--     -- if self.beginTime[1] and self.endTime[1] then
--     --     return true
--     -- end
--     return false
-- end

-- 获取is是否已获得战员
function getIsGainHero(self)
    return table.indexof(hero.HeroManager:getAllHeroTidList(), self.fashionDic[1])
end

function getDiscount(self)
    local data = self:getMsgDataByTime()
    return data.discount / 100
    -- --转化成百分比
    -- local discount = self.discount / 100
    -- return discount
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]