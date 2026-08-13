class = var_0_10000

local var_0_0 = "NewSkinShopMainView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseEventLogic"))

var_0_1.EVT_SHOW_OR_HIDE_PURCHASE_VIEW = "NewSkinShopMainView:EVT_SHOW_OR_HIDE_PURCHASE_VIEW"
var_0_1.EVT_ON_PURCHASE = "NewSkinShopMainView:EVT_ON_PURCHASE"

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3
local var_0_8 = 4
local var_0_9 = 5
local var_0_10 = 6
local var_0_11 = 7
local var_0_12 = 8

local function var_0_13(arg_1_0)
	if not var_0_1.obtainBtnSpriteNames then
		var_0_1.obtainBtnSpriteNames = {
			[var_0_5] = "yigoumai_butten",
			[var_0_6] = "goumai_butten",
			[var_0_7] = "qianwanghuoqu_butten",
			[var_0_8] = "item_buy",
			[var_0_9] = "furniture_shop",
			[var_0_10] = "tiyan_btn",
			[var_0_11] = "item_buy",
			[var_0_12] = "buy_with_gift"
		}
	end

	return var_0_1.obtainBtnSpriteNames[arg_1_0]
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_2_0)
	var_0_1.super.Ctor(arg_2_0, arg_2_2)

	arg_2_0.contextData = arg_2_3
	arg_2_0._go = arg_2_1.gameObject
	arg_2_0._tf = arg_2_1

	local var_2_0 = arg_2_0._tf

	arg_2_0.overlay = var_4.Find(var_2_0, "overlay")

	local var_2_1 = arg_2_0._tf

	arg_2_0.titleTr = var_4.Find(var_2_1, "overlay/title")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_4.Find(var_2_2, "overlay/title/skin_name")
	local var_2_4 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_2_0.skinNameTxt = var_2_4(var_2_3, var_6(var_1_10007))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_4.Find(var_2_5, "overlay/title/name")
	local var_2_7 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_2_0.shipNameTxt = var_2_7(var_2_6, var_6(var_1_10007))

	local var_2_8 = arg_2_0._tf

	arg_2_0.timeLimitTr = var_4.Find(var_2_8, "overlay/title/limit_time")

	local var_2_9 = arg_2_0.timeLimitTr
	local var_2_10 = var_4.Find(var_2_9, "Text")
	local var_2_11 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_2_0.timeLimitTxt = var_2_11(var_2_10, var_6(var_1_10007))

	local var_2_12 = arg_2_0._tf

	arg_2_0.changeSkinUI = var_4.Find(var_2_12, "overlay/left/change_skin")
	ChangeSkinToggle = var_4

	local var_2_13 = var_4.New

	findTF = var_2_12
	arg_2_0.changeSkinToggle = var_2_13(var_2_12(arg_2_0.changeSkinUI, "toggle_ui"))

	local var_2_14 = arg_2_0._tf

	arg_2_0.rightTr = var_4.Find(var_2_14, "overlay/right")
	UIItemList = var_4

	local var_2_15 = var_4.New
	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_5.Find(var_2_16, "overlay/right/container/tags_container/tags")
	local var_2_18 = arg_2_0._tf

	arg_2_0.uiTagList = var_2_15(var_2_17, var_6.Find(var_2_18, "overlay/right/container/tags_container/tags/tpl"))

	local var_2_19 = arg_2_0._tf

	arg_2_0.charContainer = var_4.Find(var_2_19, "overlay/right/container/char_container")

	local var_2_20 = arg_2_0._tf

	arg_2_0.charTf = var_4.Find(var_2_20, "overlay/right/container/char_container/char")

	local var_2_21 = arg_2_0._tf

	arg_2_0.furnitureContainer = var_4.Find(var_2_21, "overlay/right/fur")

	local var_2_22 = arg_2_0._tf

	arg_2_0.charBg = var_4.Find(var_2_22, "overlay/right/container/char_container/bg/char")

	local var_2_23 = arg_2_0._tf

	arg_2_0.furnitureBg = var_4.Find(var_2_23, "overlay/right/container/char_container/bg/furn")

	local var_2_24 = arg_2_0._tf

	arg_2_0.switchPreviewBtn = var_4.Find(var_2_24, "overlay/right/switch")

	local var_2_25 = arg_2_0._tf

	arg_2_0.obtainBtn = var_4.Find(var_2_25, "overlay/right/price/btn")

	local var_2_26 = arg_2_0.obtainBtn
	local var_2_27 = var_4.GetComponent

	typeof = var_6
	Image = var_2_18
	arg_2_0.obtainBtnImg = var_2_27(var_2_26, var_6(var_2_18))

	local var_2_28 = arg_2_0.obtainBtn

	arg_2_0.giftTag = var_4.Find(var_2_28, "tag")

	local var_2_29 = arg_2_0.obtainBtn

	arg_2_0.giftItem = var_4.Find(var_2_29, "item")

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_4.Find(var_2_30, "overlay/right/price/btn/Text")
	local var_2_32 = var_4.GetComponent

	typeof = var_6
	Text = var_2_18
	arg_2_0.giftText = var_2_32(var_2_31, var_6(var_2_18))

	local var_2_33 = arg_2_0._tf

	arg_2_0.consumeTr = var_4.Find(var_2_33, "overlay/right/price/consume")

	local var_2_34 = arg_2_0.consumeTr
	local var_2_35 = var_4.Find(var_2_34, "Text")
	local var_2_36 = var_4.GetComponent

	typeof = var_6
	Text = var_2_18
	arg_2_0.consumeRealPriceTxt = var_2_36(var_2_35, var_6(var_2_18))

	local var_2_37 = arg_2_0.consumeTr
	local var_2_38 = var_4.Find(var_2_37, "originalprice/Text")
	local var_2_39 = var_4.GetComponent

	typeof = var_6
	Text = var_2_18
	arg_2_0.consumePriceTxt = var_2_39(var_2_38, var_6(var_2_18))

	local var_2_40 = arg_2_0._tf

	arg_2_0.experienceTr = var_4.Find(var_2_40, "overlay/right/price/timelimt")

	local var_2_41 = arg_2_0.experienceTr
	local var_2_42 = var_4.Find(var_2_41, "consume/Text")
	local var_2_43 = var_4.GetComponent

	typeof = var_6
	Text = var_2_18
	arg_2_0.experienceTxt = var_2_43(var_2_42, var_6(var_2_18))
	setText = var_4

	local var_2_44 = arg_2_0.consumeTr
	local var_2_45 = var_5.Find(var_2_44, "originalprice/label")

	i18n = var_2_44

	var_4(var_2_45, var_2_44("skin_original_price"))

	local var_2_46 = arg_2_0._tf

	arg_2_0.dynamicToggle = var_4.Find(var_2_46, "overlay/right/toggles/l2d_preview")

	local var_2_47 = arg_2_0._tf

	arg_2_0.showBgToggle = var_4.Find(var_2_47, "overlay/right/toggles/hideObjToggle")

	local var_2_48 = arg_2_0._tf

	arg_2_0.dynamicResToggle = var_4.Find(var_2_48, "overlay/right/toggles/l2d_res_state")

	local var_2_49 = arg_2_0._tf

	arg_2_0.dynamicResDownaload = var_4.Find(var_2_49, "overlay/right/toggles/l2d_res_state/downloaded")

	local var_2_50 = arg_2_0._tf

	arg_2_0.dynamicResUnDownaload = var_4.Find(var_2_50, "overlay/right/toggles/l2d_res_state/undownload")

	local var_2_51 = arg_2_0._tf

	arg_2_0.paintingTF = var_4.Find(var_2_51, "painting/paint")
	arg_2_0.defaultPaintingPosition = arg_2_0.paintingTF.anchoredPosition
	arg_2_0.defaultPaintingScale = arg_2_0.paintingTF.localScale

	local var_2_52 = arg_2_0._tf

	arg_2_0.live2dContainer = var_4.Find(var_2_52, "painting/paint/live2d")

	local var_2_53 = arg_2_0._tf

	arg_2_0.spTF = var_4.Find(var_2_53, "painting/paint/spinePainting")

	local var_2_54 = arg_2_0._tf

	arg_2_0.spBg = var_4.Find(var_2_54, "painting/paintBg/spinePainting")

	local var_2_55 = arg_2_0._tf

	arg_2_0.bgsGo = var_4.Find(var_2_55, "bgs").gameObject

	local var_2_56 = arg_2_0._tf

	arg_2_0.diffBg = var_4.Find(var_2_56, "bgs/diffBg/bg")

	local var_2_57 = arg_2_0._tf

	arg_2_0.defaultBg = var_4.Find(var_2_57, "bgs/default")
	arg_2_0.downloads = {}
	arg_2_0.obtainBtnSprites = {}
	arg_2_0.isToggleDynamic = false
	arg_2_0.isToggleShowBg = true
	arg_2_0.isPreviewFurniture = false
	BackYardInteractionPreview = var_4

	local var_2_58 = var_4.New
	local var_2_59 = arg_2_0.furnitureContainer

	Vector3 = var_6
	arg_2_0.interactionPreview = var_2_58(var_2_59, var_6(0, 0, 0))
	SkinVoucherMsgBox = var_4

	local var_2_60 = var_4.New

	pg = var_2_59
	arg_2_0.voucherMsgBox = var_2_60(var_2_59.UIMgr.GetInstance().OverlayMain)
	NewSkinShopPurchaseView = var_4
	arg_2_0.purchaseView = var_4.New(arg_2_0._tf, arg_2_2)

	arg_2_0:RegisterEvent()

	return
end

