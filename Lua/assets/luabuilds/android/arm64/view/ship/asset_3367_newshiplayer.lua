local NewShipLayer = class("NewShipLayer", import("..base.BaseUI"))

NewShipLayer.PAINT_DURATION = 0.35
NewShipLayer.STAR_DURATION = 0.5
NewShipLayer.STAR_ANIMATION_DUR1 = 0.075
NewShipLayer.STAR_ANIMATION_DUR2 = 0.1
NewShipLayer.STAR_ANIMATION_DUR3 = 0.4
NewShipLayer.STAR_ANIMATION_DUR4 = 0.26

function NewShipLayer:getUIName()
	return "NewShipUI"
end

function NewShipLayer:preload(arg_2_1)
	LoadSpriteAsync("newshipbg/bg_" .. self.contextData.ship:rarity2bgPrintForGet(), function(arg_3_0)
		self.bgSprite = arg_3_0
		self.isLoadBg = true

		arg_2_1()

		return
	end)

	return
end

function NewShipLayer:init()
	self._animator = GetComponent(self._tf, "Animator")
	self._canvasGroup = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self._shake = self._tf:Find("shake_panel")
	self._shade = self._tf:Find("shade")
	self._bg = self._shake:Find("bg")
	self._drag = self._shake:Find("drag")
	self._paintingTF = self._shake:Find("paint")
	self._paintingShadowTF = self._shake:Find("shadow")
	self._dialogue = self._shake:Find("dialogue")
	self._shipName = self._dialogue:Find("bg/name"):GetComponent(typeof(Text))
	self._shipType = self._dialogue:Find("bg/type"):GetComponent(typeof(Text))
	self._dialogueText = self._dialogue:Find("Text")
	self._left = self._shake:Find("ForNotch/left_panel")
	self._lockTF = self._left:Find("lock")
	self._lockBtn = self._left:Find("lock/lock")
	self._unlockBtn = self._left:Find("lock/unlock_btn")
	self._viewBtn = self._left:Find("view_btn")
	self._evaluationBtn = self._left:Find("evaluation_btn")
	self._shareBtn = self._left:Find("share_btn")
	self.audioBtn = self._shake:Find("property_btn")
	self.clickTF = self._shake:Find("click")
	self.npc = self._tf:Find("shake_panel/npc")

	setActive(self.npc, false)

	self.newTF = self._shake:Find("New")
	self.rarityTF = self._shake:Find("rarity")
	self.starsTF = self.rarityTF:Find("stars")
	self.starsCont = self.starsTF:Find("content")
	self._skipButton = self._shake:Find("ForNotch/skip")

	setActive(self._skipButton, self.contextData.canSkipBatch)
	setActive(self._left, true)
	setActive(self.audioBtn, true)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	self.metaRepeatTF = self.rarityTF:Find("MetaRepeat")
	self.metaDarkTF = self._shake:Find("MetaMask")
	self.rarityEffect = {}

	if self.contextData.autoExitTime then
		self.autoExitTimer = Timer.New(function()
			self:showExitTip()

			return
		end, self.contextData.autoExitTime)

		self.autoExitTimer:Start()

		self.contextData.autoExitTime = nil
	end

	self:PauseAnimation()

	return
end

function NewShipLayer:voice(arg_6_1)
	if not arg_6_1 then
		return
	end

	self:stopVoice()

	self._currentVoice = arg_6_1

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_6_1)

	return
end

function NewShipLayer:stopVoice()
	if self._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self._currentVoice)
	end

	self._currentVoice = nil

	return
end

