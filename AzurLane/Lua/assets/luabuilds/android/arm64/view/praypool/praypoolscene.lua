local var_0_0 = class("PrayPoolScene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "PrayPool"
end

function var_0_0.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:initEvents()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:switchPage((arg_3_0.prayProxy:getPageState()))

	return
end

function var_0_0.willExit(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.subViewList) do
		iter_4_1:Destroy()
	end

	return
end

function var_0_0.onBackPressed(arg_5_0)
	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.subViewList) do
		var_5_0 = iter_5_1:OnBackPress()
	end

	if not var_5_0 then
		arg_5_0:emit(var_0_0.ON_BACK)
	end

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.subViewContainer = arg_6_0._tf:Find("BG/SubViewContainer")
	arg_6_0.helpBtn = arg_6_0._tf:Find("BG/HelpBtn")

	onButton(arg_6_0, arg_6_0.helpBtn, function()
		if pg.gametip.pray_build_help then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.pray_build_help.tip
			})
		end

		return
	end)

	return
end

function var_0_0.initData(arg_8_0)
	arg_8_0.prayProxy = getProxy(PrayProxy)
	arg_8_0.prayPoolHomeView = PrayPoolHomeView.New(arg_8_0.subViewContainer, arg_8_0.event, arg_8_0.contextData)
	arg_8_0.prayPoolSelectPoolView = PrayPoolSelectPoolView.New(arg_8_0.subViewContainer, arg_8_0.event, arg_8_0.contextData)
	arg_8_0.prayPoolSelectShipView = PrayPoolSelectShipView.New(arg_8_0.subViewContainer, arg_8_0.event, arg_8_0.contextData)
	arg_8_0.PrayPoolSuccessView = PrayPoolSuccessView.New(arg_8_0.subViewContainer, arg_8_0.event, arg_8_0.contextData)
	arg_8_0.curSubView = nil
	arg_8_0.subViewList = {
		[PrayProxy.STATE_HOME] = arg_8_0.prayPoolHomeView,
		[PrayProxy.STATE_SELECT_POOL] = arg_8_0.prayPoolSelectPoolView,
		[PrayProxy.STAGE_SELECT_SHIP] = arg_8_0.prayPoolSelectShipView,
		[PrayProxy.STAGE_BUILD_SUCCESS] = arg_8_0.PrayPoolSuccessView
	}

	return
end

function var_0_0.initEvents(arg_9_0)
	arg_9_0:bind(PrayPoolConst.SWITCH_TO_SELECT_POOL_PAGE, function(arg_10_0, arg_10_1)
		arg_9_0:switchPage(arg_10_1)

		return
	end)
	arg_9_0:bind(PrayPoolConst.SWITCH_TO_SELECT_SHIP_PAGE, function(arg_11_0, arg_11_1)
		arg_9_0:switchPage(arg_11_1)

		return
	end)
	arg_9_0:bind(PrayPoolConst.SWITCH_TO_HOME_PAGE, function(arg_12_0, arg_12_1)
		arg_9_0:switchPage(arg_12_1)

		return
	end)

	return
end

function var_0_0.switchPage(arg_13_0, arg_13_1)
	arg_13_0.subViewList[arg_13_1]:Reset()
	arg_13_0.subViewList[arg_13_1]:Load()

	if arg_13_0.curSubView then
		arg_13_0.curSubView:Destroy()
	end

	arg_13_0.curSubView = arg_13_0.subViewList[arg_13_1]

	return
end

return var_0_0
