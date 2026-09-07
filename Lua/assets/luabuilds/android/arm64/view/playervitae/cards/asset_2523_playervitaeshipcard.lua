local PlayerVitaeShipCard = class("PlayerVitaeShipCard", import(".PlayerVitaeBaseCard"))

function PlayerVitaeShipCard:OnInit()
	self.bgImage = self._tf:Find("bg"):GetComponent(typeof(Image))
	self.paintingTr = self._tf:Find("ship_icon/painting")
	self.paintingDefaultAngle = self.paintingTr.localEulerAngles
	self.detailTF = self._tf:Find("detail")
	self.lvTxtTF = self.detailTF:Find("top/level")
	self.lvTxt = self.lvTxtTF:GetComponent(typeof(Text))
	self.shipType = self.detailTF:Find("top/type")
	self.propsTr = self.detailTF:Find("info")
	self.nameTxt = self.detailTF:Find("name_mask/name")
	self.frame = self._tf:Find("front/frame")
	self.UIlist = UIItemList.New(self._tf:Find("front/stars"), self._tf:Find("front/stars/star_tpl"))
	self.shipState = self._tf:Find("front/flag")
	self.proposeMark = self._tf:Find("front/propose")
	self.otherBg = self._tf:Find("front/bg_other")
	self.editTr = self._tf:Find("mask")
	self.changskinBtn = self.editTr:Find("skin")
	self.changskinBtnTag = self.changskinBtn:Find("Tag")
	self.randomTr = self._tf:Find("mask1")
	self.randomSkinBtn = self.randomTr:Find("random_skin")
	self.randomShipBtn = self.randomTr:Find("random_ship")
	self.tipTime = 0
	self.nativeTr = self._tf:Find("mask_2")

	local var_1_0 = self.editTr:Find("tpl")

	eachChild(self.editTr, function(arg_2_0)
		if string.find(arg_2_0.gameObject.name, "tpl") and arg_2_0 ~= var_1_0 then
			Object.Destroy(arg_2_0.gameObject)
		end

		return
	end)

	self.btns = {
		PlayerVitaeSpineBtn.New(var_1_0, PlayerVitaeBaseBtn.VEC_TYPE),
		PlayerVitaeBGBtn.New(var_1_0, PlayerVitaeBaseBtn.VEC_TYPE),
		PlayerVitaeLive2dBtn.New(var_1_0, PlayerVitaeBaseBtn.VEC_TYPE)
	}

	onButton(self, self.changskinBtn, function()
		self:emit(PlayerVitaeMediator.CHANGE_SKIN, self.displayShip)

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		if self.inEdit then
			return
		end

		if not self.canClick then
			if self:ShouldTip() then
				self:SetNextTipTime()
				pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_forbidden"))
			end

			return
		end

		self:emit(PlayerVitaeMediator.CHANGE_PAINT, self.displayShip)

		return
	end, SFX_PANEL)

	self.eventTrigger = GetOrAddComponent(self._go, typeof(EventTriggerListener))

	self:RegisterEvent()
	setText(self.randomSkinBtn:Find("Text"), i18n("random_ship_skin_label"))
	setText(self.randomShipBtn:Find("Text"), i18n("random_ship_label"))
	setText(self.changskinBtn:Find("Text"), i18n("random_flag_ship_changskinBtn_label"))

	self.canDragFlag = true

	return
end

function PlayerVitaeShipCard:DisableDrag()
	self.canDragFlag = false

	return
end

function PlayerVitaeShipCard:EnableDrag()
	self.canDragFlag = true

	return
end

function PlayerVitaeShipCard:CanDrag()
	return not self.inEdit and self.canDragFlag
end

function PlayerVitaeShipCard:ShouldTip()
	return self.tipTime <= pg.TimeMgr.GetInstance():GetServerTime()
end

function PlayerVitaeShipCard:SetNextTipTime()
	self.tipTime = pg.TimeMgr.GetInstance():GetServerTime() + 3

	return
end

