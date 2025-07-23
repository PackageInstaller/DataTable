module("covenant.CovenantTaskVo", Class.impl())

function parseData(self,id,cusData)
    self.id = id
    self.taskType = cusData.task_type
    self.time = cusData.time
    self.describe = cusData.describe
    self.title = cusData.title
    self.reward = cusData.task_reward
    self.uiCode = cusData.ui_code
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
