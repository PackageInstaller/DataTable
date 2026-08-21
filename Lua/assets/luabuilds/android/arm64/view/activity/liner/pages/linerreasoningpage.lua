local var_0_0 = class("LinerReasoningPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LinerReasoningPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.titleTF = arg_2_0._tf:Find("clues/title")

	setText(arg_2_0.titleTF, i18n("liner_event_reasoning_title"))

	arg_2_0.eventNameTF = arg_2_0._tf:Find("clues/name")
	arg_2_0.cluesTF = arg_2_0._tf:Find("clues/content")
	arg_2_0.optionsTF = arg_2_0._tf:Find("options")

	arg_2_0._tf:Find("clues/reasoning_title"):GetComponent(typeof(Image)):SetNativeSize()

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("mask"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	arg_3_0.cluesUIList = UIItemList.New(arg_3_0.cluesTF, arg_3_0.cluesTF:Find("tpl"))

	arg_3_0.cluesUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setText(arg_5_2:Find("index/Text"), arg_3_0.clues[arg_5_1 + 1]:GetTitle())
			setText(arg_5_2:Find("Text"), arg_3_0.clues[arg_5_1 + 1]:GetReasoningDesc())
		end

		return
	end)

	arg_3_0.optionsUIList = UIItemList.New(arg_3_0.optionsTF, arg_3_0.optionsTF:Find("tpl"))

	arg_3_0.optionsUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			setText(arg_6_2:Find("Text"), arg_3_0.options[arg_6_1 + 1])
			onButton(arg_3_0, arg_6_2, function()
				arg_3_0:emit(LinerLogBookMediator.GET_EVENT_AWARD, arg_3_0.actId, arg_3_0.groupIdx, var_0, arg_3_0.eventGroup:GetDrop())
				arg_3_0:Hide()

				return
			end, SFX_CONFIRM)
		end

		return
	end)

	return
end

function var_0_0.ShowOptions(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.actId = arg_8_1
	arg_8_0.groupIdx = arg_8_2
	arg_8_0.eventGroup = LinerEventGroup.New(pg.activity_template[arg_8_0.actId].config_data[3][arg_8_0.groupIdx])

	setText(arg_8_0.eventNameTF, arg_8_0.eventGroup:GetTitle())

	arg_8_0.clues = arg_8_0.eventGroup:GetEventList()
	arg_8_0.options = arg_8_0.eventGroup:GetConclusions()

	arg_8_0.cluesUIList:align(#arg_8_0.clues)
	arg_8_0:Show()

	for iter_8_0 = 1, #arg_8_0.options do
		table.insert({}, function(arg_9_0)
			arg_8_0:managedTween(LeanTween.delayedCall, function()
				arg_8_0.optionsUIList:align(iter_8_0)
				arg_9_0()

				return
			end, 0.066, nil)

			return
		end)
	end

	seriesAsync({}, function()
		return
	end)

	return
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

return var_0_0
