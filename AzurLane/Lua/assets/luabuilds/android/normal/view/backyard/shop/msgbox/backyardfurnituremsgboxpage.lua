class = var_0_10000

local var_0_0 = "BackYardFurnitureMsgBoxPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FurnitureMsgboxPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/name")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/theme/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.themeTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/desc")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf

	arg_2_0.iconContainer = var_1.Find(var_2_9, "frame/icon")

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/icon/Image")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.icon = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0._tf

	arg_2_0.playBtn = var_1.Find(var_2_13, "frame/icon/play")

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "frame/icon/rawImage")
	local var_2_16 = var_1.GetComponent

	typeof = var_3
	RawImage = var_1_10004
	arg_2_0.rawIcon = var_2_16(var_2_15, var_3(var_1_10004))

	local var_2_17 = arg_2_0._tf

	arg_2_0.shipTr = var_1.Find(var_2_17, "frame/ship")

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_1.Find(var_2_18, "frame/ship/icon")
	local var_2_20 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.shipIcon = var_2_20(var_2_19, var_3(var_1_10004))

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_1.Find(var_2_21, "frame/ship/Text")
	local var_2_23 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.shipTxt = var_2_23(var_2_22, var_3(var_1_10004))

	local var_2_24 = arg_2_0._tf

	arg_2_0.countPanel = var_1.Find(var_2_24, "frame/count")

	local var_2_25 = arg_2_0._tf

	arg_2_0.leftArr = var_1.Find(var_2_25, "frame/count/left_arr")

	local var_2_26 = arg_2_0._tf

	arg_2_0.rightArr = var_1.Find(var_2_26, "frame/count/right_arr")

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_1.Find(var_2_27, "frame/count/Text")
	local var_2_29 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.countTxt = var_2_29(var_2_28, var_3(var_1_10004))

	local var_2_30 = arg_2_0._tf

	arg_2_0.gemIcon = var_1.Find(var_2_30, "frame/price/gem")

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_1.Find(var_2_31, "frame/price/gem_text")
	local var_2_33 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.gemCount = var_2_33(var_2_32, var_3(var_1_10004))

	local var_2_34 = arg_2_0._tf

	arg_2_0.goldIcon = var_1.Find(var_2_34, "frame/price/gold")

	local var_2_35 = arg_2_0._tf
	local var_2_36 = var_1.Find(var_2_35, "frame/price/gold_text")
	local var_2_37 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.goldCount = var_2_37(var_2_36, var_3(var_1_10004))

	local var_2_38 = arg_2_0._tf

	arg_2_0.line = var_1.Find(var_2_38, "frame/price/line")

	local var_2_39 = arg_2_0._tf
	local var_2_40 = var_1.Find(var_2_39, "frame/energy")
	local var_2_41 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.energyIcon = var_2_41(var_2_40, var_3(var_1_10004))

	local var_2_42 = arg_2_0._tf
	local var_2_43 = var_1.Find(var_2_42, "frame/energy/Text")
	local var_2_44 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.energyTxt = var_2_44(var_2_43, var_3(var_1_10004))

	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_1.Find(var_2_45, "frame/energy/Text/addition")
	local var_2_47 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.energyAddition = var_2_47(var_2_46, var_3(var_1_10004))

	local var_2_48 = arg_2_0._tf
	local var_2_49 = var_1.Find(var_2_48, "frame/energy/Text/addition/Text")
	local var_2_50 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.energyAdditionTxt = var_2_50(var_2_49, var_3(var_1_10004))

	local var_2_51 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_51, "frame/close_btn")

	local var_2_52 = arg_2_0._tf

	arg_2_0.btns = var_1.Find(var_2_52, "frame/btns")

	local var_2_53 = arg_2_0._tf

	arg_2_0.goldPurchaseBtn = var_1.Find(var_2_53, "frame/btns/gold_purchase_btn")

	local var_2_54 = arg_2_0._tf

	arg_2_0.gemPurchaseBtn = var_1.Find(var_2_54, "frame/btns/gem_purchase_btn")

	local var_2_55 = arg_2_0._tf

	arg_2_0.goldPurchaseIcon = var_1.Find(var_2_55, "frame/btns/gold_purchase_btn/content/icon")

	local var_2_56 = arg_2_0._tf

	arg_2_0.gemPurchaseIcon = var_1.Find(var_2_56, "frame/btns/gem_purchase_btn/content/icon")

	local var_2_57 = arg_2_0._tf
	local var_2_58 = var_1.Find(var_2_57, "frame/max_cnt")
	local var_2_59 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.maxCnt = var_2_59(var_2_58, var_3(var_1_10004))

	local var_2_60 = arg_2_0._tf

	arg_2_0.maxBtn = var_1.Find(var_2_60, "frame/count/max")

	local var_2_61 = arg_2_0.maxBtn
	local var_2_62 = var_1.Find(var_2_61, "Text")
	local var_2_63 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.maxBtnTxt = var_2_63(var_2_62, var_3(var_1_10004))
	setText = var_1

	local var_2_64 = arg_2_0._tf
	local var_2_65 = var_2.Find(var_2_64, "frame/price/label")

	i18n = var_2_64

	var_1(var_2_65, var_2_64("backyard_theme_total_print"))

	setActive = var_1

	var_1(arg_2_0.rawIcon, false)

	return
