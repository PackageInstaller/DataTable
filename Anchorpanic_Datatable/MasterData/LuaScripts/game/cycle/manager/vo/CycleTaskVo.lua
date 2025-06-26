module("cycle.CycleTaskVo", Class.impl())

function parseTaskVo(self,id,data)
    self.id = id 

    self.taskType = data.task_type
    self.times = data.times
    self.des = data.des
    self.title = data.title
    self.exp = data.exp
    self.icon = data.icon
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
