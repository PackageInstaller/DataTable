local SettingsOtherPanel = class("SettingsOtherPanel", import(".SettingsBasePanel"))

SettingsOtherPanel.GRAPHI_API_SWITCH_OPTION_TYPE = 3

function SettingsOtherPanel:GetUIName()
	return "SettingsOther"
end

function SettingsOtherPanel:GetTitle()
	return i18n("Settings_title_Other")
end

function SettingsOtherPanel:GetTitleEn()
	return "  / OTHER SETTINGS"
end

function SettingsOtherPanel:OnInit(...)
	self.uilist = UIItemList.New(self._tf:Find("options"), self._tf:Find("options/notify_tpl"))

	self.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_5_1 + 1, arg_5_2)
		end

		return
	end)

	if PlayerPrefs.GetInt("AUTOFIGHT_BATTERY_SAVEMODE", 0) > 0 and not pg.BrightnessMgr.GetInstance():IsPermissionGranted() then
		PlayerPrefs.SetInt("AUTOFIGHT_BATTERY_SAVEMODE", 0)
		PlayerPrefs.Save()
	end

	return
end

function SettingsOtherPanel:OnUpdate()
	self.list = self:GetList()

	self.uilist:align(#self.list)

	return
end

function SettingsOtherPanel:UpdateItem(arg_7_1, arg_7_2)
	local var_7_0 = self.list[arg_7_1]

	arg_7_2:Find("mask/Text"):GetComponent("ScrollText"):SetText(self.list[arg_7_1].title)
	onButton(self, arg_7_2:Find("mask/Text"), function()
		pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, var_7_0)

		return
	end, SFX_PANEL)
	removeOnToggle(arg_7_2:Find("on"))

	if self:GetDefaultValue(var_7_0) then
		triggerToggle(arg_7_2:Find("on"), true)
	else
		triggerToggle(arg_7_2:Find("off"), true)
	end

	onToggle(self, arg_7_2:Find("on"), function(arg_9_0)
		self:OnItemSwitch(var_7_0, arg_9_0)

		return
	end, SFX_UI_TAG, SFX_UI_CANCEL)
	self:OnUpdateItem(var_7_0)
	self:OnUpdateItemWithTr(var_7_0, arg_7_2)

	return
end

function SettingsOtherPanel:OnItemSwitch(arg_10_1, arg_10_2)
	if arg_10_1.id == 1 then
		pg.PushNotificationMgr.GetInstance():setSwitchShipName(arg_10_2)
	elseif arg_10_1.id == 5 then
		self:OnClickEffectItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.id == 9 then
		self:OnAutoFightBatterySaveModeItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.id == 10 then
		self:OnAutoFightDownFrameItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == 0 then
		self:OnCommonLocalItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == 1 then
		self:OnCommonServerItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == SettingsOtherPanel.GRAPHI_API_SWITCH_OPTION_TYPE then
		self:OnGraphApiItemSwitch(arg_10_1, arg_10_2)
	end

	if arg_10_1.id == 19 then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNewMainUI({
			isLogin = 0,
			isNewMainUI = arg_10_2 and 1 or 0
		}))
	end

	return
end

function SettingsOtherPanel:OnClickEffectItemSwitch(arg_11_1, arg_11_2)
	local var_11_0 = pg.UIMgr.GetInstance().OverlayEffect

	if var_11_0 then
		setActive(var_11_0, arg_11_2)
	end

	self:OnCommonLocalItemSwitch(arg_11_1, arg_11_2)

	return
end

function SettingsOtherPanel:OnCommonServerItemSwitch(arg_12_1, arg_12_2)
	local var_12_0 = getProxy(PlayerProxy):getRawData():GetCommonFlag(_G[arg_12_1.name])

	if (arg_12_1.default == 1 or nil) and arg_12_2 then
		pg.m02:sendNotification(GAME.CANCEL_COMMON_FLAG, {
			flagID = _G[arg_12_1.name]
		})
	else
		pg.m02:sendNotification(GAME.COMMON_FLAG, {
			flagID = _G[arg_12_1.name]
		})
	end

	return
end

function SettingsOtherPanel:OnAutoFightBatterySaveModeItemSwitch(arg_13_1, arg_13_2)
	local function var_13_0()
		triggerToggle(self.uilist.container:GetChild(arg_13_1.id - 1):Find("off"), true)

		return
	end

	local var_13_1 = pg.BrightnessMgr.GetInstance()

	seriesAsync({
		function(arg_15_0)
			if not arg_13_2 or var_13_1:IsPermissionGranted() then
				return arg_15_0()
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("words_autoFight_right"),
				onYes = function()
					var_13_1:RequestPremission(function(arg_17_0)
						if arg_17_0 then
							arg_15_0()
						else
							var_13_0()
						end

						return
					end)

					return
				end,
				onNo = var_13_0
			})

			return
		end,
		function(arg_18_0)
			PlayerPrefs.SetInt(_G[arg_13_1.name], arg_13_2 and 1 or 0)
			PlayerPrefs.Save()

			local var_18_0 = self.uilist.container:GetChild(arg_13_1.id)

			triggerToggle(var_18_0:Find(arg_13_2 and "on" or "off"), true)
			SettingsOtherPanel.SetGrayOption(var_18_0, arg_13_2)

			return
		end
	})

	return
