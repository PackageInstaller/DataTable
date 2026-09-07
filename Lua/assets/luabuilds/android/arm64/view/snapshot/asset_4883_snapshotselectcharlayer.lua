local SnapshotSelectCharLayer = class("SnapshotSelectCharLayer", import("..base.BaseUI"))

SnapshotSelectCharLayer.ON_INDEX = "SnapshotSelectCharLayer.ON_INDEX"
SnapshotSelectCharLayer.SELECT_CHAR = "SnapshotSelectCharLayer.SELECT_CHAR"
SnapshotSelectCharLayer.TOGGLE_UNDEFINED = -1
SnapshotSelectCharLayer.TOGGLE_CHAR = 0
SnapshotSelectCharLayer.TOGGLE_LINK = 1
SnapshotSelectCharLayer.TOGGLE_BLUEPRINT = 2
SnapshotSelectCharLayer.ShipIndex = {
	typeIndex = ShipIndexConst.TypeAll,
	campIndex = ShipIndexConst.CampAll,
	rarityIndex = ShipIndexConst.RarityAll
}
SnapshotSelectCharLayer.ShipIndexData = {
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

function SnapshotSelectCharLayer:setShipGroups(arg_1_1)
	self.shipGroups = arg_1_1

	return
end

function SnapshotSelectCharLayer:setProposeList(arg_2_1)
	self.proposeList = arg_2_1

	return
end

function SnapshotSelectCharLayer:getUIName()
	return "snapshotselectchar"
end

function SnapshotSelectCharLayer:back()
	if self.exited then
		return
	end

	self:emit(SnapshotSelectCharLayer.ON_CLOSE)

	return
end

function SnapshotSelectCharLayer:init()
	self.toggleType = SnapshotSelectCharLayer.TOGGLE_UNDEFINED
	self.topTF = self._tf:Find("blur_panel/adapt/top")
	self.backBtn = self.topTF:Find("back_btn")
	self.indexBtn = self.topTF:Find("index_button")
	self.toggleChar = self._tf:Find("list_card/types/char")
	self.toggleLink = self._tf:Find("list_card/types/link")
	self.toggleBlueprint = self._tf:Find("list_card/types/blueprint")
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

	self:initSelectSkinPanel()
	cameraPaintViewAdjust(false)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function SnapshotSelectCharLayer:didEnter()
	onButton(self, self.backBtn, function()
		self:back()

		return
	end)
	onToggle(self, self.toggleChar, function()
		if self.toggleType == SnapshotSelectCharLayer.TOGGLE_CHAR then
			return
		end

		self.toggleType = SnapshotSelectCharLayer.TOGGLE_CHAR

		self:updateCardList()

		return
	end)
	onToggle(self, self.toggleLink, function()
		if self.toggleType == SnapshotSelectCharLayer.TOGGLE_LINK then
			return
		end

		self.toggleType = SnapshotSelectCharLayer.TOGGLE_LINK

		self:updateCardList()

		return
	end)
	onToggle(self, self.toggleBlueprint, function()
		if self.toggleType == SnapshotSelectCharLayer.TOGGLE_BLUEPRINT then
			return
		end

		self.toggleType = SnapshotSelectCharLayer.TOGGLE_BLUEPRINT

		self:updateCardList()

		return
	end)
	onButton(self, self.indexBtn, function()
		local var_14_0 = Clone(SnapshotSelectCharLayer.ShipIndexData)

		if self.toggleType == SnapshotSelectCharLayer.TOGGLE_LINK then
			var_14_0.customPanels.campIndex = nil
			var_14_0.groupList[2] = nil
		end

		var_14_0.indexDatas = Clone(SnapshotSelectCharLayer.ShipIndex)

		function var_14_0:callback()
			SnapshotSelectCharLayer.ShipIndex.typeIndex = self.typeIndex

			if self.campIndex then
				SnapshotSelectCharLayer.ShipIndex.campIndex = self.campIndex
			end

			SnapshotSelectCharLayer.ShipIndex.rarityIndex = self.rarityIndex

			self:updateCardList()

			return
		end

		self:emit(SnapshotSelectCharLayer.ON_INDEX, var_14_0)

		return
	end)
	triggerToggle(self.toggleChar, true)

	return
end

function SnapshotSelectCharLayer:willExit()
	cameraPaintViewAdjust(true)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

local function var_0_1(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0 == SnapshotSelectCharLayer.TOGGLE_CHAR and not arg_17_1 then
		return arg_17_2
	elseif arg_17_0 == SnapshotSelectCharLayer.TOGGLE_LINK and arg_17_1 then
		return arg_17_2 - 16
	elseif arg_17_0 == SnapshotSelectCharLayer.TOGGLE_BLUEPRINT then
		return arg_17_2 - 20000
	end

	return -1
end

function SnapshotSelectCharLayer:updateCardList()
	local var_18_0 = {}
	local var_18_1 = _.filter(pg.ship_data_group.all, function(arg_19_0)
		return pg.ship_data_group[arg_19_0].handbook_type == self.toggleType
	end)

	if SnapshotSelectCharLayer.ShipIndex.typeIndex == ShipIndexConst.TypeAll and SnapshotSelectCharLayer.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and SnapshotSelectCharLayer.ShipIndex.campIndex == ShipIndexConst.CampAll and self.toggleType == SnapshotSelectCharLayer.TOGGLE_CHAR then
		for iter_18_0, iter_18_1 in ipairs(var_18_1) do
			local var_18_2
			local var_18_3 = false

			if pg.ship_data_group[iter_18_1] then
				var_18_2 = self.shipGroups[pg.ship_data_group[iter_18_1].group_type]
				var_18_3 = Nation.IsLinkType(ShipGroup.getDefaultShipConfig(pg.ship_data_group[iter_18_1].group_type).nationality)
			end

			local var_18_4 = var_0_1(self.toggleType, var_18_3, iter_18_1)

			if var_18_4 ~= -1 then
				var_18_0[iter_18_0] = {
					showTrans = false,
					code = var_18_4,
					group = var_18_2
				}
			end
		end
	else
		for iter_18_2, iter_18_3 in ipairs(var_18_1) do
			if pg.ship_data_group[iter_18_3] then
				local var_18_5 = ShipGroup.New({
					id = pg.ship_data_group[iter_18_3].group_type
				})

				if var_18_5 and ShipIndexConst.filterByType(var_18_5, SnapshotSelectCharLayer.ShipIndex.typeIndex) and ShipIndexConst.filterByRarity(var_18_5, SnapshotSelectCharLayer.ShipIndex.rarityIndex) then
					local var_18_6 = Nation.IsLinkType(var_18_5:getNation())

					if self.toggleType == SnapshotSelectCharLayer.TOGGLE_CHAR and not var_18_6 and ShipIndexConst.filterByCamp(var_18_5, SnapshotSelectCharLayer.ShipIndex.campIndex) then
						var_18_0[#var_18_0 + 1] = {
							showTrans = false,
							code = var_0_1(self.toggleType, var_18_6, iter_18_3),
							group = self.shipGroups[pg.ship_data_group[iter_18_3].group_type]
						}
					elseif self.toggleType == SnapshotSelectCharLayer.TOGGLE_LINK and var_18_6 then
						var_18_0[#var_18_0 + 1] = {
							showTrans = false,
							code = var_0_1(self.toggleType, var_18_6, iter_18_3),
							group = self.shipGroups[pg.ship_data_group[iter_18_3].group_type]
						}
					elseif self.toggleType == SnapshotSelectCharLayer.TOGGLE_BLUEPRINT and ShipIndexConst.filterByCamp(var_18_5, SnapshotSelectCharLayer.ShipIndex.campIndex) then
						var_18_0[#var_18_0 + 1] = {
							showTrans = false,
							code = var_0_1(self.toggleType, var_18_6, iter_18_3),
							group = self.shipGroups[pg.ship_data_group[iter_18_3].group_type]
						}
					end
				end
			end
		end
	end

	self.cardInfos = var_18_0

	self.cardList:SetTotalCount(#self.cardInfos, -1)

	return
end

local function var_0_2(arg_20_0)
	return getProxy(ShipSkinProxy):GetAllSkinForARCamera(arg_20_0)
end

local function var_0_3(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = getProxy(ShipSkinProxy)
	local var_21_2 = var_21_1:getSkinList()
	local var_21_3 = getProxy(CollectionProxy):getShipGroup(arg_21_0)

	if var_21_3 then
		for iter_21_0, iter_21_1 in ipairs((ShipGroup.getSkinList(arg_21_0))) do
			if iter_21_1.skin_type == ShipSkin.SKIN_TYPE_DEFAULT or table.contains(var_21_2, iter_21_1.id) or iter_21_1.skin_type == ShipSkin.SKIN_TYPE_REMAKE and var_21_3.trans or iter_21_1.skin_type == ShipSkin.SKIN_TYPE_PROPOSE and var_21_3.married == 1 or var_21_1:hasSkin(iter_21_1.id) then
				var_21_0[iter_21_1.id] = true
			end
		end
	end

	return var_21_0
end

function SnapshotSelectCharLayer:onInitCard(arg_22_1)
	local var_22_0 = SnapshotShipCard.New(arg_22_1)

	onButton(self, var_22_0.go, function()
		if var_22_0.shipGroup then
			if HXSet.isHxSkin() then
				self:emit(SnapshotSelectCharLayer.SELECT_CHAR, ShipGroup.getDefaultSkin(var_22_0.shipGroup.id).id)
				self:back()

				return
			end

			local var_23_0 = var_0_2(var_22_0.shipGroup.id)

			if #var_23_0 > 1 then
				self:openSelectSkinPanel(var_23_0, (var_0_3(var_22_0.shipGroup.id)))
			elseif #var_23_0 == 1 then
				self:emit(SnapshotSelectCharLayer.SELECT_CHAR, var_23_0[1].id)
				self:back()
			end
		end

		return
	end)

	self.cardItems[arg_22_1] = var_22_0

	return
end

function SnapshotSelectCharLayer:onUpdateCard(arg_24_1, arg_24_2)
	local var_24_0 = self.cardItems[arg_24_2]

	if not self.cardItems[arg_24_2] then
		self:onInitCard(arg_24_2)

		var_24_0 = self.cardItems[arg_24_2]
	end

	local var_24_1 = self.cardInfos[arg_24_1 + 1]

	if not self.cardInfos[arg_24_1 + 1] then
		return
	end

	var_24_0:update(var_24_1.code, var_24_1.group, var_24_1.showTrans, (var_24_1.group or nil) and self.proposeList[var_24_1.group.id])

	return
end

function SnapshotSelectCharLayer:onReturnCard(arg_25_1, arg_25_2)
	if self.exited then
		return
	end

	if self.cardItems[arg_25_2] then
		self.cardItems[arg_25_2]:clear()
	end

	self.cardItems[arg_25_2] = nil

	return
end

function SnapshotSelectCharLayer:initSelectSkinPanel()
	self.skinPanel = self._tf:Find("selectSkinPnl")

	onButton(self, self.skinPanel:Find("select_skin/btnBack"), function()
		self:closeSelectSkinPanel()

		return
	end)

	self.skinScroll = self.skinPanel:Find("select_skin/style_scroll")
	self.skinContainer = self.skinScroll:Find("view_port")
	self.skinCard = self.skinContainer:GetChild(0)

	setActive(self.skinCard, false)
	setActive(self.skinPanel, false)

	self.skinCardMap = {}

	return
end

function SnapshotSelectCharLayer:openSelectSkinPanel(arg_28_1, arg_28_2)
	setActive(self.skinPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(self.skinPanel)

	for iter_28_0 = self.skinContainer.childCount, #arg_28_1 - 1 do
		cloneTplTo(self.skinCard, self.skinContainer)
	end

	for iter_28_1 = #arg_28_1, self.skinContainer.childCount - 1 do
		setActive(self.skinContainer:GetChild(iter_28_1), false)
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_1) do
		local var_28_1 = self.skinContainer:GetChild(iter_28_2 - 1)
		local var_28_2 = self.skinCardMap[var_28_1]

		if not self.skinCardMap[var_28_1] then
			var_28_2 = ShipSkinCard.New(var_28_1.gameObject)
			self.skinCardMap[var_28_1] = var_28_2
		end

		local var_28_3 = arg_28_2[iter_28_3.id]

		var_28_2:updateSkin(iter_28_3, arg_28_2[iter_28_3.id])
		var_28_2:updateUsing(false)
		removeOnButton(var_28_1)
		onButton(self, var_28_1, function()
			if var_28_3 then
				self:emit(SnapshotSelectCharLayer.SELECT_CHAR, iter_28_3.id)
				self:closeSelectSkinPanel()
				self:back()
			end

			return
		end)
		setActive(var_28_1, true)
	end

	return
end

function SnapshotSelectCharLayer:closeSelectSkinPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.skinPanel, self._tf)
	setActive(self.skinPanel, false)

	return
end

return SnapshotSelectCharLayer
