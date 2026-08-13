class = var_0_10000

local var_0_0 = "FragmentShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ShamShopPage"))

function var_0_1.GetPaintingCommodityUpdateVoice(arg_1_0)
	return
end

function var_0_1.CanOpen(arg_2_0, arg_2_1, arg_2_2)
	pg = var_1_10003

	local var_2_0 = var_1_10003.SystemOpenMgr.GetInstance()

	return var_3.isOpenSystem(var_2_0, arg_2_2.level, "FragmentShop")
end

function var_0_1.init(arg_3_0)
	var_0_1.super.init(arg_3_0)

	return
end

function var_0_1.CustomInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.resolveBtn

	local function var_4_2()
		if not arg_4_0.resolvePanel then
			local var_5_0 = arg_4_0

			FragResolvePanel = var_2_10001
			var_5_0.resolvePanel = var_2_10001.New(arg_4_0)
			arg_4_0.resolvePanel.event = arg_4_0.event

			local var_5_1 = arg_4_0.resolvePanel

			var_0.Load(var_5_1)
		end

		local var_5_2 = arg_4_0.resolvePanel.buffer

		var_0.Reset(var_5_2)

		local var_5_3 = arg_4_0.resolvePanel.buffer

		var_0.Trigger(var_5_3, "control")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	getProxy = var_1_10001
	CommanderManualProxy = var_4_0

	local var_4_3 = var_1_10001(var_4_0)

	var_1.TaskProgressAdd(var_4_3, 2023, 1)

	return
end

function var_0_1.OnUpdatePlayer(arg_6_0)
	arg_6_0:RefreshResItemList()

	return
end

function var_0_1.OnFragmentSellUpdate(arg_7_0)
	if arg_7_0.resolvePanel then
		local var_7_0 = arg_7_0.resolvePanel.buffer

		var_1.Reset(var_7_0)

		local var_7_1 = arg_7_0.resolvePanel.buffer

		var_1.Trigger(var_7_1, "control")
	end

	return
end

function var_0_1.OnUpdateItems(arg_8_0)
	arg_8_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = {}

	DROP_TYPE_RESOURCE = var_1_10003
	var_9_1.type = var_1_10003
	PlayerConst = var_1_10003
	var_9_1.resID = var_1_10003.ResBlueprintFragment

	local var_9_2 = arg_9_0.player
	local var_9_3 = var_3.getResource

	PlayerConst = var_1_10006
	var_9_1.cnt = var_9_3(var_9_2, var_1_10006.ResBlueprintFragment)
	var_9_0[1] = var_9_1
	LOCK_UR_SHIP = var_9_1

	if not var_9_1 and arg_9_0.items then
		pg = var_2

		local var_9_4 = var_2.gameset.urpt_chapter_max.description[1]
		local var_9_5

		if not arg_9_0.items[var_9_4] then
			var_9_5 = {
				count = 0
			}
		end

		table = var_9_2

		local var_9_6 = var_9_2.insert
		local var_9_7 = var_9_0
		local var_9_8 = {}

		DROP_TYPE_ITEM = var_1_10009
		var_9_8.type = var_1_10009
		var_9_8.resID = var_9_4
		var_9_8.cnt = var_9_5.count

		var_9_6(var_9_7, var_9_8)
	end

	return var_9_0
end

function var_0_1.OnUpdateCommodity(arg_10_0, arg_10_1)
	local var_10_0

	pairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(arg_10_0.cards) do
		if iter_10_1.goodsVO.id == arg_10_1.id then
			var_10_0 = iter_10_1

			break
		end
	end

	if var_10_0 then
		var_10_0.goodsVO = arg_10_1
		ActivityGoodsCard = var_3

		var_3.StaticUpdate(var_10_0.tf, arg_10_1, var_0_1.TYPE_FRAGMENT)
	end

	return
end

function var_0_1.RefreshUI(arg_11_0)
	arg_11_0:UpdateTip()

	setActive = var_1

	var_1(arg_11_0.tipTextGo, true)

	setActive = var_1

	var_1(arg_11_0.helpBtn, false)

	setActive = var_1

	var_1(arg_11_0.resolveBtn, true)

	setActive = var_1

	var_1(arg_11_0.refreshBtn, false)

	return
end

function var_0_1.OnInitItem(arg_12_0, arg_12_1)
	ActivityGoodsCard = var_1_10002

	local var_12_0 = var_1_10002.New(arg_12_1)

	onButton = var_1_10003

	local var_12_1 = arg_12_0
	local var_12_2 = var_12_0.tf

	local function var_12_3()
		local var_13_0 = var_12_0.goodsVO

		if not var_0.canPurchase(var_13_0) then
			pg = var_0

			local var_13_1 = var_0.TipsMgr.GetInstance()
			local var_13_2 = var_0.ShowTips

			i18n = var_2_10003

			var_13_2(var_13_1, var_2_10003("buy_countLimit"))

			return
		end

		local var_13_3 = arg_12_0

		var_0.OnClickCommodity(var_13_3, var_12_0.goodsVO, function(arg_14_0, arg_14_1)
			local var_14_0 = arg_12_0

			var_2.OnPurchase(var_14_0, arg_14_0, arg_14_1)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_12_1, var_12_2, var_12_3, var_1_10008)

	arg_12_0.cards[arg_12_1] = var_12_0

	return
end

function var_0_1.OnUpdateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	if not arg_15_0.cards[arg_15_2] then
		arg_15_0:OnInitItem(arg_15_2)

		var_15_0 = arg_15_0.cards[arg_15_2]
	end

	var_15_0.goodsVO = arg_15_0.displays[arg_15_1 + 1]
	ActivityGoodsCard = var_5

	var_5.StaticUpdate(var_15_0.tf, var_4, var_0_1.TYPE_FRAGMENT)

	return
end

function var_0_1.OnPurchase(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.emit

	NewShopMainMediator = var_1_10006

	var_16_1(var_16_0, var_1_10006.ON_FRAGMENT_SHOPPING, arg_16_1.id, arg_16_2)

	return
end

function var_0_1.OnDestroy(arg_17_0)
	var_0_1.super.OnDestroy(arg_17_0)

	if arg_17_0.resolvePanel then
		local var_17_0 = arg_17_0.resolvePanel

		var_1.Destroy(var_17_0)

		arg_17_0.resolvePanel = nil
	end

	return
end

return var_0_1
