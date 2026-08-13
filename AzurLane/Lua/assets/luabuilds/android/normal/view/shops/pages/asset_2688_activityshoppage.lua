class = var_0_10000

local var_0_0 = "ActivityShopPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseShopPage"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.getBGM(arg_2_0)
	string = var_1_10001

	return var_1_10001.format("ActivityShop%s", arg_2_0.shop.activityId)
end

function var_0_1.GetPaintingName(arg_3_0)
	assert = var_1_10001

	var_1_10001(arg_3_0.shop)

	pg = var_1_10001

	local var_3_0 = var_1_10001.activity_template[arg_3_0.shop.activityId]

	getProxy = var_2
	ActivityProxy = var_1_10003

	local var_3_1 = var_2(var_1_10003)
	local var_3_2 = var_2.checkHxActivity(var_3_1, arg_3_0.shop.activityId)

	if var_3_0 and var_3_0.config_client then
		if var_3_0.config_client.use_secretary or var_3_2 then
			getProxy = var_4
			PlayerProxy = var_5

			local var_3_3 = var_4(var_5)
			local var_3_4 = var_4.getData(var_3_3)

			getProxy = var_3_3
			SettingsProxy = var_1_10007

			local var_3_5 = var_3_3(var_1_10007)
			local var_3_6 = var_6.getCurrentSecretaryIndex(var_3_5)

			getProxy = var_3_5
			BayProxy = var_1_10008

			local var_3_7 = var_3_5(var_1_10008)

			arg_3_0.tempFlagShip = var_7.getShipById(var_3_7, var_3_4.characters[1])

			local var_3_8 = arg_3_0.tempFlagShip

			return var_7.getPainting(var_3_8), true, "build"
		elseif var_3_0.config_client.painting then
			return var_3_0.config_client.painting, true
		end
	end

	return "aijiang_pt"
end

function var_0_1.GetBg(arg_4_0, arg_4_1)
	return (arg_4_1:getBgPath())
end

function var_0_1.GetPaintingEnterVoice(arg_5_0)
	local var_5_0 = arg_5_0.shop
	local var_5_1, var_5_2, var_5_3 = var_1.GetEnterVoice(var_5_0)

	return var_5_2, var_5_1, var_5_3
end

function var_0_1.GetPaintingCommodityUpdateVoice(arg_6_0)
	local var_6_0 = arg_6_0.shop
	local var_6_1, var_6_2, var_6_3 = var_1.GetPurchaseVoice(var_6_0)

	return var_6_2, var_6_1, var_6_3
end

function var_0_1.GetPaintingAllPurchaseVoice(arg_7_0)
	local var_7_0 = arg_7_0.shop
	local var_7_1, var_7_2, var_7_3 = var_1.GetPurchaseAllVoice(var_7_0)

	return var_7_2, var_7_1, var_7_3
end

function var_0_1.GetPaintingTouchVoice(arg_8_0)
	local var_8_0 = arg_8_0.shop
	local var_8_1, var_8_2, var_8_3 = var_1.GetTouchVoice(var_8_0)

	return var_8_2, var_8_1, var_8_3
end

function var_0_1.init(arg_9_0)
	var_0_1.super.init(arg_9_0)

	local var_9_0 = arg_9_0._tf

	arg_9_0.scrollRectSpecial = var_1.Find(var_9_0, "scrollRectSpecial")
	UIItemList = var_1

	local var_9_1 = var_1.New
	local var_9_2 = arg_9_0.scrollRectSpecial
	local var_9_3 = var_2.Find(var_9_2, "viewport/view")
	local var_9_4 = arg_9_0.scrollRectSpecial

	arg_9_0.groupList = var_9_1(var_9_3, var_3.Find(var_9_4, "viewport/view/group"))

	return
end

function var_0_1.OnInit(arg_10_0)
	return
end

function var_0_1.OnUpdatePlayer(arg_11_0)
	arg_11_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = arg_12_0.shop
	local var_12_2 = var_2.GetResList(var_12_1)

	ipairs = var_12_1

	for iter_12_0, iter_12_1 in var_12_1(var_12_2) do
		local var_12_3 = arg_12_0.player
		local var_12_4 = var_8.getResource(var_12_3, iter_12_1)

		table = var_12_3

		local var_12_5 = var_12_3.insert
		local var_12_6 = var_12_0
		local var_12_7 = {}

		DROP_TYPE_RESOURCE = var_1_10012
		var_12_7.type = var_1_10012
		var_12_7.resID = iter_12_1
		var_12_7.cnt = var_12_4

		var_12_5(var_12_6, var_12_7)
	end

	return var_12_0
