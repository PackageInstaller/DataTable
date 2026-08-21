local var_0_0 = class("EquipmentSkinPanel", import("..base.BasePanel"))
local var_0_1 = 0.2

function var_0_0.init(arg_1_0)
	arg_1_0.equipmentTFs = {
		arg_1_0._tf:Find("equipment_r/skin/equipment_r1"),
		arg_1_0._tf:Find("equipment_r/skin/equipment_r2"),
		arg_1_0._tf:Find("equipment_r/skin/equipment_r3"),
		arg_1_0._tf:Find("equipment_l/skin/equipment_l1"),
		arg_1_0._tf:Find("equipment_l/skin/equipment_l2")
	}
	arg_1_0.equipmentNormalTFs = {
		arg_1_0._tf:Find("equipment_r/equipment/equipment_r1"),
		arg_1_0._tf:Find("equipment_r/equipment/equipment_r2"),
		arg_1_0._tf:Find("equipment_r/equipment/equipment_r3"),
		arg_1_0._tf:Find("equipment_l/equipment/equipment_l1"),
		arg_1_0._tf:Find("equipment_l/equipment/equipment_l2")
	}
	arg_1_0.equipmentR = arg_1_0._tf:Find("equipment_r/equipment")
	arg_1_0.equipmentL = arg_1_0._tf:Find("equipment_l/equipment")
	arg_1_0.skinR = arg_1_0._tf:Find("equipment_r/skin")
	arg_1_0.skinL = arg_1_0._tf:Find("equipment_l/skin")

	setActive(arg_1_0.skinR, not LOCK_EQUIP_SKIN)
	setActive(arg_1_0.skinL, not LOCK_EQUIP_SKIN)

	arg_1_0.infoPanel = arg_1_0.equipmentTFs[1]:Find("info")
	arg_1_0.inSkinPage = true

	return
end

function var_0_0.setLabelResource(arg_2_0, arg_2_1)
	arg_2_0.resource = arg_2_1

	return
end

function var_0_0.doSwitchAnim(arg_3_0, arg_3_1)
	if arg_3_0:isTweening() then
		return
	end

	arg_3_0.inSkinPage = arg_3_1

	arg_3_0:doAnim(arg_3_0.equipmentR, arg_3_0.skinR)
	arg_3_0:doAnim(arg_3_0.equipmentL, arg_3_0.skinL)

	return
end

function var_0_0.isTweening(arg_4_0)
	if LeanTween.isTweening(go(arg_4_0.equipmentR)) or LeanTween.isTweening(go(arg_4_0.skinR)) or LeanTween.isTweening(go(arg_4_0.equipmentL)) or LeanTween.isTweening(go(arg_4_0.skinL)) then
		return true
	end

	return false
end

function var_0_0.doAnim(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetComponent(typeof(CanvasGroup))
	local var_5_1 = arg_5_2:GetComponent(typeof(CanvasGroup))

	LeanTween.moveLocal(go(arg_5_1), arg_5_2.localPosition, var_0_1)
	LeanTween.moveLocal(go(arg_5_2), arg_5_1.localPosition, var_0_1)

	local var_5_2 = 0.8
	local var_5_3 = 1

	if not arg_5_0.inSkinPage then
		var_5_3 = 0.8
		var_5_2 = 1
	end

	LeanTween.alphaCanvas(var_5_0, var_5_3, var_0_1):setFrom(var_5_2)
	LeanTween.value(go(arg_5_2), var_5_3, var_5_2, var_0_1):setOnUpdate(System.Action_float(function(arg_6_0)
		var_5_1.alpha = arg_6_0

		return
	end))

	arg_5_2:GetComponent(typeof(CanvasGroup)).blocksRaycasts = not arg_5_0.inSkinPage
	var_5_0.blocksRaycasts = arg_5_0.inSkinPage

	;(not arg_5_0.inSkinPage and arg_5_2 or arg_5_1):SetAsLastSibling()

	return
end

function var_0_0.updateAll(arg_7_0, arg_7_1)
	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.equipmentTFs) do
			if not not table.contains(ShipEquipView.UNLOCK_EQUIPMENT_SKIN_POS, iter_7_0) then
				arg_7_0:updateEquipmentTF(arg_7_1, iter_7_0)
			end

			local var_7_0 = iter_7_1:Find("shadow")

			if var_7_0 then
				setActive(var_7_0, arg_7_0.inSkinPage)
			end
		end

		for iter_7_2, iter_7_3 in ipairs(arg_7_0.equipmentNormalTFs) do
			local var_7_1 = iter_7_3:Find("shadow")

			if var_7_1 then
				setActive(var_7_1, not arg_7_0.inSkinPage)
			end
		end
	end

	return
end

function var_0_0.updateEquipmentTF(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.shipVO = arg_8_1

	if arg_8_1 then
		removeOnButton(arg_8_0.equipmentTFs[arg_8_2])

		local var_8_0 = arg_8_1:getEquip(arg_8_2)
		local var_8_1 = arg_8_0.equipmentTFs[arg_8_2]:Find("info")

		if IsNil(var_8_1) then
			var_8_1 = cloneTplTo(arg_8_0.infoPanel, arg_8_0.equipmentTFs[arg_8_2], "info")
		end

		local var_8_2 = arg_8_0.equipmentTFs[arg_8_2]:Find("panel_title/type")

		var_8_2:GetComponent(typeof(Image)).sprite = arg_8_0.resource:Find((EquipType.Types2Title(arg_8_2, arg_8_0.shipVO.configId))):GetComponent(typeof(Image)).sprite

		var_8_2:GetComponent(typeof(Image)):SetNativeSize()
		setActive(var_8_1, var_8_0)
		setActive(arg_8_0.equipmentTFs[arg_8_2]:Find("unequip"), not var_8_0)

		if var_8_0 then
			local var_8_3 = var_8_0:canEquipSkin()

			setActive(var_8_1:Find("forbid"), not var_8_3)

			local var_8_4 = var_8_1:Find("equip")

			setActive(var_8_4, var_8_3)

			if var_8_3 then
				arg_8_0:updateEquipmentPanel(var_8_4, arg_8_2)
			end
		end
	end

	return
end

function var_0_0.updateEquipmentPanel(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.shipVO:getEquip(arg_9_2)
	local var_9_1 = var_9_0:hasSkin()
	local var_9_2 = arg_9_1:Find("add")
	local var_9_3 = arg_9_1:Find("info")

	setActive(var_9_3, var_9_1)
	setActive(var_9_2, not var_9_1)

	if var_9_1 then
		arg_9_0:updateSkinInfo(var_9_3, var_9_0.skinId)
		onButton(arg_9_0, arg_9_0.equipmentTFs[arg_9_2], function()
			arg_9_0:emit(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, arg_9_2)

			return
		end, SFX_PANEL)
	else
		onButton(arg_9_0, var_9_2:Find("icon"), function()
			arg_9_0:emit(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, arg_9_2)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateSkinInfo(arg_12_0, arg_12_1, arg_12_2)
	assert(pg.equip_skin_template[arg_12_2], "miss config equip_skin_template >>" .. arg_12_2)
	setText(arg_12_1:Find("desc"), pg.equip_skin_template[arg_12_2].desc)
	setText(arg_12_1:Find("cont/name_mask/name"), pg.equip_skin_template[arg_12_2].name)
	updateDrop(arg_12_1:Find("IconTpl"), {
		type = DROP_TYPE_EQUIPMENT_SKIN,
		id = arg_12_2
	})

	return
end

return var_0_0
