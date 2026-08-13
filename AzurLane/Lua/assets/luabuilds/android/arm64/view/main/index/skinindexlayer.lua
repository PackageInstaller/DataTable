class = var_0_10000

local var_0_0 = "SkinIndexLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...common.CustomIndexLayer"))

bit = var_0_10001
var_0_1.ExtraL2D = var_0_10001.lshift(1, 0)
bit = var_1
var_0_1.ExtraDBG = var_1.lshift(1, 1)
bit = var_1
var_0_1.ExtraBG = var_1.lshift(1, 2)
bit = var_1
var_0_1.ExtraBGM = var_1.lshift(1, 3)
var_0_1.ExtraIndexs = {
	var_0_1.ExtraL2D,
	var_0_1.ExtraDBG,
	var_0_1.ExtraBG,
	var_0_1.ExtraBGM
}
IndexConst = var_1
var_0_1.ExtraALL = var_1.BitAll(var_0_1.ExtraIndexs)
table = var_1

var_1.insert(var_0_1.ExtraIndexs, 1, var_0_1.ExtraALL)

var_0_1.ExtraNames = {
	"index_all",
	"index_L2D",
	"index_DBG",
	"index_BG",
	"index_BGM"
}

local var_0_2 = {
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

function var_0_1.filterByExtra(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_1 == var_0_1.ExtraALL then
		return true
	end

	for iter_6_0 = 2, #var_0_2 do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_6_0 - 2)
		bit = var_1_10007

		if var_1_10007.band(var_1_10006, arg_6_1) > 0 and var_0_2[iter_6_0](arg_6_0) then
			return true
		end
	end

	return false
end

function var_0_1.init(arg_7_0)
	var_0_1.super.init(arg_7_0)

	arg_7_0.OnFilter = arg_7_0.contextData.OnFilter

	local var_7_0

	if not var_1.defaultIndex then
		var_7_0 = {}
	end

	arg_7_0.indexDatas = var_7_0

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0.contextData = arg_8_0:InitData()

	var_0_1.super.didEnter(arg_8_0)

	return
end

function var_0_1.BlurPanel(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_9_0, arg_9_0._tf)

	return
end

function var_0_1.InitData(arg_10_0)
	local var_10_0 = {}

	Clone = var_1_10002
	var_10_0.indexDatas = var_1_10002(arg_10_0.indexDatas)

	local var_10_1 = {
		minHeight = 650
	}
	local var_10_2 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_10_2.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_10_2.options = var_4.TypeIndexs
	ShipIndexConst = var_4
	var_10_2.names = var_4.TypeNames
	var_10_1.typeIndex = var_10_2

	local var_10_3 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_10_3.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_10_3.options = var_4.CampIndexs
	ShipIndexConst = var_4
	var_10_3.names = var_4.CampNames
	var_10_1.campIndex = var_10_3

	local var_10_4 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_10_4.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_10_4.options = var_4.RarityIndexs
	ShipIndexConst = var_4
	var_10_4.names = var_4.RarityNames
	var_10_1.rarityIndex = var_10_4

	local var_10_5 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_10_5.mode = var_4.Mode.AND
	var_10_5.options = var_0_1.ExtraIndexs
	var_10_5.names = var_0_1.ExtraNames
	var_10_1.extraIndex = var_10_5
	Vector2 = var_10_5
	var_10_1.layoutPos = var_10_5(0, -25)
	var_10_0.customPanels = var_10_1
	var_10_0.groupList = {
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

	function var_10_0.callback(arg_11_0)
		arg_10_0.OnFilter(arg_11_0)

		return
	end

	return var_10_0
end

return var_0_1
