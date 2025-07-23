--[[ 
-----------------------------------------------------
@filename       : EliminateTaskPanel
@Description    : 消消乐任务界面
@date           : 2020-12-24 16:23:40
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('eliminate.EliminateTaskPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("eliminate/EliminateTaskPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(700, 600)
    self:setTxtTitle(_TT(101009)) --"消消乐"
end

-- 取父容器
function getParentTrans(self)
    return super.getParentTrans(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mBtnRecAll = self:getChildGO("mBtnRecAll")
    self.mGroupRecAll = self:getChildGO("GroupRecAll")
    self.mScrollerTaskListGo = self:getChildGO("ScrollerTask")
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtRecAllTip = self:getChildGO("mTxtRecAllTip"):GetComponent(ty.Text)
    self.mRectScrollerTaskList = self.mScrollerTaskListGo:GetComponent(ty.RectTransform)
    self.mScrollerTaskList = self.mScrollerTaskListGo:GetComponent(ty.LyScroller)
    self.mScrollerTaskList:SetItemRender(eliminate.EliminateTaskItem)
end

function initViewText(self)
    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Eliminate)
    local overTime = mainActivityVo:getOverTimeDt()
    local t = os.date('*t', overTime)
    self.mTxtTime.text = string.format(_TT(101017), t.month, t.day, t.hour, t.min) -- "活动截止时间：%02d/%02d %02d:%02d"
    self.mTxtTip.text = _TT(101016) -- "消除记录"
    self.mTxtRecAllTip.text = _TT(101018) -- "有可领取的任务奖励"
    self:setBtnLabel(self.mBtnRecAll, 1176, "一键领取")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecAll, self.onClickRecAllHandler)
end

function close(self)
    super.close(self)
end

function onClickClose(self)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_ELIMINATE_TASK, self.onUpdateTaskHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ELIMINATE_TASK_LIST, self.onUpdateTaskHandler, self)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ELIMINATE_TASK, self.onUpdateTaskHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ELIMINATE_TASK_LIST, self.onUpdateTaskHandler, self)
end

function onClickRecAllHandler(self)
    local taskConfigList = {}
    local list = eliminate.EliminateManager:getTaskConfigList()
    for i = 1, #list do
        table.insert(taskConfigList, list[i])
    end
    -- table.sort(taskConfigList, self.__sortTaskList)

    local canRecTaskConfigList = {}
    for i = 1, #taskConfigList do
        local taskVo = eliminate.EliminateManager:getTaskVoById(taskConfigList[i].taskId)
        if(taskVo)then
            if(taskVo:getState() == task.AwardRecState.CAN_REC)then
                table.insert(canRecTaskConfigList, taskConfigList[i])
            end
        end
    end
    if(#canRecTaskConfigList > 0)then
        GameDispatcher:dispatchEvent(EventName.REQ_ELIMINATE_TASK_AWARD, canRecTaskConfigList)
    end
end

-- function __sortTaskList(taskConfigVo_1, taskConfigVo_2)
--     local taskVo_1 = eliminate.EliminateManager:getTaskVoById(taskConfigVo_1.taskId)
--     local taskVo_2 = eliminate.EliminateManager:getTaskVoById(taskConfigVo_2.taskId)
--     if(taskVo_1 and taskVo_2)then
--         if (taskVo_1:getState() > taskVo_2:getState()) then
--             return false
--         elseif (taskVo_1:getState() < taskVo_2:getState()) then
--             return true
--         else
--             if (taskVo_1.id < taskVo_2.id) then
--                 return true
--             elseif (taskVo_1.id > taskVo_2.id) then
--                 return false
--             end
--         end
--     end
--     return false
-- end

function onUpdateTaskHandler(self)
    self:updateView(false)
end

function updateView(self, cusIsInit)
    local taskConfigList = eliminate.EliminateManager:getTaskConfigList()
    table.sort(taskConfigList,function (taskConfigVo_1,taskConfigVo_2)
        local vo1=eliminate.EliminateManager:getTaskVoById(taskConfigVo_1.taskId)
        local vo2=eliminate.EliminateManager:getTaskVoById(taskConfigVo_2.taskId)
        if vo1 and vo2 then
            if vo1:getState()== vo2:getState() then
                return taskConfigVo_1.taskId < taskConfigVo_2.taskId 
            end
            return vo1:getState()< vo2:getState()
        end
        return taskConfigVo_1.taskId < taskConfigVo_2.taskId 
    end)

    if (cusIsInit == nil or cusIsInit == true) then
        self.mScrollerTaskList.DataProvider = taskConfigList
    else
        self.mScrollerTaskList:ReplaceAllDataProvider(taskConfigList)
    end
    for i = 1, self.mScrollerTaskList:GetItemList().Count do
        taskConfigList[i].tweenId = 2 + (i - 1) * 4
    end
    if(eliminate.EliminateManager:hasTaskAward())then
        self.mGroupRecAll:SetActive(true)
        gs.TransQuick:SizeDelta02(self.mRectScrollerTaskList, 460)
    else
        self.mGroupRecAll:SetActive(false)
        gs.TransQuick:SizeDelta02(self.mRectScrollerTaskList, 558)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
