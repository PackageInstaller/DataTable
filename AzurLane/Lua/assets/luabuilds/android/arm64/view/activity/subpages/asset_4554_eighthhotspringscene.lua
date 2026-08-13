class = var_0_10000

local var_0_0 = "EighthHotSpringScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.NewYearFestival.NewYearHotSpringScene"))

function var_0_1.getUIName(arg_1_0)
	return "EighthHotSpringUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	return
end

function var_0_1.didEnter(arg_3_0)
	var_0_1.super.didEnter(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "Top/Help")

	local function var_3_3()
		MsgboxMediator = var_2_10000

		local var_4_0 = var_2_10000.ShowMsgBox
		local var_4_1 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_4_1.type = var_2_10003
		pg = var_2_10003
		var_4_1.helps = var_2_10003.gametip.eighth_tip_spring.tip
		var_4_1.contextSprites = {
			{
				path = "props/eighthwenquanshoupai",
				name = "eighthwenquanshoupai"
			}
		}

		var_4_0(var_4_1)

		return
	end

	SFX_PANEL = var_3_1

	var_1(var_3_0, var_3_2, var_3_3, var_3_1)

	setImageSprite = var_1

	local var_3_4 = arg_3_0.top
	local var_3_5 = var_3.Find(var_3_4, "Ticket/Icon")

	LoadSprite = var_3_2

	var_1(var_3_5, var_3_2("props/eighthwenquanshoupai", "eighthwenquanshoupai"))

	return
end

function var_0_1.willExit(arg_5_0)
	var_0_1.super.willExit(arg_5_0)

	return
end

return var_0_1
