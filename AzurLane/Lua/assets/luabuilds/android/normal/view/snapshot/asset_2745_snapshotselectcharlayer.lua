class = var_0_10000

local var_0_0 = "SnapshotSelectCharLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.ON_INDEX = "SnapshotSelectCharLayer.ON_INDEX"
var_0_1.SELECT_CHAR = "SnapshotSelectCharLayer.SELECT_CHAR"
var_0_1.TOGGLE_UNDEFINED = -1
var_0_1.TOGGLE_CHAR = 0
var_0_1.TOGGLE_LINK = 1
var_0_1.TOGGLE_BLUEPRINT = 2

local var_0_2 = {}

ShipIndexConst = var_2
var_0_2.typeIndex = var_2.TypeAll
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
	return "snapshotselectchar"
end

function var_0_1.back(arg_4_0)
	if arg_4_0.exited then
		return
	end

	arg_4_0:emit(var_0_1.ON_CLOSE)

	return
end

function var_0_1.init(arg_5_0)
	arg_5_0.toggleType = var_0_1.TOGGLE_UNDEFINED

	local var_5_0 = arg_5_0._tf

	arg_5_0.topTF = var_1.Find(var_5_0, "blur_panel/adapt/top")

	local var_5_1 = arg_5_0.topTF

	arg_5_0.backBtn = var_1.Find(var_5_1, "back_btn")

	local var_5_2 = arg_5_0.topTF

	arg_5_0.indexBtn = var_1.Find(var_5_2, "index_button")

	local var_5_3 = arg_5_0._tf

	arg_5_0.toggleChar = var_1.Find(var_5_3, "list_card/types/char")

	local var_5_4 = arg_5_0._tf

	arg_5_0.toggleLink = var_1.Find(var_5_4, "list_card/types/link")

	local var_5_5 = arg_5_0._tf

	arg_5_0.toggleBlueprint = var_1.Find(var_5_5, "list_card/types/blueprint")
	arg_5_0.cardItems = {}

	local var_5_6 = arg_5_0._tf
	local var_5_7 = var_1.Find(var_5_6, "list_card/scroll")

	arg_5_0.cardList = var_1.GetComponent(var_5_7, "LScrollRect")

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

	arg_5_0:initSelectSkinPanel()

	cameraPaintViewAdjust = var_1

	var_1(false)

	pg = var_1

	local var_5_8 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_5_8, arg_5_0._tf)

	return
end

function var_0_1.didEnter(arg_9_0)
	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.backBtn, function()
		local var_10_0 = arg_9_0

		var_0.back(var_10_0)

		return
	end)

	onToggle = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.toggleChar, function()
		if arg_9_0.toggleType == var_0_1.TOGGLE_CHAR then
			return
		end

		arg_9_0.toggleType = var_0_1.TOGGLE_CHAR

		local var_11_0 = arg_9_0

		var_0.updateCardList(var_11_0)

		return
	end)

	onToggle = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.toggleLink, function()
		if arg_9_0.toggleType == var_0_1.TOGGLE_LINK then
			return
		end

		arg_9_0.toggleType = var_0_1.TOGGLE_LINK

		local var_12_0 = arg_9_0

		var_0.updateCardList(var_12_0)

		return
	end)

	onToggle = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.toggleBlueprint, function()
		if arg_9_0.toggleType == var_0_1.TOGGLE_BLUEPRINT then
			return
		end

		arg_9_0.toggleType = var_0_1.TOGGLE_BLUEPRINT

		local var_13_0 = arg_9_0

		var_0.updateCardList(var_13_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.indexBtn, function()
		Clone = var_2_10000

		local var_14_0 = var_2_10000(var_0_1.ShipIndexData)
		local var_14_1

		if arg_9_0.toggleType == var_0_1.TOGGLE_LINK then
			var_14_1 = var_14_0.customPanels
			var_14_1.campIndex = nil
			var_14_1 = var_14_0.groupList
			var_14_1[2] = nil
		end

		Clone = var_14_1
		var_14_0.indexDatas = var_14_1(var_0_1.ShipIndex)

		function var_14_0.callback(arg_15_0)
			var_0_1.ShipIndex.typeIndex = arg_15_0.typeIndex

			if arg_15_0.campIndex then
				var_0_1.ShipIndex.campIndex = arg_15_0.campIndex
			end

			var_0_1.ShipIndex.rarityIndex = arg_15_0.rarityIndex

			local var_15_0 = arg_9_0

			var_1.updateCardList(var_15_0)

			return
		end

		local var_14_2 = arg_9_0

		var_1.emit(var_14_2, var_0_1.ON_INDEX, var_14_0)

		return
	end)

	triggerToggle = var_1_10001

	var_1_10001(arg_9_0.toggleChar, true)

	return