end

function var_0_1.OnSetUp(arg_13_0)
	arg_13_0:SetResIcon()
	arg_13_0:UpdateTip()

	return
end

function var_0_1.OnUpdateAll(arg_14_0)
	arg_14_0:InitCommodities()

	return
end

function var_0_1.OnUpdateCommodity(arg_15_0, arg_15_1)
	local var_15_0

	pairs = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10003(arg_15_0.cards) do
		if iter_15_1.goodsVO.id == arg_15_1.id then
			var_15_0 = iter_15_1

			break
		end
	end

	if var_15_0 then
		local var_15_1 = arg_15_0.shop
		local var_15_2, var_15_3, var_15_4 = var_3.getBgPath(var_15_1)

		var_15_0:update(arg_15_1, nil, var_15_3, var_15_4)
	end

	return
end

function var_0_1.SetResIcon(arg_16_0, arg_16_1)
	arg_16_0:RefreshResItemList()

	return
end

function var_0_1.RefreshUI(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0.tipTextGo, true)

	setActive = var_1_10001

	var_1_10001(arg_17_0.helpBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_17_0.resolveBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_17_0.refreshBtn, false)

	return
end

function var_0_1.UpdateTip(arg_18_0)
	local var_18_0 = arg_18_0.shop
	local var_18_1 = #var_1.GetResList(var_18_0) > 1 and 25 or 27
	local var_18_2 = arg_18_0.tipText
	local var_18_3 = "<size="
	local var_18_4 = var_18_1
	local var_18_5 = ">"

	i18n = var_1_10007

	local var_18_6 = "activity_shop_lable"
	local var_18_7 = arg_18_0.shop

	var_18_2.text = var_18_3 .. var_18_4 .. var_18_5 .. var_1_10007(var_18_6, var_9.getOpenTime(var_18_7)) .. "</size>"

	return
end

function var_0_1.OnInitItem(arg_19_0, arg_19_1)
	ActivityGoodsCard = var_1_10002

	local var_19_0 = var_1_10002.New(arg_19_1)

	onButton = var_3

	local var_19_1 = arg_19_0
	local var_19_2 = var_19_0.tf

	local function var_19_3()
		local var_20_0 = arg_19_0

		var_0.OnClickCommodity(var_20_0, var_19_0.goodsVO, function(arg_21_0, arg_21_1)
			local var_21_0 = arg_19_0

			var_2.OnPurchase(var_21_0, arg_21_0, arg_21_1)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_19_1, var_19_2, var_19_3, var_1_10007)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_1.OnUpdateItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if not arg_22_0.cards[arg_22_2] then
		arg_22_0:OnInitItem(arg_22_2)

		var_22_0 = arg_22_0.cards[arg_22_2]
	end

	local var_22_1 = arg_22_0.displays[arg_22_1 + 1]
	local var_22_2 = arg_22_0.shop
	local var_22_3, var_22_4, var_22_5 = var_5.getBgPath(var_22_2)

	var_22_0:update(var_22_1, nil, var_22_4, var_22_5)

	return
end

