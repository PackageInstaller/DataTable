module("training.TrainingShopConfigVo", Class.impl())

function ctor(self)
end

function parseData(self, activeTimes, shopData)
    self.activeTimes = activeTimes
    self.costTid = shopData.cost_tid
    self.costNum = shopData.cost_num
    self.getCount = shopData.get
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
