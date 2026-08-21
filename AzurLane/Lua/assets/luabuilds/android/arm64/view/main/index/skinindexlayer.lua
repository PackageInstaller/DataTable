local var_0_0 = class("SkinIndexLayer", import("...common.CustomIndexLayer"))

var_0_0.ExtraL2D = bit.lshift(1, 0)
var_0_0.ExtraDBG = bit.lshift(1, 1)
var_0_0.ExtraBG = bit.lshift(1, 2)
var_0_0.ExtraBGM = bit.lshift(1, 3)
var_0_0.ExtraIndexs = {
	var_0_0.ExtraL2D,
	var_0_0.ExtraDBG,
	var_0_0.ExtraBG,
	var_0_0.ExtraBGM
}
var_0_0.ExtraALL = IndexConst.BitAll(var_0_0.ExtraIndexs)

table.insert(var_0_0.ExtraIndexs, 1, var_0_0.ExtraALL)

var_0_0.ExtraNames = {
	"index_all",
	"index_L2D",
	"index_DBG",
	"index_BG",
	"index_BGM"
}

local var_0_1 = {
	function()
		return true
	end,
	function(arg_2_0)
		return arg_2_0:IsLive2d()
	end,
	function(arg_3_0)
		return arg_3_0:IsDbg()
	end,
	function(arg_4_0)
		return arg_4_0:IsBG()
	end,
	function(arg_5_0)
		return arg_5_0:isBgm()
	end
}

function var_0_0.filterByExtra(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_1 == var_0_0.ExtraALL then
		return true
	end

	for iter_6_0 = 2, #var_0_1 do
		if bit.band(bit.lshift(1, iter_6_0 - 2), arg_6_1) > 0 and var_0_1[iter_6_0](arg_6_0) then
			return true
		end
	end

	return false
end

function var_0_0.init(arg_7_0)
	var_0_0.super.init(arg_7_0)

	arg_7_0.OnFilter = arg_7_0.contextData.OnFilter
	arg_7_0.indexDatas = arg_7_0.contextData.defaultIndex or {}

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0.contextData = arg_8_0:InitData()

	var_0_0.super.didEnter(arg_8_0)

	return
end

function var_0_0.BlurPanel(arg_9_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)

	return
end

function var_0_0.InitData(arg_10_0)
	return {
		indexDatas = Clone(arg_10_0.indexDatas),
		customPanels = {
			minHeight = 650,
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
				mode = CustomIndexLayer.Mode.AND,
				options = var_0_0.ExtraIndexs,
				names = var_0_0.ExtraNames
			},
			layoutPos = Vector2(0, -25)
		},
		groupList = {
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
		callback = function(arg_11_0)
			arg_10_0.OnFilter(arg_11_0)

			return
		end
	}
end

return var_0_0
