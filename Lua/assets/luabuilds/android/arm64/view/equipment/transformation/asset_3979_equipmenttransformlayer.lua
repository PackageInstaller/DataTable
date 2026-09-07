local EquipmentTransformLayer = class("EquipmentTransformLayer", import("view.base.BaseUI"))

function EquipmentTransformLayer:getUIName()
	return "EquipmentTransformUI"
end

function EquipmentTransformLayer:init()
	self.layer = self._tf:Find("Adapt")
	self.formulaItems = {}
	self.formulaItems[1] = self.layer:Find("MaterialModule1")
	self.formulaItems[2] = self.layer:Find("MaterialModule2")
	self.formulaItems[3] = self.layer:Find("MaterialModule3")
	self.sourceEquipItem = self.layer:Find("SourceEquip")
	self.targetEquipItem = self.layer:Find("TargetEquip")
	self.consumePanel = self.layer:Find("ComposePanel")

	setText(self._tf:Find("Adapt/TitleText"), i18n("equipment_upgrade_title"))
	setText(self.consumePanel:Find("Consume"), i18n("equipment_upgrade_coin_consume"))
	setText(self._tf:Find("Adapt/InfoPanel/StoreCount/OnShip/NameText"), i18n("equipment_upgrade_equipped_tag"))
	setText(self._tf:Find("Adapt/InfoPanel/StoreCount/Free/NameText"), i18n("equipment_upgrade_spare_tag"))

	local var_2_0 = self._tf:Find("Adapt/InfoPanel/Viewport/Content")
	local var_2_1 = var_2_0:Find("attr_tpl")

	setActive(var_2_1, false)
	setActive(var_2_1:Find("subs"), false)

	local var_2_2 = Instantiate(var_2_1).transform

	var_2_2.name = "attr"

	setParent(var_2_2, var_2_0:Find("skill"))
	var_2_2:SetAsFirstSibling()

	local var_2_3 = Instantiate(var_2_1).transform

	var_2_3.name = "attr"

	setParent(var_2_3, var_2_0:Find("part"))
	var_2_3:SetAsFirstSibling()

	self.loader = AutoLoader.New()

	return
end

function EquipmentTransformLayer:SetEnv(arg_3_1)
	self.env = arg_3_1

	return
end

function EquipmentTransformLayer:UpdatePlayer(arg_4_1)
	self.player = arg_4_1

	self:UpdateConsumeComparer()

	return
end

function EquipmentTransformLayer:UpdateConsumeComparer()
	local var_5_0 = 0
	local var_5_1 = 0
	local var_5_2 = true

	if self.contextData.sourceEquipmentInstance then
		var_5_2, var_5_0, var_5_1 = EquipmentTransformUtil.CheckTransformEnoughGold({
			self.contextData.formulaId
		}, self.contextData.sourceEquipmentInstance)
	end

	local var_5_3 = setColorStr(var_5_0, (var_5_2 or nil) and (COLOR_WHITE or COLOR_RED))

	if var_5_1 > 0 then
		var_5_3 = var_5_3 .. setColorStr(" + " .. var_5_1, (var_5_2 or nil) and (COLOR_GREEN or COLOR_RED))
	end

	self.consumePanel:Find("GoldText"):GetComponent(typeof(Text)).text = var_5_3

	return
end

