local var_0_0 = class("MonthCardPage", BaseSignPage)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hander_ = arg_1_1

	local var_1_0 = Asset.Load("Widget/System/ActivitySign/MonthCardUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.haveGetController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "haveGet")
	arg_3_0.bonusIcon_.sprite = ItemTools.getItemSprite(GameSetting.monthly_card_reward_daily.value[1])
	arg_3_0.bonusLabel_.text = "x" .. GetI18NText(GameSetting.monthly_card_reward_daily.value[2])
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		return
	end)
end

function var_0_0.OnShow(arg_6_0)
	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	print(debug.traceback("MonthCardView::UpdateView, sign = " .. tostring(RechargeData:IsSignToday())))

	if RechargeData:IsSignToday() then
		arg_7_0.haveGetController_:SetSelectedState("true")
	else
		arg_7_0.haveGetController_:SetSelectedState("false")
	end

	arg_7_0.surplusDay_.text = RechargeData:GetMonthCardLastDay() .. GetTips("DAY")
end

function var_0_0.OnMonthCardDailyReward(arg_8_0)
	manager.notify:CallUpdateFunc(SIGN_INPUT, true)
	arg_8_0:UpdateView()
end

function var_0_0.AutoGetReward(arg_9_0)
	manager.notify:CallUpdateFunc(SIGN_INPUT, false)
	TimeTools.StartAfterSeconds(1, function()
		PayAction.GetMonthCardBonus()
	end, {})
end

return var_0_0
