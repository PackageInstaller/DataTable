class = var_0_10000

local var_0_0 = var_0_10000("StoreHouseConst")

var_0_0.WARP_TO_DESIGN = "WARP_TO_DESIGN"
var_0_0.WARP_TO_MATERIAL = "WARP_TO_MATERIAL"
var_0_0.WARP_TO_WEAPON = "WARP_TO_WEAPON"
var_0_0.OVERVIEW = "StoreHouseScene_OVERVIEW"
var_0_0.DESTROY = "StoreHouseScene_DESTROY"
var_0_0.EQUIPMENT = "StoreHouseScene_EQUIPMENT"
var_0_0.SKIN = "StoreHouseScene_SKIN"
var_0_0.SPWEAPON = "StoreHouseScene_SPWEAPON"

local var_0_1 = {}
local var_0_2 = {
	minHeight = 650
}
local var_0_3 = {}

CustomIndexLayer = var_0_10004
var_0_3.mode = var_0_10004.Mode.OR
IndexConst = var_4
var_0_3.options = var_4.EquipmentTypeIndexs
IndexConst = var_4
var_0_3.names = var_4.EquipmentTypeNames
var_0_2.typeIndex = var_0_3

local var_0_4 = {}

CustomIndexLayer = var_4
var_0_4.mode = var_4.Mode.OR
IndexConst = var_4
var_0_4.options = var_4.EquipPropertyIndexs
IndexConst = var_4
var_0_4.names = var_4.EquipPropertyNames
var_0_2.equipPropertyIndex = var_0_4

local var_0_5 = {}

CustomIndexLayer = var_4
var_0_5.mode = var_4.Mode.OR
IndexConst = var_4
var_0_5.options = var_4.EquipPropertyIndexs
IndexConst = var_4
var_0_5.names = var_4.EquipPropertyNames
var_0_2.equipPropertyIndex2 = var_0_5

local var_0_6 = {}

CustomIndexLayer = var_4
var_0_6.mode = var_4.Mode.OR
IndexConst = var_4
var_0_6.options = var_4.EquipAmmoIndexs_1
IndexConst = var_4
var_0_6.names = var_4.EquipAmmoIndexs_1_Names
var_0_2.equipAmmoIndex1 = var_0_6

local var_0_7 = {}

CustomIndexLayer = var_4
var_0_7.mode = var_4.Mode.OR
IndexConst = var_4
var_0_7.options = var_4.EquipAmmoIndexs_2
IndexConst = var_4
var_0_7.names = var_4.EquipAmmoIndexs_2_Names
var_0_2.equipAmmoIndex2 = var_0_7

local var_0_8 = {}

CustomIndexLayer = var_4
var_0_8.mode = var_4.Mode.AND
IndexConst = var_4
var_0_8.options = var_4.EquipCampIndexs
IndexConst = var_4
var_0_8.names = var_4.EquipCampNames
var_0_2.equipCampIndex = var_0_8

local var_0_9 = {}

CustomIndexLayer = var_4
var_0_9.mode = var_4.Mode.AND
IndexConst = var_4
var_0_9.options = var_4.EquipmentRarityIndexs
IndexConst = var_4
var_0_9.names = var_4.RarityNames
var_0_2.rarityIndex = var_0_9

local var_0_10 = {}

CustomIndexLayer = var_4
var_0_10.mode = var_4.Mode.OR
IndexConst = var_4
var_0_10.options = var_4.EquipmentExtraIndexs
IndexConst = var_4
var_0_10.names = var_4.EquipmentExtraNames
var_0_2.extraIndex = var_0_10
var_0_1.customPanels = var_0_2
var_0_1.groupList = {
	{
		dropdown = false,
		titleENTxt = "indexsort_typeeng",
		titleTxt = "indexsort_type",
		tags = {
			"typeIndex"
		}
	},
	{
		dropdown = true,
		titleENTxt = "indexsort_indexeng",
		titleTxt = "indexsort_index",
		tags = {
			"equipPropertyIndex",
			"equipPropertyIndex2",
			"equipAmmoIndex1",
			"equipAmmoIndex2"
		}
	},
	{
		dropdown = false,
		titleENTxt = "indexsort_campeng",
		titleTxt = "indexsort_camp",
		tags = {
			"equipCampIndex"
		}
	},
	{
		dropdown = false,
		titleENTxt = "indexsort_rarityeng",
		titleTxt = "indexsort_rarity",
		tags = {
			"rarityIndex"
		}
	},
	{
		dropdown = false,
		titleENTxt = "indexsort_indexeng",
		titleTxt = "indexsort_extraindex",
		tags = {
			"extraIndex"
		}
	}
}

