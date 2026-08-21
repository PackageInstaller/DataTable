local var_0_0 = class("SpWeaponUpgradeLayer", import("view.base.BaseUI"))
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

function var_0_0.getUIName(arg_1_0)
	return "SpWeaponUpgradeUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.consumeItems, arg_2_0.consumeSpweapons = {}, {}
	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.rightPanel = arg_3_0._tf:Find("Right")
	arg_3_0.leftPanel = arg_3_0._tf:Find("Left")
	arg_3_0.equipmentPanel = arg_3_0.rightPanel:Find("EquipmentPanel")
	arg_3_0.equipmentPanelTitleStrengthen = arg_3_0.equipmentPanel:Find("Title/Strengthen")
	arg_3_0.equipmentPanelTitleUpgrade = arg_3_0.equipmentPanel:Find("Title/Upgrade")
	arg_3_0.equipmentPanelTitleComposite = arg_3_0.equipmentPanel:Find("Title/Composite")
	arg_3_0.equipmentPanelIcon1 = arg_3_0.equipmentPanel:Find("Container/Equiptpl")
	arg_3_0.equipmentPanelIcon2 = arg_3_0.equipmentPanel:Find("Container/Equiptpl2")
	arg_3_0.equipmentPanelArrow = arg_3_0.equipmentPanel:Find("Container/Slot")
	arg_3_0.craftTargetCount = arg_3_0.equipmentPanel:Find("TotalCount")
	arg_3_0.materialPanel = arg_3_0.rightPanel:Find("MaterialPanel")
	arg_3_0.materialPanelAttrList = arg_3_0.materialPanel:Find("ScrollView/List")
	arg_3_0.materialPanelExpLv = arg_3_0.materialPanel:Find("ExpLv")
	arg_3_0.materialPanelExpLvText = arg_3_0.materialPanel:Find("ExpLv/Number")

	setActive(arg_3_0.materialPanelExpLvText, false)

	arg_3_0.materialPanelExpFullText = arg_3_0.materialPanel:Find("ExpFull")
	arg_3_0.materialPanelExpBar = arg_3_0.materialPanel:Find("ExpBar")
	arg_3_0.materialPanelExpBarFill = arg_3_0.materialPanel:Find("ExpBar/Fill")
	arg_3_0.materialPanelExpBarFull = arg_3_0.materialPanel:Find("ExpBar/Full")

	setText(arg_3_0.materialPanel:Find("ExpFull"), i18n("spweapon_ui_levelmax"))

	arg_3_0.materialPanelExpTotalText = arg_3_0.materialPanel:Find("ExpTotal")
	arg_3_0.materialPanelExpCurrentText = arg_3_0.materialPanel:Find("ExpTotal/ExpCurrent")
	arg_3_0.materialPanelMaterialList = arg_3_0.materialPanel:Find("Materials/List")
	arg_3_0.materialPanelMaterialListLimit = arg_3_0.materialPanel:Find("Materials/Limit")
	arg_3_0.materialPanelMaterialItems = CustomIndexLayer.Clone2Full(arg_3_0.materialPanelMaterialList, 3)

	setText(arg_3_0.materialPanel:Find("Materials/Title"), i18n("spweapon_ui_need_resource"))
	setText(arg_3_0.materialPanel:Find("Materials/Limit/text"), i18n("spweapon_ui_levelmax2"))

	arg_3_0.materialPanelCostText = arg_3_0.materialPanel:Find("Cost/Consume")
	arg_3_0.materialPanelButton = arg_3_0.materialPanel:Find("Button")
	arg_3_0.materialPanelButtonUpgrade = arg_3_0.materialPanel:Find("Button/Upgrade")
	arg_3_0.materialPanelButtonStrengthen = arg_3_0.materialPanel:Find("Button/Strengthen")
	arg_3_0.materialPanelButtonCreate = arg_3_0.materialPanel:Find("Button/Create")

	setText(arg_3_0.materialPanelButtonUpgrade, i18n("msgbox_text_breakthrough"))
	setText(arg_3_0.materialPanelButtonStrengthen, i18n("msgbox_text_noPos_intensify"))
	setText(arg_3_0.materialPanelButtonCreate, i18n("spweapon_ui_create_button"))

	arg_3_0.leftPanelAutoSelectButton = arg_3_0.leftPanel:Find("Title/AutoSelect")
	arg_3_0.leftPanelClearSelectButton = arg_3_0.leftPanel:Find("Title/ClearSelect")
	arg_3_0.leftPanelItem = arg_3_0.leftPanel:Find("Items")
	arg_3_0.leftPanelItemRect = UIItemList.New(arg_3_0.leftPanel:Find("Items/Content"), (arg_3_0.leftPanel:Find("Items/EquipItem")))

	setText(arg_3_0.leftPanel:Find("Items/Top/TextName"), i18n("spweapon_ui_ptitem"))
	setText(arg_3_0.leftPanelAutoSelectButton:Find("On/Text"), i18n("spweapon_ui_autoselect"))
	setText(arg_3_0.leftPanelAutoSelectButton:Find("Off/Text"), i18n("spweapon_ui_autoselect"))
	setText(arg_3_0.leftPanelClearSelectButton:Find("On/Text"), i18n("spweapon_ui_cancelselect"))
	setText(arg_3_0.leftPanelClearSelectButton:Find("Off/Text"), i18n("spweapon_ui_cancelselect"))

	arg_3_0.LeftPanelEquip = arg_3_0.leftPanel:Find("Equips")
	arg_3_0.leftPanelEquipScrollComp = GetComponent(arg_3_0.leftPanel:Find("Equips/Scroll View"), "LScrollRect")

	setText(arg_3_0.leftPanel:Find("Equips/Top/TextName"), i18n("spweapon_ui_spweapon"))

	arg_3_0.leftPanelFilterButton = arg_3_0.leftPanel:Find("Equips/Top/Filter")

	setText(arg_3_0.leftPanel:Find("TipText"), i18n("spweapon_ui_helptext"))
	setText(arg_3_0.equipmentPanel:Find("Ship/Detail"), i18n("spweapon_tip_view"))
	setText(arg_3_0.equipmentPanel:Find("Ship/Title"), i18n("spweapon_tip_ship"))
	setText(arg_3_0.equipmentPanel:Find("ShipType/Title"), i18n("spweapon_tip_type"))
	setText(arg_3_0.craftTargetCount:Find("Tip"), i18n("spweapon_tip_owned", ""))
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.setItems(arg_4_0, arg_4_1)
	arg_4_0.itemVOs = arg_4_1

	return
