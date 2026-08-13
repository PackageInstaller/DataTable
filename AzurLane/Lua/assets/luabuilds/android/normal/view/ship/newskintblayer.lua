class = var_0_10000

local var_0_0 = "NewSkinTBLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.ship.NewSkinLayer"))

function var_0_1.getUIName(arg_1_0)
	return "NewSkinUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.contextData.skinId

	pg = var_1_10003

	local var_2_1 = var_1_10003.ship_skin_template[var_2_0]
	local var_2_2

	if var_2_1.bg_sp and var_2_1.bg_sp ~= "" then
		var_2_2 = var_2_1.bg_sp
	else
		var_2_2 = var_2_1.bg and #var_2_1.bg > 0 and var_2_1.bg or var_2_1.rarity_bg and #var_2_1.rarity_bg > 0 and var_2_1.rarity_bg
	end

	local var_2_3

	var_2_3 = var_2_2 and "bg/star_level_bg_" .. var_2_2 or nil

	if var_2_3 then
		GetSpriteFromAtlasAsync = var_5

		var_5(var_2_3, "", arg_2_1)
	else
		existCall = var_5

		var_5(arg_2_1)
	end

	return
end

function var_0_1.setSkinPri(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.loadUISync(var_3_0, "getrole")

	LayerMask = var_3_0
	var_3_1.layer = var_3_0.NameToLayer("UI")

	local var_3_2 = var_3_1.transform

	Vector3 = var_4
	var_3_2.localPosition = var_4(0, 0, -10)
	setParent = var_3_2

	var_3_2(var_3_1, arg_3_0._tf, false)

	setActive = var_3_2

	var_3_2(var_3_1, false)

	onNextTick = var_3_2

	var_3_2(function()
		setActive = var_2_10000

		var_2_10000(var_3_1, true)

		return
	end)

	pg = var_3_2

	local var_3_3 = var_3_2.CriMgr.GetInstance()
	local var_3_4 = var_3.PlaySoundEffect_V3

	SFX_UI_DOCKYARD_CHARGET = var_5

	var_3_4(var_3_3, var_5)

	arg_3_0.cg.alpha = 1

	local var_3_5 = arg_3_0._shade
	local var_3_6 = var_3.GetComponent

	typeof = var_5
	Image = var_6

	local var_3_7 = var_3_6(var_3_5, var_5(var_6))

	Color = var_3_5
	var_3_7.color = var_3_5.New(0, 0, 0, 0)

	arg_3_0:recyclePainting()

	pg = var_3
	arg_3_0._skinConfig = var_3.ship_skin_template[arg_3_1]

	local var_3_8

	if arg_3_0._skinConfig.bg_sp and arg_3_0._skinConfig.bg_sp ~= "" then
		var_3_8 = arg_3_0._skinConfig.bg_sp
	else
		var_3_8 = arg_3_0._skinConfig.bg and #arg_3_0._skinConfig.bg > 0 and arg_3_0._skinConfig.bg or arg_3_0._skinConfig.rarity_bg and #arg_3_0._skinConfig.rarity_bg > 0 and arg_3_0._skinConfig.rarity_bg
	end

	if var_3_8 then
		pg = var_4

		local var_3_9 = var_4.DynamicBgMgr.GetInstance()

		var_4.LoadBg(var_3_9, arg_3_0, var_3_8, arg_3_0._bg, arg_3_0._staticBg, function(arg_5_0)
			arg_3_0.isLoadBg = true

			return
		end, function(arg_6_0)
			arg_3_0.isLoadBg = true

			return
		end)
	end

	setPaintingPrefabAsync = var_4

	var_4(arg_3_0._paintingTF, arg_3_0._skinConfig.painting, "huode")

	local var_3_10 = arg_3_0._skinName

	i18n = var_5
	var_3_10.text = var_5("ship_newSkin_name", arg_3_0._skinConfig.name)

	local var_3_11
	local var_3_12 = ""
	local var_3_13

	EducateCharWordHelper = var_7

	local var_3_14 = var_7.GetWordAndCV

	NewEducateHelper = var_8

	local var_3_15, var_3_16, var_3_17 = var_3_14(var_8.GetSecIdBySkinId(arg_3_1), "login")
	local var_3_18 = var_3_17
	local var_3_19 = var_3_16
	local var_3_20 = var_3_15

	setWidgetText = var_3_15

	local var_3_21 = arg_3_0._dialogue

	SwitchSpecialChar = var_3_17

	var_3_15(var_3_21, var_3_17(var_3_18, true), "desc/Text")

	local var_3_22 = arg_3_0._dialogue.transform

	Vector3 = var_3_21
	var_3_22.localScale = var_3_21(0, 1, 1)
	SetActive = var_3_22

	var_3_22(arg_3_0._dialogue, false)

	SetActive = var_3_22

	var_3_22(arg_3_0._dialogue, true)

	LeanTween = var_3_22

	local var_3_23 = var_3_22.scale
	local var_3_24 = arg_3_0._dialogue

	Vector3 = var_9

	local var_3_25 = var_3_23(var_3_24, var_9(1, 1, 1), 0.1)
	local var_3_26 = var_7.setOnComplete

	System = var_9

	var_3_26(var_3_25, var_9.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_3_0._shade, false)

		setActive = var_2_10000

		var_2_10000(arg_3_0.clickTF, true)

		local var_7_0 = arg_3_0

		var_0.voice(var_7_0, var_3_19)

		return
	end))

	return
