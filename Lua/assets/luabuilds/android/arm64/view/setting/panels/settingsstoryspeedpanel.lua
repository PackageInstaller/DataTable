local var_0_0 = class("SettingsStorySpeedPanel", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsStorySpeed"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("story_setting_label")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / AUTO SPEED"
end

function var_0_0.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf:Find("speeds")

	arg_4_0.btns = {}

	for iter_4_0 = 1, var_4_0.childCount do
		local var_4_1 = var_4_0:GetChild(iter_4_0 - 1)

		onToggle(arg_4_0, var_4_1, function(arg_5_0)
			if arg_5_0 then
				getProxy(SettingsProxy):SetStorySpeed(Story.STORY_AUTO_SPEED[iter_4_0])
			end

			return
		end, SFX_PANEL)
		setText(var_4_1:Find("Text"), i18n("setting_story_speed_" .. iter_4_0))

		arg_4_0.btns[iter_4_0] = var_4_1
	end

	return
end

function var_0_0.OnUpdate(arg_6_0)
	local var_6_0 = table.indexof(Story.STORY_AUTO_SPEED, (getProxy(SettingsProxy):GetStorySpeed())) or 2

	triggerToggle(arg_6_0.btns[var_6_0], true)

	return
end

return var_0_0
