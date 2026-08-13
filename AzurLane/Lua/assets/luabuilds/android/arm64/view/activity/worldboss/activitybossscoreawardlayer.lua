class = var_0_10000

local var_0_0 = "ActivityBossScoreAwardLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ActivitybonusWindow_nonPt"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "window/panel/list")
	local var_2_4 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_1(var_2_3, var_4.Find(var_2_4, "window/panel/list/item"))

	local var_2_5 = arg_2_0.uiItemList

	var_1.make(var_2_5, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0

			var_3.UpdateItem(var_3_0, arg_3_1, arg_3_2)
		end

		return
	end)

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "window/pt/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_2_4
	arg_2_0.currentTxt = var_2_8(var_2_7, var_4(var_2_4))
	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "window/top/bg/infomation")

	i18n = var_4

	var_1(var_2_10, var_4("world_expedition_reward_display"))

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "window/pt/title")

	i18n = var_4

	var_1(var_2_12, var_4("activityboss_sp_window_best_score"))

	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "window/panel/list/item/target/title")

	i18n = var_4

	var_1(var_2_14, var_4("activityboss_sp_score_target"))

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.closeBtn

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)
	arg_4_0:Flush()

	pg = var_1

	local var_4_6 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_6, arg_4_0._tf)

	return
end

function var_0_1.Flush(arg_7_0, arg_7_1)
	arg_7_0.awards = arg_7_0.contextData.awards
	arg_7_0.targets = arg_7_0.contextData.targets
	arg_7_0.score = arg_7_0.contextData.score

	local var_7_0 = arg_7_0.uiItemList

	var_2.align(var_7_0, #arg_7_0.awards)

	arg_7_0.currentTxt.text = arg_7_0.score

	return
end

function var_0_1.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.awards[arg_8_1 + 1]
	local var_8_1 = arg_8_0.targets[arg_8_1 + 1]
	local var_8_2 = arg_8_2:Find("award")
	local var_8_3 = {
		type = var_8_0[1],
		id = var_8_0[2],
		count = var_8_0[3]
	}

	updateDrop = var_7

	var_7(var_8_2, var_8_3)

	onButton = var_7

	local var_8_4 = arg_8_0
	local var_8_5 = var_8_2

	local function var_8_6()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		BaseUI = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_DROP, var_8_3)

		return
	end

	SFX_PANEL = var_1_10012

	var_7(var_8_4, var_8_5, var_8_6, var_1_10012)

	setActive = var_7

	var_7(arg_8_2:Find("award/mask"), var_8_1 <= arg_8_0.score)

	setText = var_7

	var_7(arg_8_2:Find("target/Text"), var_8_1)

	setText = var_7

	var_7(arg_8_2:Find("title/Text"), "PHASE  " .. arg_8_1 + 1)

	return
end

function var_0_1.Hide(arg_10_0)
	arg_10_0:closeView()

	return
end

function var_0_1.willExit(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf)

	return
end

return var_0_1
