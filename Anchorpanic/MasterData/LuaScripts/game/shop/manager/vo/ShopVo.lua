--[[-----------------------------------------------------
@filename       : ShopVo
@Description    : 商店商品数据
@date           : 2020-05-22 17:07:48
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('shop.ShopVo', Class.impl())

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
    -- 兑换道具tid
    self.pay_tid = cusMsg.pay_tid
    -- 销售价格
    self.price = cusMsg.price
    -- 原价
    self.old_price = cusMsg.old_price
    -- 折扣
    self.discount = cusMsg.discount
    -- 玩家等级：下限
    self.player_lv = cusMsg.player_lv
    -- 玩家等级：上限
    self.hide_lvl = cusMsg.hide_lvl
    -- 盟约势力等阶：上限
    self.prestige_stage = cusMsg.stage
    -- 限制购买次数
    self.limit_count = cusMsg.limit_num
    -- 已购买次数
    self.buy_times = cusMsg.buy_times
    -- 排序
    self.sort = cusMsg.sort
    -- 前端描述语言包
    self.resume = cusMsg.resume
    -- 是否已锁定 1是 0否
    self.lock = cusMsg.lock
    -- 限购类型
    self.limitType = cusMsg.limit_type
    -- 角标（1-免费，2-折扣，3-热销）
    self.tag = cusMsg.tag
    --性价比 百分比
    self.priceRatio = cusMsg.value or 0
    -- 掉落包id
    self.dropId = cusMsg.drop_id
    -- 联盟等级
    self.guildLv = cusMsg.guild_lv
    -- 出售开始时间
    self.beginTime = cusMsg.begin_time
    -- 出售结束时间
    self.endTime = cusMsg.end_time
end

-- 商品id
function getId(self)
    return self.id
end
-- 商店类型标签
function getType(self)
    return self.type
end
-- 商店限购类型
function getLimitType(self)
    return self.limitType
end
-- 道具模版tid
function getItemTid(self)
    return self.item_tid
end
-- 道具数量
function getItemNum(self)
    return MoneyUtil.shortValueStr(self.item_num)
end
-- 支付类型
function getPayType(self)
    return self.pay_type
end
-- 消耗道具tid
function getPayTid(self)
    return self.pay_tid
end
-- 销售价格
function getPrice(self)
    return self.price
end
-- 原价
function getOldPrice(self)
    return self.old_price
end
-- 折扣（万分比）
function getDiscount(self)
    return self.discount
end
-- 限制等级下限
function getMinLv(self)
    return self.player_lv
end
-- 限制等级上限
function getMaxLv(self)
    return self.hide_lvl
end
-- 限制势力等阶下限
function getMinPrestigeSage(self)
    return self.prestige_stage
end
-- 获取限购次数
function getLimit(self)
    return self.limit_count
end
-- 已购买次数
function getBuyTimes(self)
    return self.buy_times
end
-- 排序
function getSort(self)
    return self.sort
end
-- 唯一支付类型（都是支付类型也是tid）
function getRealPayType(self)
    if self:getPayType() > 0 then
        return self:getPayType()
    else
        return self:getPayTid()
    end
end
-- 商店显示的简短描述语言包id
function getResume(self)
    return self.resume
end
-- 是否已锁定 1是 0否
function isLock(self)
    return (self.lock == 1)
end

-- 是否售罄
function isSoldout(self)
    if (self:getLimitCount() == 0 and self:getLimit() > 0) then
        return true
    end
    return false
end

-- 获取角标
function getTag(self)
    return self.tag
end

--获取性价比 百分比
function getPriceRatio(self)
    return self.priceRatio .. "%"
end

-- 获取掉落包Id
function getDropId(self)
    return self.dropId
end

-- 取剩余购买数量
function getLimitCount(self)
    return self:getLimit() - self:getBuyTimes()
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
    return MoneyUtil.getMoneyIconUrlByType(self:getRealPayType())
end

-- 是否满足所有限制
function isEnoughLimit(self)
    local isEnough = self:isEnoughPlayerLvl()
    if (not isEnough) then return false end
    local isEnough = self:isEnoughPerstigeStage()
    if (not isEnough) then return false end
    return true
end

-- 是否满足玩家等级限制
function isEnoughPlayerLvl(self)
    local roleLv = role.RoleManager:getRoleVo():getPlayerLvl()
    if self:getMinLv() > roleLv or roleLv > self:getMaxLv() then
        return false
    end

    return true
end

-- 是否满足玩家声望等阶限制
function isEnoughPerstigeStage(self)
    local perstigeStage = role.RoleManager:getRoleVo():getPlayerPerstigeStage()
    if (perstigeStage < self:getMinPrestigeSage()) then
        return false
    end

    return true
end

-- 联盟等级
function getGuildLv(self)
    return self.guildLv
end

-- 开始时间
function getBeginTime(self)
    return self.beginTime
end

-- 结束时间
function getEndTime(self)
    return self.endTime
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]