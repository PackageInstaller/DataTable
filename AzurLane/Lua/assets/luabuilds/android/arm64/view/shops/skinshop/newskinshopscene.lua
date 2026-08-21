local var_0_0 = class("NewSkinShopScene", import("view.base.BaseUI"))

var_0_0.MODE_OVERVIEW = 1
var_0_0.MODE_EXPERIENCE = 2
var_0_0.MODE_EXPERIENCE_FOR_ITEM = 3

local var_0_1 = -1
local var_0_2 = -2
local var_0_3 = -4

var_0_0.PAGE_RETURN = -3

local var_0_4 = 9999
local var_0_5 = 9997
local var_0_6 = 9998

var_0_0.PAGE_ALL = -1
var_0_0.optionsPath = {
	"overlay/blur_panel/adapt/top/option"
}

function var_0_0.getUIName(arg_1_0)
	return "NewSkinShopUI"
end

function var_0_0.forceGC(arg_2_0)
	return true
end

function var_0_0.ResUISettings(arg_3_0)
	return {
		anim = true,
		showType = PlayerResUI.TYPE_GEM
	}
end

function var_0_0.GetAllCommodity(arg_4_0)
	local var_4_0 = getProxy(ShipSkinProxy):GetAllSkins()

	if LOCK_SKIN_US then
		local var_4_1 = pg.gameset.levellimit_skintype.description

		if pg.gameset.levellimit_skintype.key_value >= getProxy(PlayerProxy):getData().level then
			var_4_0 = _.filter(var_4_0, function(arg_5_0)
				return table.contains(var_4_1, pg.ship_skin_template[arg_5_0:getSkinId()].shop_type_id)
			end)
		end
	end

	return var_4_0
end

function var_0_0.GetPlayer(arg_6_0)
	return (getProxy(PlayerProxy):getRawData())
end

function var_0_0.GetShopTypeIdBySkinId(arg_7_0, arg_7_1)
	var_0_0.shopTypeIdList = var_0_0.shopTypeIdList or {}

	if var_0_0.shopTypeIdList[arg_7_1] then
		return var_0_0.shopTypeIdList[arg_7_1]
	end

	for iter_7_0, iter_7_1 in pairs(pg.ship_skin_template.get_id_list_by_shop_type_id) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			var_0_0.shopTypeIdList[iter_7_3] = iter_7_0

			if iter_7_3 == arg_7_1 then
				return iter_7_0
			end
		end
	end

	return
end