function PlayerVitaeShipCard:RegisterEvent()
	local var_10_0 = PlayerVitaeShipsPage.GetSlotMaxCnt()

	self.eventTrigger:AddBeginDragFunc(function()
		if not self:CanDrag() then
			return
		end

		if not self.canClick then
			if self:ShouldTip() then
				self:SetNextTipTime()
				pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_forbidden"))
			end

			return
		end

		LeanTween.scale(self.paintingTr, Vector3(1.1, 1.1, 0), 0.3)
		self._tf:SetSiblingIndex(var_10_0 - 1)
		self:emit(PlayerVitaeShipsPage.ON_BEGIN_DRAG_CARD, self.slotIndex)
		setButtonEnabled(self._tf, false)

		return
	end)
	self.eventTrigger:AddDragFunc(function(arg_12_0, arg_12_1)
		if not self:CanDrag() then
			return
		end

		if not self.canClick then
			return
		end

		local var_12_0 = self:Change2RectPos(self._tf.parent, arg_12_1.position)

		self._tf.localPosition = Vector3(var_12_0.x, self._tf.localPosition.y, 0)

		self:emit(PlayerVitaeShipsPage.ON_DRAGING_CARD, var_12_0)

		return
	end)
	self.eventTrigger:AddDragEndFunc(function(arg_13_0, arg_13_1)
		if not self:CanDrag() then
			return
		end

		if not self.canClick then
			return
		end

		LeanTween.scale(self.paintingTr, Vector3(1, 1, 0), 0.3)
		self:emit(PlayerVitaeShipsPage.ON_DRAG_END_CARD)
		setButtonEnabled(self._tf, true)

		return
	end)

	return
end

function PlayerVitaeShipCard:Change2RectPos(arg_14_1, arg_14_2)
	return (LuaHelper.ScreenToLocal(arg_14_1, arg_14_2, (GameObject.Find("OverlayCamera"):GetComponent("Camera"))))
end

function PlayerVitaeShipCard:OnUpdate(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	self.canClick = arg_15_4 ~= PlayerVitaeShipsPage.RANDOM_FLAG_SHIP_PAGE
	self.slotIndex = arg_15_1
	self.typeIndex = arg_15_2
	self.shipIds = arg_15_3
	self.pageType = arg_15_4
	self.native = arg_15_5

	local var_15_0 = getProxy(BayProxy):GetShipPhantom(arg_15_3[arg_15_2])

	if not self.displayShip or self.displayShipSkinId ~= var_15_0:getSkinId() or self.displayShip.id ~= var_15_0.id then
		self:UpdateShip(var_15_0)
	end

	local var_15_1 = not HXSet.isHxSkin() and getProxy(ShipSkinProxy):HasFashion(var_15_0)

	setActive(self.changskinBtn, var_15_1)
	setActive(self.nativeTr, self.canClick and self.native)

	if var_15_1 then
		self:updatePaintingTag(var_15_0)
	end

	return
end

function PlayerVitaeShipCard:Refresh()
	self:OnUpdate(self.slotIndex, self.typeIndex, self.shipIds, self.pageType, self.native)

	if isActive(self.editTr) then
		self:UpdateBtns()
	end

	return
end

function PlayerVitaeShipCard:UpdateShip(arg_17_1)
	self.displayShip = arg_17_1
	self.displayShipSkinId = arg_17_1:getSkinId()
	self.lvTxt.text = "Lv." .. arg_17_1.level

	local var_17_0 = arg_17_1:getStar()

	self.UIlist:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			setActive(arg_18_2:Find("star"), arg_18_1 < var_17_0)
		end

		return
	end)
	self.UIlist:align((arg_17_1:getMaxStar()))
	setScrollText(self.nameTxt, arg_17_1:GetColorName())
	setPaintingPrefabAsync(self.paintingTr, arg_17_1:getPainting(), "biandui", nil, {
		skinID = arg_17_1:getSkinId(),
		rotateZ = self.paintingDefaultAngle.z
	})

	local var_17_1 = arg_17_1:rarity2bgPrint()

	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_17_1, "", self.bgImage)
	setImageSprite(self.shipType, GetSpriteFromAtlas("shiptype", shipType2print((arg_17_1:getShipType()))))

	local var_17_2, var_17_3 = arg_17_1:GetFrameAndEffect(true)

	setRectShipCardFrame(self.frame, var_17_1, var_17_2)
	setFrameEffect(self.otherBg, var_17_3)
	setProposeMarkIcon(self.proposeMark, arg_17_1)
	self:UpdateProps(arg_17_1)

	return
end

