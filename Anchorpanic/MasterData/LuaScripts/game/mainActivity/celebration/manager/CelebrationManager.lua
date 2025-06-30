
module("Celebration.CelebrationManager", Class.impl(Manager))

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
    self.mSSROptionalState = 0--"周年开通月卡赠礼 状态 0-未解锁 1-已解锁未领取 2-已领取"
    self.mAccRechargeNum=0--"周年慶纍計充值費用"
    self.mCelebrationTaskDic = nil
    self.mCelebrationRechargeDic = nil
    self.mCelebrationCurDay = 0--当前天数进度
    self.mCelebrationTargetState = 0--不可领取
    self.mCelebrationTaskVoMsgDic={}
    self.mCelebrationTaskIdMsgList={}
    self.mAccRechargeRecivedMsgList={}
    self.mCelebratoinTargetTaskInfo = nil
end

-- 初始化周年庆任务配置表
function parseCelebrationTaskConfig(self)
    self.mCelebrationTaskDic = {}
    local baseData = RefMgr:getData("celebration_task_data")
    for taskId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(Celebration.CelebrationTaskVo)
        vo:parseData(taskId, data)
        if not self.mCelebrationTaskDic[vo.day] then
            self.mCelebrationTaskDic[vo.day] = {}
        end
        table.insert(self.mCelebrationTaskDic[vo.day],vo)
    end
end

-- 初始化周年庆任务配置表
function parseCelebrationRechargeConfig(self)
    self.mCelebrationRechargeDic = {}
    local baseData = RefMgr:getData("celebration_recharge_data")
    for taskId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(Celebration.CelebrationRechargeVo)
        vo:parseData(taskId, data)
        self.mCelebrationRechargeDic[vo.index]=vo
    end
end
----------------------更新庆典任务领取id---------------------------------------
function updateCelebrationTaskReciveMsg(self,msg)
    for _, id in ipairs(msg.task_id_list) do
        self.mCelebrationTaskVoMsgDic[id].state = Celebration.CelebrationConst.CelebrationTaskState.Recived
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_TASK_LIST)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function updateCelebrationTaskInfoMsg(self,msg)
    self.mAccRechargeNum=tonumber(string.format("%.2f", msg.total_count/100))
    for _, id in ipairs(msg.reward_list) do
        if not table.indexof(self.mAccRechargeRecivedMsgList,id) then
            table.insert(self.mAccRechargeRecivedMsgList,id)
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_ACC_RECHARGE_LIST)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function checkRechargeIsRecivedAward(self,id)
    return table.indexof(self.mAccRechargeRecivedMsgList,id)
end

function parseCelebrationTaskPanelMsg(self,msg)
    self.mCelebrationCurDay = msg.day
    self.mCelebrationTargetState = msg.target_gain_state
    for _, msgVo in ipairs(msg.task_list) do
        self.mCelebrationTaskVoMsgDic[msgVo.id]=msgVo
        table.insert(self.mCelebrationTaskIdMsgList,msgVo.id)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_TASK_LIST)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function getCurUnLockDay(self)
    return self.mCelebrationCurDay
end

function getTaskOverNum(self)
    local num =0 
    for _, vo in pairs(self.mCelebrationTaskVoMsgDic) do
        if vo.state==Celebration.CelebrationConst.CelebrationTaskState.Recived then
            num=num+1
        end
    end
    return num
end

function getRechargeList(self)
    if not self.mCelebrationRechargeDic then
        self:parseCelebrationRechargeConfig()
    end
    local list={}
    for k, vo in pairs(self.mCelebrationRechargeDic) do
        table.insert(list,vo)
    end
    return list
end

function getIsRechargeRed(self)
    for i, rechargeVo in ipairs(self:getRechargeList()) do
        if rechargeVo:getState()==Celebration.CelebrationConst.CelebrationTaskState.Recive then
            return true
        end
    end
    return false
end

function getRechargeNum(self)
    return self.mAccRechargeNum or 0
end

function updateAccRechargeReciveMsg(self,msg)
    if msg.result then
        gs.Message.Show(_TT(41722))
        if not table.indexof(self.mAccRechargeRecivedMsgList,msg.recharge_id) then
            table.insert(self.mAccRechargeRecivedMsgList,msg.recharge_id)
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_ACC_RECHARGE_LIST)
        GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
    else
        gs.Message.Show(_TT(27600))
    end
end

function parseCelebrationTargetTaskInfoMsg(self,msg)
    self.mCelebrationTargetState = msg.result
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_TARGET_TASK_STATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function parseCelebrationTaskInfoMsg(self,msg)
    if msg.task_info then
        self.mCelebrationTaskVoMsgDic[msg.task_info.id]=msg.task_info 
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

function getCanReciveListByDay(self,day)
    local list={}
    for i, taskVo in ipairs(self:getCelebrationTaskListByDay(day)) do
        if taskVo:getState()==Celebration.CelebrationConst.CelebrationTaskState.Recive then
            table.insert(list,taskVo.id)
        end
    end
    return list
end

function getIsSignRed(self)
    
end

function getIsRedByDay(self,day)
    local list=self:getCanReciveListByDay(day)
    return #list>0
end

function getTaskIsHasRed(self)
    if not self.mCelebrationTaskDic then
        self:parseCelebrationTaskConfig()
    end
    for day, _ in pairs(self.mCelebrationTaskDic) do
        if self:getIsRedByDay(day) then
            return true
        end
    end
    local taskNeedNum=sysParam.SysParamManager:getValue(SysParamType.CELEBRATION_TASK_AWARD_NEED_COUNT)
    local curTaskOverNum=self:getTaskOverNum()<=taskNeedNum and self:getTaskOverNum() or taskNeedNum
    if (curTaskOverNum>=taskNeedNum and self:getTargetState()==Celebration.CelebrationConst.AwardState.Nomal)  then
        return true
    end
    return false
end

function getTargetState(self)
    return self.mCelebrationTargetState
end

function getCelebrationTaskListByDay(self,day)
    if not self.mCelebrationTaskDic then
        self:parseCelebrationTaskConfig()
    end
    local list={}
    for _, taskVo in ipairs(self.mCelebrationTaskDic[day]) do
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
    if not self.mCelebrationTaskDic then
        self:parseCelebrationTaskConfig()
    end
    return self.mCelebrationTaskDic[day]
end

function updateCelebrationRed(self)
    for _, pageVo in pairs(Celebration.CelebrationConst:getTabList()) do
        local isFlag=false
        if (pageVo.isBubble and activity.ActivityManager:getActivityVoById(pageVo.activityId) and activity.ActivityManager:getActivityVoById(pageVo.activityId):isOpen()) then
            isFlag=true
        end
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_CELEBRATION, isFlag ,pageVo.funcId)
    end
end

function getSSROptionalIsRed(self)
    return self.mSSROptionalState==Celebration.CelebrationConst.AwardState.Recive
end

function updateSSROptionalState(self,msg)
    if self.mSSROptionalState~=msg.state then
        self.mSSROptionalState=msg.state
        GameDispatcher:dispatchEvent(EventName.UPDATE_SSROPTIONAL_INFO)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end
function getSSROptionalState(self)
    return self.mSSROptionalState
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]
