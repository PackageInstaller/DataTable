local var_0_0 = class("PlayerVitaeShipCard", import(".PlayerVitaeBaseCard"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bgImage = arg_1_0._tf:Find("bg"):GetComponent(typeof(Image))
	arg_1_0.paintingTr = arg_1_0._tf:Find("ship_icon/painting")
	arg_1_0.paintingDefaultAngle = arg_1_0.paintingTr.localEulerAngles
	arg_1_0.detailTF = arg_1_0._tf:Find("detail")
	arg_1_0.lvTxtTF = arg_1_0.detailTF:Find("top/level")
	arg_1_0.lvTxt = arg_1_0.lvTxtTF:GetComponent(typeof(Text))
	arg_1_0.shipType = arg_1_0.detailTF:Find("top/type")
	arg_1_0.propsTr = arg_1_0.detailTF:Find("info")
	arg_1_0.nameTxt = arg_1_0.detailTF:Find("name_mask/name")
	arg_1_0.frame = arg_1_0._tf:Find("front/frame")
	arg_1_0.UIlist = UIItemList.New(arg_1_0._tf:Find("front/stars"), arg_1_0._tf:Find("front/stars/star_tpl"))
	arg_1_0.shipState = arg_1_0._tf:Find("front/flag")
	arg_1_0.proposeMark = arg_1_0._tf:Find("front/propose")
	arg_1_0.otherBg = arg_1_0._tf:Find("front/bg_other")
	arg_1_0.editTr = arg_1_0._tf:Find("mask")
	arg_1_0.changskinBtn = arg_1_0.editTr:Find("skin")
	arg_1_0.changskinBtnTag = arg_1_0.changskinBtn:Find("Tag")
	arg_1_0.randomTr = arg_1_0._tf:Find("mask1")
	arg_1_0.randomSkinBtn = arg_1_0.randomTr:Find("random_skin")
	arg_1_0.randomShipBtn = arg_1_0.randomTr:Find("random_ship")
	arg_1_0.tipTime = 0
	arg_1_0.nativeTr = arg_1_0._tf:Find("mask_2")

	local var_1_0 = arg_1_0.editTr:Find("tpl")

	eachChild(arg_1_0.editTr, function(arg_2_0)
		if string.find(arg_2_0.gameObject.name, "tpl") and arg_2_0 ~= var_1_0 then
			Object.Destroy(arg_2_0.gameObject)
		end

		return
	end)

	arg_1_0.btns = {
		PlayerVitaeSpineBtn.New(var_1_0, PlayerVitaeBaseBtn.VEC_TYPE),
		PlayerVitaeBGBtn.New(var_1_0, PlayerVitaeBaseBtn.VEC_TYPE),
		PlayerVitaeLive2dBtn.New(var_1_0, PlayerVitaeBaseBtn.VEC_TYPE)
	}

	onButton(arg_1_0, arg_1_0.changskinBtn, function()
		arg_1_0:emit(PlayerVitaeMediator.CHANGE_SKIN, arg_1_0.displayShip)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0._tf, function()
		if arg_1_0.inEdit then
			return
		end

		if not arg_1_0.canClick then
			if arg_1_0:ShouldTip() then
				arg_1_0:SetNextTipTime()
				pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_forbidden"))
			end

			return
		end

		arg_1_0:emit(PlayerVitaeMediator.CHANGE_PAINT, arg_1_0.displayShip)

		return
	end, SFX_PANEL)

	arg_1_0.eventTrigger = GetOrAddComponent(arg_1_0._go, typeof(EventTriggerListener))

	arg_1_0:RegisterEvent()
	setText(arg_1_0.randomSkinBtn:Find("Text"), i18n("random_ship_skin_label"))
	setText(arg_1_0.randomShipBtn:Find("Text"), i18n("random_ship_label"))
	setText(arg_1_0.changskinBtn:Find("Text"), i18n("random_flag_ship_changskinBtn_label"))

	arg_1_0.canDragFlag = true

	return
end

function var_0_0.DisableDrag(arg_5_0)
	arg_5_0.canDragFlag = false

	return
end

function var_0_0.EnableDrag(arg_6_0)
	arg_6_0.canDragFlag = true

	return
end

function var_0_0.CanDrag(arg_7_0)
	return not arg_7_0.inEdit and arg_7_0.canDragFlag
end

function var_0_0.ShouldTip(arg_8_0)
	local var_8_0 = pg.TimeMgr.GetInstance()

	return arg_8_0.tipTime <= var_8_0:GetServerTime()
end

function var_0_0.SetNextTipTime(arg_9_0)
	arg_9_0.tipTime = pg.TimeMgr.GetInstance():GetServerTime() + 3

	return
end

function var_0_0.RegisterEvent(arg_10_0)
	local var_10_0 = PlayerVitaeShipsPage.GetSlotMaxCnt()

	arg_10_0.eventTrigger:AddBeginDragFunc(function()
		if not arg_10_0:CanDrag() then
			return
		end

		if not arg_10_0.canClick then
			if arg_10_0:ShouldTip() then
				arg_10_0:SetNextTipTime()
				pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_forbidden"))
			end

			return
		end

		LeanTween.scale(arg_10_0.paintingTr, Vector3(1.1, 1.1, 0), 0.3)
		arg_10_0._tf:SetSiblingIndex(var_10_0 - 1)
		arg_10_0:emit(PlayerVitaeShipsPage.ON_BEGIN_DRAG_CARD, arg_10_0.slotIndex)
		setButtonEnabled(arg_10_0._tf, false)

		return
	end)
	arg_10_0.eventTrigger:AddDragFunc(function(arg_12_0, arg_12_1)
		if not arg_10_0:CanDrag() then
			return
		end

		if not arg_10_0.canClick then
			return
		end

		local var_12_0 = arg_10_0:Change2RectPos(arg_10_0._tf.parent, arg_12_1.position)

		arg_10_0._tf.localPosition = Vector3(var_12_0.x, arg_10_0._tf.localPosition.y, 0)

		arg_10_0:emit(PlayerVitaeShipsPage.ON_DRAGING_CARD, var_12_0)

		return
	end)
	arg_10_0.eventTrigger:AddDragEndFunc(function(arg_13_0, arg_13_1)
		if not arg_10_0:CanDrag() then
			return
		end

		if not arg_10_0.canClick then
			return
		end

		LeanTween.scale(arg_10_0.paintingTr, Vector3(1, 1, 0), 0.3)
		arg_10_0:emit(PlayerVitaeShipsPage.ON_DRAG_END_CARD)
		setButtonEnabled(arg_10_0._tf, true)

		return
	end)

	return
end

function var_0_0.Change2RectPos(arg_14_0, arg_14_1, arg_14_2)
	return (LuaHelper.ScreenToLocal(arg_14_1, arg_14_2, (GameObject.Find("OverlayCamera"):GetComponent("Camera"))))
end

function var_0_0.OnUpdate(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	arg_15_0.canClick = arg_15_4 ~= PlayerVitaeShipsPage.RANDOM_FLAG_SHIP_PAGE
	arg_15_0.slotIndex = arg_15_1
	arg_15_0.typeIndex = arg_15_2
	arg_15_0.shipIds = arg_15_3
	arg_15_0.pageType = arg_15_4
	arg_15_0.native = arg_15_5

	local var_15_0 = getProxy(BayProxy):GetShipPhantom(arg_15_3[arg_15_2])

	if not arg_15_0.displayShip or arg_15_0.displayShipSkinId ~= var_15_0:getSkinId() or arg_15_0.displayShip.id ~= var_15_0.id then
		arg_15_0:UpdateShip(var_15_0)
	end

	local var_15_1 = not HXSet.isHxSkin() and getProxy(ShipSkinProxy):HasFashion(var_15_0)

	setActive(arg_15_0.changskinBtn, var_15_1)

	local var_15_2 = arg_15_0.canClick and arg_15_0.native

	setActive(arg_15_0.nativeTr, var_15_2)

	if var_15_1 then
		arg_15_0:updatePaintingTag(var_15_0)
	end

	return
end

function var_0_0.Refresh(arg_16_0)
	arg_16_0:OnUpdate(arg_16_0.slotIndex, arg_16_0.typeIndex, arg_16_0.shipIds, arg_16_0.pageType, arg_16_0.native)

	if isActive(arg_16_0.editTr) then
		arg_16_0:UpdateBtns()
	end

	return
end

function var_0_0.UpdateShip(arg_17_0, arg_17_1)
	arg_17_0.displayShip = arg_17_1
	arg_17_0.displayShipSkinId = arg_17_1:getSkinId()
	arg_17_0.lvTxt.text = "Lv." .. arg_17_1.level

	local var_17_0 = arg_17_1:getStar()

	arg_17_0.UIlist:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			setActive(arg_18_2:Find("star"), arg_18_1 < var_17_0)
		end

		return
	end)
	arg_17_0.UIlist:align((arg_17_1:getMaxStar()))
	setScrollText(arg_17_0.nameTxt, arg_17_1:GetColorName())
	setPaintingPrefabAsync(arg_17_0.paintingTr, arg_17_1:getPainting(), "biandui", nil, {
		skinID = arg_17_1:getSkinId(),
		rotateZ = arg_17_0.paintingDefaultAngle.z
	})

	local var_17_1 = arg_17_1:rarity2bgPrint()

	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_17_1, "", arg_17_0.bgImage)
	setImageSprite(arg_17_0.shipType, GetSpriteFromAtlas("shiptype", shipType2print((arg_17_1:getShipType()))))

	local var_17_2, var_17_3 = arg_17_1:GetFrameAndEffect(true)

	setRectShipCardFrame(arg_17_0.frame, var_17_1, var_17_2)
	setFrameEffect(arg_17_0.otherBg, var_17_3)
	setProposeMarkIcon(arg_17_0.proposeMark, arg_17_1)
	arg_17_0:UpdateProps(arg_17_1)

	return
end

function var_0_0.updatePaintingTag(arg_19_0)
	if arg_19_0.displayShip then
		setActive(arg_19_0.changskinBtnTag, #PaintingGroupConst.GetPaintingNameListByShipVO(arg_19_0.displayShip) > 0)
	end

	return
end

function var_0_0.UpdateProps(arg_20_0, arg_20_1)
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
		local var_20_3 = arg_20_0.propsTr:GetChild(iter_20_0)

		if iter_20_0 < #var_20_2 then
			var_20_3.gameObject:SetActive(true)

			local var_20_4 = var_20_3:GetChild(0)

			var_20_4:GetComponent("Text").text = var_20_2[iter_20_0 + 1][1]

			local var_20_5 = var_20_3:GetChild(1)

			var_20_5:GetComponent("Text").text = var_20_2[iter_20_0 + 1][2]
		else
			var_20_3.gameObject:SetActive(false)
		end
	end

	return
end

function var_0_0.EditCard(arg_21_0, arg_21_1)
	if not arg_21_0.displayShip then
		return
	end

	setActive(arg_21_0.editTr, arg_21_1)
	arg_21_0:UpdateBtns()

	arg_21_0.inEdit = arg_21_1

	local var_21_0 = arg_21_0.canClick and arg_21_0.native and not arg_21_0.inEdit

	setActive(arg_21_0.nativeTr, var_21_0)

	return
end

function var_0_0.UpdateBtns(arg_22_0)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.btns) do
		local var_22_1 = iter_22_1:IsActive(arg_22_0.displayShip)

		if var_22_1 then
			var_22_0 = var_22_0 + 1
		end

		iter_22_1:Update(var_22_1, var_22_0, arg_22_0.displayShip)
	end

	return
end

function var_0_0.EditCardForRandom(arg_23_0, arg_23_1)
	if not arg_23_0.displayShip then
		return
	end

	setActive(arg_23_0.randomTr, arg_23_1)

	if arg_23_1 then
		arg_23_0:UpdateRandomBtns()
	else
		removeOnButton(arg_23_0.randomSkinBtn)
		removeOnButton(arg_23_0.randomShipBtn)
		arg_23_0:ClearRandomFlagValue()
	end

	arg_23_0.inEdit = arg_23_1
	arg_23_0.inRandomEdit = arg_23_1

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
	setActive(arg_24_1:Find("on"), arg_24_2)
	setActive(arg_24_1:Find("off"), not arg_24_2)

	return
end

function var_0_0.UpdateRandomBtns(arg_26_0)
	local function var_26_0(arg_27_0, arg_27_1)
		return (arg_27_0 and 1 or 0) + (arg_27_1 and 2 or 0)
	end

	local var_26_1 = arg_26_0.slotIndex or 1
	local var_26_2 = getProxy(PlayerProxy):getRawData()
	local var_26_3 = var_26_2:IsOpenRandomFlagShipSkinInPos(var_26_1)
	local var_26_4 = var_26_2:IsOpenRandomFlagShipInPos(var_26_1)

	var_0_1(arg_26_0, arg_26_0.randomSkinBtn, var_26_3, function(arg_28_0)
		var_26_3 = arg_28_0
		arg_26_0.randomFlagValue = var_26_0(var_26_3, var_26_4)

		return
	end)
	var_0_1(arg_26_0, arg_26_0.randomShipBtn, var_26_4, function(arg_29_0)
		var_26_4 = arg_29_0
		arg_26_0.randomFlagValue = var_26_0(var_26_3, var_26_4)

		return
	end)

	arg_26_0.randomFlagValue = (function(arg_27_0, arg_27_1)
		return (arg_27_0 and 1 or 0) + (arg_27_1 and 2 or 0)
	end)(var_26_3, var_26_4)

	setActive(arg_26_0.randomShipBtn, var_26_2:CanRandomFlagShipInPos(var_26_1))

	return
end

function var_0_0.GetRandomFlagValue(arg_30_0)
	assert(arg_30_0.inRandomEdit)

	if arg_30_0.randomFlagValue then
		return arg_30_0.randomFlagValue
	else
		return getProxy(PlayerProxy):getRawData():RawGetRandomShipAndSkinValueInpos(arg_30_0.slotIndex)
	end

	return
end

function var_0_0.ClearRandomFlagValue(arg_31_0)
	arg_31_0.randomFlagValue = nil

	return
end

function var_0_0.Disable(arg_32_0)
	var_0_0.super.Disable(arg_32_0)

	arg_32_0.inEdit = false
	arg_32_0.inRandomEdit = false

	return
end

function var_0_0.OnDispose(arg_33_0)
	if arg_33_0.displayShip then
		retPaintingPrefab(arg_33_0.paintingTr, arg_33_0.displayShip:getPainting())
	end

	ClearEventTrigger(arg_33_0.eventTrigger)

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.btns) do
		iter_33_1:Dispose()
	end

	arg_33_0.btns = nil

	arg_33_0:Disable()

	return
end

return var_0_0