function NewShipLayer:setShip(arg_8_1)
	self:recyclePainting()

	self._shipVO = arg_8_1
	self.isRemoulded = arg_8_1:isRemoulded()

	local var_8_0 = arg_8_1:isBluePrintShip()

	setImageSprite(self._bg, self.bgSprite)
	setActive(self.metaDarkTF, arg_8_1:isMetaShip())

	if var_8_0 then
		if self.metaBg then
			setActive(self.metaBg, false)
		end

		if self.designBg and self.designName ~= "raritydesign" .. arg_8_1:getRarity() then
			PoolMgr.GetInstance():ReturnUI(self.designName, self.designBg)

			self.designBg = nil
		end

		if not self.designBg then
			PoolMgr.GetInstance():GetUI("raritydesign" .. arg_8_1:getRarity(), true, function(arg_9_0)
				self.designBg = arg_9_0
				self.designName = "raritydesign" .. arg_8_1:getRarity()

				arg_9_0.transform:SetParent(self._shake, false)

				arg_9_0.transform.localPosition = Vector3(1, 1, 1)
				arg_9_0.transform.localScale = Vector3(1, 1, 1)

				arg_9_0.transform:SetSiblingIndex(1)
				setActive(arg_9_0, true)

				return
			end)
		else
			setActive(self.designBg, true)
		end
	elseif arg_8_1:isMetaShip() then
		if self.designBg then
			setActive(self.designBg, false)
		end

		if self.metaBg and self.metaName ~= "raritymeta" .. arg_8_1:getRarity() then
			PoolMgr.GetInstance():ReturnUI(self.metaName, self.metaBg)

			self.metaBg = nil
		end

		if not self.metaBg then
			PoolMgr.GetInstance():GetUI("raritymeta" .. arg_8_1:getRarity(), true, function(arg_10_0)
				self.metaBg = arg_10_0
				self.metaName = "raritymeta" .. arg_8_1:getRarity()

				arg_10_0.transform:SetParent(self._shake, false)

				arg_10_0.transform.localPosition = Vector3(1, 1, 1)
				arg_10_0.transform.localScale = Vector3(1, 1, 1)

				arg_10_0.transform:SetSiblingIndex(1)
				setActive(arg_10_0, true)

				return
			end)
		else
			setActive(self.metaBg, true)
		end
	else
		if self.designBg then
			setActive(self.designBg, false)
		end

		if self.metaBg then
			setActive(self.metaBg, false)
		end
	end

	if arg_8_1.virgin and not self.isRemoulded and not arg_8_1:isActivityNpc() then
		setActive(self.newTF, true)
		LoadImageSpriteAsync("clutter/new", self.newTF)

		if OPEN_TEC_TREE_SYSTEM and table.indexof(pg.fleet_tech_ship_template.all, self._shipVO.groupId, 1) then
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_TECPOINT, {
				point = pg.fleet_tech_ship_template[self._shipVO.groupId].pt_get,
				typeList = ShipType.FilterOverQuZhuType(pg.fleet_tech_ship_template[self._shipVO.groupId].add_get_shiptype),
				attr = pg.fleet_tech_ship_template[self._shipVO.groupId].add_get_attr,
				value = pg.fleet_tech_ship_template[self._shipVO.groupId].add_get_value
			})
		end
	else
		setActive(self.newTF, false)

		local var_8_1 = arg_8_1:getReMetaSpecialItemVO()

		self:updateLockTF(var_8_1 ~= nil)

		if var_8_1 then
			local var_8_2 = self.metaRepeatTF:Find("Icon")

			setImageSprite(var_8_2, LoadSprite(var_8_1:getConfig("icon")))
			GetImageSpriteFromAtlasAsync(var_8_1:getConfig("icon"), "", var_8_2)
			setText(self.metaRepeatTF:Find("Count"), var_8_1.count)

			local var_8_3 = pg.ship_transform[self._shipVO.groupId].common_item[1][2]
			local var_8_4 = self.metaRepeatTF:Find("Commom")

			setActive(self.metaRepeatTF:Find("Special"), var_8_1.id == pg.ship_transform[self._shipVO.groupId].exclusive_item[1][2])
			setActive(var_8_4, var_8_1.id == var_8_3)
		else
			setActive(self.metaRepeatTF, false)
		end
	end

	setActive(self.audioBtn, not self.isRemoulded)
	self:UpdateLockButton(self._shipVO:GetLockState())

	local var_8_5 = self._shipVO:getConfigTable()

	if self.isRemoulded then
		setPaintingPrefabAsync(self._paintingTF, self._shipVO:getRemouldPainting(), "huode")
		setPaintingPrefabAsync(self._paintingShadowTF, self._shipVO:getRemouldPainting(), "huode")
	else
		setPaintingPrefabAsync(self._paintingTF, self._shipVO:getPainting(), "huode")
		setPaintingPrefabAsync(self._paintingShadowTF, self._shipVO:getPainting(), "huode")
	end

	self._shipType.text = pg.ship_data_by_type[self._shipVO:getShipType()].type_name
	self._shipName.text = arg_8_1:getName()

	local var_8_6 = arg_8_1:getRarity()
	local var_8_7 = pg.ship_data_template[var_8_5.id].star_max
	local var_8_8 = self._shipVO:getStar()

	if pg.ship_data_template[var_8_5.id].star_max % 2 ~= 0 or not (var_8_7 / 2) then
		local var_8_9 = math.floor(var_8_7 / 2) + 1
	end

	for iter_8_0 = 1, 6 do
		local var_8_11 = self.starsTF:Find("content/star_" .. iter_8_0)
		local var_8_12 = var_8_11:Find("star_empty")

		setActive(var_8_11:Find("star"), iter_8_0 <= var_8_8)
		setActive(var_8_12, var_8_8 < iter_8_0)

		if var_8_7 < iter_8_0 then
			setActive(var_8_11, false)
		end
	end

	local var_8_13 = self._shake:Find("rarity/nation")
	local var_8_14 = LoadSprite("prints/" .. nation2print(var_8_5.nationality) .. "_0")

	if not var_8_14 then
		warning("找不到印花, shipConfigId: " .. arg_8_1.configId)
		setActive(var_8_13, false)
	else
		setImageSprite(var_8_13, var_8_14, false)
	end

	local var_8_15 = self._shake:Find("rarity/type")
	local var_8_16 = self._shake:Find("rarity/type/rarLogo")

	if arg_8_1:isMetaShip() then
		LoadImageSpriteAsync("shiprarity/1" .. var_8_6 .. "m", var_8_15, true)
		LoadImageSpriteAsync("shiprarity/1" .. var_8_6 .. "s", var_8_16, true)
	else
		LoadImageSpriteAsync("shiprarity/" .. (var_8_0 and "0" or "") .. var_8_6 .. "m", var_8_15, true)
		LoadImageSpriteAsync("shiprarity/" .. (var_8_0 and "0" or "") .. var_8_6 .. "s", var_8_16, true)
	end

	setActive(var_8_13, false)
	setActive(self.rarityTF, false)
	setActive(self._shade, true)

	self.inAnimating = true

	self:AddLeanTween(function()
		return LeanTween.delayedCall(0.5, System.Action(function()
			setActive(var_8_13, true)
			setActive(self.rarityTF, true)
			self:starsAnimation()

			return
		end))
	end)

	local var_8_17 = self._shake:Find("ship_type")
	local var_8_18 = var_8_17:Find("stars")
	local var_8_19 = var_8_17:Find("stars/startpl")

	setText(var_8_17:Find("english_name"), self._shipVO:getConfig("english_name"))

	local var_8_20 = self._shipVO:getStar()
	local var_8_21 = self._shipVO:getMaxStar()

	for iter_8_1 = var_8_18.childCount, var_8_21 - 1 do
		cloneTplTo(var_8_19, var_8_18)
	end

	for iter_8_2 = 0, var_8_18.childCount - 1 do
		local var_8_22 = var_8_18:GetChild(iter_8_2)

		var_8_22.gameObject:SetActive(iter_8_2 < var_8_21)
		setActive(var_8_22:Find("star"), iter_8_2 < var_8_20)
		setActive(var_8_22:Find("empty"), var_8_20 <= iter_8_2)
	end

	local var_8_23 = self._shipVO:getConfigTable()

	findTF(var_8_17, "type_bg/type"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("shiptype", tostring(self._shipVO:getShipType()))

	setScrollText(var_8_17:Find("name_bg/mask/Text"), self._shipVO:getName())

	if var_8_0 then
		var_8_6 = var_8_6 .. "_1"
	elseif arg_8_1:isMetaShip() then
		var_8_6 = var_8_6 .. "_2"
	end

	if not self.rarityEffect[var_8_6] then
		PoolMgr.GetInstance():GetUI("getrole_" .. var_8_6, true, function(arg_13_0)
			if IsNil(self._tf) then
				return
			end

			self.rarityEffect[var_8_6] = arg_13_0

			arg_13_0.transform:SetParent(self._tf, false)

			arg_13_0.transform.localPosition = Vector3(1, 1, 1)
			arg_13_0.transform.localScale = Vector3(1, 1, 1)

			arg_13_0.transform:SetSiblingIndex(1)

			if arg_8_1:isMetaShip() then
				local var_13_0 = tf(arg_13_0):Find("fire_ruchang")

				var_13_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_14_0)
					setActive(var_8_13, true)
					setActive(var_13_0, false)

					return
				end)
			end

			setActive(var_8_13, false)

			self.effectObj = arg_13_0

			setActive(self.effectObj, self.isOpeningEnd)

			return
		end)
	else
		self.effectObj = self.rarityEffect[var_8_6]

		setActive(self.effectObj, self.isOpeningEnd)
	end

	self:playOpening(function()
		self:ResumeAnimation()
		self:DisplayWord()

		return
	end)

	return
