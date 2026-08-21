local var_0_0 = class("MallSummaryBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MallSummaryBox"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0.uiTitleText, i18n("mall_summary_title"))
	setText(arg_2_0.uiTipText, i18n("word_click_to_close"))
	setText(arg_2_0.uiIncomeHeaderText, i18n("mall_total_income_header"))
	setText(arg_2_0.uiBalanceHeaderText, i18n("mall_balance_header"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.uiCloseBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	arg_3_0.floorUIList = UIItemList.New(arg_3_0.uiFloorsTF, arg_3_0.uiFloorsTF:Find("tpl"))

	arg_3_0.floorUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setText(arg_5_2:Find("header"), i18n("mall_floor_income_header", arg_5_1 + 1))
			setText(arg_5_2:Find("value"), arg_3_0.incomeList[arg_5_1 + 1])
		end

		return
	end)

	return
end

function var_0_0.Show(arg_6_0)
	var_0_0.super.Show(arg_6_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	arg_6_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	arg_6_0.balance = arg_6_0.activity:GetLastBalance()
	arg_6_0.totalIncome = 0
	arg_6_0.incomeList = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.activity:GetFloorListAsc()) do
		if iter_6_1:IsUnlock() then
			local var_6_0 = iter_6_1:GetLastIncome()

			arg_6_0.totalIncome = arg_6_0.totalIncome + var_6_0

			table.insert(arg_6_0.incomeList, var_6_0)
		end
	end

	setText(arg_6_0.uiIncomeValText, arg_6_0.totalIncome)
	setText(arg_6_0.uiBalanceValText, arg_6_0.balance)
	arg_6_0.floorUIList:align(#arg_6_0.incomeList)

	return
end

function var_0_0.Hide(arg_7_0)
	var_0_0.super.Hide(arg_7_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
