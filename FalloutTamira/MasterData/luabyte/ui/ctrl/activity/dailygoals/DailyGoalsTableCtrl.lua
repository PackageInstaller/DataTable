--七日签到左侧页签
local DailyGoalsTaskListCtrl = BaseClass("DailyGoalsTaskListCtrl")
local M = DailyGoalsTaskListCtrl


function M:CompleteIds()
    local allDay = self.m_curDay > self.m_maxDay and self.m_maxDay or self.m_curDay

    local taskIds = {}
    local dayIds = {}
    for i=1, allDay do
        local cfg = self.m_cfg[i]
        -- 循环每一天任务
        for i,v in ipairs(cfg) do
            local d = self:_FindAll(v)
            -- 拿到roledata里面的有的数据 判断是否可领取
            if d.State == 1 then
                -- 判断是否是特殊任务 
                if v.target == 1 then
                    dayIds[#dayIds + 1] = v.id
                else
                    taskIds[#taskIds + 1] = v.id
                end
            end
        end
    end
    
    return taskIds, dayIds
end


function M:RefreshDayandTaskList()
    local cfg = self.m_cfg[self.m_curTaskDay]
    local taskCfg = MapUtil.FilterValues(cfg, function (v) return v.target ~= 1 end)
    local daycfg = MapUtil.Find(cfg, function (v) return v.target == 1 end)
    local dayData = MapUtil.Find(self.m_roleData, function (v) return v.SubActivityId == daycfg.id end)
    local isUnLock = self.m_curTaskDay <= self.m_curDay

    self.m_taskView:Refresh(taskCfg, self.m_roleData, isUnLock)
    self.m_dayView:Refresh(daycfg, self.m_dayComplete[self.m_curTaskDay], dayData)
end


function M:Refresh(data, cfg, taskView, dayView)
    self.m_taskView = taskView
    self.m_dayView = dayView
    self.m_cfg = cfg
    self.m_maxDay = #cfg
    self.m_data = data
    self:_RefreshCurDay()
    self:Update(data)
end


function M:Update(data)
    self.m_roleData = data:RoleActivity()
    self.m_dayComplete = self:_RefreshDayReward()

    self:_RefreshCurTab()
    self:_RefreshTabState()
end


function M:_RefreshDayReward()
    local completes = {}

    for i,v in ipairs(self.m_cfg) do
        completes[i] = {}
        completes[i].curNum = 0

        for k,t in ipairs(v) do
            if t.target == 1 then
                completes[i].allNum = t.limitValue1
            end
           
            local d = self:_Find(t)
            if d.State == 2 then
                completes[i].curNum = completes[i].curNum + 1
            end
        end
    end

    return completes
end


function M:_RefreshCurDay()
    local startTime, endTime = self.m_data:StartTime(), self.m_data:EndTime()
    self.m_allDay = ActivityHelper.CountDayByStartTime(startTime, endTime) 
    self.m_curDay = ActivityHelper.CountDayByStartTime(startTime)
    self.m_curTaskDay = self.m_curDay > self.m_maxDay and self.m_maxDay or self.m_curDay
end


function M:_RefreshCurTab()
    local strArray = { "一", "二", "三", "四", "五", "六", "七", "八", "九" }
    local labels = {}

    for i=1, self.m_maxDay do
        labels[#labels + 1] = strArray[i]
    end

    self._view.tab:InitItems(0, labels, Bind(self, self._OnChangeDayType));
    self._view.tab:TabSelect(self.m_curTaskDay - 1)
    self._view.tab:SetOpenLockSelect(true)
end


function M:_RefreshTabState()
    for i=1, self.m_maxDay do
        local index = i - 1
        local item = self._view.tab:GetTabItem(index)

        if item then 
            item:SetRedPointParam(0, i)
            item:RedPointCheck()
            item:SetUnlock(i <= self.m_curDay)
            item:SetComplete(false)
            item.Select = i == self.m_curTaskDay

            -- 判断是否当前天数是否全部完成
            if i <= self.m_curDay then
                local complete = self.m_dayComplete[i]
                item:SetComplete(complete.curNum >= complete.allNum)
            end
        end
    end
end


function M:_Find(data)
    local d = MapUtil.Find(self.m_roleData or {}, function (v) return (v.SubActivityId == data.id and data.target ~= 1) end)
    return d or {State = 0}
end


function M:_FindAll(data)
    local d = MapUtil.Find(self.m_roleData or {}, function (v) return (v.SubActivityId == data.id) end)
    return d or {State = 0}
end


function M:__init(view)
    self._view = view
end


function M:_OnChangeDayType(index)
    self.m_curTaskDay = index + 1
    self:RefreshDayandTaskList()
end


function M:OnDispose()
    if self._view then 
        self._view:OnDispose() 
    end

    self._view = nil
    self.m_RefreshTaskCallBack = nil
    self.m_RefreshDayCallBack = nil
end





return DailyGoalsTaskListCtrl