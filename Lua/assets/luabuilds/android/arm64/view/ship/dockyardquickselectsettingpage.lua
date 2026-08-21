local var_0_0 = class("DockyardQuickSelectSettingPage", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "DockyardQuickSelectSettingUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:InitUI()

	return
end

function var_0_0.InitUI(arg_3_0)
	setText(findTF(arg_3_0._tf, "window/top/bg/obtain/title"), i18n("retire_title"))
	setText(findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_0/Text"), i18n("unique_ship_retire_protect"))

	local var_3_0 = findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_0")
	local var_3_1 = findTF(var_3_0, "on")
	local var_3_2 = findTF(var_3_0, "off")

	onToggle(arg_3_0, var_3_1, function(arg_4_0)
		local var_4_0 = var_3_1:GetComponent(typeof(Toggle))

		if arg_4_0 then
			arg_3_0.settingChanged = true

			PlayerPrefs.SetInt("RetireProtect", 0)
		end

		return
	end)
	onToggle(arg_3_0, var_3_2, function(arg_5_0)
		local var_5_0 = var_3_2:GetComponent(typeof(Toggle))

		if arg_5_0 then
			arg_3_0.settingChanged = true

			PlayerPrefs.SetInt("RetireProtect", 1)
		end

		return
	end)

	local var_3_3 = {
		findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_1"),
		findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_2"),
		findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_3")
	}
	local var_3_4 = {
		sr = 4,
		n = 2,
		empty = 0,
		r = 3
	}
	local var_3_5 = {}

	for iter_3_0 = 1, #var_3_3 do
		var_3_5[iter_3_0] = {}

		for iter_3_1, iter_3_2 in pairs(var_3_4) do
			var_3_5[iter_3_0][iter_3_1] = findTF(var_3_3[iter_3_0], iter_3_1)
		end
	end

	for iter_3_3 = 1, #var_3_3 do
		for iter_3_4, iter_3_5 in pairs(var_3_4) do
			onToggle(arg_3_0, var_3_5[iter_3_3][iter_3_4], function(arg_6_0)
				if arg_6_0 then
					arg_3_0.settingChanged = true

					PlayerPrefs.SetInt("QuickSelectRarity" .. iter_3_3, iter_3_5)
				elseif not var_3_5[iter_3_3][iter_3_4]:GetComponent(typeof(Toggle)).group:AnyTogglesOn() then
					triggerToggle(var_3_5[iter_3_3].empty, true)
				end

				return
			end)
		end
	end

	local var_3_6 = findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_4")

	onToggle(arg_3_0, findTF(var_3_6, "keep_all"), function(arg_7_0)
		if arg_7_0 then
			arg_3_0.settingChanged = true

			PlayerPrefs.SetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepAll")
		end

		return
	end)
	onToggle(arg_3_0, findTF(var_3_6, "keep_one"), function(arg_8_0)
		if arg_8_0 then
			arg_3_0.settingChanged = true

			PlayerPrefs.SetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepOne")
		end

		return
	end)
	onToggle(arg_3_0, findTF(var_3_6, "keep_none"), function(arg_9_0)
		if arg_9_0 then
			arg_3_0.settingChanged = true

			PlayerPrefs.SetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepNone")
		end

		return
	end)

	local var_3_7 = findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_5")

	onToggle(arg_3_0, findTF(var_3_7, "keep_all"), function(arg_10_0)
		if arg_10_0 then
			arg_3_0.settingChanged = true

			PlayerPrefs.SetString("QuickSelectWithoutMaxstar", "KeepAll")
		end

		return
	end)
	onToggle(arg_3_0, findTF(var_3_7, "keep_needed"), function(arg_11_0)
		if arg_11_0 then
			arg_3_0.settingChanged = true

			PlayerPrefs.SetString("QuickSelectWithoutMaxstar", "KeepNeeded")
		end

		return
	end)
	onToggle(arg_3_0, findTF(var_3_7, "keep_none"), function(arg_12_0)
		if arg_12_0 then
			arg_3_0.settingChanged = true

			PlayerPrefs.SetString("QuickSelectWithoutMaxstar", "KeepNone")
		end

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0._tf, "window/top/btnBack"), function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, findTF(arg_3_0._tf, "window/top/bg/obtain/title/title_en/info"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("retire_setting_help")
		})

		return
	end, SFX_CONFIRM)

	local var_3_8 = PlayerPrefs.GetInt("RetireProtect", 1)
	local var_3_9 = PlayerPrefs.GetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepNone")
	local var_3_10 = PlayerPrefs.GetString("QuickSelectWithoutMaxstar", "KeepAll")

	if var_3_8 == 0 then
		triggerToggle(var_3_1, true)
	elseif var_3_8 == 1 then
		triggerToggle(var_3_2, true)
	end

	if var_3_9 == "KeepAll" then
		triggerToggle(findTF(var_3_6, "keep_all"), true)
	elseif var_3_9 == "KeepOne" then
		triggerToggle(findTF(var_3_6, "keep_one"), true)
	elseif var_3_9 == "KeepNone" then
		triggerToggle(findTF(var_3_6, "keep_none"), true)
	end

	if var_3_10 == "KeepAll" then
		triggerToggle(findTF(var_3_7, "keep_all"), true)
	elseif var_3_10 == "KeepNeeded" then
		triggerToggle(findTF(var_3_7, "keep_needed"), true)
	elseif var_3_10 == "KeepNone" then
		triggerToggle(findTF(var_3_7, "keep_none"), true)
	end

	setText(findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_4/Text"), i18n("retire_1"))
	setText(findTF(arg_3_0._tf, "window/notifications/options/notify_tpl_5/Text"), i18n("retire_2"))

	local var_3_11 = {
		PlayerPrefs.GetInt("QuickSelectRarity1", 3),
		PlayerPrefs.GetInt("QuickSelectRarity2", 4),
		PlayerPrefs.GetInt("QuickSelectRarity3", 2)
	}

	for iter_3_6 = 1, #var_3_3 do
		setText(findTF(var_3_3[iter_3_6], "Text"), i18n("retire_rarity", iter_3_6))

		for iter_3_7, iter_3_8 in pairs(var_3_4) do
			if iter_3_8 == var_3_11[iter_3_6] then
				triggerToggle(var_3_5[iter_3_6][iter_3_7], true)
			end
		end
	end

	return
end

function var_0_0.Show(arg_15_0)
	setActive(arg_15_0._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_15_0._tf)

	return
end

function var_0_0.Hide(arg_16_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf, arg_16_0._parentTf)
	setActive(arg_16_0._tf, false)

	if arg_16_0.settingChangedCB then
		arg_16_0.settingChangedCB()
	end

	return
end

function var_0_0.OnDestroy(arg_17_0)
	arg_17_0.settingChangedCB = nil

	return
end

function var_0_0.OnSettingChanged(arg_18_0, arg_18_1)
	arg_18_0.settingChangedCB = arg_18_1

	return
end

return var_0_0
