class = var_0_10000

local var_0_0 = "LoveLetterSelectCharLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.ON_INDEX = "LoveLetterSelectCharLayer.ON_INDEX"
var_0_1.SELECT_CHAR = "LoveLetterSelectCharLayer.SELECT_CHAR"
var_0_1.TOGGLE_UNDEFINED = -1
var_0_1.TOGGLE_CHAR = 0
var_0_1.TOGGLE_LINK = 1
var_0_1.TOGGLE_BLUEPRINT = 2

local var_0_2 = {}

ShipIndexConst = var_0_0
var_0_2.typeIndex = var_0_0.TypeAll
ShipIndexConst = var_2
var_0_2.campIndex = var_2.CampAll
ShipIndexConst = var_2
var_0_2.rarityIndex = var_2.RarityAll
var_0_1.ShipIndex = var_0_2

local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {
	blueSeleted = true
}

CustomIndexLayer = var_0_10004
var_0_5.mode = var_0_10004.Mode.AND
ShipIndexConst = var_4
var_0_5.options = var_4.TypeIndexs
ShipIndexConst = var_4
var_0_5.names = var_4.TypeNames
var_0_4.typeIndex = var_0_5

local var_0_6 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_6.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_6.options = var_4.CampIndexs
ShipIndexConst = var_4
var_0_6.names = var_4.CampNames
var_0_4.campIndex = var_0_6

