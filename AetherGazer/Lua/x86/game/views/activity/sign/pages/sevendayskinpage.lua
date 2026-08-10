local var_0_0 = {
	[2714] = {
		author = "HERO_HADES_NAME",
		name = "hades",
		body = "HADES_WORD"
	},
	[2715] = {
		author = "HERO_ORSIRIS_NAME",
		name = "orsiris",
		body = "ORSIRIS_WORD"
	},
	[2716] = {
		author = "HERO_HELLA_NAME",
		name = "hella",
		body = "HELLA_WORD"
	},
	[1042051] = {
		author = "HERO_HADES_NAME",
		name = "hades",
		body = "HADES_SKIN_WORD"
	}
}

ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_1 = class("SevenDaySkinPage", ActivityMainBasePanel)

function var_0_1.GetUIName(arg_1_0)
	return ActivityCumulativeSignCfg[arg_1_0.activityID_].ui_path
end

function var_0_1.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.items = {}
	arg_2_0.max_sign_day = SevenDaySkinData:MaxSignDay(arg_2_0.activityID_)
	arg_2_0.isResign = false

	for iter_2_0 = 1, arg_2_0.max_sign_day do
		local var_2_0 = SevenDaySkinItem.New(arg_2_0["btn_" .. iter_2_0])

		table.insert(arg_2_0.items, var_2_0)
	end

	arg_2_0.onSignHandler = handler(arg_2_0, arg_2_0.OnSignSuccess)
	arg_2_0.onClearHandler = handler(arg_2_0, arg_2_0.OnClearSuccess)

	arg_2_0:AddListeners()
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.BtnSign, nil, handler(arg_3_0, arg_3_0.OnBtnSignClick))
	arg_3_0:AddBtnListener(arg_3_0.BtnInfo, nil, handler(arg_3_0, arg_3_0.OnBtnInfoClick))
end

function var_0_1.OnTop(arg_4_0)
	arg_4_0:UpdateBar()
end

function var_0_1.UpdateBar(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_1.OnEnter(arg_6_0)
	var_0_1.super.OnEnter(arg_6_0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_6_0.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_6_0.onSignHandler)
	manager.redPoint:bindUIandKey(arg_6_0.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, arg_6_0.activityID_))

	arg_6_0.data = SevenDaySkinData:GetActivityData(arg_6_0.activityID_)
	arg_6_0.crossDay = false

	arg_6_0:RefreshView()
end

function var_0_1.OnExit(arg_7_0)
	var_0_1.super.OnExit(arg_7_0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_7_0.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_7_0.onClearHandler)
	manager.redPoint:unbindUIandKey(arg_7_0.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, arg_7_0.activityID_))
	manager.windowBar:HideBar()

	if arg_7_0.timer then
		arg_7_0.timer:Stop()

		arg_7_0.timer = nil
	end
end

function var_0_1.Dispose(arg_8_0)
	var_0_1.super.Dispose(arg_8_0)

	for iter_8_0 = 1, #arg_8_0.items do
		arg_8_0.items[iter_8_0]:Dispose()
	end
end

function var_0_1.RefreshView(arg_9_0)
	arg_9_0:RefreshSignInfo()
	arg_9_0:RefreshItems()
end

function var_0_1.RefreshSignInfo(arg_10_0)
	local var_10_0 = arg_10_0.data:IsReSign()
	local var_10_1 = arg_10_0.data:SignDay() >= arg_10_0.max_sign_day

	if arg_10_0.TxtSign then
		arg_10_0.TxtSign.text = GetTips(var_10_0 and "RESIGN" or "SIGN")
	end

	if arg_10_0.BtnSign then
		arg_10_0.BtnSign:SetActive(not var_10_1)
	end

	if var_10_1 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, arg_10_0.activityID_), 0)
	end
end

function var_0_1.RefreshItems(arg_11_0)
	local var_11_0 = arg_11_0.data:SignDay()
	local var_11_1 = var_11_0 + arg_11_0.data:LeftSignTimes()
	local var_11_2 = arg_11_0.data:SignRewardList()
	local var_11_3

	for iter_11_0 = 1, arg_11_0.max_sign_day do
		local var_11_4 = var_11_2[iter_11_0]

		arg_11_0.items[iter_11_0]:RefreshView(var_11_4, iter_11_0 <= var_11_0 and 2 or iter_11_0 <= var_11_1 and 1 or 0)
	end
end

function var_0_1.OnBtnSignClick(arg_12_0)
	if arg_12_0.data:SignDay() >= arg_12_0.max_sign_day then
		return
	end

	if arg_12_0.data:LeftSignTimes() > 0 then
		SevenDaySkinAction.ReqSign(arg_12_0.activityID_)

		return
	end

	if arg_12_0.data:IsReSign() then
		arg_12_0:ShowCheckDialog()

		return
	end

	ShowTips("SIGN_TIMES_EXHAUSTED")
end

function var_0_1.OnSignSuccess(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.item_list
	local var_13_1 = var_13_0[1].id
	local var_13_2 = var_0_0[var_13_1]

	if var_13_2 then
		JumpTools.OpenPageByJump("sevenDaySkinPopView", {
			msg = var_13_2,
			reward = var_13_0
		})
	else
		getReward2(var_13_0)
	end

	arg_13_0:RefreshView()
end

function var_0_1.ShowCheckDialog(arg_14_0)
	local var_14_0 = GameSetting.activity_supplementary_sign.value[arg_14_0.data:TodayBuyNum() + 1]
	local var_14_1 = var_14_0[1]
	local var_14_2 = var_14_0[2]
	local var_14_3 = ItemTools.getItemNum(var_14_1)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = {
			GetTips("WHETHER_TO_CONSUME"),
			{
				var_14_1,
				var_14_2
			},
			(GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN"))
		},
		OkCallback = function()
			local var_15_0 = manager.time:GetServerTime()
			local var_15_1, var_15_2 = ActivityData:GetActivityTime(arg_14_0.activityID_)

			if var_15_2 <= var_15_0 then
				ShowTips("TIME_OVER")
			elseif arg_14_0.crossDay then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				arg_14_0.crossDay = false
			elseif var_14_3 < var_14_2 then
				ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
			else
				SevenDaySkinAction.ReqSign(arg_14_0.activityID_)
			end
		end
	})
end

function var_0_1.OnBtnInfoClick(arg_16_0)
	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips("ACTIVITY_INSTRUSCTIONS")
	})
end

function var_0_1.OnClearSuccess(arg_17_0)
	arg_17_0.data = SevenDaySkinData:GetActivityData(arg_17_0.activityID_)

	arg_17_0:RefreshView()

	arg_17_0.crossDay = true
end

return var_0_1
