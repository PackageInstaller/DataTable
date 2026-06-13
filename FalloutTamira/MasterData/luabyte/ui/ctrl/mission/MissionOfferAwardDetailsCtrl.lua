local M = BaseClass("MissionOfferAwardDetailsCtrl", BaseUICtrl)

function M:Init()
    self.m_awardHandler = Bind(self, self.OnClickAward)
    self._view.btn_back:onClick(Bind(self, self.Close))
    self._view.btn_award:onClick(self.m_awardHandler)

    local ctrl = require("UI.Ctrl.Mission.MissionOfferAwardDetailsItemCtrl")
    local view = require("UI.View.Mission.MissionOfferAwardDetailsItemView")
    self._view.looplist:Init(ctrl, view)
    self._view.looplist:SetCreateItemCallback(Bind(self, self.OnCreatItem))
end

function M:OnEnter(activityId)
    self.m_activityId = activityId
    self.m_context = UIContextMgr:GetInstance():GetContext("MissionOfferRewards")
    local exp = self.m_context:GetWantedExp()
    self.m_level = self.m_context:GetWantedLevel()
    self.m_awardLv = self.m_context:GetWantedAwardLevel()
    local group = self.m_context:GetCurWantedLevelCfgs()

    self._view.txt_level:SetText(tostring(self.m_level))
    self._view.txt_slevel:SetText(tostring(self.m_level))
    self._view.txt_expL:SetText(tostring(exp))

    local list = {}
    local isAward = function(t) -- 是否已领取
        return self.m_awardLv >= t.Level
    end
    local canAward = function(t) -- 是否可领取
        return (self.m_level >= t.Level) and (self.m_awardLv < t.Level)
    end
    for _, cfg in ipairs(group or {}) do
        local level = cfg.wantedLevel
        if level > 0 then
            table.insert(list, {
                Level = level,
                Reward = cfg.wantedReward,
                IsAward = isAward,
                CanAward = canAward
            })
        end
        if self.m_level == level then
            local lvExp = cfg.wantedExp
            self._view.txt_expR:SetText(tostring(lvExp))
            self._view.img_fill:SetFillAmount(exp / lvExp)
        end
    end
    self._view.looplist:SetDataList(list)
    self:_UpdateBtnState()
end

function M:OnDispose()
    self.m_awardHandler = nil
    M.super.OnDispose(self)
end

-- 全部领取
function M:OnClickAward(go)
    if (self.m_level <= self.m_awardLv) or (self.m_level == 0) then return end
    self.m_context:SendWantedBattleReward(self.m_activityId, function(rewards)
        local items = {}
        for _, v in ipairs(rewards or {}) do
            items[v.Id] = v.Cnt + (items[v.Id] or 0)
        end
        self.m_awardLv = self.m_context:GetWantedAwardLevel()
        GameHelper.ShowGetItems(items)
        self._view.looplist:UpdateList()
        IRedPointMgr:ForceCheck(RedPointConst.MissionOfferRewardsRedPointChecker)
        self:_UpdateBtnState()
    end)
end

function M:OnCreatItem(ctrl)
    ctrl:SetAwardCallback(self.m_awardHandler)
end

function M:_UpdateBtnState()
    local canAward = self.m_level > self.m_awardLv
    self._view.btn_award:SetState(canAward and 1 or 2)
end

return M
