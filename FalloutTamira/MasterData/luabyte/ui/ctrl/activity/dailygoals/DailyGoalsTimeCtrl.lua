local DailyGoalsTimeCtrl = BaseClass("DailyGoalsTimeCtrl")
local M = DailyGoalsTimeCtrl



function M:Refresh(data)
    local str = ConfigHelper.GetLocalString(4151) --"倒计时：<color=#FF8C54>%d</color>天<color=#FF8C54>%d</color>小时"
    local curTime = TimeUtil.GetNowTimeStamp()
    local endTime = data:EndTime()
    local subTime = endTime - curTime
    local timeData = ActivityHelper.SplitSecond(subTime)
    local tiemtext = string.format(str, timeData.day, timeData.hour)
    self._view.timeText:SetText(tiemtext)
end

function M:__init(view)
    self._view = view
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return DailyGoalsTimeCtrl
