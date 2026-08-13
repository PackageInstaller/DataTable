class = var_0_10000

local var_0_0 = "SettingsSecondPwLimitedOpPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsSecondPwLimitedOp"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_Secpwlimop")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / PROTECTION LIST"
end

function var_0_1.OnInit(arg_4_0)
	UIItemList = var_1_10001

	local var_4_0 = var_1_10001.New

	findTF = var_1_10003

	local var_4_1 = var_1_10003(arg_4_0._tf, "options")

	findTF = var_1_10004
	arg_4_0.uiList = var_4_0(var_4_1, var_1_10004(arg_4_0._tf, "options/notify_tpl"))

	local var_4_2 = arg_4_0.uiList

	var_1.make(var_4_2, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0

			var_3.UpdateItem(var_5_0, arg_5_1 + 1, arg_5_2)
		end

		return
	end)
	arg_4_0:SetData()

	return
end

function var_0_1.SetData(arg_6_0)
	getProxy = var_1_10001
	SecondaryPWDProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	arg_6_0.rawdata = var_1.getRawData(var_6_0)

	return
end

function var_0_1.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.list[arg_7_1].key

	findTF = var_1_10005

	local var_7_1 = var_1_10005(arg_7_2, "mask/Text")
	local var_7_2 = var_5.GetComponent(var_7_1, "ScrollText")

	var_5.SetText(var_7_2, var_3.title)

	pg = var_6

	local var_7_3 = var_6.SecondaryPWDMgr.GetInstance()

	onButton = var_7_1

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_2

	local function var_7_6()
		table = var_2_10000

		local var_8_0 = var_2_10000.contains(arg_7_0.rawdata.system_list, var_7_0)
		local var_8_1

		if not var_8_0 then
			Clone = var_2
			var_8_1[#var_2(arg_7_0.rawdata.system_list) + 1] = var_7_0
			table = var_2

			var_2.sort(var_8_1, function(arg_9_0, arg_9_1)
				return arg_9_0 < arg_9_1
			end)
		elseif var_8_0 then
			Clone = var_2

			for iter_8_0 = #var_2(arg_7_0.rawdata.system_list), 1, -1 do
				if var_8_1[iter_8_0] == var_7_0 then
					table = var_6

					var_6.remove(var_8_1, iter_8_0)
				end
			end
		end

		local var_8_2 = var_7_3

		var_2.ChangeSetting(var_8_2, var_8_1, function()
			local var_10_0 = arg_7_0

			var_0.UpdateBtnsState(var_10_0)

			return
		end)

		return
	end

	SFX_UI_TAG = var_1_10012

	var_7_1(var_7_4, var_7_5, var_7_6, var_1_10012)

	return
end

function var_0_1.UpdateBtnsState(arg_11_0)
	if not arg_11_0:IsLoaded() then
		return
	end

	local function var_11_0(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0.key

		table = var_2_10003

		local var_12_1 = var_2_10003.contains(arg_11_0.rawdata.system_list, var_12_0)
		local var_12_2 = arg_12_1
		local var_12_3 = arg_12_1.GetComponent

		typeof = var_2_10007
		Button = var_2_10009
		var_12_3(var_12_2, var_2_10007(var_2_10009)).interactable = arg_11_0.rawdata.state > 0
		triggerToggle = var_5

		var_5(arg_12_1:Find("on"), var_12_1)

		triggerToggle = var_5

		var_5(arg_12_1:Find("off"), not var_12_1)

		return
	end

	local var_11_1 = arg_11_0.uiList

	var_2.eachActive(var_11_1, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_11_0.list[arg_13_0 + 1]

		var_11_0(var_13_0, arg_13_1)

		return
	end)

	return
end

function var_0_1.OnUpdate(arg_14_0)
	arg_14_0.list = arg_14_0:GetList()

	local var_14_0 = arg_14_0.uiList

	var_1.align(var_14_0, #arg_14_0.list)
	arg_14_0:UpdateBtnsState()

	return
end

function var_0_1.GetList(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.SecondaryPWDMgr.GetInstance()
	local var_15_1 = {}
	local var_15_2 = {
		key = var_15_0.UNLOCK_SHIP
	}

	i18n = var_4
	var_15_2.title = var_4("words_settings_unlock_ship")
	var_15_1[1] = var_15_2

	local var_15_3 = {
		key = var_15_0.RESOLVE_EQUIPMENT
	}

	i18n = var_4
	var_15_3.title = var_4("words_settings_resolve_equip")
	var_15_1[2] = var_15_3

	local var_15_4 = {
		key = var_15_0.UNLOCK_COMMANDER
	}

	i18n = var_4
	var_15_4.title = var_4("words_settings_unlock_commander")
	var_15_1[3] = var_15_4

	local var_15_5 = {
		key = var_15_0.CREATE_INHERIT
	}

	i18n = var_4
	var_15_5.title = var_4("words_settings_create_inherit")
	var_15_1[4] = var_15_5

	for iter_15_0 = #var_15_1, 1, -1 do
		local var_15_6 = var_15_1[iter_15_0]

		table = var_1_10008

		if not var_1_10008.contains(var_15_0.LIMITED_OPERATION, var_15_6.key) then
			table = var_1_10008

			var_1_10008.remove(var_15_1, iter_15_0)
		end
	end

	return var_15_1
end

return var_0_1
