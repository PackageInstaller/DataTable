class = var_0_10000

local var_0_0 = "ShamShopPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseShopPage"))

function var_0_1.GetPaintingCommodityUpdateVoice(arg_1_0)
	return
end

function var_0_1.CanOpen(arg_2_0, arg_2_1, arg_2_2)
	pg = var_1_10003

	local var_2_0 = var_1_10003.SystemOpenMgr.GetInstance()

	return var_3.isOpenSystem(var_2_0, arg_2_2.level, "ShamShop")
end

function var_0_1.OnUpdateItems(arg_3_0)
	arg_3_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = arg_4_0.shop
	local var_4_2 = var_2.GetResList(var_4_1)

	ipairs = var_4_1

	for iter_4_0, iter_4_1 in var_4_1(var_4_2) do
		local var_4_3
		local var_4_4 = arg_4_0.items

		ChapterConst = var_1_10010

		local var_4_5 = not var_4_4[var_1_10010.ShamMoneyItem] and 0 or var_1_10010.count

		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_4_6 = var_4_0
		local var_4_7 = {}

		DROP_TYPE_ITEM = var_1_10014
		var_4_7.type = var_1_10014
		var_4_7.resID = iter_4_1
		var_4_7.cnt = var_4_5

		var_1_10011(var_4_6, var_4_7)
	end

	return var_4_0
end

function var_0_1.OnUpdateCommodity(arg_5_0, arg_5_1)
	local var_5_0

	pairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_0.cards) do
		if iter_5_1.goodsVO.id == arg_5_1.id then
			var_5_0 = iter_5_1

			break
		end
	end

	if var_5_0 then
		var_5_0:update(arg_5_1)
	end

	return
end

function var_0_1.RefreshUI(arg_6_0)
	arg_6_0:UpdateTip()

	setActive = var_1

	var_1(arg_6_0.tipTextGo, true)

	setActive = var_1

	var_1(arg_6_0.helpBtn, false)

	setActive = var_1

	var_1(arg_6_0.resolveBtn, false)

	setActive = var_1

	var_1(arg_6_0.refreshBtn, false)

	return
end

function var_0_1.OnInitItem(arg_7_0, arg_7_1)
	ActivityGoodsCard = var_1_10002

	local var_7_0 = var_1_10002.New(arg_7_1)

	onButton = var_3

	local var_7_1 = arg_7_0
	local var_7_2 = var_7_0.tf

	local function var_7_3()
		local var_8_0 = var_7_0.goodsVO

		if not var_0.canPurchase(var_8_0) then
			pg = var_0

			local var_8_1 = var_0.TipsMgr.GetInstance()
			local var_8_2 = var_0.ShowTips

			i18n = var_2_10002

			var_8_2(var_8_1, var_2_10002("buy_countLimit"))

			return
		end

		local var_8_3 = arg_7_0

		var_0.OnClickCommodity(var_8_3, var_7_0.goodsVO, function(arg_9_0, arg_9_1)
			local var_9_0 = arg_7_0

			var_2.OnPurchase(var_9_0, arg_9_0, arg_9_1)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_7_1, var_7_2, var_7_3, var_1_10007)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_1.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)

		var_10_0 = arg_10_0.cards[arg_10_2]
	end

	local var_10_1 = arg_10_0.displays[arg_10_1 + 1]

	var_10_0:update(var_10_1)

	return
end

function var_0_1.OnUpdateAll(arg_11_0)
	arg_11_0:InitCommodities()
	arg_11_0:OnSetUp()

	return
end

function var_0_1.OnSetUp(arg_12_0)
	arg_12_0:UpdateTip()

	return
end

function var_0_1.UpdateTip(arg_13_0)
	setText = var_1_10001

	local var_13_0 = arg_13_0.tipText

	i18n = var_1_10003

	local var_13_1 = var_1_10003("title_limit_time")

	i18n = var_4

	local var_13_2 = var_4("shops_rest_day")

	string = var_5

	local var_13_3 = var_5.format
	local var_13_4 = "%02d"
	local var_13_5 = arg_13_0.shop
	local var_13_6 = var_13_3(var_13_4, var_7.getRestDays(var_13_5))

	i18n = var_13_4

	var_1_10001(var_13_0, var_13_1 .. var_13_2 .. var_13_6 .. var_13_4("word_date"))

	return
end

function var_0_1.OnPurchase(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	NewShopMainMediator = var_1_10005

	var_14_1(var_14_0, var_1_10005.ON_SHAM_SHOPPING, arg_14_1.id, arg_14_2)

	return
end

function var_0_1.OnDestroy(arg_15_0)
	var_0_1.super.OnDestroy(arg_15_0)

	return
end

return var_0_1
