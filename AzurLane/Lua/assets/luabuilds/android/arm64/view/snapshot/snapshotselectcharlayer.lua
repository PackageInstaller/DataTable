local var_0_0 = class("SnapshotSelectCharLayer", import("..base.BaseUI"))

var_0_0.ON_INDEX = "SnapshotSelectCharLayer.ON_INDEX"
var_0_0.SELECT_CHAR = "SnapshotSelectCharLayer.SELECT_CHAR"
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
	return "snapshotselectchar"
end

function var_0_0.back(arg_4_0)
	if arg_4_0.exited then
		return
	end

	arg_4_0:emit(var_0_0.ON_CLOSE)

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.toggleType = var_0_0.TOGGLE_UNDEFINED
	arg_5_0.topTF = arg_5_0._tf:Find("blur_panel/adapt/top")
	arg_5_0.backBtn = arg_5_0.topTF:Find("back_btn")
	arg_5_0.indexBtn = arg_5_0.topTF:Find("index_button")
	arg_5_0.toggleChar = arg_5_0._tf:Find("list_card/types/char")
	arg_5_0.toggleLink = arg_5_0._tf:Find("list_card/types/link")
	arg_5_0.toggleBlueprint = arg_5_0._tf:Find("list_card/types/blueprint")
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

	arg_5_0:initSelectSkinPanel()
	cameraPaintViewAdjust(false)
	pg.UIMgr.GetInstance():OverlayPanel(arg_5_0._tf)

	return
end

function var_0_0.didEnter(arg_9_0)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		arg_9_0:back()

		return
	end)
	onToggle(arg_9_0, arg_9_0.toggleChar, function()
		if arg_9_0.toggleType == var_0_0.TOGGLE_CHAR then
			return
		end

		arg_9_0.toggleType = var_0_0.TOGGLE_CHAR

		arg_9_0:updateCardList()

		return
	end)
	onToggle(arg_9_0, arg_9_0.toggleLink, function()
		if arg_9_0.toggleType == var_0_0.TOGGLE_LINK then
			return
		end

		arg_9_0.toggleType = var_0_0.TOGGLE_LINK

		arg_9_0:updateCardList()

		return
	end)
	onToggle(arg_9_0, arg_9_0.toggleBlueprint, function()
		if arg_9_0.toggleType == var_0_0.TOGGLE_BLUEPRINT then
			return
		end

		arg_9_0.toggleType = var_0_0.TOGGLE_BLUEPRINT

		arg_9_0:updateCardList()

		return
	end)
	onButton(arg_9_0, arg_9_0.indexBtn, function()
		local var_14_0 = Clone(var_0_0.ShipIndexData)

		if arg_9_0.toggleType == var_0_0.TOGGLE_LINK then
			var_14_0.customPanels.campIndex = nil
			var_14_0.groupList[2] = nil
		end

		var_14_0.indexDatas = Clone(var_0_0.ShipIndex)

		function var_14_0.callback(arg_15_0)
			var_0_0.ShipIndex.typeIndex = arg_15_0.typeIndex

			if arg_15_0.campIndex then
				var_0_0.ShipIndex.campIndex = arg_15_0.campIndex
			end

			var_0_0.ShipIndex.rarityIndex = arg_15_0.rarityIndex

			arg_9_0:updateCardList()

			return
		end

		arg_9_0:emit(var_0_0.ON_INDEX, var_14_0)

		return
	end)
	triggerToggle(arg_9_0.toggleChar, true)

	return
end

function var_0_0.willExit(arg_16_0)
	cameraPaintViewAdjust(true)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf)

	return
end

