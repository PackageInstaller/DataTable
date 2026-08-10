ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SevenDaySkinPage_3_4", ActivityMainBasePanel)
local var_0_1 = {
	[113907] = {
		author = "HERO_BOSAIDONG_NAME",
		name = "hades",
		body = "BOSAIDONG_SKIN_WORD"
	}
}

function var_0_0.GetUIName(arg_1_0)
	return ActivityCumulativeSignCfg[arg_1_0.activityID_].ui_path
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.items_ = {}
	arg_3_0.maxDay_ = SevenDaySkinData:MaxSignDay(arg_3_0.activityID_)

	for iter_3_0 = 1, arg_3_0.maxDay_ do
		local var_3_0 = SevenDaySkinItem_3_4.New(arg_3_0["btn_" .. iter_3_0])

		arg_3_0.items_[iter_3_0] = var_3_0

		arg_3_0.items_[iter_3_0]:RegisterClickFunc(function()
			arg_3_0:OnBtnSignClick()
		end)
	end

	arg_3_0.onSignHandler = handler(arg_3_0, arg_3_0.OnSignSuccess)
	arg_3_0.onClearHandler = handler(arg_3_0, arg_3_0.OnClearSuccess)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_INSTRUSCTIONS")
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.videoBtn_, nil, function()
		OperationRecorder.RecordButtonTouch(string.format("activity_%s_video_play", arg_5_0.activityID_))
		JumpTools.OpenPageByJump("/videoShowView", {
			start_path = GameSetting.activity_sign_bosaidong_video.value[1]
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	var_0_0.super.OnEnter(arg_8_0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_8_0.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_8_0.onSignHandler)

	arg_8_0.crossDay_ = false
	arg_8_0.data_ = SevenDaySkinData:GetActivityData(arg_8_0.activityID_)

	arg_8_0:RefreshView()
end

function var_0_0.RefreshView(arg_9_0)
	arg_9_0.descText_.text = GetTips("BOSAIDONG_SIGN_DESCRIPTION")

	arg_9_0:RefreshItems()
	arg_9_0:RefreshBtn()
end

function var_0_0.RefreshItems(arg_10_0)
	local var_10_0 = arg_10_0.data_:SignDay()
	local var_10_1 = var_10_0 + arg_10_0.data_:LeftSignTimes()
	local var_10_2 = arg_10_0.data_:SignRewardList()
	local var_10_3 = var_10_2[1][1]

	arg_10_0.skinCfg = SkinCfg[var_10_3]

	for iter_10_0 = 1, arg_10_0.maxDay_ do
		local var_10_4 = var_10_2[iter_10_0]
		local var_10_5 = 0
		local var_10_6 = iter_10_0 == var_10_0 + 1 and arg_10_0.data_:IsReSign()

		if iter_10_0 <= var_10_0 then
			var_10_5 = 2
		elseif iter_10_0 <= var_10_1 or var_10_6 then
			var_10_5 = 1
		end

		arg_10_0.items_[iter_10_0]:RefreshView(var_10_4, var_10_5, var_10_6)
	end
end

function var_0_0.RefreshBtn(arg_11_0)
	local var_11_0 = (GameSetting.activity_sign_bosaidong_button_open_time.value[1] or 0) * 3600
	local var_11_1 = ActivityData:GetActivityData(arg_11_0.activityID_).startTime
	local var_11_2 = manager.time:GetServerTime() >= var_11_1 + var_11_0

	SetActive(arg_11_0.videoBtn_.gameObject, var_11_2)
end

function var_0_0.OnBtnSignClick(arg_12_0)
	if arg_12_0.data_:SignDay() >= arg_12_0.maxDay_ then
		return
	end

	if arg_12_0.data_:LeftSignTimes() > 0 then
		SevenDaySkinAction.ReqSign(arg_12_0.activityID_)

		return
	end

	if arg_12_0.data_:IsReSign() then
		arg_12_0:ShowCheckDialog()

		return
	end

	ShowTips("SIGN_TIMES_EXHAUSTED")
end

function var_0_0.OnSignSuccess(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.sign_num
	local var_13_1 = arg_13_0.data_:SignRewardList()[var_13_0]
	local var_13_2 = var_13_1[1]
	local var_13_3 = var_0_1[var_13_2]

	if var_13_3 then
		JumpTools.OpenPageByJump("sevenDaySkinPopView_3_4", {
			msg = var_13_3,
			reward = {
				var_13_1
			}
		})
	else
		getReward(formatRewardCfgList({
			var_13_1
		}))
	end

	arg_13_0:RefreshView()

	arg_13_0.crossDay_ = false
end

function var_0_0.OnClearSuccess(arg_14_0)
	arg_14_0.data_ = SevenDaySkinData:GetActivityData(arg_14_0.activityID_)

	arg_14_0:RefreshView()

	arg_14_0.crossDay_ = true
end

function var_0_0.ShowCheckDialog(arg_15_0)
	local var_15_0 = GameSetting.activity_supplementary_sign_new.value
	local var_15_1 = var_15_0[2]
	local var_15_2 = var_15_0[1]
	local var_15_3 = CurrencyData:GetCurrencyNum(var_15_2)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(var_15_2), var_15_1, GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")),
		OkCallback = function()
			local var_16_0, var_16_1 = ActivityData:GetActivityTime(arg_15_0.activityID_)

			if var_16_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif arg_15_0.crossDay_ then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				arg_15_0.crossDay_ = false
			elseif var_15_3 < var_15_1 then
				ShopTools.DiamondEnoughMessageBox()
			else
				SevenDaySkinAction.ReqSign(arg_15_0.activityID_)
			end
		end
	})
end

function var_0_0.UpdateBar(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_0.OnTop(arg_18_0)
	arg_18_0:UpdateBar()
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:StopTimer()
	var_0_0.super.OnExit(arg_19_0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_19_0.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_19_0.onSignHandler)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0:RemoveAllListeners()

	for iter_20_0 = 1, #arg_20_0.items_ do
		arg_20_0.items_[iter_20_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
