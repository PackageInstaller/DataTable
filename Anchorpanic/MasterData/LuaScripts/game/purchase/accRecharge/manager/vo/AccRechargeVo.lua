module("purchase.AccRechargeVo", Class.impl())

function parseData(self, cusData, id)
    self.id = id
    self.getNum = cusData.get_num
    self.dropId = cusData.drop_id
end

function sort(self)
    local sort = self.id
    if purchase.AccRechargeManager:hasGeted(self.id) then
        sort = sort + 10000
    end
    return sort
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]