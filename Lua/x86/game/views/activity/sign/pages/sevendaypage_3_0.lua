ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SevenDayPage_3_0", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return ActivityCumulativeSignCfg[arg_1_0.activityID_].ui_path
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.items = {}
	arg_2_0.max_sign_day = SevenDaySkinData:MaxSignDay(arg_2_0.activityID_)

	for iter_2_0 = 1, arg_2_0.max_sign_day do
		local var_2_0 = SevenDaySkinItem_3_0.New(arg_2_0["btn_" .. iter_2_0])

		var_2_0:RegisterListener(function()
			if arg_2_0.data:SignDay() >= arg_2_0.max_sign_day then
				return
			end

			if arg_2_0.data:LeftSignTimes() > 0 then
				SevenDaySkinAction.ReqSign(arg_2_0.activityID_)

				return
			end

			if arg_2_0.data:IsReSign() then
				arg_2_0:ShowCheckDialog()

				return
			end
		end)
		table.insert(arg_2_0.items, var_2_0)
	end

	arg_2_0.onSignHandler = handler(arg_2_0, arg_2_0.OnSignSuccess)
	arg_2_0.onClearHandler = handler(arg_2_0, arg_2_0.OnClearSuccess)

	arg_2_0:AddListeners()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.BtnSign, nil, handler(arg_4_0, arg_4_0.OnBtnSignClick))
	arg_4_0:AddBtnListener(arg_4_0.btn_desc, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_OPTIONAL_RANDOM_RULE")
		})
	end)
end

function var_0_0.OnTop(arg_6_0)
	arg_6_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.CURRENCY_RANDOM_TARGET_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN, true)
end

function var_0_0.OnEnter(arg_8_0)
	var_0_0.super.OnEnter(arg_8_0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_8_0.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_8_0.onSignHandler)
	manager.redPoint:bindUIandKey(arg_8_0.BtnSign.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))

	arg_8_0.data = SevenDaySkinData:GetActivityData(arg_8_0.activityID_)
	arg_8_0.crossDay = false

	arg_8_0:RefreshView()
end

function var_0_0.OnExit(arg_9_0)
	var_0_0.super.OnExit(arg_9_0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_9_0.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_9_0.onClearHandler)
	manager.redPoint:unbindUIandKey(arg_9_0.BtnSign.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	for iter_10_0 = 1, #arg_10_0.items do
		arg_10_0.items[iter_10_0]:Dispose()
	end
end

function var_0_0.RefreshView(arg_11_0)
	arg_11_0:RefreshSignInfo()
	arg_11_0:RefreshItems()

	local var_11_0 = arg_11_0.data:LeftSignTimes()
end

function var_0_0.RefreshSignInfo(arg_12_0)
	arg_12_0.descText_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_BACKDROP")
end

function var_0_0.RefreshItems(arg_13_0)
	arg_13_0.receiveState = false

	local var_13_0 = arg_13_0.data:SignDay()
	local var_13_1 = var_13_0 + arg_13_0.data:LeftSignTimes()
	local var_13_2 = arg_13_0.data:SignRewardList()
	local var_13_3 = var_13_0 + arg_13_0.data:ReSignNum()

	for iter_13_0 = 1, arg_13_0.max_sign_day do
		if iter_13_0 <= var_13_0 then
			arg_13_0.receiveState = false
		elseif iter_13_0 <= var_13_1 then
			arg_13_0.receiveState = true
		else
			arg_13_0.receiveState = false
		end
	end

	local var_13_4

	for iter_13_1 = 1, arg_13_0.max_sign_day do
		local var_13_5 = var_13_2[iter_13_1]

		if iter_13_1 == var_13_0 + 1 and not arg_13_0.receiveState then
			arg_13_0.items[iter_13_1]:RefreshView(var_13_5, iter_13_1 <= var_13_0 and 2 or iter_13_1 <= var_13_1 and 1 or 0, var_13_3 > 0)
		else
			arg_13_0.items[iter_13_1]:RefreshView(var_13_5, iter_13_1 <= var_13_0 and 2 or iter_13_1 <= var_13_1 and 1 or 0, false)
		end

		var_13_3 = var_13_3 - 1
	end
end

function var_0_0.OnBtnSignClick(arg_14_0)
	JumpTools.OpenPageByJump("/norseSurpriseGiftMachinePage")
end

function var_0_0.OnSignSuccess(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.item_list

	getReward(var_15_0)
	arg_15_0:RefreshView()

	arg_15_0.crossDay = false
end

function var_0_0.ShowCheckDialog(arg_16_0)
	local var_16_0 = ActivityCumulativeSignCfg[arg_16_0.activityID_].cost_item_list[1]
	local var_16_1 = var_16_0[1]
	local var_16_2 = GetI18NText(ItemCfg[var_16_1].name)
	local var_16_3 = var_16_0[2]
	local var_16_4 = ItemTools.getItemNum(var_16_1)
	local var_16_5 = string.format(GetTips("ACTIVITY_OPTIONAL_RANDOM_SIGN_COST"), var_16_2, var_16_3)

	JumpTools.OpenPageByJump("popCostItem", {
		costId = var_16_1,
		costCount = var_16_3,
		content = var_16_5,
		popCostCallBack = function()
			local var_17_0 = manager.time:GetServerTime()
			local var_17_1, var_17_2 = ActivityData:GetActivityTime(arg_16_0.activityID_)

			if var_17_2 <= var_17_0 then
				ShowTips("TIME_OVER")
			elseif arg_16_0.crossDay then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				arg_16_0.crossDay = false
			elseif var_16_4 < var_16_3 then
				ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
			else
				SevenDaySkinAction.ReqSign(arg_16_0.activityID_)
			end
		end,
		CancelCallback = function()
			manager.windowBar:HideBar()
			arg_16_0:UpdateBar()
		end,
		MaskCallback = function()
			manager.windowBar:HideBar()
			arg_16_0:UpdateBar()
		end
	})
end

function var_0_0.OnBtnInfoClick(arg_20_0)
	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips("ACTIVITY_INSTRUSCTIONS")
	})
end

function var_0_0.OnClearSuccess(arg_21_0)
	arg_21_0.data = SevenDaySkinData:GetActivityData(arg_21_0.activityID_)

	arg_21_0:RefreshView()

	arg_21_0.crossDay = true
end

return var_0_0