end

function NewShipLayer:PauseAnimation()
	self._canvasGroup.alpha = 0
	self._animator.enabled = false

	return
end

function NewShipLayer:ResumeAnimation()
	self._canvasGroup.alpha = 1
	self._animator.enabled = true
	self.isOpeningEnd = true

	if self.effectObj then
		setActive(self.effectObj, true)
	end

	return
end

function NewShipLayer:DisplayWord()
	local var_18_1 = ""
	local var_18_2

	if self.isRemoulded then
		local var_18_3 = self._shipVO:getRemouldSkinId()

		var_18_1 = ShipWordHelper.RawGetWord(var_18_3, ShipWordHelper.WORD_TYPE_UNLOCK)

		if var_18_1 == "" then
			local var_18_4

			var_18_4, var_18_2, var_18_1 = ShipWordHelper.GetWordAndCV(var_18_3, ShipWordHelper.WORD_TYPE_DROP)
		else
			local var_18_5

			var_18_5, var_18_2, var_18_1 = ShipWordHelper.GetWordAndCV(var_18_3, ShipWordHelper.WORD_TYPE_UNLOCK)
		end
	else
		local var_18_6

		var_18_6, var_18_2, var_18_1 = ShipWordHelper.GetWordAndCV(self._shipVO:getSkinId(), ShipWordHelper.WORD_TYPE_UNLOCK)
	end

	setWidgetText(self._dialogue, SwitchSpecialChar(var_18_1, true), "Text")

	self._dialogue.transform.localScale = Vector3(0, 1, 1)

	SetActive(self._dialogue, false)
	self:AddLeanTween(function()
		return LeanTween.delayedCall(0.5, System.Action(function()
			SetActive(self._dialogue, true)
			self:AddLeanTween(function()
				return LeanTween.scale(self._dialogue, Vector3(1, 1, 1), 0.1)
			end)
			self:voice(var_18_2)

			return
		end))
	end)

	return
