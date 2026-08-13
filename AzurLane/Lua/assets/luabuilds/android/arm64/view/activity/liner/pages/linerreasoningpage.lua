class = var_0_10000

local var_0_0 = "LinerReasoningPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LinerReasoningPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.titleTF = var_1.Find(var_2_0, "clues/title")
	setText = var_1

	local var_2_1 = arg_2_0.titleTF

	i18n = var_4

	var_1(var_2_1, var_4("liner_event_reasoning_title"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.eventNameTF = var_1.Find(var_2_2, "clues/name")

	local var_2_3 = arg_2_0._tf

	arg_2_0.cluesTF = var_1.Find(var_2_3, "clues/content")

	local var_2_4 = arg_2_0._tf

	arg_2_0.optionsTF = var_1.Find(var_2_4, "options")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "clues/reasoning_title")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Image = var_6

	local var_2_8 = var_2_7(var_2_6, var_4(var_6))

	var_1.SetNativeSize(var_2_8)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "mask")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	UIItemList = var_1_10001

	local var_3_4 = var_1_10001.New
	local var_3_5 = arg_3_0.cluesTF
	local var_3_6 = arg_3_0.cluesTF

	arg_3_0.cluesUIList = var_3_4(var_3_5, var_4.Find(var_3_6, "tpl"))

	local var_3_7 = arg_3_0.cluesUIList

	var_1.make(var_3_7, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_5_1 + 1
			local var_5_1 = arg_3_0.clues[var_5_0]

			setText = var_2_10005

			var_2_10005(arg_5_2:Find("index/Text"), var_5_1:GetTitle())

			setText = var_2_10005

			var_2_10005(arg_5_2:Find("Text"), var_5_1:GetReasoningDesc())
		end

		return
	end)

	UIItemList = var_1

	local var_3_8 = var_1.New
	local var_3_9 = arg_3_0.optionsTF
	local var_3_10 = arg_3_0.optionsTF

	arg_3_0.optionsUIList = var_3_8(var_3_9, var_4.Find(var_3_10, "tpl"))

	local var_3_11 = arg_3_0.optionsUIList

	var_1.make(var_3_11, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_6_1 + 1

			setText = var_2_10004

			var_2_10004(arg_6_2:Find("Text"), arg_3_0.options[var_6_0])

			onButton = var_2_10004

			local var_6_1 = arg_3_0
			local var_6_2 = arg_6_2

			local function var_6_3()
				local var_7_0 = arg_3_0
				local var_7_1 = var_0.emit

				LinerLogBookMediator = var_3_10003

				local var_7_2 = var_3_10003.GET_EVENT_AWARD
				local var_7_3 = arg_3_0.actId
				local var_7_4 = arg_3_0.groupIdx
				local var_7_5 = var_6_0
				local var_7_6 = arg_3_0.eventGroup

				var_7_1(var_7_0, var_7_2, var_7_3, var_7_4, var_7_5, var_7.GetDrop(var_7_6))

				local var_7_7 = arg_3_0

				var_0.Hide(var_7_7)

				return
			end

			SFX_CONFIRM = var_9

			var_2_10004(var_6_1, var_6_2, var_6_3, var_9)
		end

		return
	end)

	return
end

function var_0_1.ShowOptions(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.actId = arg_8_1
	arg_8_0.groupIdx = arg_8_2
	pg = var_1_10003

	local var_8_0 = var_1_10003.activity_template[arg_8_0.actId].config_data[3][arg_8_0.groupIdx]

	LinerEventGroup = var_4
	arg_8_0.eventGroup = var_4.New(var_8_0)
	setText = var_4

	local var_8_1 = arg_8_0.eventNameTF
	local var_8_2 = arg_8_0.eventGroup

	var_4(var_8_1, var_7.GetTitle(var_8_2))

	local var_8_3 = arg_8_0.eventGroup

	arg_8_0.clues = var_4.GetEventList(var_8_3)

	local var_8_4 = arg_8_0.eventGroup

	arg_8_0.options = var_4.GetConclusions(var_8_4)

	local var_8_5 = arg_8_0.cluesUIList

	var_4.align(var_8_5, #arg_8_0.clues)
	arg_8_0:Show()

	local var_8_6 = {}

	for iter_8_0 = 1, #arg_8_0.options do
		table = var_8_2

		var_8_2.insert(var_8_6, function(arg_9_0)
			local var_9_0 = arg_8_0
			local var_9_1 = var_1.managedTween

			LeanTween = var_2_10004

			var_9_1(var_9_0, var_2_10004.delayedCall, function()
				local var_10_0 = arg_8_0.optionsUIList

				var_0.align(var_10_0, iter_8_0)
				arg_9_0()

				return
			end, 0.066, nil)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_8_6, function()
		return
	end)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1
