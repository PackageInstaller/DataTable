class = var_0_10000

local var_0_0 = "PlayerVitaeShipCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerVitaeBaseCard"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_1.Find(var_1_0, "bg")
	local var_1_2 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_1_0.bgImage = var_1_2(var_1_1, var_4(var_1_10006))

	local var_1_3 = arg_1_0._tf

	arg_1_0.paintingTr = var_1.Find(var_1_3, "ship_icon/painting")
	arg_1_0.paintingDefaultAngle = arg_1_0.paintingTr.localEulerAngles

	local var_1_4 = arg_1_0._tf

	arg_1_0.detailTF = var_1.Find(var_1_4, "detail")

	local var_1_5 = arg_1_0.detailTF

	arg_1_0.lvTxtTF = var_1.Find(var_1_5, "top/level")

	local var_1_6 = arg_1_0.lvTxtTF
	local var_1_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.lvTxt = var_1_7(var_1_6, var_4(var_1_10006))

	local var_1_8 = arg_1_0.detailTF

	arg_1_0.shipType = var_1.Find(var_1_8, "top/type")

	local var_1_9 = arg_1_0.detailTF

	arg_1_0.propsTr = var_1.Find(var_1_9, "info")

	local var_1_10 = arg_1_0.detailTF

	arg_1_0.nameTxt = var_1.Find(var_1_10, "name_mask/name")

	local var_1_11 = arg_1_0._tf

	arg_1_0.frame = var_1.Find(var_1_11, "front/frame")
	UIItemList = var_1

	local var_1_12 = var_1.New
	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_3.Find(var_1_13, "front/stars")
	local var_1_15 = arg_1_0._tf

	arg_1_0.UIlist = var_1_12(var_1_14, var_4.Find(var_1_15, "front/stars/star_tpl"))

	local var_1_16 = arg_1_0._tf

	arg_1_0.shipState = var_1.Find(var_1_16, "front/flag")

	local var_1_17 = arg_1_0._tf

	arg_1_0.proposeMark = var_1.Find(var_1_17, "front/propose")

	local var_1_18 = arg_1_0._tf

	arg_1_0.otherBg = var_1.Find(var_1_18, "front/bg_other")

	local var_1_19 = arg_1_0._tf

	arg_1_0.editTr = var_1.Find(var_1_19, "mask")

	local var_1_20 = arg_1_0.editTr

	arg_1_0.changskinBtn = var_1.Find(var_1_20, "skin")

	local var_1_21 = arg_1_0.changskinBtn

	arg_1_0.changskinBtnTag = var_1.Find(var_1_21, "Tag")

	local var_1_22 = arg_1_0._tf

	arg_1_0.randomTr = var_1.Find(var_1_22, "mask1")

	local var_1_23 = arg_1_0.randomTr

	arg_1_0.randomSkinBtn = var_1.Find(var_1_23, "random_skin")

	local var_1_24 = arg_1_0.randomTr

	arg_1_0.randomShipBtn = var_1.Find(var_1_24, "random_ship")
	arg_1_0.tipTime = 0

	local var_1_25 = arg_1_0._tf

	arg_1_0.nativeTr = var_1.Find(var_1_25, "mask_2")

	local var_1_26 = arg_1_0.editTr
	local var_1_27 = var_1.Find(var_1_26, "tpl")

	eachChild = var_1_10002

	var_1_10002(arg_1_0.editTr, function(arg_2_0)
		string = var_2_10001

		if var_2_10001.find(arg_2_0.gameObject.name, "tpl") and arg_2_0 ~= var_1_27 then
			Object = var_1

			var_1.Destroy(arg_2_0.gameObject)
		end

		return
	end)

	local var_1_28 = {}

	PlayerVitaeSpineBtn = var_1_26

	local var_1_29 = var_1_26.New
	local var_1_30 = var_1_27

	PlayerVitaeBaseBtn = var_1_15
	var_1_28[1] = var_1_29(var_1_30, var_1_15.VEC_TYPE)
	PlayerVitaeBGBtn = var_3

	local var_1_31 = var_3.New
	local var_1_32 = var_1_27

	PlayerVitaeBaseBtn = var_6
	var_1_28[2] = var_1_31(var_1_32, var_6.VEC_TYPE)
	PlayerVitaeLive2dBtn = var_3

	local var_1_33 = var_3.New
	local var_1_34 = var_1_27

	PlayerVitaeBaseBtn = var_6
	var_1_28[3] = var_1_33(var_1_34, var_6.VEC_TYPE)
	arg_1_0.btns = var_1_28
	onButton = var_1_28

	local var_1_35 = arg_1_0
	local var_1_36 = arg_1_0.changskinBtn

	local function var_1_37()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		PlayerVitaeMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.CHANGE_SKIN, arg_1_0.displayShip)

		return
	end

	SFX_PANEL = var_7

	var_1_28(var_1_35, var_1_36, var_1_37, var_7)

	onButton = var_1_28

	local var_1_38 = arg_1_0
	local var_1_39 = arg_1_0._tf

	local function var_1_40()
		if arg_1_0.inEdit then
			return
		end

		if not arg_1_0.canClick then
			local var_4_0 = arg_1_0

			if var_0.ShouldTip(var_4_0) then
				local var_4_1 = arg_1_0

				var_0.SetNextTipTime(var_4_1)

				pg = var_0

				local var_4_2 = var_0.TipsMgr.GetInstance()
				local var_4_3 = var_0.ShowTips

				i18n = var_2_10003

				var_4_3(var_4_2, var_2_10003("random_ship_forbidden"))
			end

			return
		end

		local var_4_4 = arg_1_0
		local var_4_5 = var_0.emit

		PlayerVitaeMediator = var_2_10003

		var_4_5(var_4_4, var_2_10003.CHANGE_PAINT, arg_1_0.displayShip)

		return
	end

	SFX_PANEL = var_7

	var_1_28(var_1_38, var_1_39, var_1_40, var_7)

	GetOrAddComponent = var_1_28

	local var_1_41 = arg_1_0._go

	typeof = var_1_39
	EventTriggerListener = var_7
	arg_1_0.eventTrigger = var_1_28(var_1_41, var_1_39(var_7))

	arg_1_0:RegisterEvent()

	setText = var_2

	local var_1_42 = arg_1_0.randomSkinBtn
	local var_1_43 = var_4.Find(var_1_42, "Text")

	i18n = var_5

	var_2(var_1_43, var_5("random_ship_skin_label"))

	setText = var_2

	local var_1_44 = arg_1_0.randomShipBtn
	local var_1_45 = var_4.Find(var_1_44, "Text")

	i18n = var_5

	var_2(var_1_45, var_5("random_ship_label"))

	setText = var_2

	local var_1_46 = arg_1_0.changskinBtn
	local var_1_47 = var_4.Find(var_1_46, "Text")

	i18n = var_5

	var_2(var_1_47, var_5("random_flag_ship_changskinBtn_label"))

	arg_1_0.canDragFlag = true

	return
