local DailyFatiguePage = class("DailyFatiguePage", BaseSignPage)
local var_0_1 = 3600

function DailyFatiguePage:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self.gameObject_:InjectUI(self)
	self:Init()
	self:RegisterUIEvent()
end

function DailyFatiguePage:OnEnter()
	self:Refresh()
end

function DailyFatiguePage:OnExit()
	self:OnUnSelect()
end

function DailyFatiguePage:Init()
	self.cfg = GameSetting.daily_free_physical_strength.value

	if self.cfg then
		self.hour_a = self.cfg[1][1] or 11
		self.hour_b = self.cfg[2][1] or 18
		self.morningGet = self.cfg[1][3] or 30
		self.afternoonGet = self.cfg[2][3] or 30
	end

	self.status_morning = DailyFatigueData:GetStatus(self.hour_a)
	self.status_afternoon = DailyFatigueData:GetStatus(self.hour_b)
	self.TxtTimeMorning.text = string.format("%s : 00", self.hour_a)
	self.TxtTimeAfternoon.text = string.format("%s : 00", self.hour_b)
	self.TxtMorningGet.text = string.format(GetTips("FATIGUE_GET_COUNT_TIP"), self.morningGet)
	self.TxtAfternoonGet.text = string.format(GetTips("FATIGUE_GET_COUNT_TIP"), self.afternoonGet)

	self:SetActive(true)
end

function DailyFatiguePage:RegisterUIEvent()
	self.BtnMorning:AddListener(handlerArg1(self, self.OnBtnClick, self.hour_a))
	self.BtnAfternoon:AddListener(handlerArg1(self, self.OnBtnClick, self.hour_b))
end

function DailyFatiguePage:OnBtnClick(arg_6_1)
	if DailyFatigueData:GetStatus(arg_6_1) ~= ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE then
		return
	end

	if DailyFatigueData:IsFatigueFull() then
		ShowTips("FATIGUE_FULL_TIP")

		return
	end

	DailyFatigueAction.ReqGetFatigue(arg_6_1)
end

function DailyFatiguePage:OnSelect()
	if not self.timer then
		self.timer = Timer.New(handler(self, self.Tick), 1, -1)

		self.timer:Start()
	end

	self.Scroll.verticalNormalizedPosition = 1

	self:Tick()
	self:StopEffect()
	self:Refresh()
end

function DailyFatiguePage:OnUnSelect()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function DailyFatiguePage:Refresh()
	self.status_morning = DailyFatigueData:GetStatus(self.hour_a)
	self.status_afternoon = DailyFatigueData:GetStatus(self.hour_b)

	self.CtrlMorning:SetSelectedIndex(self.status_morning - 1)
	self.CtrlAfternoon:SetSelectedIndex(self.status_afternoon - 1)

	self.TxtTalk.text = GetTips("DAILY_FATIGUE_TIPS")

	self.MorningRedDot:SetActive(self.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE)
	self.AfternoonRedDot:SetActive(self.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE)
end

function DailyFatiguePage:Tick()
	if not self.cfg then
		return
	end

	local var_10_0 = ActivityConst.DAILY_FATIGUE_STATUS
	local var_10_1 = manager.time:GetServerTime()
	local var_10_2 = manager.time:GetLastZeroTime()
	local var_10_3 = DailyFatigueData:GetStatus(self.hour_a)
	local var_10_4 = DailyFatigueData:GetStatus(self.hour_b)

	if var_10_3 == ActivityConst.DAILY_FATIGUE_STATUS.NOT_AVAILABLE then
		self.TxtMorning.text = manager.time:DescCDTime(var_10_2 + self.hour_a * var_0_1 - var_10_1)
	end

	if var_10_4 == var_10_0.NOT_AVAILABLE then
		self.TxtAfternoon.text = manager.time:DescCDTime(var_10_2 + self.hour_b * var_0_1 - var_10_1)
	end

	self.status_morning = var_10_3
	self.status_afternoon = var_10_4

	if self.status_morning ~= var_10_3 or self.status_afternoon ~= var_10_4 then
		self:Refresh()
	end
end

function DailyFatiguePage:CheckEnable()
	return self.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE or self.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE
end

function DailyFatiguePage:AutoGetReward()
	return
end

function DailyFatiguePage:OnGetFatigueSuccess(arg_13_1)
	self.status_morning = DailyFatigueData:GetStatus(self.hour_a)
	self.status_afternoon = DailyFatigueData:GetStatus(self.hour_b)

	self:Refresh()
	self:PlayEffect(arg_13_1)
end

function DailyFatiguePage:PlayEffect(arg_14_1)
	self:StopEffect()

	if arg_14_1 == self.hour_a then
		self.MorningEffect:SetActive(true)
	end

	if arg_14_1 == self.hour_b then
		self.AfternoonEffect:SetActive(true)
	end

	Timer.New(handler(self, self.StopEffect), 2, 1)
end

function DailyFatiguePage:StopEffect()
	self.MorningEffect:SetActive(false)
	self.AfternoonEffect:SetActive(false)
end

function DailyFatiguePage:ResetAni(arg_16_1, arg_16_2)
	if self.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.CLAIMED then
		self.MorningAni:Play(arg_16_1, arg_16_2)
	end

	if self.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.CLAIMED then
		self.AfternoonAni:Play(arg_16_1, arg_16_2)
	end
end

function DailyFatiguePage:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.BtnMorning:RemoveAllListener()
	self.BtnAfternoon:RemoveAllListener()
	DailyFatiguePage.super.Dispose(self)
end

return DailyFatiguePage
