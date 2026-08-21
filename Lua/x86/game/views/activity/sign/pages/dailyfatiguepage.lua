local var_0_0 = class("DailyFatiguePage", BaseSignPage)
local var_0_1 = 3600

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0.gameObject_:InjectUI(arg_1_0)
	arg_1_0:Init()
	arg_1_0:RegisterUIEvent()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:Refresh()
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:OnUnSelect()
end

function var_0_0.Init(arg_4_0)
	arg_4_0.cfg = GameSetting.daily_free_physical_strength.value

	if arg_4_0.cfg then
		arg_4_0.hour_a = arg_4_0.cfg[1][1] or 11
		arg_4_0.hour_b = arg_4_0.cfg[2][1] or 18
		arg_4_0.morningGet = arg_4_0.cfg[1][3] or 30
		arg_4_0.afternoonGet = arg_4_0.cfg[2][3] or 30
	end

	arg_4_0.status_morning = DailyFatigueData:GetStatus(arg_4_0.hour_a)
	arg_4_0.status_afternoon = DailyFatigueData:GetStatus(arg_4_0.hour_b)
	arg_4_0.TxtTimeMorning.text = string.format("%s : 00", arg_4_0.hour_a)
	arg_4_0.TxtTimeAfternoon.text = string.format("%s : 00", arg_4_0.hour_b)
	arg_4_0.TxtMorningGet.text = string.format(GetTips("FATIGUE_GET_COUNT_TIP"), arg_4_0.morningGet)
	arg_4_0.TxtAfternoonGet.text = string.format(GetTips("FATIGUE_GET_COUNT_TIP"), arg_4_0.afternoonGet)

	arg_4_0:SetActive(true)
end

function var_0_0.RegisterUIEvent(arg_5_0)
	arg_5_0.BtnMorning:AddListener(handlerArg1(arg_5_0, arg_5_0.OnBtnClick, arg_5_0.hour_a))
	arg_5_0.BtnAfternoon:AddListener(handlerArg1(arg_5_0, arg_5_0.OnBtnClick, arg_5_0.hour_b))
end

function var_0_0.OnBtnClick(arg_6_0, arg_6_1)
	if DailyFatigueData:GetStatus(arg_6_1) ~= ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE then
		return
	end

	if DailyFatigueData:IsFatigueFull() then
		ShowTips("FATIGUE_FULL_TIP")

		return
	end

	DailyFatigueAction.ReqGetFatigue(arg_6_1)
end

function var_0_0.OnSelect(arg_7_0)
	if not arg_7_0.timer then
		arg_7_0.timer = Timer.New(handler(arg_7_0, arg_7_0.Tick), 1, -1)

		arg_7_0.timer:Start()
	end

	arg_7_0.Scroll.verticalNormalizedPosition = 1

	arg_7_0:Tick()
	arg_7_0:StopEffect()
	arg_7_0:Refresh()
end

function var_0_0.OnUnSelect(arg_8_0)
	if arg_8_0.timer then
		arg_8_0.timer:Stop()

		arg_8_0.timer = nil
	end
end

function var_0_0.Refresh(arg_9_0)
	arg_9_0.status_morning = DailyFatigueData:GetStatus(arg_9_0.hour_a)
	arg_9_0.status_afternoon = DailyFatigueData:GetStatus(arg_9_0.hour_b)

	arg_9_0.CtrlMorning:SetSelectedIndex(arg_9_0.status_morning - 1)
	arg_9_0.CtrlAfternoon:SetSelectedIndex(arg_9_0.status_afternoon - 1)

	arg_9_0.TxtTalk.text = GetTips("DAILY_FATIGUE_TIPS")

	arg_9_0.MorningRedDot:SetActive(arg_9_0.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE)
	arg_9_0.AfternoonRedDot:SetActive(arg_9_0.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE)
end

function var_0_0.Tick(arg_10_0)
	if not arg_10_0.cfg then
		return
	end

	local var_10_0 = ActivityConst.DAILY_FATIGUE_STATUS
	local var_10_1 = manager.time
	local var_10_2 = var_10_1:GetServerTime()
	local var_10_3 = var_10_1:GetLastZeroTime()
	local var_10_4 = DailyFatigueData:GetStatus(arg_10_0.hour_a)
	local var_10_5 = DailyFatigueData:GetStatus(arg_10_0.hour_b)

	if var_10_4 == var_10_0.NOT_AVAILABLE then
		local var_10_6 = var_10_3 + arg_10_0.hour_a * var_0_1

		arg_10_0.TxtMorning.text = manager.time:DescCDTime(var_10_6 - var_10_2)
	end

	if var_10_5 == var_10_0.NOT_AVAILABLE then
		local var_10_7 = var_10_3 + arg_10_0.hour_b * var_0_1

		arg_10_0.TxtAfternoon.text = manager.time:DescCDTime(var_10_7 - var_10_2)
	end

	local var_10_8 = arg_10_0.status_morning ~= var_10_4 or arg_10_0.status_afternoon ~= var_10_5

	arg_10_0.status_morning = var_10_4
	arg_10_0.status_afternoon = var_10_5

	if var_10_8 then
		arg_10_0:Refresh()
	end
end

function var_0_0.CheckEnable(arg_11_0)
	return arg_11_0.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE or arg_11_0.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE
end

function var_0_0.AutoGetReward(arg_12_0)
	return
end

function var_0_0.OnGetFatigueSuccess(arg_13_0, arg_13_1)
	arg_13_0.status_morning = DailyFatigueData:GetStatus(arg_13_0.hour_a)
	arg_13_0.status_afternoon = DailyFatigueData:GetStatus(arg_13_0.hour_b)

	arg_13_0:Refresh()
	arg_13_0:PlayEffect(arg_13_1)
end

function var_0_0.PlayEffect(arg_14_0, arg_14_1)
	arg_14_0:StopEffect()

	if arg_14_1 == arg_14_0.hour_a then
		arg_14_0.MorningEffect:SetActive(true)
	end

	if arg_14_1 == arg_14_0.hour_b then
		arg_14_0.AfternoonEffect:SetActive(true)
	end

	Timer.New(handler(arg_14_0, arg_14_0.StopEffect), 2, 1)
end

function var_0_0.StopEffect(arg_15_0)
	arg_15_0.MorningEffect:SetActive(false)
	arg_15_0.AfternoonEffect:SetActive(false)
end

function var_0_0.ResetAni(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.CLAIMED then
		arg_16_0.MorningAni:Play(arg_16_1, arg_16_2)
	end

	if arg_16_0.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.CLAIMED then
		arg_16_0.AfternoonAni:Play(arg_16_1, arg_16_2)
	end
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end

	arg_17_0.BtnMorning:RemoveAllListener()
	arg_17_0.BtnAfternoon:RemoveAllListener()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
