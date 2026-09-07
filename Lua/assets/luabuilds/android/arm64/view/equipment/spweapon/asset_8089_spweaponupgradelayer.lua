local SpWeaponUpgradeLayer = class("SpWeaponUpgradeLayer", import("view.base.BaseUI"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = {
	15015,
	15016,
	15017
}
local var_0_7 = {
	typeIndex = IndexConst.SpWeaponTypeAll,
	rarityIndex = IndexConst.SpWeaponRarityAll
}

function SpWeaponUpgradeLayer:getUIName()
	return "SpWeaponUpgradeUI"
end

function SpWeaponUpgradeLayer:init()
	self:InitUI()

	self.consumeItems, self.consumeSpweapons = {}, {}
	self.loader = AutoLoader.New()

	return
end

function SpWeaponUpgradeLayer:InitUI()
	self.rightPanel = self._tf:Find("Right")
	self.leftPanel = self._tf:Find("Left")
	self.equipmentPanel = self.rightPanel:Find("EquipmentPanel")
	self.equipmentPanelTitleStrengthen = self.equipmentPanel:Find("Title/Strengthen")
	self.equipmentPanelTitleUpgrade = self.equipmentPanel:Find("Title/Upgrade")
	self.equipmentPanelTitleComposite = self.equipmentPanel:Find("Title/Composite")
	self.equipmentPanelIcon1 = self.equipmentPanel:Find("Container/Equiptpl")
	self.equipmentPanelIcon2 = self.equipmentPanel:Find("Container/Equiptpl2")
	self.equipmentPanelArrow = self.equipmentPanel:Find("Container/Slot")
	self.craftTargetCount = self.equipmentPanel:Find("TotalCount")
	self.materialPanel = self.rightPanel:Find("MaterialPanel")
	self.materialPanelAttrList = self.materialPanel:Find("ScrollView/List")
	self.materialPanelExpLv = self.materialPanel:Find("ExpLv")
	self.materialPanelExpLvText = self.materialPanel:Find("ExpLv/Number")

	setActive(self.materialPanelExpLvText, false)

	self.materialPanelExpFullText = self.materialPanel:Find("ExpFull")
	self.materialPanelExpBar = self.materialPanel:Find("ExpBar")
	self.materialPanelExpBarFill = self.materialPanel:Find("ExpBar/Fill")
	self.materialPanelExpBarFull = self.materialPanel:Find("ExpBar/Full")

	setText(self.materialPanel:Find("ExpFull"), i18n("spweapon_ui_levelmax"))

	self.materialPanelExpTotalText = self.materialPanel:Find("ExpTotal")
	self.materialPanelExpCurrentText = self.materialPanel:Find("ExpTotal/ExpCurrent")
	self.materialPanelMaterialList = self.materialPanel:Find("Materials/List")
	self.materialPanelMaterialListLimit = self.materialPanel:Find("Materials/Limit")
	self.materialPanelMaterialItems = CustomIndexLayer.Clone2Full(self.materialPanelMaterialList, 3)

	setText(self.materialPanel:Find("Materials/Title"), i18n("spweapon_ui_need_resource"))
	setText(self.materialPanel:Find("Materials/Limit/text"), i18n("spweapon_ui_levelmax2"))

	self.materialPanelCostText = self.materialPanel:Find("Cost/Consume")
	self.materialPanelButton = self.materialPanel:Find("Button")
	self.materialPanelButtonUpgrade = self.materialPanel:Find("Button/Upgrade")
	self.materialPanelButtonStrengthen = self.materialPanel:Find("Button/Strengthen")
	self.materialPanelButtonCreate = self.materialPanel:Find("Button/Create")

	setText(self.materialPanelButtonUpgrade, i18n("msgbox_text_breakthrough"))
	setText(self.materialPanelButtonStrengthen, i18n("msgbox_text_noPos_intensify"))
	setText(self.materialPanelButtonCreate, i18n("spweapon_ui_create_button"))

	self.leftPanelAutoSelectButton = self.leftPanel:Find("Title/AutoSelect")
	self.leftPanelClearSelectButton = self.leftPanel:Find("Title/ClearSelect")
	self.leftPanelItem = self.leftPanel:Find("Items")
	self.leftPanelItemRect = UIItemList.New(self.leftPanel:Find("Items/Content"), (self.leftPanel:Find("Items/EquipItem")))

	setText(self.leftPanel:Find("Items/Top/TextName"), i18n("spweapon_ui_ptitem"))
	setText(self.leftPanelAutoSelectButton:Find("On/Text"), i18n("spweapon_ui_autoselect"))
	setText(self.leftPanelAutoSelectButton:Find("Off/Text"), i18n("spweapon_ui_autoselect"))
	setText(self.leftPanelClearSelectButton:Find("On/Text"), i18n("spweapon_ui_cancelselect"))
	setText(self.leftPanelClearSelectButton:Find("Off/Text"), i18n("spweapon_ui_cancelselect"))

	self.LeftPanelEquip = self.leftPanel:Find("Equips")
	self.leftPanelEquipScrollComp = GetComponent(self.leftPanel:Find("Equips/Scroll View"), "LScrollRect")

	setText(self.leftPanel:Find("Equips/Top/TextName"), i18n("spweapon_ui_spweapon"))

	self.leftPanelFilterButton = self.leftPanel:Find("Equips/Top/Filter")

	setText(self.leftPanel:Find("TipText"), i18n("spweapon_ui_helptext"))
	setText(self.equipmentPanel:Find("Ship/Detail"), i18n("spweapon_tip_view"))
	setText(self.equipmentPanel:Find("Ship/Title"), i18n("spweapon_tip_ship"))
	setText(self.equipmentPanel:Find("ShipType/Title"), i18n("spweapon_tip_type"))
	setText(self.craftTargetCount:Find("Tip"), i18n("spweapon_tip_owned", ""))
	Canvas.ForceUpdateCanvases()

	return
end

function SpWeaponUpgradeLayer:setItems(arg_4_1)
	self.itemVOs = arg_4_1

	return
end

function SpWeaponUpgradeLayer:updateRes(arg_5_1)
	self.playerVO = arg_5_1

	return
end

function SpWeaponUpgradeLayer:SetSpWeapon(arg_6_1)
	self.spWeaponVO = arg_6_1

	return
end

function SpWeaponUpgradeLayer:SetSpWeaponList(arg_7_1)
	self.spWeaponList = arg_7_1

	return
end

function SpWeaponUpgradeLayer:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:emit(SpWeaponUpgradeLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.leftPanelFilterButton, function()
		self:emit(SpWeaponUpgradeMediator.OPEN_EQUIPMENT_INDEX, {
			indexDatas = Clone(self.contextData.indexDatas),
			customPanels = {
				typeIndex = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.SpWeaponTypeIndexs,
					names = IndexConst.SpWeaponTypeNames
				},
				rarityIndex = {
					mode = CustomIndexLayer.Mode.AND,
					options = IndexConst.SpWeaponRarityIndexs,
					names = IndexConst.SpWeaponRarityNames
				}
			},
			groupList = {
				{
					dropdown = false,
					titleENTxt = "indexsort_typeeng",
					titleTxt = "indexsort_type",
					tags = {
						"typeIndex"
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
			},
			callback = function(self)
				self.contextData.indexDatas.typeIndex = self.typeIndex
				self.contextData.indexDatas.rarityIndex = self.rarityIndex

				self:UpdateAll()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.leftPanelAutoSelectButton, function()
		self:AutoSelectMaterials()

		return
	end)
	onButton(self, self.leftPanelClearSelectButton, function()
		table.clear(self.consumeItems)
		self:UpdateAll(true)

		return
	end, SFX_CANCEL)

	function self.leftPanelEquipScrollComp:onInitItem()
		ClearTweenItemAlphaAndWhite(self.gameObject)

		return
	end

	function self.leftPanelEquipScrollComp.onUpdateItem(arg_15_0, arg_15_1)
		self:UpdateEquipItemByIndex(arg_15_0, arg_15_1)

		return
	end

	function self.leftPanelEquipScrollComp.onReturnItem(arg_16_0, arg_16_1)
		ClearTweenItemAlphaAndWhite(go(arg_16_1))

		return
	end

	self.leftPanelItemRect:make(function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1

		if arg_17_0 == UIItemList.EventInit then
			pressPersistTrigger(arg_17_2:Find("IconTpl"), 0.5, function(arg_18_0)
				local var_18_0 = self.candicateMaterials[arg_17_1].id
				local var_18_1 = self:GetSelectMaterial(self.candicateMaterials[arg_17_1].id)

				if var_18_1 then
					if self.itemVOs[var_18_0] then
						local var_18_3 = self.itemVOs[var_18_0].count or 0

						if self.ptMax then
							pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_upgrade"))
							arg_18_0()
						elseif (var_18_1.count or 0) == var_18_3 then
							arg_18_0()
						end

						if not var_18_1 then
							var_18_1 = Item.New({
								count = 0,
								id = var_18_0
							})

							table.insert(self.consumeItems, var_18_1)
						end
					end
				end

				var_18_1.count = var_18_1.count + 1

				self:UpdateAll(true)

				return
			end, nil, true, true, 0.15, SFX_PANEL)
			pressPersistTrigger(arg_17_2:Find("IconTpl/Reduce"), 0.5, function(arg_19_0)
				local var_19_0 = self:GetSelectMaterial(self.candicateMaterials[arg_17_1].id)

				if var_19_0 then
					if (var_19_0.count or 0) == 0 then
						arg_19_0()

						return
					end
				end

				var_19_0.count = var_19_0.count - 1

				if var_19_0.count <= 0 then
					table.removebyvalue(self.consumeItems, var_19_0)
				end

				self:UpdateAll(true)

				return
			end, nil, true, true, 0.15, SFX_PANEL)
		elseif arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = self.candicateMaterials[arg_17_1]

			updateDrop(arg_17_2:Find("IconTpl"), Drop.New({
				type = DROP_TYPE_ITEM,
				id = self.candicateMaterials[arg_17_1].id,
				count = self.candicateMaterials[arg_17_1].count
			}))
			setScrollText(arg_17_2:Find("Mask/NameText"), var_17_0:getConfig("name"))
			setText(arg_17_2:Find("IconTpl/icon_bg/count"), var_17_0.count)
			setActive(arg_17_2:Find("IconTpl/mask"), var_17_0.count == 0)

			local var_17_1 = self:GetSelectMaterial(var_17_0.id)

			setActive(arg_17_2:Find("IconTpl/Reduce"), var_17_1 and var_17_1.count > 0)

			if var_17_1 then
				setText(arg_17_2:Find("IconTpl/Reduce/Text"), var_17_1.count)
			end
		end

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.contextData.indexDatas = self.contextData.indexDatas or Clone(var_0_7)

	self:UpdateAll()

	return
end

function SpWeaponUpgradeLayer:UpdateEquipItemByIndex(arg_20_1, arg_20_2)
	arg_20_1 = arg_20_1 + 1

	TweenItemAlphaAndWhite(arg_20_2)
	self:UpdateEquipItem(self.candicateSpweapons[arg_20_1], arg_20_2)

	return
end

function SpWeaponUpgradeLayer:UpdateEquipItem(arg_21_1, arg_21_2)
	local var_21_0 = tf(arg_21_2)

	onButton(self, var_21_0, function()
		if self:GetSelectSpWeapon(arg_21_1) then
			return
		end

		if self.ptMax then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_upgrade"))

			return
		end

		seriesAsync({
			function(arg_23_0)
				if not arg_21_1:IsImportant() then
					return arg_23_0()
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					modal = true,
					type = MSGBOX_TYPE_CONFIRM_DELETE,
					title = pg.MsgboxMgr.TITLE_INFORMATION,
					onYes = arg_23_0,
					data = {
						name = arg_21_1:GetName()
					}
				})

				return
			end,
			function()
				table.insert(self.consumeSpweapons, arg_21_1)
				self:UpdateAll(true)
				self:UpdateEquipItem(arg_21_1, arg_21_2)

				return
			end
		})

		return
	end)
	onButton(self, var_21_0:Find("IconTpl/Reduce"), function()
		local var_25_0 = self:GetSelectSpWeapon(arg_21_1)

		if not var_25_0 then
			return
		end

		table.removebyvalue(self.consumeSpweapons, var_25_0)
		self:UpdateEquipItem(arg_21_1, arg_21_2)
		self:UpdateAll(true)

		return
	end)
	updateSpWeapon(var_21_0:Find("IconTpl"), arg_21_1)
	setScrollText(var_21_0:Find("Mask/NameText"), arg_21_1:GetName())

	local var_21_1 = arg_21_1:GetShipId()

	setActive(var_21_0:Find("EquipShip"), var_21_1)

	if var_21_1 and var_21_1 > 0 then
		setImageSprite(var_21_0:Find("EquipShip/Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_21_1):getPainting()))
	end

	local var_21_2 = self:GetSelectSpWeapon(arg_21_1)

	setActive(var_21_0:Find("IconTpl/Reduce"), var_21_2)

	if var_21_2 then
		setText(var_21_0:Find("IconTpl/Reduce/Text"), 1)
	end

	return
end

function SpWeaponUpgradeLayer:UpdateSelectPt()
	self.nextSpWeaponVO = nil
	self.upgradeType = nil
	self.upgradeMaxLevel = false
	self.ptMax = false

	local var_26_0 = self.spWeaponVO:GetPt() + SpWeapon.CalculateHistoryPt(self.consumeItems, self.consumeSpweapons)
	local var_26_1 = self.spWeaponVO:GetConfigID()
	local var_26_2 = 0
	local var_26_3 = 0
	local var_26_4 = 0
	local var_26_5 = 0
	local var_26_6 = {}

	local function var_26_7(arg_27_0)
		for iter_27_0, iter_27_1 in ipairs(arg_27_0) do
			local var_27_0 = iter_27_1[1]
			local var_27_1 = underscore.detect(var_26_6, function(arg_28_0)
				return arg_28_0.id == var_27_0
			end)

			if not var_27_1 then
				var_27_1 = Item.New({
					id = iter_27_1[1]
				})
				var_27_1.count = 0

				table.insert(var_26_6, var_27_1)
			end

			var_27_1.count = var_27_1.count + iter_27_1[2]
		end

		return
	end

	if self.craftMode == var_0_1 then
		local var_26_8 = SpWeapon.New({
			id = var_26_1
		}):GetUpgradeConfig()

		var_26_3 = var_26_3 + var_26_8.create_use_pt

		var_26_7(var_26_8.create_use_item)

		var_26_5 = var_26_5 + var_26_8.create_use_gold
		self.upgradeType = var_0_3
	end

	if var_26_3 <= var_26_0 then
		self.upgradeType = var_0_4

		repeat
			local var_26_9 = SpWeapon.New({
				id = var_26_1
			})
			local var_26_10 = var_26_9:GetNextUpgradeID()

			if var_26_10 == 0 then
				break
			end

			local var_26_11 = var_26_9:GetUpgradeConfig()

			var_26_2 = var_26_3
			var_26_3 = var_26_3 + var_26_11.upgrade_use_pt

			local var_26_12 = SpWeapon.New({
				id = var_26_10
			})

			if var_26_4 > 0 and var_26_12:GetRarity() > var_26_9:GetRarity() then
				break
			end

			if var_26_12:GetRarity() > var_26_9:GetRarity() then
				self.upgradeType = var_0_5
			end

			if var_26_0 < var_26_3 then
				break
			end

			var_26_7(var_26_11.upgrade_use_item)

			var_26_5 = var_26_5 + var_26_11.upgrade_use_gold
			var_26_4 = var_26_4 + 1
			var_26_1 = var_26_10
		until var_26_12:GetRarity() > var_26_9:GetRarity()
	end

	self.ptMax = var_26_3 <= var_26_0
	self.upgradeLevel = var_26_4
	self.upgradePtOrigin = var_26_2
	self.upgradePtTotal = math.min(var_26_0, var_26_3)
	self.upgradePtMax = var_26_3
	self.upgradNeedMaterials = var_26_6
	self.upgradNeedGold = var_26_5
	self.nextSpWeaponVO = self.spWeaponVO:MigrateTo(var_26_1)

	if self.craftMode == var_0_2 then
		self.upgradeMaxLevel = self.spWeaponVO:GetNextUpgradeID() == 0
	end

	return
end

function SpWeaponUpgradeLayer:AutoSelectMaterials()
	local var_29_0 = self.spWeaponVO:GetPt() + SpWeapon.CalculateHistoryPt(self.consumeItems, self.consumeSpweapons)
	local var_29_1 = self.spWeaponVO:GetConfigID()
	local var_29_2 = 0

	if self.craftMode == var_0_1 then
		var_29_2 = SpWeapon.New({
			id = var_29_1
		}):GetUpgradeConfig().create_use_pt
	end

	while true do
		local var_29_3 = SpWeapon.New({
			id = var_29_1
		})
		local var_29_4 = var_29_3:GetNextUpgradeID()

		if var_29_4 == 0 then
			break
		end

		var_29_2 = var_29_2 + var_29_3:GetUpgradeConfig().upgrade_use_pt

		if SpWeapon.New({
			id = var_29_4
		}):GetRarity() > self.spWeaponVO:GetRarity() then
			break
		end

		var_29_1 = var_29_4
	end

	if var_29_2 <= var_29_0 then
		return
	end

	local var_29_5 = _.values(_.map(self.candicateMaterials, function(arg_30_0)
		local var_30_0 = self:GetSelectMaterial(arg_30_0.id)
		local var_30_1 = arg_30_0.count - ((var_30_0 or nil) and (var_30_0.count or 0))

		return var_30_1 > 0 and Item.New({
			id = arg_30_0.id,
			count = var_30_1
		}) or nil
	end))

	local function var_29_6(arg_31_0)
		return Item.getConfigData(arg_31_0.id).usage_arg[1]
	end

	table.sort(var_29_5, function(arg_32_0, arg_32_1)
		return var_29_6(arg_32_0) > var_29_6(arg_32_1)
	end)

	local function var_29_8(arg_33_0, arg_33_1, arg_33_2)
		if not var_29_5[arg_33_0] then
			return false
		end

		local var_33_0 = var_29_6(var_29_5[arg_33_0])
		local var_33_1 = math.min(math.ceil(arg_33_1 / var_33_0), var_29_5[arg_33_0].count)

		arg_33_2 = Clone(arg_33_2)

		if arg_33_1 - var_33_0 * var_33_1 == 0 then
			table.insert(arg_33_2, {
				id = var_29_5[arg_33_0].id,
				count = var_33_1
			})

			return true, arg_33_2
		elseif arg_33_1 - var_33_0 * var_33_1 > 0 then
			local var_33_2, var_33_3 = var_29_8(arg_33_0 + 1, arg_33_1 - var_33_0 * var_33_1, {})

			if var_33_2 then
				table.insert(arg_33_2, {
					id = var_29_5[arg_33_0].id,
					count = var_33_1
				})
				table.insertto(arg_33_2, var_33_3)

				return true, arg_33_2
			else
				return false
			end
		elseif arg_33_1 - var_33_0 * var_33_1 < 0 then
			local var_33_4, var_33_5 = var_29_8(arg_33_0 + 1, arg_33_1 - var_33_0 * var_33_1 + var_33_0, {})

			if var_33_4 then
				table.insert(arg_33_2, {
					id = var_29_5[arg_33_0].id,
					count = math.max(var_33_1 - 1, 0)
				})
				table.insertto(arg_33_2, var_33_5)

				return true, arg_33_2
			else
				table.insert(arg_33_2, {
					id = var_29_5[arg_33_0].id,
					count = math.max(var_33_1, 0)
				})

				return true, arg_33_2
			end
		end

		return
	end

	local var_29_9, var_29_10 = (nil)(1, var_29_2 - var_29_0, {})

	var_29_10 = var_29_9 and var_29_10 or var_29_5

	_.each(var_29_10, function(arg_34_0)
		self:UpdateSelectMaterial(arg_34_0.id, arg_34_0.count)
		self:UpdateAll(true)

		return
	end)

	return
end

function SpWeaponUpgradeLayer:UpdateAll(arg_35_1)
	if not self.spWeaponVO:IsReal() then
		self.craftMode = var_0_1 or var_0_2
	end

	self:UpdateSelectPt()

	local var_35_0 = self.craftMode == var_0_2 and self.nextSpWeaponVO:GetConfigID() ~= self.spWeaponVO:GetConfigID()

	setActive(self.equipmentPanelIcon2, var_35_0)
	setActive(self.equipmentPanelArrow, var_35_0)

	if var_35_0 then
		updateSpWeapon(self.equipmentPanelIcon1, self.spWeaponVO)
		updateSpWeapon(self.equipmentPanelIcon2, self.nextSpWeaponVO)
		self:UpdateAttrs(self.materialPanelAttrList, self.spWeaponVO, self.nextSpWeaponVO)
	else
		updateSpWeapon(self.equipmentPanelIcon1, self.nextSpWeaponVO)
		self:UpdateAttrs(self.materialPanelAttrList, self.nextSpWeaponVO)
	end

	setText(self.equipmentPanel:Find("Name"), self.nextSpWeaponVO:GetName())

	local var_35_1 = self.nextSpWeaponVO:IsUnique()

	setActive(self.equipmentPanel:Find("ShipType"), not var_35_1)
	setActive(self.equipmentPanel:Find("Ship"), var_35_1)

	if var_35_1 then
		local var_35_2 = ShipGroup.getDefaultShipConfig(self.nextSpWeaponVO:GetUniqueGroup())
		local var_35_3

		if var_35_2 then
			var_35_3 = var_35_2.id or nil
		end

		assert(var_35_3 and var_35_3 > 0)

		if var_35_3 and var_35_3 > 0 then
			self.loader:GetSprite("qicon/" .. Ship.New({
				configId = var_35_3
			}):getPainting(), nil, self.equipmentPanel:Find("Ship/Icon/Image"))

			local function var_35_4()
				self:emit(BaseUI.ON_DROP, {
					type = DROP_TYPE_SHIP,
					id = var_35_3
				})

				return
			end

			self.equipmentPanel:Find("Ship/Detail"):GetComponent("RichText"):AddListener(var_35_4)
			onButton(self, self.equipmentPanel:Find("Ship/Icon"), var_35_4)
		end
	else
		local var_35_5 = ShipType.FilterOverQuZhuType((_.filter(self.nextSpWeaponVO:GetWearableShipTypes(), function(arg_37_0)
			return table.contains(ShipType.AllShipType, arg_37_0)
		end)))

		CustomIndexLayer.Clone2Full(self.equipmentPanel:Find("ShipType/List"), #var_35_5)

		for iter_35_0, iter_35_1 in ipairs(var_35_5) do
			self.loader:GetSprite("shiptype", ShipType.Type2CNLabel(iter_35_1), (self.equipmentPanel:Find("ShipType/List"):GetChild(iter_35_0 - 1)))
		end
	end

	self:UpdateExpBar()
	self:UpdateMaterials()
	self:UpdatePtMaterials(arg_35_1)
	self:UpdateCraftTargetCount()

	return
end

function SpWeaponUpgradeLayer:UpdateCraftTargetCount()
	setActive(self.craftTargetCount, self.craftMode == var_0_1)

	if not self.craftMode == var_0_1 then
		return
	end

	setText(self.craftTargetCount:Find("Text"), (_.reduce(self.spWeaponList, 0, function(arg_39_0, arg_39_1)
		if self.nextSpWeaponVO:GetOriginID() == arg_39_1:GetOriginID() then
			arg_39_0 = arg_39_0 + 1
		end

		return arg_39_0
	end)))

	return
end

function SpWeaponUpgradeLayer:UpdateAttrs(arg_40_1, arg_40_2, arg_40_3)
	local var_40_0
	local var_40_1

	if self.craftMode == var_0_1 then
		var_40_0 = SpWeaponHelper.TransformCompositeInfo(arg_40_2)
		var_40_1 = arg_40_2:GetSkillGroup()
		arg_40_3 = arg_40_2
	elseif self.craftMode == var_0_2 then
		arg_40_3 = arg_40_3 or arg_40_2
		var_40_0 = SpWeaponHelper.TransformUpgradeInfo(arg_40_2, arg_40_3)
		var_40_1 = arg_40_3:GetSkillGroup()
	end

	self:UpdateSpWeaponUpgradeInfo(arg_40_1, var_40_0, var_40_1, arg_40_3)

	return
end

function SpWeaponUpgradeLayer:UpdateSpWeaponUpgradeInfo(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = arg_41_1:Find("attr_tpl")

	removeAllChildren(arg_41_1:Find("attrs"))

	local function var_41_1(arg_42_0, arg_42_1)
		local var_42_0 = arg_42_0:Find("base")

		setText(var_42_0:Find("name"), arg_42_1.name)
		setActive(var_42_0:Find("value"), true)
		setText(var_42_0:Find("value"), arg_42_1.value)
		setActive(var_42_0:Find("effect"), false)
		setActive(var_42_0:Find("value/up"), arg_42_1.compare and arg_42_1.compare > 0)
		setActive(var_42_0:Find("value/down"), arg_42_1.compare and arg_42_1.compare < 0)
		triggerToggle(var_42_0, arg_42_1.lock_open)

		if not arg_42_1.lock_open and arg_42_1.sub and #arg_42_1.sub > 0 then
			GetComponent(var_42_0, typeof(Toggle)).enabled = true
		else
			setActive(var_42_0:Find("name/close"), false)
			setActive(var_42_0:Find("name/open"), false)

			GetComponent(var_42_0, typeof(Toggle)).enabled = false
		end

		return
	end

	;(function(arg_43_0, arg_43_1, arg_43_2)
		for iter_43_0, iter_43_1 in ipairs(arg_43_2) do
			var_41_1(cloneTplTo(arg_43_1, arg_43_0), iter_43_1)
		end

		return
	end)(arg_41_1:Find("attrs"), var_41_0, arg_41_2)

	local var_41_2 = {}

	if arg_41_3[1].skillId > 0 then
		table.insert(var_41_2, {
			name = i18n("spweapon_attr_effect"),
			effect = arg_41_3[1]
		})
	end

	for iter_41_0, iter_41_1 in ipairs(arg_41_3[2]) do
		table.insert(var_41_2, {
			isSkill = true,
			name = i18n("spweapon_attr_skillupgrade"),
			effect = iter_41_1
		})
	end

	local function var_41_3(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_0:Find("base")
		local var_44_1 = arg_44_1.effect

		setText(var_44_0:Find("name"), arg_44_1.name)
		setActive(var_44_0:Find("value"), false)
		setActive(var_44_0:Find("effect"), true)

		local var_44_2 = getSkillName(arg_44_1.effect.skillId)

		if not arg_44_1.effect.unlock then
			var_44_2 = setColorStr(var_44_2, "#a2a2a2")

			setTextColor(var_44_0:Find("effect"), SummerFeastScene.TransformColor("a2a2a2"))
		else
			setTextColor(var_44_0:Find("effect"), SummerFeastScene.TransformColor("FFDE00"))
		end

		local var_44_3 = "<material=underline event=displaySkill>" .. var_44_2 .. "</material>"

		var_44_0:Find("effect"):GetComponent("RichText"):AddListener(function(arg_45_0, arg_45_1)
			if arg_45_0 == "displaySkill" then
				local var_45_0 = getSkillDesc(var_44_1.skillId, var_44_1.lv)

				if not var_44_1.unlock then
					var_45_0 = setColorStr(i18n("spweapon_tip_skill_locked") .. var_45_0, "#a2a2a2")
				end

				if not arg_44_1.isSkill then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_SINGLE_ITEM,
						drop = {
							type = DROP_TYPE_SPWEAPON,
							id = arg_41_4:GetConfigID()
						},
						name = var_44_2,
						content = var_45_0
					})
				else
					self:emit(SpWeaponUpgradeMediator.ON_SKILLINFO, var_44_1.skillId, var_44_1.unlock, 10)
				end
			end

			return
		end)
		setText(var_44_0:Find("effect"), var_44_3)
		setActive(var_44_0:Find("value/up"), false)
		setActive(var_44_0:Find("value/down"), false)
		triggerToggle(var_44_0, false)
		setActive(var_44_0:Find("name/close"), false)
		setActive(var_44_0:Find("name/open"), false)

		GetComponent(var_44_0, typeof(Toggle)).enabled = false

		return
	end

	;(function(arg_46_0, arg_46_1, arg_46_2)
		for iter_46_0, iter_46_1 in ipairs(arg_46_2) do
			var_41_3(cloneTplTo(arg_46_1, arg_46_0), iter_46_1)
		end

		return
	end)(arg_41_1:Find("attrs"), var_41_0, var_41_2)

	return
end

function SpWeaponUpgradeLayer:UpdateExpBar()
	setActive(self.materialPanelExpLv, not self.upgradeMaxLevel)
	setActive(self.materialPanelExpFullText, self.upgradeMaxLevel)
	setActive(self.materialPanelExpBarFull, self.upgradeMaxLevel)

	if not self.upgradeMaxLevel then
		setSlider(self.materialPanelExpBar, 0, 1, (self.upgradePtTotal - self.upgradePtOrigin) / (self.upgradePtMax - self.upgradePtOrigin))

		if self.upgradeType == var_0_3 then
			setText(self.materialPanelExpLv, i18n("spweapon_ui_create_exp"))
		elseif self.upgradeType == var_0_4 then
			setText(self.materialPanelExpLv, i18n("spweapon_ui_upgrade_exp"))
		elseif self.upgradeType == var_0_5 then
			setText(self.materialPanelExpLv, i18n("spweapon_ui_breakout_exp"))
		end

		setText(self.materialPanelExpCurrentText, self.upgradePtTotal - self.upgradePtOrigin)
		setText(self.materialPanelExpTotalText, self.upgradePtMax - self.upgradePtOrigin)
	else
		setText(self.materialPanelExpCurrentText, 0)
		setText(self.materialPanelExpTotalText, 0)
	end

	return
end

function SpWeaponUpgradeLayer:UpdateMaterials()
	local var_48_0 = self.upgradNeedGold
	local var_48_1 = self.spWeaponVO:GetNextUpgradeID() == 0

	setActive(self.materialPanelMaterialList, not var_48_1)
	setActive(self.materialPanelMaterialListLimit, var_48_1)

	local var_48_2
	local var_48_3 = true

	for iter_48_0 = 1, #self.materialPanelMaterialItems do
		setActive(findTF(self.materialPanelMaterialItems[iter_48_0], "off"), not self.upgradNeedMaterials[iter_48_0])
		setActive(findTF(self.materialPanelMaterialItems[iter_48_0], "Icon"), self.upgradNeedMaterials[iter_48_0])

		if self.upgradNeedMaterials[iter_48_0] then
			local var_48_4 = findTF(self.materialPanelMaterialItems[iter_48_0], "Icon")
			local var_48_5 = {
				type = DROP_TYPE_ITEM,
				id = self.upgradNeedMaterials[iter_48_0].id,
				count = self.upgradNeedMaterials[iter_48_0].count
			}

			updateDrop(var_48_4, var_48_5)
			onButton(self, var_48_4, function()
				self:emit(BaseUI.ON_DROP, var_48_5)

				return
			end)

			local var_48_6 = defaultValue(self.itemVOs[self.upgradNeedMaterials[iter_48_0].id], {
				count = 0
			})
			local var_48_7 = self.upgradNeedMaterials[iter_48_0].count .. "/" .. var_48_6.count

			if var_48_6.count < self.upgradNeedMaterials[iter_48_0].count then
				var_48_7 = setColorStr(var_48_6.count, COLOR_RED) .. "/" .. self.upgradNeedMaterials[iter_48_0].count
				var_48_3 = false
				var_48_2 = self.upgradNeedMaterials[iter_48_0].id
			end

			local var_48_8 = findTF(var_48_4, "icon_bg/count")

			setActive(var_48_8, true)
			setText(var_48_8, var_48_7)

			local var_48_9 = var_48_4:Find("Click")

			setActive(var_48_9, not self.confirmUpgrade and self.upgradeType == var_0_5)
			onButton(self, var_48_9, function()
				self.confirmUpgrade = true

				setActive(var_48_9, not self.confirmUpgrade)

				return
			end)
		end
	end

	setText(self.materialPanelCostText, var_48_0)
	setActive(self.materialPanelButtonCreate, self.craftMode == var_0_1)
	setActive(self.materialPanelButtonUpgrade, self.craftMode == var_0_2 and self.upgradeType == var_0_5)
	setActive(self.materialPanelButtonStrengthen, self.craftMode == var_0_2 and self.upgradeType == var_0_4)
	setActive(self.equipmentPanelTitleComposite, self.craftMode == var_0_1)
	setActive(self.equipmentPanelTitleUpgrade, self.craftMode == var_0_2 and self.upgradeType == var_0_5)
	setActive(self.equipmentPanelTitleStrengthen, self.craftMode == var_0_2 and self.upgradeType == var_0_4)
	onButton(self, self.materialPanelButton, function()
		if not var_48_3 then
			if not ItemTipPanel.ShowItemTipbyID(var_48_2) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))
			end

			return
		end

		if self.playerVO.gold < var_48_0 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
				{
					59001,
					var_48_0 - self.playerVO.gold,
					var_48_0
				}
			})

			return
		end

		if not self.confirmUpgrade and self.upgradeType == var_0_5 and #self.upgradNeedMaterials > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_breakout_materal_check"))

			return
		end

		if self.craftMode == var_0_1 then
			self:emit(SpWeaponUpgradeMediator.EQUIPMENT_COMPOSITE, self.spWeaponVO:GetConfigID(), self.consumeItems, self.consumeSpweapons)
		elseif self.craftMode == var_0_2 then
			self:emit(SpWeaponUpgradeMediator.EQUIPMENT_UPGRADE, self.spWeaponVO:GetUID(), self.consumeItems, self.consumeSpweapons)
		end

		return
	end, SFX_UI_DOCKYARD_REINFORCE)
	setGray(self.materialPanelButton, self.upgradeMaxLevel)
	setButtonEnabled(self.materialPanelButton, not self.upgradeMaxLevel)

	return
end

function SpWeaponUpgradeLayer:UpdatePtMaterials(arg_52_1)
	self.candicateMaterials = _.map(var_0_6, function(arg_53_0)
		return self.itemVOs[arg_53_0] or Item.New({
			count = 0,
			id = arg_53_0
		})
	end)

	table.sort(self.candicateMaterials, function(arg_54_0, arg_54_1)
		return arg_54_0.id < arg_54_1.id
	end)

	local var_52_0 = table.equal(self.contextData.indexDatas, var_0_7)

	setActive(self.leftPanelFilterButton:Find("Off"), var_52_0)
	setActive(self.leftPanelFilterButton:Find("On"), not var_52_0)

	self.candicateSpweapons = {}

	for iter_52_0, iter_52_1 in pairs(self.spWeaponList) do
		if iter_52_1:GetUID() ~= self.spWeaponVO:GetUID() and not iter_52_1:IsUnCraftable() and not iter_52_1:GetShipId() and IndexConst.filterSpWeaponByType(iter_52_1, self.contextData.indexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_52_1, self.contextData.indexDatas.rarityIndex) then
			table.insert(self.candicateSpweapons, iter_52_1)
		end
	end

	table.sort(self.candicateSpweapons, CompareFuncs(SpWeaponSortCfg.sortFunc(SpWeaponSortCfg.sort[1], true)))
	self.leftPanelItemRect:align(#self.candicateMaterials)

	if not arg_52_1 then
		self.leftPanelEquipScrollComp:SetTotalCount(#self.candicateSpweapons)
	end

	setActive(self.leftPanelAutoSelectButton:Find("On"), not self.ptMax)
	setActive(self.leftPanelAutoSelectButton:Find("Off"), self.ptMax)
	setButtonEnabled(self.leftPanelAutoSelectButton, not self.ptMax)

	local var_52_1 = #self.consumeItems > 0

	setActive(self.leftPanelClearSelectButton:Find("On"), #self.consumeItems > 0)
	setActive(self.leftPanelClearSelectButton:Find("Off"), not var_52_1)
	setButtonEnabled(self.leftPanelClearSelectButton, var_52_1)

	return
end

function SpWeaponUpgradeLayer:UpdateSelectMaterial(arg_55_1, arg_55_2)
	local var_55_0 = self:GetSelectMaterial(arg_55_1)

	if var_55_0 then
		local var_55_1 = var_55_0.count or 0

		if self.itemVOs[arg_55_1] then
			local var_55_2 = self.itemVOs[arg_55_1].count or 0

			if arg_55_2 > 0 then
				if self.ptMax then
					pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_upgrade"))

					return true
				end

				arg_55_2 = math.min(arg_55_2, (math.max(var_55_2 - var_55_1, 0)))

				if arg_55_2 > 0 then
					if not var_55_0 then
						var_55_0 = Item.New({
							count = 0,
							id = arg_55_1
						})

						table.insert(self.consumeItems, var_55_0)
					end

					var_55_0.count = var_55_0.count + arg_55_2
				end

				if var_55_2 <= var_55_1 + arg_55_2 then
					return true
				end
			elseif arg_55_2 < 0 then
				arg_55_2 = math.max(arg_55_2, -var_55_1)

				if arg_55_2 < 0 and var_55_0 then
					var_55_0.count = var_55_0.count + arg_55_2

					if var_55_0.count <= 0 then
						table.removebyvalue(self.consumeItems, var_55_0)
					end
				end

				if var_55_1 + arg_55_2 <= 0 then
					return true
				end
			end
		end
	end

	return
end

function SpWeaponUpgradeLayer:GetSelectMaterial(arg_56_1)
	return _.detect(self.consumeItems, function(arg_57_0)
		return arg_57_0.id == arg_56_1
	end)
end

function SpWeaponUpgradeLayer:GetSelectSpWeapon(arg_58_1)
	if table.contains(self.consumeSpweapons, arg_58_1) then
		return arg_58_1
	end

	return
end

function SpWeaponUpgradeLayer:ClearSelectMaterials()
	table.clear(self.consumeItems)
	table.clear(self.consumeSpweapons)

	return
end

function SpWeaponUpgradeLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	ClearLScrollrect(self.leftPanelEquipScrollComp)
	self.loader:Clear()

	return
end

return SpWeaponUpgradeLayer
