module("ActivityTargetScoreAwardVo", Class.impl())

function parseData(self, cusMsg)
    -- 积分奖励id
    self.id = cusMsg.id
    -- 积分值
    self.score = cusMsg.score
    -- 任务状态，1:未完成，0:已完成未领奖，2:已领取奖励
    self.m_state = cusMsg.state
    -- 奖励
    self.propsList = {}
    for i = 1, #cusMsg.task_award do
        local propsVo = props.PropsVo.new()
        propsVo:setPropsAwardMsgData(cusMsg.task_award[i])
        table.insert(self.propsList, propsVo)
    end
end

function setState(self, recState)
    if (recState == task.AwardRecState.UN_REC) then
        self.m_state = 1
    elseif (recState == task.AwardRecState.CAN_REC) then
        self.m_state = 0
    elseif (recState == task.AwardRecState.HAS_REC) then
        self.m_state = 2
    end
end

function getState(self)
    if (self.m_state == 1) then
        return task.AwardRecState.UN_REC
    elseif (self.m_state == 0) then
        return task.AwardRecState.CAN_REC
    elseif (self.m_state == 2) then
        return task.AwardRecState.HAS_REC
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
