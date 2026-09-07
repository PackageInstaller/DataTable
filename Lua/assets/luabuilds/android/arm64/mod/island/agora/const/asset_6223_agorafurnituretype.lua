local AgoraFurnitureType = class("AgoraFurnitureType")

AgoraFurnitureType.FOUNDATION = 1
AgoraFurnitureType.BUILDING = 2
AgoraFurnitureType.FURNITURE = 3
AgoraFurnitureType.DECORAION = 4
AgoraFurnitureType.FLOOR = 5
AgoraFurnitureType.TILE = 6
AgoraFurnitureType.COLLECTION = 7
AgoraFurnitureType.TILE_NEW = 8

local var_0_1 = {
	[AgoraFurnitureType.FOUNDATION] = i18n("island_agora_label_base"),
	[AgoraFurnitureType.BUILDING] = i18n("island_agora_label_building"),
	[AgoraFurnitureType.FURNITURE] = i18n("island_agora_label_furniture"),
	[AgoraFurnitureType.DECORAION] = i18n("island_agora_label_dec"),
	[AgoraFurnitureType.FLOOR] = i18n("island_agora_label_floor"),
	[AgoraFurnitureType.TILE] = i18n("island_agora_label_tile"),
	[AgoraFurnitureType.COLLECTION] = i18n("island_agora_label_collection"),
	[AgoraFurnitureType.TILE_NEW] = i18n("island_agora_label_tile")
}

function AgoraFurnitureType:Type2CN()
	return var_0_1[self]
end

AgoraFurnitureType.PLACEMENT_TYPE = {
	AgoraFurnitureType.FOUNDATION,
	AgoraFurnitureType.BUILDING,
	AgoraFurnitureType.FURNITURE,
	AgoraFurnitureType.DECORAION,
	AgoraFurnitureType.TILE_NEW,
	AgoraFurnitureType.COLLECTION
}
AgoraFurnitureType.SORT_DEFAULT = 1
AgoraFurnitureType.SORT_RARITY = 2
AgoraFurnitureType.SORT_TIME = 3
AgoraFurnitureType.SORT_CAPACITY = 4
AgoraFurnitureType.SORT_LIST = {
	AgoraFurnitureType.SORT_DEFAULT,
	AgoraFurnitureType.SORT_RARITY,
	AgoraFurnitureType.SORT_TIME,
	AgoraFurnitureType.SORT_CAPACITY
}

local var_0_2 = {
	[AgoraFurnitureType.SORT_DEFAULT] = i18n("island_agora_label_default"),
	[AgoraFurnitureType.SORT_RARITY] = i18n("island_agora_label_rarity"),
	[AgoraFurnitureType.SORT_TIME] = i18n("island_agora_label_gettime"),
	[AgoraFurnitureType.SORT_CAPACITY] = i18n("island_agora_label_capacity")
}

function AgoraFurnitureType:Sort2CN()
	return var_0_2[self]
end

return AgoraFurnitureType
