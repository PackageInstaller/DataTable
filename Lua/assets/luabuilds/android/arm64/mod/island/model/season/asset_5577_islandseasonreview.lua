local IslandSeasonReview = class("IslandSeasonReview", import("model.vo.BaseVO"))

IslandSeasonReview.KEYS = {
	TECHNOLOGY = 3,
	MINIGAME = 9,
	FORMULA = 7,
	PT = 4,
	FISHING = 8,
	ORDER = 6,
	LEVEL = 1,
	SHIP = 2,
	PT_RANK = 5
}
IslandSeasonReview.KEY2NAME = {
	[IslandSeasonReview.KEYS.LEVEL] = i18n("island_season_charts_level"),
	[IslandSeasonReview.KEYS.SHIP] = i18n("island_season_review_charnum"),
	[IslandSeasonReview.KEYS.TECHNOLOGY] = i18n("island_season_review_projuctnum"),
	[IslandSeasonReview.KEYS.PT] = i18n("island_season_review_ptnum"),
	[IslandSeasonReview.KEYS.PT_RANK] = i18n("island_season_review_ptrank"),
	[IslandSeasonReview.KEYS.ORDER] = i18n("island_season_review_ordernum"),
	[IslandSeasonReview.KEYS.FORMULA] = i18n("island_season_review_formulanum"),
	[IslandSeasonReview.KEYS.FISHING] = i18n("island_season_review_fishnum"),
	[IslandSeasonReview.KEYS.MINIGAME] = i18n("island_season_review_gamenum")
}

function IslandSeasonReview:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.data = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.count_list or {}) do
		self.data[iter_1_1.key] = iter_1_1.value
	end

	return
end

function IslandSeasonReview:bindConfigTable()
	return pg.island_season
end

function IslandSeasonReview:GetRecordData(arg_3_1)
	return self.data[arg_3_1] or 0
end

return IslandSeasonReview
