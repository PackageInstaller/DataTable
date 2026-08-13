class = var_0_10000

local var_0_0 = "HoloLivePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.listbtn = var_1.Find(var_1_1, "list")

	local var_1_2 = arg_1_0.listbtn

	arg_1_0.btnFubuki = var_1.Find(var_1_2, "1")

	local var_1_3 = arg_1_0.listbtn

	arg_1_0.btnBattle = var_1.Find(var_1_3, "2")

	local var_1_4 = arg_1_0.listbtn

	arg_1_0.btnSora = var_1.Find(var_1_4, "3")

	local var_1_5 = arg_1_0.listbtn

	arg_1_0.btnShion = var_1.Find(var_1_5, "4")

	local var_1_6 = arg_1_0.listbtn

	arg_1_0.btnMio = var_1.Find(var_1_6, "5")

	local var_1_7 = arg_1_0.listbtn

	arg_1_0.btnAqua = var_1.Find(var_1_7, "6")

	local var_1_8 = arg_1_0.listbtn

	arg_1_0.btnAyame = var_1.Find(var_1_8, "7")

	local var_1_9 = arg_1_0.listbtn

	arg_1_0.btnMatsuri = var_1.Find(var_1_9, "8")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.btnFubuki, function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.BATTLE_OPERA)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.btnBattle, function()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.btnSora, function()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.SELECT_ACTIVITY

		ActivityConst = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004.HOLOLIVE_MORNING_ID)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.btnShion, function()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_6_2 = var_2_10003.SELECT_ACTIVITY

		ActivityConst = var_2_10004

		var_6_1(var_6_0, var_6_2, var_2_10004.HOLOLIVE_PT_ID)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.btnMio, function()
		local var_7_0 = arg_2_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_7_2 = var_2_10003.SELECT_ACTIVITY

		ActivityConst = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.HOLOLIVE_MIO_ID)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.btnAqua, function()
		local var_8_0 = arg_2_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_8_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_8_1(var_8_0, var_8_2, var_2_10004.HOLOLIVE_LINKLINK_SELECT_SCENE)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.btnAyame, function()
		local var_9_0 = arg_2_0
		local var_9_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_9_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_9_1(var_9_0, var_9_2, var_2_10004.HOLOLIVE_MEDAL)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.btnMatsuri, function()
		local var_10_0 = arg_2_0
		local var_10_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_10_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_10_3 = var_2_10004.SHOP
		local var_10_4 = {}

		NewShopsScene = var_2_10006
		var_10_4.warp = var_2_10006.TYPE_ACTIVITY

		var_10_1(var_10_0, var_10_2, var_10_3, var_10_4)

		return
	end)

	return
end

return var_0_1
