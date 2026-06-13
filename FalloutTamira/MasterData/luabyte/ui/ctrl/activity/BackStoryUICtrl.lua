local M = BaseClass("BackStoryUICtrl", BaseUICtrl)

function M:Init()
    local itemCtrl = require("UI.Ctrl.Activity.BackStoryItemCtrl")
    local itemView = require("UI.View.Activity.BackStoryItemView")
    self._view.list_task:Init(itemCtrl, itemView)

    local taskHandler = Bind(self, self.OnTaskUpdate)
    self.m_onTaskUpdate = EventMgr:AddListener(UIMessageNames.ACTIVITY_UPDATE, taskHandler)
end

function M:OnEnter()
    local activityId = 0
    self.view.txt_time:SetActive(false)
    for _, data in ipairs(ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.BACKSTORY) or {}) do
        if data:IsOpen() then
            activityId = data:ActivityId()
            local startStr = GameHelper.TimeStampToString(data:StartTime(), "yyyy.MM.dd")
            local endStr = GameHelper.TimeStampToString(data:EndTime(), "yyyy.MM.dd")
            self.view.txt_time:SetText(string.format("%s - %s", startStr, endStr))
            break
        end
    end

    if activityId == 0 then
        Logger.LogError("activity is error ! id = " .. activityId)
        return
    end



    ActivityDataMgr:GetInstance():GetActivityByIdAsyn(activityId, Bind(self, self.OnAsynActCallBack))
end

function M:OnAsynActCallBack(data)
    self.view.txt_title:SetText(data:ActivityCfg().name)
    local list = {}
    local roleActs = {}
    for _, v in pairs(data:RoleActivity() or {}) do
        roleActs[v.SubActivityId] = v
    end
    local id = data:ActivityId()
    local backStorys = ConfigHelper.GetCfgsByLua("backStory", { activityId = id }) or {}
    table.sort(backStorys, function(a, b) -- 开放顺序：表id小到大
        return a.id < b.id
    end)
    local curDay = ActivityHelper.CountDayByStartTime(data:StartTime())
    for i, v in ipairs(backStorys) do
        local _roleAct = roleActs[v.backTask] or {
            ActivityId    = id,
            SubActivityId = v.backTask,
            Value0        = 0,
            Value1        = 0,
            Value2        = 0,
            State         = 0
        }
        table.insert(list, {
            BackStory = v,
            Task = ConfigHelper.GetCfgByLua("activitySevenDay", v.backTask),
            RoleAct = _roleAct,
            CurDay = curDay,
            OrderId = i
        })
    end
    table.sort(list, function(a, b)
        local a_state, b_state = a.RoleAct.State, b.RoleAct.State
        if a_state == b_state then
            return a.OrderId < b.OrderId
        end
        if (a_state + b_state) >= 2 then
            return a_state < b_state
        end
        return a_state > b_state
    end)
    self._view.list_task:SetDataList(list)
end

function M:OnTaskUpdate(activityId)
    local data = ActivityDataMgr:GetInstance():GetActivityData(activityId)
    self:OnAsynActCallBack(data)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ACTIVITY_UPDATE, self.m_onTaskUpdate)
    self.m_onTaskUpdate = nil
    M.super.OnDispose(self)
end

return M
