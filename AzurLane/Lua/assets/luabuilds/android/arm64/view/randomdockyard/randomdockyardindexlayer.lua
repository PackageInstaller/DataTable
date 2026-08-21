local var_0_0 = class("RandomDockYardIndexLayer", import("..common.CustomIndexLayer"))

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)

	arg_1_0.OnFilter = arg_1_0.contextData.OnFilter
	arg_1_0.indexDatas = arg_1_0.contextData.defaultIndex or {}

	return
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0.contextData = arg_2_0:InitData()

	var_0_0.super.didEnter(arg_2_0)

	return
end

function var_0_0.InitData(arg_3_0)
	return {
		indexDatas = Clone(arg_3_0.indexDatas),
		customPanels = {
			minHeight = 650,
			sortIndex = {
				isSort = true,
				mode = CustomIndexLayer.Mode.OR,
				options = ShipIndexConst.SortIndexs,
				names = ShipIndexConst.SortNames
			},
			sortPropertyIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.OR,
				options = ShipIndexConst.SortPropertyIndexs,
				names = ShipIndexConst.SortPropertyNames
			},
			typeIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.AND,
				options = ShipIndexConst.TypeIndexs,
				names = ShipIndexConst.TypeNames
			},
			campIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.AND,
				options = ShipIndexConst.CampIndexs,
				names = ShipIndexConst.CampNames
			},
			rarityIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.AND,
				options = ShipIndexConst.RarityIndexs,
				names = ShipIndexConst.RarityNames
			},
			extraIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.OR,
				options = ShipIndexConst.ExtraIndexs,
				names = ShipIndexConst.ExtraNames
			},
			layoutPos = Vector2(0, -25)
		},
		groupList = {
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
		},
		callback = function(arg_4_0)
			arg_3_0.OnFilter(arg_4_0)

			return
		end
	}
end

return var_0_0
