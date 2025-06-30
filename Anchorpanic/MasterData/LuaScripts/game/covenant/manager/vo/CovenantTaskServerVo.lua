module("covenant.CovenantTaskVo", Class.impl())

function paserServerData(self,cusData)
    self.id = cusData.id
    self.count = cusData.count
    --任务状态，1:未完成，0:已完成未领奖，2：已领取奖励
    self.state = cusData.state    
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
