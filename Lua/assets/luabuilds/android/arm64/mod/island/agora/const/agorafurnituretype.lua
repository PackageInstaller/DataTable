local var_0_0 = class("AgoraFurnitureType")

var_0_0.FOUNDATION = 1
var_0_0.BUILDING = 2
var_0_0.FURNITURE = 3
var_0_0.DECORAION = 4
var_0_0.FLOOR = 5
var_0_0.TILE = 6
var_0_0.COLLECTION = 7
var_0_0.TILE_NEW = 8

local var_0_1 = {
	[var_0_0.FOUNDATION] = i18n("island_agora_label_base"),
	[var_0_0.BUILDING] = i18n("island_agora_label_building"),
	[var_0_0.FURNITURE] = i18n("island_agora_label_furniture"),
	[var_0_0.DECORAION] = i18n("island_agora_label_dec"),
	[var_0_0.FLOOR] = i18n("island_agora_label_floor"),
	[var_0_0.TILE] = i18n("island_agora_label_tile"),
	[var_0_0.COLLECTION] = i18n("island_agora_label_collection"),
	[var_0_0.TILE_NEW] = i18n("island_agora_label_tile")
}

function var_0_0.Type2CN(arg_1_0)
	return var_0_1[arg_1_0]
end

var_0_0.PLACEMENT_TYPE = {
	var_0_0.FOUNDATION,
	var_0_0.BUILDING,
	var_0_0.FURNITURE,
	var_0_0.DECORAION,
	var_0_0.TILE_NEW,
	var_0_0.COLLECTION
}
var_0_0.SORT_DEFAULT = 1
var_0_0.SORT_RARITY = 2
var_0_0.SORT_TIME = 3
var_0_0.SORT_CAPACITY = 4
var_0_0.SORT_LIST = {
	var_0_0.SORT_DEFAULT,
	var_0_0.SORT_RARITY,
	var_0_0.SORT_TIME,
	var_0_0.SORT_CAPACITY
}

local var_0_2 = {
	[var_0_0.SORT_DEFAULT] = i18n("island_agora_label_default"),
	[var_0_0.SORT_RARITY] = i18n("island_agora_label_rarity"),
	[var_0_0.SORT_TIME] = i18n("island_agora_label_gettime"),
	[var_0_0.SORT_CAPACITY] = i18n("island_agora_label_capacity")
}

function var_0_0.Sort2CN(arg_2_0)
	return var_0_2[arg_2_0]
end

return var_0_0
