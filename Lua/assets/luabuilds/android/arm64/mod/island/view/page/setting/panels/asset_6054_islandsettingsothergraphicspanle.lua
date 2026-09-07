local IslandSettingsOtherGraphicsPanle = class("IslandSettingsOtherGraphicsPanle", import("view.Setting.panels.SettingsBasePanel"))

IslandSettingsOtherGraphicsPanle.EVT_UPDTAE = "IslandSettingsOtherGraphicsPanle:EVT_UPDTAE"

local var_0_1
local var_0_2
local var_0_3
local var_0_4

function IslandSettingsOtherGraphicsPanle:GetUIName()
	return "IslandGraphicSettingsOther"
end

function IslandSettingsOtherGraphicsPanle:GetTitle()
	return i18n("grapihcs3d_setting_universal")
end

function IslandSettingsOtherGraphicsPanle:GetTitleEn()
	return "  / STANDBY MODE SETTINGS"
end

function IslandSettingsOtherGraphicsPanle:InitTitle()
	setText(self._tf:Find("title/title_point/title_text"), self:GetTitle())

	return
end

function IslandSettingsOtherGraphicsPanle:OnInit()
	var_0_1 = GraphicSettingConst.SettingType
	var_0_2 = GraphicSettingConst.assetPath
	var_0_3 = GraphicSettingConst.settings
	var_0_4 = GraphicSettingConst.SettingLevel
	self.init = true
	self.uilist = UIItemList.New(self._tf:Find("options"), self._tf:Find("options/notify_tpl"))

	self.uilist:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_6_1 + 1, arg_6_2)
		end

		return
	end)

	return
end

function IslandSettingsOtherGraphicsPanle:JumpToCustomSetting(arg_7_1)
	if self.graphicLevel == var_0_4.Custom then
		return
	end

	self:SetPlayerPrefSetting(arg_7_1)
	pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGraphics(4))
	PlayerPrefs.SetInt(GraphicSettingConst.PlayerGraphicLevelIsland, 4)
	pg.m02:sendNotification(IslandSettingsPage.SELECTCUSTOMGRAPHICSETTING)

	return
end

function IslandSettingsOtherGraphicsPanle:UpdateItem(arg_8_1, arg_8_2)
	local var_8_0 = self.list[arg_8_1]

	setText(arg_8_2:Find("mask/Text"), i18n(self.list[arg_8_1].settingName))

	local var_8_1 = var_8_0.settingType == var_0_1.toggle
	local var_8_2 = arg_8_2:Find("select")

	setActive(arg_8_2:Find("toggle"), var_8_0.settingType == var_0_1.toggle)
	setActive(var_8_2, not var_8_1)

	if var_8_1 then
		local function var_8_3(arg_9_0)
			PlayerPrefs.SetInt(var_8_0.playerPrefsname .. "island", arg_9_0 and 1 or 0)

			return
		end

		local var_8_4 = arg_8_2:Find("toggle/off")
		local var_8_5 = arg_8_2:Find("toggle/on")
		local var_8_6

		local function var_8_7(arg_10_0)
			var_8_6 = arg_10_0

			SetActive(var_8_4, not arg_10_0)
			SetActive(var_8_5, arg_10_0)

			return
		end

		onButton(self, var_8_4, function()
			if var_8_6 == true then
				return
			end

			if var_8_0.tips then
				local var_11_0 = {}

				table.insert(var_11_0, function(arg_12_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_NORMAL,
						content = i18n(var_8_0.tips),
						onYes = function()
							arg_12_0()

							return
						end,
						onNo = function()
							return
						end
					})

					return
				end)
				seriesAsync(var_11_0, function()
					var_8_7(true)
					var_8_3(true)
					self:JumpToCustomSetting(var_8_0)

					return
				end)
			else
				var_8_7(true)
				var_8_3(true)

				if self.customSetting and var_8_0.hasChild then
					pg.m02:sendNotification(IslandSettingsPage.SELECTCUSTOMGRAPHICSETTING)

					return
				end

				self:JumpToCustomSetting(var_8_0)
			end

			return
		end, SFX_CANCEL)
		onButton(self, var_8_5, function()
			if var_8_6 == false then
				return
			end

			var_8_7(false)
			var_8_3(false)

			if self.customSetting and var_8_0.hasChild then
				pg.m02:sendNotification(IslandSettingsPage.SELECTCUSTOMGRAPHICSETTING)

				return
			end

			self:JumpToCustomSetting(var_8_0)

			return
		end, SFX_CANCEL)

		local var_8_8 = self.graphicLevel == var_0_4.Custom and PlayerPrefs.GetInt(var_8_0.playerPrefsname .. "island", -1) or nil

		if not var_8_8 or var_8_8 == -1 then
			var_8_8 = var_8_0.defaultValues[self.graphicLevel]
		end

		var_8_7(var_8_8 == 1 or var_8_8 == true)
	else
		local var_8_10
		local var_8_11 = self.graphicLevel == var_0_4.Custom and PlayerPrefs.GetInt(var_8_0.playerPrefsname .. "island", -1) or nil

		if not var_8_11 or var_8_11 == -1 then
			var_8_11 = var_8_0.defaultValues[self.graphicLevel]
		end

		for iter_8_0, iter_8_1 in ipairs(var_8_0.options) do
			if iter_8_1 == var_8_11 then
				var_8_10 = iter_8_0
			end
		end

		local function var_8_12()
			local var_17_0 = var_8_10 == 1
			local var_17_1 = var_8_10 == #var_8_0.optionNames

			setActive(var_8_2:Find("leftbu"), not (var_8_10 == 1))
			setActive(var_8_2:Find("leftline"), var_17_0)
			setActive(var_8_2:Find("rightbu"), not var_17_1)
			setActive(var_8_2:Find("rightline"), var_17_1)
			setText(var_8_2:Find("Text"), i18n(var_8_0.optionNames[var_8_10]))

			return
		end

		var_8_12()
		onButton(self, var_8_2:Find("leftbu"), function()
			var_8_10 = var_8_10 - 1

			var_8_12()
			PlayerPrefs.SetInt(var_8_0.playerPrefsname .. "island", var_8_0.options[var_8_10])
			self:JumpToCustomSetting(var_8_0)

			return
		end)
		onButton(self, var_8_2:Find("rightbu"), function()
			var_8_10 = var_8_10 + 1

			var_8_12()
			PlayerPrefs.SetInt(var_8_0.playerPrefsname .. "island", var_8_0.options[var_8_10])
			self:JumpToCustomSetting(var_8_0)

			return
		end)
	end

	return