end

function NewShipLayer:updateShip(arg_22_1)
	self._shipVO = arg_22_1

	return
end

function NewShipLayer:switch2Property()
	setActive(self.newTF, false)
	setActive(self._dialogue, false)
	setActive(self.rarityTF, false)
	setActive(self._shake:Find("rarity/nation"), false)

	local var_23_0 = self._shake:Find("ship_type")

	setActive(var_23_0, true)
	self:AddLeanTween(function()
		return LeanTween.move(rtf(var_23_0), Vector3(0, -149.55, 0), 0.3)
	end)
	self:AddLeanTween(function()
		return LeanTween.move(rtf(self._paintingTF), Vector3(-59, 21, 0), 0.2)
	end)
	self:DisplayNewShipDocumentView()

	return
end

function NewShipLayer:showExitTip(arg_26_1)
	local var_26_0 = getProxy(PlayerProxy):getRawData():GetCommonFlag(_G[pg.settings_other_template[22].name])

	if pg.settings_other_template[22].default == 1 then
		var_26_0 = not var_26_0
	end

	if self._shipVO.virgin and self._shipVO:GetLockState() == Ship.LOCK_STATE_UNLOCK and not var_26_0 then
		if self.effectObj then
			setActive(self.effectObj, false)
		end

		if self.effectLineObj then
			setActive(self.effectLineObj, false)
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			content = i18n("ship_lock_tip"),
			onYes = function()
				triggerButton(self._lockBtn)

				if arg_26_1 then
					arg_26_1()
				else
					self:emit(NewShipMediator.ON_EXIT)
				end

				return
			end,
			onNo = function()
				if arg_26_1 then
					arg_26_1()
				else
					self:emit(NewShipMediator.ON_EXIT)
				end

				return
			end
		})
	elseif arg_26_1 then
		arg_26_1()
	else
		self:emit(NewShipMediator.ON_EXIT)
	end

	return
