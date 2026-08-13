class = var_0_10000

local var_0_0 = "IslandOrderTendencyPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.msgbox.window.IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandOrderTendencyUI"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = {}

	IslandOrderSlot = var_1_10002

	local var_2_1 = var_1_10002.TENDENCY_TYPE_COMMON
	local var_2_2 = arg_2_0._tf

	var_2_0[var_2_1] = var_3.Find(var_2_2, "toggle/1")
	IslandOrderSlot = var_2_1

	local var_2_3 = var_2_1.TENDENCY_TYPE_EASY
	local var_2_4 = arg_2_0._tf

	var_2_0[var_2_3] = var_3.Find(var_2_4, "toggle/0")
	IslandOrderSlot = var_2_3

	local var_2_5 = var_2_3.TENDENCY_TYPE_HARD
	local var_2_6 = arg_2_0._tf

	var_2_0[var_2_5] = var_3.Find(var_2_6, "toggle/2")
	arg_2_0.toggles = var_2_0
	setText = var_2_0

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "toggle/0/Text")

	i18n = var_1_10004

	var_2_0(var_2_8, var_1_10004("island_order_difficulty_2"))

	setText = var_2_0

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "toggle/1/Text")

	i18n = var_4

	var_2_0(var_2_10, var_4("island_order_difficulty_1"))

	setText = var_2_0

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "toggle/2/Text")

	i18n = var_4

	var_2_0(var_2_12, var_4("island_order_difficulty_3"))

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		if arg_3_0.onYes then
			arg_3_0.onYes(arg_3_0.selectedIndex)
		end

		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.OnShow(arg_5_0)
	var_0_1.super.OnShow(arg_5_0)

	local var_5_0

	if not arg_5_0.settings.selected then
		IslandOrderSlot = var_5_0
		var_5_0 = var_5_0.TENDENCY_TYPE_COMMON
	end

	arg_5_0.selectedIndex = var_5_0

	arg_5_0:FlushToggles()

	return
end

function var_0_1.OnHide(arg_6_0)
	var_0_1.super.OnHide(arg_6_0)

	arg_6_0.settings = nil

	return
end

function var_0_1.FlushToggles(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.toggles) do
		onToggle = var_1_10006

		local var_7_0 = arg_7_0
		local var_7_1 = iter_7_1

		local function var_7_2(arg_8_0)
			if arg_8_0 then
				arg_7_0.selectedIndex = iter_7_0

				local var_8_0 = arg_7_0

				var_1.UpdateContent(var_8_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_7_0, var_7_1, var_7_2, var_1_10011)
	end

	triggerToggle = var_1

	var_1(arg_7_0.toggles[arg_7_0.selectedIndex], true)

	return
end

function var_0_1.UpdateContent(arg_9_0)
	IslandOrderSlot = var_1_10001

	local var_9_0 = var_1_10001.TENDENCY2TIP(arg_9_0.selectedIndex)

	arg_9_0.contentTxt.text = var_9_0

	return
end

return var_0_1