end

function var_0_1.OnInit(arg_3_0)
	local function var_3_0()
		local var_4_0 = {}

		for iter_4_0 = 1, arg_3_0.count do
			table = var_2_10005

			var_2_10005.insert(var_4_0, arg_3_0.furniture.id)
		end

		return var_4_0
	end

	onButton = var_1_10002

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.goldPurchaseBtn

	local function var_3_3()
		local var_5_0 = var_3_0()
		local var_5_1 = arg_3_0
		local var_5_2 = var_1.emit

		NewBackYardShopMediator = var_2_10003

		local var_5_3 = var_2_10003.ON_SHOPPING
		local var_5_4 = var_5_0

		PlayerConst = var_2_10005

		var_5_2(var_5_1, var_5_3, var_5_4, var_2_10005.ResDormMoney)

		local var_5_5 = arg_3_0

		var_1.Hide(var_5_5)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_1, var_3_2, var_3_3, var_1_10006)

	onButton = var_1_10002

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.gemPurchaseBtn

	local function var_3_6()
		local var_6_0 = var_3_0()
		local var_6_1 = arg_3_0
		local var_6_2 = var_1.emit

		NewBackYardShopMediator = var_2_10003

		local var_6_3 = var_2_10003.ON_SHOPPING
		local var_6_4 = var_6_0

		PlayerConst = var_2_10005

		var_6_2(var_6_1, var_6_3, var_6_4, var_2_10005.ResDiamond)

		local var_6_5 = arg_3_0

		var_1.Hide(var_6_5)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_4, var_3_5, var_3_6, var_1_10006)

	onButton = var_1_10002

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.closeBtn

	local function var_3_9()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_7, var_3_8, var_3_9, var_1_10006)

	onButton = var_1_10002

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0._tf

	local function var_3_12()
		local var_8_0 = arg_3_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_10, var_3_11, var_3_12, var_1_10006)

	onButton = var_1_10002

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.leftArr

	local function var_3_15()
		if arg_3_0.count <= 1 then
			return
		end

		arg_3_0.count = arg_3_0.count - 1

		local var_9_0 = arg_3_0

		var_0.UpdatePrice(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_13, var_3_14, var_3_15, var_1_10006)

	onButton = var_1_10002

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.rightArr

	local function var_3_18()
		if arg_3_0.count == arg_3_0.maxCount then
			return
		end

		arg_3_0.count = arg_3_0.count + 1

		local var_10_0 = arg_3_0

		var_0.UpdatePrice(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_16, var_3_17, var_3_18, var_1_10006)

	onButton = var_1_10002

	local var_3_19 = arg_3_0
	local var_3_20 = arg_3_0.maxBtn

	local function var_3_21()
		arg_3_0.count = arg_3_0.maxCount

		local var_11_0 = arg_3_0

		var_0.UpdatePrice(var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_19, var_3_20, var_3_21, var_1_10006)

	return
end

function var_0_1.PlayerUpdated(arg_12_0, arg_12_1)
	arg_12_0.player = arg_12_1

	return
end

