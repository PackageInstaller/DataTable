-- 2022/11/15 17:15:07
-- 预制体 Masquerade_Main
local UIMasqueradeCtrl = BaseClass("UIMasqueradeCtrl", BaseUICtrl)
local M = UIMasqueradeCtrl
local EBattleStyle = EnumConst.EBattleStyle
local sfmt = string.format
local AudioHelper = CS.AudioHelper
local MASQUERADEANIM = "MASQUERADEANIM"
local url = "Video/jmwh0824.mp4"

function M:Init()
    self._view.btnBack:onClick(Bind(self, self.Close))
    self._view.btnGift:onClick(Bind(self, self._OnBtnGiftClick))
    self._view.btnBattle1:onClick(Bind(self, self._OnBtnBattle1Click))
    self._view.btnBattle2:onClick(Bind(self, self._OnBtnBattle2Click))
    self._view.btnShow:onClick(Bind(self, self._OnBtnShowClick))
    self._view.btnShop:onClick(Bind(self, self._OnBtnShopClick))
    self._view.btnReward:onClick(Bind(self, self._OnBtnRewardClick))
    self._view.btnSkip:onClick(Bind(self, self._onBtnSkipClick))
    self._view.btnTips:onClick(Bind(self, self._onBtnTips))
end

-- 进入UI，可传参数
function M:OnEnter(activityId)
    self.activityId = activityId
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=self.activityId})
    self.activityCopy = activityCopys[1]
    local startTimerData, endTimerData = ActivityDataMgr:GetInstance():GetActivityTime(self.activityId)
    local startDay, startTimer = self:_getTimerFormat(startTimerData)
    local endDay, endTimer = self:_getTimerFormat(endTimerData)
    self._view.labStartDay:SetText(startDay)
    self._view.labStartTimer:SetText(startTimer)
    self._view.labEndDay:SetText(endDay)
    self._view.labEndTimer:SetText(endTimer)
    self:_InitUI()
    local taskId = self:GetContext():GetTaskActivityId()
    self._view.redPoint:SetParam(0, taskId) -- 任务红点
    self._view.redPoint:SetParam(1, activityId) -- 成就红点
    self._view.rewardRedPoint:SetParam(0, activityId) -- 大狂欢红点
    self._view.redPoint:Check()
    self._view.rewardRedPoint:Check()
    GameHelper.DoPlayerAction(PlayerAction.OpenMasquerade)
    if self:GetLastAnimTimer() then
        local time = ConfigHelper.GetSystemParam(367)
        AudioHelper.PlayPVStart()
        self._view.VideoPlayerPlayFromStreamingAssets.transform.parent:SetActive(true)
        self._view.VideoPlayerPlayFromStreamingAssets:Play(url, false)
        self._view.VideoPlayerPlayFromStreamingAssets:SetPlayOnAwake(false)
        self._timer = TimerManager:GetInstance():GetTimer(time, self.VideoCallBack, self, true)
        self._timer:Start()
    else
        self._view.VideoPlayerPlayFromStreamingAssets.transform.parent:SetActive(false)
    end

end

function M:OnVisible()
    self._view.redPoint:Check()
end

function M:VideoCallBack()
    self:_onBtnSkipClick()
end

function M:GetLastAnimTimer()
    local lastTimer = PlayerPrefTools.GetPlayerPrefsInt(MASQUERADEANIM, 0)
    if not TimeUtil.IsToday(lastTimer) then
        local nowTimer = TimeUtil.GetNowTimeStamp()
        PlayerPrefTools.SetPlayerPrefs(MASQUERADEANIM, nowTimer)
        return true
    else
        return false
    end
end

