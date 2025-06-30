module("WelfareOptTapTapTaskVo",Class.impl())

function parseTapTapTaskData(self,id,cusData)
    self.id = id 
    self.taskType = cusData.task_type 
    self.time = cusData.time 
    self.describe = cusData.describe
    self.title = cusData.title
    self.reward = cusData.reward
    self.uiCode = cusData.ui_code
end

function setServerInfo(self,info)
    self.serverInfo = info
end

return _M