function var_0_0.GetSkinClassify(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_1 = arg_8_0:GetShopTypeIdBySkinId(iter_8_1:getSkinId())

		if var_8_1 == 0 then
			local var_8_2 = var_0_4 or var_8_1
			local var_8_3 = var_8_0[var_8_2] or 0

			var_8_0[var_8_2] = var_8_3 + 1
		end
	end

	local var_8_4 = {}

	for iter_8_2, iter_8_3 in ipairs(arg_8_0:GetReturnSkins()) do
		({})[iter_8_3] = true
	end

	if underscore.any(arg_8_1, function(arg_9_0)
		return var_8_4[arg_9_0.id]
	end) then
		table.insert({}, var_0)
	end

	for iter_8_4, iter_8_5 in ipairs(pg.skin_page_template.all) do
		if iter_8_5 ~= var_0_5 and iter_8_5 ~= var_0_6 then
			local var_8_5 = var_8_0[iter_8_5] or 0

			if var_8_5 > 0 then
				table.insert({}, iter_8_5)
			end
		end
	end

	if arg_8_2 == var_0_0.MODE_EXPERIENCE then
		table.insert({}, 1, var_0_2)
	end

	if arg_8_2 == var_0_0.MODE_EXPERIENCE_FOR_ITEM then
		table.insert({}, 1, var_0_3)
	end

	table.insert({}, 1, var_0_1)

	return {}
end

function var_0_0.GetReturnSkins(arg_10_0)
	arg_10_0.returnSkins = arg_10_0.returnSkins or getProxy(ShipSkinProxy):GetEncoreSkins()

	return arg_10_0.returnSkins
end

function var_0_0.GetReturnSkinMap(arg_11_0)
	if not arg_11_0.encoreSkinMap then
		arg_11_0.encoreSkinMap = {}

		for iter_11_0, iter_11_1 in ipairs((arg_11_0:GetReturnSkins())) do
			arg_11_0.encoreSkinMap[iter_11_1] = true
		end
	end

	return arg_11_0.encoreSkinMap
end

function var_0_0.OnFurnitureUpdate(arg_12_0, arg_12_1)
	if not arg_12_0.mainView.commodity then
		return
	end

	local var_12_0 = arg_12_0.mainView.commodity.id

	if Goods.ExistFurniture(arg_12_0.mainView.commodity.id) and Goods.Id2FurnitureId(var_12_0) == arg_12_1 then
		arg_12_0.mainView:Flush(arg_12_0.mainView.commodity)
	end

	return
end

function var_0_0.OnShopping(arg_13_0, arg_13_1)
	if not arg_13_0.mainView.commodity then
		return
	end

	arg_13_0.mainView:ClosePurchaseView()

	if arg_13_0.mainView.commodity.id == arg_13_1 then
		local var_13_0 = arg_13_0:GetAllCommodity()
		local var_13_1 = _.detect(var_13_0, function(arg_14_0)
			return arg_14_0.id == arg_13_1
		end)

		if var_13_1 then
			arg_13_0.mainView:Flush(var_13_1)
		end

		arg_13_0:UpdateCouponBtn()
		arg_13_0:UpdateVoucherBtn()
		arg_13_0:UpdateCommodities(var_13_0, false)

		arg_13_0.commodities = var_13_0
	end

	return
end

function var_0_0.init(arg_15_0)
	arg_15_0.cgGroup = arg_15_0._tf:GetComponent(typeof(CanvasGroup))
	arg_15_0.backBtn = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/back_btn")
	arg_15_0.atlasBtn = arg_15_0._tf:Find("overlay/bottom/bg/atlas")
	arg_15_0.prevBtn = arg_15_0._tf:Find("overlay/bottom/bg/left_arr")
	arg_15_0.nextBtn = arg_15_0._tf:Find("overlay/bottom/bg/right_arr")
	arg_15_0.live2dFilter = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/live2d")
	arg_15_0.live2dFilterSel = arg_15_0.live2dFilter:Find("selected")
	arg_15_0.indexBtn = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/index_btn")
	arg_15_0.indexBtnSel = arg_15_0.indexBtn:Find("sel")
	arg_15_0.inptuTr = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/search")
	arg_15_0.changeBtn = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/change_btn")

	setText(arg_15_0.inptuTr:Find("holder"), i18n("skinatlas_search_holder"))

	arg_15_0.couponTr = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/discount/coupon")
	arg_15_0.couponSelTr = arg_15_0.couponTr:Find("selected")
	arg_15_0.voucherTr = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/discount/voucher")
	arg_15_0.voucherSelTr = arg_15_0.voucherTr:Find("selected")
	arg_15_0.rollingCircleRect = RollingCircleRect.New(arg_15_0._tf:Find("overlay/left/mask/content/0"), arg_15_0._tf:Find("overlay/left"))

	arg_15_0.rollingCircleRect:SetCallback(arg_15_0, var_0_0.OnSelectSkinPage, var_0_0.OnConfirmSkinPage)

	arg_15_0.rollingCircleMaskTr = arg_15_0._tf:Find("overlay/left")
	arg_15_0.mainView = NewSkinShopMainView.New(arg_15_0._tf, arg_15_0.event, arg_15_0.contextData)
	arg_15_0.title = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/title"):GetComponent(typeof(Image))
	arg_15_0.titleEn = arg_15_0._tf:Find("overlay/blur_panel/adapt/top/title_en"):GetComponent(typeof(Image))
	arg_15_0.scrollrect = arg_15_0._tf:Find("overlay/bottom/scroll"):GetComponent("LScrollRect")
	arg_15_0.scrollrect.isNewLoadingMethod = true

	function arg_15_0.scrollrect.onInitItem(arg_16_0)
		arg_15_0:OnInitItem(arg_16_0)

		return
	end

	function arg_15_0.scrollrect.onUpdateItem(arg_17_0, arg_17_1)
		arg_15_0:OnUpdateItem(arg_17_0, arg_17_1)

		return
	end

	arg_15_0.emptyTr = arg_15_0._tf:Find("bgs/empty")
	arg_15_0.defaultIndex = {
		typeIndex = ShipIndexConst.TypeAll,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll,
		extraIndex = SkinIndexLayer.ExtraALL
	}
	Input.multiTouchEnabled = false

	return
end

function var_0_0.didEnter(arg_18_0)
	onButton(arg_18_0, arg_18_0.backBtn, function()
		arg_18_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_18_0, arg_18_0.atlasBtn, function()
		arg_18_0:emit(NewSkinShopMediator.ON_ATLAS)

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.prevBtn, function()
		arg_18_0:OnPrevCommodity()

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.nextBtn, function()
		arg_18_0:OnNextCommodity()

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.indexBtn, function()
		arg_18_0:emit(NewSkinShopMediator.ON_INDEX, {
			OnFilter = function(arg_24_0)
				arg_18_0:OnFilter(arg_24_0)

				return
			end,
			defaultIndex = arg_18_0.defaultIndex
		})

		return
	end, SFX_PANEL)
	onInputChanged(arg_18_0, arg_18_0.inptuTr, function()
		arg_18_0:OnSearch()

		return
	end)
	onToggle(arg_18_0, arg_18_0.changeBtn, function(arg_26_0)
		if arg_26_0 and getInputText(arg_18_0.inptuTr) ~= "" then
			setInputText(arg_18_0.inptuTr, "")
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.live2dFilter, function()
		local var_27_0 = arg_18_0.defaultIndex

		if arg_18_0.defaultIndex.extraIndex == SkinIndexLayer.ExtraL2D then
			var_27_0.extraIndex = SkinIndexLayer.ExtraALL or SkinIndexLayer.ExtraL2D

			arg_18_0:OnFilter(arg_18_0.defaultIndex)

			return
		end
	end, SFX_PANEL)

	arg_18_0.isFilterCoupon = false

	onButton(arg_18_0, arg_18_0.couponTr, function()
		if not SkinCouponActivity.StaticExistActivityAndCoupon() then
			arg_18_0.isFilterCoupon = false

			arg_18_0:UpdateCouponBtn()
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_18_0.isFilterCoupon = not arg_18_0.isFilterCoupon

		setActive(arg_18_0.couponSelTr, arg_18_0.isFilterCoupon)
		arg_18_0:OnFilter(arg_18_0.defaultIndex)

		return
	end, SFX_PANEL)

	arg_18_0.isFilterVoucher = false

	onButton(arg_18_0, arg_18_0.voucherTr, function()
		arg_18_0.isFilterVoucher = not arg_18_0.isFilterVoucher

		setActive(arg_18_0.voucherSelTr, arg_18_0.isFilterVoucher)
		arg_18_0:OnFilter(arg_18_0.defaultIndex)

		return
	end, SFX_PANEL)
	arg_18_0:SetUp()
	getProxy(CommanderManualProxy):TaskProgressAdd(2021, 1)

	return
end

function var_0_0.UpdateCouponBtn(arg_30_0)
	local var_30_0 = SkinCouponActivity.StaticExistActivityAndCoupon() and (not arg_30_0.contextData.mode or arg_30_0.contextData.mode == var_0_0.MODE_OVERVIEW)

	arg_30_0.isFilterCoupon = tobool(arg_30_0.isFilterCoupon) and var_30_0

	local var_30_1 = arg_30_0.couponTr

	var_30_1.localScale = var_30_0 and Vector3(1, 1, 1) or Vector3(0, 0, 0)

	return
end

function var_0_0.UpdateVoucherBtn(arg_31_0)
	local var_31_9000
	local var_31_0 = getProxy(BagProxy)
	local var_31_1 = #var_31_0.GetSkinShopDiscountItemList(var_31_9000) > 0 and (not arg_31_0.contextData.mode or arg_31_0.contextData.mode == var_0_0.MODE_OVERVIEW)
	local var_31_2 = tobool(arg_31_0.isFilterVoucher)

	if var_31_0 then
		var_31_2 = var_31_1
	end

	arg_31_0.isFilterVoucher = var_31_2

	local var_31_3 = arg_31_0.voucherTr

	var_31_3.localScale = var_31_1 and Vector3(1, 1, 1) or Vector3(0, 0, 0)

	return
end

function var_0_0.OnSelectSkinPage(arg_32_0, arg_32_1)
	if arg_32_0.selectedSkinPageItem then
		setActive(arg_32_0.selectedSkinPageItem._tr:Find("selected"), false)
		setActive(arg_32_0.selectedSkinPageItem._tr:Find("name"), true)
	end

	setActive(arg_32_1._tr:Find("selected"), true)
	setActive(arg_32_1._tr:Find("name"), false)

	arg_32_0.selectedSkinPageItem = arg_32_1

	return
end

function var_0_0.OnConfirmSkinPage(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1:GetID()

	if arg_33_0.skinPageID ~= var_33_0 then
		arg_33_0.skinPageID = var_33_0

		if arg_33_0.commodities then
			arg_33_0:UpdateCommodities(arg_33_0.commodities, true)
		end
	end

	return
end

function var_0_0.OnFilter(arg_34_0, arg_34_1)
	arg_34_0.defaultIndex = {
		typeIndex = arg_34_1.typeIndex,
		campIndex = arg_34_1.campIndex,
		rarityIndex = arg_34_1.rarityIndex,
		extraIndex = arg_34_1.extraIndex
	}

	setActive(arg_34_0.live2dFilterSel, arg_34_1.extraIndex == SkinIndexLayer.ExtraL2D)

	if arg_34_0.commodities then
		arg_34_0:UpdateCommodities(arg_34_0.commodities, true)
	end

	setActive(arg_34_0.indexBtnSel, arg_34_1.typeIndex ~= ShipIndexConst.TypeAll or arg_34_1.campIndex ~= ShipIndexConst.CampAll or arg_34_1.rarityIndex ~= ShipIndexConst.RarityAll or arg_34_1.extraIndex ~= SkinIndexLayer.ExtraALL)

	return
end

function var_0_0.OnSearch(arg_35_0)
	if arg_35_0.commodities then
		arg_35_0:UpdateCommodities(arg_35_0.commodities, true)
	end

	return
end

function var_0_0.GetDefaultPage(arg_36_0, arg_36_1)
	if arg_36_1 == var_0_0.MODE_EXPERIENCE then
		do return var_0_2 end

		goto label_36_0
	end

	if arg_36_1 == var_0_0.MODE_EXPERIENCE_FOR_ITEM then
		do return var_0_3 end

		goto label_36_0
	end

	::label_36_0::

	if arg_36_0.contextData.page then
		do
			return arg_36_0.contextData.page or var_0_1
		end

		return
	end
end

function var_0_0.SetUp(arg_37_0)
	local var_37_0 = arg_37_0.contextData.mode or var_0_0.MODE_OVERVIEW

	arg_37_0.mode = var_37_0

	local var_37_1 = arg_37_0:GetAllCommodity()

	arg_37_0.cgGroup.blocksRaycasts = false

	arg_37_0:UpdateTitle(var_37_0)
	arg_37_0:UpdateCouponBtn()
	arg_37_0:UpdateVoucherBtn()
	setActive(arg_37_0.rollingCircleMaskTr, var_37_0 == var_0_0.MODE_OVERVIEW)

	if var_37_0 == var_0_0.MODE_EXPERIENCE or var_37_0 == var_0_0.MODE_EXPERIENCE_FOR_ITEM then
		getProxy(SettingsProxy):SetNextTipTimeLimitSkinShop()
	end

	arg_37_0.skinPageID = arg_37_0:GetDefaultPage(var_37_0)

	parallelAsync({
		function(arg_38_0)
			arg_37_0:InitSkinClassify(var_37_1, var_37_0, arg_38_0)

			return
		end,
		function(arg_39_0)
			seriesAsync({
				function(arg_40_0)
					onNextTick(arg_40_0)

					return
				end,
				function(arg_41_0)
					if arg_37_0.exited then
						return
					end

					arg_37_0:UpdateCommodities(var_37_1, true, arg_41_0)

					return
				end
			}, arg_39_0)

			return
		end
	}, function()
		arg_37_0.commodities = var_37_1
		arg_37_0.cgGroup.blocksRaycasts = true

		return
	end)

	return
end

function var_0_0.UpdateTitle(arg_43_0, arg_43_1)
	arg_43_0.title.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", ({
		"huanzhuangshagndian",
		"title_01",
		"title_01"
	})[arg_43_1])

	arg_43_0.title:SetNativeSize()

	arg_43_0.titleEn.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", ({
		"huanzhuangshagndian_en",
		"title_en_01",
		"title_en_01"
	})[arg_43_1])

	arg_43_0.titleEn:SetNativeSize()

	return
