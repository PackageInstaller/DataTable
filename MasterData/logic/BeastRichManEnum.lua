-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/model/BeastRichManEnum.lua

module("logic.extensions.beastrichman.model.BeastRichManEnum", package.seeall)

local BeastRichManEnum = {}

BeastRichManEnum.MapGoType = {
	Boss = 4,
	Bg = 1,
	Event = 3,
	Path = 2
}
BeastRichManEnum.CellType = {
	Game = 5,
	Shop = 11,
	GainCard = 7,
	SmallShop = 8,
	Benefit = 1,
	PayMoney = 10,
	Bank = 13,
	Wheel = 12,
	StorySelect = 3,
	BookStore = 9,
	Storm = 2,
	Empty = 0,
	GainDice = 6,
	StoryPlay = 4,
	None = -1
}
BeastRichManEnum.MapRootType = {
	PathRoot = 2,
	BgRoot = 1,
	EventBackRoot = 3,
	EventFrontRoot = 4
}
BeastRichManEnum.RankTabType = {
	Score = "rank_gain",
	Sub = "rank_sub",
	Total = "rank_total"
}
BeastRichManEnum.BossType = {
	Break = 2,
	Boss = 1
}
BeastRichManEnum.DiceType = {
	Fix = 2,
	Random = 1
}
BeastRichManEnum.EventType = {
	PayMoney = 1,
	Wheel = 3,
	Shop = 2,
	Build = 5,
	Bank = 4
}
BeastRichManEnum.BuildingType = {
	BookShop = 2,
	Store = 1
}
BeastRichManEnum.DiceType = {
	Fix = 2,
	Random = 1
}
BeastRichManEnum.MapType = {
	Boss = 3,
	Event = 2,
	Path = 1
}
BeastRichManEnum.StoryType = {
	Select = 1,
	Play = 2
}
BeastRichManEnum.CardType = {
	JuMang = 2,
	Slow = 6,
	JinWu = 3,
	LevelUp = 4,
	HuXian = 1,
	Stop = 5
}

return BeastRichManEnum
