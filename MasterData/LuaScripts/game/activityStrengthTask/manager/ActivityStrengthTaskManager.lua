
module("game.activityStrengthTask.manager.ActivityStrengthTaskManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.mTaskDic = nil
    self.mCelebrationCurDay = 0--当前天数进度
    self.mCelebrationTargetState = 0--不可领取
    self.mCelebrationTaskVoMsgDic={}
    self.mCelebrationTaskIdMsgList={}
    self.mCelebratoinTargetTaskInfo = nil
end

-- 初始化任务配置表
function parseCelebrationTaskConfig(self)
    self.mTaskDic = {}
    local baseData = RefMgr:getData("strength_task_data")
    for taskId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(activityStrengthTask.ActivityStrengthTaskVo)
        vo:parseData(taskId, data)
        if not self.mTaskDic[vo.day] then
            self.mTaskDic[vo.day] = {}
        end
        table.insert(self.mTaskDic[vo.day],vo)
    end
end

----------------------更新庆典任务领取id---------------------------------------
function updateCelebrationTaskReciveMsg(self,msg)
    for _, id in ipairs(msg.task_id_list) do
        self.mCelebrationTaskVoMsgDic[id].state = activityStrengthTask.ActivityStrengthTaskConst.CelebrationTaskState.Recived
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_STRENGTH_TASK_TASK_LIST)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function parseCelebrationTaskPanelMsg(self,msg)
    self.mCelebrationCurDay = msg.day
    self.mCelebrationTargetState = msg.target_gain_state
    for _, msgVo in ipairs(msg.task_list) do
        self.mCelebrationTaskVoMsgDic[msgVo.id]=msgVo
        table.insert(self.mCelebrationTaskIdMsgList,msgVo.id)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_STRENGTH_TASK_TASK_LIST)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function getCurUnLockDay(self)
    return self.mCelebrationCurDay
end

function getTaskOverNum(self)
    local num =0 
    for _, vo in pairs(self.mCelebrationTaskVoMsgDic) do
        if vo.state==activityStrengthTask.ActivityStrengthTaskConst.CelebrationTaskState.Recived then
            num=num+1
        end
    end
    return num
end

function parseCelebrationTargetTaskInfoMsg(self,msg)
    self.mCelebrationTargetState = msg.result
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_STRENGTH_TASK_TARGET_TASK_STATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function parseCelebrationTaskInfoMsg(self,msg)
    if msg.task_info then
        self.mCelebrationTaskVoMsgDic[msg.task_info.id]=msg.task_info 
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_STRENGTH_TASK_TASK_LIST)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function getCanReciveListByDay(self,day)
    local list={}
    for i, taskVo in ipairs(self:getCelebrationTaskListByDay(day)) do
        if taskVo:getState()==activityStrengthTask.ActivityStrengthTaskConst.CelebrationTaskState.Recive then
            table.insert(list,taskVo.id)
        end
    end
    return list
end

function getIsRedByDay(self,day)
    local list=self:getCanReciveListByDay(day)
    return #list>0
end

function getTaskIsHasRed(self)
    if not self.mTaskDic then
        self:parseCelebrationTaskConfig()
    end
    for day, _ in pairs(self.mTaskDic) do
        if self:getIsRedByDay(day) then
            return true
        end
    end
    local taskNeedNum=sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_STRENGTH_TASK_AWARD_NEED_COUNT)
    local curTaskOverNum=self:getTaskOverNum()<=taskNeedNum and self:getTaskOverNum() or taskNeedNum
    if (curTaskOverNum>=taskNeedNum and self:getTargetState()==activityStrengthTask.ActivityStrengthTaskConst.AwardState.Nomal)  then
        return true
    end
    return false
end

function getTargetState(self)
    return self.mCelebrationTargetState
end

function getCelebrationTaskListByDay(self,day)
    if not self.mTaskDic then
        self:parseCelebrationTaskConfig()
    end
    local list={}
    for _, taskVo in ipairs(self.mTaskDic[day]) do
        if table.indexof(self.mCelebrationTaskIdMsgList,taskVo.id) then
            local msgVo=self.mCelebrationTaskVoMsgDic[taskVo.id]
            taskVo:setMsgVo(msgVo)
            table.insert(list,taskVo) 
        end
    end
    table.sort(list,function (vo1,vo2)
        if vo1:getState()==vo2:getState() then
            return vo1.id>vo2.id
        end
        return vo1:getState()<vo2:getState()
    end)
    return list
end

function getCelebrationTaskDic(self,day)
    if not self.mTaskDic then
        self:parseCelebrationTaskConfig()
    end
    return self.mTaskDic[day]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
