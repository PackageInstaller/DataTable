--[[ 
-----------------------------------------------------
@filename       : ShopTypeVo
@Description    : 商店额外数据
@date           : 2020-07-29 10:29:48
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.shop.manager.vo.ShopTypeVo', Class.impl())

function parseMsg(self, cusMsg)
    -- 商店类型标签
    self.shop_type = cusMsg.shop_type
    -- 0-该商店没有定时刷新功能，其他-下次刷新时间
    self.next_refresh_time = cusMsg.next_refresh_time
    -- 已经刷新次数
    self.had_refresh = cusMsg.had_refresh
    -- 0-无限，其他-刷新上限
    self.refresh_limit = cusMsg.refresh_limit
    -- 刷新消耗的货币类型
    self.cost_pay = cusMsg.cost_pay
    -- 刷新的道具tid
    self.cost_item = cusMsg.cost_item
    -- 刷新消耗的数量
    self.cost_num = cusMsg.cost_num
end
-- 商店类型标签
function getType(self)
    return self.shop_type
end
-- 0-该商店没有定时刷新功能，其他-下次刷新时间
function getRefreshTime(self)
    return self.next_refresh_time
end
-- 已经刷新次数
function getHadRefreshTime(self)
    return self.had_refresh
end
-- 0-无限，其他-刷新上限
function getRefreshLimit(self)
    return self.refresh_limit
end
-- 刷新消耗的货币类型
function getPayType(self)
    return self.cost_pay
end
-- 刷新的道具tid
function getCostItem(self)
    return self.cost_item
end
-- 刷新消耗的数量
function getCostNum(self)
    return self.cost_num
end

--获取道具模版数据
function getItemConfigVo(self)
    return props.PropsManager:getPropsConfigVo(self:getCostItem())
end

-- 剩余刷新次数
function getRemaindTime(self)
    return self:getRefreshLimit() - self:getHadRefreshTime()
end

-- 还能不能手动刷新
function getCanRefresh(self)
    if self:getRefreshLimit() == 0 then
        return true
    end
    if self:getRemaindTime() > 0 then
        return true
    end
    return false
end

--获取货币图标
function getPayIcon(self)
    if self:getPayType() > 0 then
        return MoneyUtil.getMoneyIconUrlByType(self:getPayType())
    else
        return UrlManager:getPropsIconUrl(self:getCostItem())
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
