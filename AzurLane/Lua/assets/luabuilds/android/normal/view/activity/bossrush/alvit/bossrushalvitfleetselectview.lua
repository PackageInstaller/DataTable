class = var_0_10000

local var_0_0 = "BossRushAlvitFleetSelectView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.BossRush.BossRushFleetSelectView"))

function var_0_1.GetTextColor(arg_1_0)
	Color = var_1_10001

	local var_1_0 = var_1_10001.NewHex("1C231F")

	Color = var_2

	local var_1_1 = var_2.NewHex("979A98")
end

function var_0_1.getUIName(arg_2_0)
	return "BossRushAlvitFleetSelectUI"
end

function var_0_1.tempCache(arg_3_0)
	return true
end

function var_0_1.didEnter(arg_4_0)
	var_0_1.super.didEnter(arg_4_0)

	removeOnButton = var_1

	local var_4_0 = arg_4_0._tf

	var_1(var_2.Find(var_4_0, "BG"))

	onButton = var_1

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_3.Find(var_4_2, "BG/close")

	local function var_4_4()
		local var_5_0 = arg_4_0

		var_0.onCancelHard(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_4_1, var_4_3, var_4_4, var_5)

	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_1.GetComponent

	typeof = var_4_3
	Animation = var_4_4
	arg_4_0.anim = var_4_6(var_4_5, var_4_3(var_4_4))

	local var_4_7 = arg_4_0.anim
	local var_4_8 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4_4
	arg_4_0.animEvent = var_4_8(var_4_7, var_3(var_4_4))

	local var_4_9 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_9, function()
		var_0_1.super.onCancelHard(arg_4_0)

		return
	end)

	return
end

function var_0_1.onCancelHard(arg_7_0)
	local var_7_0 = arg_7_0.anim

	var_1.Play(var_7_0, "anim_kinder_fleetselect_out")

	return
end

return var_0_1
