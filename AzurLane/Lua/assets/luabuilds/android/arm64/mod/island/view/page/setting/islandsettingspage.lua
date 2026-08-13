class = var_0_10000

local var_0_0 = "IslandSettingsPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

var_0_1.SELECTCUSTOMGRAPHICSETTING = "IslandSettingsPage:SelectCustomGraphicSetting"
var_0_1.SELECTGRAPHICSETTINGLEVEL = "IslandSettingsPage:SelectGraphicSettinglevel"

function var_0_1.getUIName(arg_1_0)
	return "IslandNewSettingsUI"
end

function var_0_1.AddListeners(arg_2_0)
	arg_2_0:AddListener(var_0_1.SELECTCUSTOMGRAPHICSETTING, arg_2_0.OnSelectCustomGraphicSetting)
	arg_2_0:AddListener(var_0_1.SELECTGRAPHICSETTINGLEVEL, arg_2_0.OnSelectGraphicSettingLevel)

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.AddListener

	GAME = var_4

	var_2_1(var_2_0, var_4.ISLAND_SETTING_FLAG_DONE, arg_2_0.OnSettingFlagDone)

	return
end

function var_0_1.RemoveListeners(arg_3_0)
	arg_3_0:RemoveListener(var_0_1.SELECTCUSTOMGRAPHICSETTING, arg_3_0.OnSelectCustomGraphicSetting)
	arg_3_0:RemoveListener(var_0_1.SELECTGRAPHICSETTINGLEVEL, arg_3_0.OnSelectGraphicSettingLevel)

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.RemoveListener

	GAME = var_4

	var_3_1(var_3_0, var_4.ISLAND_SETTING_FLAG_DONE, arg_3_0.OnSettingFlagDone)

	return
end