function var_0_1.SetUp(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.dorm = arg_13_2
	arg_13_0.furniture = arg_13_1
	arg_13_0.count = 1
	arg_13_0.player = arg_13_3
	arg_13_0.maxCount = arg_13_1:getConfig("count") - arg_13_1.count

	local var_13_0 = arg_13_0.maxCount
	local var_13_1 = 1 < var_13_0

	setActive = var_5

	var_5(arg_13_0.maxBtn, var_13_1)

	setAnchoredPosition = var_5

	var_5(arg_13_0.countPanel, {
		x = var_13_1 and 200 or 258
	})

	arg_13_0.maxBtnTxt.text = "MAX"

	arg_13_0:UpdateMainInfo()
	arg_13_0:UpdateSkinType()
	arg_13_0:Show()

	setText = var_5

	local var_13_2 = arg_13_0.gemPurchaseBtn
	local var_13_3 = var_6.Find(var_13_2, "content/Text")

	i18n = var_13_2

	var_5(var_13_3, var_13_2("word_buy"))

	setText = var_5

	local var_13_4 = arg_13_0.goldPurchaseBtn
	local var_13_5 = var_6.Find(var_13_4, "content/Text")

	i18n = var_13_4

	var_5(var_13_5, var_13_4("word_buy"))

	setActive = var_5

	var_5(arg_13_0.goldPurchaseIcon, true)

	setActive = var_5

	var_5(arg_13_0.gemPurchaseIcon, true)

	return
end

function var_0_1.UpdateSkinType(arg_14_0)
	Goods = var_1_10001

	local var_14_0 = var_1_10001.FurnitureId2Id(arg_14_0.furniture.id)

	Goods = var_2

	local var_14_1 = var_2.ExistFurniture(var_14_0)

	setActive = var_3

	var_3(arg_14_0.shipTr, var_14_1)

	if var_14_1 then
		Goods = var_3

		local var_14_2 = var_3.GetFurnitureConfig(var_14_0)

		Goods = var_4

		local var_14_3 = var_4.Id2ShipSkinId(var_14_2.id)

		pg = var_5

		local var_14_4 = var_5.ship_skin_template[var_14_3]

		GetImageSpriteFromAtlasAsync = var_1_10006

		var_1_10006("QIcon/" .. var_14_4.prefab, "", arg_14_0.shipIcon.gameObject)

		ShipGroup = var_1_10006

		local var_14_5 = var_1_10006.getDefaultShipConfig(var_14_4.ship_group)
		local var_14_6 = arg_14_0.shipTxt

		shortenString = var_8
		var_14_6.text = var_8(var_14_5.name .. "-" .. var_14_4.name, 15)
	end

	return
end

function var_0_1.UpdateMainInfo(arg_15_0)
	local var_15_0 = arg_15_0.furniture

	HXSet = var_1_10002

	local var_15_1 = var_1_10002.hxLan(var_15_0:getConfig("name"))

	arg_15_0.nameTxt.text = var_15_1
	arg_15_0.themeTxt.text = var_15_0:GetThemeName()

	local var_15_2 = arg_15_0.descTxt

	HXSet = var_4
	var_15_2.text = var_4.hxLan(var_15_0:getConfig("describe"))

	arg_15_0:UpdateIcon()
	arg_15_0:UpdatePrice()

	local var_15_3 = var_15_0:canPurchaseByDormMoeny()
	local var_15_4 = var_15_0
	local var_15_5 = var_15_0.canPurchaseByGem(var_15_4)

	setActive = var_15_4

	var_15_4(arg_15_0.goldPurchaseBtn, var_15_3)

	setActive = var_15_4

	var_15_4(arg_15_0.gemPurchaseBtn, var_15_5)

	setActive = var_15_4

	var_15_4(arg_15_0.gemIcon, var_15_5)

	setActive = var_15_4

	var_15_4(arg_15_0.gemCount, var_15_5)

	setActive = var_15_4

	var_15_4(arg_15_0.goldIcon, var_15_3)

	setActive = var_15_4

	var_15_4(arg_15_0.goldCount, var_15_3)

	setActive = var_15_4

	var_15_4(arg_15_0.line, var_15_3 and var_15_5)

	local var_15_6 = arg_15_0.goldPurchaseBtn
	local var_15_7 = var_5.GetComponent

	typeof = var_7
	LayoutElement = var_1_10008

	local var_15_8 = var_15_7(var_15_6, var_7(var_1_10008))
	local var_15_9 = arg_15_0.gemPurchaseBtn
	local var_15_10 = var_6.GetComponent

	typeof = var_1_10008
	LayoutElement = var_1_10009

	local var_15_11 = var_15_10(var_15_9, var_1_10008(var_1_10009))

	if var_15_5 and var_15_3 then
		var_15_8.preferredWidth = 239
		var_15_11.preferredWidth = 239
	elseif var_15_5 and not var_15_3 then
		var_15_8.preferredWidth = 0
		var_15_11.preferredWidth = 510
	elseif not var_15_5 and var_15_3 then
		var_15_8.preferredWidth = 510
		var_15_11.preferredWidth = 0
	end

	arg_15_0.maxCnt.text = ""

	if var_15_0:getConfig("count") > 1 then
		arg_15_0.maxCnt.text = var_15_0.count .. "/" .. var_15_0:getConfig("count")
	end

	return
end

function var_0_1.UpdateEnergy(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.dorm
	local var_16_1 = var_2.getComfortable(var_16_0)
	local var_16_2 = arg_16_0.dorm
	local var_16_3 = var_3.getComfortable(var_16_2, arg_16_1) - var_16_1 > 0
	local var_16_4 = arg_16_0.dorm
	local var_16_5 = var_6._GetComfortableLevel(var_16_4)

	LoadSpriteAtlasAsync = var_16_4

	var_16_4("ui/CourtyardUI_atlas", "express_" .. var_16_5, function(arg_17_0)
		if arg_16_0.exited then
			return
		end

		arg_16_0.energyIcon.sprite = arg_17_0

		local var_17_0 = arg_16_0.energyIcon

		var_1.SetNativeSize(var_17_0)

		return
	end)

	Color = var_16_4

	local var_16_6 = var_16_4.New(0.5921569, 0.8470588, 0.4235294, 1)

	Color = var_8

	local var_16_7 = var_8.New(0.945098, 0.7960784, 0.3019608, 1)

	arg_16_0.energyAddition.color = var_16_3 and var_16_6 or var_16_7
	arg_16_0.energyTxt.text = var_16_1
	arg_16_0.energyAdditionTxt.text = " +" .. var_4

	return
end

function var_0_1.UpdatePrice(arg_18_0)
	local var_18_0 = arg_18_0.furniture
	local var_18_1 = var_1.getPrice

	PlayerConst = var_1_10004

	local var_18_2 = var_18_1(var_18_0, var_1_10004.ResDormMoney)
	local var_18_3 = var_1
	local var_18_4 = var_1.getPrice

	PlayerConst = var_1_10005

	local var_18_5 = var_18_4(var_18_3, var_1_10005.ResDiamond)

	arg_18_0.gemCount.text = var_18_5 * arg_18_0.count
	arg_18_0.goldCount.text = var_18_2 * arg_18_0.count
	arg_18_0.countTxt.text = arg_18_0.count

	local var_18_6 = {}

	for iter_18_0 = 1, arg_18_0.count do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_18_7 = var_18_6

		Furniture = var_1_10011

		var_1_10009(var_18_7, var_1_10011.New({
			id = arg_18_0.furniture.id
		}))
	end

	arg_18_0:UpdateEnergy(var_18_6)

	return
end

function var_0_1.UpdateIcon(arg_19_0)
	local var_19_0 = arg_19_0.icon

	GetSpriteFromAtlas = var_1_10002

	local var_19_1 = "furnitureicon/"
	local var_19_2 = arg_19_0.furniture

	var_19_0.sprite = var_1_10002(var_19_1 .. var_4.getConfig(var_19_2, "icon"), "")

	local var_19_3 = arg_19_0.icon

	var_1.SetNativeSize(var_19_3)

	setActive = var_1

	var_1(arg_19_0.icon.gameObject, true)

	pg = var_1

	local var_19_4

	var_19_4 = var_1.furniture_data_template[arg_19_0.furniture.configId].interAction ~= nil or var_1.spine ~= nil and var_1.spine[2] ~= nil
	setActive = var_3

	var_3(arg_19_0.playBtn, false)

	onButton = var_3

	local var_19_5 = arg_19_0
	local var_19_6 = arg_19_0.playBtn

	local function var_19_7()
		Goods = var_2_10000

		local var_20_0 = var_2_10000.FurnitureId2Id(arg_19_0.furniture.id)

		Goods = var_1

		local var_20_1 = var_1.ExistFurniture(var_20_0)
		local var_20_2 = 312011

		if var_20_1 then
			Goods = var_2_10003
			var_20_2 = var_2_10003.Id2ShipSkinId(var_20_0)
		end

		local var_20_3 = arg_19_0

		CourtyardInteractionPreview = var_2_10004

		local var_20_4 = var_2_10004.New

		pg = var_2_10005
		var_20_3.interactionPreview = var_20_4(var_2_10005.UIMgr.GetInstance().OverlayMain, arg_19_0._event)

		local var_20_5 = arg_19_0.interactionPreview

		var_3.ExecuteAction(var_20_5, "Show", var_0.id, var_20_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_19_5, var_19_6, var_19_7, var_1_10007)

	return
end

function var_0_1.Show(arg_21_0)
	arg_21_0.isShowing = true

	var_0_1.super.Show(arg_21_0)

	SetParent = var_1

	local var_21_0 = arg_21_0._tf

	pg = var_1_10003

	var_1(var_21_0, var_1_10003.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_1.Hide(arg_22_0)
	arg_22_0.isShowing = false

	var_0_1.super.Hide(arg_22_0)

	SetParent = var_1

	var_1(arg_22_0._tf, arg_22_0._parentTf)

	if arg_22_0.interactionPreview then
		local var_22_0 = arg_22_0.interactionPreview

		var_1.Destroy(var_22_0)

		arg_22_0.interactionPreview = nil
	end

	return
end

function var_0_1.OnDestroy(arg_23_0)
	if arg_23_0.isShowing then
		arg_23_0:Hide()
	end

	return
end

return var_0_1
