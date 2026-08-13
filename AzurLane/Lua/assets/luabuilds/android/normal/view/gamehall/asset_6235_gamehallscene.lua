class = var_0_10000

local var_0_0 = "GameHallScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.open_with_list = false

function var_0_1.getUIName(arg_1_0)
	return "GameHallUI"
end

function var_0_1.init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:initTopUI()
	arg_3_0:initHomeUI()

	findTF = var_1

	local var_3_0 = var_1(arg_3_0._tf, "ad/container")

	GameHallContainerUI = var_2
	arg_3_0.charController = var_2.New(var_3_0)
	findTF = var_2
	arg_3_0.freeCoinTf = var_2(var_3_0, "content/top/free")
	onButton = var_2

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.freeCoinTf

	local function var_3_3()
		getProxy = var_2_10000
		GameRoomProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)
		local var_4_1 = var_0.getCoin(var_4_0)

		pg = var_4_0

		local var_4_2 = var_4_0.gameset.game_coin_max.key_value - var_4_1

		pg = var_2_10003

		local var_4_3 = var_2_10003.gameset.game_coin_initial.key_value

		if var_4_2 == 0 then
			pg = var_2_10004

			local var_4_4 = var_2_10004.TipsMgr.GetInstance()

			var_2_10004 = var_2_10004.ShowTips
			i18n = var_2_10006

			var_2_10004(var_4_4, var_2_10006("game_icon_max_full"))
		elseif var_4_2 < var_4_3 then
			pg = var_2_10004

			local var_4_5 = var_2_10004.MsgboxMgr.GetInstance()
			local var_4_6 = var_4.ShowMsgBox

			var_2_10006 = {}
			i18n = var_2_10007
			var_2_10006.content = var_2_10007("game_icon_max")

			function var_2_10006.onYes()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				GameHallMediator = var_3_10002

				var_5_1(var_5_0, var_3_10002.GET_WEEKLY_COIN)

				return
			end

			function var_2_10006.onNo()
				return
			end

			var_4_6(var_4_5, var_2_10006)
		else
			local var_4_7 = arg_3_0
			local var_4_8 = var_4.emit

			GameHallMediator = var_2_10006

			var_4_8(var_4_7, var_2_10006.GET_WEEKLY_COIN)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_2(var_3_1, var_3_2, var_3_3, var_1_10006)

	findTF = var_2
	arg_3_0.listPanelTf = var_2(arg_3_0._tf, "ad/listPanel")
	GameHallListPanel = var_2
	arg_3_0.listPanel = var_2.New(arg_3_0.listPanelTf, arg_3_0)

	local var_3_4 = arg_3_0.listPanel
	local var_3_5 = var_2.setVisible

	GameHallScene = var_4

	var_3_5(var_3_4, var_4.open_with_list)

	GameHallScene = var_3_5
	var_3_5.open_with_list = false
	findTF = var_3_5
	arg_3_0.exchangePanelTf = var_3_5(arg_3_0._tf, "ad/exchangePanel")
	findTF = var_2
	arg_3_0.parentTf = var_2(arg_3_0._tf, "ad")
	GameHallExchangePanel = var_2
	arg_3_0.exchangePanel = var_2.New(arg_3_0.exchangePanelTf, arg_3_0.parentTf, arg_3_0)

	arg_3_0:openExchangePanel(false)
	arg_3_0:changeTitle(false)

	Application = var_2

	local var_3_6

	if not var_2.targetFrameRate then
		var_3_6 = 60
	end

	if 60 < var_3_6 then
		var_3_6 = 60
	end

	Timer = var_3
	arg_3_0.timer = var_3.New(function()
		local var_7_0 = arg_3_0

		var_0.onTimer(var_7_0)

		return
	end, 1 / var_3_6, -1)

	local var_3_7 = arg_3_0.timer

	var_3.Start(var_3_7)
	arg_3_0:updateUI()

	return
end

function var_0_1.initTopUI(arg_8_0)
	findTF = var_1_10001
	arg_8_0.btnBack = var_1_10001(arg_8_0._tf, "ad/topPanel/btnBack")
	findTF = var_1
	arg_8_0.btnHome = var_1(arg_8_0._tf, "ad/topPanel/btnHome")
	findTF = var_1
	arg_8_0.btnHelp = var_1(arg_8_0._tf, "ad/topPanel/btnHelp")
	findTF = var_1
	arg_8_0.btnCoin = var_1(arg_8_0._tf, "ad/topPanel/coin")
	findTF = var_1
	arg_8_0.textCoin = var_1(arg_8_0._tf, "ad/topPanel/coin/text")
	pg = var_1
	arg_8_0.coinMax = var_1.gameset.game_coin_max.key_value
	findTF = var_1
	arg_8_0.textCoinMaxTF = var_1(arg_8_0._tf, "ad/topPanel/coin/max")
	setText = var_1

	var_1(arg_8_0.textCoinMaxTF, "MAX:" .. arg_8_0.coinMax)

	onButton = var_1

	var_1(arg_8_0, arg_8_0.btnCoin, function()
		local var_9_0 = arg_8_0

		var_0.openExchangePanel(var_9_0, true)

		return
	end)

	onButton = var_1

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.btnBack

	local function var_8_2()
		local var_10_0 = arg_8_0.listPanel

		if var_0.getVisible(var_10_0) then
			local var_10_1 = arg_8_0.listPanel

			var_0.setVisible(var_10_1, false)

			local var_10_2 = arg_8_0

			var_0.changeTitle(var_10_2, false)

			pg = var_0

			local var_10_3 = var_0.SystemGuideMgr.GetInstance()

			var_0.Play(var_10_3, arg_8_0)

			return
		end

		local var_10_4 = arg_8_0

		var_0.closeView(var_10_4)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.btnHome

	local function var_8_5()
		local var_11_0 = arg_8_0

		var_0.quickExitFunc(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.btnHelp

	local function var_8_8()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_12_2.type = var_2_10003
		pg = var_2_10003
		var_12_2.helps = var_2_10003.gametip.game_room_help.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_8_6, var_8_7, var_8_8, var_1_10005)

	return