end

function var_0_1.DisableDrag(arg_5_0)
	arg_5_0.canDragFlag = false

	return
end

function var_0_1.EnableDrag(arg_6_0)
	arg_6_0.canDragFlag = true

	return
end

function var_0_1.CanDrag(arg_7_0)
	return not arg_7_0.inEdit and arg_7_0.canDragFlag
end

function var_0_1.ShouldTip(arg_8_0)
	local var_8_0 = arg_8_0.tipTime

	pg = var_1_10002

	local var_8_1 = var_1_10002.TimeMgr.GetInstance()

	return var_8_0 <= var_2.GetServerTime(var_8_1)
end

function var_0_1.SetNextTipTime(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.TimeMgr.GetInstance()

	arg_9_0.tipTime = var_1.GetServerTime(var_9_0) + 3

	return
end

function var_0_1.RegisterEvent(arg_10_0)
	local var_10_0 = arg_10_0.eventTrigger

	PlayerVitaeShipsPage = var_1_10002

	local var_10_1 = var_1_10002.GetSlotMaxCnt()

	var_10_0:AddBeginDragFunc(function()
		local var_11_0 = arg_10_0

		if not var_0.CanDrag(var_11_0) then
			return
		end

		local var_11_4

		if not arg_10_0.canClick then
			local var_11_1 = arg_10_0

			if var_11_4.ShouldTip(var_11_1) then
				local var_11_2 = arg_10_0

				var_11_4.SetNextTipTime(var_11_2)

				pg = var_11_4

				local var_11_3 = var_11_4.TipsMgr.GetInstance()

				var_11_4 = var_11_4.ShowTips
				i18n = var_2_10003

				var_11_4(var_11_3, var_2_10003("random_ship_forbidden"))
			end

			return
		end

		LeanTween = var_11_4

		local var_11_5 = var_11_4.scale
		local var_11_6 = arg_10_0.paintingTr

		Vector3 = var_2_10003

		var_11_5(var_11_6, var_2_10003(1.1, 1.1, 0), 0.3)

		local var_11_7 = arg_10_0._tf

		var_0.SetSiblingIndex(var_11_7, var_10_1 - 1)

		local var_11_8 = arg_10_0
		local var_11_9 = var_0.emit

		PlayerVitaeShipsPage = var_3

		var_11_9(var_11_8, var_3.ON_BEGIN_DRAG_CARD, arg_10_0.slotIndex)

		setButtonEnabled = var_11_9

		var_11_9(arg_10_0._tf, false)

		return
	end)
	var_10_0:AddDragFunc(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_10_0

		if not var_2.CanDrag(var_12_0) then
			return
		end

		if not arg_10_0.canClick then
			return
		end

		local var_12_1 = arg_10_0
		local var_12_2 = var_2.Change2RectPos(var_12_1, arg_10_0._tf.parent, arg_12_1.position)
		local var_12_3 = arg_10_0._tf

		Vector3 = var_12_1
		var_12_3.localPosition = var_12_1(var_12_2.x, arg_10_0._tf.localPosition.y, 0)

		local var_12_4 = arg_10_0
		local var_12_5 = var_3.emit

		PlayerVitaeShipsPage = var_6

		var_12_5(var_12_4, var_6.ON_DRAGING_CARD, var_12_2)

		return
	end)
	var_10_0:AddDragEndFunc(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_10_0

		if not var_2.CanDrag(var_13_0) then
			return
		end

		if not arg_10_0.canClick then
			return
		end

		LeanTween = var_2

		local var_13_1 = var_2.scale
		local var_13_2 = arg_10_0.paintingTr

		Vector3 = var_2_10005

		var_13_1(var_13_2, var_2_10005(1, 1, 0), 0.3)

		local var_13_3 = arg_10_0
		local var_13_4 = var_2.emit

		PlayerVitaeShipsPage = var_5

		var_13_4(var_13_3, var_5.ON_DRAG_END_CARD)

		setButtonEnabled = var_13_4

		var_13_4(arg_10_0._tf, true)

		return
	end)

	return
end

function var_0_1.Change2RectPos(arg_14_0, arg_14_1, arg_14_2)
	GameObject = var_1_10003

	local var_14_0 = var_1_10003.Find("OverlayCamera")
	local var_14_1 = var_3.GetComponent(var_14_0, "Camera")

	LuaHelper = var_1_10004

	return (var_1_10004.ScreenToLocal(arg_14_1, arg_14_2, var_14_1))
end

function var_0_1.OnUpdate(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	PlayerVitaeShipsPage = var_1_10006
	arg_15_0.canClick = arg_15_4 ~= var_1_10006.RANDOM_FLAG_SHIP_PAGE
	arg_15_0.slotIndex = arg_15_1
	arg_15_0.typeIndex = arg_15_2
	arg_15_0.shipIds = arg_15_3
	arg_15_0.pageType = arg_15_4
	arg_15_0.native = arg_15_5

	local var_15_0 = arg_15_3[arg_15_2]

	getProxy = var_1_10007
	BayProxy = var_1_10009

	local var_15_1 = var_1_10007(var_1_10009)
	local var_15_2 = var_7.GetShipPhantom(var_15_1, var_15_0)
	local var_15_3

	if not arg_15_0.displayShip or arg_15_0.displayShipSkinId ~= var_15_2:getSkinId() or arg_15_0.displayShip.id ~= var_15_2.id then
		var_15_3 = arg_15_0

		arg_15_0.UpdateShip(var_15_3, var_15_2)
	end

	HXSet = var_8

	local var_15_5

	if not var_8.isHxSkin() then
		getProxy = var_8
		ShipSkinProxy = var_15_3

		local var_15_4 = var_8(var_15_3)

		var_15_5 = var_8.HasFashion(var_15_4, var_15_2)
	else
		var_15_5 = false
	end

	if false then
		var_15_5 = true
	end

	setActive = var_15_1

	var_15_1(arg_15_0.changskinBtn, var_15_5)

	setActive = var_15_1

	local var_15_6 = arg_15_0.nativeTr
	local var_15_7

	if arg_15_0.canClick then
		var_15_7 = arg_15_0.native
	end

	var_15_1(var_15_6, var_15_7)

	if var_15_5 then
		arg_15_0:updatePaintingTag(var_15_2)
	end

	return
end

function var_0_1.Refresh(arg_16_0)
	arg_16_0:OnUpdate(arg_16_0.slotIndex, arg_16_0.typeIndex, arg_16_0.shipIds, arg_16_0.pageType, arg_16_0.native)

	isActive = var_1

	if var_1(arg_16_0.editTr) then
		arg_16_0:UpdateBtns()
	end

	return
end

function var_0_1.UpdateShip(arg_17_0, arg_17_1)
	arg_17_0.displayShip = arg_17_1
	arg_17_0.displayShipSkinId = arg_17_1:getSkinId()
	arg_17_0.lvTxt.text = "Lv." .. arg_17_1.level

	local var_17_0 = arg_17_1:getMaxStar()
	local var_17_1 = arg_17_1
	local var_17_2 = arg_17_1.getStar(var_17_1)
	local var_17_3 = arg_17_0.UIlist

	var_4.make(var_17_3, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_18_2:Find("star"), arg_18_1 < var_17_2)
		end

		return
	end)

	local var_17_4 = arg_17_0.UIlist

	var_4.align(var_17_4, var_17_0)

	setScrollText = var_4

	var_4(arg_17_0.nameTxt, arg_17_1:GetColorName())

	setPaintingPrefabAsync = var_4

	var_4(arg_17_0.paintingTr, arg_17_1:getPainting(), "biandui", nil, {
		skinID = arg_17_1:getSkinId(),
		rotateZ = arg_17_0.paintingDefaultAngle.z
	})

	local var_17_5 = arg_17_1
	local var_17_6 = arg_17_1.rarity2bgPrint(var_17_5)

	GetImageSpriteFromAtlasAsync = var_17_1

	var_17_1("bg/star_level_card_" .. var_17_6, "", arg_17_0.bgImage)

	local var_17_7 = arg_17_1:getShipType()

	setImageSprite = var_17_5

	local var_17_8 = arg_17_0.shipType

	GetSpriteFromAtlas = var_9

	local var_17_9 = "shiptype"

	shipType2print = var_1_10012

	var_17_5(var_17_8, var_9(var_17_9, var_1_10012(var_17_7)))

	local var_17_10 = arg_17_1
	local var_17_11, var_17_12 = arg_17_1.GetFrameAndEffect(var_17_10, true)

	setRectShipCardFrame = var_17_10

	var_17_10(arg_17_0.frame, var_17_6, var_17_11)

	setFrameEffect = var_17_10

	var_17_10(arg_17_0.otherBg, var_17_12)

	setProposeMarkIcon = var_17_10

	var_17_10(arg_17_0.proposeMark, arg_17_1)
	arg_17_0:UpdateProps(arg_17_1)

	return
end

function var_0_1.updatePaintingTag(arg_19_0)
	if arg_19_0.displayShip then
		setActive = var_1_10002

		local var_19_0 = arg_19_0.changskinBtnTag

		PaintingGroupConst = var_1_10005

		var_1_10002(var_19_0, #var_1_10005.GetPaintingNameListByShipVO(var_1) > 0)
	end

	return
end

function var_0_1.UpdateProps(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:getShipCombatPower()
	local var_20_1, var_20_2 = arg_20_1:getIntimacyDetail()
	local var_20_3 = {}
	local var_20_4 = {}

	i18n = var_1_10007
	var_20_4[1] = var_1_10007("word_lv")
	var_20_4[2] = arg_20_1.level
	var_20_3[1] = var_20_4

	local var_20_5 = {}

	i18n = var_7
	var_20_5[1] = var_7("attribute_intimacy")
	var_20_5[2] = var_20_2
	var_20_3[2] = var_20_5

	local var_20_6 = {}

	i18n = var_7
	var_20_6[1] = var_7("word_synthesize_power")
	var_20_6[2] = "<color=#ffff00>" .. var_20_0 .. "</color>"
	var_20_3[3] = var_20_6

	for iter_20_0 = 0, 2 do
		local var_20_7 = arg_20_0.propsTr
		local var_20_8 = var_10.GetChild(var_20_7, iter_20_0)

		if iter_20_0 < #var_20_3 then
			local var_20_9 = var_20_8.gameObject

			var_11.SetActive(var_20_9, true)

			local var_20_10 = var_20_8:GetChild(0)

			var_11.GetComponent(var_20_10, "Text").text = var_20_3[iter_20_0 + 1][1]

			local var_20_11 = var_20_8:GetChild(1)

			var_11.GetComponent(var_20_11, "Text").text = var_20_3[iter_20_0 + 1][2]
		else
			local var_20_12 = var_20_8.gameObject

			var_11.SetActive(var_20_12, false)
		end
	end

	return
end

function var_0_1.EditCard(arg_21_0, arg_21_1)
	if not arg_21_0.displayShip then
		return
	end

	setActive = var_2

	var_2(arg_21_0.editTr, arg_21_1)
	arg_21_0:UpdateBtns()

	arg_21_0.inEdit = arg_21_1
	setActive = var_2

	local var_21_0 = arg_21_0.nativeTr
	local var_21_1

	if arg_21_0.canClick and arg_21_0.native then
		var_21_1 = not arg_21_0.inEdit
	end

	var_2(var_21_0, var_21_1)

	return
end

function var_0_1.UpdateBtns(arg_22_0)
	local var_22_0 = arg_22_0.displayShip
	local var_22_1 = 0

	ipairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(arg_22_0.btns) do
		if iter_22_1:IsActive(var_22_0) then
			var_22_1 = var_22_1 + 1
		end

		iter_22_1:Update(var_8, var_22_1, var_22_0)
	end

	return
end

function var_0_1.EditCardForRandom(arg_23_0, arg_23_1)
	if not arg_23_0.displayShip then
		return
	end

	setActive = var_2

	var_2(arg_23_0.randomTr, arg_23_1)

	if arg_23_1 then
		arg_23_0:UpdateRandomBtns()
	else
		removeOnButton = var_2

		var_2(arg_23_0.randomSkinBtn)

		removeOnButton = var_2

		var_2(arg_23_0.randomShipBtn)
		arg_23_0:ClearRandomFlagValue()
	end

	arg_23_0.inEdit = arg_23_1
	arg_23_0.inRandomEdit = arg_23_1

	return
end

local function var_0_2(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_1
	local var_24_1 = arg_24_1.Find(var_24_0, "on")
	local var_24_2 = arg_24_1:Find("off")

	onButton = var_24_0

	local var_24_3 = arg_24_0
	local var_24_4 = arg_24_1

	local function var_24_5()
		arg_24_2 = not arg_24_2
		setActive = var_0

		var_0(var_24_1, arg_24_2)

		setActive = var_0

		var_0(var_24_2, not arg_24_2)
		arg_24_3(arg_24_2)

		return
	end

	SFX_PANEL = var_1_10011

	var_24_0(var_24_3, var_24_4, var_24_5, var_1_10011)

	setActive = var_24_0

	var_24_0(var_24_1, arg_24_2)

	setActive = var_24_0

	var_24_0(var_24_2, not arg_24_2)

	return
end

function var_0_1.UpdateRandomBtns(arg_26_0)
	local function var_26_0(arg_27_0, arg_27_1)
		return (arg_27_0 and 1 or 0) + (arg_27_1 and 2 or 0)
	end

	local var_26_1

	if not arg_26_0.slotIndex then
		var_26_1 = 1
	end

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_26_2 = var_1_10003(var_1_10005)
	local var_26_3 = var_3.getRawData(var_26_2)
	local var_26_4 = var_3.IsOpenRandomFlagShipSkinInPos(var_26_3, var_26_1)
	local var_26_5 = var_3:IsOpenRandomFlagShipInPos(var_26_1)

	var_0_2(arg_26_0, arg_26_0.randomSkinBtn, var_26_4, function(arg_28_0)
		var_26_4 = arg_28_0
		arg_26_0.randomFlagValue = var_26_0(var_26_4, var_26_5)

		return
	end)
	var_0_2(arg_26_0, arg_26_0.randomShipBtn, var_26_5, function(arg_29_0)
		var_26_5 = arg_29_0
		arg_26_0.randomFlagValue = var_26_0(var_26_4, var_26_5)

		return
	end)

	arg_26_0.randomFlagValue = var_26_0(var_26_4, var_26_5)
	setActive = var_6

	var_6(arg_26_0.randomShipBtn, var_3:CanRandomFlagShipInPos(var_26_1))

	return
end

function var_0_1.GetRandomFlagValue(arg_30_0)
	assert = var_1_10001

	var_1_10001(arg_30_0.inRandomEdit)

	if arg_30_0.randomFlagValue then
		return arg_30_0.randomFlagValue
	else
		getProxy = var_1
		PlayerProxy = var_3

		local var_30_0 = var_1(var_3)
		local var_30_1 = var_1.getRawData(var_30_0)

		return var_1.RawGetRandomShipAndSkinValueInpos(var_30_1, arg_30_0.slotIndex)
	end

	return
end

function var_0_1.ClearRandomFlagValue(arg_31_0)
	arg_31_0.randomFlagValue = nil

	return
end

function var_0_1.Disable(arg_32_0)
	var_0_1.super.Disable(arg_32_0)

	arg_32_0.inEdit = false
	arg_32_0.inRandomEdit = false

	return
end

function var_0_1.OnDispose(arg_33_0)
	if arg_33_0.displayShip then
		retPaintingPrefab = var_1_10002

		var_1_10002(arg_33_0.paintingTr, var_1:getPainting())
	end

	ClearEventTrigger = var_1_10002

	var_1_10002(arg_33_0.eventTrigger)

	ipairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_0.btns) do
		iter_33_1:Dispose()
	end

	arg_33_0.btns = nil

	arg_33_0:Disable()

	return
end

return var_0_1
