local SkinIndexLayer = class("SkinIndexLayer", import("...common.CustomIndexLayer"))

SkinIndexLayer.ExtraL2D = bit.lshift(1, 0)
SkinIndexLayer.ExtraDBG = bit.lshift(1, 1)
SkinIndexLayer.ExtraBG = bit.lshift(1, 2)
SkinIndexLayer.ExtraBGM = bit.lshift(1, 3)
SkinIndexLayer.ExtraIndexs = {
	SkinIndexLayer.ExtraL2D,
	SkinIndexLayer.ExtraDBG,
	SkinIndexLayer.ExtraBG,
	SkinIndexLayer.ExtraBGM
}
SkinIndexLayer.ExtraALL = IndexConst.BitAll(SkinIndexLayer.ExtraIndexs)

table.insert(SkinIndexLayer.ExtraIndexs, 1, SkinIndexLayer.ExtraALL)

SkinIndexLayer.ExtraNames = {
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

function SkinIndexLayer:filterByExtra(arg_6_1)
	if not arg_6_1 or arg_6_1 == SkinIndexLayer.ExtraALL then
		return true
	end

	for iter_6_0 = 2, #var_0_1 do
		if bit.band(bit.lshift(1, iter_6_0 - 2), arg_6_1) > 0 and var_0_1[iter_6_0](self) then
			return true
		end
	end

	return false
end

function SkinIndexLayer:init()
	SkinIndexLayer.super.init(self)

	self.OnFilter = self.contextData.OnFilter
	self.indexDatas = self.contextData.defaultIndex or {}

	return
end

function SkinIndexLayer:didEnter()
	self.contextData = self:InitData()

	SkinIndexLayer.super.didEnter(self)

	return
end

function SkinIndexLayer:BlurPanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SkinIndexLayer:InitData()
	return {
		indexDatas = Clone(self.indexDatas),
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
				options = SkinIndexLayer.ExtraIndexs,
				names = SkinIndexLayer.ExtraNames
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
			self.OnFilter(arg_11_0)

			return
		end
	}
end

return SkinIndexLayer
