module("cycle.CycleRecruitVo", Class.impl())

function parseRecruit(self,id,data)
    self.id = id
    
    self.param = data.param
    self.name = data.name 
    self.des = data.des
    self.icon = data.icon
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
