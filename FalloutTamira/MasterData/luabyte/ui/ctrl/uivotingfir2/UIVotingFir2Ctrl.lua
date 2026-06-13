-- baoruichang
-- 2021/12/15 11:17:39
local UIVotingFir2Ctrl = BaseClass("UIVotingFir2Ctrl", BaseUICtrl)
local M = UIVotingFir2Ctrl
local VotingTimer = EnumConst.VotingTimer
local sfmt = string.format

function M:Init()
end

-- 进入UI，可传参数
function M:OnEnter(heroDatas)
    self.heroDatas = heroDatas

    if heroDatas == nil or #heroDatas <= 0 then
        self._view.tfItemL.gameObject:SetActive(false)
        self._view.tfItemR.gameObject:SetActive(false)
        self._view.tfNameL.gameObject:SetActive(false)
        self._view.tfNameR.gameObject:SetActive(false)
        return
    end

    if heroDatas[1] ~= nil then
        self._view.tfItemL.gameObject:SetActive(true)
        self._view.tfNameL.gameObject:SetActive(true)
        self._view.ItemL:InitData(heroDatas[1], heroDatas)
    else
        self._view.tfItemL.gameObject:SetActive(false)
        self._view.tfNameL.gameObject:SetActive(false)
    end

    if heroDatas[2] ~= nil then
        self._view.tfItemR.gameObject:SetActive(true)
        self._view.tfNameR.gameObject:SetActive(true)
        self._view.ItemR:InitData(heroDatas[2], heroDatas)
    else
        self._view.tfItemR.gameObject:SetActive(false)
        self._view.tfNameR.gameObject:SetActive(false)
    end

    local timeData = VotingDataMgr:GetInstance():GetTimers(VotingTimer.Timer5)
    local strTimer = self:GetTimer(timeData.startTimer, timeData.endTimer)
    self._view.textTime:SetText(strTimer)

    self:ShowTime()
end

function M:GetTimer(startTimer, endTimer)
    local strStart = TimeUtil.GetTimeFormat(startTimer, "%m.%d %H:%M")
    local strEnd = TimeUtil.GetTimeFormat(endTimer, "%m.%d %H:%M")
    return sfmt("%s~%s", strStart, strEnd)
end

function M:RefTimer()
    local Time = TimeUtil.GetTimeByStamp(self.residueRefTimer)
    local timerStr = sfmt(ConfigHelper.GetLocalString(699), Time.minute, Time.second)
    self._view.textRefTime:SetText(timerStr)
end

function M:TimerCallBack()
    if self.residueRefTimer > 0 then
        self.residueRefTimer = self.residueRefTimer - 1
        self:RefTimer()
    else
        Logger.Log("请求刷新:" .. tostring(self.residueRefTimer))
        self._timer:Stop()
        self._timer = nil
        self:GetContext():HeroRankReq()
    end
end

-- 当被全屏UI盖住时，调用此
function M:OnInvisible()
    M.super.OnInvisible(self)

    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
end

-- 当盖住自己的全屏UI关闭时掉用
function M:OnVisible()
    M.super.OnVisible(self)
    self:ShowTime()
end

function M:ShowTime()
    self.residueRefTimer = self:GetContext():GetNextRefTimer() - TimeUtil.GetNowTimeStamp()
    self:RefTimer()
    self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
    self._timer:Start()
end

function M:OnDispose()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end

    M.super.OnDispose(self)
end

return UIVotingFir2Ctrl
