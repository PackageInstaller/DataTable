class = var_0_10000

local var_0_0 = "DockyardQuickSelectSettingPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "DockyardQuickSelectSettingUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitUI()

	return
end

function var_0_1.InitUI(arg_3_0)
	setText = var_1_10001
	findTF = var_1_10002

	local var_3_0 = var_1_10002(arg_3_0._tf, "window/top/bg/obtain/title")

	i18n = var_3

	var_1_10001(var_3_0, var_3("retire_title"))

	setText = var_1_10001
	findTF = var_3_0

	local var_3_1 = var_3_0(arg_3_0._tf, "window/notifications/options/notify_tpl_0/Text")

	i18n = var_3

	var_1_10001(var_3_1, var_3("unique_ship_retire_protect"))

	findTF = var_1_10001

	local var_3_2 = var_1_10001(arg_3_0._tf, "window/notifications/options/notify_tpl_0")

	findTF = var_2

	local var_3_3 = var_2(var_3_2, "on")

	findTF = var_3

	local var_3_4 = var_3(var_3_2, "off")

	onToggle = var_4

	var_4(arg_3_0, var_3_3, function(arg_4_0)
		local var_4_0 = var_3_3
		local var_4_1 = var_1.GetComponent

		typeof = var_2_10003
		Toggle = var_2_10004

		local var_4_2 = var_4_1(var_4_0, var_2_10003(var_2_10004))

		if arg_4_0 then
			local var_4_3 = arg_3_0

			var_4_3.settingChanged = true
			PlayerPrefs = var_4_3

			var_4_3.SetInt("RetireProtect", 0)
		end

		return
	end)

	onToggle = var_4

	var_4(arg_3_0, var_3_4, function(arg_5_0)
		local var_5_0 = var_3_4
		local var_5_1 = var_1.GetComponent

		typeof = var_2_10003
		Toggle = var_2_10004

		local var_5_2 = var_5_1(var_5_0, var_2_10003(var_2_10004))

		if arg_5_0 then
			local var_5_3 = arg_3_0

			var_5_3.settingChanged = true
			PlayerPrefs = var_5_3

			var_5_3.SetInt("RetireProtect", 1)
		end

		return
	end)

	local var_3_5 = {}

	findTF = var_5
	var_3_5[1] = var_5(arg_3_0._tf, "window/notifications/options/notify_tpl_1")
	findTF = var_5
	var_3_5[2] = var_5(arg_3_0._tf, "window/notifications/options/notify_tpl_2")
	findTF = var_5
	var_3_5[3] = var_5(arg_3_0._tf, "window/notifications/options/notify_tpl_3")

	local var_3_6 = {
		sr = 4,
		n = 2,
		empty = 0,
		r = 3
	}
	local var_3_7 = {}

	for iter_3_0 = 1, #var_3_5 do
		var_3_7[iter_3_0] = {}
		pairs = var_1_10011

		for iter_3_1, iter_3_2 in var_1_10011(var_3_6) do
			var_1_10016 = var_3_7[iter_3_0]
			findTF = var_1_10017
			var_1_10016[iter_3_1] = var_1_10017(var_3_5[iter_3_0], iter_3_1)
		end
	end

	for iter_3_3 = 1, #var_3_5 do
		pairs = var_1_10011

		for iter_3_4, iter_3_5 in var_1_10011(var_3_6) do
			onToggle = var_1_10016

			var_1_10016(arg_3_0, var_3_7[iter_3_3][iter_3_4], function(arg_6_0)
				local var_6_0 = var_3_7[iter_3_3][iter_3_4]
				local var_6_1 = var_1.GetComponent

				typeof = var_2_10003
				Toggle = var_2_10004

				local var_6_2 = var_6_1(var_6_0, var_2_10003(var_2_10004))

				if arg_6_0 then
					local var_6_3 = arg_3_0

					var_6_3.settingChanged = true
					PlayerPrefs = var_6_3

					var_6_3.SetInt("QuickSelectRarity" .. iter_3_3, iter_3_5)
				else
					local var_6_4 = var_6_2.group

					if not var_2.AnyTogglesOn(var_6_4) then
						triggerToggle = var_2

						var_2(var_3_7[iter_3_3].empty, true)
					end
				end

				return
			end)
		end
	end

	findTF = var_7

	local var_3_8 = var_7(arg_3_0._tf, "window/notifications/options/notify_tpl_4")

	onToggle = var_8

	local var_3_9 = arg_3_0

	findTF = iter_3_3

	var_8(var_3_9, iter_3_3(var_3_8, "keep_all"), function(arg_7_0)
		if arg_7_0 then
			local var_7_0 = arg_3_0

			var_7_0.settingChanged = true
			PlayerPrefs = var_7_0

			var_7_0.SetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepAll")
		end

		return
	end)

	onToggle = var_8

	local var_3_10 = arg_3_0

	findTF = var_10

	var_8(var_3_10, var_10(var_3_8, "keep_one"), function(arg_8_0)
		if arg_8_0 then
			local var_8_0 = arg_3_0

			var_8_0.settingChanged = true
			PlayerPrefs = var_8_0

			var_8_0.SetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepOne")
		end

		return
	end)

	onToggle = var_8

	local var_3_11 = arg_3_0

	findTF = var_10

	var_8(var_3_11, var_10(var_3_8, "keep_none"), function(arg_9_0)
		if arg_9_0 then
			local var_9_0 = arg_3_0

			var_9_0.settingChanged = true
			PlayerPrefs = var_9_0

			var_9_0.SetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepNone")
		end

		return
	end)

	findTF = var_8

	local var_3_12 = var_8(arg_3_0._tf, "window/notifications/options/notify_tpl_5")

	onToggle = var_9

	local var_3_13 = arg_3_0

	findTF = var_11

	var_9(var_3_13, var_11(var_3_12, "keep_all"), function(arg_10_0)
		if arg_10_0 then
			local var_10_0 = arg_3_0

			var_10_0.settingChanged = true
			PlayerPrefs = var_10_0

			var_10_0.SetString("QuickSelectWithoutMaxstar", "KeepAll")
		end

		return
	end)

	onToggle = var_9

	local var_3_14 = arg_3_0

	findTF = var_11

	var_9(var_3_14, var_11(var_3_12, "keep_needed"), function(arg_11_0)
		if arg_11_0 then
			local var_11_0 = arg_3_0

			var_11_0.settingChanged = true
			PlayerPrefs = var_11_0

			var_11_0.SetString("QuickSelectWithoutMaxstar", "KeepNeeded")
		end

		return
	end)

	onToggle = var_9

	local var_3_15 = arg_3_0

	findTF = var_11

	var_9(var_3_15, var_11(var_3_12, "keep_none"), function(arg_12_0)
		if arg_12_0 then
			local var_12_0 = arg_3_0

			var_12_0.settingChanged = true
			PlayerPrefs = var_12_0

			var_12_0.SetString("QuickSelectWithoutMaxstar", "KeepNone")
		end

		return
	end)

	onButton = var_9

	local var_3_16 = arg_3_0

	findTF = var_11

	local var_3_17 = var_11(arg_3_0._tf, "window/top/btnBack")

	local function var_3_18()
		local var_13_0 = arg_3_0

		var_0.Hide(var_13_0)

		return
	end

	SFX_CANCEL = var_13

	var_9(var_3_16, var_3_17, var_3_18, var_13)

	onButton = var_9

	local var_3_19 = arg_3_0

	findTF = var_3_17

	local var_3_20 = var_3_17(arg_3_0._tf, "window/top/bg/obtain/title/title_en/info")

	local function var_3_21()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_14_2.type = var_2_10003
		i18n = var_2_10003
		var_14_2.helps = var_2_10003("retire_setting_help")

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_CONFIRM = var_13

	var_9(var_3_19, var_3_20, var_3_21, var_13)

	PlayerPrefs = var_9

	local var_3_22 = var_9.GetInt("RetireProtect", 1)

	PlayerPrefs = var_10

	local var_3_23 = var_10.GetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepNone")

	PlayerPrefs = var_11

	local var_3_24 = var_11.GetString("QuickSelectWithoutMaxstar", "KeepAll")

	if var_3_22 == 0 then
		triggerToggle = var_12

		var_12(var_3_3, true)
	elseif var_3_22 == 1 then
		triggerToggle = var_12

		var_12(var_3_4, true)
	end

	if var_3_23 == "KeepAll" then
		triggerToggle = var_12
		findTF = var_13

		var_12(var_13(var_3_8, "keep_all"), true)
	elseif var_3_23 == "KeepOne" then
		triggerToggle = var_12
		findTF = var_13

		var_12(var_13(var_3_8, "keep_one"), true)
	elseif var_3_23 == "KeepNone" then
		triggerToggle = var_12
		findTF = var_13

		var_12(var_13(var_3_8, "keep_none"), true)
	end

	if var_3_24 == "KeepAll" then
		triggerToggle = var_12
		findTF = var_13

		var_12(var_13(var_3_12, "keep_all"), true)
	elseif var_3_24 == "KeepNeeded" then
		triggerToggle = var_12
		findTF = var_13

		var_12(var_13(var_3_12, "keep_needed"), true)
	elseif var_3_24 == "KeepNone" then
		triggerToggle = var_12
		findTF = var_13

		var_12(var_13(var_3_12, "keep_none"), true)
	end

	setText = var_12
	findTF = var_13

	local var_3_25 = var_13(arg_3_0._tf, "window/notifications/options/notify_tpl_4/Text")

	i18n = var_14

	var_12(var_3_25, var_14("retire_1"))

	setText = var_12
	findTF = var_3_25

	local var_3_26 = var_3_25(arg_3_0._tf, "window/notifications/options/notify_tpl_5/Text")

	i18n = var_14

	var_12(var_3_26, var_14("retire_2"))

	local var_3_27 = {}

	PlayerPrefs = var_3_26
	var_3_27[1] = var_3_26.GetInt("QuickSelectRarity1", 3)
	PlayerPrefs = var_13
	var_3_27[2] = var_13.GetInt("QuickSelectRarity2", 4)
	PlayerPrefs = var_13
	var_3_27[3] = var_13.GetInt("QuickSelectRarity3", 2)

	for iter_3_6 = 1, #var_3_5 do
		setText = var_1_10017
		findTF = var_1_10018
		var_1_10018 = var_1_10018(var_3_5[iter_3_6], "Text")
		i18n = var_19

		var_1_10017(var_1_10018, var_19("retire_rarity", iter_3_6))

		pairs = var_1_10017

		for iter_3_7, iter_3_8 in var_1_10017(var_3_6) do
			if iter_3_8 == var_3_27[iter_3_6] then
				triggerToggle = var_22

				var_22(var_3_7[iter_3_6][iter_3_7], true)
			end
		end
	end

	return
end

function var_0_1.Show(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0._tf, true)

	pg = var_1_10001

	local var_15_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_15_0, arg_15_0._tf)

	return
end

function var_0_1.Hide(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_16_0, arg_16_0._tf, arg_16_0._parentTf)

	setActive = var_1

	var_1(arg_16_0._tf, false)

	if arg_16_0.settingChangedCB then
		arg_16_0.settingChangedCB()
	end

	return
end

function var_0_1.OnDestroy(arg_17_0)
	arg_17_0.settingChangedCB = nil

	return
end

function var_0_1.OnSettingChanged(arg_18_0, arg_18_1)
	arg_18_0.settingChangedCB = arg_18_1

	return
end

return var_0_1
