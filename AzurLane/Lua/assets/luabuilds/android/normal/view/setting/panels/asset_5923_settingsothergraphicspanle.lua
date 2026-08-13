class = var_0_10000

local var_0_0 = "SettingsOtherGraphicsPanle"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

var_0_1.EVT_UPDTAE = "SettingsOtherGraphicsPanle:EVT_UPDTAE"

local var_0_2
local var_0_3
local var_0_4
local var_0_5

function var_0_1.GetUIName(arg_1_0)
	return "GraphicSettingsOther"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("grapihcs3d_setting_universal")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / STANDBY MODE SETTINGS"
end

function var_0_1.OnInit(arg_4_0)
	GraphicSettingConst = var_1_10001
	var_0_2 = var_1_10001.SettingType
	GraphicSettingConst = var_1
	var_0_3 = var_1.assetPath
	GraphicSettingConst = var_1
	var_0_4 = var_1.settings
	GraphicSettingConst = var_1
	var_0_5 = var_1.SettingLevel
	arg_4_0.init = true
	UIItemList = var_1

	local var_4_0 = var_1.New
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_2.Find(var_4_1, "options")
	local var_4_3 = arg_4_0._tf

	arg_4_0.uilist = var_4_0(var_4_2, var_3.Find(var_4_3, "options/notify_tpl"))

	local var_4_4 = arg_4_0.uilist

	var_1.make(var_4_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0

			var_3.UpdateItem(var_5_0, arg_5_1 + 1, arg_5_2)
		end

		return
	end)

	return
end

function var_0_1.JumpToCustomSetting(arg_6_0, arg_6_1)
	if arg_6_0.graphicLevel == var_0_5.Custom then
		return
	end

	arg_6_0:SetPlayerPrefSetting(arg_6_1)

	pg = var_2

	local var_6_0 = var_2.m02
	local var_6_1 = var_2.sendNotification

	GAME = var_4

	local var_6_2 = var_4.APARTMENT_TRACK

	Dorm3dTrackCommand = var_1_10005

	var_6_1(var_6_0, var_6_2, var_1_10005.BuildDataGraphics(4))

	PlayerPrefs = var_6_1

	var_6_1.SetInt("dorm3d_graphics_settings_new", 4)

	pg = var_2

	local var_6_3 = var_2.m02
	local var_6_4 = var_2.sendNotification

	NewSettingsMediator = var_4

	var_6_4(var_6_3, var_4.SelectCustomGraphicSetting)

	return
end

