class = var_0_10000

local var_0_0 = "LittleRenownRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.heartTpl = var_1.Find(var_1_0, "HeartTpl")

	local var_1_1 = arg_1_0.bg

	arg_1_0.heartContainer = var_1.Find(var_1_1, "HeartContainer")
	UIItemList = var_1
	arg_1_0.heartUIItemList = var_1.New(arg_1_0.heartContainer, arg_1_0.heartTpl)

	local var_1_2 = arg_1_0.heartUIItemList

	var_1.make(var_1_2, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_2_1 + 1
			local var_2_1 = arg_1_0.ptData
			local var_2_2 = var_4.GetLevelProgress(var_2_1)
			local var_2_3 = arg_2_2:Find("Full")

			setActive = var_2_1

			var_2_1(var_2_3, not (var_2_2 < var_2_0))
		end

		return
	end)

	local var_1_3 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_3, "help_btn")
	onButton = var_1

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.helpBtn

	local function var_1_6()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_3_2.type = var_2_10004
		pg = var_2_10004
		var_3_2.helps = var_2_10004.gametip.littleRenown_npc.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_4, var_1_5, var_1_6, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	var_0_1.super.OnUpdateFlush(arg_4_0)

	local var_4_0 = arg_4_0.ptData
	local var_4_1, var_4_2 = var_1.GetLevelProgress(var_4_0)
	local var_4_3 = arg_4_0.heartUIItemList

	var_3.align(var_4_3, var_4_2)

	return
end

function var_0_1.OnFirstFlush(arg_5_0)
	var_0_1.super.OnFirstFlush(arg_5_0)

	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.battleBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_6_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_6_1(var_6_0, var_6_2, var_2_10004.LEVEL)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_0, var_5_1, var_5_2, var_1_10006)

	return
end

return var_0_1
