local ScoreItem = require("UI.Ctrl.Activity.DailyGoals.DailyGoalsScoreItemCtrl")
local DailyGoalsScoreCtrl = BaseClass("DailyGoalsScoreCtrl")
local M = DailyGoalsScoreCtrl

function M:ScoreCompleteIds()
    local ids = {}
    for i, v in ipairs(self.m_list) do
        if v:Complete() then
            ids[#ids + 1] = v:SubActivityId()
        end
    end
    return ids
end

function M:Refresh(data)
    self.m_activityId = data:ActivityId()
    self.m_awardsData = data:RoleActivity()[1]
    self.m_score = self.m_awardsData.Value0
    self._view.score:SetText(tostring(self.m_score))
    self:_RefreshItem()
end

function M:_RefreshItem()
    local isReward = false
    local slider = 1
    local idx = 0
    for i, v in ipairs(self.m_cfgs) do
        idx = i % 32
        isReward = (self.m_awardsData.Value1 & 1 << idx) > 0

        if self.m_score < v.score then
            local oldScore = i > 1 and self.m_cfgs[i - 1].score or 0
            local subScore = self.m_score - oldScore
            local curSubScore = v.score - oldScore
            slider = subScore / curSubScore
        end

        self.m_list[i]:Update(slider, v, self.m_activityId, isReward, #self.m_cfgs)
    end
end

function M:__init(view)
    self._view = view
    self.m_cfgs = ConfigHelper.GetCfgs("activitySevenScore")
    self.m_maxScore = self.m_cfgs[#self.m_cfgs].score

    self:_InitList()
end

function M:_InitList()
    self.m_list = {}
    self._view.item:SetActive(false)
    for _, v in pairs(self.m_cfgs) do
        local obj = self._view.item:Instantiate()
        local data = ScoreItem.New(obj, (#self.m_list + 1))
        self.m_list[#self.m_list + 1] = data
    end
end

function M:OnDispose()
    for _, v in pairs(self.m_list) do
        v:OnDispose()
    end

    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
    self.m_list = nil
end

return DailyGoalsScoreCtrl
