local var_0_0 = class("IslandSettingsPage", import("...base.IslandBasePage"))

var_0_0.SELECTCUSTOMGRAPHICSETTING = "IslandSettingsPage:SelectCustomGraphicSetting"
var_0_0.SELECTGRAPHICSETTINGLEVEL = "IslandSettingsPage:SelectGraphicSettinglevel"

function var_0_0.getUIName(arg_1_0)
	return "IslandNewSettingsUI"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddListener(var_0_0.SELECTCUSTOMGRAPHICSETTING, arg_2_0.OnSelectCustomGraphicSetting)
	arg_2_0:AddListener(var_0_0.SELECTGRAPHICSETTINGLEVEL, arg_2_0.OnSelectGraphicSettingLevel)
	arg_2_0:AddListener(GAME.ISLAND_SETTING_FLAG_DONE, arg_2_0.OnSettingFlagDone)

	return
end

function var_0_0.RemoveListeners(arg_3_0)
	arg_3_0:RemoveListener(var_0_0.SELECTCUSTOMGRAPHICSETTING, arg_3_0.OnSelectCustomGraphicSetting)
	arg_3_0:RemoveListener(var_0_0.SELECTGRAPHICSETTINGLEVEL, arg_3_0.OnSelectGraphicSettingLevel)
	arg_3_0:RemoveListener(GAME.ISLAND_SETTING_FLAG_DONE, arg_3_0.OnSettingFlagDone)

	return
end

function var_0_0.OnSelectGraphicSettingLevel(arg_4_0)
	arg_4_0:emit(IslandSettingsOtherGraphicsPanle.EVT_UPDTAE)

	return
end

function var_0_0.OnSelectCustomGraphicSetting(arg_5_0)
	arg_5_0:emit(IslandSettingsGraphicsPanle.EVT_UPDTAE)

	return
end

function var_0_0.OnSettingFlagDone(arg_6_0)
	local var_6_0 = arg_6_0:GetPage(IslandSettingsCommonPage)

	if var_6_0 and var_6_0:GetLoaded() then
		var_6_0:Update()
	end

	return
end

function var_0_0.GetPage(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.pages) do
		if isa(iter_7_1, arg_7_1) then
			return iter_7_1
		end
	end

	return
end

function var_0_0.OnLoaded(arg_8_0)
	arg_8_0.backBtn = arg_8_0._tf:Find("top/closeBtn")

	local var_8_0 = arg_8_0._tf:Find("pages")

	arg_8_0.pages = {
		IslandSettings3DPage.New(var_8_0, arg_8_0.event, {}),
		IslandSettingsOperationPage.New(var_8_0, arg_8_0.event),
		IslandSettingsCommonPage.New(var_8_0, arg_8_0.event, arg_8_0.contextData)
	}
	arg_8_0.toggles = {
		arg_8_0._tf:Find("adapt/left_length/imageQuality"),
		arg_8_0._tf:Find("adapt/left_length/operation"),
		arg_8_0._tf:Find("adapt/left_length/common")
	}

	;(function(arg_9_0, arg_9_1)
		setText(arg_9_0:Find("selected/name"), arg_9_1)
		setText(arg_9_0:Find("name"), arg_9_1)

		return
	end)(arg_8_0._tf:Find("adapt/left_length/imageQuality"), i18n("grapihcs3d_setting_3Dquality"))
	;(function(arg_9_0, arg_9_1)
		setText(arg_9_0:Find("selected/name"), arg_9_1)
		setText(arg_9_0:Find("name"), arg_9_1)

		return
	end)(arg_8_0._tf:Find("adapt/left_length/operation"), i18n("grapihcs3d_setting_control"))
	;(function(arg_9_0, arg_9_1)
		setText(arg_9_0:Find("selected/name"), arg_9_1)
		setText(arg_9_0:Find("name"), arg_9_1)

		return
	end)(arg_8_0._tf:Find("adapt/left_length/common"), i18n("grapihcs3d_setting_general"))
	setText(arg_8_0._tf:Find("top/title/Text"), i18n("island_settings"))
	setText(arg_8_0._tf:Find("top/title/Text/en"), i18n("island_settings_en"))

	return
end

function var_0_0.OnShow(arg_10_0)
	onButton(arg_10_0, arg_10_0.backBtn, function()
		arg_10_0:Hide()

		return
	end, SFX_CANCEL)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.toggles) do
		onToggle(arg_10_0, iter_10_1, function(arg_12_0)
			if arg_12_0 then
				arg_10_0:SwitchPage(iter_10_0)
			end

			return
		end, SFX_PANEL)
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_10_0._tf)
	arg_10_0:EnterDefaultPage()

	return
end

function var_0_0.EnterDefaultPage(arg_13_0)
	triggerToggle(arg_13_0.toggles[1], true)

	return
end

function var_0_0.SwitchPage(arg_14_0, arg_14_1)
	if arg_14_0.page and arg_14_0.page ~= arg_14_0.pages[arg_14_1] and arg_14_0.page:GetLoaded() then
		arg_14_0.page:Hide()
	end

	arg_14_0.pages[arg_14_1]:ExecuteAction("Show")

	arg_14_0.page = arg_14_0.pages[arg_14_1]

	if isa(arg_14_0.pages[arg_14_1], IslandSettings3DPage) then
		arg_14_0.hasShow3d = true
	end

	if isa(arg_14_0.pages[arg_14_1], IslandSettingsOperationPage) then
		arg_14_0.hasShowOP = true
	end

	return
end

function var_0_0.GetPage(arg_15_0, arg_15_1)
	if not arg_15_0.pages then
		return nil
	end

	return _.detect(arg_15_0.pages, function(arg_16_0)
		return isa(arg_16_0, arg_15_1)
	end)
end

function var_0_0.OnHide(arg_17_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_17_0._tf)

	if arg_17_0.hasShow3d then
		GraphicSettingConst.SettingQuality(true)
	end

	if arg_17_0.hasShowOP then
		arg_17_0:emitCore(ISLAND_EVT.UPDATE_CUSTOM_OP_POSITON)
	end

	local var_17_0 = arg_17_0:GetPage(IslandSettingsCommonPage)

	if var_17_0 and var_17_0:GetLoaded() then
		var_17_0:Save()
	end

	return
end

function var_0_0.OnDisable(arg_18_0)
	arg_18_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_19_0)
	arg_19_0:OnHide()

	for iter_19_0, iter_19_1 in pairs(arg_19_0.pages) do
		iter_19_1:Destroy()
	end

	arg_19_0.page = nil
	arg_19_0.pages = nil

	return
end

return var_0_0
