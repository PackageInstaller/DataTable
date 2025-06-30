--[[ 
    充值商品数据管理器
    @author zzz
]]
module("recharge.RechargeManager", Class.impl(Manager))

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
    -- 已充值的商品id列表
    self.hasRechargeList = {}
    -- 充值数据字典
    self.rechargeDic = nil
end

function parseRechargeList(self, msg)
    -- print("商品充值列表数量：" .. #msg.pay_cfg)
    -- print("商品已充值列表数量：" .. #msg.pay_list)

    self.hasRechargeList = msg.pay_list

    self.rechargeDic = {}
    for i = 1, #msg.pay_cfg do
        local rechargeVo = recharge.RechargeVo.new()
        rechargeVo:parseData(msg.pay_cfg[i])
        -- print(rechargeVo:toString())

        if (not self.rechargeDic[rechargeVo.type]) then
            self.rechargeDic[rechargeVo.type] = {}
        end
        table.insert(self.rechargeDic[rechargeVo.type], rechargeVo)
    end

    for type, list in pairs(self.rechargeDic) do
        table.sort(list, self.__sortRechargeList)
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_RECHARGEPANEL)
end

function parseRechargeConfigList(self)
    -- body
end

-- 充值列表排序
function __sortRechargeList(rechargeVo_1, rechargeVo_2)
    if (rechargeVo_1 and rechargeVo_2) then
        -- 价格从大到小
        if (rechargeVo_1.RMB > rechargeVo_2.RMB) then
            return false
        end
        if (rechargeVo_1.RMB < rechargeVo_2.RMB) then
            return true
        end
    end
    return false
end

-- 获取对应类型充值列表
function getAllRechargeList(self, rechargeType, rechargeSubType)
    if (not self.rechargeDic) then
        GameDispatcher:dispatchEvent(EventName.REQ_RECHARGE_LIST)
        return {}
    end
    if (rechargeSubType) then
        local filterList = {}
        local rechargelist = self.rechargeDic[rechargeType]
        if (rechargelist) then
            for i = 1, #rechargelist do
                if (rechargelist[i].subType == rechargeSubType) then
                    table.insert(filterList, rechargelist[i])
                end
            end
        end
        return filterList
    else
        return self.rechargeDic[rechargeType] or {}
    end
end

function getIsBuyOneGift(self)
    return (purchase.DirectBuyManager:getHadBuyNum(tonumber(recharge.rechargeDirectId.oneYuanGift)) >= 1)
end

-- 判断是否已经充值过
function checkIsRecharge(self, itemId)
    if (table.indexof(self.hasRechargeList, itemId) == false) then
        return false
    else
        return true
    end
end

-- 根据类型和限制条件获取充值vo
function getRechargeVoByDetail(self, cusType, cusSubType, detailId)
    local list = self:getAllRechargeList(cusType, cusSubType)
    if (list and #list > 0) then
        for i = 1, #list do
            if (detailId == nil or list[i].detailId == detailId) then
                return list[i]
            end
        end
    end
    return nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]