local var_0_11 = {}
local var_0_12 = {}
local var_0_13 = {}

IndexConst = var_0_10005
var_0_13.typeIndex = var_0_10005.EquipmentTypeAll
var_0_12.include = var_0_13
var_0_12.exclude = {}
var_0_11.equipPropertyIndex = var_0_12

local var_0_14 = {}
local var_0_15 = {}

IndexConst = var_5
var_0_15.typeIndex = var_5.EquipmentTypeEquip
var_0_14.include = var_0_15

local var_0_16 = {}

IndexConst = var_5
var_0_16.typeIndex = var_5.EquipmentTypeAll
var_0_14.exclude = var_0_16
var_0_11.equipPropertyIndex2 = var_0_14

local var_0_17 = {}
local var_0_18 = {}

IndexConst = var_5

local var_0_19 = var_5.BitAll
local var_0_20 = {}

IndexConst = var_0_10008
var_0_20[1] = var_0_10008.EquipmentTypeSmallCannon
IndexConst = var_8
var_0_20[2] = var_8.EquipmentTypeMediumCannon
IndexConst = var_8
var_0_20[3] = var_8.EquipmentTypeBigCannon
var_0_18.typeIndex = var_0_19(var_0_20)
var_0_17.include = var_0_18

local var_0_21 = {}

IndexConst = var_5
var_0_21.typeIndex = var_5.EquipmentTypeAll
var_0_17.exclude = var_0_21
var_0_11.equipAmmoIndex1 = var_0_17

local var_0_22 = {}
local var_0_23 = {}

IndexConst = var_5

local var_0_24 = var_5.BitAll
local var_0_25 = {}

IndexConst = var_8
var_0_25[1] = var_8.EquipmentTypeWarshipTorpedo
IndexConst = var_8
var_0_25[2] = var_8.EquipmentTypeSubmaraineTorpedo
var_0_23.typeIndex = var_0_24(var_0_25)
var_0_22.include = var_0_23

local var_0_26 = {}

IndexConst = var_5
var_0_26.typeIndex = var_5.EquipmentTypeAll
var_0_22.exclude = var_0_26
var_0_11.equipAmmoIndex2 = var_0_22
var_0_1.dropdownLimit = var_0_11
var_0_0.EQUIPMENT_INDEX_COMMON = var_0_1

local var_0_27 = {}
local var_0_28 = {}
local var_0_29 = {}

CustomIndexLayer = var_0_26
var_0_29.mode = var_0_26.Mode.OR
IndexConst = var_4
var_0_29.options = var_4.SpWeaponTypeIndexs
IndexConst = var_4
var_0_29.names = var_4.SpWeaponTypeNames
var_0_28.typeIndex = var_0_29

local var_0_30 = {}

CustomIndexLayer = var_4
var_0_30.mode = var_4.Mode.AND
IndexConst = var_4
var_0_30.options = var_4.SpWeaponRarityIndexs
IndexConst = var_4
var_0_30.names = var_4.SpWeaponRarityNames
var_0_28.rarityIndex = var_0_30
var_0_27.customPanels = var_0_28
var_0_27.groupList = {
	{
		dropdown = false,
		titleENTxt = "indexsort_typeeng",
		titleTxt = "indexsort_type",
		tags = {
			"typeIndex"
		}
	},
	{
		dropdown = false,
		titleENTxt = "indexsort_rarityeng",
		titleTxt = "indexsort_rarity",
		tags = {
			"rarityIndex"
		}
	}
}
var_0_0.SPWEAPON_INDEX_COMMON = var_0_27

return var_0_0
