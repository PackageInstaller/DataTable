class = var_0_10000

local var_0_0 = "AnniversaryIslandAwardLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryIslandAwardUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.window = var_1.Find(var_2_0, "Window")
	setText = var_1

	local var_2_1 = arg_2_0.window
	local var_2_2 = var_2.Find(var_2_1, "Text")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("expedition_award_tip"))

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.window
	local var_3_2 = var_3.Find(var_3_1, "Receive")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	var_1_10001(var_3_4, var_3.Find(var_3_5, "BG"), function()
		local var_5_0 = arg_3_0

		var_0.onBackPressed(var_5_0)

		return
	end)

	_ = var_1_10001

	local var_3_6 = var_1_10001.select
	local var_3_7

	if not arg_3_0.contextData.items then
		var_3_7 = {}
	end

	arg_3_0.awards = var_3_6(var_3_7, function(arg_6_0)
		local var_6_0 = arg_6_0.type

		DROP_TYPE_ICON_FRAME = var_2_10002

		if var_6_0 ~= var_2_10002 then
			local var_6_1 = arg_6_0.type

			DROP_TYPE_CHAT_FRAME = var_2_10002

			if var_6_1 ~= var_2_10002 then
				local var_6_2 = arg_6_0.type

				DROP_TYPE_LIVINGAREA_COVER = var_2_10002

				local var_6_3

				if var_6_2 == var_2_10002 then
					var_6_3 = false
				else
					var_6_3 = true
				end

				return var_6_3
			end
		end
	end)
	UIItemList = var_1

	local var_3_8 = var_1.StaticAlign
	local var_3_9 = arg_3_0.window
	local var_3_10 = var_3.Find(var_3_9, "Materials")
	local var_3_11 = arg_3_0.window
	local var_3_12 = var_4.Find(var_3_11, "Materials")

	var_3_8(var_3_10, var_4.GetChild(var_3_12, 0), #arg_3_0.awards, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 ~= var_0.EventUpdate then
			return
		end

		local var_7_0 = arg_3_0.awards[arg_7_1 + 1]

		AnniversaryIslandComposite2023Scene = var_4

		var_4.UpdateActivityDrop(arg_3_0, arg_7_2:Find("Icon"), var_7_0)

		onButton = var_4

		var_4(arg_3_0, arg_7_2:Find("Icon"), function()
			local var_8_0 = arg_3_0

			var_0.emit(var_8_0, var_0_1.ON_DROP, var_7_0)

			return
		end)

		setText = var_4

		var_4(arg_7_2:Find("Text"), var_7_0.count)

		return
	end)

	pg = var_3_8

	local var_3_13 = var_3_8.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_13, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_9_0)
	local var_9_0 = arg_9_0.loader

	var_1.Clear(var_9_0)

	pg = var_1

	local var_9_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_1, arg_9_0._tf)

	return
end

return var_0_1
