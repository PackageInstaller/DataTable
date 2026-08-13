class = var_0_10000

local var_0_0 = "MallSummaryBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MallSummaryBox"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiTitleText

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("mall_summary_title"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiTipText

	i18n = var_3

	var_1_10001(var_2_1, var_3("word_click_to_close"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.uiIncomeHeaderText

	i18n = var_3

	var_1_10001(var_2_2, var_3("mall_total_income_header"))

	setText = var_1_10001

	local var_2_3 = arg_2_0.uiBalanceHeaderText

	i18n = var_3

	var_1_10001(var_2_3, var_3("mall_balance_header"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.uiCloseBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	UIItemList = var_1_10001

	local var_3_3 = var_1_10001.New
	local var_3_4 = arg_3_0.uiFloorsTF
	local var_3_5 = arg_3_0.uiFloorsTF

	arg_3_0.floorUIList = var_3_3(var_3_4, var_3.Find(var_3_5, "tpl"))

	local var_3_6 = arg_3_0.floorUIList

	var_1.make(var_3_6, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_5_1 + 1

			setText = var_2_10004

			local var_5_1 = arg_5_2
			local var_5_2 = arg_5_2.Find(var_5_1, "header")

			i18n = var_5_1

			var_2_10004(var_5_2, var_5_1("mall_floor_income_header", var_5_0))

			setText = var_2_10004

			var_2_10004(arg_5_2:Find("value"), arg_3_0.incomeList[var_5_0])
		end

		return
	end)

	return
end

function var_0_1.Show(arg_6_0)
	var_0_1.super.Show(arg_6_0)

	pg = var_1

	local var_6_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_6_0, arg_6_0._tf)

	getProxy = var_1
	ActivityProxy = var_6_0

	local var_6_1 = var_1(var_6_0)
	local var_6_2 = var_1.getActivityByType

	ActivityConst = var_3
	arg_6_0.activity = var_6_2(var_6_1, var_3.ACTIVITY_TYPE_MALL)

	local var_6_3 = arg_6_0.activity

	arg_6_0.balance = var_1.GetLastBalance(var_6_3)
	arg_6_0.totalIncome = 0
	arg_6_0.incomeList = {}
	ipairs = var_1

	local var_6_4 = arg_6_0.activity

	for iter_6_0, iter_6_1 in var_1(var_2.GetFloorListAsc(var_6_4)) do
		if iter_6_1:IsUnlock() then
			local var_6_5 = iter_6_1:GetLastIncome()

			arg_6_0.totalIncome = arg_6_0.totalIncome + var_6_5
			table = var_7

			var_7.insert(arg_6_0.incomeList, var_6_5)
		end
	end

	setText = var_1

	var_1(arg_6_0.uiIncomeValText, arg_6_0.totalIncome)

	setText = var_1

	var_1(arg_6_0.uiBalanceValText, arg_6_0.balance)

	local var_6_6 = arg_6_0.floorUIList

	var_1.align(var_6_6, #arg_6_0.incomeList)

	return
end

function var_0_1.Hide(arg_7_0)
	var_0_1.super.Hide(arg_7_0)

	pg = var_1

	local var_7_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
