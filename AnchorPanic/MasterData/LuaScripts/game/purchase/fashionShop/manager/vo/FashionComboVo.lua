
module('purchase.FashionComboVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.goodsList = cusData.goods_list
    self.payType = cusData.pay_type
    self.cost = cusData.cost
    self.configVo = purchase.FashionShopManager:getFashionComboData(id)
    -- -- 开始时间
    self.beginTime = cusData.begin_time
    -- -- 结束时间
    self.endTime = cusData.end_time
end

-- 剩余时间
function getTime(self)
    local time = GameManager:getClientTime()

    if self.beginTime ~= 0 and self.endTime ~= 0 then
        return self.endTime - time
    end
    return 0
end

function getCanUpdate(self)
    local canUpdate = true
    local time = GameManager:getClientTime()
    if self.beginTime ~= 0 and self.endTime ~= 0 then
        if time >= self.endTime then
            canUpdate = false
        end
    end
    return canUpdate
end

return _M
