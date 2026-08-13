class = var_0_10000

local var_0_0 = "MainPlayerInfoBtn4Mellow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainPlayerInfoBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	findTF = var_3
	arg_1_0.playerInfoBtn = var_3(arg_1_0._tf, "name_bg")
	findTF = var_3

	local var_1_0 = var_3(arg_1_0._tf, "name_bg/Text")
	local var_1_1 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.playerNameTxt = var_1_1(var_1_0, var_5(var_6))
	findTF = var_3
	arg_1_0.playerLevelTr = var_3(arg_1_0._tf, "name_bg/level/Text")
	findTF = var_3

	local var_1_2 = var_3(arg_1_0._tf, "name_bg/level/Text")
	local var_1_3 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.playerLevelTxt = var_1_3(var_1_2, var_5(var_6))
	findTF = var_3

	local var_1_4 = var_3(arg_1_0._tf, "name_bg/level/mask/Text")
	local var_1_5 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.expTxt = var_1_5(var_1_4, var_5(var_6))
	findTF = var_3

	local var_1_6 = var_3(arg_1_0._tf, "res/gold/max")
	local var_1_7 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.goldMax = var_1_7(var_1_6, var_5(var_6))
	findTF = var_3

	local var_1_8 = var_3(arg_1_0._tf, "res/gold/Text")
	local var_1_9 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.goldValue = var_1_9(var_1_8, var_5(var_6))
	findTF = var_3

	local var_1_10 = var_3(arg_1_0._tf, "res/oil/max")
	local var_1_11 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.oilMax = var_1_11(var_1_10, var_5(var_6))
	findTF = var_3

	local var_1_12 = var_3(arg_1_0._tf, "res/oil/Text")
	local var_1_13 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.oilValue = var_1_13(var_1_12, var_5(var_6))
	findTF = var_3

	local var_1_14 = var_3(arg_1_0._tf, "res/gem/Text")
	local var_1_15 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.gemValue = var_1_15(var_1_14, var_5(var_6))
	findTF = var_3
	arg_1_0.expTr = var_3(arg_1_0._tf, "name_bg/level/mask")
	onButton = var_3

	local var_1_16 = arg_1_0

	findTF = var_5

	local var_1_17 = var_5(arg_1_0._tf, "res/gold")

	local function var_1_18()
		pg = var_2_10000

		local var_2_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_2_0)

		return
	end

	SFX_PANEL = var_7

	var_3(var_1_16, var_1_17, var_1_18, var_7)

	onButton = var_3

	local var_1_19 = arg_1_0

	findTF = var_1_17

	local var_1_20 = var_1_17(arg_1_0._tf, "res/oil")

	local function var_1_21()
		pg = var_2_10000

		local var_3_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_3_0)

		return
	end

	SFX_PANEL = var_7

	var_3(var_1_19, var_1_20, var_1_21, var_7)

	onButton = var_3

	local var_1_22 = arg_1_0

	findTF = var_1_20

	local var_1_23 = var_1_20(arg_1_0._tf, "res/gem")

	local function var_1_24()
		pg = var_2_10000

		local var_4_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_4_0)

		return
	end

	SFX_PANEL = var_7

	var_3(var_1_22, var_1_23, var_1_24, var_7)

	local var_1_25 = arg_1_0
	local var_1_26 = arg_1_0.bind

	PlayerProxy = var_1_23

	var_1_26(var_1_25, var_1_23.UPDATED, function()
		local var_5_0 = arg_1_0

		var_0.Flush(var_5_0)

		return
	end)

	local var_1_27 = arg_1_0
	local var_1_28 = arg_1_0.bind

	GAME = var_5

	var_1_28(var_1_27, var_5.GUILD_GET_USER_INFO_DONE, function()
		local var_6_0 = arg_1_0

		var_0.Flush(var_6_0)

		return
	end)

	local var_1_29 = arg_1_0
	local var_1_30 = arg_1_0.bind

	GAME = var_5

	var_1_30(var_1_29, var_5.GET_PUBLIC_GUILD_USER_DATA_DONE, function()
		local var_7_0 = arg_1_0

		var_0.Flush(var_7_0)

		return
	end)

	return
end

function var_0_1.Flush(arg_8_0, arg_8_1)
	var_0_1.super.Flush(arg_8_0, arg_8_1)
	arg_8_0:UpdateRes()

	return
end

function var_0_1.UpdateRes(arg_9_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.getRawData(var_9_0)

	PlayerResUI = var_9_0

	var_9_0.StaticFlush(var_9_1, arg_9_0.goldMax, arg_9_0.goldValue, arg_9_0.oilMax, arg_9_0.oilValue, arg_9_0.gemValue)

	return
end

function var_0_1.UpdateExp(arg_10_0)
	local var_10_0 = 0

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_10_1 = var_1_10002(var_1_10003)
	local var_10_2 = var_2.getRawData(var_10_1)

	arg_10_0.playerLevelTxt.text = var_10_2.level
	arg_10_0.expTxt.text = var_10_2.level

	local var_10_3 = var_10_2.level
	local var_10_4 = var_10_2

	if var_10_3 == var_10_2.getMaxLevel(var_10_4) then
		var_10_0 = 1
	else
		getConfigFromLevel1 = var_10_3
		pg = var_4

		local var_10_5 = var_10_3(var_4.user_level, var_10_2.level)

		var_10_0 = var_10_2.exp / var_10_5.exp_interval
	end

	local var_10_6 = 34 * var_10_0
	local var_10_7 = arg_10_0.expTr

	Vector2 = var_10_4
	var_10_7.sizeDelta = var_10_4(70, var_10_6)

	return
end

function var_0_1.Dispose(arg_11_0)
	var_0_1.super.Dispose(arg_11_0)

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_11_0)

	return
end

return var_0_1
