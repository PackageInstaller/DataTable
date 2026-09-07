local EquipmentTraceBackLayer = class("EquipmentTraceBackLayer", import("view.base.BaseUI"))

function EquipmentTraceBackLayer:getUIName()
	return "EquipmentTraceBackUI"
end

function EquipmentTraceBackLayer:init()
	local var_2_0 = self._tf:Find("Adapt/Left/Operation")

	self.sortOrderBtn = var_2_0:Find("Bar1")
	self.orderText = var_2_0:Find("OrderText")
	self.sortBarBtn = var_2_0:Find("Bar2")
	self.sortImg = var_2_0:Find("SortImg")
	self.sortBar = self._tf:Find("Adapt/Left/SortBar")

	setActive(self.sortBar, false)

	self.equipLayout = self._tf:Find("Adapt/Left/Scroll View")
	self.equipLayoutScroll = self.equipLayout:GetComponent("LScrollRect")
	self.equipLayoutContent = self.equipLayout:Find("Viewport/Content")
	self.equipLayoutContent:GetComponent(typeof(GridLayoutGroup)).constraintCount = 6

	local var_2_1 = self._tf:Find("Adapt/Right")

	self.sourceEquip = var_2_1:Find("Source")
	self.sourceEquipStatus = var_2_1:Find("Status")
	self.formulaWire = var_2_1:Find("Wire")
	self.targetEquip = var_2_1:Find("Target")
	self.confirmBtn = var_2_1:Find("ConfirmBtn")
	self.cancelBtn = var_2_1:Find("CancelBtn")
	self.materialLayout = var_2_1:Find("Scroll View")
	self.materialLayoutContent = self.materialLayout:Find("Viewport/Content")
	self.goldText = var_2_1:Find("GoldText")

	setText(var_2_0:Find("Field/Text"), i18n("equipment_upgrade_quick_interface_source_chosen"))
	setText(var_2_1:Find("Text"), i18n("equipment_upgrade_quick_interface_materials_consume"))

	self.loader = AutoLoader.New()

	return
end

EquipmentTraceBackLayer.SortType = {
	Rarity = "rarity",
	Strengthen = "level",
	Type = "type"
}

local var_0_1 = {
	EquipmentTraceBackLayer.SortType.Rarity,
	EquipmentTraceBackLayer.SortType.Type,
	EquipmentTraceBackLayer.SortType.Strengthen
}
local var_0_2 = {
	[EquipmentTraceBackLayer.SortType.Rarity] = "rarity",
	[EquipmentTraceBackLayer.SortType.Type] = "type",
	[EquipmentTraceBackLayer.SortType.Strengthen] = "strengthen"
}

EquipmentTraceBackLayer.SortOrder = {
	Descend = 0,
	Ascend = 1
}

local var_0_3 = {
	[EquipmentTraceBackLayer.SortOrder.Descend] = "word_desc",
	[EquipmentTraceBackLayer.SortOrder.Ascend] = "word_asc"
}

function EquipmentTraceBackLayer:SetEnv(arg_3_1)
	self.env = arg_3_1

	return
end

function EquipmentTraceBackLayer:GetAllPaths(arg_4_1)
	local var_4_0 = {}
	local var_4_1 = {
		{
			arg_4_1
		}
	}

	while #var_4_1 > 0 do
		local var_4_2 = table.remove(var_4_1, 1)

		for iter_4_0, iter_4_1 in ipairs((EquipmentProxy.GetTransformSources(var_4_2[1]))) do
			local var_4_3 = pg.equip_upgrade_data[iter_4_1].upgrade_from
			local var_4_4 = var_4_2[2] and Clone(var_4_2[2]) or {}

			table.insert(var_4_4, 1, iter_4_1)
			table.insert(var_4_1, {
				var_4_3,
				var_4_4
			})

			local var_4_5 = self.env.tracebackHelper:GetEquipmentTransformCandicates(var_4_3)

			if #var_4_5 > 0 then
				table.insertto(var_4_0, _.map(var_4_5, function(arg_5_0)
					return {
						source = arg_5_0,
						formulas = var_4_4
					}
				end))
			end
		end
	end

	return var_4_0
end

