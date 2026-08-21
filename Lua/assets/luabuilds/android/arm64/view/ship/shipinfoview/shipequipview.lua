local var_0_0 = class("ShipEquipView", import("...base.BaseSubView"))

var_0_0.UNLOCK_EQUIPMENT_SKIN_POS = {
	1,
	2,
	3,
	4,
	5
}

function var_0_0.getUIName(arg_1_0)
	return "ShipEquipView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:InitEquipment()

	return
end

function var_0_0.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_0.GetShipVO(arg_4_0)
	if arg_4_0.shareData and arg_4_0.shareData.shipVO then
		return arg_4_0.shareData.shipVO
	end

	return nil
end

function var_0_0.UpdateUI(arg_5_0)
	arg_5_0:UpdateEquipments((arg_5_0:GetShipVO()))

	return
end

function var_0_0.InitEquipment(arg_6_0)
	arg_6_0.mainPanel = arg_6_0._parentTf.parent
	arg_6_0.equipRCon = arg_6_0._parentTf:Find("equipment_r_container")
	arg_6_0.equipLCon = arg_6_0._parentTf:Find("equipment_l_container")
	arg_6_0.equipBCon = arg_6_0._parentTf:Find("equipment_b_container")
	arg_6_0.equipmentR = arg_6_0._tf:Find("equipment_r")
	arg_6_0.equipmentL = arg_6_0._tf:Find("equipment_l")
	arg_6_0.equipmentB = arg_6_0._tf:Find("equipment_b")
	arg_6_0.equipmentR1 = arg_6_0.equipmentR:Find("equipment/equipment_r1")
	arg_6_0.equipmentR2 = arg_6_0.equipmentR:Find("equipment/equipment_r2")
	arg_6_0.equipmentR3 = arg_6_0.equipmentR:Find("equipment/equipment_r3")
	arg_6_0.equipmentL1 = arg_6_0.equipmentL:Find("equipment/equipment_l1")
	arg_6_0.equipmentL2 = arg_6_0.equipmentL:Find("equipment/equipment_l2")
	arg_6_0.equipSkinBtn = arg_6_0.equipmentR:Find("equipment_skin_btn")
	arg_6_0.equipmentB1 = arg_6_0.equipmentB:Find("equipment")
	arg_6_0.resource = arg_6_0._tf:Find("resource")
	arg_6_0.equipSkinLogicPanel = ShipEquipSkinLogicPanel.New(arg_6_0._tf.gameObject)

	arg_6_0.equipSkinLogicPanel:attach(arg_6_0)
	arg_6_0.equipSkinLogicPanel:setLabelResource(arg_6_0.resource)
	setActive(arg_6_0.equipSkinLogicPanel._go, true)
	setParent(arg_6_0.equipmentR, arg_6_0.equipRCon)
	setParent(arg_6_0.equipmentL, arg_6_0.equipLCon)
	setParent(arg_6_0.equipmentB, arg_6_0.equipBCon)
	setActive(arg_6_0.equipmentR, true)
	setActive(arg_6_0.equipmentL, true)
	setActive(arg_6_0.equipmentB, true)
	setActive(arg_6_0.equipSkinBtn, true)

	arg_6_0.equipmentPanels = {
		arg_6_0.equipmentR1,
		arg_6_0.equipmentR2,
		arg_6_0.equipmentR3,
		arg_6_0.equipmentL1,
		arg_6_0.equipmentL2
	}
	arg_6_0.onSelected = false

	return
end

function var_0_0.InitEvent(arg_7_0)
	onButton(arg_7_0, arg_7_0.equipSkinBtn, function()
		local var_8_0, var_8_1 = ShipStatus.ShipStatusCheck("onModify", arg_7_0:GetShipVO())

		if not var_8_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_8_1)

			return
		end

		arg_7_0:switch2EquipmentSkinPage()

		return
	end)

	if arg_7_0.contextData.isInEquipmentSkinPage then
		arg_7_0.contextData.isInEquipmentSkinPage = nil

		triggerButton(arg_7_0.equipSkinBtn)
	end

	return
