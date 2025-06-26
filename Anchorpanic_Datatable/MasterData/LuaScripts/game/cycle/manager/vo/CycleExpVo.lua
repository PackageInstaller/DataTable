module("cycle.CycleExpVo", Class.impl())

function parseExpVo(self,id,data)
    self.id = id 

    self.nextExp = data.next_exp
    self.addHope = data.add_hope
    self.addReasonLimit= data.add_reason_limit
    self.recoveryReason = data.recovery_reason
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