local var_0_7 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_7.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_7.options = var_4.RarityIndexs
ShipIndexConst = var_4
var_0_7.names = var_4.RarityNames
var_0_4.rarityIndex = var_0_7
var_0_3.customPanels = var_0_4
var_0_3.groupList = {
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
var_0_1.ShipIndexData = var_0_3

function var_0_1.setShipGroups(arg_1_0, arg_1_1)
	arg_1_0.shipGroups = arg_1_1

	return
end

function var_0_1.setProposeList(arg_2_0, arg_2_1)
	arg_2_0.proposeList = arg_2_1

	return
end

function var_0_1.getUIName(arg_3_0)
	return "LoveLetterGroupChangeUI"
end

function var_0_1.back(arg_4_0)
	if arg_4_0.exited then
		return
	end

	arg_4_0:emit(var_0_1.ON_CLOSE)

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.topTF = var_1.Find(var_5_0, "blur_panel/adapt/top")

	local var_5_1 = arg_5_0.topTF

	arg_5_0.backBtn = var_1.Find(var_5_1, "back_btn")

	local var_5_2 = arg_5_0.topTF

	arg_5_0.indexBtn = var_1.Find(var_5_2, "index_button")
	setActive = var_1

	local var_5_3 = arg_5_0._tf

	var_1(var_3.Find(var_5_3, "list_card/types"), false)

	arg_5_0.cardItems = {}

	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_1.Find(var_5_4, "list_card/scroll")

	arg_5_0.cardList = var_1.GetComponent(var_5_5, "LScrollRect")

	function arg_5_0.cardList.onInitItem(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.onInitCard(var_6_0, arg_6_0)

		return
	end

	function arg_5_0.cardList.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.onUpdateCard(var_7_0, arg_7_0, arg_7_1)

		return
	end

	function arg_5_0.cardList.onReturnItem(arg_8_0, arg_8_1)
		local var_8_0 = arg_5_0

		var_2.onReturnCard(var_8_0, arg_8_0, arg_8_1)

		return
	end

	arg_5_0:OverlayPanel(arg_5_0._tf)

	return
end

function var_0_1.didEnter(arg_9_0)
	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.backBtn, function()
		local var_10_0 = arg_9_0

		var_0.back(var_10_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.indexBtn, function()
		Clone = var_2_10000

		local var_11_0 = var_2_10000(var_0_1.ShipIndexData)

		Clone = var_2_10001
		var_11_0.indexDatas = var_2_10001(var_0_1.ShipIndex)

		function var_11_0.callback(arg_12_0)
			var_0_1.ShipIndex.typeIndex = arg_12_0.typeIndex

			if arg_12_0.campIndex then
				var_0_1.ShipIndex.campIndex = arg_12_0.campIndex
			end

			var_0_1.ShipIndex.rarityIndex = arg_12_0.rarityIndex

			local var_12_0 = arg_9_0

			var_1.updateCardList(var_12_0)

			return
		end

		local var_11_1 = arg_9_0

		var_1.emit(var_11_1, var_0_1.ON_INDEX, var_11_0)

		return
	end)
	arg_9_0:updateCardList()

	return
end

function var_0_1.willExit(arg_13_0)
	arg_13_0:UnOverlayPanel(arg_13_0._tf)

	return
end

local function var_0_8(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0 == var_0_1.TOGGLE_CHAR and not arg_14_1 then
		return arg_14_2
	elseif arg_14_0 == var_0_1.TOGGLE_LINK and arg_14_1 then
		return arg_14_2 - 16
	elseif arg_14_0 == var_0_1.TOGGLE_BLUEPRINT then
		return arg_14_2 - 20000
	end

	return -1
end

function var_0_1.updateCardList(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2
	local var_15_3

	if arg_15_0.contextData.isRepair then
		underscore = var_15_3
		var_15_3 = var_15_3.map
		pg = var_1_10006
		var_15_2 = var_15_3(var_1_10006.lover_letter_content.get_id_list_by_year[2018], function(arg_16_0)
			pg = var_2_10001

			return var_2_10001.lover_letter_content[arg_16_0].ship_group
		end)
	else
		pg = var_15_3
		var_15_2 = var_15_3.lover_character_template.all
	end

	ipairs = var_15_3

	for iter_15_0, iter_15_1 in var_15_3(var_15_2) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.ship_data_group.get_id_list_by_group_type[iter_15_1]
		assert = var_1_10010

		var_1_10010(not var_1_10009 or #var_1_10009 == 1)

		if not var_1_10009 then
			warning = var_1_10010

			var_1_10010(iter_15_1)
		else
			underscore = var_1_10010
			var_1_10010 = var_1_10010.any
			table = var_12

			local var_15_4 = var_12.insertto

			var_1_10014 = {
				iter_15_1
			}
			pg = var_1_10015

			if var_1_10010(var_15_4(var_1_10014, var_1_10015.lover_character_template[iter_15_1].relate_group_id), function(arg_17_0)
				return arg_15_0.shipGroups[arg_17_0]
			end) then
				table = var_1_10010

				var_1_10010.insert(var_15_1, var_1_10009[1])
			end
		end
	end

	table = var_4

	var_4.sort(var_15_1)

	local var_15_5 = var_0_1.ShipIndex.typeIndex

	ShipIndexConst = var_5

	if var_15_5 == var_5.TypeAll then
		var_15_5 = var_0_1.ShipIndex.rarityIndex
		ShipIndexConst = var_5

		if var_15_5 == var_5.RarityAll then
			var_15_5 = var_0_1.ShipIndex.campIndex
			ShipIndexConst = var_5

			if var_15_5 == var_5.CampAll then
				ipairs = var_15_5

				for iter_15_2, iter_15_3 in var_15_5(var_15_1) do
					pg = var_1_10009
					var_1_10009 = var_1_10009.ship_data_group[iter_15_3]
					var_1_10010 = nil

					local var_15_6 = false

					if var_1_10009 then
						if not arg_15_0.shipGroups[var_1_10009.group_type] then
							::label_15_0::

							ShipGroup = var_12
							var_1_10010 = var_12.New({
								id = var_1_10009.group_type
							})
						end

						Nation = var_12

						local var_15_7 = var_12.IsLinkType

						ShipGroup = var_1_10014
						var_15_6 = var_15_7(var_1_10014.getDefaultShipConfig(var_1_10009.group_type).nationality)
					end

					local var_15_8 = var_1_10009.handbook_type

					if var_0_8(var_15_8, var_15_6, iter_15_3) ~= -1 then
						var_15_0[iter_15_2] = {
							showTrans = false,
							code = var_13,
							group = var_1_10010
						}
					end
				end

				goto label_15_1
			end
		end
	end

	ipairs = var_15_5

	for iter_15_4, iter_15_5 in var_15_5(var_15_1) do
		pg = var_1_10009

		if var_1_10009.ship_data_group[iter_15_5] then
			ShipGroup = var_1_10010
			var_1_10010 = var_1_10010.New({
				id = var_1_10009.group_type
			})

			local var_15_9 = arg_15_0.shipGroups[var_1_10009.group_type]

			if var_1_10010 then
				ShipIndexConst = var_12

				if var_12.filterByType(var_1_10010, var_0_1.ShipIndex.typeIndex) then
					ShipIndexConst = var_12

					if var_12.filterByRarity(var_1_10010, var_0_1.ShipIndex.rarityIndex) then
						Nation = var_12

						local var_15_10 = var_12.IsLinkType(var_1_10010:getNation())
						local var_15_11 = var_1_10009.handbook_type

						ShipIndexConst = var_14

						if var_14.filterByCamp(var_1_10010, var_0_1.ShipIndex.campIndex) then
							var_15_0[#var_15_0 + 1] = {
								showTrans = false,
								code = var_0_8(var_15_11, var_15_10, iter_15_5),
								group = var_15_9
							}
						end
					end
				end
			end
		end
	end

	::label_15_1::

	arg_15_0.cardInfos = var_15_0

	local var_15_12 = arg_15_0.cardList

	var_4.SetTotalCount(var_15_12, #arg_15_0.cardInfos, -1)

	return
end

local function var_0_9(arg_18_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)

	return var_1.GetAllSkinForARCamera(var_18_0, arg_18_0)
end

local function var_0_10(arg_19_0)
	local var_19_0 = {}

	getProxy = var_1_10002
	ShipSkinProxy = var_1_10004

	local var_19_1 = var_1_10002(var_1_10004)
	local var_19_2 = var_2.getSkinList(var_19_1)

	getProxy = var_1_10004
	CollectionProxy = var_1_10006

	local var_19_3 = var_1_10004(var_1_10006)

	if var_4.getShipGroup(var_19_3, arg_19_0) then
		ShipGroup = var_19_1

		local var_19_4 = var_19_1.getSkinList(arg_19_0)

		ipairs = var_19_3

		for iter_19_0, iter_19_1 in var_19_3(var_19_4) do
			local var_19_5 = iter_19_1.skin_type

			ShipSkin = var_1_10012

			if var_19_5 ~= var_1_10012.SKIN_TYPE_DEFAULT then
				table = var_19_5

				if not var_19_5.contains(var_19_2, iter_19_1.id) then
					local var_19_6 = iter_19_1.skin_type

					ShipSkin = var_1_10012

					if var_19_6 ~= var_1_10012.SKIN_TYPE_REMAKE or not var_4.trans then
						local var_19_7 = iter_19_1.skin_type

						ShipSkin = var_1_10012

						if var_19_7 == var_1_10012.SKIN_TYPE_PROPOSE and var_4.married == 1 or var_2:hasSkin(iter_19_1.id) then
							var_19_0[iter_19_1.id] = true
						end
					end
				end
			end
		end
	end

	return var_19_0
end

function var_0_1.onInitCard(arg_20_0, arg_20_1)
	LoveLetterShipCard = var_1_10002

	local var_20_0 = var_1_10002.New(arg_20_1)

	onButton = var_1_10003

	var_1_10003(arg_20_0, var_20_0.go, function()
		if var_20_0.shipGroup then
			local var_21_0 = arg_20_0

			var_0.emit(var_21_0, var_0_1.SELECT_CHAR, var_20_0.shipGroup.id)
		end

		return
	end)

	arg_20_0.cardItems[arg_20_1] = var_20_0

	return
end

function var_0_1.onUpdateCard(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if not arg_22_0.cardItems[arg_22_2] then
		arg_22_0:onInitCard(arg_22_2)

		var_22_0 = arg_22_0.cardItems[arg_22_2]
	end

	local var_22_1 = arg_22_1 + 1

	if not arg_22_0.cardInfos[var_22_1] then
		return
	end

	local var_22_2

	if var_5.group then
		local var_22_3 = arg_22_0.proposeList[var_5.group.id]
	end

	var_22_0:update(var_5.group)

	return
end

function var_0_1.onReturnCard(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.exited then
		return
	end

	if arg_23_0.cardItems[arg_23_2] then
		var_3:clear()
	end

	arg_23_0.cardItems[arg_23_2] = nil

	return
end

return var_0_1
