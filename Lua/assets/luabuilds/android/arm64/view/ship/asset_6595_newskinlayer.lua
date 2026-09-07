local NewSkinLayer = class("NewSkinLayer", import("..base.BaseUI"))

NewSkinLayer.PAINT_DURATION = 0.35
NewSkinLayer.STAR_DURATION = 0.5

function NewSkinLayer:getUIName()
	return "NewSkinUI"
end

function NewSkinLayer:preload(arg_2_1)
	local var_2_0 = pg.ship_skin_template[self.contextData.skinId]
	local var_2_1 = pg.ship_skin_template[self.contextData.skinId].ship_group
	local var_2_2 = pg.ship_skin_template[self.contextData.skinId].bg_sp and var_2_0.bg_sp ~= "" and var_2_0.bg_sp or var_2_0.bg and #var_2_0.bg > 0 and var_2_0.bg or var_2_0.rarity_bg and #var_2_0.rarity_bg > 0 and var_2_0.rarity_bg

	GetSpriteFromAtlasAsync(var_2_2 and "bg/star_level_bg_" .. var_2_2 or "newshipbg/bg_" .. shipRarity2bgPrint(pg.ship_data_statistics[pg.ship_skin_template[self.contextData.skinId].ship_group * 10 + 1].rarity, ShipGroup.IsBluePrintGroup(var_2_1), ShipGroup.IsMetaGroup(var_2_1)), "", arg_2_1)

	return
end

function NewSkinLayer:init()
	self._shake = self._tf:Find("shake_panel")
	self._shade = self._tf:Find("shade")
	self._bg = self._shake:Find("bg")
	self._staticBg = self._bg:Find("static_bg")
	self._paintingTF = self._shake:Find("paint")
	self._dialogue = self._shake:Find("dialogue")
	self._skinName = self._dialogue:Find("name"):GetComponent(typeof(Text))
	self._left = self._shake:Find("left_panel")
	self._viewBtn = self._left:Find("view_btn")
	self._shareBtn = self._left:Find("share_btn")
	self.clickTF = self._shake:Find("click")
	self.newTF = self._shake:Find("New")
	self.timelimit = self._shake:Find("timelimit")

	setActive(self.newTF, false)

	self.changeSkinBtn = self._shake:Find("set_skin_btn")
	self.selectPanel = self._tf:Find("select_ship_panel")
	self.isTimeLimit = self.contextData.timeLimit

	setActive(self.timelimit, self.isTimeLimit)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	self.isLoadBg = false
	self.selectShipPage = ChangeShipSkinPage.New(self._parentTf, self.event)
	self.selectShipPage.isNew = true

	function self.selectShipPage.hideCallback()
		self:closeView()

		return
	end

	return
end

function NewSkinLayer:voice(arg_5_1)
	if not arg_5_1 then
		return
	end

	self:stopVoice()

	self._currentVoice = arg_5_1

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_5_1)

	return
end

function NewSkinLayer:stopVoice()
	if self._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self._currentVoice)
	end

	self._currentVoice = nil

	return
end

function NewSkinLayer:setSkin(arg_7_1)
	self.cg = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.cg.alpha = 0

	setActive(self._shade, true)

	self._shade:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 1)

	if checkABExist("ui/skinunlockanim/" .. "star_level_unlock_anim_" .. arg_7_1) then
		self:playOpening(function()
			self:setSkinPri(arg_7_1)

			return
		end, "star_level_unlock_anim_" .. arg_7_1)
	else
		self:setSkinPri(arg_7_1)
	end

	return
end

