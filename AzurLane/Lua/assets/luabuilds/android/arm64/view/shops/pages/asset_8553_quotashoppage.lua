class = var_0_10000

local var_0_0 = "QuotaShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseShopPage"))

function var_0_1.GetPaintingCommodityUpdateVoice(arg_1_0)
	return
end

function var_0_1.CanOpen(arg_2_0, arg_2_1, arg_2_2)
	pg = var_1_10003

	local var_2_0 = var_1_10003.SystemOpenMgr.GetInstance()

	return var_3.isOpenSystem(var_2_0, arg_2_2.level, "QuotaShop")
end

function var_0_1.RefreshUI(arg_3_0)
	arg_3_0:UpdateTip()

	setActive = var_1

	var_1(arg_3_0.tipTextGo, true)

	setActive = var_1

	var_1(arg_3_0.helpBtn, false)

	setActive = var_1

	var_1(arg_3_0.resolveBtn, false)

	setActive = var_1

	var_1(arg_3_0.refreshBtn, false)

	return
end

function var_0_1.UpdateTip(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0.tipText

	i18n = var_1_10004

	var_1_10001(var_4_0, var_1_10004("quota_shop_description"))

	return
end

function var_0_1.OnUpdateItems(arg_5_0)
	arg_5_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0.shop
	local var_6_2 = var_2.GetResList(var_6_1)

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(var_6_2) do
		local var_6_3
		local var_6_4 = arg_6_0.items

		ChapterConst = var_1_10010

		local var_6_5 = not var_6_4[var_1_10010.ShamMoneyItem] and 0 or var_1_10010.count

		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_6_6 = var_6_0
		local var_6_7 = {}

		DROP_TYPE_ITEM = var_1_10015
		var_6_7.type = var_1_10015
		var_6_7.resID = iter_6_1
		var_6_7.cnt = var_6_5

		var_1_10011(var_6_6, var_6_7)
	end

	return var_6_0
end

function var_0_1.OnUpdateCommodity(arg_7_0, arg_7_1)
	local var_7_0

	pairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.cards) do
		if iter_7_1.goodsVO.id == arg_7_1.id then
			var_7_0 = iter_7_1

			break
		end
	end

	if var_7_0 then
		var_7_0:update(arg_7_1)
	end

	return
end

function var_0_1.OnInitItem(arg_8_0, arg_8_1)
	QuotaGoodsCard = var_1_10002

	local var_8_0 = var_1_10002.New(arg_8_1)

	onButton = var_1_10003

	local var_8_1 = arg_8_0
	local var_8_2 = var_8_0.tf

	local function var_8_3()
		local var_9_0 = var_8_0.goodsVO

		if not var_0.canPurchase(var_9_0) then
			pg = var_0

			local var_9_1 = var_0.TipsMgr.GetInstance()
			local var_9_2 = var_0.ShowTips

			i18n = var_2_10003

			var_9_2(var_9_1, var_2_10003("buy_countLimit"))

			return
		end

		local var_9_3 = arg_8_0

		var_0.OnClickCommodity(var_9_3, var_8_0.goodsVO, function(arg_10_0, arg_10_1)
			local var_10_0 = arg_8_0

			var_2.OnPurchase(var_10_0, arg_10_0, arg_10_1)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_8_1, var_8_2, var_8_3, var_1_10008)

	arg_8_0.cards[arg_8_1] = var_8_0

	return
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)

		var_11_0 = arg_11_0.cards[arg_11_2]
	end

	local var_11_1 = arg_11_0.displays[arg_11_1 + 1]

	var_11_0:update(var_11_1)

	return
end

function var_0_1.OnUpdateAll(arg_12_0)
	arg_12_0:InitCommodities()

	return
end

function var_0_1.OnPurchase(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.emit

	NewShopMainMediator = var_1_10006

	var_13_1(var_13_0, var_1_10006.ON_QUOTA_SHOPPING, arg_13_1.id, arg_13_2)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	var_0_1.super.OnDestroy(arg_14_0)

	return
end

return var_0_1
