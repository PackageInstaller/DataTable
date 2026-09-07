local EquipmentDesignLayer = class("EquipmentDesignLayer", import("..base.BaseUI"))

function EquipmentDesignLayer:getUIName()
	return "EquipmentDesignUI"
end

function EquipmentDesignLayer:setItems(arg_2_1)
	self.itemVOs = arg_2_1

	return
end

function EquipmentDesignLayer:setPlayer(arg_3_1)
	self.player = arg_3_1

	return
end

function EquipmentDesignLayer:setCapacity(arg_4_1)
	self.capacity = arg_4_1

	return
end

function EquipmentDesignLayer:init()
	self.designScrollView = self._tf:Find("equipment_scrollview")
	self.equipmentTpl = self._tf:Find("equipment_tpl")
	self.equipmentContainer = self.designScrollView:Find("equipment_grid")
	self.msgBoxTF = self._tf:Find("msg_panel")

	setActive(self.msgBoxTF, false)

	self.top = self._tf:Find("top")
	self.sortBtn = self.top:Find("sort_button")
	self.indexBtn = self.top:Find("index_button")
	self.decBtn = self.sortBtn:Find("dec_btn")
	self.sortImgAsc = self.decBtn:Find("asc")
	self.sortImgDec = self.decBtn:Find("desc")
	self.indexPanel = self._tf:Find("index")
	self.tagContainer = self.indexPanel:Find("adapt/mask/panel")
	self.tagTpl = self.tagContainer:Find("tpl")
	self.listEmptyTF = self._tf:Find("empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setText(self.listEmptyTxt, i18n("list_empty_tip_equipmentdesignui"))
	self:OverlayPanel(self.indexPanel)

	self.obtainWayPage = EquipmentDesignObtainWayPage.New(self._tf, self.event)

	self.obtainWayPage:RegisterView(self)

	return
end

function EquipmentDesignLayer:SetParentTF(arg_6_1)
	self.parentTF = arg_6_1
	self.equipmentView = self.parentTF:Find("adapt/equipment_scrollview")

	setActive(self.equipmentView, false)

	return
end

function EquipmentDesignLayer:SetTopContainer(arg_7_1)
	self.topPanel = arg_7_1

	return
end

local var_0_1 = {
	"sort_default",
	"sort_rarity",
	"sort_count"
}

function EquipmentDesignLayer:didEnter()
	setParent(self._tf, self.parentTF)
	self._tf:SetSiblingIndex((self.equipmentView:GetSiblingIndex()))

	self.contextData.indexDatas = self.contextData.indexDatas or {}

	setParent(self.top, self.topPanel)
	self:initDesigns()
	onToggle(self, self.sortBtn, function(arg_9_0)
		if arg_9_0 then
			setActive(self.indexPanel, true)
		else
			setActive(self.indexPanel, false)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.indexPanel, function()
		triggerToggle(self.sortBtn, false)

		return
	end, SFX_PANEL)
	onButton(self, self.indexBtn, function()
		self:emit(EquipmentDesignMediator.OPEN_EQUIPMENTDESIGN_INDEX, {
			indexDatas = Clone(self.contextData.indexDatas),
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
			callback = function(self)
				if not isActive(self._tf) then
					return
				end

				self.contextData.indexDatas.typeIndex = self.typeIndex
				self.contextData.indexDatas.equipPropertyIndex = self.equipPropertyIndex
				self.contextData.indexDatas.equipPropertyIndex2 = self.equipPropertyIndex2
				self.contextData.indexDatas.equipAmmoIndex1 = self.equipAmmoIndex1
				self.contextData.indexDatas.equipAmmoIndex2 = self.equipAmmoIndex2
				self.contextData.indexDatas.equipCampIndex = self.equipCampIndex
				self.contextData.indexDatas.rarityIndex = self.rarityIndex

				self:filter(self.contextData.index or 1)

				return
			end
		})

		return
	end, SFX_PANEL)
	self:initTags()

	return
end

function EquipmentDesignLayer:isDefaultStatus()
	return (not self.contextData.indexDatas.typeIndex or self.contextData.indexDatas.typeIndex == IndexConst.EquipmentTypeAll) and (not self.contextData.indexDatas.equipPropertyIndex or self.contextData.indexDatas.equipPropertyIndex == IndexConst.EquipPropertyAll) and (not self.contextData.indexDatas.equipPropertyIndex2 or self.contextData.indexDatas.equipPropertyIndex2 == IndexConst.EquipPropertyAll) and (not self.contextData.indexDatas.equipAmmoIndex1 or self.contextData.indexDatas.equipAmmoIndex1 == IndexConst.EquipAmmoAll_1) and (not self.contextData.indexDatas.equipAmmoIndex2 or self.contextData.indexDatas.equipAmmoIndex2 == IndexConst.EquipAmmoAll_2) and (not self.contextData.indexDatas.equipCampIndex or self.contextData.indexDatas.equipCampIndex == IndexConst.EquipCampAll) and (not self.contextData.indexDatas.rarityIndex or self.contextData.indexDatas.rarityIndex == IndexConst.EquipmentRarityAll)
end

function EquipmentDesignLayer:initTags()
	onButton(self, self.decBtn, function()
		self.asc = not self.asc
		self.contextData.asc = self.asc

		self:filter(self.contextData.index or 1)

		return
	end)

	self.tagTFs = {}

	eachChild(self.tagContainer, function(arg_16_0)
		setActive(arg_16_0, false)

		return
	end)

	for iter_14_0, iter_14_1 in ipairs(var_0_1) do
		local var_14_0 = iter_14_0 <= self.tagContainer.childCount and self.tagContainer:GetChild(iter_14_0 - 1) or cloneTplTo(self.tagTpl, self.tagContainer)

		setActive(var_14_0, true)
		setImageSprite(findTF(var_14_0, "Image"), GetSpriteFromAtlas("ui/equipmentdesignui_atlas", iter_14_1))
		onToggle(self, var_14_0, function(arg_17_0)
			if arg_17_0 then
				self:filter(iter_14_0)
				triggerButton(self.indexPanel)

				self.contextData.index = iter_14_0
			else
				triggerButton(self.indexPanel)
			end

			return
		end, SFX_PANEL)
		table.insert(self.tagTFs, var_14_0)

		self.contextData.index = self.contextData.index or iter_14_0
	end

	triggerToggle(self.tagTFs[self.contextData.index], true)

	return
end

function EquipmentDesignLayer:initDesigns()
	self.scollRect = self.designScrollView:GetComponent("LScrollRect")
	self.scollRect.decelerationRate = 0.07

	function self.scollRect.onInitItem(arg_19_0)
		self:initDesign(arg_19_0)

		return
	end

	function self.scollRect.onUpdateItem(arg_20_0, arg_20_1)
		self:updateDesign(arg_20_0, arg_20_1)

		return
	end

	function self.scollRect.onReturnItem(arg_21_0, arg_21_1)
		self:returnDesign(arg_21_0, arg_21_1)

		return
	end

	self.desgins = {}

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

	for iter_22_0, iter_22_1 in ipairs(var_22_3 and arg_22_1:isDevice() and {
		1,
		2,
		5
	} or {
		1,
		4,
		2,
		3
	}) do
		local var_22_4 = var_22_0:Find("attr_" .. iter_22_1)

		setActive(var_22_4, true)

		if iter_22_1 == 5 then
			setText(var_22_4:Find("value"), getSkillName(var_22_3))
		else
			local var_22_5 = ""
			local var_22_6 = ""

			if #var_22_1 > 0 then
				var_22_5, var_22_6 = Equipment.GetInfoTrans((table.remove(var_22_1, 1)))
			end

			setText(var_22_4:Find("tag"), var_22_5)
			setText(var_22_4:Find("value"), var_22_6)
		end
	end

	return
end

function EquipmentDesignLayer:createDesign(arg_25_1)
	arg_25_1 = tf(arg_25_1)

	local var_25_0 = findTF(arg_25_1, "info/count")
	local var_25_1 = findTF(arg_25_1, "mask")
	local var_25_2 = {
		go = arg_25_1,
		nameTxt = arg_25_1:Find("name_bg/mask/name")
	}

	ClearTweenItemAlphaAndWhite(var_25_2.go)

	function var_25_2:getItemById(arg_26_1)
		return self.itemVOs[arg_26_1] or Item.New({
			count = 0,
			id = arg_26_1
		})
	end

	function var_25_2:update(arg_27_1, arg_27_2)
		self.designId = arg_27_1
		self.itemVOs = arg_27_2

		local var_27_0 = pg.compose_data_template[arg_27_1]

		assert(pg.compose_data_template[arg_27_1], "必须存在配置" .. arg_27_1)
		TweenItemAlphaAndWhite(self.go)

		local var_27_1 = Equipment.getConfigData(pg.compose_data_template[arg_27_1].equip_id)

		assert(var_27_1, "必须存在装备" .. pg.compose_data_template[arg_27_1].equip_id)
		setText(self.nameTxt, shortenString(var_27_1.name, 6))

		local var_27_2 = Equipment.New({
			id = pg.compose_data_template[arg_27_1].equip_id
		})

		updateEquipment(findTF(arg_25_1, "equipment/bg"), var_27_2)
		var_0_2(arg_25_1, var_27_2)
		;(function()
			local var_28_0 = self.itemVOs[var_27_0.material_id] or Item.New({
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

	function var_25_2:clear()
		ClearTweenItemAlphaAndWhite(self.go)

		return
	end

	return var_25_2
end

function EquipmentDesignLayer:initDesign(arg_30_1)
	local var_30_0 = self:createDesign(arg_30_1)

	onButton(self, tf(var_30_0.go):Find("info/make_btn"), function()
		self:showDesignDesc(var_30_0.designId)

		return
	end, SFX_PANEL)
	onButton(self, tf(var_30_0.go):Find("look"), function()
		self.obtainWayPage:ExecuteAction("Show", var_30_0.designId)

		return
	end, SFX_PANEL)

	self.desgins[arg_30_1] = var_30_0

	return
end

function EquipmentDesignLayer:updateDesign(arg_33_1, arg_33_2)
	if not self.desgins[arg_33_2] then
		self:initDesign(arg_33_2)
	end

	self.desgins[arg_33_2]:update(self.desginIds[arg_33_1 + 1], self.itemVOs)

	return
end

function EquipmentDesignLayer:returnDesign(arg_34_1, arg_34_2)
	if self.exited then
		return
	end

	if self.desgins[arg_34_2] then
		self.desgins[arg_34_2]:clear()
	end

	return
end

function EquipmentDesignLayer:getDesignVO(arg_35_1)
	local var_35_0 = {}

	var_35_0.equipmentCfg = Equipment.getConfigData(pg.compose_data_template[arg_35_1].equip_id)
	var_35_0.designCfg = pg.compose_data_template[arg_35_1]
	var_35_0.id = arg_35_1

	local var_35_1 = self:getItemById(pg.compose_data_template[arg_35_1].material_id).count

	var_35_0.itemCount = var_35_1
	var_35_0.canMakeCount = math.floor(var_35_1 / pg.compose_data_template[arg_35_1].material_num)
	var_35_0.canMake = math.min(var_35_0.canMakeCount, 1)

	local var_35_2 = Equipment.getConfigData(pg.compose_data_template[arg_35_1].equip_id)

	assert(var_35_2, "equip config not exist: " .. pg.compose_data_template[arg_35_1].equip_id)

	var_35_0.config = var_35_2

	function var_35_0.getNation(arg_36_0)
		return var_35_2.nationality
	end

	function var_35_0.getConfig(arg_37_0, arg_37_1)
		return var_35_2[arg_37_1]
	end

	return var_35_0
end

function EquipmentDesignLayer:filter(arg_38_1, arg_38_2)
	GetSpriteFromAtlasAsync("ui/share/index_atlas", self:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_39_0)
		setImageSprite(self.indexBtn, arg_39_0, true)

		return
	end)

	local var_38_0 = {}
	local var_38_1 = getProxy(EquipmentProxy)

	for iter_38_0, iter_38_1 in ipairs(pg.compose_data_template.all) do
		if self:getItemById(pg.compose_data_template[iter_38_1].material_id).count > 0 or self.contextData.isShowAllDesign and var_38_1:ShouldShowEquipmentDesignObtainWay(iter_38_1) then
			table.insert(var_38_0, iter_38_1)
		end
	end

	local var_38_2 = {}
	local var_38_3 = table.mergeArray({}, {
		self.contextData.indexDatas.equipPropertyIndex,
		self.contextData.indexDatas.equipPropertyIndex2
	}, true)

	for iter_38_2, iter_38_3 in pairs(var_38_0) do
		local var_38_4 = self:getDesignVO(iter_38_3)

		if IndexConst.filterEquipByType(var_38_4, self.contextData.indexDatas.typeIndex) and IndexConst.filterEquipByProperty(var_38_4, var_38_3) and IndexConst.filterEquipAmmo1(var_38_4, self.contextData.indexDatas.equipAmmoIndex1) and IndexConst.filterEquipAmmo2(var_38_4, self.contextData.indexDatas.equipAmmoIndex2) and IndexConst.filterEquipByCamp(var_38_4, self.contextData.indexDatas.equipCampIndex) and IndexConst.filterEquipByRarity(var_38_4, self.contextData.indexDatas.rarityIndex) then
			table.insert(var_38_2, iter_38_3)
		end
	end

	if arg_38_1 == 1 then
		if self.asc then
			table.sort(var_38_2, function(arg_40_0, arg_40_1)
				local var_40_0 = self:getDesignVO(arg_40_0)
				local var_40_1 = self:getDesignVO(arg_40_1)

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
			table.sort(var_38_2, function(arg_41_0, arg_41_1)
				local var_41_0 = self:getDesignVO(arg_41_0)
				local var_41_1 = self:getDesignVO(arg_41_1)

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
		if self.asc then
			table.sort(var_38_2, function(arg_42_0, arg_42_1)
				local var_42_0 = self:getDesignVO(arg_42_0)
				local var_42_1 = self:getDesignVO(arg_42_1)

				if var_42_0.equipmentCfg.rarity == var_42_1.equipmentCfg.rarity then
					return var_42_0.equipmentCfg.id < var_42_0.equipmentCfg.id
				end

				return var_42_0.equipmentCfg.rarity < var_42_1.equipmentCfg.rarity
			end)
		else
			table.sort(var_38_2, function(arg_43_0, arg_43_1)
				local var_43_0 = self:getDesignVO(arg_43_0)
				local var_43_1 = self:getDesignVO(arg_43_1)

				if var_43_0.equipmentCfg.rarity == var_43_1.equipmentCfg.rarity then
					return var_43_0.equipmentCfg.id < var_43_0.equipmentCfg.id
				end

				return var_43_0.equipmentCfg.rarity > var_43_1.equipmentCfg.rarity
			end)
		end
	elseif arg_38_1 == 3 then
		if self.asc then
			table.sort(var_38_2, function(arg_44_0, arg_44_1)
				local var_44_0 = self:getDesignVO(arg_44_0)
				local var_44_1 = self:getDesignVO(arg_44_1)

				if var_44_0.itemCount == var_44_1.itemCount then
					return var_44_0.equipmentCfg.id < var_44_1.equipmentCfg.id
				end

				return var_44_0.itemCount < var_44_1.itemCount
			end)
		else
			table.sort(var_38_2, function(arg_45_0, arg_45_1)
				local var_45_0 = self:getDesignVO(arg_45_0)
				local var_45_1 = self:getDesignVO(arg_45_1)

				if var_45_0.itemCount == var_45_1.itemCount then
					return var_45_0.equipmentCfg.id < var_45_1.equipmentCfg.id
				end

				return var_45_0.itemCount > var_45_1.itemCount
			end)
		end
	end

	self.desginIds = var_38_2

	self.scollRect:SetTotalCount(#var_38_2, arg_38_2 and -1 or 0)
	setActive(self.listEmptyTF, #var_38_2 <= 0)
	Canvas.ForceUpdateCanvases()
	setImageSprite(self.sortBtn:Find("Image"), (GetSpriteFromAtlas("ui/equipmentdesignui_atlas", var_0_1[arg_38_1])))
	setActive(self.sortImgAsc, self.asc)
	setActive(self.sortImgDec, not self.asc)

	return
end

function EquipmentDesignLayer:getItemById(arg_46_1)
	return self.itemVOs[arg_46_1] or Item.New({
		count = 0,
		id = arg_46_1
	})
end

function EquipmentDesignLayer:showDesignDesc(arg_47_1)
	self.isShowDesc = true

	if IsNil(self.msgBoxTF) then
		return
	end

	pg.UIMgr.GetInstance():BlurPanel(self.msgBoxTF)
	setActive(self.msgBoxTF, true)

	local var_47_0 = self.msgBoxTF
	local var_47_1 = pg.compose_data_template[arg_47_1]
	local var_47_2 = Equipment.New({
		id = pg.compose_data_template[arg_47_1].equip_id
	})

	updateEquipInfo(self.msgBoxTF:Find("bg/attrs/content"), var_47_2:GetPropertiesInfo(), var_47_2:GetSkill())
	GetImageSpriteFromAtlasAsync("equips/" .. var_47_2:getConfig("icon"), "", (var_47_0:Find("bg/frame/icon")))
	changeToScrollText(var_47_0:Find("bg/name"), var_47_2:getConfig("name"))
	UIItemList.New(var_47_0:Find("bg/frame/stars"), var_47_0:Find("bg/frame/stars/sarttpl")):align(var_47_2:getConfig("rarity"))
	setImageSprite(findTF(var_47_0, "bg/frame/type"), GetSpriteFromAtlas("equiptype", EquipType.type2Tag(var_47_2:getConfig("type"))))
	setText(var_47_0:Find("bg/frame/speciality/Text"), var_47_2:getConfig("speciality") ~= "无" and var_47_2:getConfig("speciality") or i18n1("—"))

	var_47_0:Find("bg/frame"):GetComponent(typeof(Image)).sprite = LoadSprite("bg/equipment_bg_" .. var_47_2:getConfig("rarity"))

	local var_47_3 = findTF(var_47_0, "bg/frame/numbers")
	local var_47_4 = var_47_2:getConfig("tech") or 1

	for iter_47_0 = 0, var_47_3.childCount - 1 do
		setActive(var_47_3:GetChild(iter_47_0), iter_47_0 == var_47_4)
	end

	local var_47_5 = math.floor(self:getItemById(var_47_1.material_id).count / var_47_1.material_num)
	local var_47_6 = 1
	local var_47_7 = var_47_0:Find("bg/calc/values/Text")
	local var_47_8 = var_47_1.gold_num
	local var_47_9 = var_47_0:Find("bg/calc/gold/Text")

	local function var_47_10(arg_48_0)
		setText(var_47_7, arg_48_0)
		setText(var_47_9, arg_48_0 * var_47_8)

		return
	end

	var_47_10(1)
	pressPersistTrigger(findTF(var_47_0, "bg/calc/minus"), 0.5, function(arg_49_0)
		if var_47_6 <= 1 then
			arg_49_0()

			return
		end

		var_47_6 = var_47_6 - 1

		var_47_10(var_47_6)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(findTF(var_47_0, "bg/calc/add"), 0.5, function(arg_50_0)
		if var_47_6 == var_47_5 then
			arg_50_0()

			return
		end

		var_47_6 = var_47_6 + 1

		var_47_10(var_47_6)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, findTF(var_47_0, "bg/calc/max"), function()
		if var_47_6 == var_47_5 then
			return
		end

		var_47_6 = math.max(math.min(var_47_5, self.player:getMaxEquipmentBag() - self.capacity), 1)

		var_47_10(var_47_6)

		return
	end, SFX_PANEL)
	onButton(self, findTF(var_47_0, "bg/cancel_btn"), function()
		self:hideMsgBox()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(var_47_0, "bg/confirm_btn"), function()
		self:emit(EquipmentDesignMediator.MAKE_EQUIPMENT, arg_47_1, var_47_6)
		self:hideMsgBox()

		return
	end, SFX_CONFIRM)
	onButton(self, var_47_0, function()
		self:hideMsgBox()

		return
	end, SFX_CANCEL)

	return
end

function EquipmentDesignLayer:hideMsgBox()
	if not IsNil(self.msgBoxTF) then
		self.isShowDesc = nil

		pg.UIMgr.GetInstance():UnOverlayPanel(self.msgBoxTF, self._tf)
		setActive(self.msgBoxTF, false)
	end

	return
end

function EquipmentDesignLayer:onBackPressed()
	if isActive(self.indexPanel) then
		triggerButton(self.indexPanel)

		return
	end

	if self.isShowDesc then
		self:hideMsgBox()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		self:emit(EquipmentDesignLayer.ON_BACK)
	end

	return
end

function EquipmentDesignLayer:willExit()
	self:UnOverlayPanel(self.indexPanel, self._tf)

	if self.leftEventTrigger then
		ClearEventTrigger(self.leftEventTrigger)
	end

	if self.rightEventTrigger then
		ClearEventTrigger(self.rightEventTrigger)
	end

	setParent(self.sortBtn.parent, self._tf)

	if self.obtainWayPage then
		self.obtainWayPage:Destroy()
	end

	self.obtainWayPage = nil

	return
end

return EquipmentDesignLayer
