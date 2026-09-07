local IslandSeasonRankPanel = class("IslandSeasonRankPanel", import("view.base.BaseSubView"))

function IslandSeasonRankPanel:getUIName()
	return "IslandSeasonRankPanel"
end

function IslandSeasonRankPanel:OnLoaded()
	local var_2_0 = self._tf:Find("content")

	self.tipTF = var_2_0:Find("tip")

	setText(self.tipTF, i18n("island_season_charts_refresh"))

	local var_2_1 = var_2_0:Find("header")

	setText(var_2_1:Find("rank"), i18n("island_season_charts_ranking"))
	setText(var_2_1:Find("info"), i18n("island_season_charts_information"))
	setText(var_2_1:Find("pt"), i18n("island_season_charts_pt"))
	setText(var_2_1:Find("award"), i18n("island_season_charts_award"))

	self.playerRankTF = var_2_0:Find("player_rank")

	setActive(self.playerRankTF, false)

	self.rankRect = var_2_0:Find("ranks"):GetComponent("LScrollRect")
	self.listEmptyTF = var_2_0:Find("ranks/empty")

	return
end

function IslandSeasonRankPanel:OnInit()
	self.rankType = PowerRank.TYPE_ISLAND_SEASON_PT
	self.cards = {}
	self.rankVOs = {}
	self.playerRankVOs = {}

	function self.rankRect.onInitItem(arg_4_0)
		self:OnInitItem(arg_4_0)

		return
	end

	function self.rankRect.onUpdateItem(arg_5_0, arg_5_1)
		self:OnUpdateItem(arg_5_0, arg_5_1)

		return
	end

	self.playerCard = IslandRankCard.New(self.playerRankTF, IslandRankCard.TYPE_SELF, self)
	self.newestId = IslandSeasonAgency.GetCurrentSeason()

	if self.newestId > 1 then
		-- block empty
	end

	return
end

function IslandSeasonRankPanel:OnInitItem(arg_6_1)
	self.cards[arg_6_1] = IslandRankCard.New(arg_6_1, IslandRankCard.TYPE_OTHER, self)

	return
end

function IslandSeasonRankPanel:OnUpdateItem(arg_7_1, arg_7_2)
	if not self.cards[arg_7_2] then
		self:OnInitItem(arg_7_2)
	end

	self.cards[arg_7_2]:Update(self.displayRankVOs[arg_7_1 + 1], self.seasonId)

	return
end

function IslandSeasonRankPanel:Show()
	self.super.Show(self)
	self:Flush(self.newestId)
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_17")

	return
end

function IslandSeasonRankPanel:Flush(arg_9_1)
	self.seasonId = arg_9_1

	if self.rankVOs[self.seasonId] then
		if getProxy(BillboardProxy):canFetch(self.rankType, self.seasonId) then
			self:emit(IslandMediator.ON_GET_SEASON_RANK, self.rankType, self.seasonId)

			goto label_9_0
		end
	end

	self:UpdataRankView()

	::label_9_0::

	return
end

function IslandSeasonRankPanel:UpdateRankVOs(arg_10_1, arg_10_2, arg_10_3)
	self.rankVOs[arg_10_1] = arg_10_2
	self.playerRankVOs[arg_10_1] = arg_10_3

	return
end

function IslandSeasonRankPanel:UpdataRankView()
	self.displayRankVOs = {}

	for iter_11_0, iter_11_1 in ipairs(self.rankVOs[self.seasonId] or {}) do
		table.insert(self.displayRankVOs, iter_11_1)
	end

	self.rankRect:SetTotalCount(#self.displayRankVOs)
	setActive(self.listEmptyTF, #self.displayRankVOs <= 0)
	setActive(self.playerRankTF, self.playerRankVOs[self.seasonId])

	if self.playerRankVOs[self.seasonId] then
		self.playerCard:Update(self.playerRankVOs[self.seasonId], self.seasonId)
	end

	setActive(self.tipTF, self.seasonId == self.newestId)

	return
end

function IslandSeasonRankPanel:OnDestory()
	ClearLScrollrect(self.rankRect)

	for iter_12_0, iter_12_1 in ipairs(self.cards) do
		iter_12_1:Dispose()
	end

	self.cards = nil

	self.playerCard:Dispose()

	return
end

return IslandSeasonRankPanel
