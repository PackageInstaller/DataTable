class = var_0_10000

local var_0_0 = "XiaoXinNongPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	UIItemList = var_1

	local var_1_0 = var_1.New
	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_3.Find(var_1_1, "AD/heart")
	local var_1_3 = arg_1_0._tf

	arg_1_0.hearts = var_1_0(var_1_2, var_4.Find(var_1_3, "AD/heart/mark"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.battleBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	var_0_1.super.OnUpdateFlush(arg_4_0)

	local var_4_0 = arg_4_0.ptData
	local var_4_1, var_4_2, var_4_3 = var_1.GetLevelProgress(var_4_0)
	local var_4_4 = arg_4_0.ptData
	local var_4_5, var_4_6, var_4_7 = var_4.GetResProgress(var_4_4)
	local var_4_8 = arg_4_0.hearts

	var_7.make(var_4_8, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_5_2, arg_5_1 < arg_4_0.ptData.level)
		end

		return
	end)

	setText = var_7

	local var_4_9 = arg_4_0.progress

	setColorStr = var_10

	local var_4_10 = var_10(var_4_5, "#7780D3")
	local var_4_11 = "/"

	setColorStr = var_12

	var_7(var_4_9, var_4_10 .. var_4_11 .. var_12(var_4_6, "#ffffff"))

	local var_4_12 = arg_4_0.hearts

	var_7.align(var_4_12, var_4_2)

	return
end

return var_0_1
