class = var_0_10000

local var_0_0 = "SupplyShopView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.supplyShopType = arg_1_4

	return
end

function var_0_1.getUIName(arg_2_0)
	return "ShopSupplyShopUI"
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:initData()

	local var_3_0 = arg_3_0

	arg_3_0.initUI(var_3_0)

	arg_3_0.prevBtn = nil

	local var_3_1 = {}

	ShopConst = var_3_0

	local var_3_2 = var_3_0.TYPE_ACTIVITY

	ActivityShopPage = var_1_10003
	var_3_1[var_3_2] = var_1_10003.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_2

	local var_3_3 = var_3_2.TYPE_SHOP_STREET

	StreetShopPage = var_3
	var_3_1[var_3_3] = var_3.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_3

	local var_3_4 = var_3_3.TYPE_MILITARY_SHOP

	MilitaryShopPage = var_3
	var_3_1[var_3_4] = var_3.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_4

	local var_3_5 = var_3_4.TYPE_GUILD

	GuildShopPage = var_3
	var_3_1[var_3_5] = var_3.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_5

	local var_3_6 = var_3_5.TYPE_SHAM_SHOP

	ShamShopPage = var_3
	var_3_1[var_3_6] = var_3.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_6

	local var_3_7 = var_3_6.TYPE_FRAGMENT

	FragmentShopPage = var_3
	var_3_1[var_3_7] = var_3.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_7

	local var_3_8 = var_3_7.TYPE_META

	MetaShopPage = var_3
	var_3_1[var_3_8] = var_3.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_8

	local var_3_9 = var_3_8.TYPE_MEDAL

	MedalShopPage = var_3
	var_3_1[var_3_9] = var_3.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_9

	local var_3_10 = var_3_9.TYPE_QUOTA

	QuotaShopPage = var_3
	var_3_1[var_3_10] = var_3.New(arg_3_0, arg_3_0._go)
	ShopConst = var_3_10

	local var_3_11 = var_3_10.TYPE_MINI_GAME

	MiniGameShopPage = var_3
	var_3_1[var_3_11] = var_3.New(arg_3_0, arg_3_0._go)
	arg_3_0.pages = var_3_1
	arg_3_0.shopResItemList = {}

	local var_3_12 = arg_3_0._tf

	arg_3_0.shopResParent = var_1.Find(var_3_12, "bg/resList")

	local var_3_13 = arg_3_0._tf

	arg_3_0.shopResItem = var_1.Find(var_3_13, "bg/resList/res")

	arg_3_0:blurView()

	return
end

function var_0_1.OnDestroy(arg_4_0)
	arg_4_0:unBlurView()

	arg_4_0.prevBtn = nil

	if arg_4_0.page then
		local var_4_0 = arg_4_0.page

		var_1.StopBGM(var_4_0)

		arg_4_0.page = nil
	end

	arg_4_0:DestroyResItemList()

	pairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.pages) do
		iter_4_1:OnDestroy()
	end

	arg_4_0.pages = nil

	return
end

