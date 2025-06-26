module("rogueLike.RogueLikeTaskTabViewWeek",Class.impl(rogueLike.RogueLikeTaskTabView))

taskFilterType = rogueLike.TaskType.Week

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTaskInfo = self:getChildGO("mTaskInfo")
    self.mTaskScroller = self:getChildGO("mTaskScroller"):GetComponent(ty.LyScroller)
    self.mTaskScroller:SetItemRender(rogueLike.RogueLikeTaskItem)

    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtTime.gameObject:SetActive(true)

    self.mGetAllBtn = self:getChildGO("mGetAllBtn")
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_TASK_PANEL_TASK, self.updateTask, self)
    --GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_TASK_PANEL_SCORE, self.updateScore, self)
    self:updateTaskView(true)
    self:updateEndTime()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self, self.__updateTime)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_TASK_PANEL_TASK, self.updateTask, self)
    --GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_TASK_PANEL_SCORE, self.updateScore, self)
    
end

function updateEndTime(self)
    LoopManager:removeTimer(self, self.__updateTime)

    --self.mEndTime = rogueLike.RogueLikeManager:getResRogueLikeTime()

    --if self.mEndTime > 0 then
    LoopManager:addTimer(0, 0, self, self.__updateTime)
    --end
end

function __updateTime(self)

    -- local wday = tonumber(os.date("%w")) == 0 and 7 or tonumber(os.date("%w"))
    -- wday = (wday == 1 and tonumber(os.date("%H")) < 5) and 8 or wday
    -- local endTime = ((8 - wday) * 24 * 3600) - os.date("%H") * 3600 - os.date("%M") * 60 - os.date("%S") + 5 * 3600
    -- self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_1(endTime)

    local currentTime = GameManager:getClientTime()
    local reamainTime = GameManager:getWeekResetTime() - currentTime
    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_1(reamainTime)
    
    -- local currentTime = GameManager:getClientTime()
    -- local reamainTime = self.mEndTime - currentTime
    -- if (reamainTime <= 0) then
    --     self:onClickClose()
    --     return
    -- end
    -- self.mTxtTime.text = _TT(44505, TimeUtil.getFormatTimeBySeconds_1(reamainTime))
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
