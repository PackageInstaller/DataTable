class = var_0_10000

local var_0_0 = "IslandTradeRankPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTradeRankUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "title/Text")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("island_trade_rank_num_label"))

	setText = var_1_10001

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "title/Text_1")

	i18n = var_2_2

	var_1_10001(var_2_3, var_2_2("island_trade_rank_info_label"))

	setText = var_1_10001

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "title/Text_2")

	i18n = var_2_4

	var_1_10001(var_2_5, var_2_4("island_trade_rank_price_label"))

	setText = var_1_10001

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "tpl/main/visit/Text")

	i18n = var_2_6

	var_1_10001(var_2_7, var_2_6("island_visit_title"))

	setText = var_1_10001

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "tpl/main/invite/Text")

	i18n = var_2_8

	var_1_10001(var_2_9, var_2_8("island_trade_invite_label"))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "scrollrect")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_11, "LScrollRect")

	function arg_2_0.scrollrect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	local var_2_12 = arg_2_0.scrollrect

	function var_2_12.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	IslandTradeRankCard = var_2_12

	local var_2_13 = var_2_12.New
	local var_2_14 = arg_2_0._tf

	arg_2_0.selfRankCard = var_2_13(var_2.Find(var_2_14, "tpl"))
	arg_2_0.cards = {}

	return
end

function var_0_1.Show(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.Show(arg_5_0)

	arg_5_0.mode = arg_5_2
	seriesAsync = var_3

	var_3({
		function(arg_6_0)
			local var_6_0 = arg_5_0

			var_1.RequestRank(var_6_0, arg_6_0)

			return
		end
	}, function()
		local var_7_0 = arg_5_0
		local var_7_1, var_7_2, var_7_3 = var_0.GetDislays(var_7_0)

		arg_5_0.rankNums = var_7_3

		local var_7_4 = arg_5_0

		var_3.DisplayResult(var_7_4, var_7_2, var_7_1)

		local var_7_5 = arg_5_0

		var_3.UpdateSelfRank(var_7_5, var_7_1)

		return
	end)

	return
end

function var_0_1.GetDislays(arg_8_0)
	local var_8_0
	local var_8_1
	local var_8_2 = arg_8_0.mode

	IslandTradePage = var_1_10004

	local var_8_3

	if var_8_2 == var_1_10004.MODE_SELL then
		getProxy = var_8_2
		IslandProxy = var_8_3
		var_8_3 = var_8_2(var_8_3)
		var_8_3 = var_3.GetIsland(var_8_3)
		var_8_3 = var_3.GetTradeAgency(var_8_3)

		local var_8_4

		var_8_4, var_8_3 = var_3.GetSellRanks(var_8_3)
		var_8_1 = var_8_3
		var_8_0 = var_8_4
	else
		local var_8_5 = arg_8_0.mode

		IslandTradePage = var_8_3

		if var_8_5 == var_8_3.MODE_PURCHAS then
			getProxy = var_8_5
			IslandProxy = var_8_3
			var_8_3 = var_8_5(var_8_3)
			var_8_3 = var_3.GetIsland(var_8_3)
			var_8_3 = var_3.GetTradeAgency(var_8_3)

			local var_8_6

			var_8_6, var_8_3 = var_3.GetRanks(var_8_3)
			var_8_1 = var_8_3
			var_8_0 = var_8_6
		end
	end

	local var_8_7 = {}

	table = var_8_3

	var_8_3.insert(var_8_7, var_8_1)

	ipairs = var_4

	for iter_8_0, iter_8_1 in var_4(var_8_0) do
		if iter_8_1:IsVaild() then
			table = var_9

			var_9.insert(var_8_7, iter_8_1)
		end
	end

	table = var_4

	var_4.sort(var_8_7, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_8_0.mode

		IslandTradePage = var_2_10003

		if var_9_0 == var_2_10003.MODE_SELL then
			local var_9_1 = arg_9_0.value

			return arg_9_1.value < var_9_1
		else
			local var_9_2 = arg_8_0.mode

			IslandTradePage = var_3

			if var_9_2 == var_3.MODE_PURCHAS then
				return arg_9_0.value < arg_9_1.value
			end
		end

		return
	end)

	local var_8_8 = {}
	local var_8_9 = 0
	local var_8_10 = 0

	ipairs = iter_8_0

	for iter_8_2, iter_8_3 in iter_8_0(var_8_7) do
		if iter_8_3.value ~= var_8_9 then
			var_8_10 = var_8_10 + 1
			var_8_8[iter_8_3.value] = var_8_10
			var_8_9 = iter_8_3.value
		end
	end

	return var_8_1, var_8_7, var_8_8
end

function var_0_1.RequestRank(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.emit

	IslandBaseMediator = var_1_10004

	var_10_1(var_10_0, var_1_10004.REQ_TRADE_RANK, arg_10_1)

	return
end

function var_0_1.DisplayResult(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.displays = {}
	ipairs = var_3

	for iter_11_0, iter_11_1 in var_3(arg_11_1) do
		if iter_11_1.id ~= arg_11_2.id then
			table = var_8

			var_8.insert(arg_11_0.displays, iter_11_1)
		end
	end

	local var_11_0 = arg_11_0.scrollrect

	var_3.SetTotalCount(var_11_0, #arg_11_0.displays)

	return
end

function var_0_1.OnInitItem(arg_12_0, arg_12_1)
	IslandTradeRankCard = var_1_10002

	local var_12_0 = var_1_10002.New(arg_12_1)

	onButton = var_3

	local var_12_1 = arg_12_0
	local var_12_2 = var_12_0.visitBtn

	local function var_12_3()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		IslandBaseMediator = var_2_10002

		var_13_1(var_13_0, var_2_10002.ENTER_ISLAND, var_12_0.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_12_1, var_12_2, var_12_3, var_1_10007)

	arg_12_0.cards[arg_12_1] = var_12_0

	return
end

function var_0_1.OnUpdateItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0

	if not arg_14_0.cards[arg_14_2] then
		arg_14_0:OnInitItem(arg_14_2)

		var_14_0 = arg_14_0.cards[arg_14_2]
	end

	local var_14_1 = arg_14_0.displays[arg_14_1 + 1]
	local var_14_2 = arg_14_0.rankNums[var_14_1.value]

	assert = var_6

	var_6(var_14_2, var_14_1.value)
	var_14_0:Update(var_14_2, var_14_1, arg_14_1)

	return
end

function var_0_1.UpdateSelfRank(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.rankNums[arg_15_1.value]
	local var_15_1 = arg_15_0.selfRankCard

	var_3.Update(var_15_1, var_15_0, arg_15_1, 0)

	onButton = var_3

	local var_15_2 = arg_15_0
	local var_15_3 = arg_15_0.selfRankCard.inviteBtn

	local function var_15_4()
		local var_16_0 = arg_15_0
		local var_16_1 = var_0.emit

		IslandTradePage = var_2_10002

		var_16_1(var_16_0, var_2_10002.OPEN_INVITE_PAGE)

		return
	end

	SFX_PANEL = var_7

	var_3(var_15_2, var_15_3, var_15_4, var_7)

	return
end

function var_0_1.OnDestory(arg_17_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_17_0.scrollrect)

	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.cards) do
		iter_17_1:Dispose()
	end

	arg_17_0.cards = nil

	local var_17_0 = arg_17_0.selfRankCard

	var_1.Dispose(var_17_0)

	return
end

return var_0_1
