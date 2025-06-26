module("ActivityTargetVo",Class.impl())

function parseActivityTargetVo(self,cusData,id)
    self.id = id
    self.taskType = cusData.task_type
    self.time = cusData.time
    self.describe = cusData.describe
    self.title = cusData.title
    self.reward = cusData.reward
    self.uiCode = cusData.ui_code
    self.day = cusData.day
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
