module("fashionPermitTwo.FashionPermitTwoTaskVo", Class.impl())

function parseTaskVo(self,id,data,msgData)
    self.id = id 

    self.taskType = data.task_type
    self.times = data.time
    self.des = data.describe
    self.title = data.title
    self.exp = data.exp_reward
    self.uiCode = data.ui_code

    self.msgData = msgData
end

function updateMsgData(self,msgData)
    self.msgData = msgData
end

return _M