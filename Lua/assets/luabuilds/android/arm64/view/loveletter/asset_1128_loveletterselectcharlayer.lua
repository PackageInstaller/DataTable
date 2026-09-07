local LoveLetterSelectCharLayer = class("LoveLetterSelectCharLayer", import("..base.BaseUI"))

LoveLetterSelectCharLayer.ON_INDEX = "LoveLetterSelectCharLayer.ON_INDEX"
LoveLetterSelectCharLayer.SELECT_CHAR = "LoveLetterSelectCharLayer.SELECT_CHAR"
LoveLetterSelectCharLayer.TOGGLE_UNDEFINED = -1
LoveLetterSelectCharLayer.TOGGLE_CHAR = 0
LoveLetterSelectCharLayer.TOGGLE_LINK = 1
LoveLetterSelectCharLayer.TOGGLE_BLUEPRINT = 2
LoveLetterSelectCharLayer.ShipIndex = {
	typeIndex = ShipIndexConst.TypeAll,
	campIndex = ShipIndexConst.CampAll,
	rarityIndex = ShipIndexConst.RarityAll
}
LoveLetterSelectCharLayer.ShipIndexData = {
	customPanels = {
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
		}
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
		}
	}
}

function LoveLetterSelectCharLayer:setShipGroups(arg_1_1)
	self.shipGroups = arg_1_1

	return
end

function LoveLetterSelectCharLayer:setProposeList(arg_2_1)
	self.proposeList = arg_2_1

	return
end

function LoveLetterSelectCharLayer:getUIName()
	return "LoveLetterGroupChangeUI"
end

function LoveLetterSelectCharLayer:back()
	if self.exited then
		return
	end

	self:emit(LoveLetterSelectCharLayer.ON_CLOSE)

	return
end

function LoveLetterSelectCharLayer:init()
	self.topTF = self._tf:Find("blur_panel/adapt/top")
	self.backBtn = self.topTF:Find("back_btn")
	self.indexBtn = self.topTF:Find("index_button")

	setActive(self._tf:Find("list_card/types"), false)

	self.cardItems = {}
	self.cardList = self._tf:Find("list_card/scroll"):GetComponent("LScrollRect")

	function self.cardList.onInitItem(arg_6_0)
		self:onInitCard(arg_6_0)

		return
	end

	function self.cardList.onUpdateItem(arg_7_0, arg_7_1)
		self:onUpdateCard(arg_7_0, arg_7_1)

		return
	end

	function self.cardList.onReturnItem(arg_8_0, arg_8_1)
		self:onReturnCard(arg_8_0, arg_8_1)

		return
	end

	self:OverlayPanel(self._tf)

	return
end

function LoveLetterSelectCharLayer:didEnter()
	onButton(self, self.backBtn, function()
		self:back()

		return
	end)
	onButton(self, self.indexBtn, function()
		local var_11_0 = Clone(LoveLetterSelectCharLayer.ShipIndexData)

		var_11_0.indexDatas = Clone(LoveLetterSelectCharLayer.ShipIndex)

		function var_11_0:callback()
			LoveLetterSelectCharLayer.ShipIndex.typeIndex = self.typeIndex

			if self.campIndex then
				LoveLetterSelectCharLayer.ShipIndex.campIndex = self.campIndex
			end

			LoveLetterSelectCharLayer.ShipIndex.rarityIndex = self.rarityIndex

			self:updateCardList()

			return
		end

		self:emit(LoveLetterSelectCharLayer.ON_INDEX, var_11_0)

		return
	end)
	self:updateCardList()

	return
end

function LoveLetterSelectCharLayer:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

