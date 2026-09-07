local StoreHouseConst = class("StoreHouseConst")

StoreHouseConst.WARP_TO_DESIGN = "WARP_TO_DESIGN"
StoreHouseConst.WARP_TO_MATERIAL = "WARP_TO_MATERIAL"
StoreHouseConst.WARP_TO_WEAPON = "WARP_TO_WEAPON"
StoreHouseConst.OVERVIEW = "StoreHouseScene_OVERVIEW"
StoreHouseConst.DESTROY = "StoreHouseScene_DESTROY"
StoreHouseConst.EQUIPMENT = "StoreHouseScene_EQUIPMENT"
StoreHouseConst.SKIN = "StoreHouseScene_SKIN"
StoreHouseConst.SPWEAPON = "StoreHouseScene_SPWEAPON"
StoreHouseConst.EQUIPMENT_INDEX_COMMON = {
	customPanels = {
		minHeight = 650,
		typeIndex = {
			mode = CustomIndexLayer.Mode.OR,
			options = IndexConst.EquipmentTypeIndexs,
			names = IndexConst.EquipmentTypeNames
		},
		equipPropertyIndex = {
			mode = CustomIndexLayer.Mode.OR,
			options = IndexConst.EquipPropertyIndexs,
			names = IndexConst.EquipPropertyNames
		},
		equipPropertyIndex2 = {
			mode = CustomIndexLayer.Mode.OR,
			options = IndexConst.EquipPropertyIndexs,
			names = IndexConst.EquipPropertyNames
		},
		equipAmmoIndex1 = {
			mode = CustomIndexLayer.Mode.OR,
			options = IndexConst.EquipAmmoIndexs_1,
			names = IndexConst.EquipAmmoIndexs_1_Names
		},
		equipAmmoIndex2 = {
			mode = CustomIndexLayer.Mode.OR,
			options = IndexConst.EquipAmmoIndexs_2,
			names = IndexConst.EquipAmmoIndexs_2_Names
		},
		equipCampIndex = {
			mode = CustomIndexLayer.Mode.AND,
			options = IndexConst.EquipCampIndexs,
			names = IndexConst.EquipCampNames
		},
		rarityIndex = {
			mode = CustomIndexLayer.Mode.AND,
			options = IndexConst.EquipmentRarityIndexs,
			names = IndexConst.RarityNames
		},
		extraIndex = {
			mode = CustomIndexLayer.Mode.OR,
			options = IndexConst.EquipmentExtraIndexs,
			names = IndexConst.EquipmentExtraNames
		}
	},
	groupList = {
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
	},
	dropdownLimit = {
		equipPropertyIndex = {
			include = {
				typeIndex = IndexConst.EquipmentTypeAll
			},
			exclude = {}
		},
		equipPropertyIndex2 = {
			include = {
				typeIndex = IndexConst.EquipmentTypeEquip
			},
			exclude = {
				typeIndex = IndexConst.EquipmentTypeAll
			}
		},
		equipAmmoIndex1 = {
			include = {
				typeIndex = IndexConst.BitAll({
					IndexConst.EquipmentTypeSmallCannon,
					IndexConst.EquipmentTypeMediumCannon,
					IndexConst.EquipmentTypeBigCannon
				})
			},
			exclude = {
				typeIndex = IndexConst.EquipmentTypeAll
			}
		},
		equipAmmoIndex2 = {
			include = {
				typeIndex = IndexConst.BitAll({
					IndexConst.EquipmentTypeWarshipTorpedo,
					IndexConst.EquipmentTypeSubmaraineTorpedo
				})
			},
			exclude = {
				typeIndex = IndexConst.EquipmentTypeAll
			}
		}
	}
}
StoreHouseConst.SPWEAPON_INDEX_COMMON = {
	customPanels = {
		typeIndex = {
			mode = CustomIndexLayer.Mode.OR,
			options = IndexConst.SpWeaponTypeIndexs,
			names = IndexConst.SpWeaponTypeNames
		},
		rarityIndex = {
			mode = CustomIndexLayer.Mode.AND,
			options = IndexConst.SpWeaponRarityIndexs,
			names = IndexConst.SpWeaponRarityNames
		}
	},
	groupList = {
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
}

return StoreHouseConst
