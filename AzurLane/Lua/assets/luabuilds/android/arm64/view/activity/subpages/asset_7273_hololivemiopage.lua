class = var_0_10000

local var_0_0 = "HoloLiveMioPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.heartTpl = var_1.Find(var_1_0, "HeartTpl")

	local var_1_1 = arg_1_0.bg

	arg_1_0.heartContainer = var_1.Find(var_1_1, "HeartContainer")

	local var_1_2 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_2, "HelpBtn")
	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.helpBtn

	local function var_1_5()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_2_2.type = var_2_10004
		pg = var_2_10004
		var_2_2.helps = var_2_10004.gametip.hololive_dashenling.tip

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_3, var_1_4, var_1_5, var_1_10006)

	UIItemList = var_1
	arg_1_0.heartUIItemList = var_1.New(arg_1_0.heartContainer, arg_1_0.heartTpl)

	local var_1_6 = arg_1_0.heartUIItemList

	var_1.make(var_1_6, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_3_1 + 1
			local var_3_1 = arg_1_0.ptData
			local var_3_2 = var_4.GetLevelProgress(var_3_1)
			local var_3_3 = arg_3_2:Find("Full")

			setActive = var_3_1

			var_3_1(var_3_3, not (var_3_2 < var_3_0))
		end

		return
	end)

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

return var_0_1
