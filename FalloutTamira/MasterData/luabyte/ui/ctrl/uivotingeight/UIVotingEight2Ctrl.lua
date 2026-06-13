-- baoruichang
-- 2021/12/9 11:57:05
local UIVotingEight2Ctrl = BaseClass("UIVotingEight2Ctrl", BaseUICtrl)
local M = UIVotingEight2Ctrl
local VotingTimer = EnumConst.VotingTimer
local sfmt = string.format

function M:Init()
    self.eventHero = EventMgr:AddListener(UIMessageNames.VOTING_SELECTHERO2, Bind(self, self.OnEventHero))
end

-- 进入UI，可传参数
function M:OnEnter(heroDatas)
    self.heroDatas = heroDatas
    local timeData = VotingDataMgr:GetInstance():GetTimers(VotingTimer.Timer3)
    self._view.textTime:SetText(self:GetTimer(timeData.startTimer, timeData.endTimer))

    if not self.tabCtrl then
        self.tabCtrl = {}
    end

    local prefabCtrl = self._view.item -- Ctrl
    prefabCtrl:SetActive(false)

    for i = 1, #heroDatas do
        local itemCtrl = self.tabCtrl[i]

        if not itemCtrl then
            itemCtrl = prefabCtrl:Instantiate()
            self.tabCtrl[i] = itemCtrl
        end

        itemCtrl:UpdateData(heroDatas[i])
        itemCtrl:SetActive(true)
        -- table.insert(self.tabCtrl, itemCtrl)
    end

    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    -- 刷新时间
    self.residueRefTimer = self:GetContext():GetNextRefTimer() - TimeUtil.GetNowTimeStamp()
    self:RefTimer()
    self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
    self._timer:Start()
end

function M:GetTimer(startTimer, endTimer)
    local strStart = TimeUtil.GetTimeFormat(startTimer, "%m.%d %H:%M")
    local strEnd = TimeUtil.GetTimeFormat(endTimer, "%m.%d %H:%M")
    return sfmt("%s~%s", strStart, strEnd)
end

function M:TimerCallBack()
    if self.residueRefTimer > 0 then
        self.residueRefTimer = self.residueRefTimer - 1
        self:RefTimer()
    else
        Logger.Log("请求刷新:" .. tostring(self.residueRefTimer))
        self._timer:Stop()
        self._timer = nil
        if VotingDataMgr:GetInstance():GetNowState() == VotingTimer.Timer3 then
            self:GetContext():HeroRankReq()
        else
            self:Close()
        end
    end
end

function M:RefTimer()
    local Time = TimeUtil.GetTimeByStamp(self.residueRefTimer)
    local timerStr = sfmt(ConfigHelper.GetLocalString(699), Time.minute, Time.second)
    self._view.textRefTime:SetText(timerStr)
end

function M:OnEventHero(heroId)
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingHero, heroId, self:GetContext():GetHeroDatas(), true)
end

function M:OnDispose()
    if self.tabCtrl then
        for _, value in ipairs(self.tabCtrl) do
            -- body
            CS.UnityEngine.GameObject.Destroy(value.gameObject)
            value:OnDestroy()
        end
    end

    self.tabCtrl = nil

    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end

    EventMgr:RemoveListener(UIMessageNames.VOTING_SELECTHERO2, self.eventHero)
    self.eventHero = nil
    M.super.OnDispose(self)
end

return UIVotingEight2Ctrl
