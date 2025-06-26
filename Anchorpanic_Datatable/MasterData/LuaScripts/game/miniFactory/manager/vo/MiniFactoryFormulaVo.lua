--[[ 
-----------------------------------------------------
@filename       : MiniFacFormulaVo
@Description    : 迷你工厂公式解析
@date           : 2022-2-28 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("miniFac.MiniFactoryFormulaVo", Class.impl())

function ctor(self)
end

function parseFormula(self, cusData, key)
    -- 订单id
    self.key = key
    -- 产品道具id
    self.tid = cusData.item_tid
    -- 商品数量
    self.itemNum = cusData.item_num
    -- 商品简述
    self.resume = cusData.resume
    -- 生产耗时
    self.cost = cusData.time_cost
    -- 工厂类型 
    self.type = cusData.type
    -- 消耗道具id
    self.payId = cusData.pay_tid
    -- 消耗道具数量
    self.payCost = cusData.cost_num
    -- 等级限制
    self.lvLimit = cusData.player_lv
    -- 排序
    self.sort = cusData.sort 
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
