local var_0_0 = class("ChangeShipSkinPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ChangeShipSkinPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.cancelBtn = arg_2_0._tf:Find("window/cancel_btn")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("window/exchange_btn")
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.shipContent = arg_2_0._tf:Find("window/sliders/scroll_rect/content")
	arg_2_0.shipCardTpl = arg_2_0.shipContent:GetChild(0)
	arg_2_0.flagShipToggle = arg_2_0._tf:Find("window/flag_bg/flag_ship")
	arg_2_0.flagRandomToggle = arg_2_0._tf:Find("window/flag_bg/flag_random")

	setText(arg_2_0._tf:Find("window/top/title_list/infomation/title"), i18n("chang_ship_skin_window_title"))
	setText(arg_2_0._tf:Find("window/sliders/please/Text"), i18n("choose_ship_to_wear_this_skin"))
	setText(arg_2_0._tf:Find("window/exchange_btn/Image"), i18n("change"))
	setText(arg_2_0._tf:Find("window/cancel_btn/Image"), i18n("word_cancel"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:OnConfirm()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("bg0"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.flagShipToggle, function(arg_8_0)
		arg_3_0.flagShipMark = arg_8_0

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.flagRandomToggle, function(arg_9_0)
		arg_3_0.flagRandomMark = arg_9_0

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnConfirm(arg_10_0)
	if not arg_10_0.selectIds or #arg_10_0.selectIds <= 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("new_skin_no_choose"),
			onYes = function()
				arg_10_0:Hide()

				return
			end
		})

		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.selectIds) do
		local var_10_0, var_10_1 = ShipPhantom.UnpackMark(iter_10_1)

		pg.m02:sendNotification(GAME.SET_SHIP_SKIN, {
			shipId = var_10_0,
			phantomId = var_10_1,
			skinId = arg_10_0.skin.id
		})
	end

	arg_10_0:SetFlagRandomMark(arg_10_0.flagRandomMark)

	if arg_10_0.flagRandomMark then
		pg.m02:sendNotification(GAME.CHANGE_RANDOM_SHIPS, {
			addList = underscore.to_array(arg_10_0.selectIds),
			deleteList = {}
		})
	end

	arg_10_0:SetFlagShipMark(arg_10_0.flagShipMark)

	if arg_10_0.flagShipMark then
		arg_10_0:ShowAdmiral()
	else
		arg_10_0:Hide()
	end

	return
end

function var_0_0.Show(arg_12_0, arg_12_1)
	var_0_0.super.Show(arg_12_0)
	setActive(arg_12_0._tf:Find("window"), true)
	setActive(arg_12_0._tf:Find("select_skin"), false)
	pg.UIMgr.GetInstance():BlurPanel(arg_12_0._tf)

	arg_12_0.selectIds = {}
	arg_12_0.skin = arg_12_1
	arg_12_0.ships = arg_12_0:GetShips(arg_12_1)

	triggerToggle(arg_12_0.flagShipToggle, arg_12_0:GetFlagShipMark())
	triggerToggle(arg_12_0.flagRandomToggle, arg_12_0:GetFlagRandomMark())
	arg_12_0:FlushShips()

	return
end

function var_0_0.ShowAdmiral(arg_13_0)
	setActive(arg_13_0._tf:Find("window"), false)
	setActive(arg_13_0._tf:Find("select_skin"), true)

	local var_13_0 = arg_13_0._tf:Find("select_skin")

	onButton(arg_13_0, var_13_0:Find("btnBack"), function()
		arg_13_0:Hide()

		return
	end, SFX_CANCEL)

	arg_13_0.selectIndex = 1

	onButton(arg_13_0, var_13_0:Find("exchange_btn"), function()
		local var_15_0 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()

		var_15_0[arg_13_0.selectIndex] = arg_13_0.selectIds[1]

		pg.m02:sendNotification(GAME.CHANGE_PLAYER_ICON, {
			skinPage = true,
			after = var_15_0
		})
		arg_13_0:Hide()

		return
	end, SFX_CONFIRM)

	arg_13_0.paintingInfo = {}

	local var_13_1, var_13_2 = PlayerVitaeShipsPage.GetSlotMaxCnt()
	local var_13_3 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()
	local var_13_4 = var_13_0:Find("frame/style_scroll/view_port")

	UIItemList.StaticAlign(var_13_4, var_13_4:GetChild(0), var_13_1, function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1 = arg_16_1 + 1

		if arg_16_0 == UIItemList.EventUpdate then
			onToggle(arg_13_0, arg_16_2, function(arg_17_0)
				if arg_17_0 then
					arg_13_0.selectIndex = arg_16_1
				end

				return
			end, SFX_PANEL)

			if var_13_3[arg_16_1] then
				local var_16_0 = getProxy(BayProxy):GetShipPhantom(var_13_3[arg_16_1]) or nil

				setActive(arg_16_2:Find("Style_card"), var_16_0)
				setActive(arg_16_2:Find("empty"), not var_16_0)

				if var_16_0 then
					local var_16_1 = var_16_0:getSkinId()

					;({}).paintingName = pg.ship_skin_template[var_16_1].painting or "unknown"
					;({}).painting = arg_16_2:Find("Style_card/bg/mask/painting")
					;({}).skinID = var_16_1
					arg_13_0.paintingInfo[arg_16_1] = {}

					arg_13_0:loadPainting(arg_13_0.paintingInfo[arg_16_1])
					changeToScrollText(arg_16_2:Find("Style_card/bg/desc/name_bar/name"), pg.ship_skin_template[var_16_1].name)
					setToggleEnabled(arg_16_2, true)
				else
					local var_16_2 = arg_16_1 > var_13_2

					setActive(arg_16_2:Find("empty/add"), not (arg_16_1 > var_13_2))
					setActive(arg_16_2:Find("empty/lock"), var_16_2)
					setText(arg_16_2:Find("empty/lock/Text"), i18n("secretary_unlock" .. arg_16_1))
					setToggleEnabled(arg_16_2, not var_16_2)
				end

				triggerToggle(arg_16_2, arg_16_1 == arg_13_0.selectIndex)

				return
			end
		end
	end)
	setText(arg_13_0._tf:Find("select_skin/title/Text"), i18n("choose_secretary_change_title"))
	setText(arg_13_0._tf:Find("select_skin/please"), i18n("choose_secretary_change_to_this_ship"))
	setText(arg_13_0._tf:Find("select_skin/exchange_btn/Image"), i18n("change"))

	return
end

function var_0_0.GetFlagShipMark(arg_18_0)
	if arg_18_0.isNew then
		return getProxy(SettingsProxy):GetSetFlagShip()
	else
		return getProxy(SettingsProxy):GetSetFlagShipForSkinAtlas()
	end

	return
end

function var_0_0.SetFlagShipMark(arg_19_0, arg_19_1)
	if arg_19_0.isNew then
		getProxy(SettingsProxy):SetFlagShip(arg_19_1)
	else
		getProxy(SettingsProxy):SetFlagShipForSkinAtlas(arg_19_1)
	end

	return
end

function var_0_0.GetFlagRandomMark(arg_20_0)
	return getProxy(SettingsProxy):GetFlagRandom()
end

function var_0_0.SetFlagRandomMark(arg_21_0, arg_21_1)
	getProxy(SettingsProxy):SetFlagRandom(arg_21_1)

	return
end

function var_0_0.GetShips(arg_22_0, arg_22_1)
	local var_22_0 = getProxy(BayProxy):CanUseShareSkinPhantoms(arg_22_1.id)

	table.sort(var_22_0, CompareFuncs({
		function(arg_23_0)
			return -arg_23_0.level
		end,
		function(arg_24_0)
			return -arg_24_0:getStar()
		end,
		function(arg_25_0)
			return arg_25_0.inFleet and 0 or 1
		end,
		function(arg_26_0)
			return arg_26_0.createTime
		end,
		function(arg_27_0)
			return arg_27_0.phantomId
		end
	}))

	return var_22_0
end

function var_0_0.FlushShips(arg_28_0)
	UIItemList.StaticAlign(arg_28_0.shipContent, arg_28_0.shipCardTpl, #arg_28_0.ships, function(arg_29_0, arg_29_1, arg_29_2)
		arg_29_1 = arg_29_1 + 1

		if arg_29_0 == UIItemList.EventUpdate then
			local var_29_0 = arg_28_0.ships[arg_29_1]
			local var_29_1 = ShipDetailCard.New(arg_29_2.gameObject)

			var_29_1:update(arg_28_0.ships[arg_29_1], arg_28_0.skin.id)
			setActive(var_29_1.maskStatusOb, var_29_0:getSkinId() == arg_28_0.skin.id)
			setText(var_29_1.maskStatusOb:Find("Text"), "-  " .. i18n("shop_skin_already_inuse") .. "  -")
			setActive(arg_29_2:Find("phantom_mark"), var_29_0.phantomId > 0)
			onToggle(arg_28_0, var_29_1.tr, function(arg_30_0)
				if var_29_0:getSkinId() == arg_28_0.skin.id then
					return
				end

				var_29_1:updateSelected(arg_30_0)

				if arg_30_0 then
					table.insert(arg_28_0.selectIds, var_29_1.shipVO:GetSelectMark())
				else
					table.removebyvalue(arg_28_0.selectIds, var_29_1.shipVO:GetSelectMark())
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.Hide(arg_31_0)
	var_0_0.super.Hide(arg_31_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_31_0._tf, arg_31_0._parentTf)

	arg_31_0.selectIds = {}

	existCall(arg_31_0.hideCallback)

	return
end

function var_0_0.loadPainting(arg_32_0, arg_32_1)
	local var_32_0 = checkABExist("painting/" .. arg_32_1.paintingName .. "_n")

	setPaintingPrefabAsync(arg_32_1.painting, arg_32_1.paintingName, "pifu", nil, {
		rotateZ = 0,
		skinID = arg_32_1.skinID
	})

	return
end

function var_0_0.clearPainting(arg_33_0, arg_33_1)
	if arg_33_1.paintingName then
		retPaintingPrefab(arg_33_1.painting, arg_33_1.paintingName)

		arg_33_1.paintingName = nil
	end

	return
end

function var_0_0.OnDestroy(arg_34_0)
	if arg_34_0:isShowing() then
		arg_34_0:Hide()
	end

	if arg_34_0.paintingInfo then
		for iter_34_0, iter_34_1 in pairs(arg_34_0.paintingInfo) do
			arg_34_0:clearPainting(iter_34_1)
		end
	end

	arg_34_0.shipCards = nil
	arg_34_0.selectIds = nil

	return
end

return var_0_0
