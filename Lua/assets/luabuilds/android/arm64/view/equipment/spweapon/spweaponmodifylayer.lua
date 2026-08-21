local var_0_0 = class("SpWeaponModifyLayer", BaseUI)

function var_0_0.getUIName(arg_1_0)
	return "SpWeaponModifyUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.equipmentPanel = arg_2_0._tf:Find("Main/panel/equipment_panel")
	arg_2_0.materialPanel = arg_2_0._tf:Find("Main/panel/material_panel")
	arg_2_0.equipmentIcon = arg_2_0.equipmentPanel:Find("Icon")
	arg_2_0.equipmentName = arg_2_0.equipmentPanel:Find("Name")
	arg_2_0.attributeList = arg_2_0.equipmentPanel:Find("Attribute/Rect/Attrs")
	arg_2_0.attributeButtons = arg_2_0.equipmentPanel:Find("Attribute/Rect/Buttons")
	arg_2_0.attributeExchangeButton = arg_2_0.attributeButtons:Find("Exchange")
	arg_2_0.attributeDiscardButton = arg_2_0.attributeButtons:Find("Discard")

	setText(arg_2_0.equipmentPanel:Find("Attribute/Text"), i18n("spweapon_ui_transform_attr_text"))
	setText(arg_2_0.attributeExchangeButton:Find("Text"), i18n("spweapon_ui_change_attr"))
	setText(arg_2_0.attributeDiscardButton:Find("Text"), i18n("spweapon_ui_keep_attr"))

	arg_2_0.materialItems = CustomIndexLayer.Clone2Full(arg_2_0.materialPanel:Find("materials/materials"), 3)
	arg_2_0.materialLimit = arg_2_0.materialPanel:Find("materials/limit")
	arg_2_0.materialCostText = arg_2_0.materialPanel:Find("cost/consume")
	arg_2_0.materialStartButton = arg_2_0.materialPanel:Find("start_btn")

	setText(arg_2_0.materialPanel:Find("materials/panel_title"), i18n("spweapon_ui_need_resource"))
	setText(arg_2_0.materialStartButton:Find("Image"), i18n("spweapon_ui_transform"))

	return
end

function var_0_0.SetSpweaponVO(arg_3_0, arg_3_1)
	arg_3_0.spWeaponVO = arg_3_1

	return
end

function var_0_0.SetItems(arg_4_0, arg_4_1)
	arg_4_0.itemVOs = arg_4_1

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf:Find("BG"), function()
		arg_5_0:closeView()

		return
	end)
	arg_5_0:UpdateView()
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.ResetMaterialMask(arg_7_0)
	arg_7_0.confirmUpgrade = nil

	return
end

