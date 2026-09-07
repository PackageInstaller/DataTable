local SkinAtlasIndexLayer = class("SkinAtlasIndexLayer", import("...common.CustomIndexLayer"))

SkinAtlasIndexLayer.ExtraL2D = bit.lshift(1, 0)
SkinAtlasIndexLayer.ExtraDBG = bit.lshift(1, 1)
SkinAtlasIndexLayer.ExtraBG = bit.lshift(1, 2)
SkinAtlasIndexLayer.ExtraBGM = bit.lshift(1, 3)
SkinAtlasIndexLayer.ExtraCANTUSE = bit.lshift(1, 4)
SkinAtlasIndexLayer.ExtraUNUSE = bit.lshift(1, 5)
SkinAtlasIndexLayer.ExtraIndexs = {
	SkinAtlasIndexLayer.ExtraL2D,
	SkinAtlasIndexLayer.ExtraDBG,
	SkinAtlasIndexLayer.ExtraBG,
	SkinAtlasIndexLayer.ExtraBGM,
	SkinAtlasIndexLayer.ExtraCANTUSE,
	SkinAtlasIndexLayer.ExtraUNUSE
}
SkinAtlasIndexLayer.ExtraALL = IndexConst.BitAll(SkinAtlasIndexLayer.ExtraIndexs)

table.insert(SkinAtlasIndexLayer.ExtraIndexs, 1, SkinAtlasIndexLayer.ExtraALL)

SkinAtlasIndexLayer.ExtraNames = {
	"index_all",
	"index_L2D",
	"index_DBG",
	"index_BG",
	"index_BGM",
	"index_CANTUSE",
	"index_UNUSE"
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
	end,
	function(arg_6_0)
		return arg_6_0:CantUse()
	end,
	function(arg_7_0)
		return arg_7_0:WithoutUse()
	end
}

function SkinAtlasIndexLayer:filterByExtra(arg_8_1)
	if not arg_8_1 or arg_8_1 == SkinAtlasIndexLayer.ExtraALL then
		return true
	end

	for iter_8_0 = 2, #var_0_1 do
		if bit.band(bit.lshift(1, iter_8_0 - 2), arg_8_1) > 0 and var_0_1[iter_8_0](self) then
			return true
		end
	end

	return false
end

function SkinAtlasIndexLayer:init()
	SkinAtlasIndexLayer.super.init(self)

	self.OnFilter = self.contextData.OnFilter
	self.indexDatas = self.contextData.defaultIndex or {}

	return
end

function SkinAtlasIndexLayer:BlurPanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SkinAtlasIndexLayer:didEnter()
	self.contextData = self:InitData()

	SkinAtlasIndexLayer.super.didEnter(self)

	return
end

function SkinAtlasIndexLayer:InitData()
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
				options = SkinAtlasIndexLayer.ExtraIndexs,
				names = SkinAtlasIndexLayer.ExtraNames
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
		callback = function(arg_13_0)
			self.OnFilter(arg_13_0)

			return
		end
	}
end

return SkinAtlasIndexLayer