local function var_0_1(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0 == LoveLetterSelectCharLayer.TOGGLE_CHAR and not arg_14_1 then
		return arg_14_2
	elseif arg_14_0 == LoveLetterSelectCharLayer.TOGGLE_LINK and arg_14_1 then
		return arg_14_2 - 16
	elseif arg_14_0 == LoveLetterSelectCharLayer.TOGGLE_BLUEPRINT then
		return arg_14_2 - 20000
	end

	return -1
end

function LoveLetterSelectCharLayer:updateCardList()
	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(self.contextData.isRepair and underscore.map(pg.lover_letter_content.get_id_list_by_year[2018], function(arg_16_0)
		return pg.lover_letter_content[arg_16_0].ship_group
	end) or pg.lover_character_template.all) do
		local var_15_3 = pg.ship_data_group.get_id_list_by_group_type[iter_15_1]

		assert(not pg.ship_data_group.get_id_list_by_group_type[iter_15_1] or #var_15_3 == 1)

		if not var_15_3 then
			warning(iter_15_1)
		elseif underscore.any(table.insertto({
			iter_15_1
		}, pg.lover_character_template[iter_15_1].relate_group_id), function(arg_17_0)
			return self.shipGroups[arg_17_0]
		end) then
			table.insert(var_15_1, var_15_3[1])
		end
	end

	table.sort(var_15_1)

	if LoveLetterSelectCharLayer.ShipIndex.typeIndex == ShipIndexConst.TypeAll and LoveLetterSelectCharLayer.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and LoveLetterSelectCharLayer.ShipIndex.campIndex == ShipIndexConst.CampAll then
		for iter_15_2, iter_15_3 in ipairs(var_15_1) do
			local var_15_4
			local var_15_5 = false

			if pg.ship_data_group[iter_15_3] then
				var_15_4 = self.shipGroups[pg.ship_data_group[iter_15_3].group_type] or ShipGroup.New({
					id = pg.ship_data_group[iter_15_3].group_type
				})
				var_15_5 = Nation.IsLinkType(ShipGroup.getDefaultShipConfig(pg.ship_data_group[iter_15_3].group_type).nationality)
			end

			local var_15_6 = var_0_1(pg.ship_data_group[iter_15_3].handbook_type, var_15_5, iter_15_3)

			if var_15_6 ~= -1 then
				var_15_0[iter_15_2] = {
					showTrans = false,
					code = var_15_6,
					group = var_15_4
				}
			end
		end
	else
		for iter_15_4, iter_15_5 in ipairs(var_15_1) do
			if pg.ship_data_group[iter_15_5] then
				local var_15_7 = ShipGroup.New({
					id = pg.ship_data_group[iter_15_5].group_type
				})

				if var_15_7 and ShipIndexConst.filterByType(var_15_7, LoveLetterSelectCharLayer.ShipIndex.typeIndex) and ShipIndexConst.filterByRarity(var_15_7, LoveLetterSelectCharLayer.ShipIndex.rarityIndex) then
					local var_15_8 = Nation.IsLinkType(var_15_7:getNation())

					if ShipIndexConst.filterByCamp(var_15_7, LoveLetterSelectCharLayer.ShipIndex.campIndex) then
						var_15_0[#var_15_0 + 1] = {
							showTrans = false,
							code = var_0_1(pg.ship_data_group[iter_15_5].handbook_type, var_15_8, iter_15_5),
							group = self.shipGroups[pg.ship_data_group[iter_15_5].group_type]
						}
					end
				end
			end
		end
	end

	self.cardInfos = var_15_0

	self.cardList:SetTotalCount(#self.cardInfos, -1)

	return
end

function LoveLetterSelectCharLayer:onInitCard(arg_20_1)
	local var_20_0 = LoveLetterShipCard.New(arg_20_1)

	onButton(self, var_20_0.go, function()
		if var_20_0.shipGroup then
			self:emit(LoveLetterSelectCharLayer.SELECT_CHAR, var_20_0.shipGroup.id)
		end

		return
	end)

	self.cardItems[arg_20_1] = var_20_0

	return
end

function LoveLetterSelectCharLayer:onUpdateCard(arg_22_1, arg_22_2)
	local var_22_0 = self.cardItems[arg_22_2]

	if not self.cardItems[arg_22_2] then
		self:onInitCard(arg_22_2)

		var_22_0 = self.cardItems[arg_22_2]
	end

	local var_22_1 = self.cardInfos[arg_22_1 + 1]

	if not self.cardInfos[arg_22_1 + 1] then
		return
	end

	if var_22_1.group then
		-- block empty
	end

	var_22_0:update(var_22_1.group)

	return
end

function LoveLetterSelectCharLayer:onReturnCard(arg_23_1, arg_23_2)
	if self.exited then
		return
	end

	if self.cardItems[arg_23_2] then
		self.cardItems[arg_23_2]:clear()
	end

	self.cardItems[arg_23_2] = nil

	return
end

return LoveLetterSelectCharLayer