function var_0_0.UpdateView(arg_8_0)
	setText(arg_8_0.equipmentName, arg_8_0.spWeaponVO:GetName())

	local var_8_0 = arg_8_0.spWeaponVO:GetUpgradeConfig()

	table.Foreach(arg_8_0.materialItems, function(arg_9_0, arg_9_1)
		setActive(arg_9_1:Find("Off"), not var_8_0.reset_use_item[arg_9_0])
		setActive(arg_9_1:Find("Icon"), var_8_0.reset_use_item[arg_9_0])

		if var_8_0.reset_use_item[arg_9_0] then
			updateDrop(arg_9_1:Find("Icon"), {
				id = var_8_0.reset_use_item[arg_9_0][1],
				count = var_8_0.reset_use_item[arg_9_0][2],
				type = DROP_TYPE_ITEM
			})

			local var_9_0 = defaultValue(arg_8_0.itemVOs[var_8_0.reset_use_item[arg_9_0][1]], {
				count = 0
			})
			local var_9_1 = var_9_0.count .. "/" .. var_8_0.reset_use_item[arg_9_0][2]

			if var_9_0.count < var_8_0.reset_use_item[arg_9_0][2] then
				var_9_1 = setColorStr(var_9_0.count, COLOR_RED) .. "/" .. var_8_0.reset_use_item[arg_9_0][2]
			end

			setText(arg_9_1:Find("Icon/icon_bg/count"), var_9_1)
			onButton(arg_8_0, arg_9_1:Find("Icon"), function()
				arg_8_0:emit(BaseUI.ON_DROP, var_0)

				return
			end)

			local var_9_2 = arg_9_1:Find("Icon/Click")

			setActive(var_9_2, not arg_8_0.confirmUpgrade)
			onButton(arg_8_0, var_9_2, function()
				arg_8_0.confirmUpgrade = true

				setActive(var_9_2, not arg_8_0.confirmUpgrade)

				return
			end)
		end

		return
	end)
	updateSpWeapon(arg_8_0.equipmentIcon, arg_8_0.spWeaponVO)

	local var_8_1 = arg_8_0.spWeaponVO:GetBaseAttributes()
	local var_8_2 = {
		arg_8_0.spWeaponVO:getConfig("attribute_1"),
		arg_8_0.spWeaponVO:getConfig("attribute_2")
	}
	local var_8_3 = _.any(arg_8_0.spWeaponVO:GetAttributeOptions(), function(arg_12_0)
		return arg_12_0 > 0
	end)

	setActive(arg_8_0.attributeButtons, var_8_3)
	UIItemList.StaticAlign(arg_8_0.attributeList, arg_8_0.attributeList:GetChild(0), #var_8_1, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_13_1 = arg_13_1 + 1

		setText(arg_13_2:Find("Name"), (AttributeType.Type2Name(var_8_2[arg_13_1])))
		setText(arg_13_2:Find("Values/Min/Value"), math.min(1, var_0[arg_13_1]))
		setText(arg_13_2:Find("Values/Max/Value"), var_0[arg_13_1])
		setText(arg_13_2:Find("Values/Current/Value1"), var_8_1[arg_13_1])
		setText(arg_13_2:Find("Values/Current/Value2"), var_0[arg_13_1])
		setActive(arg_13_2:Find("Values/Current/Symbol"), var_8_3)
		setActive(arg_13_2:Find("Values/Current/Value2"), var_8_3)

		return
	end)
	onButton(arg_8_0, arg_8_0.materialStartButton, function()
		if not arg_8_0.confirmUpgrade then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_transform_materal_check"))

			return
		end

		arg_8_0:emit(SpWeaponModifyMediator.ON_REFORGE)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.attributeExchangeButton, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON,
			op = SpWeapon.CONFIRM_OP_EXCHANGE,
			attrs = _.map({
				1,
				2
			}, function(arg_16_0)
				return {
					AttributeType.Type2Name(var_8_2[arg_16_0]),
					var_8_1[arg_16_0],
					var_0[arg_16_0]
				}
			end),
			onYes = function()
				arg_8_0:emit(SpWeaponModifyMediator.ON_CONFIRM_REFORGE, SpWeapon.CONFIRM_OP_EXCHANGE)

				return
			end
		})

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.attributeDiscardButton, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON,
			op = SpWeapon.CONFIRM_OP_DISCARD,
			attrs = _.map({
				1,
				2
			}, function(arg_19_0)
				return {
					AttributeType.Type2Name(var_8_2[arg_19_0]),
					var_8_1[arg_19_0],
					var_0[arg_19_0]
				}
			end),
			onYes = function()
				arg_8_0:emit(SpWeaponModifyMediator.ON_CONFIRM_REFORGE, SpWeapon.CONFIRM_OP_DISCARD)

				return
			end
		})

		return
	end, SFX_CANCEL)
	setGray(arg_8_0.materialStartButton, var_8_3 or table.equal(var_8_1, (arg_8_0.spWeaponVO:GetAttributesRange())))

	return
end

function var_0_0.willExit(arg_21_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf)

	return
end

return var_0_0
