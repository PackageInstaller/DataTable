module("purchase.RechargeCostManager", Class.impl(Manager))

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
    self.rechargeList = nil
end

--析构函数
function dtor(self)
end

function parseRechargeConfig(self)
    self.rechargeList = {}
    local baseData = RefMgr:getData("recharge_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(purchase.RechargeCostVo)
        vo:parseData(data, id)
        table.insert(self.rechargeList, vo)
    end
end

function getRechargeData(self, id)
    if self.rechargeList == nil then
        self:parseRechargeConfig()
    end
    return self.rechargeList[id]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]