function NewSkinLayer:setSkinPri(arg_9_1)
	local var_9_0 = self:loadUISync("getrole")

	var_9_0.layer = LayerMask.NameToLayer("UI")
	var_9_0.transform.localPosition = Vector3(0, 0, -10)

	setParent(var_9_0, self._tf, false)
	setActive(var_9_0, false)
	onNextTick(function()
		setActive(var_9_0, true)

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOCKYARD_CHARGET)

	self.cg.alpha = 1
	self._shade:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0)

	self:recyclePainting()

	self._skinConfig = pg.ship_skin_template[arg_9_1]

	local var_9_1 = pg.ship_skin_template[arg_9_1].ship_group
	local var_9_2 = pg.ship_data_statistics[self._skinConfig.ship_group * 10 + 1]
	local var_9_3 = self._skinConfig.bg_sp and self._skinConfig.bg_sp ~= "" and self._skinConfig.bg_sp or self._skinConfig.bg and #self._skinConfig.bg > 0 and self._skinConfig.bg or self._skinConfig.rarity_bg and #self._skinConfig.rarity_bg > 0 and self._skinConfig.rarity_bg

	if var_9_3 then
		pg.DynamicBgMgr.GetInstance():LoadBg(self, var_9_3, self._bg, self._staticBg, function(arg_11_0)
			self.isLoadBg = true

			return
		end, function(arg_12_0)
			self.isLoadBg = true

			return
		end)
	else
		GetSpriteFromAtlasAsync("newshipbg/bg_" .. shipRarity2bgPrint(var_9_2.rarity, ShipGroup.IsBluePrintGroup(var_9_1), ShipGroup.IsMetaGroup(var_9_1)), "", function(arg_13_0)
			setImageSprite(self._staticBg, arg_13_0, true)

			self.isLoadBg = true

			return
		end)
	end

	setPaintingPrefabAsync(self._paintingTF, self._skinConfig.painting, "huode")

	self._skinName.text = i18n("ship_newSkin_name", self._skinConfig.name)

	local var_9_6
	local var_9_7 = ShipWordHelper.RawGetWord(arg_9_1, ShipWordHelper.WORD_TYPE_UNLOCK)

	if "" == "" then
		local var_9_8

		var_9_8, var_9_6, var_9_7 = ShipWordHelper.GetWordAndCV(arg_9_1, ShipWordHelper.WORD_TYPE_DROP)
	else
		local var_9_9

		var_9_9, var_9_6, var_9_7 = ShipWordHelper.GetWordAndCV(arg_9_1, ShipWordHelper.WORD_TYPE_UNLOCK)
	end

	setWidgetText(self._dialogue, SwitchSpecialChar(var_9_7, true), "desc/Text")

	self._dialogue.transform.localScale = Vector3(0, 1, 1)

	SetActive(self._dialogue, false)
	SetActive(self._dialogue, true)
	LeanTween.scale(self._dialogue, Vector3(1, 1, 1), 0.1):setOnComplete(System.Action(function()
		setActive(self._shade, false)
		setActive(self.clickTF, true)
		self:voice(var_9_6)

		return
	end))

	return
end

function NewSkinLayer:showExitTip()
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("give_up_cloth_change"),
		onYes = function()
			self:emit(NewSkinLayer.ON_CLOSE)

			return
		end
	})

	return
end

function NewSkinLayer:didEnter()
	self.shipName = pg.ship_skin_template[ShipWordHelper.GetDefaultSkin(self.contextData.skinId)].name

	onButton(self, self._viewBtn, function()
		self.isInView = true

		self:paintView()
		setActive(self.clickTF, false)

		return
	end, SFX_PANEL)
	onButton(self, self._shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeNewSkin)

		return
	end, SFX_PANEL)
	onButton(self, self.clickTF, function()
		if self.isInView or not self.isLoadBg then
			return
		end

		self:showExitTip()

		return
	end, SFX_CANCEL)

	self.sameShipVOs = self:GetShips(self.contextData.skinId)

	self:onSwitch(self.changeSkinBtn, #self.sameShipVOs > 0)

	return
end

function NewSkinLayer:GetShips(arg_21_1)
	local var_21_0 = getProxy(BayProxy):CanUseShareSkinPhantoms(arg_21_1)

	table.sort(var_21_0, CompareFuncs({
		function(arg_22_0)
			return arg_22_0:getSkinId() == arg_21_1 and 1 or 0
		end,
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
		end
	}))

	return var_21_0
end

function NewSkinLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if self.isInView then
		self:hidePaintView(true)

		return
	end

	if self.selectShipPage:isShowing() then
		self.selectShipPage:Hide()

		return
	end

	if isActive(self.clickTF) then
		triggerButton(self.clickTF)
	end

	return
end

function NewSkinLayer:onSwitch(arg_28_1, arg_28_2)
	onButton(self, arg_28_1, function()
		if arg_28_2 then
			self:openSelectPanel()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("err_cloth_change_noship", self.shipName))
		end

		return
	end)

	return
end

