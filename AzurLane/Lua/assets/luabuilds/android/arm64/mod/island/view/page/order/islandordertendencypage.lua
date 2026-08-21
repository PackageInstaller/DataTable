local var_0_0 = class("IslandOrderTendencyPage", import("Mod.Island.View.page.msgbox.window.IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandOrderTendencyUI"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.toggles = {
		[IslandOrderSlot.TENDENCY_TYPE_COMMON] = arg_2_0._tf:Find("toggle/1"),
		[IslandOrderSlot.TENDENCY_TYPE_EASY] = arg_2_0._tf:Find("toggle/0"),
		[IslandOrderSlot.TENDENCY_TYPE_HARD] = arg_2_0._tf:Find("toggle/2")
	}

	setText(arg_2_0._tf:Find("toggle/0/Text"), i18n("island_order_difficulty_2"))
	setText(arg_2_0._tf:Find("toggle/1/Text"), i18n("island_order_difficulty_1"))
	setText(arg_2_0._tf:Find("toggle/2/Text"), i18n("island_order_difficulty_3"))

	return
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if arg_3_0.onYes then
			arg_3_0.onYes(arg_3_0.selectedIndex)
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_5_0)
	var_0_0.super.OnShow(arg_5_0)

	arg_5_0.selectedIndex = arg_5_0.settings.selected or IslandOrderSlot.TENDENCY_TYPE_COMMON

	arg_5_0:FlushToggles()

	return
end

function var_0_0.OnHide(arg_6_0)
	var_0_0.super.OnHide(arg_6_0)

	arg_6_0.settings = nil

	return
end

function var_0_0.FlushToggles(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.toggles) do
		onToggle(arg_7_0, iter_7_1, function(arg_8_0)
			if arg_8_0 then
				arg_7_0.selectedIndex = iter_7_0

				arg_7_0:UpdateContent()
			end

			return
		end, SFX_PANEL)
	end

	triggerToggle(arg_7_0.toggles[arg_7_0.selectedIndex], true)

	return
end

function var_0_0.UpdateContent(arg_9_0)
	arg_9_0.contentTxt.text = IslandOrderSlot.TENDENCY2TIP(arg_9_0.selectedIndex)

	return
end

return var_0_0
