local var_0_0 = class("SettingsOtherPanel", import(".SettingsBasePanel"))

var_0_0.GRAPHI_API_SWITCH_OPTION_TYPE = 3

function var_0_0.GetUIName(arg_1_0)
	return "SettingsOther"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_Other")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / OTHER SETTINGS"
end

function var_0_0.OnInit(arg_4_0, ...)
	arg_4_0.uilist = UIItemList.New(arg_4_0._tf:Find("options"), arg_4_0._tf:Find("options/notify_tpl"))

	arg_4_0.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_4_0:UpdateItem(arg_5_1 + 1, arg_5_2)
		end

		return
	end)

	if PlayerPrefs.GetInt("AUTOFIGHT_BATTERY_SAVEMODE", 0) > 0 and not pg.BrightnessMgr.GetInstance():IsPermissionGranted() then
		PlayerPrefs.SetInt("AUTOFIGHT_BATTERY_SAVEMODE", 0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.OnUpdate(arg_6_0)
	arg_6_0.list = arg_6_0:GetList()

	arg_6_0.uilist:align(#arg_6_0.list)

	return
end

function var_0_0.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.list[arg_7_1]

	arg_7_2:Find("mask/Text"):GetComponent("ScrollText"):SetText(arg_7_0.list[arg_7_1].title)
	onButton(arg_7_0, arg_7_2:Find("mask/Text"), function()
		pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, var_7_0)

		return
	end, SFX_PANEL)
	removeOnToggle(arg_7_2:Find("on"))

	if arg_7_0:GetDefaultValue(var_7_0) then
		triggerToggle(arg_7_2:Find("on"), true)
	else
		triggerToggle(arg_7_2:Find("off"), true)
	end

	onToggle(arg_7_0, arg_7_2:Find("on"), function(arg_9_0)
		arg_7_0:OnItemSwitch(var_7_0, arg_9_0)

		return
	end, SFX_UI_TAG, SFX_UI_CANCEL)
	arg_7_0:OnUpdateItem(var_7_0)
	arg_7_0:OnUpdateItemWithTr(var_7_0, arg_7_2)

	return
end

function var_0_0.OnItemSwitch(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1.id == 1 then
		pg.PushNotificationMgr.GetInstance():setSwitchShipName(arg_10_2)
	elseif arg_10_1.id == 5 then
		arg_10_0:OnClickEffectItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.id == 9 then
		arg_10_0:OnAutoFightBatterySaveModeItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.id == 10 then
		arg_10_0:OnAutoFightDownFrameItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == 0 then
		arg_10_0:OnCommonLocalItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == 1 then
		arg_10_0:OnCommonServerItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == var_0_0.GRAPHI_API_SWITCH_OPTION_TYPE then
		arg_10_0:OnGraphApiItemSwitch(arg_10_1, arg_10_2)
	end

	if arg_10_1.id == 19 then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNewMainUI({
			isLogin = 0,
			isNewMainUI = arg_10_2 and 1 or 0
		}))
	end

	return
end

function var_0_0.OnClickEffectItemSwitch(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = pg.UIMgr.GetInstance().OverlayEffect

	if var_11_0 then
		setActive(var_11_0, arg_11_2)
	end

	arg_11_0:OnCommonLocalItemSwitch(arg_11_1, arg_11_2)

	return
end

function var_0_0.OnCommonServerItemSwitch(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = getProxy(PlayerProxy):getRawData():GetCommonFlag(_G[arg_12_1.name])
	local var_12_1 = not arg_12_2

	if arg_12_1.default == 1 then
		var_12_1 = arg_12_2
	end

	if var_12_1 then
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

function var_0_0.OnAutoFightBatterySaveModeItemSwitch(arg_13_0, arg_13_1, arg_13_2)
	local function var_13_0()
		triggerToggle(arg_13_0.uilist.container:GetChild(arg_13_1.id - 1):Find("off"), true)

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

			local var_18_0 = arg_13_0.uilist.container:GetChild(arg_13_1.id)

			triggerToggle(var_18_0:Find(arg_13_2 and "on" or "off"), true)
			var_0_0.SetGrayOption(var_18_0, arg_13_2)

			return
		end
	})

	return
end

function var_0_0.OnAutoFightDownFrameItemSwitch(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0

	if not arg_19_0:GetDefaultValue(arg_19_0.list[9]) and arg_19_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("words_autoFight_tips"))
		triggerToggle(arg_19_0.uilist.container:GetChild(arg_19_1.id - 1):Find("off"), true)

		do return end

		var_19_0 = PlayerPrefs.SetInt
	end

	var_19_0(_G[arg_19_1.name], arg_19_2 and 1 or 0)
	PlayerPrefs.Save()

	return
end

function var_0_0.SetGrayOption(arg_20_0, arg_20_1)
	setGray(arg_20_0:Find("on"), not arg_20_1)
	setGray(arg_20_0:Find("off"), not arg_20_1)

	return
end

function var_0_0.OnCommonLocalItemSwitch(arg_21_0, arg_21_1, arg_21_2)
	PlayerPrefs.SetInt(_G[arg_21_1.name], arg_21_2 and 1 or 0)
	PlayerPrefs.Save()

	return
end

function var_0_0.OnGraphApiItemSwitch(arg_22_0, arg_22_1, arg_22_2)
	local function var_22_0()
		triggerToggle(arg_22_0.uilist.container:GetChild(#arg_22_0.list - 1):Find("off"), true)
		GraphApiHelper.SetForceGraphApi(GraphApiHelper.Api.Force_OpenGLES)

		return
	end

	local function var_22_1()
		triggerToggle(arg_22_0.uilist.container:GetChild(#arg_22_0.list - 1):Find("on"), true)
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
			onNo = function()
				triggerToggle(arg_22_0.uilist.container:GetChild(#arg_22_0.list - 1):Find("off"), true)
				GraphApiHelper.SetForceGraphApi(GraphApiHelper.Api.Force_OpenGLES)

				return
			end
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("graphi_api_switch_opengl"),
			onYes = function()
				var_22_0()
				Application.Quit()

				return
			end,
			onNo = function()
				triggerToggle(arg_22_0.uilist.container:GetChild(#arg_22_0.list - 1):Find("on"), true)
				GraphApiHelper.SetForceGraphApi(GraphApiHelper.Api.Force_Vulkan)

				return
			end
		})
	end

	return
end

function var_0_0.OnUpdateItem(arg_27_0, arg_27_1)
	if arg_27_1.id == 10 then
		var_0_0.SetGrayOption(arg_27_0.uilist.container:GetChild(arg_27_1.id - 1), arg_27_0:GetDefaultValue(arg_27_0.list[9]))
	end

	return
end

function var_0_0.OnUpdateItemWithTr(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = findTF(arg_28_2, "mask/tip")

	setActive(var_28_0, false)

	if arg_28_1.id == 18 then
		onButton(arg_28_0, var_28_0, function()
			pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, arg_28_1)

			return
		end, SFX_PANEL)
		setActive(var_28_0, true)
	end

	return
end

function var_0_0.GetDefaultValue(arg_30_0, arg_30_1)
	if arg_30_1.id == 1 then
		return pg.PushNotificationMgr.GetInstance():isEnableShipName()
	elseif arg_30_1.id == 17 then
		return getProxy(SettingsProxy):IsDisplayResultPainting()
	elseif arg_30_1.type == 0 then
		local var_30_1 = _G[arg_30_1.name]
		local var_30_2 = arg_30_1.default or 0

		return var_30_0(var_30_1, var_30_2) > 0
	elseif arg_30_1.type == 1 then
		local var_30_3 = getProxy(PlayerProxy):getRawData():GetCommonFlag(_G[arg_30_1.name])

		if arg_30_1.default == 1 then
			return not var_30_3
		else
			return var_30_3
		end
	elseif arg_30_1.type == var_0_0.GRAPHI_API_SWITCH_OPTION_TYPE then
		return GraphApiHelper.IsUsingVulkan()
	end

	return
end

function var_0_0.GetList(arg_31_0)
	local var_31_0

	for iter_31_0, iter_31_1 in ipairs(pg.settings_other_template.all) do
		if LOCK_BATTERY_SAVEMODE and (iter_31_1 == 9 or iter_31_1 == 10) then
			-- block empty
		elseif LOCK_L2D_GYRO and iter_31_1 == 15 then
			-- block empty
		elseif pg.settings_other_template[iter_31_1].type == var_0_0.GRAPHI_API_SWITCH_OPTION_TYPE then
			if PermissionHelper.IsAndroid() then
				var_31_0 = pg.settings_other_template[iter_31_1]
			end
		else
			table.insert({}, pg.settings_other_template[iter_31_1])
		end
	end

	if var_31_0 then
		table.insert({}, var_31_0)
	end

	return {}
end

return var_0_0
