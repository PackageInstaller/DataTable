--[[ 
-----------------------------------------------------
@filename       : ReturnedTaskVo
@Description    : 回归任务数据
@date           : 2023-11-01 14:35:46
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.returned.manager.vo.ReturnedTaskVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key
    self.type = cusData.type
    self.taskType = cusData.task_type
    self.time = cusData.time
    self.describe = cusData.describe
    self.title = cusData.title
    self.uiCode = cusData.ui_code
    self.taskReward = {}

    self.state = 1
    self.count = 0

    self:parseAwardData(cusData.task_reward)
end

function parseAwardData(self, task_reward)
    if next(task_reward) then
        for _, data in pairs(task_reward) do
            self.taskReward[#self.taskReward + 1] = { tid = data[1], num = data[2] }
        end
    end
end

-- 解析服务器数据
function parseMsg(self, cusMsg)
    self.count = cusMsg.count
    self.state = cusMsg.state --"任务状态，1:未完成，0:已完成未领奖，2：已领取奖励"
end

function getId(self)
    return self.id
end

function getState(self)
    return self.state
end

function getCount(self)
    return self.count
end

function getUiCode(self)
    return self.uiCode
end

function getTitle(self)
    return self.title
end

function getTime(self)
    return self.time
end

function getType(self)
    return self.type
end

function getTaskType(self)
    return self.taskType
end

function getDescribe(self)
    return self.describe
end



return _M