function var_0_1.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.list[arg_7_1]
	local var_7_1 = arg_7_2
	local var_7_2

	var_7_2, setText = arg_7_2.Find(var_7_1, "mask/Text"), var_7_1
	i18n = var_1_10007

	var_7_1(var_7_2, var_1_10007(var_7_0.settingName))

	local var_7_3 = var_7_0.settingType == var_0_2.toggle
	local var_7_4 = arg_7_2:Find("toggle")
	local var_7_5 = arg_7_2
	local var_7_6 = arg_7_2.Find(var_7_5, "select")

	setActive = var_7_5

	var_7_5(var_7_4, var_7_3)

	setActive = var_7_5

	var_7_5(var_7_6, not var_7_3)

	if var_7_3 then
		local function var_7_7(arg_8_0)
			local var_8_0 = arg_8_0 and 1 or 0

			PlayerPrefs = var_2_10002

			var_2_10002.SetInt(var_7_0.playerPrefsname, var_8_0)

			return
		end

		local var_7_8 = arg_7_2:Find("toggle/off")

		var_1_10011 = arg_7_2

		local var_7_9 = arg_7_2.Find(var_1_10011, "toggle/on")

		var_1_10011 = nil

		local function var_7_10(arg_9_0)
			var_1_10011 = arg_9_0
			SetActive = var_2_10001

			local var_9_0 = var_7_8

			var_2_10001(var_2.Find(var_9_0, "show"), not arg_9_0)

			SetActive = var_2_10001

			local var_9_1 = var_7_9

			var_2_10001(var_2.Find(var_9_1, "show"), arg_9_0)

			return
		end

		onButton = var_1_10013

		local var_7_11 = arg_7_0
		local var_7_12 = var_7_9

		local function var_7_13()
			if var_1_10011 == true then
				return
			end

			if var_7_0.tips then
				local var_10_0 = {}

				table = var_2_10001

				var_2_10001.insert(var_10_0, function(arg_11_0)
					pg = var_3_10001

					local var_11_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_11_1 = var_1.ShowMsgBox
					local var_11_2 = {}

					MSGBOX_TYPE_NORMAL = var_3_10004
					var_11_2.type = var_3_10004
					i18n = var_3_10004
					var_11_2.content = var_3_10004(var_7_0.tips)

					function var_11_2.onYes()
						arg_11_0()

						return
					end

					function var_11_2.onNo()
						return
					end

					var_11_1(var_11_0, var_11_2)

					return
				end)

				seriesAsync = var_1

				var_1(var_10_0, function()
					var_7_10(true)
					var_7_7(true)

					local var_14_0 = arg_7_0

					var_0.JumpToCustomSetting(var_14_0, var_7_0)

					return
				end)
			else
				var_7_10(true)
				var_7_7(true)

				if arg_7_0.customSetting and var_7_0.hasChild then
					pg = var_0

					local var_10_1 = var_0.m02
					local var_10_2 = var_0.sendNotification

					NewSettingsMediator = var_2_10002

					var_10_2(var_10_1, var_2_10002.SelectCustomGraphicSetting)

					return
				end

				local var_10_3 = arg_7_0

				var_0.JumpToCustomSetting(var_10_3, var_7_0)
			end

			return
		end

		SFX_CANCEL = var_1_10017

		var_1_10013(var_7_11, var_7_12, var_7_13, var_1_10017)

		onButton = var_1_10013

		local var_7_14 = arg_7_0
		local var_7_15 = var_7_8

		local function var_7_16()
			if var_1_10011 == false then
				return
			end

			var_7_10(false)
			var_7_7(false)

			if arg_7_0.customSetting and var_7_0.hasChild then
				pg = var_0

				local var_15_0 = var_0.m02
				local var_15_1 = var_0.sendNotification

				NewSettingsMediator = var_2_10002

				var_15_1(var_15_0, var_2_10002.SelectCustomGraphicSetting)

				return
			end

			local var_15_2 = arg_7_0

			var_0.JumpToCustomSetting(var_15_2, var_7_0)

			return
		end

		SFX_CANCEL = var_1_10017

		var_1_10013(var_7_14, var_7_15, var_7_16, var_1_10017)

		local var_7_17

		if arg_7_0.graphicLevel == var_0_5.Custom then
			PlayerPrefs = var_15

			local var_7_18

			if not var_15.GetInt(var_7_0.playerPrefsname, -1) then
				::label_7_0::

				var_7_18 = nil
			end

			if not var_7_18 or var_7_18 == -1 then
				var_7_18 = var_7_0.defaultValues[arg_7_0.graphicLevel]
			end

			var_7_10(var_7_18 == 1 or var_7_18 == true)

			goto label_7_1

			local var_7_19

			if arg_7_0.graphicLevel == var_0_5.Custom then
				PlayerPrefs = var_10

				do
					local var_7_20

					if not var_10.GetInt(var_7_0.playerPrefsname, -1) then
						var_7_20 = nil
					end

					if not var_7_20 or var_7_20 == -1 then
						var_7_20 = var_7_0.defaultValues[arg_7_0.graphicLevel]
					end

					ipairs = var_1_10011

					for iter_7_0, iter_7_1 in var_1_10011(var_7_0.options) do
						if iter_7_1 == var_7_20 then
							var_7_19 = iter_7_0
						end
					end

					;(function()
						local var_16_0 = var_7_19 == 1
						local var_16_1 = var_7_19 == #var_7_0.optionNames

						setActive = var_2

						local var_16_2 = var_7_6

						var_2(var_3.Find(var_16_2, "leftbu"), not var_16_0)

						setActive = var_2

						local var_16_3 = var_7_6

						var_2(var_3.Find(var_16_3, "rightbu"), not var_16_1)

						setText = var_2

						local var_16_4 = var_7_6
						local var_16_5 = var_3.Find(var_16_4, "Text")

						i18n = var_16_4

						var_2(var_16_5, var_16_4(var_7_0.optionNames[var_7_19]))

						return
					end)()

					onButton = var_12

					var_12(arg_7_0, var_7_6:Find("leftbu"), function()
						var_7_19 = var_7_19 - 1

						var_0()

						PlayerPrefs = var_0

						var_0.SetInt(var_7_0.playerPrefsname, var_7_0.options[var_7_19])

						local var_17_0 = arg_7_0

						var_0.JumpToCustomSetting(var_17_0, var_7_0)

						return
					end)

					onButton = var_12

					var_12(arg_7_0, var_7_6:Find("rightbu"), function()
						var_7_19 = var_7_19 + 1

						var_0()

						PlayerPrefs = var_0

						var_0.SetInt(var_7_0.playerPrefsname, var_7_0.options[var_7_19])

						local var_18_0 = arg_7_0

						var_0.JumpToCustomSetting(var_18_0, var_7_0)

						return
					end)
				end

				::label_7_1::

				return
			end
		end
	end
