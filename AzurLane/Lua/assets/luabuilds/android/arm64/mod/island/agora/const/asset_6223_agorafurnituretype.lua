class = var_0_10000

local var_0_0 = var_0_10000("AgoraFurnitureType")

var_0_0.FOUNDATION = 1
var_0_0.BUILDING = 2
var_0_0.FURNITURE = 3
var_0_0.DECORAION = 4
var_0_0.FLOOR = 5
var_0_0.TILE = 6
var_0_0.COLLECTION = 7
var_0_0.TILE_NEW = 8

local var_0_1 = {}
local var_0_2 = var_0_0.FOUNDATION

i18n = var_0_10003
var_0_1[var_0_2] = var_0_10003("island_agora_label_base")

local var_0_3 = var_0_0.BUILDING

i18n = var_3
var_0_1[var_0_3] = var_3("island_agora_label_building")

local var_0_4 = var_0_0.FURNITURE

i18n = var_3
var_0_1[var_0_4] = var_3("island_agora_label_furniture")

local var_0_5 = var_0_0.DECORAION

i18n = var_3
var_0_1[var_0_5] = var_3("island_agora_label_dec")

local var_0_6 = var_0_0.FLOOR

i18n = var_3
var_0_1[var_0_6] = var_3("island_agora_label_floor")

local var_0_7 = var_0_0.TILE

i18n = var_3
var_0_1[var_0_7] = var_3("island_agora_label_tile")

local var_0_8 = var_0_0.COLLECTION

i18n = var_3
var_0_1[var_0_8] = var_3("island_agora_label_collection")

local var_0_9 = var_0_0.TILE_NEW

i18n = var_3
var_0_1[var_0_9] = var_3("island_agora_label_tile")

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

local var_0_10 = {}
local var_0_11 = var_0_0.SORT_DEFAULT

i18n = var_0_10004
var_0_10[var_0_11] = var_0_10004("island_agora_label_default")

local var_0_12 = var_0_0.SORT_RARITY

i18n = var_4
var_0_10[var_0_12] = var_4("island_agora_label_rarity")

local var_0_13 = var_0_0.SORT_TIME

i18n = var_4
var_0_10[var_0_13] = var_4("island_agora_label_gettime")

local var_0_14 = var_0_0.SORT_CAPACITY

i18n = var_4
var_0_10[var_0_14] = var_4("island_agora_label_capacity")

function var_0_0.Sort2CN(arg_2_0)
	return var_0_10[arg_2_0]
end

return var_0_0
