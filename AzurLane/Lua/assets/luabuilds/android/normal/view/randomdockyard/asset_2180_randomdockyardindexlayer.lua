class = var_0_10000

local var_0_0 = "RandomDockYardIndexLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..common.CustomIndexLayer"))

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	arg_1_0.OnFilter = arg_1_0.contextData.OnFilter

	local var_1_0

	if not var_1.defaultIndex then
		var_1_0 = {}
	end

	arg_1_0.indexDatas = var_1_0

	return
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0.contextData = arg_2_0:InitData()

	var_0_1.super.didEnter(arg_2_0)

	return
end

function var_0_1.InitData(arg_3_0)
	local var_3_0 = {}

	Clone = var_1_10002
	var_3_0.indexDatas = var_1_10002(arg_3_0.indexDatas)

	local var_3_1 = {
		minHeight = 650
	}
	local var_3_2 = {
		isSort = true
	}

	CustomIndexLayer = var_1_10004
	var_3_2.mode = var_1_10004.Mode.OR
	ShipIndexConst = var_4
	var_3_2.options = var_4.SortIndexs
	ShipIndexConst = var_4
	var_3_2.names = var_4.SortNames
	var_3_1.sortIndex = var_3_2

	local var_3_3 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_3_3.mode = var_4.Mode.OR
	ShipIndexConst = var_4
	var_3_3.options = var_4.SortPropertyIndexs
	ShipIndexConst = var_4
	var_3_3.names = var_4.SortPropertyNames
	var_3_1.sortPropertyIndex = var_3_3

	local var_3_4 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_3_4.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_3_4.options = var_4.TypeIndexs
	ShipIndexConst = var_4
	var_3_4.names = var_4.TypeNames
	var_3_1.typeIndex = var_3_4

	local var_3_5 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_3_5.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_3_5.options = var_4.CampIndexs
	ShipIndexConst = var_4
	var_3_5.names = var_4.CampNames
	var_3_1.campIndex = var_3_5

	local var_3_6 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_3_6.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_3_6.options = var_4.RarityIndexs
	ShipIndexConst = var_4
	var_3_6.names = var_4.RarityNames
	var_3_1.rarityIndex = var_3_6

	local var_3_7 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_3_7.mode = var_4.Mode.OR
	ShipIndexConst = var_4
	var_3_7.options = var_4.ExtraIndexs
	ShipIndexConst = var_4
	var_3_7.names = var_4.ExtraNames
	var_3_1.extraIndex = var_3_7
	Vector2 = var_3_7
	var_3_1.layoutPos = var_3_7(0, -25)
	var_3_0.customPanels = var_3_1
	var_3_0.groupList = {
		{
			titleTxt = "indexsort_sort",
			dropdown = false,
			titleENTxt = "indexsort_sorteng",
			tags = {
				"sortIndex"
			},
			simpleDropdown = {
				"sortPropertyIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_indexeng",
			titleTxt = "indexsort_index",
			tags = {
				"typeIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_campeng",
			titleTxt = "indexsort_camp",
			tags = {
				"campIndex"
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

	function var_3_0.callback(arg_4_0)
		arg_3_0.OnFilter(arg_4_0)

		return
	end

	return var_3_0
end

return var_0_1
