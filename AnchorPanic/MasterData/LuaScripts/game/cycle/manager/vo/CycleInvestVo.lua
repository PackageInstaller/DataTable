module("cycle.CycleInvestVo", Class.impl())

function parseInvestVo(self,id,data)
    self.id = id 

    self.needCoin = data.show_coin
    self.des = data.des
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
