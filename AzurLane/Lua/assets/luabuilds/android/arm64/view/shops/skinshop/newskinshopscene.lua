class = var_0_10000

local var_0_0 = "NewSkinShopScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.MODE_OVERVIEW = 1
var_0_1.MODE_EXPERIENCE = 2
var_0_1.MODE_EXPERIENCE_FOR_ITEM = 3

local var_0_2 = -1
local var_0_3 = -2
local var_0_4 = -3
local var_0_5 = -4

var_0_1.PAGE_RETURN = var_0_4

local var_0_6 = 9999
local var_0_7 = 9997
local var_0_8 = 9998

var_0_1.PAGE_ALL = var_0_2
var_0_1.optionsPath = {
	"overlay/blur_panel/adapt/top/option"
}

function var_0_1.getUIName(arg_1_0)
	return "NewSkinShopUI"
end

function var_0_1.forceGC(arg_2_0)
	return true
end

function var_0_1.ResUISettings(arg_3_0)
	local var_3_0 = {
		anim = true
	}

	PlayerResUI = var_1_10002
	var_3_0.showType = var_1_10002.TYPE_GEM

	return var_3_0
end

function var_0_1.GetAllCommodity(arg_4_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.GetAllSkins(var_4_0)

	LOCK_SKIN_US = var_1_10002

	if var_1_10002 then
		pg = var_1_10002

		local var_4_2 = var_1_10002.gameset.levellimit_skintype.key_value

		pg = var_4_0

		local var_4_3 = var_4_0.gameset.levellimit_skintype.description

		getProxy = var_1_10004
		PlayerProxy = var_1_10006

		local var_4_4 = var_1_10004(var_1_10006)

		if var_4_2 >= var_4.getData(var_4_4).level then
			_ = var_1_10005
			var_4_1 = var_1_10005.filter(var_4_1, function(arg_5_0)
				pg = var_2_10001

				local var_5_0 = var_2_10001.ship_skin_template[arg_5_0:getSkinId()].shop_type_id

				table = var_2

				return var_2.contains(var_4_3, var_5_0)
			end)
		end
	end

	return var_4_1
end

function var_0_1.GetPlayer(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	return (var_1.getRawData(var_6_0))
end

function var_0_1.GetShopTypeIdBySkinId(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.ship_skin_template.get_id_list_by_shop_type_id

	if not var_0_1.shopTypeIdList then
		var_0_1.shopTypeIdList = {}
	end

	if var_0_1.shopTypeIdList[arg_7_1] then
		return var_0_1.shopTypeIdList[arg_7_1]
	end

	pairs = var_3

	for iter_7_0, iter_7_1 in var_3(var_7_0) do
		ipairs = var_1_10008

		for iter_7_2, iter_7_3 in var_1_10008(iter_7_1) do
			var_0_1.shopTypeIdList[iter_7_3] = iter_7_0

			if iter_7_3 == arg_7_1 then
				return iter_7_0
			end
		end
	end

	return
end

function var_0_1.GetSkinClassify(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = {}

	ipairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(arg_8_1) do
		local var_8_2

		if arg_8_0:GetShopTypeIdBySkinId(iter_8_1:getSkinId()) ~= 0 or not var_0_6 then
			var_8_2 = var_10
		end

		local var_8_3

		if not var_8_1[var_8_2] then
			var_8_3 = 0
		end

		var_8_1[var_8_2] = var_8_3 + 1
	end

	local var_8_4 = {}

	ipairs = var_6

	for iter_8_2, iter_8_3 in var_6(arg_8_0:GetReturnSkins()) do
		var_8_4[iter_8_3] = true
	end

	underscore = var_6

	if var_6.any(arg_8_1, function(arg_9_0)
		return var_8_4[arg_9_0.id]
	end) then
		table = var_6

		var_6.insert(var_8_0, var_0_4)
	end

	ipairs = var_6
	pg = var_8

	for iter_8_4, iter_8_5 in var_6(var_8.skin_page_template.all) do
		if iter_8_5 ~= var_0_7 and iter_8_5 ~= var_0_8 then
			local var_8_5

			if not var_8_1[iter_8_5] then
				var_8_5 = 0
			end

			if var_8_5 > 0 then
				table = var_8_5

				var_8_5.insert(var_8_0, iter_8_5)
			end
		end
	end

	if arg_8_2 == var_0_1.MODE_EXPERIENCE then
		table = var_6

		var_6.insert(var_8_0, 1, var_0_3)
	end

	if arg_8_2 == var_0_1.MODE_EXPERIENCE_FOR_ITEM then
		table = var_6

		var_6.insert(var_8_0, 1, var_0_5)
	end

	table = var_6

	var_6.insert(var_8_0, 1, var_0_2)

	return var_8_0
end

function var_0_1.GetReturnSkins(arg_10_0)
	if not arg_10_0.returnSkins then
		getProxy = var_1
		ShipSkinProxy = var_1_10003

		local var_10_0 = var_1(var_1_10003)

		arg_10_0.returnSkins = var_1.GetEncoreSkins(var_10_0)
	end

	return arg_10_0.returnSkins
end

function var_0_1.GetReturnSkinMap(arg_11_0)
	if not arg_11_0.encoreSkinMap then
		arg_11_0.encoreSkinMap = {}

		local var_11_0 = arg_11_0:GetReturnSkins()

		ipairs = var_1_10002

		for iter_11_0, iter_11_1 in var_1_10002(var_11_0) do
			arg_11_0.encoreSkinMap[iter_11_1] = true
		end
	end

	return arg_11_0.encoreSkinMap
end

function var_0_1.OnFurnitureUpdate(arg_12_0, arg_12_1)
	if not arg_12_0.mainView.commodity then
		return
	end

	local var_12_0 = arg_12_0.mainView.commodity.id

	Goods = var_1_10003

	if var_1_10003.ExistFurniture(var_12_0) then
		Goods = var_3

		if var_3.Id2FurnitureId(var_12_0) == arg_12_1 then
			local var_12_1 = arg_12_0.mainView

			var_3.Flush(var_12_1, arg_12_0.mainView.commodity)
		end
	end

	return
end

function var_0_1.OnShopping(arg_13_0, arg_13_1)
	if not arg_13_0.mainView.commodity then
		return
	end

	local var_13_0 = arg_13_0.mainView

	var_2.ClosePurchaseView(var_13_0)

	if arg_13_0.mainView.commodity.id == arg_13_1 then
		local var_13_1 = arg_13_0:GetAllCommodity()

		_ = var_1_10003

		if var_1_10003.detect(var_13_1, function(arg_14_0)
			return arg_14_0.id == arg_13_1
		end) then
			local var_13_2 = arg_13_0.mainView

			var_4.Flush(var_13_2, var_3)
		end

		arg_13_0:UpdateCouponBtn()
		arg_13_0:UpdateVoucherBtn()
		arg_13_0:UpdateCommodities(var_13_1, false)

		arg_13_0.commodities = var_13_1
	end

	return
end

function var_0_1.init(arg_15_0)
	local var_15_0 = arg_15_0._tf
	local var_15_1 = var_1.GetComponent

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	arg_15_0.cgGroup = var_15_1(var_15_0, var_1_10004(var_1_10006))

	local var_15_2 = arg_15_0._tf

	arg_15_0.backBtn = var_1.Find(var_15_2, "overlay/blur_panel/adapt/top/back_btn")

	local var_15_3 = arg_15_0._tf

	arg_15_0.atlasBtn = var_1.Find(var_15_3, "overlay/bottom/bg/atlas")

	local var_15_4 = arg_15_0._tf

	arg_15_0.prevBtn = var_1.Find(var_15_4, "overlay/bottom/bg/left_arr")

	local var_15_5 = arg_15_0._tf

	arg_15_0.nextBtn = var_1.Find(var_15_5, "overlay/bottom/bg/right_arr")

	local var_15_6 = arg_15_0._tf

	arg_15_0.live2dFilter = var_1.Find(var_15_6, "overlay/blur_panel/adapt/top/live2d")

	local var_15_7 = arg_15_0.live2dFilter

	arg_15_0.live2dFilterSel = var_1.Find(var_15_7, "selected")

	local var_15_8 = arg_15_0._tf

	arg_15_0.indexBtn = var_1.Find(var_15_8, "overlay/blur_panel/adapt/top/index_btn")

	local var_15_9 = arg_15_0.indexBtn

	arg_15_0.indexBtnSel = var_1.Find(var_15_9, "sel")

	local var_15_10 = arg_15_0._tf

	arg_15_0.inptuTr = var_1.Find(var_15_10, "overlay/blur_panel/adapt/top/search")

	local var_15_11 = arg_15_0._tf

	arg_15_0.changeBtn = var_1.Find(var_15_11, "overlay/blur_panel/adapt/top/change_btn")
	setText = var_1

	local var_15_12 = arg_15_0.inptuTr
	local var_15_13 = var_3.Find(var_15_12, "holder")

	i18n = var_4

	var_1(var_15_13, var_4("skinatlas_search_holder"))

	local var_15_14 = arg_15_0._tf

	arg_15_0.couponTr = var_1.Find(var_15_14, "overlay/blur_panel/adapt/top/discount/coupon")

	local var_15_15 = arg_15_0.couponTr

	arg_15_0.couponSelTr = var_1.Find(var_15_15, "selected")

	local var_15_16 = arg_15_0._tf

	arg_15_0.voucherTr = var_1.Find(var_15_16, "overlay/blur_panel/adapt/top/discount/voucher")

	local var_15_17 = arg_15_0.voucherTr

	arg_15_0.voucherSelTr = var_1.Find(var_15_17, "selected")
	RollingCircleRect = var_1

	local var_15_18 = var_1.New
	local var_15_19 = arg_15_0._tf
	local var_15_20 = var_3.Find(var_15_19, "overlay/left/mask/content/0")
	local var_15_21 = arg_15_0._tf

	arg_15_0.rollingCircleRect = var_15_18(var_15_20, var_4.Find(var_15_21, "overlay/left"))

	local var_15_22 = arg_15_0.rollingCircleRect

	var_1.SetCallback(var_15_22, arg_15_0, var_0_1.OnSelectSkinPage, var_0_1.OnConfirmSkinPage)

	local var_15_23 = arg_15_0._tf

	arg_15_0.rollingCircleMaskTr = var_1.Find(var_15_23, "overlay/left")
	NewSkinShopMainView = var_1
	arg_15_0.mainView = var_1.New(arg_15_0._tf, arg_15_0.event, arg_15_0.contextData)

	local var_15_24 = arg_15_0._tf
	local var_15_25 = var_1.Find(var_15_24, "overlay/blur_panel/adapt/top/title")
	local var_15_26 = var_1.GetComponent

	typeof = var_4
	Image = var_6
	arg_15_0.title = var_15_26(var_15_25, var_4(var_6))

	local var_15_27 = arg_15_0._tf
	local var_15_28 = var_1.Find(var_15_27, "overlay/blur_panel/adapt/top/title_en")
	local var_15_29 = var_1.GetComponent

	typeof = var_4
	Image = var_6
	arg_15_0.titleEn = var_15_29(var_15_28, var_4(var_6))

	local var_15_30 = arg_15_0._tf
	local var_15_31 = var_1.Find(var_15_30, "overlay/bottom/scroll")

	arg_15_0.scrollrect = var_1.GetComponent(var_15_31, "LScrollRect")
	arg_15_0.scrollrect.isNewLoadingMethod = true

	function arg_15_0.scrollrect.onInitItem(arg_16_0)
		local var_16_0 = arg_15_0

		var_1.OnInitItem(var_16_0, arg_16_0)

		return
	end

	function arg_15_0.scrollrect.onUpdateItem(arg_17_0, arg_17_1)
		local var_17_0 = arg_15_0

		var_2.OnUpdateItem(var_17_0, arg_17_0, arg_17_1)

		return
	end

	local var_15_32 = arg_15_0._tf

	arg_15_0.emptyTr = var_1.Find(var_15_32, "bgs/empty")

	local var_15_33 = {}

	ShipIndexConst = var_2
	var_15_33.typeIndex = var_2.TypeAll
	ShipIndexConst = var_2
	var_15_33.campIndex = var_2.CampAll
	ShipIndexConst = var_2
	var_15_33.rarityIndex = var_2.RarityAll
	SkinIndexLayer = var_2
	var_15_33.extraIndex = var_2.ExtraALL
	arg_15_0.defaultIndex = var_15_33
	Input = var_15_33
	var_15_33.multiTouchEnabled = false

	return
end

function var_0_1.didEnter(arg_18_0)
	onButton = var_1_10001

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.backBtn

	local function var_18_2()
		local var_19_0 = arg_18_0

		var_0.emit(var_19_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_18_0, var_18_1, var_18_2, var_1_10006)

	onButton = var_1_10001

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.atlasBtn

	local function var_18_5()
		local var_20_0 = arg_18_0
		local var_20_1 = var_0.emit

		NewSkinShopMediator = var_2_10003

		var_20_1(var_20_0, var_2_10003.ON_ATLAS)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_3, var_18_4, var_18_5, var_1_10006)

	onButton = var_1_10001

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0.prevBtn

	local function var_18_8()
		local var_21_0 = arg_18_0

		var_0.OnPrevCommodity(var_21_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_6, var_18_7, var_18_8, var_1_10006)

	onButton = var_1_10001

	local var_18_9 = arg_18_0
	local var_18_10 = arg_18_0.nextBtn

	local function var_18_11()
		local var_22_0 = arg_18_0

		var_0.OnNextCommodity(var_22_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_9, var_18_10, var_18_11, var_1_10006)

	onButton = var_1_10001

	local var_18_12 = arg_18_0
	local var_18_13 = arg_18_0.indexBtn

	local function var_18_14()
		local var_23_0 = arg_18_0
		local var_23_1 = var_0.emit

		NewSkinShopMediator = var_2_10003

		var_23_1(var_23_0, var_2_10003.ON_INDEX, {
			OnFilter = function(arg_24_0)
				local var_24_0 = arg_18_0

				var_1.OnFilter(var_24_0, arg_24_0)

				return
			end,
			defaultIndex = arg_18_0.defaultIndex
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_12, var_18_13, var_18_14, var_1_10006)

	onInputChanged = var_1_10001

	var_1_10001(arg_18_0, arg_18_0.inptuTr, function()
		local var_25_0 = arg_18_0

		var_0.OnSearch(var_25_0)

		return
	end)

	onToggle = var_1_10001

	local var_18_15 = arg_18_0
	local var_18_16 = arg_18_0.changeBtn

	local function var_18_17(arg_26_0)
		if arg_26_0 then
			getInputText = var_2_10001

			if var_2_10001(arg_18_0.inptuTr) ~= "" then
				setInputText = var_1

				var_1(arg_18_0.inptuTr, "")
			end
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_15, var_18_16, var_18_17, var_1_10006)

	onButton = var_1_10001

	local var_18_18 = arg_18_0
	local var_18_19 = arg_18_0.live2dFilter

	local function var_18_20()
		local var_27_0 = arg_18_0.defaultIndex
		local var_27_1 = arg_18_0.defaultIndex.extraIndex

		SkinIndexLayer = var_2_10002

		if var_27_1 == var_2_10002.ExtraL2D then
			SkinIndexLayer = var_27_1

			if not var_27_1.ExtraALL then
				SkinIndexLayer = var_27_1
				var_27_1 = var_27_1.ExtraL2D
			end

			var_27_0.extraIndex = var_27_1

			local var_27_2 = arg_18_0

			var_0.OnFilter(var_27_2, arg_18_0.defaultIndex)

			return
		end
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_18, var_18_19, var_18_20, var_1_10006)

	arg_18_0.isFilterCoupon = false
	onButton = var_1

	local var_18_21 = arg_18_0
	local var_18_22 = arg_18_0.couponTr

	local function var_18_23()
		SkinCouponActivity = var_2_10000

		if not var_2_10000.StaticExistActivityAndCoupon() then
			arg_18_0.isFilterCoupon = false

			local var_28_0 = arg_18_0

			var_0.UpdateCouponBtn(var_28_0)

			pg = var_0

			local var_28_1 = var_0.TipsMgr.GetInstance()
			local var_28_2 = var_0.ShowTips

			i18n = var_2_10003

			var_28_2(var_28_1, var_2_10003("common_activity_end"))

			return
		end

		local var_28_3 = arg_18_0

		var_28_3.isFilterCoupon = not arg_18_0.isFilterCoupon
		setActive = var_28_3

		var_28_3(arg_18_0.couponSelTr, arg_18_0.isFilterCoupon)

		local var_28_4 = arg_18_0

		var_0.OnFilter(var_28_4, arg_18_0.defaultIndex)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_18_21, var_18_22, var_18_23, var_1_10006)

	arg_18_0.isFilterVoucher = false
	onButton = var_1

	local var_18_24 = arg_18_0
	local var_18_25 = arg_18_0.voucherTr

	local function var_18_26()
		local var_29_0 = arg_18_0

		var_29_0.isFilterVoucher = not arg_18_0.isFilterVoucher
		setActive = var_29_0

		var_29_0(arg_18_0.voucherSelTr, arg_18_0.isFilterVoucher)

		local var_29_1 = arg_18_0

		var_0.OnFilter(var_29_1, arg_18_0.defaultIndex)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_18_24, var_18_25, var_18_26, var_1_10006)

	local var_18_27 = arg_18_0

	arg_18_0.SetUp(var_18_27)

	getProxy = var_1
	CommanderManualProxy = var_18_27

	local var_18_28 = var_1(var_18_27)

	var_1.TaskProgressAdd(var_18_28, 2021, 1)

	return