end

function SettingsOtherPanel:OnAutoFightDownFrameItemSwitch(arg_19_1, arg_19_2)
	if not self:GetDefaultValue(self.list[9]) and arg_19_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("words_autoFight_tips"))
		triggerToggle(self.uilist.container:GetChild(arg_19_1.id - 1):Find("off"), true)

		return
	end

	PlayerPrefs.SetInt(_G[arg_19_1.name], arg_19_2 and 1 or 0)
	PlayerPrefs.Save()

	return
end

function SettingsOtherPanel:SetGrayOption(arg_20_1)
	setGray(self:Find("on"), not arg_20_1)
	setGray(self:Find("off"), not arg_20_1)

	return
end

function SettingsOtherPanel:OnCommonLocalItemSwitch(arg_21_1, arg_21_2)
	PlayerPrefs.SetInt(_G[arg_21_1.name], arg_21_2 and 1 or 0)
	PlayerPrefs.Save()

	return
end

function SettingsOtherPanel:OnGraphApiItemSwitch(arg_22_1, arg_22_2)
	local function var_22_0()
		triggerToggle(self.uilist.container:GetChild(#self.list - 1):Find("off"), true)
		GraphApiHelper.SetForceGraphApi(GraphApiHelper.Api.Force_OpenGLES)

		return
	end

	local function var_22_1()
		triggerToggle(self.uilist.container:GetChild(#self.list - 1):Find("on"), true)
		GraphApiHelper.SetForceGraphApi(GraphApiHelper.Api.Force_Vulkan)

		return
	end

	if arg_22_2 == false and not GraphApiHelper.IsUsingVulkan() or arg_22_2 == true and GraphApiHelper.IsUsingVulkan() then
		return
	end

	if arg_22_2 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("graphi_api_switch_vulkan"),
			onYes = function()
				var_22_1()
				Application.Quit()

				return
			end,
			onNo = var_22_0
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("graphi_api_switch_opengl"),
			onYes = function()
				var_22_0()
				Application.Quit()

				return
			end,
			onNo = var_22_1
		})
	end

	return
end

function SettingsOtherPanel:OnUpdateItem(arg_27_1)
	if arg_27_1.id == 10 then
		SettingsOtherPanel.SetGrayOption(self.uilist.container:GetChild(arg_27_1.id - 1), self:GetDefaultValue(self.list[9]))
	end

	return
end

function SettingsOtherPanel:OnUpdateItemWithTr(arg_28_1, arg_28_2)
	local var_28_0 = findTF(arg_28_2, "mask/tip")

	setActive(var_28_0, false)

	if arg_28_1.id == 18 then
		onButton(self, var_28_0, function()
			pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, arg_28_1)

			return
		end, SFX_PANEL)
		setActive(var_28_0, true)
	end

	return
end

function SettingsOtherPanel:GetDefaultValue(arg_30_1)
	if arg_30_1.id == 1 then
		return pg.PushNotificationMgr.GetInstance():isEnableShipName()
	elseif arg_30_1.id == 17 then
		return getProxy(SettingsProxy):IsDisplayResultPainting()
	elseif arg_30_1.type == 0 then
		return PlayerPrefs.GetInt(_G[arg_30_1.name], (not arg_30_1.default or nil) and 0) > 0
	elseif arg_30_1.type == 1 then
		local var_30_1 = getProxy(PlayerProxy):getRawData():GetCommonFlag(_G[arg_30_1.name])

		if arg_30_1.default == 1 then
			return not var_30_1
		else
			return var_30_1
		end
	elseif arg_30_1.type == SettingsOtherPanel.GRAPHI_API_SWITCH_OPTION_TYPE then
		return GraphApiHelper.IsUsingVulkan()
	end

	return
end

function SettingsOtherPanel:GetList()
	local var_31_0 = {}
	local var_31_1

	for iter_31_0, iter_31_1 in ipairs(pg.settings_other_template.all) do
		if LOCK_BATTERY_SAVEMODE and (iter_31_1 == 9 or iter_31_1 == 10) then
			-- block empty
		elseif LOCK_L2D_GYRO and iter_31_1 == 15 then
			-- block empty
		elseif pg.settings_other_template[iter_31_1].type == SettingsOtherPanel.GRAPHI_API_SWITCH_OPTION_TYPE then
			if PermissionHelper.IsAndroid() then
				var_31_1 = pg.settings_other_template[iter_31_1]
			end
		else
			table.insert(var_31_0, pg.settings_other_template[iter_31_1])
		end
	end

	if var_31_1 then
		table.insert(var_31_0, var_31_1)
	end

	return var_31_0
end

return SettingsOtherPanel