function EquipmentTraceBackLayer:UpdateSourceEquipmentPaths()
	self.totalPaths = self:GetAllPaths(self.contextData.TargetEquipmentId)

	if self.contextData.sourceEquipmentInstance then
		local var_6_0 = _.detect(self.totalPaths, function(arg_7_0)
			return EquipmentTransformUtil.SameDrop(arg_7_0.source, self.contextData.sourceEquipmentInstance)
		end)

		if var_6_0 then
			self.contextData.sourceEquipmentInstance = var_6_0.source or nil
		end
	end

	return
end

function EquipmentTraceBackLayer:UpdateSort()
	for iter_8_0, iter_8_1 in ipairs(self.totalPaths) do
		iter_8_1.isSourceEnough = iter_8_1.source.type ~= DROP_TYPE_ITEM or iter_8_1.source.template.count >= iter_8_1.source.composeCfg.material_num
		iter_8_1.isMaterialEnough = iter_8_1.isSourceEnough and EquipmentTransformUtil.CheckTransformFormulasSucceed(iter_8_1.formulas, iter_8_1.source)
	end

	table.sort(self.totalPaths, function(arg_9_0, arg_9_1)
		if arg_9_0.isSourceEnough ~= arg_9_1.isSourceEnough then
			return arg_9_0.isSourceEnough
		end

		if arg_9_0.isMaterialEnough ~= arg_9_1.isMaterialEnough then
			return arg_9_0.isMaterialEnough
		end

		if arg_9_0.source.type ~= arg_9_1.source.type then
			return arg_9_0.source.type < arg_9_1.source.type
		end

		local var_9_0 = self.contextData.sortType
		local var_9_1 = self.contextData.sortOrder == EquipmentTraceBackLayer.SortOrder.Descend and 1 or -1

		if arg_9_0.source.type == DROP_TYPE_ITEM then
			return (arg_9_0.source.template.id - arg_9_1.source.template.id) * var_9_1 > 0
		end

		local var_9_2 = arg_9_0.source.template.shipId or -1
		local var_9_3 = arg_9_1.source.template.shipId or -1

		if var_9_2 ~= var_9_3 then
			return var_9_2 < var_9_3
		end

		local var_9_4 = arg_9_0.source.template:getConfigTable()[var_9_0] - arg_9_1.source.template:getConfigTable()[var_9_0]

		var_9_4 = var_9_4 ~= 0 and var_9_4 or arg_9_0.source.template.id - arg_9_1.source.template.id

		return var_9_4 * var_9_1 > 0
	end)
	setText(self.orderText, i18n(var_0_3[self.contextData.sortOrder]))
	self.loader:GetSprite("ui/equipmenttracebackui_atlas", var_0_2[self.contextData.sortType], self.sortImg)

	return
end

function EquipmentTraceBackLayer:didEnter()
	function self.equipLayoutScroll.onUpdateItem(arg_11_0, arg_11_1)
		self:UpdateSourceListItem(arg_11_0, tf(arg_11_1))
		TweenItemAlphaAndWhite(arg_11_1)

		return
	end

	function self.equipLayoutScroll.onReturnItem(arg_12_0, arg_12_1)
		ClearTweenItemAlphaAndWhite(arg_12_1)

		return
	end

	onButton(self, self.sortBarBtn, function()
		setActive(self.sortBar, not isActive(self.sortBar))

		return
	end, SFX_PANEL)

	for iter_10_0 = 1, self.sortBar.childCount do
		onButton(self, self.sortBar:GetChild(iter_10_0 - 1), function()
			self.contextData.sortType = var_0_1[iter_10_0]

			self:UpdateSort()
			self:UpdateSourceList()
			setActive(self.sortBar, false)

			return
		end, SFX_PANEL)
	end

	onButton(self, self.sortOrderBtn, function()
		self.contextData.sortOrder = EquipmentTraceBackLayer.SortOrder.Ascend - self.contextData.sortOrder

		self:UpdateSort()
		self:UpdateSourceList()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.confirmBtn, function()
		if not self.contextData.sourceEquipmentInstance then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_quick_interface_feedback_source_chosen"))

			return
		end

		if not EquipmentTransformUtil.CheckTransformFormulasSucceed(self.contextData.sourceEquipmentFormulaList, self.contextData.sourceEquipmentInstance) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_feedback_lack_of_materials"))

			return
		end

		self:emit(EquipmentTraceBackMediator.TRANSFORM_EQUIP, self.contextData.sourceEquipmentInstance, self.contextData.sourceEquipmentFormulaList)

		return
	end, SFX_PANEL)

	self.contextData.sortOrder = self.contextData.sortOrder or EquipmentTraceBackLayer.SortOrder.Descend
	self.contextData.sortType = self.contextData.sortType or EquipmentTraceBackLayer.SortType.Rarity

	self:UpdateSourceEquipmentPaths()
	self:UpdateSort()
	self:UpdateSourceList()
	self:UpdateFormula()
	updateDrop(self.targetEquip, {
		type = DROP_TYPE_EQUIP,
		id = self.contextData.TargetEquipmentId
	})
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	return
end

