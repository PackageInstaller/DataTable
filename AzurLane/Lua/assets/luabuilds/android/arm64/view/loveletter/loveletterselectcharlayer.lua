local var_0_0 = class("LoveLetterSelectCharLayer", import("..base.BaseUI"))

var_0_0.ON_INDEX = "LoveLetterSelectCharLayer.ON_INDEX"
var_0_0.SELECT_CHAR = "LoveLetterSelectCharLayer.SELECT_CHAR"
var_0_0.TOGGLE_UNDEFINED = -1
var_0_0.TOGGLE_CHAR = 0
var_0_0.TOGGLE_LINK = 1
var_0_0.TOGGLE_BLUEPRINT = 2
var_0_0.ShipIndex = {
	typeIndex = ShipIndexConst.TypeAll,
	campIndex = ShipIndexConst.CampAll,
	rarityIndex = ShipIndexConst.RarityAll
}
var_0_0.ShipIndexData = {
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

function var_0_0.setShipGroups(arg_1_0, arg_1_1)
	arg_1_0.shipGroups = arg_1_1

	return
end

function var_0_0.setProposeList(arg_2_0, arg_2_1)
	arg_2_0.proposeList = arg_2_1

	return
end

function var_0_0.getUIName(arg_3_0)
	return "LoveLetterGroupChangeUI"
end

function var_0_0.back(arg_4_0)
	if arg_4_0.exited then
		return
	end

	arg_4_0:emit(var_0_0.ON_CLOSE)

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.topTF = arg_5_0._tf:Find("blur_panel/adapt/top")
	arg_5_0.backBtn = arg_5_0.topTF:Find("back_btn")
	arg_5_0.indexBtn = arg_5_0.topTF:Find("index_button")

	setActive(arg_5_0._tf:Find("list_card/types"), false)

	arg_5_0.cardItems = {}
	arg_5_0.cardList = arg_5_0._tf:Find("list_card/scroll"):GetComponent("LScrollRect")

	function arg_5_0.cardList.onInitItem(arg_6_0)
		arg_5_0:onInitCard(arg_6_0)

		return
	end

	function arg_5_0.cardList.onUpdateItem(arg_7_0, arg_7_1)
		arg_5_0:onUpdateCard(arg_7_0, arg_7_1)

		return
	end

	function arg_5_0.cardList.onReturnItem(arg_8_0, arg_8_1)
		arg_5_0:onReturnCard(arg_8_0, arg_8_1)

		return
	end

	arg_5_0:OverlayPanel(arg_5_0._tf)

	return
end

function var_0_0.didEnter(arg_9_0)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		arg_9_0:back()

		return
	end)
	onButton(arg_9_0, arg_9_0.indexBtn, function()
		local var_11_0 = Clone(var_0_0.ShipIndexData)

		var_11_0.indexDatas = Clone(var_0_0.ShipIndex)

		function var_11_0.callback(arg_12_0)
			var_0_0.ShipIndex.typeIndex = arg_12_0.typeIndex

			if arg_12_0.campIndex then
				var_0_0.ShipIndex.campIndex = arg_12_0.campIndex
			end

			var_0_0.ShipIndex.rarityIndex = arg_12_0.rarityIndex

			arg_9_0:updateCardList()

			return
		end

		arg_9_0:emit(var_0_0.ON_INDEX, var_11_0)

		return
	end)
	arg_9_0:updateCardList()

	return
end

function var_0_0.willExit(arg_13_0)
	arg_13_0:UnOverlayPanel(arg_13_0._tf)

	return
end

