local ChangeShipSkinPage = class("ChangeShipSkinPage", import("....base.BaseSubView"))

function ChangeShipSkinPage:getUIName()
	return "ChangeShipSkinPage"
end

function ChangeShipSkinPage:OnLoaded()
	self.cancelBtn = self._tf:Find("window/cancel_btn")
	self.confirmBtn = self._tf:Find("window/exchange_btn")
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.shipContent = self._tf:Find("window/sliders/scroll_rect/content")
	self.shipCardTpl = self.shipContent:GetChild(0)
	self.flagShipToggle = self._tf:Find("window/flag_bg/flag_ship")
	self.flagRandomToggle = self._tf:Find("window/flag_bg/flag_random")

	setText(self._tf:Find("window/top/title_list/infomation/title"), i18n("chang_ship_skin_window_title"))
	setText(self._tf:Find("window/sliders/please/Text"), i18n("choose_ship_to_wear_this_skin"))
	setText(self._tf:Find("window/exchange_btn/Image"), i18n("change"))
	setText(self._tf:Find("window/cancel_btn/Image"), i18n("word_cancel"))

	return
end

function ChangeShipSkinPage:OnInit()
	onButton(self, self.confirmBtn, function()
		self:OnConfirm()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg0"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onToggle(self, self.flagShipToggle, function(arg_8_0)
		self.flagShipMark = arg_8_0

		return
	end, SFX_PANEL)
	onToggle(self, self.flagRandomToggle, function(arg_9_0)
		self.flagRandomMark = arg_9_0

		return
	end, SFX_PANEL)

	return
end

function ChangeShipSkinPage:OnConfirm()
	if not self.selectIds or #self.selectIds <= 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("new_skin_no_choose"),
			onYes = function()
				self:Hide()

				return
			end
		})

		return
	end

	for iter_10_0, iter_10_1 in ipairs(self.selectIds) do
		local var_10_0, var_10_1 = ShipPhantom.UnpackMark(iter_10_1)

		pg.m02:sendNotification(GAME.SET_SHIP_SKIN, {
			shipId = var_10_0,
			phantomId = var_10_1,
			skinId = self.skin.id
		})
	end

	self:SetFlagRandomMark(self.flagRandomMark)

	if self.flagRandomMark then
		pg.m02:sendNotification(GAME.CHANGE_RANDOM_SHIPS, {
			addList = underscore.to_array(self.selectIds),
			deleteList = {}
		})
	end

	self:SetFlagShipMark(self.flagShipMark)

	if self.flagShipMark then
		self:ShowAdmiral()
	else
		self:Hide()
	end

	return
end

function ChangeShipSkinPage:Show(arg_12_1)
	ChangeShipSkinPage.super.Show(self)
	setActive(self._tf:Find("window"), true)
	setActive(self._tf:Find("select_skin"), false)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.selectIds = {}
	self.skin = arg_12_1
	self.ships = self:GetShips(arg_12_1)

	triggerToggle(self.flagShipToggle, self:GetFlagShipMark())
	triggerToggle(self.flagRandomToggle, self:GetFlagRandomMark())
	self:FlushShips()

	return
end

function ChangeShipSkinPage:ShowAdmiral()
	setActive(self._tf:Find("window"), false)
	setActive(self._tf:Find("select_skin"), true)

	local var_13_0 = self._tf:Find("select_skin")

	onButton(self, var_13_0:Find("btnBack"), function()
		self:Hide()

		return
	end, SFX_CANCEL)

	self.selectIndex = 1

	onButton(self, var_13_0:Find("exchange_btn"), function()
		local var_15_0 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()

		var_15_0[self.selectIndex] = self.selectIds[1]

		pg.m02:sendNotification(GAME.CHANGE_PLAYER_ICON, {
			skinPage = true,
			after = var_15_0
		})
		self:Hide()

		return
	end, SFX_CONFIRM)

	self.paintingInfo = {}

	local var_13_1, var_13_2 = PlayerVitaeShipsPage.GetSlotMaxCnt()
	local var_13_3 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()
	local var_13_4 = var_13_0:Find("frame/style_scroll/view_port")

	UIItemList.StaticAlign(var_13_4, var_13_4:GetChild(0), var_13_1, function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1 = arg_16_1 + 1

		if arg_16_0 == UIItemList.EventUpdate then
			onToggle(self, arg_16_2, function(arg_17_0)
				if arg_17_0 then
					self.selectIndex = arg_16_1
				end

				return
			end, SFX_PANEL)

			local var_16_0

			if var_13_3[arg_16_1] then
				var_16_0 = getProxy(BayProxy):GetShipPhantom(var_13_3[arg_16_1]) or nil
			end

			setActive(arg_16_2:Find("Style_card"), var_16_0)
			setActive(arg_16_2:Find("empty"), not var_16_0)

			if var_16_0 then
				local var_16_1 = var_16_0:getSkinId()
				local var_16_2 = {}

				var_16_2.paintingName = pg.ship_skin_template[var_16_1].painting or "unknown"
				var_16_2.painting = arg_16_2:Find("Style_card/bg/mask/painting")
				var_16_2.skinID = var_16_1
				self.paintingInfo[arg_16_1] = var_16_2

				self:loadPainting(self.paintingInfo[arg_16_1])
				changeToScrollText(arg_16_2:Find("Style_card/bg/desc/name_bar/name"), pg.ship_skin_template[var_16_1].name)
				setToggleEnabled(arg_16_2, true)
			else
				local var_16_3 = arg_16_1 > var_13_2

				setActive(arg_16_2:Find("empty/add"), not (arg_16_1 > var_13_2))
				setActive(arg_16_2:Find("empty/lock"), var_16_3)
				setText(arg_16_2:Find("empty/lock/Text"), i18n("secretary_unlock" .. arg_16_1))
				setToggleEnabled(arg_16_2, not var_16_3)
			end

			triggerToggle(arg_16_2, arg_16_1 == self.selectIndex)
		end

		return
	end)
	setText(self._tf:Find("select_skin/title/Text"), i18n("choose_secretary_change_title"))
	setText(self._tf:Find("select_skin/please"), i18n("choose_secretary_change_to_this_ship"))
	setText(self._tf:Find("select_skin/exchange_btn/Image"), i18n("change"))

	return