end

local function var_0_7(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1:GetID()
	local var_44_1
	local var_44_2

	if var_44_0 ~= var_0_1 and var_44_0 ~= var_0_2 then
		if var_44_0 == var_0_3 then
			var_44_2 = "ALL"
			var_44_1 = "text_all"
		else
			if var_44_0 == var_0 then
				var_44_2 = "RETURN"
				var_44_1 = "text_fanchang"

				goto label_44_0

				var_44_2 = pg.skin_page_template[var_44_0].english_name
			end

			var_44_1 = "text_" .. pg.skin_page_template[var_44_0].res
		end

		::label_44_0::

		LoadSpriteAtlasAsync("SkinClassified", var_44_1 .. "01", function(arg_45_0)
			if arg_44_0.exited then
				return
			end

			local var_45_0 = arg_44_1._tr:Find("name"):GetComponent(typeof(Image))

			var_45_0.sprite = arg_45_0

			var_45_0:SetNativeSize()

			return
		end)
		LoadSpriteAtlasAsync("SkinClassified", var_44_1, function(arg_46_0)
			if arg_44_0.exited then
				return
			end

			local var_46_0 = arg_44_1._tr:Find("selected/Image"):GetComponent(typeof(Image))

			var_46_0.sprite = arg_46_0

			var_46_0:SetNativeSize()

			return
		end)
		setText(arg_44_1._tr:Find("eng"), var_44_2)

		return
	end
end

function var_0_0.InitSkinClassify(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	for iter_47_0, iter_47_1 in ipairs((arg_47_0:GetSkinClassify(arg_47_1, arg_47_2))) do
		table.insert({}, function(arg_48_0)
			if arg_47_0.exited then
				return
			end

			var_0_7(arg_47_0, (arg_47_0.rollingCircleRect:AddItem(iter_47_1)))

			if (iter_47_0 - 1) % 5 == 0 or iter_47_0 == #var_0 then
				onNextTick(arg_48_0)
			else
				arg_48_0()
			end

			return
		end)
	end

	seriesAsync({}, function()
		if arg_47_0.exited then
			return
		end

		arg_47_0.rollingCircleRect:ScrollTo(arg_47_0.skinPageID)
		arg_47_3()

		return
	end)

	return
end

local function var_0_8(arg_50_0)
	var_0_0.cacheSkinExperienceItems = var_0_0.cacheSkinExperienceItems or getProxy(BagProxy):GetSkinExperienceItems()

	return _.any(var_0_0.cacheSkinExperienceItems, function(arg_51_0)
		return arg_51_0:CanUseForShop(arg_50_0)
	end)
end

function var_0_0.IsType(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_0:GetShopTypeIdBySkinId(arg_52_2:getSkinId())

	if arg_52_2:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
		if arg_52_0.mode == var_0_0.MODE_EXPERIENCE_FOR_ITEM then
			return arg_52_1 == var_0_3 and var_0_8(arg_52_2.id)
		else
			return arg_52_1 == var_0_2
		end

		goto label_52_0
	end

	if arg_52_1 == var_0_1 then
		do return true end

		goto label_52_0
	end

	if arg_52_1 == var_0 and arg_52_0:GetReturnSkinMap()[arg_52_2.id] then
		do return true end

		goto label_52_0
	end

	::label_52_0::

	if var_52_0 == 0 then
		do
			local var_52_1 = var_0_4 or var_52_0

			return var_52_1 == arg_52_1
		end

		return false
	end
end

function var_0_0.ToVShip(arg_53_0, arg_53_1)
	if not arg_53_0.vship then
		arg_53_0.vship = {}

		function arg_53_0.vship.getNation()
			return arg_53_0.vship.config.nationality
		end

		function arg_53_0.vship.getShipType()
			return arg_53_0.vship.config.type
		end

		function arg_53_0.vship.getTeamType()
			return ShipType.GetTeamFromShipType(arg_53_0.vship.config.type)
		end

		function arg_53_0.vship.getRarity()
			return arg_53_0.vship.config.rarity
		end
	end

	arg_53_0.vship.config = arg_53_1

	return arg_53_0.vship
end

function var_0_0.IsAllFilter(arg_58_0, arg_58_1)
	return arg_58_1.typeIndex == ShipIndexConst.TypeAll and arg_58_1.campIndex == ShipIndexConst.CampAll and arg_58_1.rarityIndex == ShipIndexConst.RarityAll and arg_58_1.extraIndex == SkinIndexLayer.ExtraALL
end

function var_0_0.IsFilterType(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_0:IsAllFilter(arg_59_1) then
		return true
	end

	;({}).id = arg_59_2:getSkinId()

	local var_59_0 = ShipSkin.New({})
	local var_59_1 = var_59_0:GetDefaultShipConfig()

	if not var_59_1 then
		return false
	end

	local var_59_2 = arg_59_0:ToVShip(var_59_1)

	return ShipIndexConst.filterByType(var_59_2, arg_59_1.typeIndex) and ShipIndexConst.filterByCamp(var_59_2, arg_59_1.campIndex) and ShipIndexConst.filterByRarity(var_59_2, arg_59_1.rarityIndex) and SkinIndexLayer.filterByExtra(var_59_0, arg_59_1.extraIndex)
end

function var_0_0.IsSearchType(arg_60_0, arg_60_1, arg_60_2)
	if not arg_60_1 or arg_60_1 == "" then
		return true
	end

	;({}).id = arg_60_2:getSkinId()

	return ShipSkin.New({}):IsMatchKey(arg_60_1)
end

local function var_0_9(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_2[arg_61_0.id]
	local var_61_1 = arg_61_2[arg_61_1.id]

	if arg_61_2[arg_61_0.id] == arg_61_2[arg_61_1.id] then
		return arg_61_0.id < arg_61_1.id
	else
		return var_61_1 < var_61_0
	end

	return
end

function var_0_0.Sort(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	local var_62_0 = arg_62_1.buyCount == 0 and 1 or 0
	local var_62_1 = arg_62_2.buyCount == 0 and 1 or 0

	if (arg_62_1.buyCount == 0 and 1 or 0) == (arg_62_2.buyCount == 0 and 1 or 0) then
		local var_62_2 = arg_62_1:getConfig("order")
		local var_62_3 = arg_62_2:getConfig("order")

		if var_62_2 == var_62_3 then
			return var_0_9(arg_62_1, arg_62_2, arg_62_3)
		else
			return var_62_2 < var_62_3
		end
	else
		return var_62_1 < var_62_0
	end

	return
end

function var_0_0.IsCouponType(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_1 and not SkinCouponActivity.GetBestReadySkinCouponAct(arg_63_2.id) then
		return false
	end

	return true
end

function var_0_0.IsVoucherType(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_1 and not arg_64_2 then
		return false
	end

	return true
end

function var_0_0.UpdateCommodities(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_0:ClearCards()

	arg_65_0.cards = {}
	arg_65_0.displays = {}
	arg_65_0.canUseVoucherCache = {}

	local var_65_0 = getInputText(arg_65_0.inptuTr)
	local var_65_1 = getProxy(BagProxy):GetSkinShopDiscountItemList()

	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		local var_65_2 = iter_65_1:StaticCanUseVoucherType(var_65_1)

		if arg_65_0:IsType(arg_65_0.skinPageID, iter_65_1) and arg_65_0:IsFilterType(arg_65_0.defaultIndex, iter_65_1) and arg_65_0:IsSearchType(var_65_0, iter_65_1) and arg_65_0:IsCouponType(arg_65_0.isFilterCoupon, iter_65_1) and arg_65_0:IsVoucherType(arg_65_0.isFilterVoucher, var_65_2) then
			table.insert(arg_65_0.displays, iter_65_1)
		end

		arg_65_0.canUseVoucherCache[iter_65_1.id] = var_65_2
	end

	local var_65_3 = {}

	for iter_65_2, iter_65_3 in ipairs(arg_65_0.displays) do
		local var_65_4 = 0

		if not (iter_65_3.type == Goods.TYPE_ACTIVITY or iter_65_3.type == Goods.TYPE_ACTIVITY_EXTRA) then
			var_65_4 = iter_65_3:GetPrice()
		end

		var_65_3[iter_65_3.id] = var_65_4
	end

	table.sort(arg_65_0.displays, function(arg_66_0, arg_66_1)
		return arg_65_0:Sort(arg_66_0, arg_66_1, var_65_3)
	end)

	if arg_65_2 then
		arg_65_0.triggerFirstCard = true

		arg_65_0.scrollrect:SetTotalCount(#arg_65_0.displays, 0)
	else
		arg_65_0.scrollrect:SetTotalCount(#arg_65_0.displays)
	end

	local var_65_5 = #arg_65_0.displays <= 0

	setActive(arg_65_0.emptyTr, #arg_65_0.displays <= 0)

	if var_65_5 then
		arg_65_0.mainView:Flush(nil)
	end

	if arg_65_3 then
		arg_65_3()
	end

	return
end

function var_0_0.OnInitItem(arg_67_0, arg_67_1)
	local var_67_0 = NewShopSkinCard.New(arg_67_1)

	onButton(arg_67_0, var_67_0._go, function()
		if not var_67_0.commodity then
			return
		end

		for iter_68_0, iter_68_1 in pairs(arg_67_0.cards) do
			iter_68_1:UpdateSelected(false)
		end

		arg_67_0.selectedId = var_67_0.commodity.id

		var_67_0:UpdateSelected(true)
		arg_67_0:UpdateMainView(var_67_0.commodity)
		arg_67_0:GCHandle()

		return
	end, SFX_PANEL)

	arg_67_0.cards[arg_67_1] = var_67_0

	return
end

function var_0_0.OnUpdateItem(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = arg_69_0.cards[arg_69_2]

	if not arg_69_0.cards[arg_69_2] then
		arg_69_0:OnInitItem(arg_69_2)

		var_69_0 = arg_69_0.cards[arg_69_2]
	end

	local var_69_1 = arg_69_0.displays[arg_69_1 + 1]
	local var_69_2

	if not arg_69_0.displays[arg_69_1 + 1] then
		do return end

		var_69_2 = arg_69_0:GetReturnSkinMap()[var_69_1.id]
	end

	var_69_0:Update(var_69_1, arg_69_0.selectedId == var_69_1.id, var_69_2)

	if arg_69_0.triggerFirstCard and arg_69_1 == 0 then
		arg_69_0.triggerFirstCard = nil

		triggerButton(var_69_0._go)
	end

	return
end

function var_0_0.GCHandle(arg_70_0)
	local var_70_0 = var_0_0.GCCNT or 0

	var_0_0.GCCNT = var_70_0 + 1

	if var_0_0.GCCNT == 3 then
		gcAll()

		var_0_0.GCCNT = 0
	end

	return
end

function var_0_0.UpdateMainView(arg_71_0, arg_71_1)
	arg_71_0.mainView:Flush(arg_71_1)

	return
end

function var_0_0.GetCommodityIndex(arg_72_0, arg_72_1)
	for iter_72_0, iter_72_1 in ipairs(arg_72_0.displays) do
		if iter_72_1.id == arg_72_1 then
			return iter_72_0
		end
	end

	return
end

function var_0_0.OnPrevCommodity(arg_73_0)
	if not arg_73_0.selectedId then
		return
	end

	local var_73_0 = arg_73_0:GetCommodityIndex(arg_73_0.selectedId)

	if var_73_0 - 1 > 0 then
		arg_73_0:TriggerCommodity(var_73_0, -1)
	end

	return
end

function var_0_0.OnNextCommodity(arg_74_0)
	if not arg_74_0.selectedId then
		return
	end

	local var_74_0 = arg_74_0:GetCommodityIndex(arg_74_0.selectedId)

	if var_74_0 + 1 <= #arg_74_0.displays then
		arg_74_0:TriggerCommodity(var_74_0, 1)
	end

	return
end

function var_0_0.CheckCardBound(arg_75_0, arg_75_1, arg_75_2, arg_75_3, arg_75_4)
	local var_75_0 = getBounds(arg_75_0.scrollrect.gameObject.transform)

	if arg_75_3 then
		if math.ceil(getBounds(arg_75_1._tf):GetMax().x - var_75_0:GetMax().x) > getBounds(arg_75_2._tf).size.x then
			arg_75_0.scrollrect:SetNormalizedPosition(arg_75_0.scrollrect.value - (arg_75_0.scrollrect:HeadIndexToValue(arg_75_4 - 1) - arg_75_0.scrollrect:HeadIndexToValue(arg_75_4)), 0)
		end
	else
		local var_75_1 = getBounds(arg_75_1._tf)

		if getBounds(arg_75_1._tf.parent):GetMin().x < var_75_0:GetMin().x and var_75_1:GetMin().x < var_75_0:GetMin().x then
			arg_75_0.scrollrect:SetNormalizedPosition(arg_75_0.scrollrect:HeadIndexToValue(arg_75_4 - 1), 0)
		end
	end

	return
end

function var_0_0.TriggerCommodity(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0
	local var_76_1

	for iter_76_0, iter_76_1 in pairs(arg_76_0.cards) do
		if iter_76_1._tf.gameObject.name ~= "-1" then
			if iter_76_1.commodity.id == arg_76_0.displays[arg_76_1 + arg_76_2].id then
				var_76_0 = iter_76_1
			elseif iter_76_1.commodity.id == arg_76_0.displays[arg_76_1].id then
				var_76_1 = iter_76_1
			end
		end
	end

	if var_76_0 then
		triggerButton(var_76_0._tf)
	end

	if var_76_0 and var_76_1 then
		arg_76_0:CheckCardBound(var_76_0, var_76_1, arg_76_2 > 0, arg_76_1 + arg_76_2)
	end

	return
end

function var_0_0.ClearCards(arg_77_0)
	if not arg_77_0.cards then
		return
	end

	for iter_77_0, iter_77_1 in pairs(arg_77_0.cards) do
		iter_77_1:Dispose()
	end

	arg_77_0.cards = nil

	return
end

function var_0_0.willExit(arg_78_0)
	arg_78_0:ClearCards()
	ClearLScrollrect(arg_78_0.scrollrect)

	if arg_78_0.rollingCircleRect then
		arg_78_0.rollingCircleRect:Dispose()

		arg_78_0.rollingCircleRect = nil
	end

	Input.multiTouchEnabled = true

	if arg_78_0.mainView then
		arg_78_0.mainView:Dispose()

		arg_78_0.mainView = nil
	end

	var_0_0.shopTypeIdList = nil
	var_0_0.cacheSkinExperienceItems = nil

	return
end

return var_0_0