function var_0_1.initUI(arg_5_0)
	GetComponent = var_1_10001

	local var_5_0 = arg_5_0._tf

	arg_5_0.lScrollRect = var_1_10001(var_2.Find(var_5_0, "scroll"), "LScrollRect")

	local var_5_1 = arg_5_0._tf

	arg_5_0.scrollContent = var_1.Find(var_5_1, "scroll/content")
	GetComponent = var_1

	local var_5_2 = arg_5_0.scrollContent

	typeof = var_3
	RectTransform = var_4
	arg_5_0.scrollRectTF = var_1(var_5_2, var_3(var_4))
	GetComponent = var_1

	local var_5_3 = arg_5_0.scrollContent

	typeof = var_3
	GridLayoutGroup = var_4
	arg_5_0.layoutGroup = var_1(var_5_3, var_3(var_4))

	local var_5_4 = arg_5_0._tf

	arg_5_0.scrollRectSpecial = var_1.Find(var_5_4, "scrollRectSpecial")
	setActive = var_1

	var_1(arg_5_0.scrollRectSpecial, false)

	GetComponent = var_1

	local var_5_5 = arg_5_0.scrollRectSpecial
	local var_5_6 = var_2.Find(var_5_5, "viewport/view/group/items")

	typeof = var_5_5
	GridLayoutGroup = var_4

	local var_5_7 = var_1(var_5_6, var_5_5(var_4))
	local var_5_8 = arg_5_0.scrollRectTF.rect.width
	local var_5_9 = arg_5_0.layoutGroup.cellSize.x

	math = var_4

	local var_5_10 = var_4.floor(var_5_8 / var_5_9)
	local var_5_11

	if var_5_8 % var_5_9 / var_5_10 < 12 then
		var_5_11 = (var_5_8 - var_5_9 * (var_5_10 - 1)) / var_4
	end

	local var_5_12 = arg_5_0.layoutGroup

	Vector2 = var_1_10008
	var_5_12.spacing = var_1_10008(var_5_11, var_5_11)

	local var_5_13 = arg_5_0.layoutGroup.padding

	var_5_13.left = var_5_11 / 2
	Vector2 = var_5_13
	var_5_7.spacing = var_5_13(var_5_11, var_5_11)
	var_5_7.padding.left = var_5_11 / 2

	return
end

function var_0_1.initData(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)

	arg_6_0.player = var_1.getData(var_6_0)

	return
end

function var_0_1.SetAllShopData(arg_7_0, arg_7_1)
	arg_7_0.allShopList = arg_7_1
	arg_7_0.packageSortList = {}

	local var_7_0 = 0

	ipairs = var_1_10003
	ShopConst = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10003(var_1_10004.SUPPLY_SHOP_LIST[arg_7_0.supplyShopType]) do
		ipairs = var_1_10008

		local var_7_1

		if not arg_7_0.allShopList[iter_7_1] then
			var_7_1 = {}
		end

		for iter_7_2, iter_7_3 in var_1_10008(var_7_1) do
			var_7_0 = var_7_0 + 1
			table = var_1_10013

			var_1_10013.insert(arg_7_0.packageSortList, {
				type = iter_7_1,
				index = var_7_0,
				shopData = iter_7_3
			})
		end
	end

	arg_7_0.selectedPackageType = nil

	arg_7_0:updateData()
	arg_7_0:initToggleList()
	arg_7_0:updateToggleList()

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.GetDefaultShopIndex(var_7_2)

	triggerButton = var_7_2

	local var_7_4 = arg_7_0._tf
	local var_7_5 = var_5.Find(var_7_4, "toggleGroup")

	var_7_2(var_5.GetChild(var_7_5, arg_7_0.packageSortList[var_7_3].index - 1))
	arg_7_0:UpdateShop()

	return
end

function var_0_1.GetDefaultShopIndex(arg_8_0)
	local var_8_0 = arg_8_0.supplyShopType

	ShopConst = var_1_10002

	if var_8_0 == var_1_10002.CATEGORY_ACTIVITY then
		var_8_0 = arg_8_0.contextData.actId
		ipairs = var_2

		for iter_8_0, iter_8_1 in var_2(arg_8_0.packageSortList) do
			if iter_8_1.shopData.activityId == var_8_0 then
				return iter_8_1.index
			end
		end
	else
		pairs = var_8_0

		for iter_8_2, iter_8_3 in var_8_0(arg_8_0.packageSortList) do
			if iter_8_3.type == arg_8_0.contextData.shopID then
				local var_8_1 = arg_8_0.packageSortList[arg_8_0.supplyShopType].index
				local var_8_2 = arg_8_0.packageSortList[arg_8_0.supplyShopType].type
				local var_8_3 = arg_8_0.allShopList[var_8_2][1]
				local var_8_4 = arg_8_0.pages[iter_8_3.type]
				local var_8_5, var_8_6 = var_9.CanOpen(var_8_4, var_8_3, arg_8_0.player)

				if var_8_5 then
					return iter_8_3.index
				end
			end
		end
	end

	pairs = var_8_0

	for iter_8_4, iter_8_5 in var_8_0(arg_8_0.packageSortList) do
		local var_8_7 = arg_8_0.allShopList[iter_8_5.type][1]
		local var_8_8 = arg_8_0.pages[iter_8_5.type]
		local var_8_9, var_8_10 = var_7.CanOpen(var_8_8, var_8_7, arg_8_0.player)

		if var_8_9 then
			return iter_8_5.index
		end
	end

	return 1
