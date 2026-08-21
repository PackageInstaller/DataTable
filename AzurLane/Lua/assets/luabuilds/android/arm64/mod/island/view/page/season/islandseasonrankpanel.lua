local var_0_0 = class("IslandSeasonRankPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSeasonRankPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("content")

	arg_2_0.tipTF = var_2_0:Find("tip")

	setText(arg_2_0.tipTF, i18n("island_season_charts_refresh"))

	local var_2_1 = var_2_0:Find("header")

	setText(var_2_1:Find("rank"), i18n("island_season_charts_ranking"))
	setText(var_2_1:Find("info"), i18n("island_season_charts_information"))
	setText(var_2_1:Find("pt"), i18n("island_season_charts_pt"))
	setText(var_2_1:Find("award"), i18n("island_season_charts_award"))

	arg_2_0.playerRankTF = var_2_0:Find("player_rank")

	setActive(arg_2_0.playerRankTF, false)

	arg_2_0.rankRect = var_2_0:Find("ranks"):GetComponent("LScrollRect")
	arg_2_0.listEmptyTF = var_2_0:Find("ranks/empty")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.rankType = PowerRank.TYPE_ISLAND_SEASON_PT
	arg_3_0.cards = {}
	arg_3_0.rankVOs = {}
	arg_3_0.playerRankVOs = {}

	function arg_3_0.rankRect.onInitItem(arg_4_0)
		arg_3_0:OnInitItem(arg_4_0)

		return
	end

	function arg_3_0.rankRect.onUpdateItem(arg_5_0, arg_5_1)
		arg_3_0:OnUpdateItem(arg_5_0, arg_5_1)

		return
	end

	arg_3_0.playerCard = IslandRankCard.New(arg_3_0.playerRankTF, IslandRankCard.TYPE_SELF, arg_3_0)
	arg_3_0.newestId = IslandSeasonAgency.GetCurrentSeason()

	if arg_3_0.newestId > 1 then
		-- block empty
	end

	return
end

function var_0_0.OnInitItem(arg_6_0, arg_6_1)
	arg_6_0.cards[arg_6_1] = IslandRankCard.New(arg_6_1, IslandRankCard.TYPE_OTHER, arg_6_0)

	return
end

function var_0_0.OnUpdateItem(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.cards[arg_7_2] then
		arg_7_0:OnInitItem(arg_7_2)
	end

	arg_7_0.cards[arg_7_2]:Update(arg_7_0.displayRankVOs[arg_7_1 + 1], arg_7_0.seasonId)

	return
end

function var_0_0.Show(arg_8_0)
	arg_8_0.super.Show(arg_8_0)
	arg_8_0:Flush(arg_8_0.newestId)
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_17")

	return
end

function var_0_0.Flush(arg_9_0, arg_9_1)
	arg_9_0.seasonId = arg_9_1

	if arg_9_0.rankVOs[arg_9_0.seasonId] then
		if getProxy(BillboardProxy):canFetch(arg_9_0.rankType, arg_9_0.seasonId) then
			arg_9_0:emit(IslandMediator.ON_GET_SEASON_RANK, arg_9_0.rankType, arg_9_0.seasonId)
		else
			arg_9_0:UpdataRankView()
		end

		return
	end
end

function var_0_0.UpdateRankVOs(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.rankVOs[arg_10_1] = arg_10_2
	arg_10_0.playerRankVOs[arg_10_1] = arg_10_3

	return
end

function var_0_0.UpdataRankView(arg_11_0)
	arg_11_0.displayRankVOs = {}

	local var_11_1 = arg_11_0.rankVOs[arg_11_0.seasonId] or {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		table.insert(arg_11_0.displayRankVOs, iter_11_1)
	end

	arg_11_0.rankRect:SetTotalCount(#arg_11_0.displayRankVOs)
	setActive(arg_11_0.listEmptyTF, #arg_11_0.displayRankVOs <= 0)
	setActive(arg_11_0.playerRankTF, arg_11_0.playerRankVOs[arg_11_0.seasonId])

	if arg_11_0.playerRankVOs[arg_11_0.seasonId] then
		arg_11_0.playerCard:Update(arg_11_0.playerRankVOs[arg_11_0.seasonId], arg_11_0.seasonId)
	end

	setActive(arg_11_0.tipTF, arg_11_0.seasonId == arg_11_0.newestId)

	return
end

function var_0_0.OnDestory(arg_12_0)
	ClearLScrollrect(arg_12_0.rankRect)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.cards) do
		iter_12_1:Dispose()
	end

	arg_12_0.cards = nil

	arg_12_0.playerCard:Dispose()

	return
end

return var_0_0