local function var_0_1(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0 == var_0_0.TOGGLE_CHAR and not arg_17_1 then
		return arg_17_2
	elseif arg_17_0 == var_0_0.TOGGLE_LINK and arg_17_1 then
		return arg_17_2 - 16
	elseif arg_17_0 == var_0_0.TOGGLE_BLUEPRINT then
		return arg_17_2 - 20000
	end

	return -1
end

function var_0_0.updateCardList(arg_18_0)
	local var_18_0 = _.filter(pg.ship_data_group.all, function(arg_19_0)
		return pg.ship_data_group[arg_19_0].handbook_type == arg_18_0.toggleType
	end)

	if var_0_0.ShipIndex.typeIndex == ShipIndexConst.TypeAll and var_0_0.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and var_0_0.ShipIndex.campIndex == ShipIndexConst.CampAll and arg_18_0.toggleType == var_0_0.TOGGLE_CHAR then
		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			local var_18_1
			local var_18_2 = false

			if pg.ship_data_group[iter_18_1] then
				var_18_1 = arg_18_0.shipGroups[pg.ship_data_group[iter_18_1].group_type]
				var_18_2 = Nation.IsLinkType(ShipGroup.getDefaultShipConfig(pg.ship_data_group[iter_18_1].group_type).nationality)
			end

			local var_18_3 = var_0_1(arg_18_0.toggleType, var_18_2, iter_18_1)

			if var_18_3 ~= -1 then
				({})[iter_18_0] = {
					showTrans = false,
					code = var_18_3,
					group = var_18_1
				}
			end
		end
	else
		for iter_18_2, iter_18_3 in ipairs(var_18_0) do
			if pg.ship_data_group[iter_18_3] then
				local var_18_4 = ShipGroup.New({
					id = pg.ship_data_group[iter_18_3].group_type
				})

				if var_18_4 and ShipIndexConst.filterByType(var_18_4, var_0_0.ShipIndex.typeIndex) and ShipIndexConst.filterByRarity(var_18_4, var_0_0.ShipIndex.rarityIndex) then
					local var_18_5 = Nation.IsLinkType(var_18_4:getNation())

					if arg_18_0.toggleType == var_0_0.TOGGLE_CHAR and not var_18_5 and ShipIndexConst.filterByCamp(var_18_4, var_0_0.ShipIndex.campIndex) then
						({})[#{} + 1] = {
							showTrans = false,
							code = var_0_1(arg_18_0.toggleType, var_18_5, iter_18_3),
							group = arg_18_0.shipGroups[pg.ship_data_group[iter_18_3].group_type]
						}
					elseif arg_18_0.toggleType == var_0_0.TOGGLE_LINK and var_18_5 then
						({})[#{} + 1] = {
							showTrans = false,
							code = var_0_1(arg_18_0.toggleType, var_18_5, iter_18_3),
							group = arg_18_0.shipGroups[pg.ship_data_group[iter_18_3].group_type]
						}
					elseif arg_18_0.toggleType == var_0_0.TOGGLE_BLUEPRINT and ShipIndexConst.filterByCamp(var_18_4, var_0_0.ShipIndex.campIndex) then
						({})[#{} + 1] = {
							showTrans = false,
							code = var_0_1(arg_18_0.toggleType, var_18_5, iter_18_3),
							group = arg_18_0.shipGroups[pg.ship_data_group[iter_18_3].group_type]
						}
					end
				end
			end
		end
	end

	arg_18_0.cardInfos = {}

	arg_18_0.cardList:SetTotalCount(#arg_18_0.cardInfos, -1)

	return
end

local function var_0_2(arg_20_0)
	return getProxy(ShipSkinProxy):GetAllSkinForARCamera(arg_20_0)
end

local function var_0_3(arg_21_0)
	local var_21_0 = getProxy(ShipSkinProxy)
	local var_21_1 = var_21_0:getSkinList()
	local var_21_2 = getProxy(CollectionProxy):getShipGroup(arg_21_0)

	if var_21_2 then
		for iter_21_0, iter_21_1 in ipairs((ShipGroup.getSkinList(arg_21_0))) do
			if iter_21_1.skin_type == ShipSkin.SKIN_TYPE_DEFAULT or table.contains(var_21_1, iter_21_1.id) or iter_21_1.skin_type == ShipSkin.SKIN_TYPE_REMAKE and var_21_2.trans or iter_21_1.skin_type == ShipSkin.SKIN_TYPE_PROPOSE and var_21_2.married == 1 or var_21_0:hasSkin(iter_21_1.id) then
				({})[iter_21_1.id] = true
			end
		end
	end

	return {}
end

function var_0_0.onInitCard(arg_22_0, arg_22_1)
	local var_22_0 = SnapshotShipCard.New(arg_22_1)

	onButton(arg_22_0, var_22_0.go, function()
		if var_22_0.shipGroup then
			if HXSet.isHxSkin() then
				arg_22_0:emit(var_0_0.SELECT_CHAR, ShipGroup.getDefaultSkin(var_22_0.shipGroup.id).id)
				arg_22_0:back()

				return
			end

			local var_23_0 = var_0_2(var_22_0.shipGroup.id)

			if #var_23_0 > 1 then
				arg_22_0:openSelectSkinPanel(var_23_0, (var_0_3(var_22_0.shipGroup.id)))
			elseif #var_23_0 == 1 then
				arg_22_0:emit(var_0_0.SELECT_CHAR, var_23_0[1].id)
				arg_22_0:back()
			end
		end

		return
	end)

	arg_22_0.cardItems[arg_22_1] = var_22_0

	return
end

function var_0_0.onUpdateCard(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.cardItems[arg_24_2]

	if not arg_24_0.cardItems[arg_24_2] then
		arg_24_0:onInitCard(arg_24_2)

		var_24_0 = arg_24_0.cardItems[arg_24_2]
	end

	local var_24_1 = arg_24_0.cardInfos[arg_24_1 + 1]

	if not arg_24_0.cardInfos[arg_24_1 + 1] then
		return
	end

	local var_24_2

	if var_24_1.group then
		var_24_2 = arg_24_0.proposeList[var_24_1.group.id]
	end

	var_24_0:update(var_24_1.code, var_24_1.group, var_24_1.showTrans, var_24_2)

	return
end

function var_0_0.onReturnCard(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.exited then
		return
	end

	if arg_25_0.cardItems[arg_25_2] then
		var_25_0:clear()
	end

	arg_25_0.cardItems[arg_25_2] = nil

	return
end

function var_0_0.initSelectSkinPanel(arg_26_0)
	arg_26_0.skinPanel = arg_26_0._tf:Find("selectSkinPnl")

	onButton(arg_26_0, arg_26_0.skinPanel:Find("select_skin/btnBack"), function()
		arg_26_0:closeSelectSkinPanel()

		return
	end)

	arg_26_0.skinScroll = arg_26_0.skinPanel:Find("select_skin/style_scroll")
	arg_26_0.skinContainer = arg_26_0.skinScroll:Find("view_port")
	arg_26_0.skinCard = arg_26_0.skinContainer:GetChild(0)

	setActive(arg_26_0.skinCard, false)
	setActive(arg_26_0.skinPanel, false)

	arg_26_0.skinCardMap = {}

	return
end

function var_0_0.openSelectSkinPanel(arg_28_0, arg_28_1, arg_28_2)
	setActive(arg_28_0.skinPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_28_0.skinPanel)

	for iter_28_0 = arg_28_0.skinContainer.childCount, #arg_28_1 - 1 do
		cloneTplTo(arg_28_0.skinCard, arg_28_0.skinContainer)
	end

	for iter_28_1 = #arg_28_1, arg_28_0.skinContainer.childCount - 1 do
		setActive(arg_28_0.skinContainer:GetChild(iter_28_1), false)
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_1) do
		local var_28_1 = arg_28_0.skinContainer:GetChild(iter_28_2 - 1)
		local var_28_2 = arg_28_0.skinCardMap[var_28_1]
		local var_28_3, var_28_4

		if not arg_28_0.skinCardMap[var_28_1] then
			var_28_2 = ShipSkinCard.New(var_28_1.gameObject)
			arg_28_0.skinCardMap[var_28_1] = var_28_2
			var_28_3 = var_28_2
			var_28_4 = iter_28_3
		end

		var_28_2:updateSkin(iter_28_3, arg_28_2[iter_28_3.id])
		var_28_2:updateUsing(false)
		removeOnButton(var_28_1)
		onButton(arg_28_0, var_28_1, function()
			if var_0 then
				arg_28_0:emit(var_0_0.SELECT_CHAR, iter_28_3.id)
				arg_28_0:closeSelectSkinPanel()
				arg_28_0:back()
			end

			return
		end)
		setActive(var_28_1, true)
	end

	return
end

function var_0_0.closeSelectSkinPanel(arg_30_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0.skinPanel, arg_30_0._tf)
	setActive(arg_30_0.skinPanel, false)

	return
end

return var_0_0