end

function var_0_0.updateRes(arg_5_0, arg_5_1)
	arg_5_0.playerVO = arg_5_1

	return
end

function var_0_0.SetSpWeapon(arg_6_0, arg_6_1)
	arg_6_0.spWeaponVO = arg_6_1

	return
end

function var_0_0.SetSpWeaponList(arg_7_0, arg_7_1)
	arg_7_0.spWeaponList = arg_7_1

	return
end

function var_0_0.didEnter(arg_8_0)
	onButton(arg_8_0, arg_8_0._tf:Find("BG"), function()
		arg_8_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.leftPanelFilterButton, function()
		arg_8_0:emit(SpWeaponUpgradeMediator.OPEN_EQUIPMENT_INDEX, {
			indexDatas = Clone(arg_8_0.contextData.indexDatas),
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
			callback = function(arg_11_0)
				arg_8_0.contextData.indexDatas.typeIndex = arg_11_0.typeIndex
				arg_8_0.contextData.indexDatas.rarityIndex = arg_11_0.rarityIndex

				arg_8_0:UpdateAll()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.leftPanelAutoSelectButton, function()
		arg_8_0:AutoSelectMaterials()

		return
	end)
	onButton(arg_8_0, arg_8_0.leftPanelClearSelectButton, function()
		table.clear(arg_8_0.consumeItems)
		arg_8_0:UpdateAll(true)

		return
	end, SFX_CANCEL)

	function arg_8_0.leftPanelEquipScrollComp.onInitItem(arg_14_0)
		ClearTweenItemAlphaAndWhite(arg_14_0.gameObject)

		return
	end

	function arg_8_0.leftPanelEquipScrollComp.onUpdateItem(arg_15_0, arg_15_1)
		arg_8_0:UpdateEquipItemByIndex(arg_15_0, arg_15_1)

		return
	end

	function arg_8_0.leftPanelEquipScrollComp.onReturnItem(arg_16_0, arg_16_1)
		ClearTweenItemAlphaAndWhite(go(arg_16_1))

		return
	end

	arg_8_0.leftPanelItemRect:make(function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1

		if arg_17_0 == UIItemList.EventInit then
			pressPersistTrigger(arg_17_2:Find("IconTpl"), 0.5, function(arg_18_0)
				local var_18_0 = arg_8_0.candicateMaterials[arg_17_1].id
				local var_18_1 = arg_8_0:GetSelectMaterial(arg_8_0.candicateMaterials[arg_17_1].id)

				if var_18_1 then
					local var_18_2 = var_18_1.count or 0

					if arg_8_0.itemVOs[var_18_0] then
						local var_18_3 = arg_8_0.itemVOs[var_18_0].count or 0

						if arg_8_0.ptMax then
							pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_upgrade"))
							arg_18_0()
						elseif var_18_2 == var_18_3 then
							arg_18_0()
						else
							if not var_18_1 then
								var_18_1 = Item.New({
									count = 0,
									id = var_18_0
								})

								table.insert(arg_8_0.consumeItems, var_18_1)
							end

							var_18_1.count = var_18_1.count + 1

							arg_8_0:UpdateAll(true)
						end

						return
					end
				end
			end, nil, true, true, 0.15, SFX_PANEL)
			pressPersistTrigger(arg_17_2:Find("IconTpl/Reduce"), 0.5, function(arg_19_0)
				local var_19_0 = arg_8_0:GetSelectMaterial(arg_8_0.candicateMaterials[arg_17_1].id)

				if var_19_0 then
					local var_19_1 = var_19_0.count or 0

					if var_19_1 == 0 then
						arg_19_0()

						return
					end

					var_19_0.count = var_19_0.count - 1

					if var_19_0.count <= 0 then
						table.removebyvalue(arg_8_0.consumeItems, var_19_0)
					end

					arg_8_0:UpdateAll(true)

					return
				end
			end, nil, true, true, 0.15, SFX_PANEL)
		elseif arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = arg_8_0.candicateMaterials[arg_17_1]

			updateDrop(arg_17_2:Find("IconTpl"), Drop.New({
				type = DROP_TYPE_ITEM,
				id = arg_8_0.candicateMaterials[arg_17_1].id,
				count = arg_8_0.candicateMaterials[arg_17_1].count
			}))
			setScrollText(arg_17_2:Find("Mask/NameText"), var_17_0:getConfig("name"))
			setText(arg_17_2:Find("IconTpl/icon_bg/count"), var_17_0.count)
			setActive(arg_17_2:Find("IconTpl/mask"), var_17_0.count == 0)

			local var_17_1 = arg_8_0:GetSelectMaterial(var_17_0.id)

			setActive(arg_17_2:Find("IconTpl/Reduce"), var_17_1 and var_17_1.count > 0)

			if var_17_1 then
				setText(arg_17_2:Find("IconTpl/Reduce/Text"), var_17_1.count)
			end
		end

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)

	arg_8_0.contextData.indexDatas = arg_8_0.contextData.indexDatas or Clone(var_0_7)

	arg_8_0:UpdateAll()

	return
end

function var_0_0.UpdateEquipItemByIndex(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1 = arg_20_1 + 1

	TweenItemAlphaAndWhite(arg_20_2)
	arg_20_0:UpdateEquipItem(arg_20_0.candicateSpweapons[arg_20_1], arg_20_2)

	return
end

function var_0_0.UpdateEquipItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = tf(arg_21_2)

	onButton(arg_21_0, var_21_0, function()
		if arg_21_0:GetSelectSpWeapon(arg_21_1) then
			return
		end

		if arg_21_0.ptMax then
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
				table.insert(arg_21_0.consumeSpweapons, arg_21_1)
				arg_21_0:UpdateAll(true)
				arg_21_0:UpdateEquipItem(arg_21_1, arg_21_2)

				return
			end
		})

		return
	end)
	onButton(arg_21_0, var_21_0:Find("IconTpl/Reduce"), function()
		local var_25_0 = arg_21_0:GetSelectSpWeapon(arg_21_1)

		if not var_25_0 then
			return
		end

		table.removebyvalue(arg_21_0.consumeSpweapons, var_25_0)
		arg_21_0:UpdateEquipItem(arg_21_1, arg_21_2)
		arg_21_0:UpdateAll(true)

		return
	end)
	updateSpWeapon(var_21_0:Find("IconTpl"), arg_21_1)
	setScrollText(var_21_0:Find("Mask/NameText"), arg_21_1:GetName())

	local var_21_1 = arg_21_1:GetShipId()

	setActive(var_21_0:Find("EquipShip"), var_21_1)

	if var_21_1 and var_21_1 > 0 then
		setImageSprite(var_21_0:Find("EquipShip/Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_21_1):getPainting()))
	end

	local var_21_2 = arg_21_0:GetSelectSpWeapon(arg_21_1)

	setActive(var_21_0:Find("IconTpl/Reduce"), var_21_2)

	if var_21_2 then
		setText(var_21_0:Find("IconTpl/Reduce/Text"), 1)
	end

	return
end

function var_0_0.UpdateSelectPt(arg_26_0)
	arg_26_0.nextSpWeaponVO = nil
	arg_26_0.upgradeType = nil
	arg_26_0.upgradeMaxLevel = false
	arg_26_0.ptMax = false

	local var_26_0 = arg_26_0.spWeaponVO:GetPt() + SpWeapon.CalculateHistoryPt(arg_26_0.consumeItems, arg_26_0.consumeSpweapons)
	local var_26_1 = arg_26_0.spWeaponVO:GetConfigID()
	local var_26_2 = 0
	local var_26_3 = 0
	local var_26_4 = 0
	local var_26_5 = 0
	local var_26_6 = {}

	if arg_26_0.craftMode == var_0_1 then
		local var_26_7 = SpWeapon.New({
			id = var_26_1
		}):GetUpgradeConfig()

		var_26_3 = var_26_3 + var_26_7.create_use_pt

		;(function(arg_27_0)
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
		end)(var_26_7.create_use_item)

		var_26_5 = var_26_5 + var_26_7.create_use_gold
		arg_26_0.upgradeType = var_0_3
	end

	if var_26_3 <= var_26_0 then
		arg_26_0.upgradeType = var_0_4

		repeat
			local var_26_8 = SpWeapon.New({
				id = var_26_1
			})
			local var_26_9 = var_26_8:GetNextUpgradeID()

			if var_26_9 == 0 then
				break
			end

			local var_26_10 = var_26_8:GetUpgradeConfig()

			var_26_2 = var_26_3
			var_26_3 = var_26_3 + var_26_10.upgrade_use_pt

			local var_26_11 = SpWeapon.New({
				id = var_26_9
			})

			if var_26_4 > 0 and var_26_11:GetRarity() > var_26_8:GetRarity() then
				break
			end

			if var_26_11:GetRarity() > var_26_8:GetRarity() then
				arg_26_0.upgradeType = var_0_5
			end

			if var_26_0 < var_26_3 then
				break
			end

			;(function(arg_27_0)
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
			end)(var_26_10.upgrade_use_item)

			var_26_5 = var_26_5 + var_26_10.upgrade_use_gold
			var_26_4 = var_26_4 + 1
			var_26_1 = var_26_9
		until var_26_11:GetRarity() > var_26_8:GetRarity()
	end

	arg_26_0.ptMax = var_26_3 <= var_26_0
	arg_26_0.upgradeLevel = var_26_4
	arg_26_0.upgradePtOrigin = var_26_2
	arg_26_0.upgradePtTotal = math.min(var_26_0, var_26_3)
	arg_26_0.upgradePtMax = var_26_3
	arg_26_0.upgradNeedMaterials = var_26_6
	arg_26_0.upgradNeedGold = var_26_5
	arg_26_0.nextSpWeaponVO = arg_26_0.spWeaponVO:MigrateTo(var_26_1)

	if arg_26_0.craftMode == var_0_2 then
		arg_26_0.upgradeMaxLevel = arg_26_0.spWeaponVO:GetNextUpgradeID() == 0
	end

	return
end

function var_0_0.AutoSelectMaterials(arg_29_0)
	local var_29_0 = arg_29_0.spWeaponVO:GetPt() + SpWeapon.CalculateHistoryPt(arg_29_0.consumeItems, arg_29_0.consumeSpweapons)
	local var_29_1 = arg_29_0.spWeaponVO:GetConfigID()
	local var_29_2 = 0

	if arg_29_0.craftMode == var_0_1 then
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

		local var_29_5 = SpWeapon.New({
			id = var_29_4
		})

		if var_29_5:GetRarity() > arg_29_0.spWeaponVO:GetRarity() then
			break
		end

		var_29_1 = var_29_4
	end

	if var_29_2 <= var_29_0 then
		return
	end

	local var_29_6 = _.values(_.map(arg_29_0.candicateMaterials, function(arg_30_0)
		local var_30_0 = arg_29_0:GetSelectMaterial(arg_30_0.id)
		local var_30_1 = arg_30_0.count

		if var_30_0 then
			local var_30_2 = var_30_0.count or 0
			local var_30_3 = var_30_1 - var_30_2

			return var_30_3 > 0 and Item.New({
				id = arg_30_0.id,
				count = var_30_3
			}) or nil
		end
	end))

	local function var_29_7(arg_31_0)
		return Item.getConfigData(arg_31_0.id).usage_arg[1]
	end

	table.sort(var_29_6, function(arg_32_0, arg_32_1)
		return var_29_7(arg_32_0) > var_29_7(arg_32_1)
	end)

	local var_29_9, var_29_10 = (function(arg_33_0, arg_33_1, arg_33_2)
		if not var_29_6[arg_33_0] then
			return false
		end

		local var_33_0 = var_29_7(var_29_6[arg_33_0])
		local var_33_1 = math.min(math.ceil(arg_33_1 / var_33_0), var_29_6[arg_33_0].count)

		arg_33_2 = Clone(arg_33_2)

		if arg_33_1 - var_33_0 * var_33_1 == 0 then
			table.insert(arg_33_2, {
				id = var_29_6[arg_33_0].id,
				count = var_33_1
			})

			return true, arg_33_2
		elseif arg_33_1 - var_33_0 * var_33_1 > 0 then
			local var_33_2, var_33_3 = var_0(arg_33_0 + 1, arg_33_1 - var_33_0 * var_33_1, {})

			if var_33_2 then
				table.insert(arg_33_2, {
					id = var_29_6[arg_33_0].id,
					count = var_33_1
				})
				table.insertto(arg_33_2, var_33_3)

				return true, arg_33_2
			else
				return false
			end
		elseif arg_33_1 - var_33_0 * var_33_1 < 0 then
			local var_33_4, var_33_5 = var_0(arg_33_0 + 1, arg_33_1 - var_33_0 * var_33_1 + var_33_0, {})

			if var_33_4 then
				table.insert(arg_33_2, {
					id = var_29_6[arg_33_0].id,
					count = math.max(var_33_1 - 1, 0)
				})
				table.insertto(arg_33_2, var_33_5)

				return true, arg_33_2
			else
				table.insert(arg_33_2, {
					id = var_29_6[arg_33_0].id,
					count = math.max(var_33_1, 0)
				})

				return true, arg_33_2
			end
		end

		return
	end)(1, var_29_2 - var_29_0, {})

	var_29_10 = var_29_9 and var_29_10 or var_29_6

	_.each(var_29_10, function(arg_34_0)
		arg_29_0:UpdateSelectMaterial(arg_34_0.id, arg_34_0.count)
		arg_29_0:UpdateAll(true)

		return
	end)

	return
end

function var_0_0.UpdateAll(arg_35_0, arg_35_1)
	if not arg_35_0.spWeaponVO:IsReal() then
		arg_35_0.craftMode = var_0_1 or var_0_2

		arg_35_0:UpdateSelectPt()

		local var_35_0 = arg_35_0.craftMode == var_0_2 and arg_35_0.nextSpWeaponVO:GetConfigID() ~= arg_35_0.spWeaponVO:GetConfigID()

		setActive(arg_35_0.equipmentPanelIcon2, var_35_0)
		setActive(arg_35_0.equipmentPanelArrow, var_35_0)

		if var_35_0 then
			updateSpWeapon(arg_35_0.equipmentPanelIcon1, arg_35_0.spWeaponVO)
			updateSpWeapon(arg_35_0.equipmentPanelIcon2, arg_35_0.nextSpWeaponVO)
			arg_35_0:UpdateAttrs(arg_35_0.materialPanelAttrList, arg_35_0.spWeaponVO, arg_35_0.nextSpWeaponVO)
		else
			updateSpWeapon(arg_35_0.equipmentPanelIcon1, arg_35_0.nextSpWeaponVO)
			arg_35_0:UpdateAttrs(arg_35_0.materialPanelAttrList, arg_35_0.nextSpWeaponVO)
		end

		setText(arg_35_0.equipmentPanel:Find("Name"), arg_35_0.nextSpWeaponVO:GetName())

		local var_35_1 = arg_35_0.nextSpWeaponVO:IsUnique()

		setActive(arg_35_0.equipmentPanel:Find("ShipType"), not var_35_1)
		setActive(arg_35_0.equipmentPanel:Find("Ship"), var_35_1)

		if var_35_1 then
			local var_35_2 = ShipGroup.getDefaultShipConfig(arg_35_0.nextSpWeaponVO:GetUniqueGroup())

			if var_35_2 then
				local var_35_3 = var_35_2.id or nil

				assert(var_35_3 and var_35_3 > 0)

				if var_35_3 and var_35_3 > 0 then
					arg_35_0.loader:GetSprite("qicon/" .. Ship.New({
						configId = var_35_3
					}):getPainting(), nil, arg_35_0.equipmentPanel:Find("Ship/Icon/Image"))
					arg_35_0.equipmentPanel:Find("Ship/Detail"):GetComponent("RichText"):AddListener(function()
						arg_35_0:emit(BaseUI.ON_DROP, {
							type = DROP_TYPE_SHIP,
							id = var_35_3
						})

						return
					end)
					onButton(arg_35_0, arg_35_0.equipmentPanel:Find("Ship/Icon"), function()
						arg_35_0:emit(BaseUI.ON_DROP, {
							type = DROP_TYPE_SHIP,
							id = var_35_3
						})

						return
					end)
				end

				if false then
					local var_35_4 = ShipType.FilterOverQuZhuType((_.filter(arg_35_0.nextSpWeaponVO:GetWearableShipTypes(), function(arg_37_0)
						return table.contains(ShipType.AllShipType, arg_37_0)
					end)))

					CustomIndexLayer.Clone2Full(arg_35_0.equipmentPanel:Find("ShipType/List"), #var_35_4)

					for iter_35_0, iter_35_1 in ipairs(var_35_4) do
						local var_35_5 = arg_35_0.equipmentPanel:Find("ShipType/List")

						arg_35_0.loader:GetSprite("shiptype", ShipType.Type2CNLabel(iter_35_1), (var_35_5:GetChild(iter_35_0 - 1)))
					end
				end

				arg_35_0:UpdateExpBar()
				arg_35_0:UpdateMaterials()
				arg_35_0:UpdatePtMaterials(arg_35_1)
				arg_35_0:UpdateCraftTargetCount()

				return
			end
		end
	end
end

function var_0_0.UpdateCraftTargetCount(arg_38_0)
	setActive(arg_38_0.craftTargetCount, arg_38_0.craftMode == var_0_1)

	if not arg_38_0.craftMode == var_0_1 then
		return
	end

	setText(arg_38_0.craftTargetCount:Find("Text"), (_.reduce(arg_38_0.spWeaponList, 0, function(arg_39_0, arg_39_1)
		if arg_38_0.nextSpWeaponVO:GetOriginID() == arg_39_1:GetOriginID() then
			arg_39_0 = arg_39_0 + 1
		end

		return arg_39_0
	end)))

	return
end

function var_0_0.UpdateAttrs(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0
	local var_40_1

	if arg_40_0.craftMode == var_0_1 then
		var_40_0 = SpWeaponHelper.TransformCompositeInfo(arg_40_2)
		var_40_1 = arg_40_2:GetSkillGroup()
		arg_40_3 = arg_40_2
	elseif arg_40_0.craftMode == var_0_2 then
		arg_40_3 = arg_40_3 or arg_40_2
		var_40_0 = SpWeaponHelper.TransformUpgradeInfo(arg_40_2, arg_40_3)
		var_40_1 = arg_40_3:GetSkillGroup()
	end

	arg_40_0:UpdateSpWeaponUpgradeInfo(arg_40_1, var_40_0, var_40_1, arg_40_3)

	return
end

function var_0_0.UpdateSpWeaponUpgradeInfo(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = arg_41_1:Find("attr_tpl")

	removeAllChildren(arg_41_1:Find("attrs"))

	local function var_41_1(arg_42_0, arg_42_1)
		local var_42_0 = arg_42_0:Find("base")

		setText(var_42_0:Find("name"), arg_42_1.name)
		setActive(var_42_0:Find("value"), true)
		setText(var_42_0:Find("value"), arg_42_1.value)
		setActive(var_42_0:Find("effect"), false)

		local var_42_1 = arg_42_1.compare and arg_42_1.compare > 0

		setActive(var_42_0:Find("value/up"), var_42_1)

		local var_42_2 = arg_42_1.compare and arg_42_1.compare < 0

		setActive(var_42_0:Find("value/down"), var_42_2)
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

	if arg_41_3[1].skillId > 0 then
		table.insert({}, {
			name = i18n("spweapon_attr_effect"),
			effect = arg_41_3[1]
		})
	end

	for iter_41_0, iter_41_1 in ipairs(arg_41_3[2]) do
		table.insert({}, {
			isSkill = true,
			name = i18n("spweapon_attr_skillupgrade"),
			effect = iter_41_1
		})
	end

	local function var_41_2(arg_44_0, arg_44_1)
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
					arg_41_0:emit(SpWeaponUpgradeMediator.ON_SKILLINFO, var_44_1.skillId, var_44_1.unlock, 10)
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
			var_41_2(cloneTplTo(arg_46_1, arg_46_0), iter_46_1)
		end

		return
	end)(arg_41_1:Find("attrs"), var_41_0, {})

	return
end

function var_0_0.UpdateExpBar(arg_47_0)
	setActive(arg_47_0.materialPanelExpLv, not arg_47_0.upgradeMaxLevel)
	setActive(arg_47_0.materialPanelExpFullText, arg_47_0.upgradeMaxLevel)
	setActive(arg_47_0.materialPanelExpBarFull, arg_47_0.upgradeMaxLevel)

	if not arg_47_0.upgradeMaxLevel then
		setSlider(arg_47_0.materialPanelExpBar, 0, 1, (arg_47_0.upgradePtTotal - arg_47_0.upgradePtOrigin) / (arg_47_0.upgradePtMax - arg_47_0.upgradePtOrigin))

		if arg_47_0.upgradeType == var_0_3 then
			setText(arg_47_0.materialPanelExpLv, i18n("spweapon_ui_create_exp"))
		elseif arg_47_0.upgradeType == var_0_4 then
			setText(arg_47_0.materialPanelExpLv, i18n("spweapon_ui_upgrade_exp"))
		elseif arg_47_0.upgradeType == var_0_5 then
			setText(arg_47_0.materialPanelExpLv, i18n("spweapon_ui_breakout_exp"))
		end

		setText(arg_47_0.materialPanelExpCurrentText, arg_47_0.upgradePtTotal - arg_47_0.upgradePtOrigin)
		setText(arg_47_0.materialPanelExpTotalText, arg_47_0.upgradePtMax - arg_47_0.upgradePtOrigin)
	else
		setText(arg_47_0.materialPanelExpCurrentText, 0)
		setText(arg_47_0.materialPanelExpTotalText, 0)
	end

	return
end

function var_0_0.UpdateMaterials(arg_48_0)
	local var_48_0 = arg_48_0.upgradNeedGold
	local var_48_1 = arg_48_0.spWeaponVO:GetNextUpgradeID() == 0

	setActive(arg_48_0.materialPanelMaterialList, not var_48_1)
	setActive(arg_48_0.materialPanelMaterialListLimit, var_48_1)

	local var_48_2
	local var_48_3 = true

	for iter_48_0 = 1, #arg_48_0.materialPanelMaterialItems do
		setActive(findTF(arg_48_0.materialPanelMaterialItems[iter_48_0], "off"), not arg_48_0.upgradNeedMaterials[iter_48_0])
		setActive(findTF(arg_48_0.materialPanelMaterialItems[iter_48_0], "Icon"), arg_48_0.upgradNeedMaterials[iter_48_0])

		if arg_48_0.upgradNeedMaterials[iter_48_0] then
			local var_48_4 = findTF(arg_48_0.materialPanelMaterialItems[iter_48_0], "Icon")

			updateDrop(var_48_4, {
				type = DROP_TYPE_ITEM,
				id = arg_48_0.upgradNeedMaterials[iter_48_0].id,
				count = arg_48_0.upgradNeedMaterials[iter_48_0].count
			})
			onButton(arg_48_0, var_48_4, function()
				arg_48_0:emit(BaseUI.ON_DROP, var_0)

				return
			end)

			local var_48_5 = defaultValue(arg_48_0.itemVOs[arg_48_0.upgradNeedMaterials[iter_48_0].id], {
				count = 0
			})
			local var_48_6 = arg_48_0.upgradNeedMaterials[iter_48_0].count .. "/" .. var_48_5.count

			if var_48_5.count < arg_48_0.upgradNeedMaterials[iter_48_0].count then
				var_48_6 = setColorStr(var_48_5.count, COLOR_RED) .. "/" .. arg_48_0.upgradNeedMaterials[iter_48_0].count
				var_48_3 = false
				var_48_2 = arg_48_0.upgradNeedMaterials[iter_48_0].id
			end

			local var_48_7 = findTF(var_48_4, "icon_bg/count")

			setActive(var_48_7, true)
			setText(var_48_7, var_48_6)

			local var_48_8 = var_48_4:Find("Click")

			setActive(var_48_8, not arg_48_0.confirmUpgrade and arg_48_0.upgradeType == var_0_5)
			onButton(arg_48_0, var_48_8, function()
				arg_48_0.confirmUpgrade = true

				setActive(var_48_8, not arg_48_0.confirmUpgrade)

				return
			end)
		end
	end

	setText(arg_48_0.materialPanelCostText, var_48_0)
	setActive(arg_48_0.materialPanelButtonCreate, arg_48_0.craftMode == var_0_1)
	setActive(arg_48_0.materialPanelButtonUpgrade, arg_48_0.craftMode == var_0_2 and arg_48_0.upgradeType == var_0_5)
	setActive(arg_48_0.materialPanelButtonStrengthen, arg_48_0.craftMode == var_0_2 and arg_48_0.upgradeType == var_0_4)
	setActive(arg_48_0.equipmentPanelTitleComposite, arg_48_0.craftMode == var_0_1)
	setActive(arg_48_0.equipmentPanelTitleUpgrade, arg_48_0.craftMode == var_0_2 and arg_48_0.upgradeType == var_0_5)
	setActive(arg_48_0.equipmentPanelTitleStrengthen, arg_48_0.craftMode == var_0_2 and arg_48_0.upgradeType == var_0_4)
	onButton(arg_48_0, arg_48_0.materialPanelButton, function()
		if not var_48_3 then
			if not ItemTipPanel.ShowItemTipbyID(var_48_2) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))
			end

			return
		end

		if arg_48_0.playerVO.gold < var_48_0 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
				{
					59001,
					var_48_0 - arg_48_0.playerVO.gold,
					var_48_0
				}
			})

			return
		end

		if not arg_48_0.confirmUpgrade and arg_48_0.upgradeType == var_0_5 and #arg_48_0.upgradNeedMaterials > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_breakout_materal_check"))

			return
		end

		if arg_48_0.craftMode == var_0_1 then
			arg_48_0:emit(SpWeaponUpgradeMediator.EQUIPMENT_COMPOSITE, arg_48_0.spWeaponVO:GetConfigID(), arg_48_0.consumeItems, arg_48_0.consumeSpweapons)
		elseif arg_48_0.craftMode == var_0_2 then
			arg_48_0:emit(SpWeaponUpgradeMediator.EQUIPMENT_UPGRADE, arg_48_0.spWeaponVO:GetUID(), arg_48_0.consumeItems, arg_48_0.consumeSpweapons)
		end

		return
	end, SFX_UI_DOCKYARD_REINFORCE)
	setGray(arg_48_0.materialPanelButton, arg_48_0.upgradeMaxLevel)
	setButtonEnabled(arg_48_0.materialPanelButton, not arg_48_0.upgradeMaxLevel)

	return
end

function var_0_0.UpdatePtMaterials(arg_52_0, arg_52_1)
	arg_52_0.candicateMaterials = _.map(var_0_6, function(arg_53_0)
		return arg_52_0.itemVOs[arg_53_0] or Item.New({
			count = 0,
			id = arg_53_0
		})
	end)

	table.sort(arg_52_0.candicateMaterials, function(arg_54_0, arg_54_1)
		return arg_54_0.id < arg_54_1.id
	end)

	local var_52_0 = table.equal(arg_52_0.contextData.indexDatas, var_0_7)

	setActive(arg_52_0.leftPanelFilterButton:Find("Off"), var_52_0)
	setActive(arg_52_0.leftPanelFilterButton:Find("On"), not var_52_0)

	arg_52_0.candicateSpweapons = {}

	for iter_52_0, iter_52_1 in pairs(arg_52_0.spWeaponList) do
		if iter_52_1:GetUID() ~= arg_52_0.spWeaponVO:GetUID() and not iter_52_1:IsUnCraftable() and not iter_52_1:GetShipId() and IndexConst.filterSpWeaponByType(iter_52_1, arg_52_0.contextData.indexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_52_1, arg_52_0.contextData.indexDatas.rarityIndex) then
			table.insert(arg_52_0.candicateSpweapons, iter_52_1)
		end
	end

	table.sort(arg_52_0.candicateSpweapons, CompareFuncs(SpWeaponSortCfg.sortFunc(SpWeaponSortCfg.sort[1], true)))
	arg_52_0.leftPanelItemRect:align(#arg_52_0.candicateMaterials)

	if not arg_52_1 then
		arg_52_0.leftPanelEquipScrollComp:SetTotalCount(#arg_52_0.candicateSpweapons)
	end

	setActive(arg_52_0.leftPanelAutoSelectButton:Find("On"), not arg_52_0.ptMax)
	setActive(arg_52_0.leftPanelAutoSelectButton:Find("Off"), arg_52_0.ptMax)
	setButtonEnabled(arg_52_0.leftPanelAutoSelectButton, not arg_52_0.ptMax)

	local var_52_1 = #arg_52_0.consumeItems > 0

	setActive(arg_52_0.leftPanelClearSelectButton:Find("On"), #arg_52_0.consumeItems > 0)
	setActive(arg_52_0.leftPanelClearSelectButton:Find("Off"), not var_52_1)
	setButtonEnabled(arg_52_0.leftPanelClearSelectButton, var_52_1)

	return
end

function var_0_0.UpdateSelectMaterial(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_0:GetSelectMaterial(arg_55_1)

	if var_55_0 then
		local var_55_1 = var_55_0.count or 0

		if arg_55_0.itemVOs[arg_55_1] then
			local var_55_2 = arg_55_0.itemVOs[arg_55_1].count or 0

			if arg_55_2 > 0 then
				if arg_55_0.ptMax then
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

						table.insert(arg_55_0.consumeItems, var_55_0)
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
						table.removebyvalue(arg_55_0.consumeItems, var_55_0)
					end
				end

				if var_55_1 + arg_55_2 <= 0 then
					return true
				end
			end

			return
		end
	end
end

function var_0_0.GetSelectMaterial(arg_56_0, arg_56_1)
	return _.detect(arg_56_0.consumeItems, function(arg_57_0)
		return arg_57_0.id == arg_56_1
	end)
end

function var_0_0.GetSelectSpWeapon(arg_58_0, arg_58_1)
	if table.contains(arg_58_0.consumeSpweapons, arg_58_1) then
		return arg_58_1
	end

	return
end

function var_0_0.ClearSelectMaterials(arg_59_0)
	table.clear(arg_59_0.consumeItems)
	table.clear(arg_59_0.consumeSpweapons)

	return
end

function var_0_0.willExit(arg_60_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_60_0._tf)
	ClearLScrollrect(arg_60_0.leftPanelEquipScrollComp)
	arg_60_0.loader:Clear()

	return
end

return var_0_0