function NewSkinLayer:paintView()
	local var_30_0 = {}

	while 0 < self._shake.childCount do
		local var_30_1 = self._shake:GetChild(0)

		if var_30_1.gameObject.activeSelf and var_30_1 ~= self._paintingTF and var_30_1 ~= self._bg then
			var_30_0[#var_30_0 + 1] = var_30_1

			setActive(var_30_1, false)
		end
	end

	openPortrait()

	local var_30_3 = self._paintingTF.anchoredPosition.x
	local var_30_4 = self._paintingTF.anchoredPosition.y
	local var_30_5 = self._tf.rect.width / UnityEngine.Screen.width
	local var_30_6 = self._tf.rect.height / UnityEngine.Screen.height
	local var_30_7 = self._paintingTF.rect.width / 2
	local var_30_8 = self._paintingTF.rect.height / 2
	local var_30_9
	local var_30_10

	if not LeanTween.isTweening(go(self._paintingTF)) then
		LeanTween.moveX(rtf(self._paintingTF), 150, 0.5):setEase(LeanTweenType.easeInOutSine)
	end

	local var_30_11 = GetOrAddComponent(self._bg, "MultiTouchZoom")

	var_30_11:SetZoomTarget(self._paintingTF)

	local var_30_12 = GetOrAddComponent(self._bg, "EventTriggerListener")
	local var_30_13 = true

	var_30_11.enabled = true
	var_30_12.enabled = true

	local var_30_14 = false

	var_30_12:AddPointDownFunc(function(arg_31_0)
		if Input.touchCount == 1 or IsUnityEditor then
			var_30_14 = true
			var_30_13 = true
		elseif Input.touchCount >= 2 then
			var_30_13 = false
			var_30_14 = false
		end

		return
	end)
	var_30_12:AddPointUpFunc(function(arg_32_0)
		if Input.touchCount <= 2 then
			var_30_13 = true
		end

		return
	end)
	var_30_12:AddBeginDragFunc(function(arg_33_0, arg_33_1)
		var_30_14 = false
		var_30_9 = arg_33_1.position.x * var_30_5 - var_30_7 - tf(self._paintingTF).localPosition.x
		var_30_10 = arg_33_1.position.y * var_30_6 - var_30_8 - tf(self._paintingTF).localPosition.y

		return
	end)
	var_30_12:AddDragFunc(function(arg_34_0, arg_34_1)
		if var_30_13 then
			local var_34_0 = tf(self._paintingTF).localPosition

			tf(self._paintingTF).localPosition = Vector3(arg_34_1.position.x * var_30_5 - var_30_7 - var_30_9, arg_34_1.position.y * var_30_6 - var_30_8 - var_30_10, -22)
		end

		return
	end)
	onButton(self, self._bg, function()
		self:hidePaintView()

		return
	end, SFX_CANCEL)

	function NewSkinLayer:hidePaintView(arg_36_1)
		if not arg_36_1 and not var_30_14 then
			return
		end

		var_30_12.enabled = false
		var_30_11.enabled = false

		RemoveComponent(self._bg, "Button")

		for iter_36_0, iter_36_1 in ipairs(var_30_0) do
			setActive(iter_36_1, true)
		end

		closePortrait()
		LeanTween.cancel(go(self._paintingTF))

		self._paintingTF.localScale = Vector3(1, 1, 1)

		setAnchoredPosition(self._paintingTF, {
			x = var_30_3,
			y = var_30_4
		})

		self.isInView = false

		setActive(self.clickTF, true)

		return
	end

	return
end

function NewSkinLayer:recyclePainting()
	if self._shipVO then
		retPaintingPrefab(self._paintingTF, self._shipVO:getPainting())
	end

	return
end

function NewSkinLayer:openSelectPanel()
	self.selectShipPage:ExecuteAction("Show", ShipSkin.New({
		id = self.contextData.skinId
	}))

	return
end

function NewSkinLayer:updateShipCards()
	for iter_39_0, iter_39_1 in pairs(self.shipCards or {}) do
		if self.sameShipVOs[iter_39_0] then
			iter_39_1:update(self.sameShipVOs[iter_39_0], self.contextData.skinId)
		end
	end

	return
end

function NewSkinLayer:playOpening(arg_40_1, arg_40_2)
	pg.CpkPlayMgr.GetInstance():PlayCpkMovie(function()
		return
	end, function()
		if arg_40_1 then
			arg_40_1()
		end

		return
	end, "ui/skinunlockanim", arg_40_2, false, false)

	return
end

function NewSkinLayer:willExit()
	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()
	pg.TipsMgr.GetInstance():ShowTips(i18n("ship_newSkinLayer_get", pg.ship_data_statistics[self._skinConfig.ship_group * 10 + 1].name, self._skinConfig.name), COLOR_GREEN)
	self:recyclePainting()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:stopVoice()

	if self.loadedCVBankName then
		pg.CriMgr.UnloadCVBank(self.loadedCVBankName)

		self.loadedCVBankName = nil
	end

	self.selectShipPage:Destroy()
	cameraPaintViewAdjust(false)

	return
end

return NewSkinLayer
