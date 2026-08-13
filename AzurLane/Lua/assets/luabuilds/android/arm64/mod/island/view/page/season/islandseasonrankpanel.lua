class = var_0_10000

local var_0_0 = "IslandSeasonRankPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSeasonRankPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "content")

	arg_2_0.tipTF = var_1.Find(var_2_1, "tip")
	setText = var_2

	local var_2_2 = arg_2_0.tipTF

	i18n = var_5

	var_2(var_2_2, var_5("island_season_charts_refresh"))

	local var_2_3 = var_1:Find("header")

	setText = var_2_0

	local var_2_4 = var_2_3:Find("rank")

	i18n = var_1_10006

	var_2_0(var_2_4, var_1_10006("island_season_charts_ranking"))

	setText = var_2_0

	local var_2_5 = var_2_3:Find("info")

	i18n = var_6

	var_2_0(var_2_5, var_6("island_season_charts_information"))

	setText = var_2_0

	local var_2_6 = var_2_3:Find("pt")

	i18n = var_6

	var_2_0(var_2_6, var_6("island_season_charts_pt"))

	setText = var_2_0

	local var_2_7 = var_2_3:Find("award")

	i18n = var_6

	var_2_0(var_2_7, var_6("island_season_charts_award"))

	arg_2_0.playerRankTF = var_1:Find("player_rank")
	setActive = var_3

	var_3(arg_2_0.playerRankTF, false)

	local var_2_8 = var_1:Find("ranks")

	arg_2_0.rankRect = var_3.GetComponent(var_2_8, "LScrollRect")
	arg_2_0.listEmptyTF = var_1:Find("ranks/empty")

	return
end

function var_0_1.OnInit(arg_3_0)
	PowerRank = var_1_10001
	arg_3_0.rankType = var_1_10001.TYPE_ISLAND_SEASON_PT
	arg_3_0.cards = {}
	arg_3_0.rankVOs = {}
	arg_3_0.playerRankVOs = {}

	function arg_3_0.rankRect.onInitItem(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.OnInitItem(var_4_0, arg_4_0)

		return
	end

	local var_3_0 = arg_3_0.rankRect

	function var_3_0.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.OnUpdateItem(var_5_0, arg_5_0, arg_5_1)

		return
	end

	IslandRankCard = var_3_0

	local var_3_1 = var_3_0.New
	local var_3_2 = arg_3_0.playerRankTF

	IslandRankCard = var_1_10004
	arg_3_0.playerCard = var_3_1(var_3_2, var_1_10004.TYPE_SELF, arg_3_0)
	IslandSeasonAgency = var_1
	arg_3_0.newestId = var_1.GetCurrentSeason()

	if arg_3_0.newestId > 1 then
		-- block empty
	end

	return
end

function var_0_1.OnInitItem(arg_6_0, arg_6_1)
	IslandRankCard = var_1_10002

	local var_6_0 = var_1_10002.New
	local var_6_1 = arg_6_1

	IslandRankCard = var_1_10005

	local var_6_2 = var_6_0(var_6_1, var_1_10005.TYPE_OTHER, arg_6_0)

	arg_6_0.cards[arg_6_1] = var_6_2

	return
end

function var_0_1.OnUpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if not arg_7_0.cards[arg_7_2] then
		arg_7_0:OnInitItem(arg_7_2)

		var_7_0 = arg_7_0.cards[arg_7_2]
	end

	local var_7_1 = arg_7_0.displayRankVOs[arg_7_1 + 1]

	var_7_0:Update(var_7_1, arg_7_0.seasonId)

	return
end

function var_0_1.Show(arg_8_0)
	arg_8_0.super.Show(arg_8_0)
	arg_8_0:Flush(arg_8_0.newestId)

	IslandGuideChecker = var_1

	var_1.CheckGuide("ISLAND_GUIDE_17")

	return
end

function var_0_1.Flush(arg_9_0, arg_9_1)
	arg_9_0.seasonId = arg_9_1

	if arg_9_0.rankVOs[arg_9_0.seasonId] then
		getProxy = var_3
		BillboardProxy = var_1_10005

		local var_9_0 = var_3(var_1_10005)

		if var_3.canFetch(var_9_0, arg_9_0.rankType, arg_9_0.seasonId) then
			local var_9_1 = arg_9_0
			local var_9_2 = arg_9_0.emit

			IslandMediator = var_1_10006

			var_9_2(var_9_1, var_1_10006.ON_GET_SEASON_RANK, arg_9_0.rankType, arg_9_0.seasonId)
		else
			arg_9_0:UpdataRankView()
		end

		return
	end
end

function var_0_1.UpdateRankVOs(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.rankVOs[arg_10_1] = arg_10_2
	arg_10_0.playerRankVOs[arg_10_1] = arg_10_3

	return
end

function var_0_1.UpdataRankView(arg_11_0)
	arg_11_0.displayRankVOs = {}

	local var_11_0 = arg_11_0.rankVOs[arg_11_0.seasonId]

	ipairs = var_2

	local var_11_1

	if not arg_11_0.rankVOs[arg_11_0.seasonId] then
		var_11_1 = {}
	end

	for iter_11_0, iter_11_1 in var_2(var_11_1) do
		table = var_1_10007

		var_1_10007.insert(arg_11_0.displayRankVOs, iter_11_1)
	end

	local var_11_2 = arg_11_0.rankRect

	var_2.SetTotalCount(var_11_2, #arg_11_0.displayRankVOs)

	setActive = var_2

	var_2(arg_11_0.listEmptyTF, #arg_11_0.displayRankVOs <= 0)

	local var_11_3 = arg_11_0.playerRankVOs[arg_11_0.seasonId]

	setActive = var_3

	var_3(arg_11_0.playerRankTF, var_11_3)

	if var_11_3 then
		local var_11_4 = arg_11_0.playerCard

		var_3.Update(var_11_4, var_11_3, arg_11_0.seasonId)
	end

	setActive = var_3

	var_3(arg_11_0.tipTF, arg_11_0.seasonId == arg_11_0.newestId)

	return
end

function var_0_1.OnDestory(arg_12_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_12_0.rankRect)

	ipairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.cards) do
		iter_12_1:Dispose()
	end

	arg_12_0.cards = nil

	local var_12_0 = arg_12_0.playerCard

	var_1.Dispose(var_12_0)

	return
end

return var_0_1