end

function IslandSettingsOtherGraphicsPanle:SetPlayerPrefSetting(arg_20_1)
	if self.graphicLevel == var_0_4.Custom then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(var_0_3) do
		if arg_20_1.playerPrefsname .. "island" ~= iter_20_1.playerPrefsname .. "island" then
			local var_20_0 = iter_20_1.defaultValues[self.graphicLevel]

			if iter_20_1.settingType == var_0_1.toggle then
				PlayerPrefs.SetInt(iter_20_1.playerPrefsname .. "island", var_20_0 and 1 or 0)
			else
				local var_20_1

				for iter_20_2, iter_20_3 in ipairs(iter_20_1.options) do
					if iter_20_3 == var_20_0 then
						var_20_1 = iter_20_2
					end
				end

				PlayerPrefs.SetInt(iter_20_1.playerPrefsname .. "island", iter_20_1.options[var_20_1])
			end
		end
	end

	return
end

function IslandSettingsOtherGraphicsPanle:OnUpdate()
	if not self.init then
		return
	end

	self.playerSettingPlaySet = {}
	self.graphicLevel = PlayerPrefs.GetInt(GraphicSettingConst.PlayerGraphicLevelIsland, 4)
	self.customSetting = self.graphicLevel == 4
	self.list = self:GetList()

	self.uilist:align(#self.list)

	return
end

function IslandSettingsOtherGraphicsPanle:RefreshPanelByGraphcLevel()
	self:OnUpdate()

	return
end

function IslandSettingsOtherGraphicsPanle:GetList()
	local var_23_0 = {}

	local function var_23_1(arg_24_0)
		local var_24_0 = self:GetParentSetting(arg_24_0.parentId)
		local var_24_1 = false

		if var_24_0 then
			local var_24_2 = self.customSetting and PlayerPrefs.GetInt(var_24_0.playerPrefsname .. "island", -1) or nil

			if not var_24_2 or var_24_2 == -1 then
				var_24_2 = var_24_0.defaultValues[self.graphicLevel]
			end

			var_24_1 = var_24_2 == 0
		end

		return not (arg_24_0.isShow == 0 or var_24_1)
	end

	for iter_23_0, iter_23_1 in ipairs(var_0_3) do
		if var_23_1(iter_23_1) then
			table.insert(var_23_0, iter_23_1)
		end
	end

	return var_23_0
end

function IslandSettingsOtherGraphicsPanle:GetParentSetting(arg_25_1)
	if not arg_25_1 then
		return
	end

	for iter_25_0, iter_25_1 in ipairs(var_0_3) do
		if iter_25_0 == arg_25_1 then
			iter_25_1.hasChild = true

			return iter_25_1
		end
	end

	return nil
end

return IslandSettingsOtherGraphicsPanle
