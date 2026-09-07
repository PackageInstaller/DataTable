local SettingsOtherGraphicsPanle = class("SettingsOtherGraphicsPanle", import(".SettingsBasePanel"))

SettingsOtherGraphicsPanle.EVT_UPDTAE = "SettingsOtherGraphicsPanle:EVT_UPDTAE"

local var_0_1
local var_0_2
local var_0_3
local var_0_4

function SettingsOtherGraphicsPanle:GetUIName()
	return "GraphicSettingsOther"
end

function SettingsOtherGraphicsPanle:GetTitle()
	return i18n("grapihcs3d_setting_universal")
end

function SettingsOtherGraphicsPanle:GetTitleEn()
	return "  / STANDBY MODE SETTINGS"
end

function SettingsOtherGraphicsPanle:OnInit()
	var_0_1 = GraphicSettingConst.SettingType
	var_0_2 = GraphicSettingConst.assetPath
	var_0_3 = GraphicSettingConst.settings
	var_0_4 = GraphicSettingConst.SettingLevel
	self.init = true
	self.uilist = UIItemList.New(self._tf:Find("options"), self._tf:Find("options/notify_tpl"))

	self.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_5_1 + 1, arg_5_2)
		end

		return
	end)

	return
end

function SettingsOtherGraphicsPanle:JumpToCustomSetting(arg_6_1)
	if self.graphicLevel == var_0_4.Custom then
		return
	end

	self:SetPlayerPrefSetting(arg_6_1)
	pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGraphics(4))
	PlayerPrefs.SetInt("dorm3d_graphics_settings_new", 4)
	pg.m02:sendNotification(NewSettingsMediator.SelectCustomGraphicSetting)

	return
end

function SettingsOtherGraphicsPanle:UpdateItem(arg_7_1, arg_7_2)
	local var_7_0 = self.list[arg_7_1]

	setText(arg_7_2:Find("mask/Text"), i18n(self.list[arg_7_1].settingName))

	local var_7_1 = var_7_0.settingType == var_0_1.toggle
	local var_7_2 = arg_7_2:Find("select")

	setActive(arg_7_2:Find("toggle"), var_7_0.settingType == var_0_1.toggle)
	setActive(var_7_2, not var_7_1)

	if var_7_1 then
		local function var_7_3(arg_8_0)
			PlayerPrefs.SetInt(var_7_0.playerPrefsname, arg_8_0 and 1 or 0)

			return
		end

		local var_7_4 = arg_7_2:Find("toggle/off")
		local var_7_5 = arg_7_2:Find("toggle/on")
		local var_7_6

		local function var_7_7(arg_9_0)
			var_7_6 = arg_9_0

			SetActive(var_7_4:Find("show"), not arg_9_0)
			SetActive(var_7_5:Find("show"), arg_9_0)

			return
		end

		onButton(self, var_7_5, function()
			if var_7_6 == true then
				return
			end

			if var_7_0.tips then
				local var_10_0 = {}

				table.insert(var_10_0, function(arg_11_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_NORMAL,
						content = i18n(var_7_0.tips),
						onYes = function()
							arg_11_0()

							return
						end,
						onNo = function()
							return
						end
					})

					return
				end)
				seriesAsync(var_10_0, function()
					var_7_7(true)
					var_7_3(true)
					self:JumpToCustomSetting(var_7_0)

					return
				end)
			else
				var_7_7(true)
				var_7_3(true)

				if self.customSetting and var_7_0.hasChild then
					pg.m02:sendNotification(NewSettingsMediator.SelectCustomGraphicSetting)

					return
				end

				self:JumpToCustomSetting(var_7_0)
			end

			return
		end, SFX_CANCEL)
		onButton(self, var_7_4, function()
			if var_7_6 == false then
				return
			end

			var_7_7(false)
			var_7_3(false)

			if self.customSetting and var_7_0.hasChild then
				pg.m02:sendNotification(NewSettingsMediator.SelectCustomGraphicSetting)

				return
			end

			self:JumpToCustomSetting(var_7_0)

			return
		end, SFX_CANCEL)

		local var_7_8 = self.graphicLevel == var_0_4.Custom and PlayerPrefs.GetInt(var_7_0.playerPrefsname, -1) or nil

		if not var_7_8 or var_7_8 == -1 then
			var_7_8 = var_7_0.defaultValues[self.graphicLevel]
		end

		var_7_7(var_7_8 == 1 or var_7_8 == true)
	else
		local var_7_10
		local var_7_11 = self.graphicLevel == var_0_4.Custom and PlayerPrefs.GetInt(var_7_0.playerPrefsname, -1) or nil

		if not var_7_11 or var_7_11 == -1 then
			var_7_11 = var_7_0.defaultValues[self.graphicLevel]
		end

		for iter_7_0, iter_7_1 in ipairs(var_7_0.options) do
			if iter_7_1 == var_7_11 then
				var_7_10 = iter_7_0
			end
		end

		local function var_7_12()
			local var_16_0 = var_7_10 == #var_7_0.optionNames

			setActive(var_7_2:Find("leftbu"), not (var_7_10 == 1))
			setActive(var_7_2:Find("rightbu"), not var_16_0)
			setText(var_7_2:Find("Text"), i18n(var_7_0.optionNames[var_7_10]))

			return
		end

		var_7_12()
		onButton(self, var_7_2:Find("leftbu"), function()
			var_7_10 = var_7_10 - 1

			var_7_12()
			PlayerPrefs.SetInt(var_7_0.playerPrefsname, var_7_0.options[var_7_10])
			self:JumpToCustomSetting(var_7_0)

			return
		end)
		onButton(self, var_7_2:Find("rightbu"), function()
			var_7_10 = var_7_10 + 1

			var_7_12()
			PlayerPrefs.SetInt(var_7_0.playerPrefsname, var_7_0.options[var_7_10])
			self:JumpToCustomSetting(var_7_0)

			return
		end)
	end

	return