end

function var_0_1.UpdateCouponBtn(arg_30_0)
	SkinCouponActivity = var_1_10001

	local var_30_0

	if var_1_10001.StaticExistActivityAndCoupon() then
		var_30_0 = not arg_30_0.contextData.mode or arg_30_0.contextData.mode == var_0_1.MODE_OVERVIEW
	end

	tobool = var_1_10002

	local var_30_1

	if var_1_10002(arg_30_0.isFilterCoupon) then
		var_30_1 = var_30_0
	end

	arg_30_0.isFilterCoupon = var_30_1

	local var_30_2 = arg_30_0.couponTr

	if var_30_0 then
		Vector3 = var_1_10003

		if not var_1_10003(1, 1, 1) then
			Vector3 = var_1_10003
			var_1_10003 = var_1_10003(0, 0, 0)
		end

		var_30_2.localScale = var_1_10003

		return
	end
end

function var_0_1.UpdateVoucherBtn(arg_31_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003

	local var_31_0 = var_1_10001(var_1_10003)
	local var_31_1 = #var_1.GetSkinShopDiscountItemList(var_31_0)
	local var_31_2 = 0 < var_31_1 and (not arg_31_0.contextData.mode or arg_31_0.contextData.mode == var_0_1.MODE_OVERVIEW)

	tobool = var_3

	local var_31_3

	if var_3(arg_31_0.isFilterVoucher) then
		var_31_3 = var_31_2
	end

	arg_31_0.isFilterVoucher = var_31_3

	local var_31_4 = arg_31_0.voucherTr

	if var_31_2 then
		Vector3 = var_1_10004

		if not var_1_10004(1, 1, 1) then
			Vector3 = var_1_10004
			var_1_10004 = var_1_10004(0, 0, 0)
		end

		var_31_4.localScale = var_1_10004

		return
	end
end

function var_0_1.OnSelectSkinPage(arg_32_0, arg_32_1)
	if arg_32_0.selectedSkinPageItem then
		setActive = var_2

		local var_32_0 = arg_32_0.selectedSkinPageItem._tr

		var_2(var_4.Find(var_32_0, "selected"), false)

		setActive = var_2

		local var_32_1 = arg_32_0.selectedSkinPageItem._tr

		var_2(var_4.Find(var_32_1, "name"), true)
	end

	setActive = var_2

	local var_32_2 = arg_32_1._tr

	var_2(var_4.Find(var_32_2, "selected"), true)

	setActive = var_2

	local var_32_3 = arg_32_1._tr

	var_2(var_4.Find(var_32_3, "name"), false)

	arg_32_0.selectedSkinPageItem = arg_32_1

	return
end

function var_0_1.OnConfirmSkinPage(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1:GetID()

	if arg_33_0.skinPageID ~= var_33_0 then
		arg_33_0.skinPageID = var_33_0

		if arg_33_0.commodities then
			arg_33_0:UpdateCommodities(arg_33_0.commodities, true)
		end
	end

	return
end

function var_0_1.OnFilter(arg_34_0, arg_34_1)
	arg_34_0.defaultIndex = {
		typeIndex = arg_34_1.typeIndex,
		campIndex = arg_34_1.campIndex,
		rarityIndex = arg_34_1.rarityIndex,
		extraIndex = arg_34_1.extraIndex
	}
	setActive = var_2

	local var_34_0 = arg_34_0.live2dFilterSel
	local var_34_1 = arg_34_1.extraIndex

	SkinIndexLayer = var_1_10006

	var_2(var_34_0, var_34_1 == var_1_10006.ExtraL2D)

	if arg_34_0.commodities then
		arg_34_0:UpdateCommodities(arg_34_0.commodities, true)
	end

	setActive = var_2

	local var_34_2 = arg_34_0.indexBtnSel
	local var_34_3 = arg_34_1.typeIndex

	ShipIndexConst = var_6

	local var_34_7

	if var_34_3 == var_6.TypeAll then
		local var_34_4 = arg_34_1.campIndex

		ShipIndexConst = var_6

		if var_34_4 == var_6.CampAll then
			local var_34_5 = arg_34_1.rarityIndex

			ShipIndexConst = var_6

			if var_34_5 == var_6.RarityAll then
				local var_34_6 = arg_34_1.extraIndex

				SkinIndexLayer = var_6

				if var_34_6 == var_6.ExtraALL then
					var_34_7 = false

					goto label_34_0
				end
			end
		end
	end

	var_34_7 = true

	::label_34_0::

	var_2(var_34_2, var_34_7)

	return
end

function var_0_1.OnSearch(arg_35_0)
	if arg_35_0.commodities then
		arg_35_0:UpdateCommodities(arg_35_0.commodities, true)
	end

	return
end

function var_0_1.GetDefaultPage(arg_36_0, arg_36_1)
	if arg_36_1 == var_0_1.MODE_EXPERIENCE then
		return var_0_3
	elseif arg_36_1 == var_0_1.MODE_EXPERIENCE_FOR_ITEM then
		return var_0_5
	else
		local var_36_0

		if not arg_36_0.contextData.page or not arg_36_0.contextData.page then
			var_36_0 = var_0_2
		end

		return var_36_0
	end

	return
end

function var_0_1.SetUp(arg_37_0)
	local var_37_0

	if not arg_37_0.contextData.mode then
		var_37_0 = var_0_1.MODE_OVERVIEW
	end

	arg_37_0.mode = var_37_0

	local var_37_1 = arg_37_0:GetAllCommodity()

	arg_37_0.cgGroup.blocksRaycasts = false

	arg_37_0:UpdateTitle(var_37_0)
	arg_37_0:UpdateCouponBtn()
	arg_37_0:UpdateVoucherBtn()

	setActive = var_3

	var_3(arg_37_0.rollingCircleMaskTr, var_37_0 == var_0_1.MODE_OVERVIEW)

	if var_37_0 == var_0_1.MODE_EXPERIENCE or var_37_0 == var_0_1.MODE_EXPERIENCE_FOR_ITEM then
		getProxy = var_3
		SettingsProxy = var_5

		local var_37_2 = var_3(var_5)

		var_3.SetNextTipTimeLimitSkinShop(var_37_2)
	end

	arg_37_0.skinPageID = arg_37_0:GetDefaultPage(var_37_0)
	parallelAsync = var_3

	var_3({
		function(arg_38_0)
			local var_38_0 = arg_37_0

			var_1.InitSkinClassify(var_38_0, var_37_1, var_37_0, arg_38_0)

			return
		end,
		function(arg_39_0)
			seriesAsync = var_2_10001

			var_2_10001({
				function(arg_40_0)
					onNextTick = var_3_10001

					var_3_10001(arg_40_0)

					return
				end,
				function(arg_41_0)
					if arg_37_0.exited then
						return
					end

					local var_41_0 = arg_37_0

					var_1.UpdateCommodities(var_41_0, var_37_1, true, arg_41_0)

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

function var_0_1.UpdateTitle(arg_43_0, arg_43_1)
	local var_43_0 = {
		"huanzhuangshagndian",
		"title_01",
		"title_01"
	}
	local var_43_1 = arg_43_0.title

	GetSpriteFromAtlas = var_1_10004
	var_43_1.sprite = var_1_10004("ui/SkinShopUI_atlas", var_43_0[arg_43_1])

	local var_43_2 = arg_43_0.title

	var_3.SetNativeSize(var_43_2)

	local var_43_3 = {
		"huanzhuangshagndian_en",
		"title_en_01",
		"title_en_01"
	}
	local var_43_4 = arg_43_0.titleEn

	GetSpriteFromAtlas = var_43_2
	var_43_4.sprite = var_43_2("ui/SkinShopUI_atlas", var_43_3[arg_43_1])

	local var_43_5 = arg_43_0.titleEn

	var_4.SetNativeSize(var_43_5)

	return
end

local function var_0_9(arg_44_0, arg_44_1)
	pg = var_1_10002

	local var_44_0 = var_1_10002.skin_page_template
	local var_44_1 = arg_44_1:GetID()
	local var_44_2
	local var_44_3
	local var_44_4

	if var_44_1 == var_0_2 or var_44_1 == var_0_3 or var_44_1 == var_0_5 then
		var_44_4 = "text_all"
		var_44_3 = "ALL"
		var_44_2 = var_44_4
	elseif var_44_1 == var_0_4 then
		var_44_4 = "text_fanchang"
		var_44_3 = "RETURN"
		var_44_2 = var_44_4
	else
		var_44_4 = "text_" .. var_44_0[var_44_1].res
		var_44_3 = var_44_0[var_44_1].english_name
		var_44_2 = var_44_4
	end

	LoadSpriteAtlasAsync = var_44_4

	var_44_4("SkinClassified", var_44_2 .. "01", function(arg_45_0)
		if arg_44_0.exited then
			return
		end

		local var_45_0 = arg_44_1._tr
		local var_45_1 = var_1.Find(var_45_0, "name")
		local var_45_2 = var_1.GetComponent

		typeof = var_4
		Image = var_2_10006

		local var_45_3 = var_45_2(var_45_1, var_4(var_2_10006))

		var_45_3.sprite = arg_45_0

		var_45_3:SetNativeSize()

		return
	end)

	LoadSpriteAtlasAsync = var_44_4

	var_44_4("SkinClassified", var_44_2, function(arg_46_0)
		if arg_44_0.exited then
			return
		end

		local var_46_0 = arg_44_1._tr
		local var_46_1 = var_1.Find(var_46_0, "selected/Image")
		local var_46_2 = var_1.GetComponent

		typeof = var_4
		Image = var_2_10006

		local var_46_3 = var_46_2(var_46_1, var_4(var_2_10006))

		var_46_3.sprite = arg_46_0

		var_46_3:SetNativeSize()

		return
	end)

	setText = var_44_4

	local var_44_5 = arg_44_1._tr

	var_44_4(var_8.Find(var_44_5, "eng"), var_44_3)

	return
end

function var_0_1.InitSkinClassify(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = arg_47_0
	local var_47_1 = arg_47_0.GetSkinClassify(var_47_0, arg_47_1, arg_47_2)
	local var_47_2 = {}

	ipairs = var_47_0

	for iter_47_0, iter_47_1 in var_47_0(var_47_1) do
		table = var_1_10011

		var_1_10011.insert(var_47_2, function(arg_48_0)
			if arg_47_0.exited then
				return
			end

			local var_48_0 = arg_47_0.rollingCircleRect
			local var_48_1 = var_1.AddItem(var_48_0, iter_47_1)

			var_0_9(arg_47_0, var_48_1)

			if (iter_47_0 - 1) % 5 == 0 or iter_47_0 == #var_47_1 then
				onNextTick = var_2

				var_2(arg_48_0)
			else
				arg_48_0()
			end

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_47_2, function()
		if arg_47_0.exited then
			return
		end

		local var_49_0 = arg_47_0.rollingCircleRect

		var_0.ScrollTo(var_49_0, arg_47_0.skinPageID)
		arg_47_3()

		return
	end)

	return
end

local function var_0_10(arg_50_0)
	local var_50_0

	if not var_0_1.cacheSkinExperienceItems then
		var_50_0 = var_0_1
		getProxy = var_1_10002
		BagProxy = var_1_10004

		local var_50_1 = var_1_10002(var_1_10004)

		var_50_0.cacheSkinExperienceItems = var_2.GetSkinExperienceItems(var_50_1)
	end

	_ = var_50_0

	return var_50_0.any(var_0_1.cacheSkinExperienceItems, function(arg_51_0)
		return arg_51_0:CanUseForShop(arg_50_0)
	end)
end

function var_0_1.IsType(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_2:getConfig("genre")

	ShopArgs = var_1_10004

	if var_52_0 == var_1_10004.SkinShopTimeLimit then
		if arg_52_0.mode == var_0_1.MODE_EXPERIENCE_FOR_ITEM then
			return arg_52_1 == var_0_5 and var_0_10(arg_52_2.id)
		else
			return arg_52_1 == var_0_3
		end
	elseif arg_52_1 == var_0_2 then
		return true
	elseif arg_52_1 == var_0_4 and arg_52_0:GetReturnSkinMap()[arg_52_2.id] then
		return true
	else
		local var_52_1

		if arg_52_0:GetShopTypeIdBySkinId(arg_52_2:getSkinId()) ~= 0 or not var_0_6 then
			var_52_1 = var_3
		end

		return var_52_1 == arg_52_1
	end

	return false
end

function var_0_1.ToVShip(arg_53_0, arg_53_1)
	if not arg_53_0.vship then
		arg_53_0.vship = {}

		function arg_53_0.vship.getNation()
			return arg_53_0.vship.config.nationality
		end

		function arg_53_0.vship.getShipType()
			return arg_53_0.vship.config.type
		end

		function arg_53_0.vship.getTeamType()
			ShipType = var_2_10000

			return var_2_10000.GetTeamFromShipType(arg_53_0.vship.config.type)
		end

		function arg_53_0.vship.getRarity()
			return arg_53_0.vship.config.rarity
		end
	end

	arg_53_0.vship.config = arg_53_1

	return arg_53_0.vship
end

function var_0_1.IsAllFilter(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1.typeIndex

	ShipIndexConst = var_1_10003

	if var_58_0 == var_1_10003.TypeAll then
		local var_58_1 = arg_58_1.campIndex

		ShipIndexConst = var_3

		if var_58_1 == var_3.CampAll then
			local var_58_2 = arg_58_1.rarityIndex

			ShipIndexConst = var_3

			if var_58_2 == var_3.RarityAll then
				local var_58_3 = arg_58_1.extraIndex

				SkinIndexLayer = var_3

				local var_58_4

				if var_58_3 ~= var_3.ExtraALL then
					var_58_4 = false
				else
					var_58_4 = true
				end

				return var_58_4
			end
		end
	end
end

function var_0_1.IsFilterType(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_0:IsAllFilter(arg_59_1) then
		return true
	end

	local var_59_0 = arg_59_2:getSkinId()

	ShipSkin = var_1_10004

	local var_59_1 = var_1_10004.New({
		id = var_59_0
	})

	if not var_4.GetDefaultShipConfig(var_59_1) then
		return false
	end

	local var_59_2 = arg_59_0
	local var_59_3 = arg_59_0.ToVShip(var_59_2, var_5)

	ShipIndexConst = var_59_1

	local var_59_4 = var_59_1.filterByType(var_59_3, arg_59_1.typeIndex)

	ShipIndexConst = var_59_2

	local var_59_5 = var_59_2.filterByCamp(var_59_3, arg_59_1.campIndex)

	ShipIndexConst = var_9

	local var_59_6 = var_9.filterByRarity(var_59_3, arg_59_1.rarityIndex)

	SkinIndexLayer = var_10

	local var_59_7 = var_10.filterByExtra(var_4, arg_59_1.extraIndex)

	return var_59_4 and var_59_5 and var_59_6 and var_59_7
end

function var_0_1.IsSearchType(arg_60_0, arg_60_1, arg_60_2)
	if not arg_60_1 or arg_60_1 == "" then
		return true
	end

	local var_60_0 = arg_60_2:getSkinId()

	ShipSkin = var_1_10004

	local var_60_1 = var_1_10004.New({
		id = var_60_0
	})

	return var_4.IsMatchKey(var_60_1, arg_60_1)
end

local function var_0_11(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_2[arg_61_0.id] == arg_61_2[arg_61_1.id] then
		return arg_61_0.id < arg_61_1.id
	else
		return var_4 < var_3
	end

	return
end

function var_0_1.Sort(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	if (arg_62_1.buyCount == 0 and 1 or 0) == (arg_62_2.buyCount == 0 and 1 or 0) then
		if arg_62_1:getConfig("order") == arg_62_2:getConfig("order") then
			return var_0_11(arg_62_1, arg_62_2, arg_62_3)
		else
			return var_6 < var_7
		end
	else
		return var_5 < var_4
	end

	return
end

function var_0_1.IsCouponType(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_1 then
		SkinCouponActivity = var_1_10003

		if not var_1_10003.GetBestReadySkinCouponAct(arg_63_2.id) then
			return false
		end
	end

	return true
end

function var_0_1.IsVoucherType(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_1 and not arg_64_2 then
		return false
	end

	return true
end

function var_0_1.UpdateCommodities(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_0:ClearCards()

	arg_65_0.cards = {}
	arg_65_0.displays = {}
	arg_65_0.canUseVoucherCache = {}
	getInputText = var_4

	local var_65_0 = var_4(arg_65_0.inptuTr)

	getProxy = var_1_10005
	BagProxy = var_1_10007

	local var_65_1 = var_1_10005(var_1_10007)
	local var_65_2 = var_5.GetSkinShopDiscountItemList(var_65_1)

	ipairs = var_6

	for iter_65_0, iter_65_1 in var_6(arg_65_1) do
		var_1_10013 = iter_65_1

		local var_65_3 = iter_65_1.StaticCanUseVoucherType(var_1_10013, var_65_2)

		if arg_65_0:IsType(arg_65_0.skinPageID, iter_65_1) and arg_65_0:IsFilterType(arg_65_0.defaultIndex, iter_65_1) and arg_65_0:IsSearchType(var_65_0, iter_65_1) and arg_65_0:IsCouponType(arg_65_0.isFilterCoupon, iter_65_1) and arg_65_0:IsVoucherType(arg_65_0.isFilterVoucher, var_65_3) then
			table = var_12

			var_12.insert(arg_65_0.displays, iter_65_1)
		end

		arg_65_0.canUseVoucherCache[iter_65_1.id] = var_65_3
	end

	local var_65_4 = {}

	ipairs = var_7

	for iter_65_2, iter_65_3 in var_7(arg_65_0.displays) do
		local var_65_5 = iter_65_3.type

		Goods = var_1_10013

		local var_65_7

		if var_65_5 ~= var_1_10013.TYPE_ACTIVITY then
			local var_65_6 = iter_65_3.type

			Goods = var_1_10013

			if var_65_6 ~= var_1_10013.TYPE_ACTIVITY_EXTRA then
				var_65_7 = false

				goto label_65_0
			end
		end

		var_65_7 = true

		::label_65_0::

		var_1_10013 = 0

		if not var_65_7 then
			var_1_10013 = iter_65_3:GetPrice()
		end

		var_65_4[iter_65_3.id] = var_1_10013
	end

	table = var_7

	var_7.sort(arg_65_0.displays, function(arg_66_0, arg_66_1)
		local var_66_0 = arg_65_0

		return var_2.Sort(var_66_0, arg_66_0, arg_66_1, var_65_4)
	end)

	if arg_65_2 then
		arg_65_0.triggerFirstCard = true

		local var_65_8 = arg_65_0.scrollrect

		var_7.SetTotalCount(var_65_8, #arg_65_0.displays, 0)
	else
		local var_65_9 = arg_65_0.scrollrect

		var_7.SetTotalCount(var_65_9, #arg_65_0.displays)
	end

	local var_65_10 = #arg_65_0.displays <= 0

	setActive = var_8

	var_8(arg_65_0.emptyTr, var_65_10)

	if var_65_10 then
		local var_65_11 = arg_65_0.mainView

		var_8.Flush(var_65_11, nil)
	end

	if arg_65_3 then
		arg_65_3()
	end

	return
end

function var_0_1.OnInitItem(arg_67_0, arg_67_1)
	NewShopSkinCard = var_1_10002

	local var_67_0 = var_1_10002.New(arg_67_1)

	onButton = var_1_10003

	local var_67_1 = arg_67_0
	local var_67_2 = var_67_0._go

	local function var_67_3()
		if not var_67_0.commodity then
			return
		end

		pairs = var_0

		for iter_68_0, iter_68_1 in var_0(arg_67_0.cards) do
			iter_68_1:UpdateSelected(false)
		end

		arg_67_0.selectedId = var_67_0.commodity.id

		local var_68_0 = var_67_0

		var_0.UpdateSelected(var_68_0, true)

		local var_68_1 = arg_67_0

		var_0.UpdateMainView(var_68_1, var_67_0.commodity)

		local var_68_2 = arg_67_0

		var_0.GCHandle(var_68_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_67_1, var_67_2, var_67_3, var_1_10008)

	arg_67_0.cards[arg_67_1] = var_67_0

	return
end

function var_0_1.OnUpdateItem(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0

	if not arg_69_0.cards[arg_69_2] then
		arg_69_0:OnInitItem(arg_69_2)

		var_69_0 = arg_69_0.cards[arg_69_2]
	end

	if not arg_69_0.displays[arg_69_1 + 1] then
		return
	end

	local var_69_1 = arg_69_0.selectedId == var_4.id
	local var_69_2 = arg_69_0:GetReturnSkinMap()[var_4.id]

	var_69_0:Update(var_4, var_69_1, var_69_2)

	if arg_69_0.triggerFirstCard and arg_69_1 == 0 then
		arg_69_0.triggerFirstCard = nil
		triggerButton = var_8

		var_8(var_69_0._go)
	end

	return
end

function var_0_1.GCHandle(arg_70_0)
	local var_70_0 = var_0_1
	local var_70_1

	if not var_0_1.GCCNT then
		var_70_1 = 0
	end

	var_70_0.GCCNT = var_70_1 + 1

	if var_0_1.GCCNT == 3 then
		gcAll = var_1

		var_1()

		var_0_1.GCCNT = 0
	end

	return
end

function var_0_1.UpdateMainView(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0.mainView

	var_2.Flush(var_71_0, arg_71_1)

	return
end

function var_0_1.GetCommodityIndex(arg_72_0, arg_72_1)
	ipairs = var_1_10002

	for iter_72_0, iter_72_1 in var_1_10002(arg_72_0.displays) do
		if iter_72_1.id == arg_72_1 then
			return iter_72_0
		end
	end

	return
end

function var_0_1.OnPrevCommodity(arg_73_0)
	if not arg_73_0.selectedId then
		return
	end

	if arg_73_0:GetCommodityIndex(arg_73_0.selectedId) - 1 > 0 then
		arg_73_0:TriggerCommodity(var_1, -1)
	end

	return
end

function var_0_1.OnNextCommodity(arg_74_0)
	if not arg_74_0.selectedId then
		return
	end

	if arg_74_0:GetCommodityIndex(arg_74_0.selectedId) + 1 <= #arg_74_0.displays then
		arg_74_0:TriggerCommodity(var_1, 1)
	end

	return
end

function var_0_1.CheckCardBound(arg_75_0, arg_75_1, arg_75_2, arg_75_3, arg_75_4)
	getBounds = var_1_10005

	local var_75_0 = var_1_10005(arg_75_0.scrollrect.gameObject.transform)
	local var_75_1

	if arg_75_3 then
		getBounds = var_1_10006
		var_1_10006 = var_1_10006(arg_75_2._tf)
		getBounds = var_75_1
		var_75_1 = var_75_1(arg_75_1._tf)
		math = var_8

		if var_8.ceil(var_75_1:GetMax().x - var_75_0:GetMax().x) > var_1_10006.size.x then
			local var_75_2 = arg_75_0.scrollrect
			local var_75_3 = var_8.HeadIndexToValue(var_75_2, arg_75_4 - 1)
			local var_75_4 = arg_75_0.scrollrect
			local var_75_5 = var_75_3 - var_9.HeadIndexToValue(var_75_4, arg_75_4)
			local var_75_6 = arg_75_0.scrollrect.value - var_75_5
			local var_75_7 = arg_75_0.scrollrect

			var_10.SetNormalizedPosition(var_75_7, var_75_6, 0)
		end
	else
		getBounds = var_1_10006

		local var_75_8 = var_1_10006(arg_75_1._tf)

		getBounds = var_75_1

		local var_75_9 = var_75_1(arg_75_1._tf.parent)

		if var_7.GetMin(var_75_9).x < var_75_0:GetMin().x and var_75_8:GetMin().x < var_75_0:GetMin().x then
			local var_75_10 = arg_75_0.scrollrect
			local var_75_11 = var_8.HeadIndexToValue(var_75_10, arg_75_4 - 1)
			local var_75_12 = arg_75_0.scrollrect

			var_9.SetNormalizedPosition(var_75_12, var_75_11, 0)
		end
	end

	return
end

function var_0_1.TriggerCommodity(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0 = arg_76_0.displays[arg_76_1]
	local var_76_1 = arg_76_0.displays[arg_76_1 + arg_76_2]
	local var_76_2
	local var_76_3

	pairs = var_1_10007

	for iter_76_0, iter_76_1 in var_1_10007(arg_76_0.cards) do
		if iter_76_1._tf.gameObject.name ~= "-1" then
			if iter_76_1.commodity.id == var_76_1.id then
				var_76_2 = iter_76_1
			elseif iter_76_1.commodity.id == var_76_0.id then
				var_76_3 = iter_76_1
			end
		end
	end

	if var_76_2 then
		triggerButton = var_7

		var_7(var_76_2._tf)
	end

	if var_76_2 and var_76_3 then
		arg_76_0:CheckCardBound(var_76_2, var_76_3, arg_76_2 > 0, arg_76_1 + arg_76_2)
	end

	return
end

function var_0_1.ClearCards(arg_77_0)
	if not arg_77_0.cards then
		return
	end

	pairs = var_1

	for iter_77_0, iter_77_1 in var_1(arg_77_0.cards) do
		iter_77_1:Dispose()
	end

	arg_77_0.cards = nil

	return
end

function var_0_1.willExit(arg_78_0)
	arg_78_0:ClearCards()

	ClearLScrollrect = var_1

	var_1(arg_78_0.scrollrect)

	if arg_78_0.rollingCircleRect then
		local var_78_0 = arg_78_0.rollingCircleRect

		var_1.Dispose(var_78_0)

		arg_78_0.rollingCircleRect = nil
	end

	Input = var_1
	var_1.multiTouchEnabled = true

	if arg_78_0.mainView then
		local var_78_1 = arg_78_0.mainView

		var_1.Dispose(var_78_1)

		arg_78_0.mainView = nil
	end

	var_0_1.shopTypeIdList = nil
	var_0_1.cacheSkinExperienceItems = nil

	return
end

return var_0_1