function var_0_1.OnSelectGraphicSettingLevel(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.emit

	IslandSettingsOtherGraphicsPanle = var_1_10004

	var_4_1(var_4_0, var_1_10004.EVT_UPDTAE)

	return
end

function var_0_1.OnSelectCustomGraphicSetting(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.emit

	IslandSettingsGraphicsPanle = var_1_10004

	var_5_1(var_5_0, var_1_10004.EVT_UPDTAE)

	return
end

function var_0_1.OnSettingFlagDone(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetPage

	IslandSettingsCommonPage = var_1_10004

	if var_6_1(var_6_0, var_1_10004) and var_1:GetLoaded() then
		var_1:Update()
	end

	return
end

function var_0_1.GetPage(arg_7_0, arg_7_1)
	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.pages) do
		isa = var_1_10007

		if var_1_10007(iter_7_1, arg_7_1) then
			return iter_7_1
		end
	end

	return
end

function var_0_1.OnLoaded(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.backBtn = var_1.Find(var_8_0, "top/closeBtn")

	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_1.Find(var_8_1, "pages")
	local var_8_3 = {}

	IslandSettings3DPage = var_8_1
	var_8_3[1] = var_8_1.New(var_8_2, arg_8_0.event, {})
	IslandSettingsOperationPage = var_3
	var_8_3[2] = var_3.New(var_8_2, arg_8_0.event)
	IslandSettingsCommonPage = var_3
	var_8_3[3] = var_3.New(var_8_2, arg_8_0.event, arg_8_0.contextData)
	arg_8_0.pages = var_8_3

	local var_8_4 = {}
	local var_8_5 = arg_8_0._tf

	var_8_4[1] = var_3.Find(var_8_5, "adapt/left_length/imageQuality")

	local var_8_6 = arg_8_0._tf

	var_8_4[2] = var_3.Find(var_8_6, "adapt/left_length/operation")

	local var_8_7 = arg_8_0._tf

	var_8_4[3] = var_3.Find(var_8_7, "adapt/left_length/common")
	arg_8_0.toggles = var_8_4

	local function var_8_8(arg_9_0, arg_9_1)
		setText = var_2_10002

		var_2_10002(arg_9_0:Find("selected/name"), arg_9_1)

		setText = var_2_10002

		var_2_10002(arg_9_0:Find("name"), arg_9_1)

		return
	end

	local var_8_9 = arg_8_0._tf
	local var_8_10 = var_5.Find(var_8_9, "adapt/left_length/imageQuality")

	i18n = var_6

	var_8_8(var_8_10, var_6("grapihcs3d_setting_3Dquality"))

	local var_8_11 = var_2
	local var_8_12 = arg_8_0._tf
	local var_8_13 = var_5.Find(var_8_12, "adapt/left_length/operation")

	i18n = var_6

	var_8_11(var_8_13, var_6("grapihcs3d_setting_control"))

	local var_8_14 = var_2
	local var_8_15 = arg_8_0._tf
	local var_8_16 = var_5.Find(var_8_15, "adapt/left_length/common")

	i18n = var_6

	var_8_14(var_8_16, var_6("grapihcs3d_setting_general"))

	setText = var_8_14

	local var_8_17 = arg_8_0._tf
	local var_8_18 = var_5.Find(var_8_17, "top/title/Text")

	i18n = var_6

	var_8_14(var_8_18, var_6("island_settings"))

	setText = var_8_14

	local var_8_19 = arg_8_0._tf
	local var_8_20 = var_5.Find(var_8_19, "top/title/Text/en")

	i18n = var_6

	var_8_14(var_8_20, var_6("island_settings_en"))

	return
end

function var_0_1.OnShow(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.backBtn

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.Hide(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10006)

	ipairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.toggles) do
		onToggle = var_1_10006

		local var_10_3 = arg_10_0
		local var_10_4 = iter_10_1

		local function var_10_5(arg_12_0)
			if arg_12_0 then
				local var_12_0 = arg_10_0

				var_1.SwitchPage(var_12_0, iter_10_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_10_3, var_10_4, var_10_5, var_1_10011)
	end

	pg = var_1

	local var_10_6 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_10_6, arg_10_0._tf)
	arg_10_0:EnterDefaultPage()

	return
end

function var_0_1.EnterDefaultPage(arg_13_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_13_0.toggles[1], true)

	return
end

function var_0_1.SwitchPage(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.pages[arg_14_1]

	if arg_14_0.page and arg_14_0.page ~= var_14_0 then
		local var_14_1 = arg_14_0.page

		if var_3.GetLoaded(var_14_1) then
			local var_14_2 = arg_14_0.page

			var_3.Hide(var_14_2)
		end
	end

	var_14_0:ExecuteAction("Show")

	arg_14_0.page = var_14_0
	isa = var_3

	local var_14_3 = var_14_0

	IslandSettings3DPage = var_6

	if var_3(var_14_3, var_6) then
		arg_14_0.hasShow3d = true
	end

	isa = var_3

	local var_14_4 = var_14_0

	IslandSettingsOperationPage = var_6

	if var_3(var_14_4, var_6) then
		arg_14_0.hasShowOP = true
	end

	return
end

function var_0_1.GetPage(arg_15_0, arg_15_1)
	if not arg_15_0.pages then
		return nil
	end

	_ = var_2

	return var_2.detect(arg_15_0.pages, function(arg_16_0)
		isa = var_2_10001

		return var_2_10001(arg_16_0, arg_15_1)
	end)
end

function var_0_1.OnHide(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_17_0, arg_17_0._tf)

	if arg_17_0.hasShow3d then
		GraphicSettingConst = var_1

		var_1.SettingQuality(true)
	end

	if arg_17_0.hasShowOP then
		local var_17_1 = arg_17_0
		local var_17_2 = arg_17_0.emitCore

		ISLAND_EVT = var_4

		var_17_2(var_17_1, var_4.UPDATE_CUSTOM_OP_POSITON)
	end

	local var_17_3 = arg_17_0
	local var_17_4 = arg_17_0.GetPage

	IslandSettingsCommonPage = var_4

	if var_17_4(var_17_3, var_4) and var_1:GetLoaded() then
		var_1:Save()
	end

	return
end

function var_0_1.OnDisable(arg_18_0)
	arg_18_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_19_0)
	arg_19_0:OnHide()

	pairs = var_1

	for iter_19_0, iter_19_1 in var_1(arg_19_0.pages) do
		iter_19_1:Destroy()
	end

	arg_19_0.page = nil
	arg_19_0.pages = nil

	return
end

return var_0_1