function M:_InitUI()
    self.activity = ConfigHelper.GetCfgByLua("activity", self.activityId)
    local relationId = self.activity.relationId
    self._view.btnShow:SetActive(#relationId >= 1)
    self:_InitTips()
end

function M:_InitTips()
    self.openBattle1 = true
    self.openBattle2 = true
    local endTime = self.activity.endTime
    local nowTime = TimeUtil:GetNowTimeStamp()
    if nowTime > endTime then
        self._view.labTips1:SetText(6149)
        self._view.labTips2:SetText(6149)
        self.openBattle1 = nil
        self.openBattle2 = nil
        self._view.btnBattle1:SetColor(110, 110, 110, 255)
        self._view.battle2State:SetState(2)
        return
    end
    self._view.btnBattle1:SetColor(255, 255, 255, 255)
    self._view.labTips1:SetText("")
    -- 特殊战役
    -- 特殊战役开启时间
    local specialTime = self.activityCopy.specialTime
    if specialTime > nowTime then
        local timeData = TimeUtil.GetTimeByStamp(specialTime)
        local tips = sfmt("%02d/%02d %02d:%02d\n%s", timeData.month, timeData.day, timeData.hour, timeData.minute, ConfigHelper.GetLocalString(6147))
        self._view.labTips2:SetText(tips)
        self.openBattle2 = nil
        self.tips2 = 27000013
        self._view.battle2State:SetState(2)
        return
    end
    MissionDataMgr:GetInstance():LoadChapter(self.activityCopy.chapterId, Bind(self, self._OnLoadChapter))

end

function M:_OnLoadChapter()
    -- 是否通关简单战役
    local passState = MissionDataMgr:GetInstance():IsPassedChapter(self.activityCopy.chapterId)
    if passState then
        self._view.labTips2:SetText("")
        self._view.battle2State:SetState(1)
        return
    end
    self.openBattle2 = nil
    self._view.labTips2:SetText(6148)
    self._view.battle2State:SetState(3)
    self.tips2 = 6148
end

-- 纪念入口
function M:_OnBtnGiftClick()
    UIContextMgr:GetInstance():Show(self.activityCopy.UIGift, self.activityId)
end

---入场
function M:_OnBtnBattle1Click()
    if not self.openBattle1 then
        GameHelper.TipsById(6149)
        return
    end
    local chapterId = self:GetContext():GetChapterId(0)
    local chapter = ConfigHelper.GetCfg("chapter", chapterId)
    JumpMgr:GetInstance():Execute(100, EBattleStyle.Normal, chapter)
end

function M:_OnBtnBattle2Click()
    if not self.openBattle2 then
        GameHelper.TipsById(self.tips2)
        return
    end
    local chapterId = self:GetContext():GetChapterId(1)
    local chapter = ConfigHelper.GetCfg("chapter", chapterId)
    JumpMgr:GetInstance():Execute(100, EBattleStyle.Normal, chapter)
end

---节目清单(任务)
function M:_OnBtnShowClick()
    UIContextMgr:GetInstance():Show(self.activityCopy.UITask, self.activityId)
end

---交换礼(商店)
function M:_OnBtnShopClick()
    UIContextMgr:GetInstance():Show(self.activityCopy.UIShop, self.activityId)
end

---大狂欢
function M:_OnBtnRewardClick()
    UIContextMgr:GetInstance():Show(self.activityCopy.UIReward, self.activityId)
end

-- 跳过按钮
function M:_onBtnSkipClick()
    self._view.VideoPlayerPlayFromStreamingAssets.transform.parent:SetActive(false)
    if self._timer then
        self._timer:Stop()
    end
    self._timer = nil
    AudioHelper.PlayPVEnd()
end

function M:_getTimerFormat(timer)
    local timerData = TimeUtil.GetTimeByStamp(timer)
    local month = ConfigHelper.GetLocalString(551)
    local day = ConfigHelper.GetLocalString(5793)
    local strDay = tostring(timerData.month) .. month .. timerData.day .. day
    local strTimer = tostring(sfmt("%02d", timerData.hour)) .. ":" .. sfmt("%02d", timerData.minute)
    return strDay, strTimer
end

function M:_onBtnTips()
    UIContextMgr:GetInstance():Show("GamePlayExplain", 24)
end

function M:Close()
    JumpMgr:GetInstance():Execute(1)
    M.super.Close(self)
end

function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UIMasqueradeCtrl
