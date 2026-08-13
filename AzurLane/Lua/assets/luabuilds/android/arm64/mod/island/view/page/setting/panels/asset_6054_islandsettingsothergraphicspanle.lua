class = var_0_10000

local var_0_0 = "IslandSettingsOtherGraphicsPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.Setting.panels.SettingsBasePanel"))

var_0_1.EVT_UPDTAE = "IslandSettingsOtherGraphicsPanle:EVT_UPDTAE"

local var_0_2
local var_0_3
local var_0_4
local var_0_5

function var_0_1.GetUIName(arg_1_0)
	return "IslandGraphicSettingsOther"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("grapihcs3d_setting_universal")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / STANDBY MODE SETTINGS"
end

function var_0_1.InitTitle(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tf

	var_1_10001(var_3.Find(var_4_0, "title/title_point/title_text"), arg_4_0:GetTitle())

	return
end

function var_0_1.OnInit(arg_5_0)
	GraphicSettingConst = var_1_10001
	var_0_2 = var_1_10001.SettingType
	GraphicSettingConst = var_1
	var_0_3 = var_1.assetPath
	GraphicSettingConst = var_1
	var_0_4 = var_1.settings
	GraphicSettingConst = var_1
	var_0_5 = var_1.SettingLevel
	arg_5_0.init = true
	UIItemList = var_1

	local var_5_0 = var_1.New
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_3.Find(var_5_1, "options")
	local var_5_3 = arg_5_0._tf

	arg_5_0.uilist = var_5_0(var_5_2, var_4.Find(var_5_3, "options/notify_tpl"))

	local var_5_4 = arg_5_0.uilist

	var_1.make(var_5_4, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_5_0

			var_3.UpdateItem(var_6_0, arg_6_1 + 1, arg_6_2)
		end

		return
	end)

	return
end

function var_0_1.JumpToCustomSetting(arg_7_0, arg_7_1)
	if arg_7_0.graphicLevel == var_0_5.Custom then
		return
	end

	arg_7_0:SetPlayerPrefSetting(arg_7_1)

	pg = var_2

	local var_7_0 = var_2.m02
	local var_7_1 = var_2.sendNotification

	GAME = var_5

	local var_7_2 = var_5.APARTMENT_TRACK

	Dorm3dTrackCommand = var_1_10006

	var_7_1(var_7_0, var_7_2, var_1_10006.BuildDataGraphics(4))

	PlayerPrefs = var_7_1

	local var_7_3 = var_7_1.SetInt

	GraphicSettingConst = var_7_0

	var_7_3(var_7_0.PlayerGraphicLevelIsland, 4)

	pg = var_7_3

	local var_7_4 = var_7_3.m02
	local var_7_5 = var_2.sendNotification

	IslandSettingsPage = var_5

	var_7_5(var_7_4, var_5.SELECTCUSTOMGRAPHICSETTING)

	return
end

function var_0_1.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.list[arg_8_1]
	local var_8_1

	var_8_1, setText = arg_8_2:Find("mask/Text"), var_1_10005
	i18n = var_1_10008

	var_1_10005(var_8_1, var_1_10008(var_8_0.settingName))

	local var_8_2 = var_8_0.settingType == var_0_2.toggle
	local var_8_3 = arg_8_2
	local var_8_4 = arg_8_2.Find(var_8_3, "toggle")
	local var_8_5 = arg_8_2:Find("select")

	setActive = var_8_3

	var_8_3(var_8_4, var_8_2)

	setActive = var_8_3

	var_8_3(var_8_5, not var_8_2)

	if var_8_2 then
		local function var_8_6(arg_9_0)
			local var_9_0 = arg_9_0 and 1 or 0

			PlayerPrefs = var_2_10002

			var_2_10002.SetInt(var_8_0.playerPrefsname .. "island", var_9_0)

			return
		end

		local var_8_7 = arg_8_2
		local var_8_8 = arg_8_2.Find(var_8_7, "toggle/off")
		local var_8_9 = arg_8_2:Find("toggle/on")

		var_8_7 = nil

		local function var_8_10(arg_10_0)
			var_8_7 = arg_10_0
			SetActive = var_2_10001

			var_2_10001(var_8_8, not arg_10_0)

			SetActive = var_2_10001

			var_2_10001(var_8_9, arg_10_0)

			return
		end

		onButton = var_13

		local var_8_11 = arg_8_0
		local var_8_12 = var_8_8

		local function var_8_13()
			if var_8_7 == true then
				return
			end

			if var_8_0.tips then
				local var_11_0 = {}

				table = var_2_10001

				var_2_10001.insert(var_11_0, function(arg_12_0)
					pg = var_3_10001

					local var_12_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_12_1 = var_1.ShowMsgBox
					local var_12_2 = {}

					MSGBOX_TYPE_NORMAL = var_3_10005
					var_12_2.type = var_3_10005
					i18n = var_3_10005
					var_12_2.content = var_3_10005(var_8_0.tips)

					function var_12_2.onYes()
						arg_12_0()

						return
					end

					function var_12_2.onNo()
						return
					end

					var_12_1(var_12_0, var_12_2)

					return
				end)

				seriesAsync = var_1

				var_1(var_11_0, function()
					var_8_10(true)
					var_8_6(true)

					local var_15_0 = arg_8_0

					var_0.JumpToCustomSetting(var_15_0, var_8_0)

					return
				end)
			else
				var_8_10(true)
				var_8_6(true)

				if arg_8_0.customSetting and var_8_0.hasChild then
					pg = var_0

					local var_11_1 = var_0.m02
					local var_11_2 = var_0.sendNotification

					IslandSettingsPage = var_2_10003

					var_11_2(var_11_1, var_2_10003.SELECTCUSTOMGRAPHICSETTING)

					return
				end

				local var_11_3 = arg_8_0

				var_0.JumpToCustomSetting(var_11_3, var_8_0)
			end

			return
		end

		SFX_CANCEL = var_1_10018

		var_13(var_8_11, var_8_12, var_8_13, var_1_10018)

		onButton = var_13

		local var_8_14 = arg_8_0
		local var_8_15 = var_8_9

		local function var_8_16()
			if var_8_7 == false then
				return
			end

			var_8_10(false)
			var_8_6(false)

			if arg_8_0.customSetting and var_8_0.hasChild then
				pg = var_0

				local var_16_0 = var_0.m02
				local var_16_1 = var_0.sendNotification

				IslandSettingsPage = var_2_10003

				var_16_1(var_16_0, var_2_10003.SELECTCUSTOMGRAPHICSETTING)

				return
			end

			local var_16_2 = arg_8_0

			var_0.JumpToCustomSetting(var_16_2, var_8_0)

			return
		end

		SFX_CANCEL = var_1_10018

		var_13(var_8_14, var_8_15, var_8_16, var_1_10018)

		local var_8_17

		if arg_8_0.graphicLevel == var_0_5.Custom then
			PlayerPrefs = var_15

			local var_8_18

			if not var_15.GetInt(var_8_0.playerPrefsname .. "island", -1) then
				::label_8_0::

				var_8_18 = nil
			end

			if not var_8_18 or var_8_18 == -1 then
				var_8_18 = var_8_0.defaultValues[arg_8_0.graphicLevel]
			end

			var_8_10(var_8_18 == 1 or var_8_18 == true)

			goto label_8_1

			local var_8_19

			if arg_8_0.graphicLevel == var_0_5.Custom then
				PlayerPrefs = var_10

				do
					local var_8_20

					if not var_10.GetInt(var_8_0.playerPrefsname .. "island", -1) then
						var_8_20 = nil
					end

					if not var_8_20 or var_8_20 == -1 then
						var_8_20 = var_8_0.defaultValues[arg_8_0.graphicLevel]
					end

					ipairs = var_8_7

					for iter_8_0, iter_8_1 in var_8_7(var_8_0.options) do
						if iter_8_1 == var_8_20 then
							var_8_19 = iter_8_0
						end
					end

					;(function()
						local var_17_0 = var_8_19 == 1
						local var_17_1 = var_8_19 == #var_8_0.optionNames

						setActive = var_2

						local var_17_2 = var_8_5

						var_2(var_4.Find(var_17_2, "leftbu"), not var_17_0)

						setActive = var_2

						local var_17_3 = var_8_5

						var_2(var_4.Find(var_17_3, "leftline"), var_17_0)

						setActive = var_2

						local var_17_4 = var_8_5

						var_2(var_4.Find(var_17_4, "rightbu"), not var_17_1)

						setActive = var_2

						local var_17_5 = var_8_5

						var_2(var_4.Find(var_17_5, "rightline"), var_17_1)

						setText = var_2

						local var_17_6 = var_8_5
						local var_17_7 = var_4.Find(var_17_6, "Text")

						i18n = var_5

						var_2(var_17_7, var_5(var_8_0.optionNames[var_8_19]))

						return
					end)()

					onButton = var_12

					var_12(arg_8_0, var_8_5:Find("leftbu"), function()
						var_8_19 = var_8_19 - 1

						var_0()

						PlayerPrefs = var_0

						var_0.SetInt(var_8_0.playerPrefsname .. "island", var_8_0.options[var_8_19])

						local var_18_0 = arg_8_0

						var_0.JumpToCustomSetting(var_18_0, var_8_0)

						return
					end)

					onButton = var_12

					var_12(arg_8_0, var_8_5:Find("rightbu"), function()
						var_8_19 = var_8_19 + 1

						var_0()

						PlayerPrefs = var_0

						var_0.SetInt(var_8_0.playerPrefsname .. "island", var_8_0.options[var_8_19])

						local var_19_0 = arg_8_0

						var_0.JumpToCustomSetting(var_19_0, var_8_0)

						return
					end)
				end

				::label_8_1::

				return
			end
		end
	end
end

function var_0_1.SetPlayerPrefSetting(arg_20_0, arg_20_1)
	if arg_20_0.graphicLevel == var_0_5.Custom then
		return
	end

	ipairs = var_2

	for iter_20_0, iter_20_1 in var_2(var_0_4) do
		if arg_20_1.playerPrefsname .. "island" ~= iter_20_1.playerPrefsname .. "island" then
			local var_20_0 = iter_20_1.defaultValues[arg_20_0.graphicLevel]

			if iter_20_1.settingType == var_0_2.toggle then
				local var_20_1 = var_20_0 and 1 or 0

				PlayerPrefs = var_9

				var_9.SetInt(iter_20_1.playerPrefsname .. "island", var_20_1)
			else
				local var_20_2

				ipairs = var_9

				for iter_20_2, iter_20_3 in var_9(iter_20_1.options) do
					if iter_20_3 == var_20_0 then
						var_20_2 = iter_20_2
					end
				end

				PlayerPrefs = var_9

				var_9.SetInt(iter_20_1.playerPrefsname .. "island", iter_20_1.options[var_20_2])
			end
		end
	end

	return
end

function var_0_1.OnUpdate(arg_21_0)
	if not arg_21_0.init then
		return
	end

	arg_21_0.playerSettingPlaySet = {}
	PlayerPrefs = var_1

	local var_21_0 = var_1.GetInt

	GraphicSettingConst = var_1_10003
	arg_21_0.graphicLevel = var_21_0(var_1_10003.PlayerGraphicLevelIsland, 4)
	arg_21_0.customSetting = arg_21_0.graphicLevel == 4

	local var_21_1 = var_0_3[arg_21_0.graphicLevel]

	arg_21_0.list = arg_21_0:GetList()

	local var_21_2 = arg_21_0.uilist

	var_2.align(var_21_2, #arg_21_0.list)

	return
end

function var_0_1.RefreshPanelByGraphcLevel(arg_22_0)
	arg_22_0:OnUpdate()

	return
end

function var_0_1.GetList(arg_23_0)
	local var_23_0 = {}

	local function var_23_1(arg_24_0)
		local var_24_0 = arg_23_0
		local var_24_1 = var_1.GetParentSetting(var_24_0, arg_24_0.parentId)
		local var_24_2 = false

		if var_24_1 then
			if arg_23_0.customSetting then
				PlayerPrefs = var_3

				local var_24_3

				if not var_3.GetInt(var_24_1.playerPrefsname .. "island", -1) then
					var_24_3 = nil
				end

				if not var_24_3 or var_24_3 == -1 then
					var_24_3 = var_24_1.defaultValues[arg_23_0.graphicLevel]
				end

				var_24_2 = var_24_3 == 0

				return not (arg_24_0.isShow == 0 or var_24_2)
			end
		end
	end

	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(var_0_4) do
		if var_23_1(iter_23_1) then
			table = var_8

			var_8.insert(var_23_0, iter_23_1)
		end
	end

	return var_23_0
end

function var_0_1.GetParentSetting(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return
	end

	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(var_0_4) do
		if iter_25_0 == arg_25_1 then
			iter_25_1.hasChild = true

			return iter_25_1
		end
	end

	return nil
end

return var_0_1
