class = var_0_10000

local var_0_0 = "CombatSkinInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CombatSkinInfoUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "display/top/btnBack")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirm = var_1.Find(var_2_2, "display/actions/confirm")

	local var_2_3 = arg_2_0._tf

	arg_2_0.skinViewTF = var_1.Find(var_2_3, "display")
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "display/info/display_panel/combat_skin/elementList")
	local var_2_7 = arg_2_0._tf

	arg_2_0.toggleList = var_2_4(var_2_6, var_4.Find(var_2_7, "display/info/display_panel/combat_skin/elementList/main"))
	setText = var_1

	local var_2_8 = arg_2_0.confirm
	local var_2_9 = var_3.Find(var_2_8, "upgrade")

	i18n = var_4

	var_1(var_2_9, var_4("text_consume"))

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "display/top/bg/infomation/title")

	i18n = var_4

	var_1(var_2_11, var_4("words_information"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.confirm

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)
	arg_3_0:InitPanel()

	return
end

function var_0_1.InitPanel(arg_7_0)
	local var_7_0 = arg_7_0.contextData.skinID

	pg = var_1_10002

	local var_7_1 = var_1_10002.item_data_battleui[var_7_0]
	local var_7_2 = arg_7_0.skinViewTF
	local var_7_3 = var_3.Find(var_7_2, "info/display_panel/name_container/name")
	local var_7_4 = arg_7_0.skinViewTF
	local var_7_5 = var_4.Find(var_7_4, "info/display_panel/desc/Text")

	setText = var_7_2

	var_7_2(var_7_3, var_7_1.name)

	setText = var_7_2

	var_7_2(var_7_5, var_7_1.desc)

	local var_7_6 = var_7_1.rare_display
	local var_7_7 = arg_7_0.toggleList

	var_6.make(var_7_7, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = var_7_6[arg_8_1 + 1]

			GetImageSpriteFromAtlasAsync = var_4

			local var_8_1 = "ui/combatskinrare"

			CombatSkinConst = var_2_10007

			var_4(var_8_1, var_2_10007.TYPE_ICON_NAME[var_8_0], arg_8_2:Find("icon"), true)

			setScrollText = var_4

			local var_8_2 = arg_8_2:Find("TextMask/Text")

			i18n = var_7

			var_4(var_8_2, var_7("battleui_display" .. var_8_0))
		end

		return
	end)

	local var_7_8 = arg_7_0.toggleList

	var_6.align(var_7_8, #var_7_6)

	local var_7_9 = arg_7_0.skinViewTF
	local var_7_10 = var_6.Find(var_7_9, "info/play_btn")

	onButton = var_7

	local var_7_11 = arg_7_0
	local var_7_12 = var_7_10

	local function var_7_13()
		local var_9_0 = arg_7_0

		CombatPreviewLayer = var_2_10001

		local var_9_1 = var_2_10001.New

		pg = var_2_10003
		var_9_0.combatPreview = var_9_1(var_2_10003.UIMgr.GetInstance().OverlayMain)

		local var_9_2 = arg_7_0.combatPreview

		var_0.ExecuteAction(var_9_2, "Show", var_7_0, function()
			local var_10_0 = arg_7_0.combatPreview

			var_0.Destroy(var_10_0)

			arg_7_0.combatPreview = nil

			return
		end)

		return
	end

	SPX_PANEL = var_1_10012

	var_7(var_7_11, var_7_12, var_7_13, var_1_10012)

	updateDrop = var_7

	local var_7_14 = arg_7_0.skinViewTF
	local var_7_15 = var_9.Find(var_7_14, "info/equip")

	Drop = var_7_12

	local var_7_16 = var_7_12.New
	local var_7_17 = {
		count = 1
	}

	DROP_TYPE_COMBAT_UI_STYLE = var_1_10013
	var_7_17.type = var_1_10013
	var_7_17.id = var_7_0

	var_7(var_7_15, var_7_16(var_7_17))

	return
end

function var_0_1.willExit(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf)

	return
end

function var_0_1.onBackPressed(arg_12_0)
	if arg_12_0.combatPreview then
		local var_12_0 = arg_12_0.combatPreview

		var_1.Destroy(var_12_0)

		arg_12_0.combatPreview = nil
	else
		var_0_1.super.onBackPressed(arg_12_0)
	end

	return
end

return var_0_1
