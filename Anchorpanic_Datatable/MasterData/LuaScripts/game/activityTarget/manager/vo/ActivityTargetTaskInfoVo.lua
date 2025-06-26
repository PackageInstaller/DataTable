module("ActivityTargetTaskInfoVo",Class.impl())

function parseData(self,cusMsg)
     -- 任务id
     self.id = cusMsg.id
     -- 类型
     self.type = cusMsg.type
     -- 当前值
     self.count = cusMsg.count
     -- 任务状态，1:未完成，0:已完成未领奖，2:已领取奖励
     self.state = cusMsg.state
     -- 奖励
     self.mReward = cusMsg.task_award
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