function var_0_1.RegisterEvent(arg_3_0)
	arg_3_0:bind(var_0_1.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0

		var_2.AdjustPainting(var_4_0, arg_4_1)

		setActive = var_2

		var_2(arg_3_0.overlay, not arg_4_1)

		if arg_3_0.live2dChar then
			local var_4_1 = arg_3_0.live2dChar

			var_2.setPurchaseOffset(var_4_1, arg_4_1)
		end

		if arg_3_0.spineChar then
			local var_4_3

			if arg_4_1 then
				pg = var_2

				if var_2.ship_skin_template[arg_3_0.skinId].purchase_offset then
					local var_4_2 = #var_2

					if 3 <= var_4_2 then
						var_4_3 = arg_3_0.spineChar

						local var_4_4 = var_3.SetLocalPosition

						Vector3 = var_2_10005

						var_4_4(var_4_3, var_2_10005(var_2[1], var_2[2], var_2[3]))
					end
				end

				if var_2 then
					local var_4_5 = #var_2

					if 4 <= var_4_5 then
						var_4_3 = arg_3_0.spineChar

						local var_4_6 = var_3.SetLocalScale

						Vector3 = var_2_10005

						var_4_6(var_4_3, var_2_10005(var_2[4], var_2[4], var_2[4]))
					end
				end
			else
				local var_4_7 = arg_3_0.spineChar
				local var_4_8 = var_2.SetLocalPosition

				Vector3 = var_4_3

				var_4_8(var_4_7, var_4_3(0, 0, 0))

				local var_4_9 = arg_3_0.spineChar
				local var_4_10 = var_2.SetLocalScale

				Vector3 = var_4

				var_4_10(var_4_9, var_4(0.9, 0.9, 1))
			end
		end

		return
	end)
	arg_3_0:bind(var_0_1.EVT_ON_PURCHASE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0
		local var_5_1 = var_2.GetObtainBtnState(var_5_0, arg_5_1)
		local var_5_2 = arg_3_0

		var_3.OnClickBtn(var_5_2, var_5_1, arg_5_1)

		return
	end)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.changeSkinUI

	local function var_3_2()
		ShipSkin = var_2_10000

		if var_2_10000.IsChangeSkin(arg_3_0.skinId) then
			local var_6_0 = arg_3_0

			ShipSkin = var_1
			var_6_0.changeSkinId = var_1.GetChangeSkinNextId(arg_3_0.skinId)

			local var_6_1 = arg_3_0

			var_0.Flush(var_6_1, arg_3_0.commodity)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.Flush(arg_7_0, arg_7_1)
	if not arg_7_1 then
		arg_7_0:FlushStyle(true)

		return
	end

	arg_7_0:FlushStyle(false)

	local var_7_0

	if arg_7_0.commodity then
		var_7_0 = arg_7_0.commodity.id == arg_7_1.id
	end

	arg_7_0.skinId = arg_7_1:getSkinId()
	ShipSkin = var_3

	local var_7_1 = var_3.IsChangeSkin(arg_7_0.skinId)

	arg_7_0:FlushChangeSkin(arg_7_1)

	if not var_7_0 then
		arg_7_0:FlushName(arg_7_1)
		arg_7_0:FlushPreviewBtn(arg_7_1)
		arg_7_0:FlushTimeline(arg_7_1)
		arg_7_0:FlushTag(arg_7_1)
		arg_7_0:SwitchPreview(arg_7_1, arg_7_0.isPreviewFurniture, false)
		arg_7_0:FlushPaintingToggle(arg_7_1)
		arg_7_0:FlushBG(arg_7_1)
		arg_7_0:FlushPainting(arg_7_1)
	elseif var_7_1 then
		arg_7_0:FlushBG(arg_7_1)
		arg_7_0:FlushPainting(arg_7_1)
		arg_7_0:FlushTag(arg_7_1)
		arg_7_0:SwitchPreview(arg_7_1, arg_7_0.isPreviewFurniture, false)
	else
		arg_7_0:FlushBG(arg_7_1)
		arg_7_0:FlushPainting(arg_7_1)
	end

	arg_7_0:FlushPrice(arg_7_1)
	arg_7_0:FlushObtainBtn(arg_7_1)

	arg_7_0.commodity = arg_7_1

	return
end