end

function var_0_1.openExchangePanel(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.exchangePanel

	var_2.setVisible(var_13_0, arg_13_1)

	return
end

function var_0_1.ResUISettings(arg_14_0)
	local var_14_0 = {}

	bit = var_1_10002

	local var_14_1 = var_1_10002.bor

	PlayerResUI = var_1_10003

	local var_14_2 = var_1_10003.TYPE_OIL

	PlayerResUI = var_1_10004
	var_14_0.showType = var_14_1(var_14_2, var_1_10004.TYPE_GOLD)

	return var_14_0
end

function var_0_1.initHomeUI(arg_15_0)
	findTF = var_1_10001
	arg_15_0.btnShop = var_1_10001(arg_15_0._tf, "ad/btnShop")
	findTF = var_1
	arg_15_0.btnPlay = var_1(arg_15_0._tf, "ad/btnPlay")
	onButton = var_1

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.btnPlay

	local function var_15_2()
		local var_16_0 = arg_15_0.listPanel

		var_0.setVisible(var_16_0, true)

		local var_16_1 = arg_15_0

		var_0.changeTitle(var_16_1, true)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_15_0, var_15_1, var_15_2, var_1_10005)

	onButton = var_1

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.btnShop

	local function var_15_5()
		local var_17_0 = arg_15_0
		local var_17_1 = var_0.emit

		GameHallMediator = var_2_10002

		var_17_1(var_17_0, var_2_10002.OPEN_GAME_SHOP)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_15_3, var_15_4, var_15_5, var_1_10005)

	findTF = var_1
	arg_15_0.topShop = var_1(arg_15_0._tf, "ad/container/content/top/btnShop")
	findTF = var_1
	arg_15_0.topGame = var_1(arg_15_0._tf, "ad/container/content/top/btnGameList")
	onButton = var_1

	local var_15_6 = arg_15_0
	local var_15_7 = arg_15_0.topGame

	local function var_15_8()
		local var_18_0 = arg_15_0.listPanel

		var_0.setVisible(var_18_0, true)

		local var_18_1 = arg_15_0

		var_0.changeTitle(var_18_1, true)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_15_6, var_15_7, var_15_8, var_1_10005)

	onButton = var_1

	local var_15_9 = arg_15_0
	local var_15_10 = arg_15_0.topShop

	local function var_15_11()
		local var_19_0 = arg_15_0
		local var_19_1 = var_0.emit

		GameHallMediator = var_2_10002

		var_19_1(var_19_0, var_2_10002.OPEN_GAME_SHOP)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_15_9, var_15_10, var_15_11, var_1_10005)

	return
end

function var_0_1.updateUI(arg_20_0)
	getProxy = var_1_10001
	GameRoomProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)
	local var_20_1 = var_1.getWeekly(var_20_0)

	setActive = var_20_0

	var_20_0(arg_20_0.freeCoinTf, var_20_1)

	getProxy = var_20_0
	GameRoomProxy = var_3

	local var_20_2 = var_20_0(var_3)
	local var_20_3 = var_2.getCoin(var_20_2)

	setText = var_20_2

	var_20_2(arg_20_0.textCoin, var_20_3)

	return
end

function var_0_1.onTimer(arg_21_0)
	local var_21_0 = arg_21_0.charController

	var_1.step(var_21_0)

	return
end

function var_0_1.changeTitle(arg_22_0, arg_22_1)
	setActive = var_1_10002
	findTF = var_1_10003

	var_1_10002(var_1_10003(arg_22_0._tf, "ad/topPanel/title_list"), arg_22_1)

	setActive = var_1_10002
	findTF = var_3

	var_1_10002(var_3(arg_22_0._tf, "ad/topPanel/title_main"), not arg_22_1)

	return
end

function var_0_1.onBackPressed(arg_23_0)
	local var_23_0 = arg_23_0.listPanel

	if var_1.getVisible(var_23_0) then
		local var_23_1 = arg_23_0.listPanel

		var_1.setVisible(var_23_1, false)
		arg_23_0:changeTitle(false)

		return
	end

	local var_23_2 = arg_23_0.exchangePanel

	if var_1.getVisible(var_23_2) then
		local var_23_3 = arg_23_0.exchangePanel

		var_1.setVisible(var_23_3, false)

		return
	end

	arg_23_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

function var_0_1.willExit(arg_24_0)
	local var_24_0 = arg_24_0.charController

	var_1.Dispose(var_24_0)

	if arg_24_0.timer then
		local var_24_1 = arg_24_0.timer

		var_1.Stop(var_24_1)

		arg_24_0.timer = nil
	end

	local var_24_2 = arg_24_0.listPanel

	if var_1.getVisible(var_24_2) then
		GameHallScene = var_1
		var_1.open_with_list = true
	end

	local var_24_3 = arg_24_0.exchangePanel

	var_1.dispose(var_24_3)

	local var_24_4 = arg_24_0.listPanel

	var_1.dispose(var_24_4)

	return
end

return var_0_1