end

function var_0_1.updateToggleList(arg_9_0)
	local var_9_0 = arg_9_0.uiToggleList

	var_1.align(var_9_0, #arg_9_0.packageSortList)

	return
end

function var_0_1.initToggleList(arg_10_0)
	local var_10_0 = arg_10_0._tf
	local var_10_1 = var_1.Find(var_10_0, "toggleGroup")
	local var_10_2 = arg_10_0._tf
	local var_10_3 = var_2.Find(var_10_2, "toggleGroup/Toggle")

	UIItemList = var_10_2
	arg_10_0.uiToggleList = var_10_2.New(var_10_1, var_10_3)

	local var_10_4 = arg_10_0.uiToggleList

	var_3.make(var_10_4, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventInit then
			local var_11_0 = arg_10_0.packageSortList[arg_11_1 + 1].type
			local var_11_1 = arg_10_0.packageSortList[arg_11_1 + 1].shopData

			ShopConst = var_5

			if var_11_0 == var_5.TYPE_ACTIVITY then
				local var_11_2 = var_11_1.activityId

				pg = var_2_10006

				if var_2_10006.activity_template[var_11_2] then
					pg = var_6

					if var_6.activity_template[var_11_2].config_client then
						pg = var_6

						local var_11_3

						if not var_6.activity_template[var_11_2].config_client.shop_title then
							var_11_3 = nil
						end

						setText = var_2_10007

						local var_11_4 = arg_11_2
						local var_11_5 = arg_11_2.Find(var_11_4, "selected/Label")

						i18n = var_11_4

						local var_11_6

						if not var_11_4(var_11_3) then
							i18n = var_11_6
							ShopConst = var_10
							var_11_6 = var_11_6(var_10.TYPE2NAME[var_11_0])
						end

						var_2_10007(var_11_5, var_11_6)

						goto label_11_0

						setText = var_11_2
						var_2_10007 = arg_11_2

						do
							local var_11_7 = arg_11_2.Find(var_2_10007, "selected/Label")

							i18n = var_2_10007
							ShopConst = var_8

							var_11_2(var_11_7, var_2_10007(var_8.TYPE2NAME[var_11_0]))
						end

						::label_11_0::

						setText = var_11_2
						var_2_10007 = arg_11_2

						local var_11_8 = arg_11_2.Find(var_2_10007, "selected/enText")

						i18n = var_2_10007
						ShopConst = var_8

						var_11_2(var_11_8, var_2_10007(var_8.TYPE2NAME[var_11_0] .. "en"))

						setText = var_11_2
						var_2_10007 = arg_11_2

						local var_11_9 = arg_11_2.Find(var_2_10007, "unselected/Label")

						i18n = var_2_10007
						ShopConst = var_8

						var_11_2(var_11_9, var_2_10007(var_8.TYPE2NAME[var_11_0]))

						local var_11_10 = arg_10_0.packageSortList[arg_11_1 + 1].index
						local var_11_11 = arg_10_0.allShopList[var_11_0][1]
						local var_11_12 = arg_10_0.pages[var_11_0]
						local var_11_13, var_11_14 = var_2_10007.CanOpen(var_11_12, var_11_11, arg_10_0.player)

						if var_11_13 == false then
							setActive = var_10

							var_10(arg_11_2:Find("unselected/Label/lock"), true)
						else
							setActive = var_10

							var_10(arg_11_2:Find("unselected/Label/lock"), false)
						end

						setActive = var_10

						var_10(arg_11_2:Find("unselected"), true)

						setActive = var_10

						var_10(arg_11_2:Find("selected"), false)

						goto label_11_1

						UIItemList = var_11_0

						if arg_11_0 == var_11_0.EventUpdate then
							onButton = var_3

							local var_11_15 = arg_10_0
							local var_11_16 = arg_11_2

							local function var_11_17()
								local var_12_0 = arg_10_0.packageSortList[arg_11_1 + 1].index

								if arg_10_0.selectedPackageType == var_12_0 then
									return
								end

								local var_12_1 = arg_10_0.packageSortList[arg_11_1 + 1].type
								local var_12_2 = arg_10_0.allShopList[var_12_1][1]
								local var_12_3 = arg_10_0.pages[var_12_1]
								local var_12_4, var_12_5 = var_3.CanOpen(var_12_3, var_12_2, arg_10_0.player)

								if var_12_4 == false then
									pg = var_6

									local var_12_6 = var_6.TipsMgr.GetInstance()

									var_6.ShowTips(var_12_6, var_12_5)

									return
								end

								setActive = var_6

								local var_12_7 = arg_11_2

								var_6(var_7.Find(var_12_7, "unselected"), false)

								setActive = var_6

								local var_12_8 = arg_11_2

								var_6(var_7.Find(var_12_8, "selected"), true)

								if arg_10_0.prevBtn then
									setActive = var_6

									local var_12_9 = arg_10_0.prevBtn

									var_6(var_7.Find(var_12_9, "unselected"), true)

									setActive = var_6

									local var_12_10 = arg_10_0.prevBtn

									var_6(var_7.Find(var_12_10, "selected"), false)
								end

								arg_10_0.prevBtn = arg_11_2
								arg_10_0.selectedPackageType = var_12_0
								arg_10_0.contextData.shopID = var_12_1

								local var_12_11 = arg_10_0

								var_6.UpdateShop(var_12_11)

								return
							end

							SFX_PANEL = var_2_10007

							var_3(var_11_15, var_11_16, var_11_17, var_2_10007)
						end

						::label_11_1::

						return
					end
				end
			end
		end
	end)

	return
end

function var_0_1.updateGoodsData(arg_13_0)
	arg_13_0.firstChargeIds = arg_13_0.contextData.firstChargeIds
	arg_13_0.chargedList = arg_13_0.contextData.chargedList
	arg_13_0.normalList = arg_13_0.contextData.normalList
	arg_13_0.normalGroupList = arg_13_0.contextData.normalGroupList

	return
end

function var_0_1.setGoodData(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0.firstChargeIds = arg_14_1
	arg_14_0.chargedList = arg_14_2
	arg_14_0.normalList = arg_14_3
	arg_14_0.normalGroupList = arg_14_4

	return
end

function var_0_1.updateData(arg_15_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)

	arg_15_0.player = var_1.getData(var_15_0)

	return
end

function var_0_1.RefreshResItemList(arg_16_0, arg_16_1)
	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_1) do
		local var_16_0 = arg_16_0.shopResItemList
		local var_16_1

		if not arg_16_0.shopResItemList[iter_16_0] then
			ShopResItem = var_16_1
			var_16_1 = var_16_1.New
			go = var_1_10009
			var_16_1 = var_16_1(var_1_10009(arg_16_0.shopResItem), arg_16_0.shopResParent)
		end

		var_16_0[iter_16_0] = var_16_1

		local var_16_2 = arg_16_0.shopResItemList[iter_16_0]

		var_7.SetData(var_16_2, iter_16_1.type, iter_16_1.resID, iter_16_1.cnt)
	end

	for iter_16_2 = #arg_16_1 + 1, #arg_16_0.shopResItemList do
		local var_16_3 = arg_16_0.shopResItemList[iter_16_2]

		var_6.Show(var_16_3, false)
	end

	return
end

function var_0_1.DestroyResItemList(arg_17_0)
	ipairs = var_1_10001

	local var_17_0

	if not arg_17_0.shopResItemList then
		var_17_0 = {}
	end

	for iter_17_0, iter_17_1 in var_1_10001(var_17_0) do
		iter_17_1:Dispose()
	end

	arg_17_0.shopResItemList = nil

	return
end

function var_0_1.IsSupplyShop(arg_18_0)
	return true
end

function var_0_1.SetPlayer(arg_19_0, arg_19_1)
	arg_19_0.player = arg_19_1

	local var_19_0 = arg_19_0.page

	var_2.SetPlayer(var_19_0, arg_19_1)

	return
end

function var_0_1.reUpdateAll(arg_20_0)
	arg_20_0:updateData()

	return
end

function var_0_1.OnUpdateItems(arg_21_0, arg_21_1)
	arg_21_0.items = arg_21_1

	if arg_21_0.packageSortList then
		local var_21_0 = arg_21_0.packageSortList[arg_21_0.selectedPackageType]
		local var_21_1 = arg_21_0.pages[var_21_0.type]

		var_3.SetItems(var_21_1, arg_21_1)
	end

	return
end

function var_0_1.OnUpdateShop(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.pages[arg_22_1]

	if arg_22_0.page == var_22_0 then
		local var_22_1 = arg_22_0.page

		var_4.UpdateShop(var_22_1, arg_22_2)
	end

	ipairs = var_4

	for iter_22_0, iter_22_1 in var_4(arg_22_0.packageSortList) do
		local var_22_2 = iter_22_1.shopData

		if var_9.IsSameKind(var_22_2, arg_22_2) then
			iter_22_1.shopData = arg_22_2

			break
		end
	end

	return
end

function var_0_1.OnUpdateCommodity(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0.pages[arg_23_1]

	ipairs = var_1_10005

	for iter_23_0, iter_23_1 in var_1_10005(arg_23_0.packageSortList) do
		local var_23_1 = iter_23_1.shopData

		if var_10.IsSameKind(var_23_1, arg_23_2) then
			iter_23_1.shopData = arg_23_2

			if arg_23_0.page == var_23_0 then
				local var_23_2 = arg_23_0.page

				var_10.UpdateCommodity(var_23_2, arg_23_2, arg_23_3)
			end

			break
		end
	end

	return
end

function var_0_1.OnFragmentSellUpdate(arg_24_0)
	local var_24_0 = arg_24_0.page
	local var_24_1 = arg_24_0.pages

	ShopConst = var_1_10003

	if var_24_0 == var_24_1[var_1_10003.TYPE_FRAGMENT] then
		local var_24_2 = arg_24_0.page

		var_1.OnFragmentSellUpdate(var_24_2)
	end

	return
end

function var_0_1.UpdateShop(arg_25_0)
	local var_25_0 = arg_25_0.packageSortList[arg_25_0.selectedPackageType].shopData
	local var_25_1 = arg_25_0.pages[var_1.type]
	local var_25_2, var_25_3 = var_3.CanOpen(var_25_1, var_25_0, arg_25_0.player)

	if var_25_2 then
		if arg_25_0.page and arg_25_0.page ~= var_3 then
			local var_25_4 = arg_25_0.page

			var_6.Hide(var_25_4)
		end

		var_3:SetUp(var_25_0, arg_25_0.player, arg_25_0.items)

		arg_25_0.page = var_3
	else
		pg = var_6

		local var_25_5 = var_6.TipsMgr.GetInstance()

		var_6.ShowTips(var_25_5, var_25_3)
	end

	return
end

function var_0_1.ShowPanel(arg_26_0, arg_26_1)
	if arg_26_0._go then
		setActive = var_2

		var_2(arg_26_0._go, arg_26_1)
	end

	return
end

function var_0_1.blurView(arg_27_0)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.OverlayPanel
	local var_27_2 = arg_27_0._tf
	local var_27_3 = {}
	local var_27_4 = {}
	local var_27_5 = arg_27_0._tf

	var_27_4[1] = var_6.Find(var_27_5, "bg")
	var_27_3.pbList = var_27_4

	var_27_1(var_27_0, var_27_2, var_27_3)

	return
end

function var_0_1.unBlurView(arg_28_0)
	arg_28_0:UnOverlayPanel(arg_28_0._tf, arg_28_0._parentTf)

	return
end

return var_0_1
