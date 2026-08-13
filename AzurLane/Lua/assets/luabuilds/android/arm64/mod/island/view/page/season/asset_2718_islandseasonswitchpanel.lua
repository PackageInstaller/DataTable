class = var_0_10000

local var_0_0 = "IslandSeasonSwitchPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSeasonSwitchPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_0, "frame")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "frame/filter_panel/list/content")
	local var_2_4 = arg_2_0._tf

	arg_2_0.uiList = var_2_1(var_2_3, var_4.Find(var_2_4, "frame/filter_panel/list/content/tpl"))

	local var_2_5 = arg_2_0._tf

	arg_2_0.selectorPanel = var_1.Find(var_2_5, "frame/filter_panel")

	local var_2_6 = arg_2_0._tf

	arg_2_0.fliterBtn = var_1.Find(var_2_6, "frame/filter")

	local var_2_7 = arg_2_0.fliterBtn
	local var_2_8 = var_1.Find(var_2_7, "Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_2_4
	arg_2_0.filterTxt = var_2_9(var_2_8, var_4(var_2_4))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.fliterBtn

	local function var_3_2()
		arg_3_0.isOpen = not arg_3_0.isOpen

		local var_4_0 = arg_3_0

		var_0.UpdateSelector(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	local var_3_3 = arg_3_0.uiList

	var_1.make(var_3_3, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			local var_5_0 = arg_3_0

			var_3.UpdateItem(var_5_0, arg_5_1, arg_5_2)
		end

		return
	end)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.callback = arg_6_2
	arg_6_0.isOpen = false

	arg_6_0:UpdateSelector()

	pg = var_3

	local var_6_0 = var_3.island_season[arg_6_1].name_short

	arg_6_0.filterTxt.text = var_6_0

	return
end

function var_0_1.UpdateSelector(arg_7_0)
	if arg_7_0.isOpen then
		IslandSeasonAgency = var_7_0

		local var_7_0 = var_7_0.GetCurrentSeason() - 1
		local var_7_1 = arg_7_0.uiList

		var_2.align(var_7_1, var_7_0 or 0)
	end

	setActive = var_7_0

	var_7_0(arg_7_0.selectorPanel, arg_7_0.isOpen)

	return
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)

	if arg_8_0.isOpen then
		arg_8_0.isOpen = false

		arg_8_0:UpdateSelector()
	end

	return
end

function var_0_1.UpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1 + 1

	pg = var_1_10004

	local var_9_1 = var_1_10004.island_season[var_9_0].name_short

	setText = var_1_10005

	var_1_10005(arg_9_2, var_9_1)

	onButton = var_1_10005

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_2

	local function var_9_4()
		arg_9_0.filterTxt.text = var_9_1

		if arg_9_0.callback then
			arg_9_0.callback(var_9_0)
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_1_10005(var_9_2, var_9_3, var_9_4, var_1_10010)

	return
end

return var_0_1