end

function var_0_1.willExit(arg_16_0)
	cameraPaintViewAdjust = var_1_10001

	var_1_10001(true)

	pg = var_1_10001

	local var_16_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_16_0, arg_16_0._tf)

	return
end

local function var_0_8(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0 == var_0_1.TOGGLE_CHAR and not arg_17_1 then
		return arg_17_2
	elseif arg_17_0 == var_0_1.TOGGLE_LINK and arg_17_1 then
		return arg_17_2 - 16
	elseif arg_17_0 == var_0_1.TOGGLE_BLUEPRINT then
		return arg_17_2 - 20000
	end

	return -1
end

function var_0_1.updateCardList(arg_18_0)
	local var_18_0 = {}

	_ = var_1_10002

	local var_18_1 = var_1_10002.filter

	pg = var_1_10003

	local var_18_2 = var_18_1(var_1_10003.ship_data_group.all, function(arg_19_0)
		pg = var_2_10001

		return var_2_10001.ship_data_group[arg_19_0].handbook_type == arg_18_0.toggleType
	end)
	local var_18_3 = var_0_1.ShipIndex.typeIndex

	ShipIndexConst = var_4

	if var_18_3 == var_4.TypeAll then
		var_18_3 = var_0_1.ShipIndex.rarityIndex
		ShipIndexConst = var_4

		if var_18_3 == var_4.RarityAll then
			var_18_3 = var_0_1.ShipIndex.campIndex
			ShipIndexConst = var_4

			if var_18_3 == var_4.CampAll and arg_18_0.toggleType == var_0_1.TOGGLE_CHAR then
				ipairs = var_18_3

				for iter_18_0, iter_18_1 in var_18_3(var_18_2) do
					pg = var_1_10008
					var_1_10008 = var_1_10008.ship_data_group[iter_18_1]
					var_1_10009 = nil

					local var_18_4 = false

					if var_1_10008 then
						var_1_10009 = arg_18_0.shipGroups[var_1_10008.group_type]
						Nation = var_11

						local var_18_5 = var_11.IsLinkType

						ShipGroup = var_12
						var_18_4 = var_18_5(var_12.getDefaultShipConfig(var_1_10008.group_type).nationality)
					end

					if var_0_8(arg_18_0.toggleType, var_18_4, iter_18_1) ~= -1 then
						var_18_0[iter_18_0] = {
							showTrans = false,
							code = var_11,
							group = var_1_10009
						}
					end
				end

				goto label_18_1
			end
		end
	end

	ipairs = var_18_3

	for iter_18_2, iter_18_3 in var_18_3(var_18_2) do
		pg = var_1_10008

		if var_1_10008.ship_data_group[iter_18_3] then
			ShipGroup = var_1_10009
			var_1_10009 = var_1_10009.New({
				id = var_1_10008.group_type
			})

			local var_18_6 = arg_18_0.shipGroups[var_1_10008.group_type]

			if var_1_10009 then
				ShipIndexConst = var_11

				if var_11.filterByType(var_1_10009, var_0_1.ShipIndex.typeIndex) then
					ShipIndexConst = var_11

					if var_11.filterByRarity(var_1_10009, var_0_1.ShipIndex.rarityIndex) then
						Nation = var_11

						local var_18_7 = var_11.IsLinkType(var_1_10009:getNation())

						if arg_18_0.toggleType == var_0_1.TOGGLE_CHAR and not var_18_7 then
							ShipIndexConst = var_12

							if var_12.filterByCamp(var_1_10009, var_0_1.ShipIndex.campIndex) then
								var_18_0[#var_18_0 + 1] = {
									showTrans = false,
									code = var_0_8(arg_18_0.toggleType, var_18_7, iter_18_3),
									group = var_18_6
								}

								goto label_18_0
							end
						end

						if arg_18_0.toggleType == var_0_1.TOGGLE_LINK and var_18_7 then
							var_18_0[#var_18_0 + 1] = {
								showTrans = false,
								code = var_0_8(arg_18_0.toggleType, var_18_7, iter_18_3),
								group = var_18_6
							}
						elseif arg_18_0.toggleType == var_0_1.TOGGLE_BLUEPRINT then
							ShipIndexConst = var_12

							if var_12.filterByCamp(var_1_10009, var_0_1.ShipIndex.campIndex) then
								var_18_0[#var_18_0 + 1] = {
									showTrans = false,
									code = var_0_8(arg_18_0.toggleType, var_18_7, iter_18_3),
									group = var_18_6
								}
							end
						end
					end
				end
			end
		end

		::label_18_0::
	end

	::label_18_1::

	arg_18_0.cardInfos = var_18_0

	local var_18_8 = arg_18_0.cardList

	var_3.SetTotalCount(var_18_8, #arg_18_0.cardInfos, -1)

	return
end

local function var_0_9(arg_20_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)

	return var_1.GetAllSkinForARCamera(var_20_0, arg_20_0)
end

local function var_0_10(arg_21_0)
	local var_21_0 = {}

	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	local var_21_1 = var_1_10002(var_1_10003)
	local var_21_2 = var_2.getSkinList(var_21_1)

	getProxy = var_21_1
	CollectionProxy = var_1_10005

	local var_21_3 = var_21_1(var_1_10005)

	if var_4.getShipGroup(var_21_3, arg_21_0) then
		ShipGroup = var_21_3

		local var_21_4 = var_21_3.getSkinList(arg_21_0)

		ipairs = var_6

		for iter_21_0, iter_21_1 in var_6(var_21_4) do
			local var_21_5 = iter_21_1.skin_type

			ShipSkin = var_1_10012

			if var_21_5 ~= var_1_10012.SKIN_TYPE_DEFAULT then
				table = var_21_5

				if not var_21_5.contains(var_21_2, iter_21_1.id) then
					local var_21_6 = iter_21_1.skin_type

					ShipSkin = var_1_10012

					if var_21_6 ~= var_1_10012.SKIN_TYPE_REMAKE or not var_4.trans then
						local var_21_7 = iter_21_1.skin_type

						ShipSkin = var_1_10012

						if var_21_7 ~= var_1_10012.SKIN_TYPE_PROPOSE or var_4.married ~= 1 then
							var_1_10012 = var_2

							if var_2.hasSkin(var_1_10012, iter_21_1.id) then
								var_21_0[iter_21_1.id] = true
							end
						end
					end
				end
			end
		end
	end

	return var_21_0
end

function var_0_1.onInitCard(arg_22_0, arg_22_1)
	SnapshotShipCard = var_1_10002

	local var_22_0 = var_1_10002.New(arg_22_1)

	onButton = var_3

	var_3(arg_22_0, var_22_0.go, function()
		if var_22_0.shipGroup then
			HXSet = var_0

			if var_0.isHxSkin() then
				ShipGroup = var_0

				local var_23_0 = var_0.getDefaultSkin(var_22_0.shipGroup.id)
				local var_23_1 = arg_22_0

				var_1.emit(var_23_1, var_0_1.SELECT_CHAR, var_23_0.id)

				local var_23_2 = arg_22_0

				var_1.back(var_23_2)

				return
			end

			if #var_0_9(var_22_0.shipGroup.id) > 1 then
				local var_23_3 = var_0_10(var_22_0.shipGroup.id)
				local var_23_4 = arg_22_0

				var_2.openSelectSkinPanel(var_23_4, var_0, var_23_3)
			elseif #var_0 == 1 then
				local var_23_5 = arg_22_0

				var_1.emit(var_23_5, var_0_1.SELECT_CHAR, var_0[1].id)

				local var_23_6 = arg_22_0

				var_1.back(var_23_6)
			end
		end

		return
	end)

	arg_22_0.cardItems[arg_22_1] = var_22_0

	return
end

function var_0_1.onUpdateCard(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0

	if not arg_24_0.cardItems[arg_24_2] then
		arg_24_0:onInitCard(arg_24_2)

		var_24_0 = arg_24_0.cardItems[arg_24_2]
	end

	local var_24_1 = arg_24_1 + 1

	if not arg_24_0.cardInfos[var_24_1] then
		return
	end

	local var_24_2

	if var_5.group then
		var_24_2 = arg_24_0.proposeList[var_5.group.id]
	end

	var_24_0:update(var_5.code, var_5.group, var_5.showTrans, var_24_2)

	return
end

function var_0_1.onReturnCard(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.exited then
		return
	end

	if arg_25_0.cardItems[arg_25_2] then
		var_3:clear()
	end

	arg_25_0.cardItems[arg_25_2] = nil

	return
end

function var_0_1.initSelectSkinPanel(arg_26_0)
	local var_26_0 = arg_26_0._tf

	arg_26_0.skinPanel = var_1.Find(var_26_0, "selectSkinPnl")

	local var_26_1 = arg_26_0.skinPanel
	local var_26_2 = var_1.Find(var_26_1, "select_skin/btnBack")

	onButton = var_26_1

	var_26_1(arg_26_0, var_26_2, function()
		local var_27_0 = arg_26_0

		var_0.closeSelectSkinPanel(var_27_0)

		return
	end)

	local var_26_3 = arg_26_0.skinPanel

	arg_26_0.skinScroll = var_2.Find(var_26_3, "select_skin/style_scroll")

	local var_26_4 = arg_26_0.skinScroll

	arg_26_0.skinContainer = var_2.Find(var_26_4, "view_port")

	local var_26_5 = arg_26_0.skinContainer

	arg_26_0.skinCard = var_2.GetChild(var_26_5, 0)
	setActive = var_2

	var_2(arg_26_0.skinCard, false)

	setActive = var_2

	var_2(arg_26_0.skinPanel, false)

	arg_26_0.skinCardMap = {}

	return
end

function var_0_1.openSelectSkinPanel(arg_28_0, arg_28_1, arg_28_2)
	setActive = var_1_10003

	var_1_10003(arg_28_0.skinPanel, true)

	pg = var_1_10003

	local var_28_0 = var_1_10003.UIMgr.GetInstance()

	var_3.BlurPanel(var_28_0, arg_28_0.skinPanel)

	for iter_28_0 = arg_28_0.skinContainer.childCount, #arg_28_1 - 1 do
		cloneTplTo = var_1_10007

		var_1_10007(arg_28_0.skinCard, arg_28_0.skinContainer)
	end

	for iter_28_1 = #arg_28_1, arg_28_0.skinContainer.childCount - 1 do
		setActive = var_1_10007

		local var_28_1 = arg_28_0.skinContainer

		var_1_10007(var_8.GetChild(var_28_1, iter_28_1), false)
	end

	local var_28_2 = arg_28_0.skinContainer.childCount

	ipairs = var_4

	for iter_28_2, iter_28_3 in var_4(arg_28_1) do
		local var_28_3 = arg_28_0.skinContainer
		local var_28_4 = var_9.GetChild(var_28_3, iter_28_2 - 1)
		local var_28_5

		if not arg_28_0.skinCardMap[var_28_4] then
			ShipSkinCard = var_11
			var_28_5 = var_11.New(var_28_4.gameObject)
			arg_28_0.skinCardMap[var_28_4] = var_28_5
		end

		local var_28_6 = arg_28_2[iter_28_3.id]

		var_28_5:updateSkin(iter_28_3, var_28_6)
		var_28_5:updateUsing(false)

		removeOnButton = var_12

		var_12(var_28_4)

		onButton = var_12

		var_12(arg_28_0, var_28_4, function()
			if var_28_6 then
				local var_29_0 = arg_28_0

				var_0.emit(var_29_0, var_0_1.SELECT_CHAR, iter_28_3.id)

				local var_29_1 = arg_28_0

				var_0.closeSelectSkinPanel(var_29_1)

				local var_29_2 = arg_28_0

				var_0.back(var_29_2)
			end

			return
		end)

		setActive = var_12

		var_12(var_28_4, true)
	end

	return
end

function var_0_1.closeSelectSkinPanel(arg_30_0)
	pg = var_1_10001

	local var_30_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_30_0, arg_30_0.skinPanel, arg_30_0._tf)

	setActive = var_1

	var_1(arg_30_0.skinPanel, false)

	return
end

return var_0_1