function var_0_1.FlushChangeSkin(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.skinId

	ShipSkin = var_1_10003

	local var_8_1 = var_1_10003.IsChangeSkin(var_8_0)

	setActive = var_4

	var_4(arg_8_0.changeSkinUI, var_8_1 and true or false)

	if var_8_1 then
		ShipSkin = var_4

		local var_8_2 = var_4.GetChangeSkinGroupId(var_8_0)

		if not arg_8_0.changeSkinId then
			arg_8_0.changeSkinId = var_8_0
		else
			ShipSkin = var_5

			if var_5.GetChangeSkinGroupId(arg_8_0.changeSkinId) == var_8_2 then
				arg_8_0.skinId = arg_8_0.changeSkinId
			else
				arg_8_0.changeSkinId = arg_8_0.skinId
			end
		end

		local var_8_3 = arg_8_0.changeSkinToggle

		var_5.setSkinData(var_8_3, arg_8_0.skinId)

		setActive = var_5

		local var_8_4 = arg_8_0.changeSkinUI
		local var_8_5 = arg_8_0.changeSkinToggle

		var_5(var_8_4, not var_7.IsAsmrSkin(var_8_5))
	end

	return
end

function var_0_1.FlushStyle(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0.paintingTF.parent, not arg_9_1)

	setActive = var_1_10002

	var_1_10002(arg_9_0.defaultBg, arg_9_1)

	setActive = var_1_10002

	var_1_10002(arg_9_0.diffBg.parent, not arg_9_1)

	setActive = var_1_10002

	var_1_10002(arg_9_0.titleTr, not arg_9_1)

	setActive = var_1_10002

	var_1_10002(arg_9_0.rightTr, not arg_9_1)

	return
end

function var_0_1.getUIName(arg_10_0)
	return "NewSkinShopMainView"
end

function var_0_1.FlushBgWithAnim(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._tf
	local var_11_1 = var_2.GetComponent

	typeof = var_1_10004
	CanvasGroup = var_1_10005

	local var_11_2 = var_11_1(var_11_0, var_1_10004(var_1_10005))

	var_11_2.blocksRaycasts = false
	parallelAsync = var_3

	var_3({
		function(arg_12_0)
			local var_12_0 = arg_11_0
			local var_12_1 = var_1.DoSwitchBgAnim
			local var_12_2 = 1
			local var_12_3 = 0.3
			local var_12_4 = 0.8

			LeanTweenType = var_2_10006

			var_12_1(var_12_0, var_12_2, var_12_3, var_12_4, var_2_10006.linear, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_11_0

			var_1.FlushBG(var_13_0, arg_11_1, arg_13_0)

			return
		end
	}, function()
		local var_14_0 = arg_11_0
		local var_14_1 = var_0.DoSwitchBgAnim
		local var_14_2 = 1
		local var_14_3 = 1
		local var_14_4 = 0.01

		LeanTweenType = var_2_10005

		var_14_1(var_14_0, var_14_2, var_14_3, var_14_4, var_2_10005.linear, function()
			var_11_2.blocksRaycasts = true

			return
		end)

		return
	end)

	return
end

function var_0_1.DoSwitchBgAnim(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	arg_16_0:ClearSwitchBgAnim()

	GetOrAddComponent = var_6

	local var_16_0 = arg_16_0.bgsGo

	typeof = var_1_10008
	CanvasGroup = var_1_10009

	local var_16_1 = var_6(var_16_0, var_1_10008(var_1_10009))

	var_16_1.alpha = arg_16_1
	LeanTween = var_16_0

	local var_16_2 = var_16_0.value(arg_16_0.bgsGo, arg_16_1, arg_16_2, arg_16_3)
	local var_16_3 = var_7.setOnUpdate

	System = var_9

	local var_16_4 = var_16_3(var_16_2, var_9.Action_float(function(arg_17_0)
		var_16_1.alpha = arg_17_0

		return
	end))
	local var_16_5 = var_7.setEase(var_16_4, arg_16_4)
	local var_16_6 = var_7.setOnComplete

	System = var_9

	var_16_6(var_16_5, var_9.Action(arg_16_5))

	return
end

function var_0_1.ClearSwitchBgAnim(arg_18_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_18_0.bgsGo) then
		LeanTween = var_1

		var_1.cancel(arg_18_0.bgsGo)
	end

	GetOrAddComponent = var_1

	local var_18_0 = arg_18_0.bgsGo

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	var_1(var_18_0, var_1_10003(var_1_10004)).alpha = 1

	return
end

function var_0_1.FlushBG(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.skinId

	pg = var_1_10004

	local var_19_1 = var_1_10004.ship_skin_template[var_19_0]
	local var_19_2
	local var_19_3 = var_19_1.skin_type

	ShipSkin = var_1_10007

	if var_19_3 == var_1_10007.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_19_3
		var_19_3 = var_19_3.New
		NewEducateHelper = var_7
		var_19_2 = var_19_3(var_7.GetSecIdBySkinId(var_19_0))
	else
		ShipGroup = var_19_3

		local var_19_4 = var_19_3.getDefaultShipConfig(var_19_1.ship_group)

		Ship = var_7
		var_19_2 = var_7.New({
			id = 999,
			configId = var_19_4.id,
			skin_id = var_19_0
		})
	end

	local var_19_5 = var_19_2
	local var_19_6 = var_19_2.getShipBgPrint(var_19_5, true)

	pg = var_19_5

	local var_19_7 = var_19_5.ship_skin_template[var_19_0].painting

	if not arg_19_0.isToggleShowBg then
		checkABExist = var_8

		if not var_8("painting/" .. var_19_7 .. "_n") then
			if var_19_1.bg_sp ~= "" then
				var_19_6 = var_19_1.bg_sp
			end
		end

		local var_19_8 = var_19_2

		if var_19_6 ~= var_19_2.rarity2bgPrintForGet(var_19_8) then
			pg = var_19_8

			local var_19_9 = var_19_8.DynamicBgMgr.GetInstance()

			var_19_8.LoadBg(var_19_9, arg_19_0, var_19_6, arg_19_0.diffBg.parent, arg_19_0.diffBg, function(arg_20_0)
				if arg_19_2 then
					arg_19_2()
				end

				return
			end, function(arg_21_0)
				if arg_19_2 then
					arg_19_2()
				end

				return
			end)
		else
			pg = var_19_8

			local var_19_10 = var_19_8.DynamicBgMgr.GetInstance()

			var_19_8.ClearBg(var_19_10, arg_19_0:getUIName())

			if arg_19_2 then
				arg_19_2()
			end
		end

		setActive = var_19_8

		var_19_8(arg_19_0.diffBg, var_8)

		setActive = var_19_8

		var_19_8(arg_19_0.defaultBg, not var_8)

		return
	end
end

function var_0_1.FlushName(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.skinId

	pg = var_1_10003

	local var_22_1 = var_1_10003.ship_skin_template[var_22_0]
	local var_22_2 = arg_22_0.skinNameTxt

	SwitchSpecialChar = var_1_10005
	var_22_2.text = var_1_10005(var_22_1.name, true)

	local var_22_3 = var_22_1.skin_type

	ShipSkin = var_5

	if var_22_3 == var_5.SKIN_TYPE_TB then
		var_22_3 = arg_22_0.shipNameTxt
		NewEducateHelper = var_5

		local var_22_4 = var_5.GetShipNameBySecId

		NewEducateHelper = var_6
		var_22_3.text = var_22_4(var_6.GetSecIdBySkinId(var_22_0))
	else
		ShipGroup = var_22_3

		local var_22_5 = var_22_3.getDefaultShipConfig(var_22_1.ship_group)

		arg_22_0.shipNameTxt.text = var_22_5.name
	end

	return
end

function var_0_1.FlushPaintingToggle(arg_23_0, arg_23_1)
	removeOnToggle = var_1_10002

	var_1_10002(arg_23_0.dynamicToggle)

	removeOnToggle = var_1_10002

	var_1_10002(arg_23_0.showBgToggle)

	ShipSkin = var_1_10002

	local var_23_0 = var_1_10002.New({
		id = arg_23_0.skinId
	})

	checkABExist = var_3

	local var_23_1 = var_3("painting/" .. var_23_0:getConfig("painting") .. "_n")

	if arg_23_0.isToggleShowBg and not var_23_1 then
		triggerToggle = var_4

		var_4(arg_23_0.showBgToggle, false)

		arg_23_0.isToggleShowBg = false
	elseif var_23_1 then
		triggerToggle = var_4

		var_4(arg_23_0.showBgToggle, true)

		arg_23_0.isToggleShowBg = true
	end

	local var_23_2 = var_23_0
	local var_23_3

	if not var_23_0.IsSpine(var_23_2) then
		var_23_2 = var_23_0
		var_23_3 = var_23_0.IsLive2d(var_23_2)
	end

	if var_23_3 then
		PlayerPrefs = var_23_2

		local var_23_4 = var_23_2.GetInt
		local var_23_5 = "skinShop#l2dPreViewToggle"

		getProxy = var_7
		PlayerProxy = var_1_10008
		var_1_10008 = var_7(var_1_10008)

		if var_23_4(var_23_5 .. var_7.getRawData(var_1_10008).id, 0) == 1 then
			arg_23_0.isToggleDynamic = true
		end
	end

	local var_23_7

	if arg_23_0.isToggleDynamic and not var_23_3 then
		triggerToggle = var_23_7

		var_23_7(arg_23_0.dynamicToggle, false)

		arg_23_0.isToggleDynamic = false
	elseif arg_23_0.isToggleDynamic then
		local var_23_6 = arg_23_0.dynamicToggle

		var_23_7 = var_23_7.GetComponent
		typeof = var_7
		Toggle = var_1_10008

		if not var_23_7(var_23_6, var_7(var_1_10008)).isOn then
			local var_23_8 = var_23_0

			if var_23_0.IsLive2d(var_23_8) then
				Live2dConst = var_23_7

				if var_23_7.GetLive2DArm32MatchAble() then
					arg_23_0.isToggleDynamic = false
					getProxy = var_23_7
					PlayerProxy = var_23_8

					local var_23_9 = var_23_7(var_23_8)

					var_23_7 = var_23_7.getRawData(var_23_9).id
					PlayerPrefs = var_23_9

					var_23_9.SetInt("skinShop#l2dPreViewToggle" .. var_23_7, 0)

					PlayerPrefs = var_6

					var_6.Save()

					triggerToggle = var_6

					var_6(arg_23_0.dynamicToggle, false)

					goto label_23_0
				end
			end

			triggerToggle = var_23_7

			var_23_7(arg_23_0.dynamicToggle, true)

			arg_23_0.isToggleDynamic = true
		end
	end

	::label_23_0::

	if var_23_1 then
		onToggle = var_23_7

		local var_23_10 = arg_23_0
		local var_23_11 = arg_23_0.showBgToggle

		local function var_23_12(arg_24_0)
			arg_23_0.isToggleShowBg = arg_24_0

			local var_24_0 = arg_23_0

			var_1.FlushPainting(var_24_0, arg_23_1)

			local var_24_1 = arg_23_0

			var_1.FlushBG(var_24_1, arg_23_1)

			return
		end

		SFX_PANEL = var_1_10009

		var_23_7(var_23_10, var_23_11, var_23_12, var_1_10009)
	end

	if var_23_0:IsSpine() or var_23_0:IsLive2d() then
		onToggle = var_5

		local var_23_13 = arg_23_0
		local var_23_14 = arg_23_0.dynamicToggle

		local function var_23_15(arg_25_0)
			if arg_25_0 then
				Live2dConst = var_2_10001

				if var_2_10001.GetLive2DArm32MatchAble() then
					local var_25_0 = var_23_0

					if var_1.IsLive2d(var_25_0) then
						Live2dConst = var_1

						var_1.ShowLive2DArm32Tips()

						triggerToggle = var_1

						var_1(arg_23_0.dynamicToggle, false)

						return
					end
				end
			end

			local var_25_1 = arg_23_0

			var_25_1.isToggleDynamic = arg_25_0
			setActive = var_25_1

			var_25_1(arg_23_0.dynamicResToggle, arg_25_0)

			setActive = var_25_1

			var_25_1(arg_23_0.showBgToggle, not arg_25_0 and var_23_1)

			local var_25_2 = arg_23_0

			var_1.FlushPainting(var_25_2, arg_23_1)

			local var_25_3 = arg_23_0

			var_1.FlushDynamicPaintingResState(var_25_3, arg_23_1)

			local var_25_4 = arg_23_0

			var_1.RecordFlag(var_25_4, arg_25_0)

			return
		end

		SFX_PANEL = var_1_10009

		var_5(var_23_13, var_23_14, var_23_15, var_1_10009)
	end

	if arg_23_0.isToggleDynamic then
		arg_23_0:FlushDynamicPaintingResState(arg_23_1)
	end

	setActive = var_5

	var_5(arg_23_0.dynamicToggle, var_23_3)

	setActive = var_5

	var_5(arg_23_0.dynamicResToggle, arg_23_0.isToggleDynamic)

	setActive = var_5

	var_5(arg_23_0.showBgToggle, not arg_23_0.isToggleDynamic and var_23_1)

	return
end

function var_0_1.RecordFlag(arg_26_0, arg_26_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_26_0 = var_1_10002(var_1_10003)
	local var_26_1 = var_2.getRawData(var_26_0).id

	PlayerPrefs = var_26_0

	var_26_0.SetInt("skinShop#l2dPreViewToggle" .. var_26_1, arg_26_1 and 1 or 0)

	PlayerPrefs = var_3

	var_3.Save()

	local var_26_2 = arg_26_0
	local var_26_3 = arg_26_0.emit

	NewSkinShopMediator = var_5

	var_26_3(var_26_2, var_5.ON_RECORD_ANIM_PREVIEW_BTN, arg_26_1)

	return
end

function var_0_1.ExistL2dRes(arg_27_0, arg_27_1)
	local var_27_0 = "live2d/"

	string = var_1_10003

	local var_27_1 = var_27_0 .. var_1_10003.lower(arg_27_1)

	HXSet = var_3

	local var_27_2 = var_3.autoHxShiftPath(var_27_1, nil, true)

	checkABExist = var_3

	return var_3(var_27_2), var_27_2
end

function var_0_1.ExistSpineRes(arg_28_0, arg_28_1)
	local var_28_0 = "SpinePainting/"

	string = var_1_10003

	local var_28_1 = var_28_0 .. var_1_10003.lower(arg_28_1)

	HXSet = var_3

	local var_28_2 = var_3.autoHxShiftPath(var_28_1, nil, true)

	checkABExist = var_3

	return var_3(var_28_2), var_28_2
end

function var_0_1.FlushDynamicPaintingResState(arg_29_0, arg_29_1)
	if not arg_29_0.isToggleDynamic then
		return
	end

	local var_29_0 = arg_29_0:GetPaintingState(arg_29_1)
	local var_29_1 = false
	local var_29_2 = ""

	pg = var_1_10005

	local var_29_3 = var_1_10005.ship_skin_template[arg_29_0.skinId].painting
	local var_29_4

	if var_0_3 == var_29_0 then
		local var_29_5

		var_29_4, var_29_5 = arg_29_0:ExistL2dRes(var_29_3)
		var_29_2 = var_29_5
		var_29_1 = var_29_4
	elseif var_0_4 == var_29_0 then
		local var_29_6

		var_29_4, var_29_6 = arg_29_0:ExistSpineRes(var_29_3)
		var_29_2 = var_29_6
		var_29_1 = var_29_4
	end

	setActive = var_29_4

	var_29_4(arg_29_0.dynamicResDownaload, var_29_1)

	setActive = var_29_4

	var_29_4(arg_29_0.dynamicResUnDownaload, not var_29_1)

	removeOnButton = var_29_4

	var_29_4(arg_29_0.dynamicResUnDownaload)

	if not var_29_1 and var_29_2 ~= "" then
		onButton = var_29_4

		local var_29_7 = arg_29_0
		local var_29_8 = arg_29_0.dynamicResUnDownaload

		local function var_29_9()
			local var_30_0 = arg_29_0

			var_0.DownloadDynamicPainting(var_30_0, var_29_2, arg_29_1)

			return
		end

		SFX_PANEL = var_1_10010

		var_29_4(var_29_7, var_29_8, var_29_9, var_1_10010)
	end

	return
end

function var_0_1.DownloadDynamicPainting(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.skinId

	if arg_31_0.downloads[var_31_0] then
		return
	end

	SkinShopDownloadRequest = var_4

	local var_31_1 = var_4.New()

	arg_31_0.downloads[var_31_0] = var_31_1

	var_31_1:Start(arg_31_1, function(arg_32_0)
		if arg_32_0 and arg_31_0.paintingState and arg_31_0.paintingState.id == arg_31_2.id then
			local var_32_0 = arg_31_0

			var_1.FlushPainting(var_32_0, arg_31_2)

			local var_32_1 = arg_31_0

			var_1.FlushDynamicPaintingResState(var_32_1, arg_31_2)
		end

		local var_32_2 = var_31_1

		var_1.Dispose(var_32_2)

		arg_31_0.downloads[var_31_0] = nil

		return
	end)

	return
end

function var_0_1.GetPaintingState(arg_33_0, arg_33_1)
	ShipSkin = var_1_10002

	local var_33_0 = var_1_10002.New({
		id = arg_33_0.skinId
	})

	if arg_33_0.isToggleDynamic and var_33_0:IsLive2d() then
		return var_0_3
	elseif arg_33_0.isToggleDynamic and var_33_0:IsSpine() then
		if var_33_0:getConfig("spine_use_live2d") == 1 then
			return var_0_3
		end

		return var_0_4
	else
		return var_0_2
	end

	return
end

function var_0_1.FlushPainting(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.GetPaintingState(var_34_0, arg_34_1)

	pg = var_34_0

	local var_34_2 = var_34_0.ship_skin_template[arg_34_0.skinId].painting

	ShipSkin = var_4

	local var_34_3 = var_4.GetChangeSkinData(arg_34_0.skinId) and true or false

	if var_34_1 == var_0_3 and not arg_34_0:ExistL2dRes(var_34_2) or var_34_1 == var_0_4 and not arg_34_0:ExistSpineRes(var_34_2) then
		var_34_1 = var_0_2
	end

	if arg_34_0.paintingState and arg_34_0.paintingState.state == var_34_1 and arg_34_0.paintingState.id == arg_34_1.id and arg_34_0.paintingState.showBg == arg_34_0.isToggleShowBg and arg_34_0.paintingState.purchaseFlag == arg_34_1.buyCount and not var_34_3 then
		return
	end

	arg_34_0:ClearPainting()

	if var_34_1 == var_0_2 then
		arg_34_0:LoadMeshPainting(arg_34_1, arg_34_0.isToggleShowBg)
	elseif var_34_1 == var_0_3 then
		arg_34_0:LoadL2dPainting(arg_34_1)
	elseif var_34_1 == var_0_4 then
		arg_34_0:LoadSpinePainting(arg_34_1)
	end

	arg_34_0.paintingState = {
		state = var_34_1,
		id = arg_34_1.id,
		showBg = arg_34_0.isToggleShowBg,
		purchaseFlag = arg_34_1.buyCount
	}

	arg_34_0:AdjustPainting(false)

	return
end

function var_0_1.ClearPainting(arg_35_0)
	if not arg_35_0.paintingState then
		return
	end

	if var_1.state == var_0_2 then
		arg_35_0:ClearMeshPainting()
	elseif var_1.state == var_0_3 then
		arg_35_0:ClearL2dPainting()
	elseif var_1.state == var_0_4 then
		arg_35_0:ClearSpinePainting()
	end

	arg_35_0.paintingState = nil

	return
end

function var_0_1.LoadMeshPainting(arg_36_0, arg_36_1, arg_36_2)
	findTF = var_1_10003

	local var_36_0 = var_1_10003(arg_36_0.paintingTF, "fitter")

	GetOrAddComponent = var_4

	local var_36_1 = var_4(var_36_0, "PaintingScaler")

	var_36_1.FrameName = "chuanwu"
	var_36_1.Tween = 1
	pg = var_5

	local var_36_2 = var_5.ship_skin_template[arg_36_0.skinId].painting
	local var_36_3

	if not arg_36_2 then
		checkABExist = var_1_10007

		if var_1_10007("painting/" .. var_36_3 .. "_n") then
			var_36_3 = var_36_3 .. "_n"
		end
	end

	checkABExist = var_1_10007

	if not var_1_10007("painting/" .. var_36_3) then
		return
	end

	pg = var_7

	local var_36_4 = var_7.UIMgr.GetInstance()

	var_7.LoadingOn(var_36_4)

	PoolMgr = var_7

	local var_36_5 = var_7.GetInstance()

	var_7.GetPainting(var_36_5, var_36_3, true, function(arg_37_0)
		pg = var_2_10001

		local var_37_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_37_0)

		setParent = var_1

		var_1(arg_37_0, var_36_0, false)

		ShipExpressionHelper = var_1

		local var_37_1 = var_1.SetExpression
		local var_37_2 = var_36_0

		var_37_1(var_2.GetChild(var_37_2, 0), var_36_2)

		arg_36_0.paintingName = var_36_3

		if arg_36_0.paintingState and arg_36_0.paintingState.id ~= arg_36_1.id then
			local var_37_3 = arg_36_0

			var_1.ClearMeshPainting(var_37_3)
		end

		local var_37_4 = arg_37_0.transform
		local var_37_5 = var_1.Find(var_37_4, "shop_hx")
		local var_37_6 = arg_36_0

		var_2.CheckShowShopHx(var_37_6, var_37_5, arg_36_1)

		return
	end)

	return
end

function var_0_1.ClearMeshPainting(arg_38_0)
	local var_38_0 = arg_38_0.paintingTF
	local var_38_1 = var_1.Find(var_38_0, "fitter")

	if arg_38_0.paintingName and var_38_1.childCount > 0 then
		local var_38_2 = var_38_1:GetChild(0).gameObject.transform
		local var_38_3 = var_3.Find(var_38_2, "shop_hx")

		arg_38_0:RevertShopHx(var_38_3)

		PoolMgr = var_4

		local var_38_4 = var_4.GetInstance()

		var_4.ReturnPainting(var_38_4, arg_38_0.paintingName, var_2)
	end

	arg_38_0.paintingName = nil

	return
end

function var_0_1.LoadL2dPainting(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.skinId

	pg = var_1_10003

	local var_39_1 = var_1_10003.ship_skin_template[var_39_0].skin_type
	local var_39_2

	ShipSkin = var_1_10005

	local var_39_3

	if var_39_1 == var_1_10005.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_39_3
		var_39_3 = var_39_3.New
		NewEducateHelper = var_1_10006
		var_39_2 = var_39_3(var_1_10006.GetSecIdBySkinId(var_39_0))
	else
		pg = var_39_3
		var_39_3 = var_39_3.ship_skin_template[var_39_0].ship_group
		ShipGroup = var_1_10006

		local var_39_4 = var_1_10006.getDefaultShipConfig(var_39_3)

		Ship = var_1_10007
		var_39_2 = var_1_10007.New({
			noChangeSkin = true,
			configId = var_39_4.id,
			skin_id = var_39_0
		})
	end

	Live2DPainting = var_39_3

	local var_39_5 = var_39_3.GenerateData
	local var_39_6 = {
		ship = var_39_2
	}

	Vector3 = var_1_10007
	var_39_6.position = var_1_10007(0, 0, -1)
	var_39_6.parent = arg_39_0.live2dContainer
	var_39_6.offset = var_39_2:GetSkinConfig().shop_offset

	local var_39_7 = var_39_5(var_39_6)

	var_39_7.shopPreView = true
	pg = var_6

	local var_39_8 = var_6.UIMgr.GetInstance()

	var_6.LoadingOn(var_39_8)

	Live2DPainting = var_6
	arg_39_0.live2dChar = var_6.New(var_39_7, function(arg_40_0)
		arg_40_0:IgonreReactPos(true)

		local var_40_0 = arg_39_0

		var_1.CheckShowShopHxForL2d(var_40_0, arg_40_0, arg_39_1)

		if arg_39_0.paintingState and arg_39_0.paintingState.id ~= arg_39_1.id then
			local var_40_1 = arg_39_0

			var_1.ClearL2dPainting(var_40_1)
		end

		local var_40_2 = arg_40_0
		local var_40_3 = arg_40_0.setSortingLayer

		LayerWeightConst = var_3

		var_40_3(var_40_2, var_3.L2D_DEFAULT_LAYER)

		pg = var_40_3

		local var_40_4 = var_40_3.UIMgr.GetInstance()

		var_1.LoadingOff(var_40_4)

		return
	end)

	return
end

function var_0_1.ClearL2dPainting(arg_41_0)
	if arg_41_0.live2dChar then
		arg_41_0:RevertShopHxForL2d(arg_41_0.live2dChar)

		local var_41_0 = arg_41_0.live2dChar

		var_1.Dispose(var_41_0)

		arg_41_0.live2dChar = nil
	end

	return
end

function var_0_1.LoadSpinePainting(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.skinId

	pg = var_1_10003

	local var_42_1 = var_1_10003.ship_skin_template[var_42_0].skin_type
	local var_42_2

	ShipSkin = var_1_10005

	local var_42_3

	if var_42_1 == var_1_10005.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_42_3
		var_42_3 = var_42_3.New
		NewEducateHelper = var_1_10006
		var_42_2 = var_42_3(var_1_10006.GetSecIdBySkinId(var_42_0))
	else
		pg = var_42_3
		var_42_3 = var_42_3.ship_skin_template[var_42_0].ship_group
		ShipGroup = var_1_10006

		local var_42_4 = var_1_10006.getDefaultShipConfig(var_42_3)

		Ship = var_1_10007
		var_42_2 = var_1_10007.New({
			noChangeSkin = true,
			configId = var_42_4.id,
			skin_id = var_42_0
		})
	end

	SpinePainting = var_42_3

	local var_42_5 = var_42_3.GenerateData
	local var_42_6 = {
		ship = var_42_2
	}

	Vector3 = var_1_10007
	var_42_6.position = var_1_10007(0, 0, 0)
	var_42_6.parent = arg_42_0.spTF
	var_42_6.effectParent = arg_42_0.spBg
	var_42_6.offset = var_42_2:GetSkinConfig().shop_offset

	local var_42_7 = var_42_5(var_42_6)

	pg = var_42_6

	local var_42_8 = var_42_6.UIMgr.GetInstance()

	var_6.LoadingOn(var_42_8)

	SpinePainting = var_6
	arg_42_0.spinePainting = var_6.New(var_42_7, function(arg_43_0)
		if arg_42_0.paintingState and arg_42_0.paintingState.id ~= arg_42_1.id then
			local var_43_0 = arg_42_0

			var_1.ClearSpinePainting(var_43_0)
		end

		local var_43_1 = arg_43_0._tf
		local var_43_2 = var_1.Find(var_43_1, "shop_hx")
		local var_43_3 = arg_42_0

		var_2.CheckShowShopHx(var_43_3, var_43_2, arg_42_1)

		pg = var_2

		local var_43_4 = var_2.UIMgr.GetInstance()

		var_2.LoadingOff(var_43_4)
		arg_43_0:SetShopHx()

		return
	end)

	return
end

function var_0_1.ClearSpinePainting(arg_44_0)
	if arg_44_0.spinePainting and arg_44_0.spinePainting._tf then
		local var_44_0 = arg_44_0.spinePainting._tf
		local var_44_1 = var_1.Find(var_44_0, "shop_hx")

		arg_44_0:RevertShopHx(arg_44_0.shopHx)

		local var_44_2 = arg_44_0.spinePainting

		var_2.Dispose(var_44_2)

		arg_44_0.spinePainting = nil
	end

	return
end

function var_0_1.CheckShowShopHxForL2d(arg_45_0, arg_45_1, arg_45_2)
	PLATFORM_CODE = var_1_10003
	PLATFORM_CH = var_1_10004

	if var_1_10003 ~= var_1_10004 then
		return
	end

	HXSet = var_1_10003

	if not var_1_10003.isHx() then
		return
	end

	local var_45_0 = arg_45_2.buyCount <= 0 and 1 or 0

	arg_45_1:changeParamaterValue("shophx", var_45_0)

	return
end

function var_0_1.RevertShopHxForL2d(arg_46_0, arg_46_1)
	arg_46_1:changeParamaterValue("shophx", 0)

	return
end

function var_0_1.CheckShowShopHx(arg_47_0, arg_47_1, arg_47_2)
	PLATFORM_CODE = var_1_10003
	PLATFORM_CH = var_1_10004

	if var_1_10003 ~= var_1_10004 then
		return
	end

	HXSet = var_1_10003

	if not var_1_10003.isHx() then
		return
	end

	IsNil = var_3

	if not var_3(arg_47_1) and arg_47_2.buyCount <= 0 then
		setActive = var_3

		var_3(arg_47_1, true)
	end

	return
end

function var_0_1.RevertShopHx(arg_48_0, arg_48_1)
	IsNil = var_1_10002

	if not var_1_10002(arg_48_1) then
		setActive = var_2

		var_2(arg_48_1, false)
	end

	return
end

function var_0_1.FlushPreviewBtn(arg_49_0, arg_49_1)
	Goods = var_1_10002

	local var_49_0 = var_1_10002.ExistFurniture(arg_49_1.id)

	removeOnButton = var_3

	var_3(arg_49_0.switchPreviewBtn)

	if not var_49_0 and arg_49_0.isPreviewFurniture then
		arg_49_0.isPreviewFurniture = false
	end

	setActive = var_3

	var_3(arg_49_0.switchPreviewBtn, var_49_0)

	if var_49_0 then
		onButton = var_3

		local var_49_1 = arg_49_0
		local var_49_2 = arg_49_0.switchPreviewBtn

		local function var_49_3()
			local var_50_0 = arg_49_0

			if var_0.IsSwitchTweening(var_50_0) then
				return
			end

			arg_49_0.isPreviewFurniture = not arg_49_0.isPreviewFurniture

			local var_50_1 = arg_49_0

			var_0.SwitchPreview(var_50_1, arg_49_1, arg_49_0.isPreviewFurniture, true)

			local var_50_2 = arg_49_0

			var_0.FlushPrice(var_50_2, arg_49_1)

			local var_50_3 = arg_49_0

			var_0.FlushObtainBtn(var_50_3, arg_49_1)

			return
		end

		SFX_PANEL = var_1_10007

		var_3(var_49_1, var_49_2, var_49_3, var_1_10007)
	end

	return
end

function var_0_1.IsSwitchTweening(arg_51_0)
	LeanTween = var_1_10001

	local var_51_0 = var_1_10001.isTweening

	go = var_1_10002

	local var_51_1

	if not var_51_0(var_1_10002(arg_51_0.furnitureBg)) then
		LeanTween = var_51_1
		var_51_1 = var_51_1.isTweening
		go = var_2
		var_51_1 = var_51_1(var_2(arg_51_0.charBg))
	end

	return var_51_1
end

function var_0_1.ClearSwitchTween(arg_52_0)
	local var_52_0 = arg_52_0

	if arg_52_0.IsSwitchTweening(var_52_0) then
		LeanTween = var_1

		local var_52_1 = var_1.cancel

		go = var_52_0

		var_52_1(var_52_0(arg_52_0.furnitureBg))

		LeanTween = var_52_1

		local var_52_2 = var_52_1.cancel

		go = var_2

		var_52_2(var_2(arg_52_0.charBg))
	end

	return
end

function var_0_1.StartSwitchAnim(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	arg_53_0:ClearSwitchTween()

	local var_53_0 = arg_53_1
	local var_53_1 = arg_53_1.GetComponent

	typeof = var_1_10007
	CanvasGroup = var_1_10008

	local var_53_2 = var_53_1(var_53_0, var_1_10007(var_1_10008))
	local var_53_3 = arg_53_2
	local var_53_4 = arg_53_2.GetComponent

	typeof = var_1_10008
	CanvasGroup = var_1_10009

	local var_53_5 = var_53_4(var_53_3, var_1_10008(var_1_10009))
	local var_53_6 = var_53_2.alpha
	local var_53_7 = var_53_5.alpha
	local var_53_8 = arg_53_1.anchoredPosition3D
	local var_53_9 = arg_53_2.anchoredPosition3D

	LeanTween = var_1_10011

	local var_53_10 = var_1_10011.moveLocal

	go = var_1_10012

	local var_53_11 = var_53_10(var_1_10012(arg_53_1), var_53_9, arg_53_3)
	local var_53_12 = var_11.setOnComplete

	System = var_13

	var_53_12(var_53_11, var_13.Action(function()
		var_53_2.alpha = var_53_7

		return
	end))

	LeanTween = var_53_12

	local var_53_13 = var_53_12.moveLocal

	go = var_53_11

	local var_53_14 = var_53_13(var_53_11(arg_53_2), var_53_8, arg_53_3)
	local var_53_15 = var_11.setOnComplete

	System = var_13

	var_53_15(var_53_14, var_13.Action(function()
		var_53_5.alpha = var_53_6

		arg_53_4()

		return
	end))

	return
end

function var_0_1.SwitchPreview(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	local var_56_0 = arg_56_0.skinId

	pg = var_1_10005

	local var_56_1 = var_1_10005.ship_skin_template[var_56_0].skin_type

	ShipSkin = var_1_10006

	if var_56_1 == var_1_10006.SKIN_TYPE_TB then
		setActive = var_56_1

		var_56_1(arg_56_0.charContainer, false)

		return
	end

	setActive = var_56_1

	var_56_1(arg_56_0.charContainer, true)

	local var_56_2 = arg_56_0.furnitureBg
	local var_56_3 = arg_56_0.charBg

	arg_56_0:StartSwitchAnim(var_56_2, var_56_3, arg_56_3 and 0.3 or 0, function()
		setActive = var_2_10000

		var_2_10000(arg_56_0.charTf, not arg_56_2)

		setActive = var_2_10000

		var_2_10000(arg_56_0.furnitureContainer, arg_56_2)

		return
	end)

	if not arg_56_2 then
		var_56_2:SetAsFirstSibling()
		var_56_3:SetSiblingIndex(2)

		pg = var_7

		local var_56_4 = var_7.ship_skin_template[var_56_0]

		arg_56_0:FlushChar(var_56_4.prefab, var_56_4.id)
	else
		var_56_3:SetAsFirstSibling()
		var_56_2:SetSiblingIndex(2)

		Goods = var_7

		local var_56_5 = var_7.Id2FurnitureId(arg_56_1.id)

		Goods = var_8

		local var_56_6 = var_8.GetFurnitureConfig(arg_56_1.id)
		local var_56_7 = arg_56_0.interactionPreview
		local var_56_8 = var_9.Flush
		local var_56_9 = var_56_0
		local var_56_10 = var_56_5
		local var_56_11

		if not var_56_6.scale[2] then
			var_56_11 = 1
		end

		var_56_8(var_56_7, var_56_9, var_56_10, var_56_11, var_56_6.position[2])
	end

	return
end

function var_0_1.GetObtainBtnState(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1
	local var_58_1 = arg_58_1.getConfig(var_58_0, "genre")

	ShopArgs = var_58_0

	if var_58_1 == var_58_0.SkinShopTimeLimit then
		do return var_0_10 end

		goto label_58_0
	end

	local var_58_2

	if arg_58_0.isPreviewFurniture then
		getProxy = var_2
		DormProxy = var_58_2
		var_58_2 = var_2(var_58_2)
		var_58_2 = var_2.getRawData(var_58_2)

		local var_58_3 = var_2.HasFurniture

		Goods = var_4

		if var_58_3(var_58_2, var_4.Id2FurnitureId(arg_58_1.id)) then
			return var_0_5
		else
			return var_0_9
		end

		goto label_58_0
	end

	local var_58_4 = arg_58_1.type

	Goods = var_58_2

	if var_58_4 ~= var_58_2.TYPE_ACTIVITY then
		do
			local var_58_5 = arg_58_1.type

			Goods = var_3

			if var_58_5 == var_3.TYPE_ACTIVITY_EXTRA then
				return var_0_7
			elseif arg_58_1.buyCount > 0 then
				return var_0_5
			elseif arg_58_1:isDisCount() and arg_58_1:IsItemDiscountType() then
				return var_0_8
			elseif arg_58_1:CanUseVoucherType() or arg_58_1:ExistExclusiveDiscountItem() then
				return var_0_11
			elseif #arg_58_1:GetGiftList() > 0 then
				return var_0_12
			else
				return var_0_6
			end
		end

		::label_58_0::

		return
	end
end

function var_0_1.GetMode(arg_59_0)
	local var_59_0

	if not arg_59_0.contextData.mode then
		NewSkinShopScene = var_59_0
		var_59_0 = var_59_0.MODE_OVERVIEW
	end

	return var_59_0
end

function var_0_1.FlushPrice(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_1
	local var_60_1 = arg_60_1.getConfig(var_60_0, "genre")

	ShopArgs = var_60_0

	local var_60_2 = var_60_1 == var_60_0.SkinShopTimeLimit
	local var_60_3 = arg_60_1.type

	Goods = var_4

	local var_60_5

	if var_60_3 ~= var_4.TYPE_ACTIVITY then
		local var_60_4 = arg_60_1.type

		Goods = var_4

		if var_60_4 ~= var_4.TYPE_ACTIVITY_EXTRA then
			var_60_5 = false

			goto label_60_0
		end
	end

	var_60_5 = true

	::label_60_0::

	if var_60_2 then
		var_1_10005 = arg_60_0

		local var_60_6 = arg_60_0.GetMode(var_1_10005)

		NewSkinShopScene = var_1_10005

		if var_60_6 == var_1_10005.MODE_EXPERIENCE_FOR_ITEM then
			arg_60_0:UpdateExperiencePrice4Item(arg_60_1)
		else
			arg_60_0:UpdateExperiencePrice(arg_60_1)
		end
	elseif arg_60_0.isPreviewFurniture then
		var_1_10005 = arg_60_0

		arg_60_0.UpdateFurniturePrice(var_1_10005, arg_60_1)
	elseif var_60_5 then
		-- block empty
	else
		var_1_10005 = arg_60_0

		arg_60_0.UpdateCommodityPrice(var_1_10005, arg_60_1)
	end

	local var_60_7 = arg_60_1.type

	Goods = var_1_10005

	local var_60_8 = var_60_7 == var_1_10005.TYPE_SKIN

	setActive = var_5

	var_5(arg_60_0.experienceTr, var_60_2 and not var_60_5)

	setActive = var_5

	var_5(arg_60_0.consumeTr, var_60_8 and not var_60_2 and not var_60_5)

	return
end

function var_0_1.UpdateExperiencePrice4Item(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_1
	local var_61_1 = arg_61_1.getConfig(var_61_0, "resource_num")

	getProxy = var_61_0
	BagProxy = var_4

	local var_61_2 = var_61_0(var_4)
	local var_61_3 = var_3.GetSkinExperienceItems(var_61_2)

	_ = var_61_2

	local var_61_4

	if not var_61_2.detect(var_61_3, function(arg_62_0)
		return arg_62_0:CanUseForShop(arg_61_1.id)
	end) or not var_4.count then
		var_61_4 = 0
	end

	if var_61_4 < var_61_1 then
		local var_61_5 = "<color="

		COLOR_RED = var_1_10007

		local var_61_6

		if not (var_61_5 .. var_1_10007 .. ">") then
			var_61_6 = ""
		end

		local var_61_7 = var_61_6 .. var_61_4 .. (var_61_4 < var_61_1 and "</color>" or "")

		arg_61_0.experienceTxt.text = var_61_7 .. "/" .. var_61_1

		return
	end
end

function var_0_1.UpdateExperiencePrice(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_1
	local var_63_1 = arg_63_1.getConfig(var_63_0, "resource_num")

	getProxy = var_63_0
	PlayerProxy = var_4

	local var_63_2 = var_63_0(var_4)
	local var_63_3 = var_3.getRawData(var_63_2)

	if var_3.getSkinTicket(var_63_3) < var_63_1 then
		local var_63_4 = "<color="

		COLOR_RED = var_1_10005

		local var_63_5

		if not (var_63_4 .. var_1_10005 .. ">") then
			var_63_5 = ""
		end

		local var_63_6 = var_63_5 .. var_3 .. (var_3 < var_63_1 and "</color>" or "")

		arg_63_0.experienceTxt.text = var_63_6 .. "/" .. var_63_1

		return
	end
end

function var_0_1.UpdateCommodityPrice(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_1:GetPrice()
	local var_64_1 = arg_64_1:getConfig("resource_num")

	arg_64_0.consumeRealPriceTxt.text = var_64_0

	local var_64_2 = arg_64_0.consumePriceTxt

	var_64_2.text = var_64_1
	setActive = var_64_2
	tf = var_5
	go = var_1_10006

	var_64_2(var_5(var_1_10006(arg_64_0.consumePriceTxt)).parent, var_64_0 ~= var_64_1)

	return
end

function var_0_1.UpdateFurniturePrice(arg_65_0, arg_65_1)
	Goods = var_1_10002

	local var_65_0 = var_1_10002.Id2FurnitureId(arg_65_1.id)

	Furniture = var_3

	local var_65_1 = var_3.New({
		id = var_65_0
	})
	local var_65_2 = var_3.getConfig(var_65_1, "gem_price")

	arg_65_0.consumePriceTxt.text = var_65_2

	local var_65_3 = var_3
	local var_65_4 = var_3.getPrice

	PlayerConst = var_1_10007

	local var_65_5 = var_65_4(var_65_3, var_1_10007.ResDiamond)
	local var_65_6 = arg_65_0.consumeRealPriceTxt

	var_65_6.text = var_65_5
	setActive = var_65_6
	tf = var_7
	go = var_1_10008

	var_65_6(var_7(var_1_10008(arg_65_0.consumePriceTxt)).parent, var_65_2 ~= var_65_5)

	return
end

function var_0_1.FlushObtainBtn(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_0:GetObtainBtnState(arg_66_1)
	local var_66_1

	if not arg_66_0.obtainBtnSprites[var_66_0] then
		GetSpriteFromAtlas = var_4
		var_66_1 = var_4("ui/skinshopui_atlas", var_0_13(var_66_0))
		arg_66_0.obtainBtnSprites[var_66_0] = var_66_1
	end

	arg_66_0.obtainBtnImg.sprite = var_66_1

	local var_66_2 = arg_66_0.obtainBtnImg

	var_4.SetNativeSize(var_66_2)

	setActive = var_4

	var_4(arg_66_0.giftTag, var_66_0 == var_0_12)

	setActive = var_4

	var_4(arg_66_0.giftItem, var_66_0 == var_0_12)

	local var_66_3

	if var_66_0 == var_0_12 then
		arg_66_0:FlushGift(arg_66_1)
	else
		var_66_3 = arg_66_0.giftText
		var_66_3.text = ""
	end

	onButton = var_66_3

	local var_66_4 = arg_66_0
	local var_66_5 = arg_66_0.obtainBtn

	local function var_66_6()
		local var_67_0 = {}

		SkinCouponActivity = var_2_10001

		local var_67_1 = var_2_10001.StaticEncoreActTip(arg_66_1.id)

		tobool = var_2

		if var_2(var_67_1) then
			table = var_2

			var_2.insert(var_67_0, function(arg_68_0)
				pg = var_3_10001

				local var_68_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_68_1 = var_1.ShowMsgBox
				local var_68_2 = {}

				i18n = var_3_10004
				var_68_2.content = var_3_10004("SkinDiscount_Hint")

				function var_68_2.onYes()
					if var_67_1 then
						local var_69_0 = var_67_1

						if not var_0.isEnd(var_69_0) then
							local var_69_1 = arg_66_0
							local var_69_2 = var_0.emit

							NewSkinShopMediator = var_4_10002

							var_69_2(var_69_1, var_4_10002.OPEN_ACTIVITY, var_67_1.id)
						end
					end

					return
				end

				function var_68_2.onNo()
					arg_68_0()

					return
				end

				var_68_1(var_68_0, var_68_2)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_67_0, function()
			if var_66_0 == var_0_6 or var_66_0 == var_0_8 or var_66_0 == var_0_12 then
				local var_71_0 = arg_66_0.purchaseView

				var_0.ExecuteAction(var_71_0, "Show", arg_66_1)
			else
				local var_71_1 = arg_66_0

				var_0.OnClickBtn(var_71_1, var_66_0, arg_66_1)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10008

	var_66_3(var_66_4, var_66_5, var_66_6, var_1_10008)

	return
end

function var_0_1.OnClickBtn(arg_72_0, arg_72_1, arg_72_2)
	if arg_72_1 == var_0_6 or arg_72_1 == var_0_8 or arg_72_1 == var_0_12 then
		arg_72_0:OnPurchase(arg_72_2)
	elseif arg_72_1 == var_0_11 then
		arg_72_0:OnItemPurchase(arg_72_2)
	elseif arg_72_1 == var_0_7 then
		arg_72_0:OnActivity(arg_72_2)
	elseif arg_72_1 == var_0_9 then
		arg_72_0:OnBackyard(arg_72_2)
	elseif arg_72_1 == var_0_10 then
		local var_72_0 = arg_72_0
		local var_72_1 = arg_72_0.GetMode(var_72_0)

		NewSkinShopScene = var_72_0

		if var_72_1 == var_72_0.MODE_EXPERIENCE_FOR_ITEM then
			arg_72_0:OnExperience4Item(arg_72_2)
		else
			arg_72_0:OnExperience(arg_72_2)
		end
	end

	return
end

function var_0_1.FlushGift(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_1:GetGiftList()[1]

	updateDrop = var_1_10004

	var_1_10004(arg_73_0.giftItem, {
		type = var_73_0.type,
		id = var_73_0.id,
		count = var_73_0.count
	})

	local var_73_1

	if not (#var_2 > 1) or not ("+" .. #var_2 - 1 .. "...") then
		var_73_1 = ""
	end

	arg_73_0.giftText.text = var_73_1

	return
end

function var_0_1.OnItemPurchase(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_1.type

	Goods = var_1_10003

	if var_74_0 ~= var_1_10003.TYPE_SKIN then
		return
	end

	local var_74_1 = arg_74_1
	local var_74_2 = arg_74_1.GetVoucherIdList(var_74_1)

	getProxy = var_74_1
	BagProxy = var_1_10004

	local var_74_3 = var_74_1(var_1_10004)
	local var_74_4 = var_3.GetExclusiveDiscountItem4Shop(var_74_3, arg_74_1.id)

	if #var_74_2 <= 0 and #var_74_4 <= 0 then
		return
	end

	local var_74_5 = {}

	ipairs = var_5

	for iter_74_0, iter_74_1 in var_5(var_74_2) do
		table = var_1_10010

		var_1_10010.insert(var_74_5, iter_74_1)
	end

	ipairs = var_5

	for iter_74_2, iter_74_3 in var_5(var_74_4) do
		table = var_1_10010

		var_1_10010.insert(var_74_5, iter_74_3.id)
	end

	local var_74_6 = arg_74_0.skinId

	pg = var_6

	local var_74_7 = var_6.ship_skin_template[var_74_6]

	SwitchSpecialChar = var_7

	local var_74_8 = var_7(var_74_7.name, true)
	local var_74_9 = arg_74_0.voucherMsgBox

	var_8.ExecuteAction(var_74_9, "Show", {
		itemList = var_74_5,
		skinId = var_74_6,
		skinName = var_74_8,
		price = arg_74_1:GetPrice(),
		onYes = function(arg_75_0)
			if arg_75_0 then
				local var_75_0 = arg_74_0
				local var_75_1 = var_1.emit

				NewSkinShopMediator = var_2_10003

				var_75_1(var_75_0, var_2_10003.ON_ITEM_PURCHASE, arg_75_0, arg_74_1.id)
			else
				local var_75_2 = arg_74_0
				local var_75_3 = var_1.emit

				NewSkinShopMediator = var_2_10003

				var_75_3(var_75_2, var_2_10003.ON_SHOPPING, arg_74_1.id, 1)
			end

			return
		end
	})

	return
end

function var_0_1.OnPurchase(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_1.type

	Goods = var_1_10003

	if var_76_0 ~= var_1_10003.TYPE_SKIN then
		return
	end

	if arg_76_1:isDisCount() and arg_76_1:IsItemDiscountType() then
		local var_76_1 = arg_76_0
		local var_76_2 = arg_76_0.emit

		NewSkinShopMediator = var_1_10004

		var_76_2(var_76_1, var_1_10004.ON_SHOPPING_BY_ACT, arg_76_1.id, 1)
	else
		local var_76_3 = arg_76_0
		local var_76_4 = arg_76_0.emit

		NewSkinShopMediator = var_1_10004

		var_76_4(var_76_3, var_1_10004.ON_SHOPPING, arg_76_1.id, 1)
	end

	return
end

function var_0_1.OnActivity(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_1:getConfig("time")
	local var_77_1 = arg_77_1
	local var_77_2 = arg_77_1.getConfig(var_77_1, "activity")

	getProxy = var_77_1
	ActivityProxy = var_5

	local var_77_3 = var_77_1(var_5)
	local var_77_4 = var_4.getActivityById(var_77_3, var_77_2)

	if var_77_2 == 0 then
		pg = var_77_3

		local var_77_5 = var_77_3.TimeMgr.GetInstance()

		if not var_77_3.inTime(var_77_5, var_77_0) then
			if var_77_4 then
				var_77_5 = var_77_4

				if not var_77_4.isEnd(var_77_5) then
					var_77_3 = arg_77_1.type
					Goods = var_77_5

					local var_77_6

					if var_77_3 == var_77_5.TYPE_ACTIVITY then
						var_77_6 = arg_77_0
						var_77_3 = arg_77_0.emit
						NewSkinShopMediator = var_1_10007

						var_77_3(var_77_6, var_1_10007.GO_SHOPS_LAYER, arg_77_1:getConfig("activity"))
					else
						var_77_3 = arg_77_1.type
						Goods = var_77_6

						if var_77_3 == var_77_6.TYPE_ACTIVITY_EXTRA then
							if arg_77_1:getConfig("scene") then
								local var_77_7 = #var_77_3

								if 0 < var_77_7 then
									var_1_10007 = arg_77_0

									local var_77_8 = arg_77_0.emit

									NewSkinShopMediator = var_1_10008

									var_77_8(var_1_10007, var_1_10008.OPEN_SCENE, var_77_3)

									goto label_77_0
								end
							end

							var_1_10007 = arg_77_0

							local var_77_9 = arg_77_0.emit

							NewSkinShopMediator = var_1_10008

							var_77_9(var_1_10007, var_1_10008.OPEN_ACTIVITY, var_77_2)
						end
					end

					goto label_77_0
				end
			end

			pg = var_77_3

			do
				local var_77_10 = var_77_3.TipsMgr.GetInstance()
				local var_77_11 = var_5.ShowTips

				i18n = var_1_10007

				var_77_11(var_77_10, var_1_10007("common_activity_not_start"))
			end

			::label_77_0::

			return
		end
	end
end

function var_0_1.OnBackyard(arg_78_0, arg_78_1)
	pg = var_1_10002

	local var_78_0 = var_1_10002.SystemOpenMgr.GetInstance()
	local var_78_1 = var_2.isOpenSystem

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_78_2 = var_1_10004(var_1_10005)
	local var_78_4

	if not var_78_1(var_78_0, var_4.getRawData(var_78_2).level, "BackYardMediator") then
		pg = var_2

		local var_78_3 = var_2.open_systems_limited[1]

		pg = var_78_0
		var_78_4 = var_78_0.TipsMgr.GetInstance()

		local var_78_5 = var_3.ShowTips

		i18n = var_5

		var_78_5(var_78_4, var_5("no_open_system_tip", var_78_3.name, var_78_3.level))

		return
	end

	local var_78_6 = arg_78_0
	local var_78_7 = arg_78_0.emit

	NewSkinShopMediator = var_78_4

	var_78_7(var_78_6, var_78_4.ON_BACKYARD_SHOP)

	return
end

function var_0_1.OnExperience(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0.skinId

	getProxy = var_1_10003
	ShipSkinProxy = var_1_10004

	local var_79_1 = var_1_10003(var_1_10004)

	if var_3.getSkinById(var_79_1, var_79_0) and not var_3:isExpireType() then
		pg = var_4

		local var_79_2 = var_4.TipsMgr.GetInstance()
		local var_79_3 = var_4.ShowTips

		i18n = var_1_10006

		var_79_3(var_79_2, var_1_10006("already_have_the_skin"))

		return
	end

	local var_79_4 = arg_79_1:getConfig("resource_num")
	local var_79_5 = arg_79_1
	local var_79_6 = arg_79_1.getConfig(var_79_5, "time_second") * var_79_4

	pg = var_79_5

	local var_79_7 = var_79_5.TimeMgr.GetInstance()
	local var_79_8, var_79_9, var_79_10, var_79_11 = var_6.parseTimeFrom(var_79_7, var_79_6)

	pg = var_1_10010

	local var_79_12 = var_1_10010.ship_skin_template[arg_79_0.skinId].name

	pg = var_11

	local var_79_13 = var_11.MsgboxMgr.GetInstance()
	local var_79_14 = var_11.ShowMsgBox
	local var_79_15 = {}

	i18n = var_1_10014
	var_79_15.content = var_1_10014("exchange_limit_skin_tip", var_79_4, var_79_12, var_79_8, var_79_9)

	function var_79_15.onYes()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_80_0 = var_2_10000(var_2_10001)
		local var_80_1 = var_0.getRawData(var_80_0)

		if var_0.getSkinTicket(var_80_1) < var_79_4 then
			pg = var_0

			local var_80_2 = var_0.TipsMgr.GetInstance()
			local var_80_3 = var_0.ShowTips

			i18n = var_2_10002

			var_80_3(var_80_2, var_2_10002("common_no_item_1"))

			return
		end

		local var_80_4 = arg_79_0
		local var_80_5 = var_0.emit

		NewSkinShopMediator = var_2_10002

		var_80_5(var_80_4, var_2_10002.ON_SHOPPING, arg_79_1.id, 1)

		return
	end

	var_79_14(var_79_13, var_79_15)

	return
end

function var_0_1.OnExperience4Item(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0.skinId

	getProxy = var_1_10003
	ShipSkinProxy = var_1_10004

	local var_81_1 = var_1_10003(var_1_10004)

	if var_3.getSkinById(var_81_1, var_81_0) and not var_3:isExpireType() then
		pg = var_4

		local var_81_2 = var_4.TipsMgr.GetInstance()
		local var_81_3 = var_4.ShowTips

		i18n = var_1_10006

		var_81_3(var_81_2, var_1_10006("already_have_the_skin"))

		return
	end

	local var_81_4 = arg_81_1:getConfig("resource_num")
	local var_81_5 = arg_81_1
	local var_81_6 = arg_81_1.getConfig(var_81_5, "time_second") * var_81_4

	pg = var_81_5

	local var_81_7 = var_81_5.TimeMgr.GetInstance()
	local var_81_8, var_81_9, var_81_10, var_81_11 = var_6.parseTimeFrom(var_81_7, var_81_6)

	pg = var_1_10010

	local var_81_12 = var_1_10010.ship_skin_template[arg_81_0.skinId].name

	getProxy = var_11
	BagProxy = var_1_10012

	local var_81_13 = var_11(var_1_10012)
	local var_81_14 = var_11.GetSkinExperienceItems(var_81_13)

	_ = var_81_13

	local var_81_15 = var_81_13.detect(var_81_14, function(arg_82_0)
		return arg_82_0:CanUseForShop(arg_81_1.id)
	end)

	pg = var_13

	local var_81_16 = var_13.MsgboxMgr.GetInstance()
	local var_81_17 = var_13.ShowMsgBox
	local var_81_18 = {}

	i18n = var_1_10016
	var_81_18.content = var_1_10016("exchange_limit_skin_tip", var_81_4, var_81_12, var_81_8, var_81_9)

	function var_81_18.onYes()
		if not var_81_15 or var_81_15.count < var_81_4 then
			pg = var_0

			local var_83_0 = var_0.TipsMgr.GetInstance()
			local var_83_1 = var_0.ShowTips

			i18n = var_2_10002

			var_83_1(var_83_0, var_2_10002("common_no_item_1"))

			return
		end

		local var_83_2 = arg_81_0
		local var_83_3 = var_0.emit

		NewSkinShopMediator = var_2_10002

		var_83_3(var_83_2, var_2_10002.ON_ITEM_EXPERIENCE, var_81_15.id, arg_81_1.id, 1)

		return
	end

	var_81_17(var_81_16, var_81_18)

	return
end

function var_0_1.FlushTag(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_0.skinId

	pg = var_1_10003

	local var_84_1 = var_1_10003.ship_skin_template[var_84_0].tag
	local var_84_2 = arg_84_0.uiTagList

	var_5.make(var_84_2, function(arg_85_0, arg_85_1, arg_85_2)
		UIItemList = var_2_10003

		if arg_85_0 == var_2_10003.EventUpdate then
			LoadSpriteAtlasAsync = var_3

			local var_85_0 = "SkinIcon"
			local var_85_1 = "type_"

			ShipSkin = var_2_10006

			var_3(var_85_0, var_85_1 .. var_2_10006.Tag2Name(var_84_1[arg_85_1 + 1]), function(arg_86_0)
				if arg_84_0.exited then
					return
				end

				local var_86_0 = arg_85_2
				local var_86_1 = var_1.Find(var_86_0, "icon")
				local var_86_2 = var_1.GetComponent

				typeof = var_3
				Image = var_3_10004

				local var_86_3 = var_86_2(var_86_1, var_3(var_3_10004))

				var_86_3.sprite = arg_86_0

				var_86_3:SetNativeSize()

				return
			end)
		end

		return
	end)

	local var_84_3 = arg_84_0.uiTagList

	var_5.align(var_84_3, #var_84_1)

	return
end

function var_0_1.FlushChar(arg_87_0, arg_87_1, arg_87_2)
	if arg_87_0.prefabName and arg_87_0.prefabName == arg_87_1 then
		return
	end

	arg_87_0:ReturnChar()

	SpineAnimChar = var_3
	arg_87_0.spineChar = var_3.New()

	local var_87_0 = arg_87_0.spineChar

	var_3.SetPaint(var_87_0, arg_87_1)

	local var_87_1 = arg_87_0.spineChar

	var_3.Load(var_87_1, true, function(arg_88_0)
		local var_88_0 = arg_87_0

		var_88_0.prefabName = arg_87_1
		pg = var_88_0

		if var_88_0.skinshop_spine_scale[arg_87_2] then
			local var_88_1 = arg_87_0.spineChar
			local var_88_2 = var_2.SetLocalScale

			Vector3 = var_2_10004

			var_88_2(var_88_1, var_2_10004(var_1.skinshop_scale, var_1.skinshop_scale, 1))
		else
			local var_88_3 = arg_87_0.spineChar
			local var_88_4 = var_2.SetLocalScale

			Vector3 = var_2_10004

			var_88_4(var_88_3, var_2_10004(0.9, 0.9, 1))
		end

		local var_88_5 = arg_87_0.spineChar
		local var_88_6 = var_2.SetLocalPosition

		Vector3 = var_2_10004

		var_88_6(var_88_5, var_2_10004(0, 0, 0))

		local var_88_7 = arg_87_0.spineChar
		local var_88_8 = var_2.SetLayer

		Layer = var_4

		var_88_8(var_88_7, var_4.UI)

		local var_88_9 = arg_87_0.spineChar

		var_2.SetParent(var_88_9, arg_87_0.charTf)

		local var_88_10 = arg_87_0.spineChar

		var_2.SetAction(var_88_10, "normal", 0)

		return
	end)

	return
end

function var_0_1.FlushTimeline(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_0.skinId
	local var_89_1 = false
	local var_89_2
	local var_89_3

	if arg_89_1:IsActivityExtra() and arg_89_1:ShowMaintenanceTime() then
		local var_89_4

		var_89_3, var_89_4 = arg_89_1:GetMaintenanceMonthAndDay()

		function var_89_2()
			i18n = var_2_10000

			return var_2_10000("limit_skin_time_before_maintenance", var_89_3, var_89_4)
		end

		var_89_1 = true
	else
		local var_89_5 = arg_89_1

		var_89_3 = arg_89_1.getConfig(var_89_5, "genre")
		ShopArgs = var_89_5

		if var_89_3 == var_89_5.SkinShopTimeLimit then
			getProxy = var_89_3
			ShipSkinProxy = var_6

			local var_89_6 = var_89_3(var_6)

			var_89_1 = var_89_3.getSkinById(var_89_6, var_89_0) and var_89_3:isExpireType() and not var_89_3:isExpired()

			if var_89_1 then
				function var_89_2()
					skinTimeStamp = var_2_10000

					local var_91_0 = var_89_3

					return var_2_10000(var_1.getRemainTime(var_91_0))
				end
			end
		else
			pg = var_89_3

			local var_89_7 = var_89_3.TimeMgr.GetInstance()
			local var_89_8

			var_89_3, var_89_8 = var_89_3.inTime(var_89_7, arg_89_1:getConfig("time"))

			if var_89_8 then
				pg = var_7

				local var_89_9 = var_7.TimeMgr.GetInstance()
				local var_89_10 = var_7.Table2ServerTime(var_89_9, var_89_8)

				function var_89_2()
					skinCommdityTimeStamp = var_2_10000

					return var_2_10000(var_89_10)
				end
			end
		end
	end

	setActive = var_89_3

	var_89_3(arg_89_0.timeLimitTr, var_89_1)
	arg_89_0:ClearTimer()

	if var_89_1 then
		arg_89_0:AddTimer(var_89_2)
	end

	return
end

function var_0_1.AddTimer(arg_93_0, arg_93_1)
	Timer = var_1_10002
	arg_93_0.timer = var_1_10002.New(function()
		arg_93_0.timeLimitTxt.text = arg_93_1()

		return
	end, 1, -1)

	arg_93_0.timer.func()

	local var_93_0 = arg_93_0.timer

	var_2.Start(var_93_0)

	return
end

function var_0_1.ClearTimer(arg_95_0)
	if arg_95_0.timer then
		local var_95_0 = arg_95_0.timer

		var_1.Stop(var_95_0)

		arg_95_0.timer = nil
	end

	return
end

function var_0_1.ReturnChar(arg_96_0)
	if arg_96_0.spineChar then
		local var_96_0 = arg_96_0.spineChar

		var_1.Dispose(var_96_0)

		arg_96_0.spineChar = nil
		arg_96_0.prefabName = nil
	end

	return
end

function var_0_1.ClosePurchaseView(arg_97_0)
	if arg_97_0.purchaseView then
		local var_97_0 = arg_97_0.purchaseView

		if var_1.GetLoaded(var_97_0) then
			local var_97_1 = arg_97_0.purchaseView

			var_1.Hide(var_97_1)
		end
	end

	return
end

function var_0_1.AdjustPainting(arg_98_0, arg_98_1)
	local var_98_0 = arg_98_0.paintingTF

	pg = var_1_10003

	local var_98_1

	if var_1_10003.ship_skin_newmainui_shift[arg_98_0.skinId] then
		var_98_1 = var_3.skin_shop_shift

		if arg_98_1 then
			Vector2 = var_1_10005
			var_98_0.anchoredPosition = var_1_10005(var_98_1[1] - 440, var_98_1[2] + arg_98_0.defaultPaintingPosition.y)
		else
			Vector2 = var_1_10005
			var_98_0.anchoredPosition = var_1_10005(var_98_1[1] + arg_98_0.defaultPaintingPosition.x, var_98_1[2] + arg_98_0.defaultPaintingPosition.y)
		end

		local var_98_2 = var_98_1[4]

		Vector3 = var_1_10006
		var_98_0.localScale = var_1_10006(var_98_2, var_98_2, 1)
	else
		Vector2 = var_98_1
		var_98_0.anchoredPosition = var_98_1(arg_98_0.defaultPaintingPosition.x, arg_98_0.defaultPaintingPosition.y)
		var_98_0.localScale = arg_98_0.defaultPaintingScale
	end

	return
end

function var_0_1.Dispose(arg_99_0)
	arg_99_0.exited = true
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_99_0)
	arg_99_0:ClearSwitchBgAnim()

	pg = var_1

	local var_99_0 = var_1.DynamicBgMgr.GetInstance()

	var_1.ClearBg(var_99_0, arg_99_0:getUIName())

	if arg_99_0.live2dChar then
		local var_99_1 = arg_99_0.live2dChar

		var_1.Dispose(var_99_1)

		arg_99_0.live2dChar = nil
	end

	if arg_99_0.voucherMsgBox then
		local var_99_2 = arg_99_0.voucherMsgBox

		var_1.Destroy(var_99_2)

		arg_99_0.voucherMsgBox = nil
	end

	if arg_99_0.purchaseView then
		local var_99_3 = arg_99_0.purchaseView

		var_1.Destroy(var_99_3)

		arg_99_0.purchaseView = nil
	end

	pairs = var_1

	for iter_99_0, iter_99_1 in var_1(arg_99_0.downloads) do
		iter_99_1:Dispose()
	end

	arg_99_0.downloads = {}

	arg_99_0:ClearPainting()

	pairs = var_1

	for iter_99_2, iter_99_3 in var_1(arg_99_0.obtainBtnSprites) do
		arg_99_0.obtainBtnSprites[iter_99_3] = nil
	end

	arg_99_0.obtainBtnSprites = nil

	if arg_99_0.interactionPreview then
		local var_99_4 = arg_99_0.interactionPreview

		var_1.Dispose(var_99_4)

		arg_99_0.interactionPreview = nil
	end

	arg_99_0:ClearSwitchTween()
	arg_99_0:disposeEvent()
	arg_99_0:ClearTimer()
	arg_99_0:ReturnChar()

	return
end

return var_0_1
