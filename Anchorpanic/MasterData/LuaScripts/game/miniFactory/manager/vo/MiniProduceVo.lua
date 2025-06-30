--[[ 
-----------------------------------------------------
@filename       : MiniProduceVo
@Description    : 迷你工厂-生产列表解析
@date           : 2022-02-28 15:55:27
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('miniFactory.MiniProduceVo', Class.impl())

function parseOneProduce(self, cusMsg)
    --模块id
    self.id = cusMsg.module_id
    --订单Id
    self.orderId = cusMsg.formula_id
    --订单数量
    self.orderNum = cusMsg.formula_num
    --结束时间
    self.endTime = cusMsg.need_time

    if self.orderId > 0 then
        local formulaVo = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.orderId)
        self.tid = formulaVo.tid
    end
end

-- 刷新消耗的货币类型
function getPayType(self)
    return self.mCostPayType
end

--获取货币图标
function getPayIcon(self)
    if self:getPayType() > 0 then
        return MoneyUtil.getMoneyIconUrlByType(self:getPayType())
    end
end
--获取产能当前数量
function getPayNums(self)
    local curMoney = miniFac.MiniFactoryManager:getFactoryCapacityVo().capacity
    return curMoney
end
--获取道具Tid
function getPropsTid(self)
    local formulaVo = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.orderId)
    return formulaVo.tid
end
--获取道具名称
function getPropName(self)
    local name = props.PropsManager:getPropsConfigVo(self.tid).name
    return name
end
--获取道具总耗时
function getTime(self)
    local formulaVo = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.orderId)
    return formulaVo.cost * self.orderNum
end
--获取道具单个耗时
function getSingleTime(self)
    local formulaVo = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.orderId)
    return formulaVo.cost
end
--获取道具单个生产时的数量
function getItemNum(self)
    local formulaVo = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.orderId)
    return formulaVo.itemNum
end
--获取道具生产总数量
function getSum(self)
    if self.orderNum == nil then
        self.orderNum = 0
    end
    return self.orderNum
end
--获取剩余时间
function getRemainTime(self)
    local residueTime = self.endTime - GameManager:getClientTime()
    if self.endTime - GameManager:getClientTime() > self:getTime() then
        residueTime = self:getTime()
    end
    return residueTime
end
--获取对应语言包
function getLuange(self)
    local type = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.orderId).type
    local luangeNum = type + 60538
    return _TT(luangeNum)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]