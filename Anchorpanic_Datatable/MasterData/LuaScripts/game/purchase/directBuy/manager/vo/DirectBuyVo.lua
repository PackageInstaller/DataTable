module('purchase.DirectBuyVo', Class.impl())

function parseMsg(self, cusMsg)
    -- 商品id
    self.id = cusMsg.id
    -- 商店类型标签
    self.type = cusMsg.type
    -- 道具模板id
    self.item_tid = cusMsg.item_tid
    -- 道具数量
    self.item_num = cusMsg.item_num
    -- 支付类型
    self.pay_type = cusMsg.pay_type
    -- 销售价格
    self.price = cusMsg.price
    -- 折扣
    self.discount = cusMsg.discount
    -- 限制购买次数
    self.limit_count = cusMsg.limit_num
    -- 限购类型
    self.limit_type = cusMsg.limit_type
    -- 结束时间
    self.end_time = cusMsg.end_time
    -- 排序
    self.sort = cusMsg.sort
    -- 角标（1-免费，2-折扣，3-热销）
    self.tag = cusMsg.tag
    -- 掉落包id
    self.dropId = cusMsg.drop_id
    --性价比 百分比
    self.priceRatio = cusMsg.value or 0
    --背景颜色
    self.color = cusMsg.color
end

-- 商品id
function getId(self)
    return self.id
end
--获取性价比 百分比
function getPriceRatio(self)
    return self.priceRatio .. "%"
end
-- 商店类型标签
function getType(self)
    return self.type
end
-- 道具模版tid
function getItemTid(self)
    return self.item_tid
end
-- 道具数量
function getItemNum(self)
    return self.item_num
end
-- 支付类型
function getPayType(self)
    if (self.pay_type == 231) then
        return MoneyType.MONEY
    elseif (self.pay_type == 230) then
        return 998
    end
    return self.pay_type
end
-- 销售价格
function getPrice(self)
    if self.pay_type == MoneyType.MONEY then
        return self.price / 100
    end
    return self.price
end
-- 折扣（万分比）
function getDiscount(self)
    return self.discount
end
-- 获取限购次数
function getLimit(self)
    return self.limit_count
end
-- 限购类型
function getLimitType(self)
    return self.limit_type
end
-- 结束时间
function getEndTime(self)
    return self.end_time
end
-- 排序
function getSort(self)
    local sort = self.sort
    if not self:getIsOver() then
        sort = sort + 1000000
    end
    return sort
end
--是否已售罄
function getIsOver(self)
    local hadBuyNum = purchase.DirectBuyManager:getHadBuyNum(self:getId())
    local surplusNum = self:getLimit() - hadBuyNum
    return surplusNum <= 0
end

--获取道具模版数据
function getItemConfigVo(self)
    return props.PropsManager:getPropsConfigVo(self:getItemTid())
end

-- 获取消耗道具模版数据
function getPayItemConfigVo(self)
    return props.PropsManager:getPropsConfigVo(self:getPayTid())
end

-- 道具名
function getItemName(self)
    return self:getItemConfigVo().name
end

--获取货币图标
function getPayIcon(self)
    return MoneyUtil.getMoneyIconUrlByType(self:getPayType())
end

-- 获取角标
function getTag(self)
    return self.tag
end

-- 获取掉落包Id
function getDropId(self)
    return self.dropId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]