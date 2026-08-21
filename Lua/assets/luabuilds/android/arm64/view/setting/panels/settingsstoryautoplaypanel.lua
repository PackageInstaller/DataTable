local var_0_0 = class("SettingsStoryAutoPlayPanel", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsStoryAutoplay"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("story_autoplay_setting_label")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / AUTO"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.btns = {}

	for iter_4_0, iter_4_1 in ipairs({
		arg_4_0._tf:Find("speeds/1"),
		arg_4_0._tf:Find("speeds/2")
	}) do
		onToggle(arg_4_0, iter_4_1, function(arg_5_0)
			if arg_5_0 then
				getProxy(SettingsProxy):SetStoryAutoPlayFlag(iter_4_0 - 1)
			end

			return
		end, SFX_PANEL)
		setText(iter_4_1:Find("Text"), i18n("story_autoplay_setting_" .. iter_4_0))

		arg_4_0.btns[iter_4_0] = iter_4_1
	end

	return
end

function var_0_0.OnUpdate(arg_6_0)
	local var_6_0 = getProxy(SettingsProxy)

	triggerToggle(arg_6_0.btns[var_6_0:GetStoryAutoPlayFlag() and 2 or 1], true)

	return
end

return var_0_0
