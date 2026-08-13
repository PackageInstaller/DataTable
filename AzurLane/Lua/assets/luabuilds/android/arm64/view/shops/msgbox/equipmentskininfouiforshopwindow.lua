class = var_0_10000

local var_0_0 = "EquipmentSkinInfoUIForShopWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EquipmentSkinInfoUIForShop"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.displayPanel = var_1.Find(var_2_0, "display")

	local var_2_1 = arg_2_0.displayPanel

	arg_2_0.displayActions = var_1.Find(var_2_1, "actions")

	local var_2_2 = arg_2_0.displayPanel
	local var_2_3 = var_1.Find(var_2_2, "info/display_panel/name_container/name")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.displayNameTxt = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0.displayPanel
	local var_2_6 = var_1.Find(var_2_5, "info/display_panel/desc")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.displayDescTxt = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0.displayPanel

	arg_2_0.playBtn = var_1.Find(var_2_8, "info/play_btn")

	local var_2_9 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_9, "display/actions/confirm")
	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "display/top/bg/infomation/title")

	i18n = var_4

	var_1(var_2_11, var_4("words_information"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "display/actions/cancel/upgrade")

	i18n = var_4

	var_1(var_2_13, var_4("msgbox_text_cancel"))

	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "display/actions/confirm/change")

	i18n = var_4

	var_1(var_2_15, var_4("shop_word_exchange"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_4.Find(var_3_4, "display/top/btnBack")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CANCEL = var_3_4

	var_1_10001(var_3_3, var_3_5, var_3_6, var_3_4)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_4.Find(var_3_8, "display/actions/cancel")

	local function var_3_10()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_CANCEL = var_3_8

	var_1_10001(var_3_7, var_3_9, var_3_10, var_3_8)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)
	arg_7_0:UpdateSkinView(arg_7_1)

	arg_7_0.showing = true

	return
end

function var_0_1.Open(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if not arg_8_1:getConfig("commodity_id") then
		var_8_0 = arg_8_1:getConfig("effect_args")[1]
	end

	onButton = var_1_10004

	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0.confirmBtn

	local function var_8_3()
		pg = var_2_10000

		local var_9_0 = var_2_10000.equip_skin_template[var_8_0].name

		if arg_8_2 then
			arg_8_2(arg_8_1, 1, var_9_0)
		end

		local var_9_1 = arg_8_0

		var_1.Hide(var_9_1)

		return
	end

	SFX_CANCEL = var_1_10009

	var_1_10004(var_8_1, var_8_2, var_8_3, var_1_10009)
	arg_8_0:Show(var_8_0)

	return
end

function var_0_1.UpdateSkinView(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.displayPanel

	pg = var_1_10003

	local var_10_1 = var_1_10003.equip_skin_template[arg_10_1]

	assert = var_1_10004

	var_1_10004(var_10_1, "miss config equip_skin_template >> " .. arg_10_1)

	arg_10_0.displayNameTxt.text = var_10_1.name

	local var_10_2 = arg_10_0.displayDescTxt

	var_10_2.text = var_10_1.desc
	_ = var_10_2

	local var_10_3 = var_10_2.map(var_10_1.equip_type, function(arg_11_0)
		EquipType = var_2_10001

		return var_2_10001.Type2Name2(arg_11_0)
	end)

	setScrollText = var_5

	local var_10_4 = var_10_0:Find("info/display_panel/equip_type/mask/Text")

	table = var_8

	var_5(var_10_4, var_8.concat(var_10_3, ","))

	onButton = var_5

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_0.playBtn

	local function var_10_7()
		local var_12_0 = arg_10_0
		local var_12_1 = var_0.emit

		NewShopMainMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003.ON_ESKIN_PREVIEW, arg_10_1)

		return
	end

	SFX_PANEL = var_10

	var_5(var_10_5, var_10_6, var_10_7, var_10)

	updateDrop = var_5

	local var_10_8 = var_10_0
	local var_10_9 = var_10_0.Find(var_10_8, "info/equip")
	local var_10_10 = {}

	DROP_TYPE_EQUIPMENT_SKIN = var_10_8
	var_10_10.type = var_10_8
	var_10_10.id = arg_10_1

	var_5(var_10_9, var_10_10)

	return
end

function var_0_1.Hide(arg_13_0)
	if arg_13_0.showing then
		var_0_1.super.Hide(arg_13_0)

		pg = var_1

		local var_13_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)

		arg_13_0.showing = false
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	arg_14_0:Hide()

	return
end

return var_0_1
