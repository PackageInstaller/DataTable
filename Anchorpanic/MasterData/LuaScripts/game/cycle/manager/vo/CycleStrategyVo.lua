module("cycle.CycleStrategyVo", Class.impl())

function parseStrategy(self,id,data)
    self.id = id 

    --1.招募所有类型战员所需希望消耗-x
    --2.初始希望+x，玩法币+y
    self.type = data.type 
    self.args = data.args 
    --解锁条件
    self.lockFactor = data.lock_factor
    --描述语言包
    self.des = data.des

    --名字
    self.name = data.name
    --策略描述
    self.tacticsDes = data.tactics_des


    --图标
    self.icon = data.icon
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
