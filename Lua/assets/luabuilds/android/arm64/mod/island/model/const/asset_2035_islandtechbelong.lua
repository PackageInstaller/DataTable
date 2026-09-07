local IslandTechBelong = class("IslandTechBelong")

IslandTechBelong.CENTRE = 1
IslandTechBelong.GATHER = 2
IslandTechBelong.PLANT = 3
IslandTechBelong.FEED = 4
IslandTechBelong.COOK = 5
IslandTechBelong.MECHINE = 6
IslandTechBelong.Fields = {
	[IslandTechBelong.CENTRE] = "centre",
	[IslandTechBelong.GATHER] = "gather",
	[IslandTechBelong.COOK] = "cook",
	[IslandTechBelong.FEED] = "feed",
	[IslandTechBelong.PLANT] = "plant",
	[IslandTechBelong.MECHINE] = "mechine"
}
IslandTechBelong.Names = {
	[IslandTechBelong.CENTRE] = i18n("island_tech_type_1"),
	[IslandTechBelong.GATHER] = i18n("island_ship_attrName_2"),
	[IslandTechBelong.COOK] = i18n("island_ship_attrName_4"),
	[IslandTechBelong.FEED] = i18n("island_ship_attrName_3"),
	[IslandTechBelong.PLANT] = i18n("island_ship_attrName_1"),
	[IslandTechBelong.MECHINE] = i18n("island_ship_attrName_6")
}
IslandTechBelong.SPECIAL_SHOW_TYPE = IslandTechBelong.CENTRE
IslandTechBelong.COMMON_SHOW_TYPES = {
	IslandTechBelong.GATHER,
	IslandTechBelong.PLANT,
	IslandTechBelong.FEED,
	IslandTechBelong.COOK,
	IslandTechBelong.MECHINE
}

return IslandTechBelong
