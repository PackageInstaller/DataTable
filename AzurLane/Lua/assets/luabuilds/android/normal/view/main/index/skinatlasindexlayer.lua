class = var_0_10000

local var_0_0 = "SkinAtlasIndexLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...common.CustomIndexLayer"))

bit = var_0_0
var_0_1.ExtraL2D = var_0_0.lshift(1, 0)
bit = var_1
var_0_1.ExtraDBG = var_1.lshift(1, 1)
bit = var_1
var_0_1.ExtraBG = var_1.lshift(1, 2)
bit = var_1
var_0_1.ExtraBGM = var_1.lshift(1, 3)
bit = var_1
var_0_1.ExtraCANTUSE = var_1.lshift(1, 4)
bit = var_1
var_0_1.ExtraUNUSE = var_1.lshift(1, 5)
var_0_1.ExtraIndexs = {
	var_0_1.ExtraL2D,
	var_0_1.ExtraDBG,
	var_0_1.ExtraBG,
	var_0_1.ExtraBGM,
	var_0_1.ExtraCANTUSE,
	var_0_1.ExtraUNUSE
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
	"index_BGM",
	"index_CANTUSE",
	"index_UNUSE"
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
	end,
	function(arg_6_0)
		return arg_6_0:CantUse()
	end,
	function(arg_7_0)
		return arg_7_0:WithoutUse()
	end
}

function var_0_1.filterByExtra(arg_8_0, arg_8_1)
	if not arg_8_1 or arg_8_1 == var_0_1.ExtraALL then
		return true
	end

	for iter_8_0 = 2, #var_0_2 do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_8_0 - 2)
		bit = var_7

		if var_7.band(var_1_10006, arg_8_1) > 0 and var_0_2[iter_8_0](arg_8_0) then
			return true
		end
	end

	return false
end

function var_0_1.init(arg_9_0)
	var_0_1.super.init(arg_9_0)

	arg_9_0.OnFilter = arg_9_0.contextData.OnFilter

	local var_9_0

	if not var_1.defaultIndex then
		var_9_0 = {}
	end

	arg_9_0.indexDatas = var_9_0

	return
end

function var_0_1.BlurPanel(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_10_0, arg_10_0._tf)

	return
end

function var_0_1.didEnter(arg_11_0)
	arg_11_0.contextData = arg_11_0:InitData()

	var_0_1.super.didEnter(arg_11_0)

	return
end

function var_0_1.InitData(arg_12_0)
	local var_12_0 = {}

	Clone = var_1_10002
	var_12_0.indexDatas = var_1_10002(arg_12_0.indexDatas)

	local var_12_1 = {
		minHeight = 650
	}
	local var_12_2 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_1_10004
	var_12_2.mode = var_1_10004.Mode.AND
	ShipIndexConst = var_4
	var_12_2.options = var_4.TypeIndexs
	ShipIndexConst = var_4
	var_12_2.names = var_4.TypeNames
	var_12_1.typeIndex = var_12_2

	local var_12_3 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_12_3.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_12_3.options = var_4.CampIndexs
	ShipIndexConst = var_4
	var_12_3.names = var_4.CampNames
	var_12_1.campIndex = var_12_3

	local var_12_4 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_12_4.mode = var_4.Mode.AND
	ShipIndexConst = var_4
	var_12_4.options = var_4.RarityIndexs
	ShipIndexConst = var_4
	var_12_4.names = var_4.RarityNames
	var_12_1.rarityIndex = var_12_4

	local var_12_5 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_4
	var_12_5.mode = var_4.Mode.AND
	var_12_5.options = var_0_1.ExtraIndexs
	var_12_5.names = var_0_1.ExtraNames
	var_12_1.extraIndex = var_12_5
	Vector2 = var_12_5
	var_12_1.layoutPos = var_12_5(0, -25)
	var_12_0.customPanels = var_12_1
	var_12_0.groupList = {
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

	function var_12_0.callback(arg_13_0)
		arg_12_0.OnFilter(arg_13_0)

		return
	end

	return var_12_0
end

return var_0_1
