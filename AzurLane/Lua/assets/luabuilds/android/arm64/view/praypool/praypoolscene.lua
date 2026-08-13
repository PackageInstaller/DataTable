class = var_0_10000

local var_0_0 = "PrayPoolScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "PrayPool"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:initEvents()

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0.prayProxy
	local var_3_1 = var_1.getPageState(var_3_0)

	arg_3_0:switchPage(var_3_1)

	return
end

function var_0_1.willExit(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.subViewList) do
		iter_4_1:Destroy()
	end

	return
end

function var_0_1.onBackPressed(arg_5_0)
	local var_5_0

	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.subViewList) do
		var_5_0 = iter_5_1:OnBackPress()
	end

	if not var_5_0 then
		arg_5_0:emit(var_0_1.ON_BACK)
	end

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.subViewContainer = var_1.Find(var_6_0, "BG/SubViewContainer")

	local var_6_1 = arg_6_0._tf

	arg_6_0.helpBtn = var_1.Find(var_6_1, "BG/HelpBtn")
	onButton = var_1

	var_1(arg_6_0, arg_6_0.helpBtn, function()
		pg = var_2_10000

		if var_2_10000.gametip.pray_build_help then
			pg = var_0

			local var_7_0 = var_0.MsgboxMgr.GetInstance()
			local var_7_1 = var_0.ShowMsgBox
			local var_7_2 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_7_2.type = var_2_10004
			pg = var_2_10004
			var_7_2.helps = var_2_10004.gametip.pray_build_help.tip

			var_7_1(var_7_0, var_7_2)
		end

		return
	end)

	return
end

function var_0_1.initData(arg_8_0)
	getProxy = var_1_10001
	PrayProxy = var_1_10003
	arg_8_0.prayProxy = var_1_10001(var_1_10003)
	PrayPoolHomeView = var_1
	arg_8_0.prayPoolHomeView = var_1.New(arg_8_0.subViewContainer, arg_8_0.event, arg_8_0.contextData)
	PrayPoolSelectPoolView = var_1
	arg_8_0.prayPoolSelectPoolView = var_1.New(arg_8_0.subViewContainer, arg_8_0.event, arg_8_0.contextData)
	PrayPoolSelectShipView = var_1
	arg_8_0.prayPoolSelectShipView = var_1.New(arg_8_0.subViewContainer, arg_8_0.event, arg_8_0.contextData)
	PrayPoolSuccessView = var_1
	arg_8_0.PrayPoolSuccessView = var_1.New(arg_8_0.subViewContainer, arg_8_0.event, arg_8_0.contextData)
	arg_8_0.curSubView = nil

	local var_8_0 = {}

	PrayProxy = var_1_10002
	var_8_0[var_1_10002.STATE_HOME] = arg_8_0.prayPoolHomeView
	PrayProxy = var_2
	var_8_0[var_2.STATE_SELECT_POOL] = arg_8_0.prayPoolSelectPoolView
	PrayProxy = var_2
	var_8_0[var_2.STAGE_SELECT_SHIP] = arg_8_0.prayPoolSelectShipView
	PrayProxy = var_2
	var_8_0[var_2.STAGE_BUILD_SUCCESS] = arg_8_0.PrayPoolSuccessView
	arg_8_0.subViewList = var_8_0

	return
end

function var_0_1.initEvents(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.bind

	PrayPoolConst = var_1_10004

	var_9_1(var_9_0, var_1_10004.SWITCH_TO_SELECT_POOL_PAGE, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_9_0

		var_2.switchPage(var_10_0, arg_10_1)

		return
	end)

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.bind

	PrayPoolConst = var_4

	var_9_3(var_9_2, var_4.SWITCH_TO_SELECT_SHIP_PAGE, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_9_0

		var_2.switchPage(var_11_0, arg_11_1)

		return
	end)

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.bind

	PrayPoolConst = var_4

	var_9_5(var_9_4, var_4.SWITCH_TO_HOME_PAGE, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_9_0

		var_2.switchPage(var_12_0, arg_12_1)

		return
	end)

	return
end

function var_0_1.switchPage(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.subViewList[arg_13_1]

	var_2.Reset(var_13_0)

	local var_13_1 = arg_13_0.subViewList[arg_13_1]

	var_2.Load(var_13_1)

	if arg_13_0.curSubView then
		local var_13_2 = arg_13_0.curSubView

		var_2.Destroy(var_13_2)
	end

	arg_13_0.curSubView = arg_13_0.subViewList[arg_13_1]

	return
end

return var_0_1
