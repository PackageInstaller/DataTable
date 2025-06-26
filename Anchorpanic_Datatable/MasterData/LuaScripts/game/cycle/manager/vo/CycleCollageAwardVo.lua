--[[   
     收藏品奖励数据
]]
module("cycle.CycleCollageAwardVo", Class.impl())

function parseAwardVo(self,id,data)
    self.id = id 

    self.num = data.num 
    self.reward = data.reward   
end


return _M