local function var_0_1(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0 == var_0_0.TOGGLE_CHAR and not arg_14_1 then
		return arg_14_2
	elseif arg_14_0 == var_0_0.TOGGLE_LINK and arg_14_1 then
		return arg_14_2 - 16
	elseif arg_14_0 == var_0_0.TOGGLE_BLUEPRINT then
		return arg_14_2 - 20000
	end

	return -1
end

function var_0_0.updateCardList(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = arg_15_0.contextData.isRepair and underscore.map(pg.lover_letter_content.get_id_list_by_year[2018], function(arg_16_0)
		return pg.lover_letter_content[arg_16_0].ship_group
	end) or pg.lover_character_template.all

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		local var_15_2 = pg.ship_data_group.get_id_list_by_group_type[iter_15_1]

		assert(not pg.ship_data_group.get_id_list_by_group_type[iter_15_1] or #var_15_2 == 1)

		if not var_15_2 then
			warning(iter_15_1)
		elseif underscore.any(table.insertto({
			iter_15_1
		}, pg.lover_character_template[iter_15_1].relate_group_id), function(arg_17_0)
			return arg_15_0.shipGroups[arg_17_0]
		end) then
			table.insert(var_15_0, var_15_2[1])
		end
	end

	table.sort(var_15_0)

	if var_0_0.ShipIndex.typeIndex == ShipIndexConst.TypeAll and var_0_0.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and var_0_0.ShipIndex.campIndex == ShipIndexConst.CampAll then
		for iter_15_2, iter_15_3 in ipairs(var_15_0) do
			local var_15_3
			local var_15_4 = false

			if pg.ship_data_group[iter_15_3] then
				var_15_3 = arg_15_0.shipGroups[pg.ship_data_group[iter_15_3].group_type] or ShipGroup.New({
					id = pg.ship_data_group[iter_15_3].group_type
				})
				var_15_4 = Nation.IsLinkType(ShipGroup.getDefaultShipConfig(pg.ship_data_group[iter_15_3].group_type).nationality)
			end

			local var_15_5 = var_0_1(pg.ship_data_group[iter_15_3].handbook_type, var_15_4, iter_15_3)

			if var_15_5 ~= -1 then
				({})[iter_15_2] = {
					showTrans = false,
					code = var_15_5,
					group = var_15_3
				}
			end
		end
	else
		for iter_15_4, iter_15_5 in ipairs(var_15_0) do
			if pg.ship_data_group[iter_15_5] then
				local var_15_6 = ShipGroup.New({
					id = pg.ship_data_group[iter_15_5].group_type
				})

				if var_15_6 and ShipIndexConst.filterByType(var_15_6, var_0_0.ShipIndex.typeIndex) and ShipIndexConst.filterByRarity(var_15_6, var_0_0.ShipIndex.rarityIndex) then
					local var_15_7 = Nation.IsLinkType(var_15_6:getNation())

					if ShipIndexConst.filterByCamp(var_15_6, var_0_0.ShipIndex.campIndex) then
						({})[#{} + 1] = {
							showTrans = false,
							code = var_0_1(pg.ship_data_group[iter_15_5].handbook_type, var_15_7, iter_15_5),
							group = arg_15_0.shipGroups[pg.ship_data_group[iter_15_5].group_type]
						}
					end
				end
			end
		end
	end

	arg_15_0.cardInfos = {}

	arg_15_0.cardList:SetTotalCount(#arg_15_0.cardInfos, -1)

	return
end

function var_0_0.onInitCard(arg_20_0, arg_20_1)
	local var_20_0 = LoveLetterShipCard.New(arg_20_1)

	onButton(arg_20_0, var_20_0.go, function()
		if var_20_0.shipGroup then
			arg_20_0:emit(var_0_0.SELECT_CHAR, var_20_0.shipGroup.id)
		end

		return
	end)

	arg_20_0.cardItems[arg_20_1] = var_20_0

	return
end

function var_0_0.onUpdateCard(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.cardItems[arg_22_2]

	if not arg_22_0.cardItems[arg_22_2] then
		arg_22_0:onInitCard(arg_22_2)

		var_22_0 = arg_22_0.cardItems[arg_22_2]
	end

	local var_22_1 = arg_22_0.cardInfos[arg_22_1 + 1]

	if not arg_22_0.cardInfos[arg_22_1 + 1] then
		return
	end

	if var_22_1.group then
		-- block empty
	end

	var_22_0:update(var_22_1.group)

	return
end

function var_0_0.onReturnCard(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.exited then
		return
	end

	if arg_23_0.cardItems[arg_23_2] then
		var_23_0:clear()
	end

	arg_23_0.cardItems[arg_23_2] = nil

	return
end

return var_0_0
