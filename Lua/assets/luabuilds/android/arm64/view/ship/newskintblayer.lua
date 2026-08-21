local var_0_0 = class("NewSkinTBLayer", import("view.ship.NewSkinLayer"))

function var_0_0.getUIName(arg_1_0)
	return "NewSkinUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	local var_2_0 = pg.ship_skin_template[arg_2_0.contextData.skinId]
	local var_2_1 = pg.ship_skin_template[arg_2_0.contextData.skinId].bg_sp and var_2_0.bg_sp ~= "" and var_2_0.bg_sp or var_2_0.bg and #var_2_0.bg > 0 and var_2_0.bg or var_2_0.rarity_bg and #var_2_0.rarity_bg > 0 and var_2_0.rarity_bg
	local var_2_2

	var_2_2 = var_2_1 and "bg/star_level_bg_" .. var_2_1 or nil

	if var_2_2 then
		GetSpriteFromAtlasAsync(var_2_2, "", arg_2_1)
	else
		existCall(arg_2_1)
	end

	return
end

function var_0_0.setSkinPri(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:loadUISync("getrole")

	var_3_0.layer = LayerMask.NameToLayer("UI")
	var_3_0.transform.localPosition = Vector3(0, 0, -10)

	setParent(var_3_0, arg_3_0._tf, false)
	setActive(var_3_0, false)
	onNextTick(function()
		setActive(var_3_0, true)

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOCKYARD_CHARGET)

	arg_3_0.cg.alpha = 1
	arg_3_0._shade:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0)

	arg_3_0:recyclePainting()

	arg_3_0._skinConfig = pg.ship_skin_template[arg_3_1]

	local var_3_1 = arg_3_0._skinConfig.bg_sp and arg_3_0._skinConfig.bg_sp ~= "" and arg_3_0._skinConfig.bg_sp or arg_3_0._skinConfig.bg and #arg_3_0._skinConfig.bg > 0 and arg_3_0._skinConfig.bg or arg_3_0._skinConfig.rarity_bg and #arg_3_0._skinConfig.rarity_bg > 0 and arg_3_0._skinConfig.rarity_bg

	if var_3_1 then
		pg.DynamicBgMgr.GetInstance():LoadBg(arg_3_0, var_3_1, arg_3_0._bg, arg_3_0._staticBg, function(arg_5_0)
			arg_3_0.isLoadBg = true

			return
		end, function(arg_6_0)
			arg_3_0.isLoadBg = true

			return
		end)
	end

	setPaintingPrefabAsync(arg_3_0._paintingTF, arg_3_0._skinConfig.painting, "huode")

	arg_3_0._skinName.text = i18n("ship_newSkin_name", arg_3_0._skinConfig.name)

	local var_3_5, var_3_6, var_3_7 = EducateCharWordHelper.GetWordAndCV(NewEducateHelper.GetSecIdBySkinId(arg_3_1), "login")
	local var_3_8 = var_3_6

	setWidgetText(arg_3_0._dialogue, SwitchSpecialChar(var_3_7, true), "desc/Text")

	arg_3_0._dialogue.transform.localScale = Vector3(0, 1, 1)

	SetActive(arg_3_0._dialogue, false)
	SetActive(arg_3_0._dialogue, true)
	LeanTween.scale(arg_3_0._dialogue, Vector3(1, 1, 1), 0.1):setOnComplete(System.Action(function()
		setActive(arg_3_0._shade, false)
		setActive(arg_3_0.clickTF, true)
		arg_3_0:voice(var_3_8)

		return
	end))

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0.shipName = NewEducateHelper.GetShipNameBySecId(arg_8_0.contextData.secId)

	onButton(arg_8_0, arg_8_0._viewBtn, function()
		arg_8_0.isInView = true

		arg_8_0:paintView()
		setActive(arg_8_0.clickTF, false)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeNewSkin)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.clickTF, function()
		if arg_8_0.isInView or not arg_8_0.isLoadBg then
			return
		end

		arg_8_0:showExitTip()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.changeSkinBtn, function()
		if NewEducateHelper.IsUnlockDefaultShip(NewEducateHelper.GetSecIdBySkinId(arg_8_0.contextData.skinId)) then
			arg_8_0.hideExitTip = true

			arg_8_0:emit(NewSkinTBMediator.GO_SET_TB_SKIN)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_character_buy_unlock"))
		end

		return
	end)

	if arg_8_0.contextData.isClose then
		onNextTick(function()
			arg_8_0:closeView()

			return
		end)
	end

	return
end

function var_0_0.willExit(arg_14_0)
	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()

	if not arg_14_0.hideExitTip then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_newSkinLayer_get", NewEducateHelper.GetShipNameBySecId(arg_14_0.contextData.secId), pg.ship_skin_template[arg_14_0.contextData.skinId].name), COLOR_GREEN)
	end

	arg_14_0:recyclePainting()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf)
	arg_14_0:stopVoice()

	if arg_14_0.loadedCVBankName then
		pg.CriMgr.UnloadCVBank(arg_14_0.loadedCVBankName)

		arg_14_0.loadedCVBankName = nil
	end

	arg_14_0.selectShipPage:Destroy()
	cameraPaintViewAdjust(false)

	return
end

return var_0_0
