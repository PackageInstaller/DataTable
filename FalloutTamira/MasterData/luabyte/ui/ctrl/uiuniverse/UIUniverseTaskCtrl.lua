-- baoruichang
-- 预制体 UIUniverseTaskList
local UIUniverseTaskCtrl = BaseClass("UIUniverseTaskCtrl", BaseUICtrl)
local M = UIUniverseTaskCtrl
local UIUniverseTaskItemCtrl = require("UI.Ctrl.UIUniverse.UIUniverseTaskItemCtrl")
local UIUniverseTaskItemView = require("UI.View.UIUniverse.UIUniverseTaskItemView")
local EActivityState = EnumConst.EActivityState
local tInsert = table.insert
local tSort = table.sort

function M:Init()
    self._view.btnBack:onClick(Bind(self, self.Close))
    self._view.baseTab:Init(0, Bind(self, self._OnClickTab))
    self.gridTask = self._view.gridTask
    self.gridTask:Init(UIUniverseTaskItemCtrl, UIUniverseTaskItemView)
    self.gridTask:SetCreateItemCallback(Bind(self, self._OnCreateItemCallBack))
    self._view.btnGetAll:onClick(Bind(self, self._OnClickGetAll))
end

-- 进入UI，可传参数
function M:OnEnter()
    self._view.baseTab:TabSelect(0)
end

function M:_OnClickTab(idx)
    self.idx = idx
    if self.idx == 0 then -- 任务
        self.taskData = self:GetContext():GetTaskData()
        tSort(self.taskData, self.SortData)
        self.gridTask:SetDataList(self.taskData)
    elseif self.idx == 1 then -- 成就
        self.gridTask:SetDataList({})
    end
    self:_InitGetAllState()
end

function M:_OnCreateItemCallBack(uiDanceTaskItemCtrl)
    uiDanceTaskItemCtrl:SetOnClick(Bind(self, self._OnRewardClick))
end

--- id: activityCopyTaskId
function M:_OnRewardClick(id)
    local activityId = self:GetContext():GetActivityId()
    ActivityDataMgr:GetInstance():SendCommonReward(activityId, {id}, Bind(self, self._OnRewardCallBack))
end

function M:_OnRewardCallBack(awardData)
    GameHelper.ShowGetItems(awardData)
    self:GetContext():GetNewTaskData()
    IRedPointMgr:ForceCheck(RedPointConst.ActivityCopyTaskRedPointChecker)
end

function M:RefTaskList()
    self:_OnClickTab(self.idx or 0)
end

function M.SortData(data1, data2)
    if data1.sortIndex ~= data2.sortIndex then
        return data1.sortIndex > data2.sortIndex
    end
    return data1.activityCopyTask.id < data2.activityCopyTask.id
end

-- 一键领取
function M:_OnClickGetAll()
    local ids = {}
    for k, data in pairs(self.taskData) do
        if data.state == EActivityState.Finished then
            tInsert(ids, data.activityCopyTask.id)
        end
    end
    local activityId = self:GetContext():GetActivityId()
    ActivityDataMgr:GetInstance():SendCommonReward(activityId, ids, Bind(self, self._OnRewardCallBack))
end

function M:_InitGetAllState()
    for k, data in pairs(self.taskData) do
        if data.state == EActivityState.Finished then
            self._view.stateGetAll:SetState(1)
            return
        end
    end
    self._view.stateGetAll:SetState(2)
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UIUniverseTaskCtrl

--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = /O
--                        ____/`---'\____
--                      .   ' \\| |// `.
--                       / \\||| : |||// \
--                     / _||||| -:- |||||- \
--                       | | \\\ - --/ | |
--                     | \_| ''\---/'' | |
--                      \ .-\__ `-` ___/-. /
--                   ___`. .' /--.--\ `. . __
--                ."" '< `.___\_<|>_/___.' >'"".
--               | | : `- \`.;`\ _ /`;.`/ - ` : | |
--                 \ \ `-. \_ __\ /__ _/ .-` / /
--         ======`-.____`-.___\_____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员
