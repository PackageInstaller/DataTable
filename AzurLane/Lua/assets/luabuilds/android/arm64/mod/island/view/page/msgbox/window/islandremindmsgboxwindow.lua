local var_0_0 = class("IslandRemindMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxWithRemind"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.remindToggle = arg_2_0._tf:Find("remind")

	setText(arg_2_0._tf:Find("remind/Text"), i18n("island_no_remind_today"))

	return
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		local var_4_0

		if arg_3_0.onYes then
			arg_3_0.onYes()

			var_4_0 = arg_3_0.flag and GetZeroTime() or 0
		end

		arg_3_0:SaveValue(arg_3_0.settings.key, var_4_0)
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_5_0)
	var_0_0.super.OnShow(arg_5_0)

	arg_5_0.flag = false

	assert(arg_5_0.settings.key)
	arg_5_0:Flush(arg_5_0.settings)

	return
end

function var_0_0.Flush(arg_6_0, arg_6_1)
	onToggle(arg_6_0, arg_6_0.remindToggle, function(arg_7_0)
		arg_6_0.flag = arg_7_0

		return
	end, SFX_PANEL)
	triggerToggle(arg_6_0.remindToggle, arg_6_0.flag)

	return
end

function var_0_0.SaveValue(arg_8_0, arg_8_1, arg_8_2)
	PlayerPrefs.SetInt(arg_8_1, arg_8_2)
	PlayerPrefs.Save()

	return
end

return var_0_0