end

function ChangeShipSkinPage:GetFlagShipMark()
	if self.isNew then
		return getProxy(SettingsProxy):GetSetFlagShip()
	else
		return getProxy(SettingsProxy):GetSetFlagShipForSkinAtlas()
	end

	return
end

function ChangeShipSkinPage:SetFlagShipMark(arg_19_1)
	if self.isNew then
		getProxy(SettingsProxy):SetFlagShip(arg_19_1)
	else
		getProxy(SettingsProxy):SetFlagShipForSkinAtlas(arg_19_1)
	end

	return
end

function ChangeShipSkinPage:GetFlagRandomMark()
	return getProxy(SettingsProxy):GetFlagRandom()
end

function ChangeShipSkinPage:SetFlagRandomMark(arg_21_1)
	getProxy(SettingsProxy):SetFlagRandom(arg_21_1)

	return
end

function ChangeShipSkinPage:GetShips(arg_22_1)
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

function ChangeShipSkinPage:FlushShips()
	UIItemList.StaticAlign(self.shipContent, self.shipCardTpl, #self.ships, function(arg_29_0, arg_29_1, arg_29_2)
		arg_29_1 = arg_29_1 + 1

		if arg_29_0 == UIItemList.EventUpdate then
			local var_29_0 = self.ships[arg_29_1]
			local var_29_1 = ShipDetailCard.New(arg_29_2.gameObject)

			var_29_1:update(self.ships[arg_29_1], self.skin.id)
			setActive(var_29_1.maskStatusOb, var_29_0:getSkinId() == self.skin.id)
			setText(var_29_1.maskStatusOb:Find("Text"), "-  " .. i18n("shop_skin_already_inuse") .. "  -")
			setActive(arg_29_2:Find("phantom_mark"), var_29_0.phantomId > 0)
			onToggle(self, var_29_1.tr, function(arg_30_0)
				if var_29_0:getSkinId() == self.skin.id then
					return
				end

				var_29_1:updateSelected(arg_30_0)

				if arg_30_0 then
					table.insert(self.selectIds, var_29_1.shipVO:GetSelectMark())
				else
					table.removebyvalue(self.selectIds, var_29_1.shipVO:GetSelectMark())
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function ChangeShipSkinPage:Hide()
	ChangeShipSkinPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	self.selectIds = {}

	existCall(self.hideCallback)

	return
end

function ChangeShipSkinPage:loadPainting(arg_32_1)
	local var_32_0 = checkABExist("painting/" .. arg_32_1.paintingName .. "_n")

	setPaintingPrefabAsync(arg_32_1.painting, arg_32_1.paintingName, "pifu", nil, {
		rotateZ = 0,
		skinID = arg_32_1.skinID
	})

	return
end

function ChangeShipSkinPage:clearPainting(arg_33_1)
	if arg_33_1.paintingName then
		retPaintingPrefab(arg_33_1.painting, arg_33_1.paintingName)

		arg_33_1.paintingName = nil
	end

	return
end

function ChangeShipSkinPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	if self.paintingInfo then
		for iter_34_0, iter_34_1 in pairs(self.paintingInfo) do
			self:clearPainting(iter_34_1)
		end
	end

	self.shipCards = nil
	self.selectIds = nil

	return
end

return ChangeShipSkinPage