function var_0_1.TipPurchase(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0, var_23_1 = arg_23_1:GetTranCntWhenFull(arg_23_2)

	if 0 < var_23_0 then
		math = var_7

		local var_23_2 = var_7.max(arg_23_2 - var_23_0, 0)

		pg = var_8

		local var_23_3 = var_8.MsgboxMgr.GetInstance()
		local var_23_4 = var_8.ShowMsgBox
		local var_23_5 = {}

		i18n = var_1_10011
		var_23_5.content = var_1_10011("pt_shop_tran_tip", var_23_2, arg_23_3, var_23_0 * var_23_1.count, var_23_1:getConfig("name"))
		var_23_5.onYes = arg_23_4

		var_23_4(var_23_3, var_23_5)
	else
		arg_23_4()
	end

	return
end

function var_0_1.OnPurchase(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1:getConfig("commodity_type")
	local var_24_1 = arg_24_1
	local var_24_2 = arg_24_1.getConfig(var_24_1, "commodity_id")

	DROP_TYPE_ITEM = var_24_1

	if var_24_0 == var_24_1 then
		getProxy = var_24_1
		BagProxy = var_6

		local var_24_3 = var_24_1(var_6)

		if var_5.RawGetItemById(var_24_3, var_24_2) and var_5:IsShipExpType() and var_5:IsMaxCnt() then
			pg = var_6

			local var_24_4 = var_6.TipsMgr.GetInstance()
			local var_24_5 = var_6.ShowTips

			i18n = var_1_10008

			var_24_5(var_24_4, var_1_10008("item_is_max_cnt"))

			return
		end
	end

	local var_24_6 = arg_24_0.shop.activityId
	local var_24_7 = arg_24_0
	local var_24_8 = arg_24_0.emit

	NewShopMainMediator = var_1_10008

	var_24_8(var_24_7, var_1_10008.ON_ACT_SHOPPING, var_24_6, 1, arg_24_1.id, arg_24_2)

	return
end

function var_0_1.OnClickCommodity(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_1:CheckCntLimit() then
		return
	end

	if var_3 and not arg_25_1:CheckArgLimit() then
		local var_25_0, var_25_1, var_25_2, var_25_3 = arg_25_1:CheckArgLimit()

		ShopArgs = var_1_10009

		local var_25_4

		if var_25_1 == var_1_10009.LIMIT_ARGS_META_SHIP_EXISTENCE then
			ShipGroup = var_25_4

			if not var_25_4.getDefaultShipConfig(var_25_3) then
				var_25_4 = {}
			end

			pg = var_10

			local var_25_5 = var_10.TipsMgr.GetInstance()
			local var_25_6 = var_10.ShowTips

			i18n = var_1_10012

			local var_25_7 = "meta_shop_exchange_limit_tip"
			local var_25_8

			if not var_25_4.name then
				var_25_8 = ""
			end

			var_25_6(var_25_5, var_1_10012(var_25_7, var_25_8))
		else
			ShopArgs = var_25_4

			if var_25_1 == var_25_4.LIMIT_ARGS_SALE_START_TIME then
				local var_25_9 = {
					year = var_25_3[1][1],
					month = var_25_3[1][2],
					day = var_25_3[1][3],
					hour = var_25_3[2][1],
					min = var_25_3[2][2],
					sec = var_25_3[2][3]
				}

				pg = var_10

				local var_25_10 = var_10.TipsMgr.GetInstance()
				local var_25_11 = var_10.ShowTips

				i18n = var_1_10012

				var_25_11(var_25_10, var_1_10012("meta_shop_exchange_limit_2_tip", var_25_9.year, var_25_9.month, var_25_9.day, var_25_9.hour, var_25_9.min, var_25_9.sec))
			end
		end

		return
	end

	var_0_1.super.OnClickCommodity(arg_25_0, arg_25_1, arg_25_2)

	return
end

function var_0_1.Show(arg_26_0)
	pg = var_1_10001

	local var_26_0

	if var_1_10001.activity_template[arg_26_0.shop.activityId] and var_1.config_client and var_1.config_client.category then
		setActive = var_26_0
		go = var_1_10003

		var_26_0(var_1_10003(arg_26_0.lScrollrect), false)

		setActive = var_26_0

		var_26_0(arg_26_0.scrollRectSpecial, true)

		var_1_10003 = arg_26_0.groupList

		var_26_0.make(var_1_10003, function(arg_27_0, arg_27_1, arg_27_2)
			UIItemList = var_2_10003

			if arg_27_0 == var_2_10003.EventUpdate then
				local var_27_0 = arg_26_0.splitCommodities[arg_27_1 + 1]

				setText = var_4

				local var_27_1 = arg_27_2
				local var_27_2 = arg_27_2.Find(var_27_1, "title/name")

				i18n = var_27_1

				var_4(var_27_2, var_27_1(arg_26_0.spiltNameCodes[arg_27_1 + 1]))

				UIItemList = var_4

				local var_27_3 = var_4.New(arg_27_2:Find("items"), arg_27_2:Find("items/ActivityShopNewTpl"))

				var_4.make(var_27_3, function(arg_28_0, arg_28_1, arg_28_2)
					UIItemList = var_3_10003

					if arg_28_0 == var_3_10003.EventUpdate then
						ActivityGoodsCard = var_3

						local var_28_0 = var_3.New(arg_28_2)
						local var_28_1 = arg_26_0.cards

						var_28_1[arg_28_2] = var_28_0
						onButton = var_28_1

						local var_28_2 = arg_26_0
						local var_28_3 = var_28_0.tf

						local function var_28_4()
							local var_29_0 = arg_26_0

							var_0.OnClickCommodity(var_29_0, var_28_0.goodsVO, function(arg_30_0, arg_30_1)
								local var_30_0 = arg_26_0

								var_2.OnPurchase(var_30_0, arg_30_0, arg_30_1)

								return
							end)

							return
						end

						SFX_PANEL = var_3_10008

						var_28_1(var_28_2, var_28_3, var_28_4, var_3_10008)

						local var_28_5 = var_27_0[arg_28_1 + 1]
						local var_28_6 = arg_26_0.shop
						local var_28_7, var_28_8, var_28_9 = var_5.getBgPath(var_28_6)

						var_28_0:update(var_28_5, nil, var_28_8, var_28_9)
					end

					return
				end)
				var_4:align(#var_27_0)
			end

			return
		end)

		var_1_10003 = arg_26_0.groupList

		var_26_0.align(var_1_10003, #arg_26_0.splitCommodities)

		var_26_0 = arg_26_0.canvasGroup
		var_26_0.alpha = 1
		var_26_0 = arg_26_0.canvasGroup
		var_26_0.blocksRaycasts = true
	else
		setActive = var_26_0
		go = var_1_10003

		var_26_0(var_1_10003(arg_26_0.lScrollrect), true)

		if arg_26_0.scrollRectSpecial then
			setActive = var_2

			var_2(arg_26_0.scrollRectSpecial, false)
		end

		var_0_1.super.Show(arg_26_0)
	end

	local var_26_1 = arg_26_0.shop

	if var_2.GetBGM(var_26_1) ~= "" then
		pg = var_2

		local var_26_2 = var_2.BgmMgr.GetInstance()
		local var_26_3 = var_2.Push
		local var_26_4 = arg_26_0.__cname
		local var_26_5 = arg_26_0.shop

		var_26_3(var_26_2, var_26_4, var_5.GetBGM(var_26_5))
	end

	return
end

function var_0_1.Hide(arg_31_0)
	pg = var_1_10001

	local var_31_0

	if var_1_10001.activity_template[arg_31_0.shop.activityId] and var_1.config_client and var_1.config_client.category then
		pairs = var_31_0

		for iter_31_0, iter_31_1 in var_31_0(arg_31_0.cards) do
			iter_31_1:Dispose()
		end

		arg_31_0.splitCommodities = {}
		arg_31_0.spiltNameCodes = {}
		arg_31_0.cards = {}
		var_31_0 = arg_31_0.canvasGroup
		var_31_0.alpha = 0
		var_31_0 = arg_31_0.canvasGroup
		var_31_0.blocksRaycasts = false
	else
		var_0_1.super.Hide(arg_31_0)
	end

	setActive = var_31_0
	go = var_1_10003

	var_31_0(var_1_10003(arg_31_0.lScrollrect), true)

	if arg_31_0.scrollRectSpecial then
		setActive = var_2

		var_2(arg_31_0.scrollRectSpecial, false)
	end

	local var_31_1 = arg_31_0.shop

	if var_2.GetBGM(var_31_1) ~= "" then
		pg = var_2

		local var_31_2 = var_2.BgmMgr.GetInstance()

		var_2.Pop(var_31_2, arg_31_0.__cname)
	end

	return
end

function var_0_1.SetUp(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0:SetShop(arg_32_1)
	arg_32_0:InitCommodities()

	arg_32_0.cards = {}

	arg_32_0:Show()
	arg_32_0:SetPlayer(arg_32_2)
	arg_32_0:SetItems(arg_32_3)
	arg_32_0:InitCommodities()
	arg_32_0:OnSetUp()
	arg_32_0:SetPainting()
	arg_32_0:RefreshUI()

	return
end

function var_0_1.InitCommodities(arg_33_0)
	pg = var_1_10001

	if var_1_10001.activity_template[arg_33_0.shop.activityId] and var_1.config_client and var_1.config_client.category then
		local var_33_0 = arg_33_0.shop

		arg_33_0.splitCommodities = var_2.GetSplitCommodities(var_33_0)

		local var_33_1 = arg_33_0.shop

		arg_33_0.spiltNameCodes = var_2.GetSplitNameCodes(var_33_1)

		local var_33_2 = arg_33_0.groupList

		var_2.align(var_33_2, #arg_33_0.splitCommodities)
	else
		var_0_1.super.InitCommodities(arg_33_0)
	end

	return
end

return var_0_1