end

function NewShipLayer:UpdateLockButton(arg_29_1)
	setActive(self._lockBtn, arg_29_1 ~= Ship.LOCK_STATE_LOCK)
	setActive(self._unlockBtn, arg_29_1 ~= Ship.LOCK_STATE_UNLOCK)

	return
end

function NewShipLayer:updateLockTF(arg_30_1)
	setActive(self._lockTF, not arg_30_1)

	return
end

function NewShipLayer:didEnter()
	onButton(self, self._lockBtn, function()
		self:StopAutoExitTimer()
		self:emit(NewShipMediator.ON_LOCK, {
			self._shipVO.id
		}, Ship.LOCK_STATE_LOCK)

		return
	end, SFX_PANEL)
	onButton(self, self._unlockBtn, function()
		self:StopAutoExitTimer()
		self:emit(NewShipMediator.ON_LOCK, {
			self._shipVO.id
		}, Ship.LOCK_STATE_UNLOCK)

		return
	end, SFX_PANEL)
	onButton(self, self._viewBtn, function()
		self:StopAutoExitTimer()

		self.isInView = true

		self:paintView()
		setActive(self.clickTF, false)

		return
	end, SFX_PANEL)
	onButton(self, self._evaluationBtn, function()
		self:StopAutoExitTimer()
		self:emit(NewShipMediator.ON_EVALIATION, self._shipVO:getGroupId())

		return
	end, SFX_PANEL)
	onButton(self, self._shareBtn, function()
		self:StopAutoExitTimer()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeNewShip)

		return
	end, SFX_PANEL)
	onButton(self, self.clickTF, function()
		self:StopAutoExitTimer()

		if self.isInView or not self.isLoadBg then
			return
		end

		self:showExitTip()

		return
	end, SFX_CANCEL)
	onButton(self, self.audioBtn, function()
		self:StopAutoExitTimer()

		if self.isInView then
			return
		end

		if not self.isOpenProperty then
			self:switch2Property()

			self.isOpenProperty = true
		end

		setActive(self.audioBtn, not self.isRemoulded and not self.isOpenProperty)

		return
	end, SFX_PANEL)
	onButton(self, self._skipButton, function()
		self:showExitTip(function()
			self:emit(NewShipMediator.ON_SKIP_BATCH, self.contextData.skipBatchType or NewShipMediator.SKIP_TYPE.BUILD)

			return
		end)

		return
	end, SFX_PANEL)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOCKYARD_CHARGET)
	pg.SystemGuideMgr.GetInstance():Play(self)

	return
end

function NewShipLayer:onBackPressed()
	if self.inAnimating then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if self.isInView then
		self:hidePaintView(true)

		return
	end

	self:DestroyNewShipDocumentView()
	triggerButton(self.clickTF)

	return
end

