class = var_0_10000

local var_0_0 = "PrayPoolHomeView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PrayPoolHomeView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:Show()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	return
end

function var_0_1.OnBackPress(arg_4_0)
	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	PrayProxy = var_1_10003
	arg_5_0.prayProxy = var_1_10001(var_1_10003)

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.startBtn = var_1.Find(var_6_0, "StartBtn")
	onButton = var_1

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.startBtn

	local function var_6_3()
		local var_7_0 = arg_6_0.prayProxy
		local var_7_1 = var_0.updatePageState

		PrayProxy = var_2_10003

		var_7_1(var_7_0, var_2_10003.STATE_SELECT_POOL)

		local var_7_2 = arg_6_0
		local var_7_3 = var_0.emit

		PrayPoolConst = var_3

		local var_7_4 = var_3.SWITCH_TO_SELECT_POOL_PAGE

		PrayProxy = var_2_10004

		var_7_3(var_7_2, var_7_4, var_2_10004.STATE_SELECT_POOL)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_6_1, var_6_2, var_6_3, var_1_10006)

	return
end

return var_0_1