function EquipmentTraceBackLayer:UpdateSourceList()
	self.lastSourceItem = nil

	self.equipLayoutScroll:SetTotalCount(#self.totalPaths)

	return
end

function EquipmentTraceBackLayer:UpdateSourceListItem(arg_19_1, arg_19_2)
	local var_19_0 = self.totalPaths[arg_19_1 + 1].source
	local var_19_1 = self.totalPaths[arg_19_1 + 1].source.template

	updateDrop(arg_19_2:Find("Item"), self.totalPaths[arg_19_1 + 1].source)
	setText(arg_19_2:Find("Item/icon_bg/count"), var_19_1.count)
	setActive(arg_19_2:Find("EquipShip"), var_19_1.shipId)
	setActive(arg_19_2:Find("Selected"), false)

	if var_19_0 == self.contextData.sourceEquipmentInstance then
		self.lastSourceItem = arg_19_2

		setActive(arg_19_2:Find("Selected"), true)
	end

	setActive(arg_19_2:Find("Item/mask"), false)

	if var_19_0.type == DROP_TYPE_ITEM then
		local var_19_2 = var_19_0.composeCfg.material_num <= var_19_1.count

		setText(arg_19_2:Find("Item/icon_bg/count"), (setColorStr(var_19_1.count .. "/" .. var_19_0.composeCfg.material_num, (var_19_0.composeCfg.material_num <= var_19_1.count or nil) and (COLOR_WHITE or COLOR_RED))))
		setActive(arg_19_2:Find("Item/mask"), not var_19_2)
	end

	if var_19_1.shipId then
		self.loader:GetSprite("qicon/" .. getProxy(BayProxy):getShipById(var_19_1.shipId):getPainting(), "", arg_19_2:Find("EquipShip/Image"))
	end

	arg_19_2:Find("Mask/NameText"):GetComponent(typeof(ScrollText)):SetText(var_19_1:getConfig("name"))
	onButton(self, arg_19_2:Find("Item"), function()
		if var_19_0.type == DROP_TYPE_ITEM and var_19_0.template.count < var_19_0.composeCfg.material_num then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_feedback_lack_of_fragment", var_19_0.template:getConfig("name")))

			return
		end

		if self.lastSourceItem then
			setActive(self.lastSourceItem:Find("Selected"), false)
		end

		self.lastSourceItem = arg_19_2

		setActive(arg_19_2:Find("Selected"), true)

		self.contextData.sourceEquipmentInstance = var_19_0
		self.contextData.sourceEquipmentFormulaList = self.totalPaths[arg_19_1 + 1].formulas

		self:UpdateFormula()

		return
	end, SFX_PANEL)

	return
end

function EquipmentTraceBackLayer:UpdatePlayer(arg_21_1)
	self.player = arg_21_1

	self:UpdateConsumeComparer()

	return
end

function EquipmentTraceBackLayer:UpdateConsumeComparer()
	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = true

	if self.contextData.sourceEquipmentInstance then
		var_22_2, var_22_0, var_22_1 = EquipmentTransformUtil.CheckTransformEnoughGold(self.contextData.sourceEquipmentFormulaList, self.contextData.sourceEquipmentInstance)
	end

	local var_22_3 = setColorStr(var_22_0, (var_22_2 or nil) and (COLOR_WHITE or COLOR_RED))

	if var_22_1 > 0 then
		var_22_3 = var_22_3 .. setColorStr(" + " .. var_22_1, (var_22_2 or nil) and (COLOR_GREEN or COLOR_RED))
	end

	self.goldText:GetComponent(typeof(Text)).text = var_22_3

	return
end

function EquipmentTraceBackLayer:UpdateFormula()
	setActive(self.sourceEquipStatus, not self.contextData.sourceEquipmentInstance)
	setActive(self.sourceEquip, self.contextData.sourceEquipmentInstance)
	setActive(self.materialLayout, self.contextData.sourceEquipmentInstance)

	if self.contextData.sourceEquipmentInstance then
		updateDrop(self.sourceEquip, self.contextData.sourceEquipmentInstance)
		setText(self.sourceEquip:Find("icon_bg/count"), (self.contextData.sourceEquipmentInstance and self.contextData.sourceEquipmentInstance.type == DROP_TYPE_ITEM or nil) and self.contextData.sourceEquipmentInstance.composeCfg.material_num)
		self.loader:GetSprite("ui/equipmenttracebackui_atlas", (not self.contextData.sourceEquipmentFormulaList or #self.contextData.sourceEquipmentFormulaList <= 1) and "wire" or "wire2", self.formulaWire)
		self:UpdateFormulaMaterials()
	else
		self:UpdateConsumeComparer()
	end

	return
end

function EquipmentTraceBackLayer:UpdateFormulaMaterials()
	if not self.contextData.sourceEquipmentFormulaList then
		return
	end

	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self.contextData.sourceEquipmentFormulaList) do
		for iter_24_2, iter_24_3 in ipairs(pg.equip_upgrade_data[iter_24_1].material_consume) do
			var_24_0[iter_24_3[1]] = (var_24_0[iter_24_3[1]] or 0) + iter_24_3[2]
		end
	end

	local var_24_2 = {}

	for iter_24_4, iter_24_5 in pairs(var_24_0) do
		table.insert(var_24_2, {
			id = iter_24_4,
			count = iter_24_5
		})
	end

	table.sort(var_24_2, function(arg_25_0, arg_25_1)
		return arg_25_0.id > arg_25_1.id
	end)

	self.consumeMaterials = var_24_2

	UIItemList.StaticAlign(self.materialLayoutContent, self.materialLayoutContent:GetChild(0), #self.consumeMaterials, function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			self:UpdateFormulaMaterialItem(arg_26_1, arg_26_2)
		end

		return
	end)
	Canvas.ForceUpdateCanvases()

	local var_24_3 = self.materialLayoutContent.rect.height < self.materialLayout.rect.height

	self.materialLayout:GetComponent(typeof(ScrollRect)).enabled = self.materialLayoutContent.rect.height >= self.materialLayout.rect.height

	setActive(self.materialLayout:Find("Scrollbar"), not var_24_3)

	if var_24_3 then
		self.materialLayoutContent.anchoredPosition = Vector2.zero
	end

	self:UpdateConsumeComparer()

	return
end

function EquipmentTraceBackLayer:UpdateFormulaMaterialItem(arg_27_1, arg_27_2)
	local var_27_0 = {
		type = DROP_TYPE_ITEM,
		id = self.consumeMaterials[arg_27_1 + 1].id
	}

	updateDrop(arg_27_2:Find("Item"), var_27_0)

	local var_27_1 = getProxy(BagProxy):getItemCountById(self.consumeMaterials[arg_27_1 + 1].id)

	setText(arg_27_2:Find("Count"), setColorStr(self.consumeMaterials[arg_27_1 + 1].count, (var_27_1 >= self.consumeMaterials[arg_27_1 + 1].count or nil) and (COLOR_GREEN or COLOR_RED)) .. "/" .. var_27_1)
	onButton(self, arg_27_2:Find("Item"), function()
		self:emit(EquipmentTraceBackLayer.ON_DROP, var_27_0)

		return
	end)

	return
end

function EquipmentTraceBackLayer:willExit()
	self.loader:Clear()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return EquipmentTraceBackLayer
