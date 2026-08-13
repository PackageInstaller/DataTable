class = var_0_10000

local var_0_0 = var_0_10000("IslandTechBelong")

var_0_0.CENTRE = 1
var_0_0.GATHER = 2
var_0_0.PLANT = 3
var_0_0.FEED = 4
var_0_0.COOK = 5
var_0_0.MECHINE = 6
var_0_0.Fields = {
	[var_0_0.CENTRE] = "centre",
	[var_0_0.GATHER] = "gather",
	[var_0_0.COOK] = "cook",
	[var_0_0.FEED] = "feed",
	[var_0_0.PLANT] = "plant",
	[var_0_0.MECHINE] = "mechine"
}

local var_0_1 = {}
local var_0_2 = var_0_0.CENTRE

i18n = var_3
var_0_1[var_0_2] = var_3("island_tech_type_1")

local var_0_3 = var_0_0.GATHER

i18n = var_3
var_0_1[var_0_3] = var_3("island_ship_attrName_2")

local var_0_4 = var_0_0.COOK

i18n = var_3
var_0_1[var_0_4] = var_3("island_ship_attrName_4")

local var_0_5 = var_0_0.FEED

i18n = var_3
var_0_1[var_0_5] = var_3("island_ship_attrName_3")

local var_0_6 = var_0_0.PLANT

i18n = var_3
var_0_1[var_0_6] = var_3("island_ship_attrName_1")

local var_0_7 = var_0_0.MECHINE

i18n = var_3
var_0_1[var_0_7] = var_3("island_ship_attrName_6")
var_0_0.Names = var_0_1
var_0_0.SPECIAL_SHOW_TYPE = var_0_0.CENTRE
var_0_0.COMMON_SHOW_TYPES = {
	var_0_0.GATHER,
	var_0_0.PLANT,
	var_0_0.FEED,
	var_0_0.COOK,
	var_0_0.MECHINE
}

return var_0_0
