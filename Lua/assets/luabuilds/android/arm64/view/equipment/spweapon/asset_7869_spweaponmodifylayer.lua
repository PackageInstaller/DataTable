local SpWeaponModifyLayer = class("SpWeaponModifyLayer", BaseUI)

function SpWeaponModifyLayer:getUIName()
	return "SpWeaponModifyUI"
end

function SpWeaponModifyLayer:init()
	self.equipmentPanel = self._tf:Find("Main/panel/equipment_panel")
	self.materialPanel = self._tf:Find("Main/panel/material_panel")
	self.equipmentIcon = self.equipmentPanel:Find("Icon")
	self.equipmentName = self.equipmentPanel:Find("Name")
	self.attributeList = self.equipmentPanel:Find("Attribute/Rect/Attrs")
	self.attributeButtons = self.equipmentPanel:Find("Attribute/Rect/Buttons")
	self.attributeExchangeButton = self.attributeButtons:Find("Exchange")
	self.attributeDiscardButton = self.attributeButtons:Find("Discard")

	setText(self.equipmentPanel:Find("Attribute/Text"), i18n("spweapon_ui_transform_attr_text"))
	setText(self.attributeExchangeButton:Find("Text"), i18n("spweapon_ui_change_attr"))
	setText(self.attributeDiscardButton:Find("Text"), i18n("spweapon_ui_keep_attr"))

	self.materialItems = CustomIndexLayer.Clone2Full(self.materialPanel:Find("materials/materials"), 3)
	self.materialLimit = self.materialPanel:Find("materials/limit")
	self.materialCostText = self.materialPanel:Find("cost/consume")
	self.materialStartButton = self.materialPanel:Find("start_btn")

	setText(self.materialPanel:Find("materials/panel_title"), i18n("spweapon_ui_need_resource"))
	setText(self.materialStartButton:Find("Image"), i18n("spweapon_ui_transform"))

	return
end

function SpWeaponModifyLayer:SetSpweaponVO(arg_3_1)
	self.spWeaponVO = arg_3_1

	return
end

function SpWeaponModifyLayer:SetItems(arg_4_1)
	self.itemVOs = arg_4_1

	return
end

function SpWeaponModifyLayer:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:closeView()

		return
	end)
	self:UpdateView()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SpWeaponModifyLayer:ResetMaterialMask()
	self.confirmUpgrade = nil

	return
end

function SpWeaponModifyLayer:UpdateView()
	setText(self.equipmentName, self.spWeaponVO:GetName())

	local var_8_0 = self.spWeaponVO:GetUpgradeConfig()

	table.Foreach(self.materialItems, function(arg_9_0, arg_9_1)
		setActive(arg_9_1:Find("Off"), not var_8_0.reset_use_item[arg_9_0])
		setActive(arg_9_1:Find("Icon"), var_8_0.reset_use_item[arg_9_0])

		if var_8_0.reset_use_item[arg_9_0] then
			local var_9_0 = {
				id = var_8_0.reset_use_item[arg_9_0][1],
				count = var_8_0.reset_use_item[arg_9_0][2],
				type = DROP_TYPE_ITEM
			}

			updateDrop(arg_9_1:Find("Icon"), var_9_0)

			local var_9_1 = defaultValue(self.itemVOs[var_8_0.reset_use_item[arg_9_0][1]], {
				count = 0
			})

			setText(arg_9_1:Find("Icon/icon_bg/count"), (var_9_1.count < var_8_0.reset_use_item[arg_9_0][2] or nil) and setColorStr(var_9_1.count, COLOR_RED) .. "/" .. var_8_0.reset_use_item[arg_9_0][2])
			onButton(self, arg_9_1:Find("Icon"), function()
				self:emit(BaseUI.ON_DROP, var_9_0)

				return
			end)

			local var_9_3 = arg_9_1:Find("Icon/Click")

			setActive(var_9_3, not self.confirmUpgrade)
			onButton(self, var_9_3, function()
				self.confirmUpgrade = true

				setActive(var_9_3, not self.confirmUpgrade)

				return
			end)
		end

		return
	end)
	updateSpWeapon(self.equipmentIcon, self.spWeaponVO)

	local var_8_1 = self.spWeaponVO:GetAttributeOptions()
	local var_8_2 = self.spWeaponVO:GetBaseAttributes()
	local var_8_3 = self.spWeaponVO:GetAttributesRange()
	local var_8_4 = {
		self.spWeaponVO:getConfig("attribute_1"),
		self.spWeaponVO:getConfig("attribute_2")
	}
	local var_8_5 = _.any(var_8_1, function(arg_12_0)
		return arg_12_0 > 0
	end)

	setActive(self.attributeButtons, var_8_5)
	UIItemList.StaticAlign(self.attributeList, self.attributeList:GetChild(0), #var_8_2, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_13_1 = arg_13_1 + 1

		setText(arg_13_2:Find("Name"), (AttributeType.Type2Name(var_8_4[arg_13_1])))
		setText(arg_13_2:Find("Values/Min/Value"), math.min(1, var_8_3[arg_13_1]))
		setText(arg_13_2:Find("Values/Max/Value"), var_8_3[arg_13_1])
		setText(arg_13_2:Find("Values/Current/Value1"), var_8_2[arg_13_1])
		setText(arg_13_2:Find("Values/Current/Value2"), var_8_1[arg_13_1])
		setActive(arg_13_2:Find("Values/Current/Symbol"), var_8_5)
		setActive(arg_13_2:Find("Values/Current/Value2"), var_8_5)

		return
	end)
	onButton(self, self.materialStartButton, function()
		if not self.confirmUpgrade then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_transform_materal_check"))

			return
		end

		self:emit(SpWeaponModifyMediator.ON_REFORGE)

		return
	end, SFX_PANEL)
	onButton(self, self.attributeExchangeButton, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON,
			op = SpWeapon.CONFIRM_OP_EXCHANGE,
			attrs = _.map({
				1,
				2
			}, function(arg_16_0)
				return {
					AttributeType.Type2Name(var_8_4[arg_16_0]),
					var_8_2[arg_16_0],
					var_8_1[arg_16_0]
				}
			end),
			onYes = function()
				self:emit(SpWeaponModifyMediator.ON_CONFIRM_REFORGE, SpWeapon.CONFIRM_OP_EXCHANGE)

				return
			end
		})

		return
	end, SFX_CANCEL)
	onButton(self, self.attributeDiscardButton, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON,
			op = SpWeapon.CONFIRM_OP_DISCARD,
			attrs = _.map({
				1,
				2
			}, function(arg_19_0)
				return {
					AttributeType.Type2Name(var_8_4[arg_19_0]),
					var_8_2[arg_19_0],
					var_8_1[arg_19_0]
				}
			end),
			onYes = function()
				self:emit(SpWeaponModifyMediator.ON_CONFIRM_REFORGE, SpWeapon.CONFIRM_OP_DISCARD)

				return
			end
		})

		return
	end, SFX_CANCEL)
	setGray(self.materialStartButton, var_8_5 or table.equal(var_8_2, var_8_3))

	return
end

function SpWeaponModifyLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return SpWeaponModifyLayer
