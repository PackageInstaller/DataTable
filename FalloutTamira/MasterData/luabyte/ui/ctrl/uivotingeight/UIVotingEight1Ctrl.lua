local UIVotingEight1Ctrl = BaseClass("UIVotingEight1Ctrl")
local M = UIVotingEight1Ctrl
local VotingTimer = EnumConst.VotingTimer
local sfmt = string.format

-- 选完八强等待阶段
-- UI: VotingAllUI 
function M:__init(view)
    self._view = view
    self:Init()
end

-- Name 预制体: UIVotingAll
function M:Init()

    local UIVotingEight1ItemCtrl = require("UI.Ctrl.UIVotingEight.UIVotingEight1ItemCtrl")
    local UIVotingEight1ItemView = require("UI.View.UIVotingEight.UIVotingEight1ItemView")

    self.gridScroll = self._view.ScrollRect
    self.gridScroll:Init(UIVotingEight1ItemCtrl, UIVotingEight1ItemView)
    self.tabAllHero = {}

    self.eventHero = EventMgr:AddListener(UIMessageNames.VOTING_SELECTHERO1, Bind(self, self.OnEventHero))
end

-- 进入UI，可传参数
function M:UpdateData(heroDatas)
    self.heroDatas = heroDatas
    self.gridScroll:SetDataList(self.heroDatas)

    local timerData = VotingDataMgr:GetInstance():GetTimers(VotingTimer.Timer3)
    local eightStartTimer = timerData.startTimer
    self.resTimer = eightStartTimer - TimeUtil.GetNowTimeStamp()
    self.resTimer = self.resTimer > 0 and self.resTimer or 0
    local strTimer = TimeUtil.SecToStringFormat(self.resTimer)
    self._view.textTimer:SetText(strTimer)

    if self.resTimer > 0 then
        self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
        self._timer:Start()
    end
end

function M:TimerCallBack()
    self.resTimer = self.resTimer - 1

    if self.resTimer <= 0 then
        if self._timer then
            self._timer:Stop()
            self._timer = nil
            EventMgr:Broadcast(UIMessageNames.VOTING_REFSTATE)
            return
        end

        self.resTimer = 0
    end
    local strTimer = TimeUtil.SecToStringFormat(self.resTimer)
    self._view.textTimer:SetText(strTimer)
end

function M:OnEventHero(heroId)
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingHero, heroId, self.heroDatas, false)
end

function M:SetEnableFalse(value)
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

return UIVotingEight1Ctrl