function NewShipLayer:paintView()
	local var_42_0 = {}

	while 0 < self._shake.childCount do
		local var_42_1 = self._shake:GetChild(0)

		if var_42_1.gameObject.activeSelf and var_42_1 ~= self._paintingTF and var_42_1 ~= self._bg and var_42_1 ~= self._drag then
			var_42_0[#var_42_0 + 1] = var_42_1

			setActive(var_42_1, false)
		end
	end

	setActive(self._paintingShadowTF, false)
	openPortrait()

	local var_42_3 = self._paintingTF
	local var_42_4 = self._paintingTF.anchoredPosition.x
	local var_42_5 = self._paintingTF.anchoredPosition.y
	local var_42_6 = self._tf.rect.width / UnityEngine.Screen.width
	local var_42_7 = self._tf.rect.height / UnityEngine.Screen.height
	local var_42_8 = self._paintingTF.rect.width / 2
	local var_42_9 = self._paintingTF.rect.height / 2
	local var_42_10
	local var_42_11

	if not LeanTween.isTweening(go(self._paintingTF)) then
		self:AddLeanTween(function()
			return LeanTween.moveX(rtf(var_42_3), 150, 0.5):setEase(LeanTweenType.easeInOutSine)
		end)
	end

	local var_42_12 = GetOrAddComponent(self._drag, "MultiTouchZoom")

	var_42_12:SetZoomTarget(self._paintingTF)

	local var_42_13 = GetOrAddComponent(self._drag, "EventTriggerListener")

	self.dragTrigger = var_42_13

	local var_42_14 = true

	var_42_12.enabled = true
	var_42_13.enabled = true

	local var_42_15 = false

	var_42_13:AddPointDownFunc(function(arg_44_0)
		if Input.touchCount == 1 or IsUnityEditor then
			var_42_15 = true
			var_42_14 = true
		elseif Input.touchCount >= 2 then
			var_42_14 = false
			var_42_15 = false
		end

		return
	end)
	var_42_13:AddPointUpFunc(function(arg_45_0)
		if Input.touchCount <= 2 then
			var_42_14 = true
		end

		return
	end)
	var_42_13:AddBeginDragFunc(function(arg_46_0, arg_46_1)
		var_42_15 = false
		var_42_10 = arg_46_1.position.x * var_42_6 - var_42_8 - tf(self._paintingTF).localPosition.x
		var_42_11 = arg_46_1.position.y * var_42_7 - var_42_9 - tf(self._paintingTF).localPosition.y

		return
	end)
	var_42_13:AddDragFunc(function(arg_47_0, arg_47_1)
		if var_42_14 then
			local var_47_0 = tf(self._paintingTF).localPosition

			tf(self._paintingTF).localPosition = Vector3(arg_47_1.position.x * var_42_6 - var_42_8 - var_42_10, arg_47_1.position.y * var_42_7 - var_42_9 - var_42_11, -22)
		end

		return
	end)
	onButton(self, self._drag, function()
		self:hidePaintView()

		return
	end, SFX_CANCEL)

	function NewShipLayer:hidePaintView(arg_49_1)
		if not arg_49_1 and not var_42_15 then
			return
		end

		var_42_13.enabled = false
		var_42_12.enabled = false

		for iter_49_0, iter_49_1 in ipairs(var_42_0) do
			setActive(iter_49_1, true)
		end

		setActive(self._paintingShadowTF, true)
		closePortrait()
		LeanTween.cancel(go(self._paintingTF))

		self._paintingTF.localScale = Vector3(1, 1, 1)

		setAnchoredPosition(self._paintingTF, {
			x = var_42_4,
			y = var_42_5
		})

		self.isInView = false

		setActive(self.clickTF, true)

		return
	end

	return
end

function NewShipLayer:recyclePainting()
	if self._shipVO then
		retPaintingPrefab(self._paintingTF, self._shipVO:getPainting())
		retPaintingPrefab(self._paintingShadowTF, self._shipVO:getPainting())

		self._shipVO = nil
	end

	return
end

function NewShipLayer:starsAnimation()
	self.inAnimating = true

	if self._shipVO:getMaxStar() >= 6 and PlayerPrefs.GetInt(RARE_SHIP_VIBRATE, 1) > 0 then
		LuaHelper.Vibrate()
	end

	setActive(self.starsCont, false)

	local var_51_0 = self._tf:GetComponent(typeof(DftAniEvent))

	var_51_0:SetTriggerEvent(function(arg_52_0)
		self:AddLeanTween(function()
			return LeanTween.scale(rtf(self.starsCont), Vector3.one, 0):setOnComplete(System.Action(function()
				setActive(self.starsCont, true)

				return
			end))
		end)

		local var_52_0 = self.STAR_ANIMATION_DUR1

		for iter_52_0 = 0, self.starsCont.childCount - 1 do
			local var_52_1 = self.starsCont:GetChild(iter_52_0)
			local var_52_2 = var_52_1:Find("star_empty")
			local var_52_3 = var_52_1:Find("star")

			setActive(var_52_2, false)
			setActive(var_52_3, false)

			local var_52_4 = iter_52_0 * self.STAR_ANIMATION_DUR1

			self:AddLeanTween(function()
				return LeanTween.scale(rtf(var_52_2), Vector3(1.8, 1.8, 1.8), 0):setDelay(var_52_4):setOnComplete(System.Action(function()
					setActive(var_52_2, true)
					self:AddLeanTween(function()
						return LeanTween.scale(rtf(var_52_2), Vector3(1, 1, 1), var_52_0)
					end)

					return
				end))
			end)
		end

		local var_52_5 = self.STAR_ANIMATION_DUR2
		local var_52_6 = self.STAR_ANIMATION_DUR3

		for iter_52_1 = 0, self._shipVO:getStar() - 1 do
			local var_52_7 = self.starsCont:GetChild(iter_52_1)
			local var_52_8 = var_52_7:Find("star_empty")
			local var_52_9 = var_52_7:Find("star")
			local var_52_10 = self.STAR_ANIMATION_DUR1 * self.starsCont.childCount + iter_52_1 * self.STAR_ANIMATION_DUR2

			self:AddLeanTween(function()
				return LeanTween.scale(rtf(var_52_9), Vector3(1.8, 1.8, 1.8), 0):setDelay(var_52_10):setOnStart(System.Action(function()
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOCKYARD_STAR)

					return
				end)):setOnComplete(System.Action(function()
					setActive(var_52_8, false)
					setActive(var_52_9, true)
					self:AddLeanTween(function()
						return LeanTween.scale(rtf(var_52_9), Vector3(1, 1, 1), var_52_5)
					end)

					return
				end))
			end)

			local var_52_11 = var_52_7:Find("light")

			if var_52_11 then
				self:AddLeanTween(function()
					return LeanTween.delayedCall(var_52_10, System.Action(function()
						if self.exited then
							return
						end

						setActive(var_52_11, true)

						return
					end))
				end)
				self:AddLeanTween(function()
					return LeanTween.alpha(rtf(var_52_11), 0, var_52_6):setDelay(var_52_10):setOnComplete(System.Action(function()
						SetActive(var_52_11, false)
						LeanTween.alpha(rtf(var_52_11), 1, 0)

						return
					end))
				end)

				var_52_11.transform.localScale = Vector3(1, 1, 1)

				self:AddLeanTween(function()
					return LeanTween.scale(rtf(var_52_11), Vector3(0.5, 1, 1), self.STAR_ANIMATION_DUR4):setDelay(var_52_10 + var_52_6 * 1 / 3)
				end)
			end
		end

		return
	end)
	var_51_0:SetEndEvent(function(arg_67_0)
		if self._shipVO:getReMetaSpecialItemVO() then
			GetComponent(self.metaRepeatTF, "CanvasGroup").alpha = 1

			self:managedTween(LeanTween.value, function()
				setAnchoredPosition(self.metaRepeatTF, {
					x = 0
				})

				self.inAnimating = false

				setActive(self.npc, self._shipVO:isActivityNpc())
				setActive(self._shade, false)

				return
			end, go(self.metaRepeatTF), self.metaRepeatTF.rect.width, 0, 1):setOnUpdate(System.Action_float(function(arg_69_0)
				setAnchoredPosition(self.metaRepeatTF, {
					x = arg_69_0
				})

				return
			end))
			setAnchoredPosition(self.metaRepeatTF, {
				x = self.metaRepeatTF.rect.width
			})
			setActive(self.metaRepeatTF, true)
		else
			self.inAnimating = false

			setActive(self.npc, self._shipVO:isActivityNpc())
			setActive(self._shade, false)
		end

		return
	end)

	return
