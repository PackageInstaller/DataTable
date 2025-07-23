module("cycle.CyclePointVo", Class.impl())

function parseData(self,id,data)
    self.id = id 
    self.score = data.score
    self.des = data.des
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