end

function var_0_1.SetPlayerPrefSetting(arg_19_0, arg_19_1)
	if arg_19_0.graphicLevel == var_0_5.Custom then
		return
	end

	ipairs = var_2

	for iter_19_0, iter_19_1 in var_2(var_0_4) do
		if arg_19_1.playerPrefsname ~= iter_19_1.playerPrefsname then
			local var_19_0 = iter_19_1.defaultValues[arg_19_0.graphicLevel]

			if iter_19_1.settingType == var_0_2.toggle then
				local var_19_1 = var_19_0 and 1 or 0

				PlayerPrefs = var_9

				var_9.SetInt(iter_19_1.playerPrefsname, var_19_1)
			else
				local var_19_2

				ipairs = var_9

				for iter_19_2, iter_19_3 in var_9(iter_19_1.options) do
					if iter_19_3 == var_19_0 then
						var_19_2 = iter_19_2
					end
				end

				PlayerPrefs = var_9

				var_9.SetInt(iter_19_1.playerPrefsname, iter_19_1.options[var_19_2])
			end
		end
	end

	return
end

function var_0_1.OnUpdate(arg_20_0)
	if not arg_20_0.init then
		return
	end

	arg_20_0.playerSettingPlaySet = {}
	PlayerPrefs = var_1
	arg_20_0.graphicLevel = var_1.GetInt("dorm3d_graphics_settings_new", 4)
	arg_20_0.customSetting = arg_20_0.graphicLevel == 4

	local var_20_0 = var_0_3[arg_20_0.graphicLevel]

	arg_20_0.list = arg_20_0:GetList()

	local var_20_1 = arg_20_0.uilist

	var_2.align(var_20_1, #arg_20_0.list)

	return
end

function var_0_1.RefreshPanelByGraphcLevel(arg_21_0)
	arg_21_0:OnUpdate()

	return
end

function var_0_1.GetList(arg_22_0)
	local var_22_0 = {}

	local function var_22_1(arg_23_0)
		local var_23_0 = arg_22_0
		local var_23_1 = var_1.GetParentSetting(var_23_0, arg_23_0.parentId)
		local var_23_2 = false

		if var_23_1 then
			if arg_22_0.customSetting then
				PlayerPrefs = var_3

				local var_23_3

				if not var_3.GetInt(var_23_1.playerPrefsname, -1) then
					var_23_3 = nil
				end

				if not var_23_3 or var_23_3 == -1 then
					var_23_3 = var_23_1.defaultValues[arg_22_0.graphicLevel]
				end

				var_23_2 = var_23_3 == 0

				return not (arg_23_0.isShow == 0 or var_23_2)
			end
		end
	end

	ipairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(var_0_4) do
		if var_22_1(iter_22_1) then
			table = var_8

			var_8.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_1.GetParentSetting(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return
	end

	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(var_0_4) do
		if iter_24_0 == arg_24_1 then
			iter_24_1.hasChild = true

			return iter_24_1
		end
	end

	return nil
end

return var_0_1
