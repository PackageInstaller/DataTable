class = var_0_10000

local var_0_0 = "MainMallBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_3)

	findTF = var_4
	arg_1_0.sellTag = var_4(arg_1_2, "sell")
	findTF = var_4
	arg_1_0.skinTag = var_4(arg_1_2, "skin")
	findTF = var_4
	arg_1_0.mallTip = var_4(arg_1_2, "tip")

	return
end

function var_0_1.OnClick(arg_2_0)
	arg_2_0:OpenMall()

	return
end

function var_0_1.OpenMall(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NewMainMediator = var_1_10003

	local var_3_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_3_1(var_3_0, var_3_2, var_1_10004.NEW_SHOP)

	isActive = var_3_1

	local var_3_3

	if not var_3_1(arg_3_0.sellTag) then
		isActive = var_3_3

		if not var_3_3(arg_3_0.skinTag) then
			isActive = var_3_3
			var_3_3 = var_3_3(arg_3_0.mallTip)
		end
	end

	pg = var_2

	local var_3_4 = var_2.m02
	local var_3_5 = var_2.sendNotification

	GAME = var_4

	local var_3_6 = var_4.TRACK

	TrackConst = var_1_10005

	local var_3_7 = var_1_10005.GetTrackData

	TrackConst = var_1_10006

	local var_3_8 = var_1_10006.SYSTEM_SHOP

	TrackConst = var_1_10007

	var_3_5(var_3_4, var_3_6, var_3_7(var_3_8, var_1_10007.ACTION_ENTER_MAIN, var_3_3))

	PlayerPrefs = var_3_5

	var_3_5.SetInt("Tec_Ship_Gift_Enter_Tag", 1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

return var_0_1