function PlayerVitaeShipCard:updatePaintingTag()
	if self.displayShip then
		setActive(self.changskinBtnTag, #PaintingGroupConst.GetPaintingNameListByShipVO(self.displayShip) > 0)
	end

	return
end

function PlayerVitaeShipCard:UpdateProps(arg_20_1)
	local var_20_0, var_20_1 = arg_20_1:getIntimacyDetail()
	local var_20_2 = {
		{
			i18n("word_lv"),
			arg_20_1.level
		},
		{
			i18n("attribute_intimacy"),
			var_20_1
		},
		{
			i18n("word_synthesize_power"),
			"<color=#ffff00>" .. arg_20_1:getShipCombatPower() .. "</color>"
		}
	}

	for iter_20_0 = 0, 2 do
		local var_20_3 = self.propsTr:GetChild(iter_20_0)

		if iter_20_0 < #var_20_2 then
			var_20_3.gameObject:SetActive(true)

			var_20_3:GetChild(0):GetComponent("Text").text = var_20_2[iter_20_0 + 1][1]
			var_20_3:GetChild(1):GetComponent("Text").text = var_20_2[iter_20_0 + 1][2]
		else
			var_20_3.gameObject:SetActive(false)
		end
	end

	return
end

function PlayerVitaeShipCard:EditCard(arg_21_1)
	if not self.displayShip then
		return
	end

	setActive(self.editTr, arg_21_1)
	self:UpdateBtns()

	self.inEdit = arg_21_1

	setActive(self.nativeTr, self.canClick and self.native and not self.inEdit)

	return
end

function PlayerVitaeShipCard:UpdateBtns()
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(self.btns) do
		local var_22_1 = iter_22_1:IsActive(self.displayShip)

		if var_22_1 then
			var_22_0 = var_22_0 + 1
		end

		iter_22_1:Update(var_22_1, var_22_0, self.displayShip)
	end

	return
end

function PlayerVitaeShipCard:EditCardForRandom(arg_23_1)
	if not self.displayShip then
		return
	end

	setActive(self.randomTr, arg_23_1)

	if arg_23_1 then
		self:UpdateRandomBtns()
	else
		removeOnButton(self.randomSkinBtn)
		removeOnButton(self.randomShipBtn)
		self:ClearRandomFlagValue()
	end

	self.inEdit = arg_23_1
	self.inRandomEdit = arg_23_1

	return
end

local function var_0_1(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_1:Find("on")
	local var_24_1 = arg_24_1:Find("off")

	onButton(arg_24_0, arg_24_1, function()
		arg_24_2 = not arg_24_2

		setActive(var_24_0, arg_24_2)
		setActive(var_24_1, not arg_24_2)
		arg_24_3(arg_24_2)

		return
	end, SFX_PANEL)
	setActive(var_24_0, arg_24_2)
	setActive(var_24_1, not arg_24_2)

	return
end

function PlayerVitaeShipCard:UpdateRandomBtns()
	local function var_26_0(arg_27_0, arg_27_1)
		return (arg_27_0 and 1 or 0) + (arg_27_1 and 2 or 0)
	end

	local var_26_1 = self.slotIndex or 1
	local var_26_2 = getProxy(PlayerProxy):getRawData()
	local var_26_3 = var_26_2:IsOpenRandomFlagShipSkinInPos(var_26_1)
	local var_26_4 = var_26_2:IsOpenRandomFlagShipInPos(var_26_1)

	var_0_1(self, self.randomSkinBtn, var_26_3, function(arg_28_0)
		var_26_3 = arg_28_0
		self.randomFlagValue = var_26_0(var_26_3, var_26_4)

		return
	end)
	var_0_1(self, self.randomShipBtn, var_26_4, function(arg_29_0)
		var_26_4 = arg_29_0
		self.randomFlagValue = var_26_0(var_26_3, var_26_4)

		return
	end)

	self.randomFlagValue = var_26_0(var_26_3, var_26_4)

	setActive(self.randomShipBtn, var_26_2:CanRandomFlagShipInPos(var_26_1))

	return
end

function PlayerVitaeShipCard:GetRandomFlagValue()
	assert(self.inRandomEdit)

	if self.randomFlagValue then
		return self.randomFlagValue
	else
		return getProxy(PlayerProxy):getRawData():RawGetRandomShipAndSkinValueInpos(self.slotIndex)
	end

	return
end

function PlayerVitaeShipCard:ClearRandomFlagValue()
	self.randomFlagValue = nil

	return
end

function PlayerVitaeShipCard:Disable()
	PlayerVitaeShipCard.super.Disable(self)

	self.inEdit = false
	self.inRandomEdit = false

	return
end

function PlayerVitaeShipCard:OnDispose()
	if self.displayShip then
		retPaintingPrefab(self.paintingTr, self.displayShip:getPainting())
	end

	ClearEventTrigger(self.eventTrigger)

	for iter_33_0, iter_33_1 in ipairs(self.btns) do
		iter_33_1:Dispose()
	end

	self.btns = nil

	self:Disable()

	return
end

return PlayerVitaeShipCard
