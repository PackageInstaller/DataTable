local var_0_0 = class("BackYardFurnitureMsgBoxPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "FurnitureMsgboxPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.nameTxt = arg_2_0._tf:Find("frame/name"):GetComponent(typeof(Text))
	arg_2_0.themeTxt = arg_2_0._tf:Find("frame/theme/Text"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/desc"):GetComponent(typeof(Text))
	arg_2_0.iconContainer = arg_2_0._tf:Find("frame/icon")
	arg_2_0.icon = arg_2_0._tf:Find("frame/icon/Image"):GetComponent(typeof(Image))
	arg_2_0.playBtn = arg_2_0._tf:Find("frame/icon/play")
	arg_2_0.rawIcon = arg_2_0._tf:Find("frame/icon/rawImage"):GetComponent(typeof(RawImage))
	arg_2_0.shipTr = arg_2_0._tf:Find("frame/ship")
	arg_2_0.shipIcon = arg_2_0._tf:Find("frame/ship/icon"):GetComponent(typeof(Image))
	arg_2_0.shipTxt = arg_2_0._tf:Find("frame/ship/Text"):GetComponent(typeof(Text))
	arg_2_0.countPanel = arg_2_0._tf:Find("frame/count")
	arg_2_0.leftArr = arg_2_0._tf:Find("frame/count/left_arr")
	arg_2_0.rightArr = arg_2_0._tf:Find("frame/count/right_arr")
	arg_2_0.countTxt = arg_2_0._tf:Find("frame/count/Text"):GetComponent(typeof(Text))
	arg_2_0.gemIcon = arg_2_0._tf:Find("frame/price/gem")
	arg_2_0.gemCount = arg_2_0._tf:Find("frame/price/gem_text"):GetComponent(typeof(Text))
	arg_2_0.goldIcon = arg_2_0._tf:Find("frame/price/gold")
	arg_2_0.goldCount = arg_2_0._tf:Find("frame/price/gold_text"):GetComponent(typeof(Text))
	arg_2_0.line = arg_2_0._tf:Find("frame/price/line")
	arg_2_0.energyIcon = arg_2_0._tf:Find("frame/energy"):GetComponent(typeof(Image))
	arg_2_0.energyTxt = arg_2_0._tf:Find("frame/energy/Text"):GetComponent(typeof(Text))
	arg_2_0.energyAddition = arg_2_0._tf:Find("frame/energy/Text/addition"):GetComponent(typeof(Image))
	arg_2_0.energyAdditionTxt = arg_2_0._tf:Find("frame/energy/Text/addition/Text"):GetComponent(typeof(Text))
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close_btn")
	arg_2_0.btns = arg_2_0._tf:Find("frame/btns")
	arg_2_0.goldPurchaseBtn = arg_2_0._tf:Find("frame/btns/gold_purchase_btn")
	arg_2_0.gemPurchaseBtn = arg_2_0._tf:Find("frame/btns/gem_purchase_btn")
	arg_2_0.goldPurchaseIcon = arg_2_0._tf:Find("frame/btns/gold_purchase_btn/content/icon")
	arg_2_0.gemPurchaseIcon = arg_2_0._tf:Find("frame/btns/gem_purchase_btn/content/icon")
	arg_2_0.maxCnt = arg_2_0._tf:Find("frame/max_cnt"):GetComponent(typeof(Text))
	arg_2_0.maxBtn = arg_2_0._tf:Find("frame/count/max")
	arg_2_0.maxBtnTxt = arg_2_0.maxBtn:Find("Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("frame/price/label"), i18n("backyard_theme_total_print"))
	setActive(arg_2_0.rawIcon, false)

	return
end

function var_0_0.OnInit(arg_3_0)
	local function var_3_0()
		for iter_4_0 = 1, arg_3_0.count do
			table.insert({}, arg_3_0.furniture.id)
		end

		return {}
	end

	onButton(arg_3_0, arg_3_0.goldPurchaseBtn, function()
		arg_3_0:emit(NewBackYardShopMediator.ON_SHOPPING, var_3_0(), PlayerConst.ResDormMoney)
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.gemPurchaseBtn, function()
		arg_3_0:emit(NewBackYardShopMediator.ON_SHOPPING, var_3_0(), PlayerConst.ResDiamond)
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.leftArr, function()
		if arg_3_0.count <= 1 then
			return
		end

		arg_3_0.count = arg_3_0.count - 1

		arg_3_0:UpdatePrice()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.rightArr, function()
		if arg_3_0.count == arg_3_0.maxCount then
			return
		end

		arg_3_0.count = arg_3_0.count + 1

		arg_3_0:UpdatePrice()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.maxBtn, function()
		arg_3_0.count = arg_3_0.maxCount

		arg_3_0:UpdatePrice()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.PlayerUpdated(arg_12_0, arg_12_1)
	arg_12_0.player = arg_12_1

	return
end

function var_0_0.SetUp(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.dorm = arg_13_2
	arg_13_0.furniture = arg_13_1
	arg_13_0.count = 1
	arg_13_0.player = arg_13_3
	arg_13_0.maxCount = arg_13_1:getConfig("count") - arg_13_1.count

	local var_13_0 = arg_13_0.maxCount > 1

	setActive(arg_13_0.maxBtn, arg_13_0.maxCount > 1)
	setAnchoredPosition(arg_13_0.countPanel, {
		x = var_13_0 and 200 or 258
	})

	arg_13_0.maxBtnTxt.text = "MAX"

	arg_13_0:UpdateMainInfo()
	arg_13_0:UpdateSkinType()
	arg_13_0:Show()
	setText(arg_13_0.gemPurchaseBtn:Find("content/Text"), i18n("word_buy"))
	setText(arg_13_0.goldPurchaseBtn:Find("content/Text"), i18n("word_buy"))
	setActive(arg_13_0.goldPurchaseIcon, true)
	setActive(arg_13_0.gemPurchaseIcon, true)

	return
end

function var_0_0.UpdateSkinType(arg_14_0)
	local var_14_0 = Goods.FurnitureId2Id(arg_14_0.furniture.id)
	local var_14_1 = Goods.ExistFurniture(var_14_0)

	setActive(arg_14_0.shipTr, var_14_1)

	if var_14_1 then
		local var_14_2 = pg.ship_skin_template[Goods.Id2ShipSkinId(Goods.GetFurnitureConfig(var_14_0).id)]

		GetImageSpriteFromAtlasAsync("QIcon/" .. var_14_2.prefab, "", arg_14_0.shipIcon.gameObject)

		arg_14_0.shipTxt.text = shortenString(ShipGroup.getDefaultShipConfig(var_14_2.ship_group).name .. "-" .. var_14_2.name, 15)
	end

	return
end

function var_0_0.UpdateMainInfo(arg_15_0)
	arg_15_0.nameTxt.text = HXSet.hxLan(arg_15_0.furniture:getConfig("name"))
	arg_15_0.themeTxt.text = arg_15_0.furniture:GetThemeName()
	arg_15_0.descTxt.text = HXSet.hxLan(arg_15_0.furniture:getConfig("describe"))

	arg_15_0:UpdateIcon()
	arg_15_0:UpdatePrice()

	local var_15_0 = arg_15_0.furniture:canPurchaseByDormMoeny()
	local var_15_1 = arg_15_0.furniture:canPurchaseByGem()

	setActive(arg_15_0.goldPurchaseBtn, var_15_0)
	setActive(arg_15_0.gemPurchaseBtn, var_15_1)
	setActive(arg_15_0.gemIcon, var_15_1)
	setActive(arg_15_0.gemCount, var_15_1)
	setActive(arg_15_0.goldIcon, var_15_0)
	setActive(arg_15_0.goldCount, var_15_0)
	setActive(arg_15_0.line, var_15_0 and var_15_1)

	local var_15_2 = arg_15_0.goldPurchaseBtn:GetComponent(typeof(LayoutElement))
	local var_15_3 = arg_15_0.gemPurchaseBtn:GetComponent(typeof(LayoutElement))

	if var_15_1 and var_15_0 then
		var_15_2.preferredWidth = 239
		var_15_3.preferredWidth = 239
	elseif var_15_1 and not var_15_0 then
		var_15_2.preferredWidth = 0
		var_15_3.preferredWidth = 510
	elseif not var_15_1 and var_15_0 then
		var_15_2.preferredWidth = 510
		var_15_3.preferredWidth = 0
	end

	arg_15_0.maxCnt.text = ""

	if arg_15_0.furniture:getConfig("count") > 1 then
		arg_15_0.maxCnt.text = arg_15_0.furniture.count .. "/" .. arg_15_0.furniture:getConfig("count")
	end

	return
end

function var_0_0.UpdateEnergy(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.dorm:getComfortable()
	local var_16_1 = arg_16_0.dorm:getComfortable(arg_16_1) - var_16_0
	local var_16_2 = var_16_1 > 0

	LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "express_" .. arg_16_0.dorm:_GetComfortableLevel(), function(arg_17_0)
		if arg_16_0.exited then
			return
		end

		arg_16_0.energyIcon.sprite = arg_17_0

		arg_16_0.energyIcon:SetNativeSize()

		return
	end)

	local var_16_3 = Color.New(0.5921569, 0.8470588, 0.4235294, 1)
	local var_16_4 = Color.New(0.945098, 0.7960784, 0.3019608, 1)

	arg_16_0.energyAddition.color = var_16_2 and var_16_3 or var_16_4
	arg_16_0.energyTxt.text = var_16_0
	arg_16_0.energyAdditionTxt.text = " +" .. var_16_1

	return
end

function var_0_0.UpdatePrice(arg_18_0)
	arg_18_0.gemCount.text = arg_18_0.furniture:getPrice(PlayerConst.ResDiamond) * arg_18_0.count
	arg_18_0.goldCount.text = arg_18_0.furniture:getPrice(PlayerConst.ResDormMoney) * arg_18_0.count
	arg_18_0.countTxt.text = arg_18_0.count

	for iter_18_0 = 1, arg_18_0.count do
		table.insert({}, Furniture.New({
			id = arg_18_0.furniture.id
		}))
	end

	arg_18_0:UpdateEnergy({})

	return
end

function var_0_0.UpdateIcon(arg_19_0)
	arg_19_0.icon.sprite = GetSpriteFromAtlas("furnitureicon/" .. arg_19_0.furniture:getConfig("icon"), "")

	arg_19_0.icon:SetNativeSize()
	setActive(arg_19_0.icon.gameObject, true)

	local var_19_0 = pg.furniture_data_template[arg_19_0.furniture.configId]

	setActive(arg_19_0.playBtn, false)
	onButton(arg_19_0, arg_19_0.playBtn, function()
		local var_20_0 = Goods.FurnitureId2Id(arg_19_0.furniture.id)
		local var_20_1 = 312011

		if Goods.ExistFurniture(var_20_0) then
			var_20_1 = Goods.Id2ShipSkinId(var_20_0)
		end

		arg_19_0.interactionPreview = CourtyardInteractionPreview.New(pg.UIMgr.GetInstance().OverlayMain, arg_19_0._event)

		arg_19_0.interactionPreview:ExecuteAction("Show", var_19_0.id, var_20_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_21_0)
	arg_21_0.isShowing = true

	var_0_0.super.Show(arg_21_0)
	SetParent(arg_21_0._tf, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_0.Hide(arg_22_0)
	arg_22_0.isShowing = false

	var_0_0.super.Hide(arg_22_0)
	SetParent(arg_22_0._tf, arg_22_0._parentTf)

	if arg_22_0.interactionPreview then
		arg_22_0.interactionPreview:Destroy()

		arg_22_0.interactionPreview = nil
	end

	return
end

function var_0_0.OnDestroy(arg_23_0)
	if arg_23_0.isShowing then
		arg_23_0:Hide()
	end

	return
end

return var_0_0
