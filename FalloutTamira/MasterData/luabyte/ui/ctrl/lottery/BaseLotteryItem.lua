local M = BaseClass("BaseLotteryItem")

function M:__init(type, view, cfg)
    self._view = view
    self._lotteryCfg = cfg
    self._cardPoolCfg = ConfigHelper.GetCfg("cardPool", cfg.jackpot)
end

--激活
function M:SetActive(v)
    if self._view then
        self._view:SetActive(v)
    end
    self._isActive = v
end

function M:Action()

end

function M:GetCfg()
    return self._lotteryCfg
end

function M:DrawData()
    return self._drawData
end

function M:Refresh(drawData)
    self._drawData = drawData
end

function M:GetSign()
    return self._lotteryCfg.sign
end

function M:GetPage()
    return self._lotteryCfg.page
end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:GetSsrCountdownNumber(drawData)
    local max = #self._cardPoolCfg.ssrProbability
    if drawData ~= nil then
        return drawData.SsrCountdown, max
    else
        local context = UIContextMgr:GetInstance():GetContext("Lottery")
        local drawdata = context._lottoDataGroup:GetFirstDataBySign(self:GetSign())
        if drawdata ~= nil then
            return drawdata.SsrCountdown, max
        end
    end

    -- local systemID = 0
    -- if self:GetSign() == 3 then
    --     systemID = 259
    -- else
    --     systemID = 257
    -- end
    -- local defaultNeedNumberSys = ConfigHelper.GetSystemParams(systemID)[0]
    return max, max --- defaultNeedNumberSys
end

function M:GetDrawCardLimit(drawData)
    local cfg = self._lotteryCfg
    local value = 0
    if drawData and TimeUtil.IsToday(drawData.ConditionTime, 5) then
        value = drawData.ConditionValue
    end
    local remain = math.max(0, cfg.valueCondition - value) / cfg.cost
    local max = cfg.valueCondition / cfg.cost
    return math.floor(remain), math.floor(max)
end

return M