end

function var_0_1.didEnter(arg_8_0)
	NewEducateHelper = var_1_10001
	arg_8_0.shipName = var_1_10001.GetShipNameBySecId(arg_8_0.contextData.secId)
	onButton = var_1

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._viewBtn

	local function var_8_2()
		arg_8_0.isInView = true

		local var_9_0 = arg_8_0

		var_0.paintView(var_9_0)

		setActive = var_0

		var_0(arg_8_0.clickTF, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0._shareBtn

	local function var_8_5()
		pg = var_2_10000

		local var_10_0 = var_2_10000.ShareMgr.GetInstance()
		local var_10_1 = var_0.Share

		pg = var_2_10002

		var_10_1(var_10_0, var_2_10002.ShareMgr.TypeNewSkin)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.clickTF

	local function var_8_8()
		if arg_8_0.isInView or not arg_8_0.isLoadBg then
			return
		end

		local var_11_0 = arg_8_0

		var_0.showExitTip(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_8_6, var_8_7, var_8_8, var_1_10005)

	onButton = var_1

	var_1(arg_8_0, arg_8_0.changeSkinBtn, function()
		NewEducateHelper = var_2_10000

		local var_12_0 = var_2_10000.IsUnlockDefaultShip

		NewEducateHelper = var_2_10001

		local var_12_1

		if var_12_0(var_2_10001.GetSecIdBySkinId(arg_8_0.contextData.skinId)) then
			var_12_1 = arg_8_0
			var_12_1.hideExitTip = true

			local var_12_2 = arg_8_0

			var_12_1 = var_12_1.emit
			NewSkinTBMediator = var_2

			var_12_1(var_12_2, var_2.GO_SET_TB_SKIN)
		else
			pg = var_12_1

			local var_12_3 = var_12_1.TipsMgr.GetInstance()
			local var_12_4 = var_0.ShowTips

			i18n = var_2

			var_12_4(var_12_3, var_2("secretary_special_character_buy_unlock"))
		end

		return
	end)

	if arg_8_0.contextData.isClose then
		onNextTick = var_1

		var_1(function()
			local var_13_0 = arg_8_0

			var_0.closeView(var_13_0)

			return
		end)
	end

	return
end

function var_0_1.willExit(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.CpkPlayMgr.GetInstance()

	var_1.DisposeCpkMovie(var_14_0)

	if not arg_14_0.hideExitTip then
		pg = var_1

		local var_14_1 = var_1.ship_skin_template[arg_14_0.contextData.skinId].name

		NewEducateHelper = var_2

		local var_14_2 = var_2.GetShipNameBySecId(arg_14_0.contextData.secId)

		pg = var_3

		local var_14_3 = var_3.TipsMgr.GetInstance()
		local var_14_4 = var_3.ShowTips

		i18n = var_1_10005

		local var_14_5 = var_1_10005("ship_newSkinLayer_get", var_14_2, var_14_1)

		COLOR_GREEN = var_6

		var_14_4(var_14_3, var_14_5, var_6)
	end

	arg_14_0:recyclePainting()

	pg = var_1

	local var_14_6 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_6, arg_14_0._tf)
	arg_14_0:stopVoice()

	if arg_14_0.loadedCVBankName then
		pg = var_1

		var_1.CriMgr.UnloadCVBank(arg_14_0.loadedCVBankName)

		arg_14_0.loadedCVBankName = nil
	end

	local var_14_7 = arg_14_0.selectShipPage

	var_1.Destroy(var_14_7)

	cameraPaintViewAdjust = var_1

	var_1(false)

	return
end

return var_0_1