end

function NewShipLayer:playOpening(arg_70_1)
	if self._shipVO:isMetaShip() then
		if not getProxy(ContextProxy):getContextByMediator(BuildShipMediator) then
			if arg_70_1 then
				arg_70_1()
			end

			return
		end
	end

	if checkABExist("ui/skinunlockanim/" .. "star_level_unlock_anim_" .. (self._shipVO:isRemoulded() and ShipGroup.GetGroupConfig(self._shipVO:getGroupId()).trans_skin or ShipGroup.getDefaultSkin(self._shipVO:getGroupId()).id)) then
		pg.CpkPlayMgr.GetInstance():PlayCpkMovie(function()
			return
		end, function()
			if arg_70_1 then
				arg_70_1()
			end

			return
		end, "ui/skinunlockanim", "star_level_unlock_anim_" .. (self._shipVO:isRemoulded() and ShipGroup.GetGroupConfig(self._shipVO:getGroupId()).trans_skin or ShipGroup.getDefaultSkin(self._shipVO:getGroupId()).id), true, false)
	elseif arg_70_1 then
		arg_70_1()
	end

	return
end

function NewShipLayer:ClearTweens(arg_73_1)
	self:cleanManagedTween(true)

	return
end

function NewShipLayer:willExit()
	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()
	self:StopAutoExitTimer()
	self:DestroyNewShipDocumentView()

	if self.designBg then
		PoolMgr.GetInstance():ReturnUI(self.designName, self.designBg)
	end

	if self.metaBg then
		PoolMgr.GetInstance():ReturnUI(self.metaName, self.metaBg)
	end

	for iter_74_0, iter_74_1 in pairs(self.rarityEffect) do
		if iter_74_1 then
			PoolMgr.GetInstance():ReturnUI("getrole_" .. iter_74_0, iter_74_1)
		end
	end

	if self.dragTrigger then
		ClearEventTrigger(self.dragTrigger)

		self.dragTrigger = nil
	end

	if not self.isRemoulded then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_newShipLayer_get", pg.ship_data_by_type[self._shipVO:getShipType()].type_name, self._shipVO:getName()), COLOR_GREEN)
	end

	self:recyclePainting()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:stopVoice()

	if self.loadedCVBankName then
		pg.CriMgr.UnloadCVBank(self.loadedCVBankName)

		self.loadedCVBankName = nil
	end

	if LeanTween.isTweening(go(self.rarityTF)) then
		LeanTween.cancel(go(self.rarityTF))
	end

	cameraPaintViewAdjust(false)

	return
end

function NewShipLayer:DisplayNewShipDocumentView()
	self.newShipDocumentView = NewShipDocumentView.New(self._shake:Find("ForNotch"), self.event, self.contextData)

	self.newShipDocumentView:Load()
	self.newShipDocumentView:ActionInvoke("SetParams", self._shipVO, function()
		if not self.isLoadBg then
			return
		end

		self:showExitTip()

		return
	end)
	self.newShipDocumentView:ActionInvoke("RefreshUI")

	return
end

function NewShipLayer:DestroyNewShipDocumentView()
	if self.newShipDocumentView and self.newShipDocumentView:CheckState(BaseSubView.STATES.INITED) then
		self.newShipDocumentView:Destroy()
	end

	return
end

function NewShipLayer:StopAutoExitTimer()
	if not self.autoExitTimer then
		return
	end

	self.autoExitTimer:Stop()

	self.autoExitTimer = nil

	return
end

return NewShipLayer
