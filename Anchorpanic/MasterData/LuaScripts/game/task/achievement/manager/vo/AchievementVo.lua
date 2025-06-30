module("task.AchievementVo", Class.impl())

function parseData(self, cusMsg)
    -- 成就id
    self.id = cusMsg.id
    -- 阶段
    self.step = cusMsg.stage
    -- 当前值
    self.count = cusMsg.count

    -- 任务状态，1:未完成，0:已完成未领奖
    self.m_state = cusMsg.state

    -- 完成时间
    self.finishTimeDic = {}

    for k,v in pairs(cusMsg.finish_info) do
        self.finishTimeDic[v.stage] = v.time
    end

    self.childsList = {}
    for i = 1,self.step - 1 do
        local vo = task.AchievementVo.new()
        vo:setChilds(self,i)
        table.insert(self.childsList,vo)
    end
end

function getFinishTime(self)
    return self.finishTimeDic[self.step] or 0
end

function setState(self, recState)
    if(recState == task.AwardRecState.UN_REC)then
        self.m_state = 1
    elseif(recState == task.AwardRecState.CAN_REC)then
        self.m_state = 0
    elseif(recState == task.AwardRecState.HAS_REC)then
        self.m_state = 2
    end
end

function getState(self)
    if (self.isChild)then
        return task.AwardRecState.HAS_REC
    elseif(self.m_state == 1)then
        return task.AwardRecState.UN_REC
    elseif(self.m_state == 0)then
        return task.AwardRecState.CAN_REC
    elseif(self.m_state == 2)then
        return task.AwardRecState.HAS_REC
    end
end

function setChilds(self,data,step)
    self.id = data.id
    self.step = step
    self.isChild = true
    self.finishTimeDic = data.finishTimeDic
end

function getChilds(self)
    return self.childsList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