end

function var_0_0.OnSelected(arg_9_0, arg_9_1)
	if arg_9_1 then
		(function(arg_10_0, arg_10_1)
			eachChild(arg_10_0, function(arg_11_0)
				table.insert(arg_10_1, arg_11_0)

				return
			end)

			return
		end)(arg_9_0.equipmentR:Find("skin"), {})
		;(function(arg_10_0, arg_10_1)
			eachChild(arg_10_0, function(arg_11_0)
				table.insert(arg_10_1, arg_11_0)

				return
			end)

			return
		end)(arg_9_0.equipmentR:Find("equipment"), {})
		;(function(arg_10_0, arg_10_1)
			eachChild(arg_10_0, function(arg_11_0)
				table.insert(arg_10_1, arg_11_0)

				return
			end)

			return
		end)(arg_9_0.equipmentL:Find("skin"), {})
		;(function(arg_10_0, arg_10_1)
			eachChild(arg_10_0, function(arg_11_0)
				table.insert(arg_10_1, arg_11_0)

				return
			end)

			return
		end)(arg_9_0.equipmentL:Find("equipment"), {})
		;(function(arg_10_0, arg_10_1)
			eachChild(arg_10_0, function(arg_11_0)
				table.insert(arg_10_1, arg_11_0)

				return
			end)

			return
		end)(arg_9_0.equipmentB, {})
		table.insert({}, arg_9_0.equipmentL:Find("equipment/equipment_l1"))
		arg_9_0:OverlayPanel(arg_9_0.equipRCon, {
			groupDelta = -1,
			pbList = {},
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
		arg_9_0:OverlayPanel(arg_9_0.equipLCon, {
			groupDelta = -1,
			pbList = {},
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
		arg_9_0:OverlayPanel(arg_9_0.equipBCon, {
			groupDelta = -1,
			pbList = {},
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
	else
		arg_9_0:UnOverlayPanel(arg_9_0.equipRCon, arg_9_0._parentTf)
		arg_9_0:UnOverlayPanel(arg_9_0.equipLCon, arg_9_0._parentTf)
		arg_9_0:UnOverlayPanel(arg_9_0.equipBCon, arg_9_0._parentTf)
	end

	arg_9_0.onSelected = arg_9_1

	return
end

function var_0_0.UpdateEquipments(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getActiveEquipments()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.equipments) do
		arg_12_0:UpdateEquipmentPanel(iter_12_0, iter_12_1, var_12_0[iter_12_0])
	end

	if arg_12_0.equipSkinLogicPanel then
		arg_12_0.equipSkinLogicPanel:updateAll(arg_12_1)
	end

	local var_12_2

	if arg_12_0.contextData.openEquipUpgrade == true then
		arg_12_0.contextData.openEquipUpgrade = false

		local var_12_1 = 0

		for iter_12_2, iter_12_3 in ipairs(arg_12_0:GetShipVO().equipments) do
			if iter_12_3 then
				var_12_1 = var_12_1 + 1
			end
		end

		if var_12_1 > 0 then
			arg_12_0:emit(ShipMainMediator.OPEN_EQUIP_UPGRADE, arg_12_0:GetShipVO().id)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("fightfail_noequip"))

			var_12_2 = arg_12_1:IsSpweaponUnlock() and not LOCK_SP_WEAPON
		end
	end

	setActive(arg_12_0.equipmentB, var_12_2)
	arg_12_0:UpdateSpWeaponPanel((arg_12_1:GetSpWeapon()))

	return
end

function var_0_0.UpdateEquipmentPanel(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0.equipmentPanels[arg_13_1]
	local var_13_1 = findTF(arg_13_0.equipmentPanels[arg_13_1], "info")
	local var_13_2 = findTF(var_13_1, "efficiency")

	setActive(var_13_1, arg_13_2)
	setActive(findTF(arg_13_0.equipmentPanels[arg_13_1], "empty"), not arg_13_2)

	local var_13_3 = arg_13_0:GetShipVO()
	local var_13_4 = {}
	local var_13_5 = var_13_3:GetSpWeapon()

	if var_13_5 then
		for iter_13_0, iter_13_1 in ipairs((var_13_5:GetUpgradableSkillInfo())) do
			if iter_13_1.unlock then
				table.insert({}, var_13_5:GetUpgradableSkillIds()[1][1])

				local var_13_6 = ys.Battle.BattleDataFunction.GetBuffTemplate(iter_13_1.skillId, iter_13_1.lv)

				if var_13_6.shipInfoScene and var_13_6.shipInfoScene.equip then
					for iter_13_2, iter_13_3 in ipairs(var_13_6.shipInfoScene.equip) do
						table.insert(var_13_4, iter_13_3)
					end
				end
			end
		end
	end

	for iter_13_4, iter_13_5 in pairs(var_13_3.skills) do
		if not table.contains({}, iter_13_5.id) then
			local var_13_7 = ys.Battle.BattleDataFunction.GetBuffTemplate(iter_13_5.id, iter_13_5.level)

			if var_13_7.shipInfoScene and var_13_7.shipInfoScene.equip then
				for iter_13_6, iter_13_7 in ipairs(var_13_7.shipInfoScene.equip) do
					table.insert(var_13_4, iter_13_7)
				end
			end
		end
	end

	if var_13_5 and var_13_5:GetEffect() ~= 0 then
		local var_13_8 = ys.Battle.BattleDataFunction.GetBuffTemplate(var_13_5:GetEffect(), 1)

		if var_13_8.shipInfoScene and var_13_8.shipInfoScene.equip then
			for iter_13_8, iter_13_9 in ipairs(var_13_8.shipInfoScene.equip) do
				table.insert(var_13_4, iter_13_9)
			end
		end
	end

	local var_13_9 = findTF(var_13_0, "panel_title/type")
	local var_13_10 = findTF(var_13_0, "skin_icon")

	if var_13_10 then
		setActive(var_13_10, arg_13_2 and arg_13_2:hasSkin())
	end

	var_13_9:GetComponent(typeof(Text)).text = EquipType.LabelToName((EquipType.Types2Title(arg_13_1, var_13_3.configId)))

	if arg_13_2 then
		setActive(var_13_2, not arg_13_2:isDevice())

		if not arg_13_2:isDevice() then
			local var_13_12 = var_13_3:getEquipProficiencyByPos(arg_13_1)

			if var_13_12 then
				local var_13_13 = var_13_12 * 100 or 0
				local var_13_14 = false
				local var_13_15 = var_13_3:getFlag("inWorld")

				var_13_15 = var_13_15 and arg_13_0.contextData.fromMediatorName == WorldMediator.__cname and WorldConst.FetchWorldShip(var_13_3.id):IsBroken()

				if not var_13_15 then
					for iter_13_10, iter_13_11 in ipairs(var_13_4) do
						print(arg_13_0:equipmentCheck(iter_13_11), arg_13_0.equipmentEnhance(iter_13_11, arg_13_2))

						if arg_13_0:equipmentCheck(iter_13_11) and arg_13_0.equipmentEnhance(iter_13_11, arg_13_2) then
							var_13_13 = var_13_13 + iter_13_11.number
							var_13_14 = true
						end
					end
				end

				local var_13_16

				if var_13_13 - calcFloor(var_13_13) > 1e-09 then
					var_13_13 = string.format("%.1f", var_13_13)
					GetComponent(findTF(var_13_2, "Text"), typeof(Text)).fontSize = 45
				else
					GetComponent(findTF(var_13_2, "Text"), typeof(Text)).fontSize = 50
					var_13_16 = var_13_14 and setColorStr(var_13_13 .. "%", COLOR_GREEN) or var_13_13 .. "%"
				end

				setButtonText(var_13_2, var_13_16)
				updateEquipment(var_13_1:Find("IconTpl"), arg_13_2)

				local var_13_17 = arg_13_2:getConfig("name")

				if arg_13_2:getConfig("ammo_icon")[1] then
					setActive(findTF(var_13_1, "cont/icon_ammo"), true)
					setImageSprite(findTF(var_13_1, "cont/icon_ammo"), GetSpriteFromAtlas("ammo", arg_13_2:getConfig("ammo_icon")[1]))
				else
					setActive(findTF(var_13_1, "cont/icon_ammo"), false)
				end

				setScrollText(arg_13_0.equipmentPanels[arg_13_1]:Find("info/cont/name_mask/name"), var_13_17)

				local var_13_18 = var_13_1:Find("attrs")

				eachChild(var_13_18, function(arg_14_0)
					setActive(arg_14_0, false)

					return
				end)

				local var_13_19 = underscore.filter(arg_13_2:GetPropertiesInfo().attrs, function(arg_15_0)
					return not arg_15_0.type or arg_15_0.type ~= AttributeType.AntiSiren
				end)
				local var_13_20 = arg_13_2:getConfig("skill_id")
				local var_13_21 = var_13_20[1] and var_13_20[1][1]

				if var_13_21 and arg_13_2:isDevice() then
					local var_13_22 = {
						1,
						2,
						5
					}

					if not {
						1,
						2,
						5
					} then
						var_13_22 = {
							1,
							4,
							2,
							3
						}
					end

					for iter_13_12, iter_13_13 in ipairs(var_13_22) do
						local var_13_23 = var_13_18:Find("attr_" .. iter_13_13)
						local var_13_24 = findTF(var_13_23, "panel")
						local var_13_25 = findTF(var_13_23, "lock")

						setActive(var_13_23, true)

						if iter_13_13 == 5 then
							setText(var_13_24:Find("values/value"), "")

							local var_13_26 = getSkillName(var_13_21)

							if PLATFORM_CODE == PLATFORM_US and string.len(var_13_26) > 15 then
								GetComponent(var_13_24:Find("values/value_1"), typeof(Text)).fontSize = 24
							end

							setText(var_13_24:Find("values/value_1"), getSkillName(var_13_21))
							setActive(var_13_25, false)
						elseif #var_13_19 > 0 then
							local var_13_27 = table.remove(var_13_19, 1)

							if arg_13_2:isAircraft() and var_13_27.type == AttributeType.CD then
								var_13_27 = var_13_3:getAircraftReloadCD()
							end

							local var_13_28, var_13_29 = Equipment.GetInfoTrans(var_13_27, var_13_3)

							setText(var_13_24:Find("tag"), var_13_28)

							local var_13_30 = string.split(tostring(var_13_29), "/")

							if #var_13_30 >= 2 then
								setText(var_13_24:Find("values/value"), var_13_30[1] .. "/")
								setText(var_13_24:Find("values/value_1"), var_13_30[2])
							else
								setText(var_13_24:Find("values/value"), var_13_29)
								setText(var_13_24:Find("values/value_1"), "")
							end

							setActive(var_13_25, false)
						else
							setText(var_13_24:Find("tag"), "")
							setText(var_13_24:Find("values/value"), "")
							setText(var_13_24:Find("values/value_1"), "")
							setActive(var_13_25, true)
						end
					end

					onButton(arg_13_0, var_13_0, function()
						arg_13_0:emit(BaseUI.ON_EQUIPMENT, {
							type = EquipmentInfoMediator.TYPE_SHIP,
							shipId = var_13_3.id,
							pos = arg_13_1,
							onRemoved = function()
								arg_13_0:setEquipDescVisible(true)

								return
							end
						})
						arg_13_0:setEquipDescVisible(false)

						return
					end, SFX_UI_DOCKYARD_EQUIPADD)

					goto label_13_0

					onButton(arg_13_0, var_13_0, function()
						if var_13_3 then
							local var_18_0, var_18_1 = ShipStatus.ShipStatusCheck("onModify", var_13_3)

							if not var_18_0 then
								pg.TipsMgr.GetInstance():ShowTips(var_18_1)

								return
							end

							arg_13_0:emit(ShipMainMediator.ON_SELECT_EQUIPMENT, arg_13_1)
						end

						return
					end, SFX_UI_DOCKYARD_EQUIPADD)

					::label_13_0::

					return
				end
			end
		end
	end
end

function var_0_0.setEquipDescVisible(arg_19_0, arg_19_1)
	if not arg_19_0.equipmentPanels then
		return
	end

	for iter_19_0 = 1, #arg_19_0.equipmentPanels do
		if arg_19_0.equipmentPanels[iter_19_0] then
			local var_19_0 = GetComponent(arg_19_0.equipmentPanels[iter_19_0]:Find("info/cont/name_mask/name"), typeof(ScrollText))

			if var_19_0 then
				var_19_0:SetVisible(arg_19_1)
			end
		end
	end

	return
end

function var_0_0.equipmentCheck(arg_20_0, arg_20_1)
	if not arg_20_0:GetShipVO() then
		return false
	end

	local var_20_0 = arg_20_1.check_type

	if not arg_20_1.check_type and not arg_20_1.check_indexList and not arg_20_1.check_label then
		return true
	end

	local var_20_3 = Clone(arg_20_0:GetShipVO().equipments)

	if arg_20_1.check_indexList then
		local var_20_4 = #var_20_3

		while var_20_4 > 0 do
			if not table.contains(arg_20_1.check_indexList, var_20_4) then
				table.remove(var_20_3, var_20_4)
			end

			var_20_4 = var_20_4 - 1
		end
	end

	if var_20_0 then
		local var_20_5 = #var_20_3

		while var_20_5 > 0 do
			if not var_20_3[var_20_5] or not table.contains(var_20_0, var_20_3[var_20_5]:getConfig("type")) then
				table.remove(var_20_3, var_20_5)
			end

			var_20_5 = var_20_5 - 1
		end
	end

	if arg_20_1.check_label then
		local var_20_6 = #var_20_3

		while var_20_6 > 0 do
			if var_20_3[var_20_6] then
				local var_20_7 = 1

				for iter_20_0, iter_20_1 in ipairs(arg_20_1.check_label) do
					if not table.contains(var_20_3[var_20_6]:getConfig("label"), iter_20_1) then
						var_20_7 = var_20_7 * 0
					end
				end

				if var_20_7 == 0 then
					table.remove(var_20_3, var_20_6)
				end
			else
				table.remove(var_20_3, var_20_6)
			end

			var_20_6 = var_20_6 - 1
		end
	end

	return #var_20_3 > 0
end

function var_0_0.equipmentEnhance(arg_21_0, arg_21_1)
	local var_21_0 = 1
	local var_21_1 = arg_21_1:getConfig("label")

	if arg_21_0.label then
		var_21_0 = 1

		for iter_21_0, iter_21_1 in ipairs(arg_21_0.label) do
			if not table.contains(var_21_1, iter_21_1) then
				var_21_0 = 0

				break
			end
		end
	end

	return var_21_0 == 1
end

function var_0_0.UpdateSpWeaponPanel(arg_22_0, arg_22_1)
	local var_22_0 = findTF(arg_22_0.equipmentB1, "info")

	setActive(var_22_0, arg_22_1)
	setActive(findTF(arg_22_0.equipmentB1, "empty"), not arg_22_1)

	local var_22_1 = arg_22_0:GetShipVO()

	assert(var_22_1)

	if arg_22_1 then
		UpdateSpWeaponSlot(var_22_0, arg_22_1, {
			20,
			20,
			20,
			20
		})

		local var_22_2 = var_22_0:Find("attrs")

		eachChild(var_22_2, function(arg_23_0)
			setActive(arg_23_0, false)

			return
		end)

		local var_22_3 = underscore.filter(arg_22_1:GetPropertiesInfo().attrs, function(arg_24_0)
			return not arg_24_0.type or arg_24_0.type ~= AttributeType.AntiSiren
		end)

		for iter_22_0 = 1, 2 do
			local var_22_4 = var_22_2:GetChild(iter_22_0 - 1)

			setActive(var_22_4, true)

			if #var_22_3 > 0 then
				local var_22_5, var_22_6 = Equipment.GetInfoTrans(table.remove(var_22_3, 1), var_22_1)

				setText(var_22_4:Find("tag"), var_22_5)
				setText(var_22_4:Find("values/value"), var_22_6)
				setText(var_22_4:Find("values/value_1"), "")
			end
		end

		Canvas.ForceUpdateCanvases()

		local var_22_7 = var_22_0:Find("cont")

		;(function()
			local var_25_0 = var_22_7:GetChild(0)

			setText(var_25_0:Find("tag"), i18n("spweapon_ui_effect_tag"))

			local var_25_1 = arg_22_1:GetEffect()

			setActive(var_25_0, var_25_1 and var_25_1 > 0)

			if not var_25_1 or var_25_1 <= 0 then
				return
			end

			setScrollText(var_25_0:Find("value/Text"), getSkillName(var_25_1))

			return
		end)()

		local var_22_8 = arg_22_1:GetActiveUpgradableSkillList(var_22_1)

		if #var_22_8 == 0 then
			setActive(var_22_0:Find("cont"):GetChild(1), false)
		else
			(function(arg_26_0)
				local var_26_0 = var_22_7:GetChild(1)

				setText(var_26_0:Find("tag"), i18n("spweapon_ui_skill_tag"))
				setActive(var_26_0, arg_26_0 and arg_26_0 > 0)

				if not arg_26_0 or arg_26_0 <= 0 then
					return
				end

				setScrollText(var_26_0:Find("value/Text"), getSkillName(arg_26_0))

				return
			end)(var_22_8[1].mapSkillID)
		end

		onButton(arg_22_0, arg_22_0.equipmentB1, function()
			arg_22_0:emit(BaseUI.ON_SPWEAPON, {
				type = SpWeaponInfoLayer.TYPE_SHIP,
				shipId = var_22_1.id,
				onRemoved = function()
					arg_22_0:setEquipDescVisible(true)

					return
				end
			})
			arg_22_0:setEquipDescVisible(false)

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	else
		onButton(arg_22_0, arg_22_0.equipmentB1, function()
			if var_22_1 then
				local var_29_0, var_29_1 = ShipStatus.ShipStatusCheck("onModify", var_22_1)

				if not var_29_0 then
					pg.TipsMgr.GetInstance():ShowTips(var_29_1)

					return
				end

				arg_22_0:emit(ShipMainMediator.ON_SELECT_SPWEAPON)
			end

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	end

	return
end

function var_0_0.switch2EquipmentSkinPage(arg_30_0)
	if arg_30_0.equipSkinLogicPanel:isTweening() then
		return
	end

	arg_30_0.equipSkinLogicPanel:doSwitchAnim(arg_30_0.contextData.isInEquipmentSkinPage)

	arg_30_0.contextData.isInEquipmentSkinPage = not arg_30_0.contextData.isInEquipmentSkinPage

	setActive(arg_30_0.equipSkinBtn:Find("unsel"), not arg_30_0.contextData.isInEquipmentSkinPage)
	setActive(arg_30_0.equipSkinBtn:Find("sel"), arg_30_0.contextData.isInEquipmentSkinPage)
	arg_30_0.equipSkinLogicPanel:updateAll(arg_30_0:GetShipVO())

	return
end

function var_0_0.OnDestroy(arg_31_0)
	setParent(arg_31_0.equipmentR, arg_31_0._tf)
	setParent(arg_31_0.equipmentL, arg_31_0._tf)
	setParent(arg_31_0.equipmentB, arg_31_0._tf)

	arg_31_0.shareData = nil

	return
end

return var_0_0