function EquipmentTransformLayer:UpdateFormula(arg_6_1)
	if arg_6_1 == self.contextData.formulaId then
		return
	end

	assert(arg_6_1 and arg_6_1 > 0, "target formulaId is invalid")

	self.contextData.formulaId = arg_6_1
	self.contextData.formula = pg.equip_upgrade_data[arg_6_1]
	self.equipmentSourceId = pg.equip_upgrade_data[arg_6_1].upgrade_from
	self.equipmentTarget = pg.equip_upgrade_data[arg_6_1].target_id
	self.transformMaterials = pg.equip_upgrade_data[arg_6_1].material_consume

	self:UpdateConsumeComparer()

	if self.contextData.sourceEquipmentInstance then
		self.contextData.sourceEquipmentInstance = _.detect(self.env.tracebackHelper:GetEquipmentTransformCandicates(self.equipmentSourceId), function(arg_7_0)
			return EquipmentTransformUtil.SameDrop(arg_7_0, self.contextData.sourceEquipmentInstance)
		end)
	end

	PlayerPrefs.SetInt("ShowTransformTip_" .. self.equipmentTarget, 1)
	PlayerPrefs.Save()
	self:emit(EquipmentTransformMediator.UPDATE_NEW_FLAG, self.equipmentTarget)
	setActive(self.layer:Find("SwitchButton"), #EquipmentProxy.GetTransformSources(self.equipmentTarget) > 1)
	self:UpdatePage()

	return
end

function EquipmentTransformLayer:UpdatePage()
	self:UpdateSourceEquipmentPaths()
	self:UpdateFormulaItems()
	self:UpdateTargetInfo()
	self:UpdateSourceInfo()

	return
end

function EquipmentTransformLayer:UpdateSourceEquipmentPaths()
	self.hasRoot = _.any(self.env.tracebackHelper:GetSortedEquipTraceBack(self.equipmentSourceId), function(arg_10_0)
		return arg_10_0.candicates and #arg_10_0.candicates > 0 and EquipmentTransformUtil.CheckTransformFormulasSucceed(arg_10_0.formulas, arg_10_0.candicates[#arg_10_0.candicates])
	end)
	self.childsCanUse = _.any(self.env.tracebackHelper:GetEquipmentTransformCandicates(self.equipmentSourceId), function(arg_11_0)
		if arg_11_0.type == DROP_TYPE_ITEM then
			return arg_11_0.template.count >= arg_11_0.composeCfg.material_num
		elseif arg_11_0.type == DROP_TYPE_EQUIP then
			return arg_11_0.template.count > 0
		end

		return
	end)

	return
end

function EquipmentTransformLayer:CheckEnoughMaterials()
	if not self.contextData.formula then
		return
	end

	if not self.contextData.sourceEquipmentInstance then
		return
	end

	local var_12_0, var_12_1 = EquipmentTransformUtil.CheckTransformFormulasSucceed({
		self.contextData.formulaId
	}, self.contextData.sourceEquipmentInstance)

	if not var_12_0 then
		return false, var_12_1
	end

	return true
end

function EquipmentTransformLayer:UpdateFormulaItems()
	for iter_13_0, iter_13_1 in ipairs(self.formulaItems) do
		local var_13_0 = iter_13_1:Find("Item")
		local var_13_1 = self.transformMaterials[iter_13_0]

		setActive(iter_13_1, self.transformMaterials[iter_13_0])

		if var_13_1 then
			local var_13_2 = {
				type = DROP_TYPE_ITEM,
				id = var_13_1[1],
				count = var_13_1[2]
			}

			updateDrop(var_13_0, var_13_2)
			onButton(self, var_13_0, function()
				self:emit(EquipmentTransformLayer.ON_DROP, var_13_2)

				return
			end, SFX_PANEL)

			local var_13_3 = getProxy(BagProxy):getItemCountById(var_13_1[1])

			var_13_3 = var_13_3 or 0

			setText(iter_13_1:Find("NumText"), setColorStr(var_13_3, (var_13_3 < var_13_1[2] or nil) and (COLOR_RED or "#000F")) .. "/" .. var_13_1[2])

			local var_13_6 = self.equipmentSourceId == 0

			setActive(iter_13_1:Find("Line"), not (self.equipmentSourceId == 0))
			setActive(iter_13_1:Find("Line2"), var_13_6)
		end
	end

	return
end

function EquipmentTransformLayer:UpdateTargetInfo()
	updateDrop(self.targetEquipItem:Find("Item"), {
		id = self.equipmentTarget,
		type = DROP_TYPE_EQUIP
	})
	self.targetEquipItem:Find("Mask/NameText"):GetComponent("ScrollText"):SetText(Equipment.getConfigData(self.equipmentTarget).name)

	local var_15_0 = self.layer:Find("InfoPanel")
	local var_15_1 = 0
	local var_15_2 = 0

	for iter_15_0, iter_15_1 in ipairs((self.env.tracebackHelper:GetEquipmentTransformCandicates(self.equipmentTarget))) do
		if iter_15_1.type == DROP_TYPE_EQUIP then
			if iter_15_1.template.shipId then
				var_15_1 = var_15_1 + iter_15_1.template.count
			else
				var_15_2 = var_15_2 + iter_15_1.template.count
			end
		end
	end

	setText(var_15_0:Find("StoreCount/OnShip/ValueText"), var_15_1)
	setText(var_15_0:Find("StoreCount/Free/ValueText"), var_15_2)

	local var_15_3 = Equipment.New({
		id = self.equipmentTarget
	})
	local var_15_4 = var_15_0:Find("Viewport/Content")

	updateEquipInfo(var_15_4, var_15_3:GetPropertiesInfo(), var_15_3:GetSkill())
	Canvas.ForceUpdateCanvases()
	EquipmentTransformLayer.FitTextBGSize(var_15_4:Find("attrs"))
	EquipmentTransformLayer.FitTextBGSize(var_15_4:Find("weapon"))
	EquipmentTransformLayer.FitTextBGSize(var_15_4:Find("equip_info"))

	return
end

function EquipmentTransformLayer:FitTextBGSize()
	for iter_16_0 = 0, self.childCount - 1 do
		local var_16_0 = self:GetChild(iter_16_0)
		local var_16_1 = var_16_0:Find("base/NameBG").sizeDelta

		var_16_1.x = var_16_0:Find("base/name").rect.width + 18
		var_16_0:Find("base/NameBG").sizeDelta = var_16_1

		EquipmentTransformLayer.FitTextBGSize(var_16_0:Find("subs"))
	end

	return
end

function EquipmentTransformLayer:UpdateSourceInfo()
	local var_17_0 = self.contextData.sourceEquipmentInstance
	local var_17_1 = self.contextData.sourceEquipmentInstance or {
		id = self.equipmentSourceId,
		type = DROP_TYPE_EQUIP
	}
	local var_17_2 = self.equipmentSourceId == 0

	setActive(self.sourceEquipItem, not (self.equipmentSourceId == 0))

	if var_17_2 then
		return
	end

	updateDrop(self.sourceEquipItem:Find("Item"), var_17_1)
	setText(self.sourceEquipItem:Find("Item/icon_bg/count"), (var_17_0 and var_17_0.type == DROP_TYPE_ITEM or nil) and setColorStr(math.min(var_17_0.template.count, var_17_0.composeCfg.material_num), (var_17_0.template.count >= var_17_0.composeCfg.material_num or nil) and (COLOR_WHITE or COLOR_RED)))
	self.sourceEquipItem:Find("Mask/NameText"):GetComponent("ScrollText"):SetText(Equipment.getConfigData(self.equipmentSourceId).name)
	setActive(self.sourceEquipItem:Find("craftable"), self.hasRoot)
	onButton(self, self.sourceEquipItem:Find("craftable"), function()
		self:emit(EquipmentTransformMediator.OPEN_LAYER, Context.New({
			mediator = EquipmentTraceBackMediator,
			viewComponent = EquipmentTraceBackLayer,
			data = {
				TargetEquipmentId = self.equipmentSourceId
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.sourceEquipItem:Find("Item"), function()
		if self.childsCanUse then
			self:emit(EquipmentTransformMediator.SELECT_TRANSFORM_FROM_STOREHOUSE, self.equipmentSourceId)
		end

		return
	end, SFX_PANEL)

	local var_17_5 = self.sourceEquipItem:Find("Status")

	if not self.childsCanUse then
		setImageSprite(var_17_5, LoadSprite("ui/equipmenttransformui_atlas", "noown"))
		setActive(var_17_5, true)
	elseif not var_17_0 then
		setImageSprite(var_17_5, LoadSprite("ui/equipmenttransformui_atlas", "unselect"))
		setActive(var_17_5, true)
	else
		setActive(var_17_5, false)
	end

	local var_17_6 = var_17_0 and var_17_0.template.shipId

	setActive(self.sourceEquipItem:Find("EquipShip"), var_17_0 and var_17_0.template.shipId)

	if var_17_6 then
		self.loader:GetSprite("qicon/" .. getProxy(BayProxy):getShipById(var_17_6):getPainting(), "", self.sourceEquipItem:Find("EquipShip/Image"))
	end

	return
end

function EquipmentTransformLayer:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:closeView()

		return
	end)
	onButton(self, self.consumePanel:Find("ComposeBtn"), function()
		if self.equipmentSourceId ~= 0 and not self.contextData.sourceEquipmentInstance then
			if self.childsCanUse then
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_quick_interface_feedback_source_chosen"))

				return
			elseif self.hasRoot then
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_feedback_equipment_can_be_produced"))

				return
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_feedback_lack_of_equipment"))

				return
			end
		end

		if not self:CheckEnoughMaterials() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_feedback_lack_of_materials"))

			return
		end

		self:emit(EquipmentTransformMediator.TRANSFORM_EQUIP, self.contextData.sourceEquipmentInstance, self.contextData.formulaId)

		return
	end, SFX_PANEL)
	onButton(self, self.layer:Find("OverviewBtn"), function()
		self:emit(EquipmentTransformMediator.OPEN_TRANSFORM_TREE, self.equipmentTarget)

		return
	end, SFX_CANCEL)
	onButton(self, self.layer:Find("SwitchButton"), function()
		local var_24_0 = EquipmentProxy.GetTransformSources(self.equipmentTarget)
		local var_24_1 = table.indexof(var_24_0, self.contextData.formulaId)

		self.contextData.sourceEquipmentInstance = nil

		self:UpdateFormula(var_24_0[var_24_1 and var_24_1 % #var_24_0 + 1 or 1])

		return
	end, SFX_PANEL)
	onButton(self, self.layer:Find("HelpBtn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.equipment_upgrade_help.tip
		})

		return
	end, SFX_PANEL)
	assert(self.contextData.formulaId)

	self.contextData.formulaId = nil

	self:UpdateFormula(self.contextData.formulaId)

	local var_20_0, var_20_1 = getProxy(ContextProxy):getContextByMediator(EquipmentTransformMediator)

	setActive(self.layer:Find("OverviewBtn"), (var_20_1 and pg.m02:retrieveMediator(var_20_1.mediator.__cname)).class ~= EquipmentTransformTreeMediator)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function EquipmentTransformLayer:willExit()
	self.loader:Clear()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return EquipmentTransformLayer
