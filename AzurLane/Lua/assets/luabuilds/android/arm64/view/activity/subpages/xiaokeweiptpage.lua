class = var_0_10000

local var_0_0 = "XiaoKeWeiPtPage"

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

	local var_1_4 = arg_1_0._tf

	arg_1_0.helpBtn = var_1.Find(var_1_4, "AD/help_btn")

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

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.helpBtn

	local function var_2_5()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_4_2.type = var_2_10004
		pg = var_2_10004
		var_4_2.helps = var_2_10004.gametip.gametip_xiaokewei.tip

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	var_0_1.super.OnUpdateFlush(arg_5_0)

	local var_5_0 = arg_5_0.ptData
	local var_5_1, var_5_2, var_5_3 = var_1.GetLevelProgress(var_5_0)
	local var_5_4 = arg_5_0.hearts

	var_4.make(var_5_4, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_6_2, arg_6_1 < arg_5_0.ptData.level)
		end

		return
	end)

	local var_5_5 = arg_5_0.hearts

	var_4.align(var_5_5, var_5_2)

	return
end

return var_0_1
