local var_0_0 = class("EquipmentDesignLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EquipmentDesignUI"
end

function var_0_0.setItems(arg_2_0, arg_2_1)
	arg_2_0.itemVOs = arg_2_1

	return
end

function var_0_0.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.player = arg_3_1

	return
end

function var_0_0.setCapacity(arg_4_0, arg_4_1)
	arg_4_0.capacity = arg_4_1

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.designScrollView = arg_5_0._tf:Find("equipment_scrollview")
	arg_5_0.equipmentTpl = arg_5_0._tf:Find("equipment_tpl")
	arg_5_0.equipmentContainer = arg_5_0.designScrollView:Find("equipment_grid")
	arg_5_0.msgBoxTF = arg_5_0._tf:Find("msg_panel")

	setActive(arg_5_0.msgBoxTF, false)

	arg_5_0.top = arg_5_0._tf:Find("top")
	arg_5_0.sortBtn = arg_5_0.top:Find("sort_button")
	arg_5_0.indexBtn = arg_5_0.top:Find("index_button")
	arg_5_0.decBtn = arg_5_0.sortBtn:Find("dec_btn")
	arg_5_0.sortImgAsc = arg_5_0.decBtn:Find("asc")
	arg_5_0.sortImgDec = arg_5_0.decBtn:Find("desc")
	arg_5_0.indexPanel = arg_5_0._tf:Find("index")
	arg_5_0.tagContainer = arg_5_0.indexPanel:Find("adapt/mask/panel")
	arg_5_0.tagTpl = arg_5_0.tagContainer:Find("tpl")
	arg_5_0.listEmptyTF = arg_5_0._tf:Find("empty")

	setActive(arg_5_0.listEmptyTF, false)

	arg_5_0.listEmptyTxt = arg_5_0.listEmptyTF:Find("Text")

	setText(arg_5_0.listEmptyTxt, i18n("list_empty_tip_equipmentdesignui"))
	arg_5_0:OverlayPanel(arg_5_0.indexPanel)

	arg_5_0.obtainWayPage = EquipmentDesignObtainWayPage.New(arg_5_0._tf, arg_5_0.event)

	arg_5_0.obtainWayPage:RegisterView(arg_5_0)

	return
end

function var_0_0.SetParentTF(arg_6_0, arg_6_1)
	arg_6_0.parentTF = arg_6_1
	arg_6_0.equipmentView = arg_6_0.parentTF:Find("adapt/equipment_scrollview")

	setActive(arg_6_0.equipmentView, false)

	return
end

function var_0_0.SetTopContainer(arg_7_0, arg_7_1)
	arg_7_0.topPanel = arg_7_1

	return
end

local var_0_1 = {
	"sort_default",
	"sort_rarity",
	"sort_count"
}

function var_0_0.didEnter(arg_8_0)
	setParent(arg_8_0._tf, arg_8_0.parentTF)
	arg_8_0._tf:SetSiblingIndex((arg_8_0.equipmentView:GetSiblingIndex()))

	arg_8_0.contextData.indexDatas = arg_8_0.contextData.indexDatas or {}

	setParent(arg_8_0.top, arg_8_0.topPanel)
	arg_8_0:initDesigns()
	onToggle(arg_8_0, arg_8_0.sortBtn, function(arg_9_0)
		if arg_9_0 then
			setActive(arg_8_0.indexPanel, true)
		else
			setActive(arg_8_0.indexPanel, false)
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.indexPanel, function()
		triggerToggle(arg_8_0.sortBtn, false)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.indexBtn, function()
		arg_8_0:emit(EquipmentDesignMediator.OPEN_EQUIPMENTDESIGN_INDEX, {
			indexDatas = Clone(arg_8_0.contextData.indexDatas),
			customPanels = {
				minHeight = 650,
				typeIndex = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipmentTypeIndexs,
					names = IndexConst.EquipmentTypeNames
				},
				equipPropertyIndex = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipPropertyIndexs,
					names = IndexConst.EquipPropertyNames
				},
				equipPropertyIndex2 = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipPropertyIndexs,
					names = IndexConst.EquipPropertyNames
				},
				equipAmmoIndex1 = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipAmmoIndexs_1,
					names = IndexConst.EquipAmmoIndexs_1_Names
				},
				equipAmmoIndex2 = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipAmmoIndexs_2,
					names = IndexConst.EquipAmmoIndexs_2_Names
				},
				equipCampIndex = {
					mode = CustomIndexLayer.Mode.AND,
					options = IndexConst.EquipCampIndexs,
					names = IndexConst.EquipCampNames
				},
				rarityIndex = {
					mode = CustomIndexLayer.Mode.AND,
					options = IndexConst.EquipmentRarityIndexs,
					names = IndexConst.RarityNames
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
					dropdown = true,
					titleENTxt = "indexsort_indexeng",
					titleTxt = "indexsort_index",
					tags = {
						"equipPropertyIndex",
						"equipPropertyIndex2",
						"equipAmmoIndex1",
						"equipAmmoIndex2"
					}
				},
				{
					dropdown = false,
					titleENTxt = "indexsort_campeng",
					titleTxt = "indexsort_camp",
					tags = {
						"equipCampIndex"
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
			dropdownLimit = {
				equipPropertyIndex = {
					include = {
						typeIndex = IndexConst.EquipmentTypeAll
					},
					exclude = {}
				},
				equipPropertyIndex2 = {
					include = {
						typeIndex = IndexConst.EquipmentTypeEquip
					},
					exclude = {
						typeIndex = IndexConst.EquipmentTypeAll
					}
				},
				equipAmmoIndex1 = {
					include = {
						typeIndex = IndexConst.BitAll({
							IndexConst.EquipmentTypeSmallCannon,
							IndexConst.EquipmentTypeMediumCannon,
							IndexConst.EquipmentTypeBigCannon
						})
					},
					exclude = {
						typeIndex = IndexConst.EquipmentTypeAll
					}
				},
				equipAmmoIndex2 = {
					include = {
						typeIndex = IndexConst.BitAll({
							IndexConst.EquipmentTypeWarshipTorpedo,
							IndexConst.EquipmentTypeSubmaraineTorpedo
						})
					},
					exclude = {
						typeIndex = IndexConst.EquipmentTypeAll
					}
				}
			},
			callback = function(arg_12_0)
				if not isActive(arg_8_0._tf) then
					return
				end

				arg_8_0.contextData.indexDatas.typeIndex = arg_12_0.typeIndex
				arg_8_0.contextData.indexDatas.equipPropertyIndex = arg_12_0.equipPropertyIndex
				arg_8_0.contextData.indexDatas.equipPropertyIndex2 = arg_12_0.equipPropertyIndex2
				arg_8_0.contextData.indexDatas.equipAmmoIndex1 = arg_12_0.equipAmmoIndex1
				arg_8_0.contextData.indexDatas.equipAmmoIndex2 = arg_12_0.equipAmmoIndex2
				arg_8_0.contextData.indexDatas.equipCampIndex = arg_12_0.equipCampIndex
				arg_8_0.contextData.indexDatas.rarityIndex = arg_12_0.rarityIndex

				local var_12_0 = arg_8_0.contextData.index or 1

				arg_8_0:filter(var_12_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	arg_8_0:initTags()

	return
end

function var_0_0.isDefaultStatus(arg_13_0)
	return (not arg_13_0.contextData.indexDatas.typeIndex or arg_13_0.contextData.indexDatas.typeIndex == IndexConst.EquipmentTypeAll) and (not arg_13_0.contextData.indexDatas.equipPropertyIndex or arg_13_0.contextData.indexDatas.equipPropertyIndex == IndexConst.EquipPropertyAll) and (not arg_13_0.contextData.indexDatas.equipPropertyIndex2 or arg_13_0.contextData.indexDatas.equipPropertyIndex2 == IndexConst.EquipPropertyAll) and (not arg_13_0.contextData.indexDatas.equipAmmoIndex1 or arg_13_0.contextData.indexDatas.equipAmmoIndex1 == IndexConst.EquipAmmoAll_1) and (not arg_13_0.contextData.indexDatas.equipAmmoIndex2 or arg_13_0.contextData.indexDatas.equipAmmoIndex2 == IndexConst.EquipAmmoAll_2) and (not arg_13_0.contextData.indexDatas.equipCampIndex or arg_13_0.contextData.indexDatas.equipCampIndex == IndexConst.EquipCampAll) and (not arg_13_0.contextData.indexDatas.rarityIndex or arg_13_0.contextData.indexDatas.rarityIndex == IndexConst.EquipmentRarityAll)
end

function var_0_0.initTags(arg_14_0)
	onButton(arg_14_0, arg_14_0.decBtn, function()
		arg_14_0.asc = not arg_14_0.asc
		arg_14_0.contextData.asc = arg_14_0.asc

		local var_15_0 = arg_14_0.contextData.index or 1

		arg_14_0:filter(var_15_0)

		return
	end)

	arg_14_0.tagTFs = {}

	eachChild(arg_14_0.tagContainer, function(arg_16_0)
		setActive(arg_16_0, false)

		return
	end)

	for iter_14_0, iter_14_1 in ipairs(var_0_1) do
		local var_14_0 = iter_14_0 <= arg_14_0.tagContainer.childCount and arg_14_0.tagContainer:GetChild(iter_14_0 - 1) or cloneTplTo(arg_14_0.tagTpl, arg_14_0.tagContainer)

		setActive(var_14_0, true)
		setImageSprite(findTF(var_14_0, "Image"), GetSpriteFromAtlas("ui/equipmentdesignui_atlas", iter_14_1))
		onToggle(arg_14_0, var_14_0, function(arg_17_0)
			if arg_17_0 then
				arg_14_0:filter(iter_14_0)
				triggerButton(arg_14_0.indexPanel)

				arg_14_0.contextData.index = iter_14_0
			else
				triggerButton(arg_14_0.indexPanel)
			end

			return
		end, SFX_PANEL)
		table.insert(arg_14_0.tagTFs, var_14_0)

		arg_14_0.contextData.index = arg_14_0.contextData.index or iter_14_0
	end

	triggerToggle(arg_14_0.tagTFs[arg_14_0.contextData.index], true)

	return
end

function var_0_0.initDesigns(arg_18_0)
	arg_18_0.scollRect = arg_18_0.designScrollView:GetComponent("LScrollRect")
	arg_18_0.scollRect.decelerationRate = 0.07

	function arg_18_0.scollRect.onInitItem(arg_19_0)
		arg_18_0:initDesign(arg_19_0)

		return
	end

	function arg_18_0.scollRect.onUpdateItem(arg_20_0, arg_20_1)
		arg_18_0:updateDesign(arg_20_0, arg_20_1)

		return
	end

	function arg_18_0.scollRect.onReturnItem(arg_21_0, arg_21_1)
		arg_18_0:returnDesign(arg_21_0, arg_21_1)

		return
	end

	arg_18_0.desgins = {}

	return
end

local function var_0_2(arg_22_0, arg_22_1)
	local var_22_0 = findTF(arg_22_0, "attrs")

	setImageSprite(findTF(arg_22_0, "name_bg/tag"), GetSpriteFromAtlas("equiptype", EquipType.type2Tag(arg_22_1:getConfig("type"))))
	eachChild(var_22_0, function(arg_23_0)
		setActive(arg_23_0, false)

		return
	end)

	local var_22_1 = underscore.filter(arg_22_1:GetPropertiesInfo().attrs, function(arg_24_0)
		return not arg_24_0.type or arg_24_0.type ~= AttributeType.AntiSiren
	end)
	local var_22_2 = arg_22_1:getConfig("skill_id")
	local var_22_3 = var_22_2[1] and var_22_2[1][1]

	if var_22_3 and arg_22_1:isDevice() then
		local var_22_4 = {
			1,
			2,
			5
		}

		if not {
			1,
			2,
			5
		} then
			var_22_4 = {
				1,
				4,
				2,
				3
			}
		end

		for iter_22_0, iter_22_1 in ipairs(var_22_4) do
			local var_22_5 = var_22_0:Find("attr_" .. iter_22_1)

			setActive(var_22_5, true)

			if iter_22_1 == 5 then
				setText(var_22_5:Find("value"), getSkillName(var_22_3))
			else
				local var_22_6 = ""
				local var_22_7 = ""

				if #var_22_1 > 0 then
					var_22_6, var_22_7 = Equipment.GetInfoTrans((table.remove(var_22_1, 1)))
				end

				setText(var_22_5:Find("tag"), var_22_6)
				setText(var_22_5:Find("value"), var_22_7)
			end
		end

		return
	end
end

function var_0_0.createDesign(arg_25_0, arg_25_1)
	arg_25_1 = tf(arg_25_1)

	local var_25_0 = findTF(arg_25_1, "info/count")
	local var_25_1 = findTF(arg_25_1, "mask")
	local var_25_2 = {
		go = arg_25_1,
		nameTxt = arg_25_1:Find("name_bg/mask/name")
	}

	ClearTweenItemAlphaAndWhite(var_25_2.go)

	function var_25_2.getItemById(arg_26_0, arg_26_1)
		return arg_26_0.itemVOs[arg_26_1] or Item.New({
			count = 0,
			id = arg_26_1
		})
	end

	function var_25_2.update(arg_27_0, arg_27_1, arg_27_2)
		arg_27_0.designId = arg_27_1
		arg_27_0.itemVOs = arg_27_2

		local var_27_0 = pg.compose_data_template[arg_27_1]

		assert(pg.compose_data_template[arg_27_1], "必须存在配置" .. arg_27_1)
		TweenItemAlphaAndWhite(arg_27_0.go)

		local var_27_1 = Equipment.getConfigData(pg.compose_data_template[arg_27_1].equip_id)

		assert(var_27_1, "必须存在装备" .. pg.compose_data_template[arg_27_1].equip_id)
		setText(arg_27_0.nameTxt, shortenString(var_27_1.name, 6))

		local var_27_2 = Equipment.New({
			id = pg.compose_data_template[arg_27_1].equip_id
		})

		updateEquipment(findTF(arg_25_1, "equipment/bg"), var_27_2)
		var_0_2(arg_25_1, var_27_2)
		;(function()
			local var_28_0 = arg_27_0.itemVOs[var_27_0.material_id] or Item.New({
				count = 0,
				id = var_27_0.material_id
			})
			local var_28_1 = var_28_0.count .. "/" .. var_27_0.material_num

			var_28_1 = var_28_0.count >= var_27_0.material_num and setColorStr(var_28_1, COLOR_WHITE) or setColorStr(var_28_1, COLOR_RED)

			setText(var_25_0, var_28_1)
			setActive(var_25_1, var_28_0.count < var_27_0.material_num)

			return
		end)()

		return
	end

	function var_25_2.clear(arg_29_0)
		ClearTweenItemAlphaAndWhite(arg_29_0.go)

		return
	end

	return var_25_2
end

function var_0_0.initDesign(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:createDesign(arg_30_1)

	onButton(arg_30_0, tf(var_30_0.go):Find("info/make_btn"), function()
		arg_30_0:showDesignDesc(var_30_0.designId)

		return
	end, SFX_PANEL)
	onButton(arg_30_0, tf(var_30_0.go):Find("look"), function()
		arg_30_0.obtainWayPage:ExecuteAction("Show", var_30_0.designId)

		return
	end, SFX_PANEL)

	arg_30_0.desgins[arg_30_1] = var_30_0

	return
end

function var_0_0.updateDesign(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0.desgins[arg_33_2] then
		arg_33_0:initDesign(arg_33_2)
	end

	arg_33_0.desgins[arg_33_2]:update(arg_33_0.desginIds[arg_33_1 + 1], arg_33_0.itemVOs)

	return
end

function var_0_0.returnDesign(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.exited then
		return
	end

	if arg_34_0.desgins[arg_34_2] then
		var_34_0:clear()
	end

	return
end

function var_0_0.getDesignVO(arg_35_0, arg_35_1)
	({}).equipmentCfg = Equipment.getConfigData(pg.compose_data_template[arg_35_1].equip_id)
	;({}).designCfg = pg.compose_data_template[arg_35_1]
	;({}).id = arg_35_1

	local var_35_0 = arg_35_0:getItemById(pg.compose_data_template[arg_35_1].material_id).count

	;({}).itemCount = var_35_0
	;({}).canMakeCount = math.floor(var_35_0 / pg.compose_data_template[arg_35_1].material_num)
	;({}).canMake = math.min(({}).canMakeCount, 1)

	local var_35_1 = Equipment.getConfigData(pg.compose_data_template[arg_35_1].equip_id)

	assert(var_35_1, "equip config not exist: " .. pg.compose_data_template[arg_35_1].equip_id)

	;({}).config = var_35_1
	;({}).getNation = function(arg_36_0)
		return var_35_1.nationality
	end
	;({}).getConfig = function(arg_37_0, arg_37_1)
		return var_35_1[arg_37_1]
	end

	return {}
end

function var_0_0.filter(arg_38_0, arg_38_1, arg_38_2)
	GetSpriteFromAtlasAsync("ui/share/index_atlas", arg_38_0:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_39_0)
		setImageSprite(arg_38_0.indexBtn, arg_39_0, true)

		return
	end)

	local var_38_0 = getProxy(EquipmentProxy)

	for iter_38_0, iter_38_1 in ipairs(pg.compose_data_template.all) do
		if arg_38_0:getItemById(pg.compose_data_template[iter_38_1].material_id).count > 0 or arg_38_0.contextData.isShowAllDesign and var_38_0:ShouldShowEquipmentDesignObtainWay(iter_38_1) then
			table.insert({}, iter_38_1)
		end
	end

	local var_38_1 = {}
	local var_38_2 = table.mergeArray({}, {
		arg_38_0.contextData.indexDatas.equipPropertyIndex,
		arg_38_0.contextData.indexDatas.equipPropertyIndex2
	}, true)

	for iter_38_2, iter_38_3 in pairs({}) do
		local var_38_3 = arg_38_0:getDesignVO(iter_38_3)

		if IndexConst.filterEquipByType(var_38_3, arg_38_0.contextData.indexDatas.typeIndex) and IndexConst.filterEquipByProperty(var_38_3, var_38_2) and IndexConst.filterEquipAmmo1(var_38_3, arg_38_0.contextData.indexDatas.equipAmmoIndex1) and IndexConst.filterEquipAmmo2(var_38_3, arg_38_0.contextData.indexDatas.equipAmmoIndex2) and IndexConst.filterEquipByCamp(var_38_3, arg_38_0.contextData.indexDatas.equipCampIndex) and IndexConst.filterEquipByRarity(var_38_3, arg_38_0.contextData.indexDatas.rarityIndex) then
			table.insert(var_38_1, iter_38_3)
		end
	end

	if arg_38_1 == 1 then
		if arg_38_0.asc then
			table.sort(var_38_1, function(arg_40_0, arg_40_1)
				local var_40_0 = arg_38_0:getDesignVO(arg_40_0)
				local var_40_1 = arg_38_0:getDesignVO(arg_40_1)

				if var_40_0.canMake == var_40_1.canMake then
					if var_40_0.equipmentCfg.rarity == var_40_1.equipmentCfg.rarity then
						return var_40_0.equipmentCfg.id < var_40_1.equipmentCfg.id
					else
						return var_40_0.equipmentCfg.rarity > var_40_1.equipmentCfg.rarity
					end
				else
					return var_40_0.canMake < var_40_1.canMake
				end

				return
			end)
		else
			table.sort(var_38_1, function(arg_41_0, arg_41_1)
				local var_41_0 = arg_38_0:getDesignVO(arg_41_0)
				local var_41_1 = arg_38_0:getDesignVO(arg_41_1)

				if var_41_0.canMake == var_41_1.canMake then
					if var_41_0.equipmentCfg.rarity == var_41_1.equipmentCfg.rarity then
						return var_41_0.equipmentCfg.id < var_41_1.equipmentCfg.id
					else
						return var_41_0.equipmentCfg.rarity > var_41_1.equipmentCfg.rarity
					end
				else
					return var_41_0.canMake > var_41_1.canMake
				end

				return
			end)
		end
	elseif arg_38_1 == 2 then
		if arg_38_0.asc then
			table.sort(var_38_1, function(arg_42_0, arg_42_1)
				local var_42_0 = arg_38_0:getDesignVO(arg_42_0)
				local var_42_1 = arg_38_0:getDesignVO(arg_42_1)

				if var_42_0.equipmentCfg.rarity == var_42_1.equipmentCfg.rarity then
					return var_42_0.equipmentCfg.id < var_42_0.equipmentCfg.id
				end

				return var_42_0.equipmentCfg.rarity < var_42_1.equipmentCfg.rarity
			end)
		else
			table.sort(var_38_1, function(arg_43_0, arg_43_1)
				local var_43_0 = arg_38_0:getDesignVO(arg_43_0)
				local var_43_1 = arg_38_0:getDesignVO(arg_43_1)

				if var_43_0.equipmentCfg.rarity == var_43_1.equipmentCfg.rarity then
					return var_43_0.equipmentCfg.id < var_43_0.equipmentCfg.id
				end

				return var_43_0.equipmentCfg.rarity > var_43_1.equipmentCfg.rarity
			end)
		end
	elseif arg_38_1 == 3 then
		if arg_38_0.asc then
			table.sort(var_38_1, function(arg_44_0, arg_44_1)
				local var_44_0 = arg_38_0:getDesignVO(arg_44_0)
				local var_44_1 = arg_38_0:getDesignVO(arg_44_1)

				if var_44_0.itemCount == var_44_1.itemCount then
					return var_44_0.equipmentCfg.id < var_44_1.equipmentCfg.id
				end

				return var_44_0.itemCount < var_44_1.itemCount
			end)
		else
			table.sort(var_38_1, function(arg_45_0, arg_45_1)
				local var_45_0 = arg_38_0:getDesignVO(arg_45_0)
				local var_45_1 = arg_38_0:getDesignVO(arg_45_1)

				if var_45_0.itemCount == var_45_1.itemCount then
					return var_45_0.equipmentCfg.id < var_45_1.equipmentCfg.id
				end

				return var_45_0.itemCount > var_45_1.itemCount
			end)
		end
	end

	arg_38_0.desginIds = var_38_1

	arg_38_0.scollRect:SetTotalCount(#var_38_1, arg_38_2 and -1 or 0)
	setActive(arg_38_0.listEmptyTF, #var_38_1 <= 0)
	Canvas.ForceUpdateCanvases()
	setImageSprite(arg_38_0.sortBtn:Find("Image"), (GetSpriteFromAtlas("ui/equipmentdesignui_atlas", var_0_1[arg_38_1])))
	setActive(arg_38_0.sortImgAsc, arg_38_0.asc)
	setActive(arg_38_0.sortImgDec, not arg_38_0.asc)

	return
end

function var_0_0.getItemById(arg_46_0, arg_46_1)
	return arg_46_0.itemVOs[arg_46_1] or Item.New({
		count = 0,
		id = arg_46_1
	})
end

function var_0_0.showDesignDesc(arg_47_0, arg_47_1)
	arg_47_0.isShowDesc = true

	if IsNil(arg_47_0.msgBoxTF) then
		return
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_47_0.msgBoxTF)
	setActive(arg_47_0.msgBoxTF, true)

	local var_47_0 = arg_47_0.msgBoxTF
	local var_47_1 = pg.compose_data_template[arg_47_1]
	local var_47_2 = Equipment.New({
		id = pg.compose_data_template[arg_47_1].equip_id
	})

	updateEquipInfo(arg_47_0.msgBoxTF:Find("bg/attrs/content"), var_47_2:GetPropertiesInfo(), var_47_2:GetSkill())
	GetImageSpriteFromAtlasAsync("equips/" .. var_47_2:getConfig("icon"), "", (var_47_0:Find("bg/frame/icon")))
	changeToScrollText(var_47_0:Find("bg/name"), var_47_2:getConfig("name"))
	UIItemList.New(var_47_0:Find("bg/frame/stars"), var_47_0:Find("bg/frame/stars/sarttpl")):align(var_47_2:getConfig("rarity"))
	setImageSprite(findTF(var_47_0, "bg/frame/type"), GetSpriteFromAtlas("equiptype", EquipType.type2Tag(var_47_2:getConfig("type"))))

	local var_47_3 = var_47_2:getConfig("speciality") ~= "无" and var_47_2:getConfig("speciality") or i18n1("—")

	setText(var_47_0:Find("bg/frame/speciality/Text"), var_47_3)

	var_47_0:Find("bg/frame"):GetComponent(typeof(Image)).sprite = LoadSprite("bg/equipment_bg_" .. var_47_2:getConfig("rarity"))

	local var_47_4 = findTF(var_47_0, "bg/frame/numbers")
	local var_47_5 = var_47_2:getConfig("tech") or 1

	for iter_47_0 = 0, var_47_4.childCount - 1 do
		setActive(var_47_4:GetChild(iter_47_0), iter_47_0 == var_47_5)
	end

	local var_47_6 = math.floor(arg_47_0:getItemById(var_47_1.material_id).count / var_47_1.material_num)
	local var_47_7 = var_47_0:Find("bg/calc/values/Text")
	local var_47_8 = var_47_1.gold_num
	local var_47_9 = var_47_0:Find("bg/calc/gold/Text")

	;(function(arg_48_0)
		setText(var_47_7, arg_48_0)
		setText(var_47_9, arg_48_0 * var_47_8)

		return
	end)(1)
	pressPersistTrigger(findTF(var_47_0, "bg/calc/minus"), 0.5, function(arg_49_0)
		if var_0 <= 1 then
			arg_49_0()

			return
		end

		var_0 = var_0 - 1

		var_0(var_0)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(findTF(var_47_0, "bg/calc/add"), 0.5, function(arg_50_0)
		if var_0 == var_47_6 then
			arg_50_0()

			return
		end

		var_0 = var_0 + 1

		var_0(var_0)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_47_0, findTF(var_47_0, "bg/calc/max"), function()
		if var_0 == var_47_6 then
			return
		end

		var_0 = math.max(math.min(var_47_6, arg_47_0.player:getMaxEquipmentBag() - arg_47_0.capacity), 1)

		var_0(var_0)

		return
	end, SFX_PANEL)
	onButton(arg_47_0, findTF(var_47_0, "bg/cancel_btn"), function()
		arg_47_0:hideMsgBox()

		return
	end, SFX_CANCEL)
	onButton(arg_47_0, findTF(var_47_0, "bg/confirm_btn"), function()
		arg_47_0:emit(EquipmentDesignMediator.MAKE_EQUIPMENT, arg_47_1, var_0)
		arg_47_0:hideMsgBox()

		return
	end, SFX_CONFIRM)
	onButton(arg_47_0, var_47_0, function()
		arg_47_0:hideMsgBox()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.hideMsgBox(arg_55_0)
	if not IsNil(arg_55_0.msgBoxTF) then
		arg_55_0.isShowDesc = nil

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_55_0.msgBoxTF, arg_55_0._tf)
		setActive(arg_55_0.msgBoxTF, false)
	end

	return
end

function var_0_0.onBackPressed(arg_56_0)
	if isActive(arg_56_0.indexPanel) then
		triggerButton(arg_56_0.indexPanel)

		return
	end

	if arg_56_0.isShowDesc then
		arg_56_0:hideMsgBox()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		arg_56_0:emit(var_0_0.ON_BACK)
	end

	return
end

function var_0_0.willExit(arg_57_0)
	arg_57_0:UnOverlayPanel(arg_57_0.indexPanel, arg_57_0._tf)

	if arg_57_0.leftEventTrigger then
		ClearEventTrigger(arg_57_0.leftEventTrigger)
	end

	if arg_57_0.rightEventTrigger then
		ClearEventTrigger(arg_57_0.rightEventTrigger)
	end

	setParent(arg_57_0.sortBtn.parent, arg_57_0._tf)

	if arg_57_0.obtainWayPage then
		arg_57_0.obtainWayPage:Destroy()
	end

	arg_57_0.obtainWayPage = nil

	return
end

return var_0_0