end

function SettingsOtherGraphicsPanle:SetPlayerPrefSetting(arg_19_1)
	if self.graphicLevel == var_0_4.Custom then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(var_0_3) do
		if arg_19_1.playerPrefsname ~= iter_19_1.playerPrefsname then
			local var_19_0 = iter_19_1.defaultValues[self.graphicLevel]

			if iter_19_1.settingType == var_0_1.toggle then
				PlayerPrefs.SetInt(iter_19_1.playerPrefsname, var_19_0 and 1 or 0)
			else
				local var_19_1

				for iter_19_2, iter_19_3 in ipairs(iter_19_1.options) do
					if iter_19_3 == var_19_0 then
						var_19_1 = iter_19_2
					end
				end

				PlayerPrefs.SetInt(iter_19_1.playerPrefsname, iter_19_1.options[var_19_1])
			end
		end
	end

	return
end

function SettingsOtherGraphicsPanle:OnUpdate()
	if not self.init then
		return
	end

	self.playerSettingPlaySet = {}
	self.graphicLevel = PlayerPrefs.GetInt("dorm3d_graphics_settings_new", 4)
	self.customSetting = self.graphicLevel == 4
	self.list = self:GetList()

	self.uilist:align(#self.list)

	return
end

function SettingsOtherGraphicsPanle:RefreshPanelByGraphcLevel()
	self:OnUpdate()

	return
end

function SettingsOtherGraphicsPanle:GetList()
	local var_22_0 = {}

	local function var_22_1(arg_23_0)
		local var_23_0 = self:GetParentSetting(arg_23_0.parentId)
		local var_23_1 = false

		if var_23_0 then
			local var_23_2 = self.customSetting and PlayerPrefs.GetInt(var_23_0.playerPrefsname, -1) or nil

			if not var_23_2 or var_23_2 == -1 then
				var_23_2 = var_23_0.defaultValues[self.graphicLevel]
			end

			var_23_1 = var_23_2 == 0
		end

		return not (arg_23_0.isShow == 0 or var_23_1)
	end

	for iter_22_0, iter_22_1 in ipairs(var_0_3) do
		if var_22_1(iter_22_1) then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function SettingsOtherGraphicsPanle:GetParentSetting(arg_24_1)
	if not arg_24_1 then
		return
	end

	for iter_24_0, iter_24_1 in ipairs(var_0_3) do
		if iter_24_0 == arg_24_1 then
			iter_24_1.hasChild = true

			return iter_24_1
		end
	end

	return nil
end

return SettingsOtherGraphicsPanle
