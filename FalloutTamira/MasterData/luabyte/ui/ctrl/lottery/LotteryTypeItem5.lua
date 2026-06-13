local LotteryTypeItem = BaseClass("LotteryTypeItem5", require("UI.Ctrl.Lottery.BaseLotteryItem"))
local M = LotteryTypeItem

function M:_initView()

end

function M:Refresh(drawData)
    M.super.Refresh(self, drawData)
    local cfg = self._lotteryCfg
    local needTimes = 10
    local restTimes = 10
    if drawData ~= nil then
        if self._view.numberTip ~= nil then
            self._view.numberTip:SetActive(not drawData.GuaranteeFlag or drawData.GuaranteeFlag == 0)
        end
        restTimes = needTimes - drawData.TotalTimes
    end

    if restTimes < 0 then
        restTimes = 0
    end
    if self._view.numberTip ~= nil then
        self._view.numberTip:SetActive(false) --03.15杜老师要求先把这个隐藏
    end

    if self._view.ssrCountTf ~= nil then
        self._view.ssrCountTf:SetText(tostring(restTimes))
    end

    if self._view.Time ~= nil then
        local startstr = GameHelper.TimeStampToString(cfg.startTime, "yyyy.MM.dd")
        local endstr = GameHelper.TimeStampToString(cfg.lastTime, "yyyy.MM.dd")
        self._view.Time:SetText(startstr .. "-" .. endstr)
    end

    if self._view.ssrNeedTime ~= nil then
        local num, max = self:GetSsrCountdownNumber(drawData)
        self._view.ssrNeedTime:SetText(string.format("最多<color=#FF8901>%d/%d</color>次必出SSR战员", num, max))
    end

    if self._view.drawTimes ~= nil then
        local times, max = self:GetDrawCardLimit(drawData)
        self._view.drawTimes:SetText("今日剩余精密星斯抽卡次数：<color=#FF8901>" .. times .. "/" .. max .. "</color>")
    end
end

return M
