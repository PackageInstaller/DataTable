local var_0_0 = class("ShipEquipSkinLogicPanel", import("...base.BasePanel"))
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
	arg_1_0.spweaponNormalTF = arg_1_0._tf:Find("equipment_b/equipment")
	arg_1_0.equipmentR = arg_1_0._tf:Find("equipment_r/equipment")
	arg_1_0.equipmentL = arg_1_0._tf:Find("equipment_l/equipment")
	arg_1_0.skinR = arg_1_0._tf:Find("equipment_r/skin")
	arg_1_0.skinL = arg_1_0._tf:Find("equipment_l/skin")
	arg_1_0.infoPanel = arg_1_0.equipmentTFs[1]:Find("info")
	arg_1_0.inSkinPage = true

	for iter_1_0 = 1, 3 do
		setText(findTF(arg_1_0.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/info/unMatch/txt"), i18n("equipskin_typewrong"))
		setText(findTF(arg_1_0.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/info/unMatch/forbid_en"), i18n("equipskin_typewrong_en"))
		setText(findTF(arg_1_0.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/add/Text"), i18n("equipskin_add"))
		setText(findTF(arg_1_0.skinR, "equipment_r" .. iter_1_0 .. "/info/forbid"), i18n("equipskin_none"))
	end

	for iter_1_1 = 1, 2 do
		if IsNil((arg_1_0.equipmentTFs[3 + iter_1_1]:Find("info"))) then
			local var_1_0 = cloneTplTo(arg_1_0.infoPanel, arg_1_0.equipmentTFs[3 + iter_1_1], "info")
		end

		setActive(findTF(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/forbid"), false)
		setText(findTF(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/info/unMatch/txt"), i18n("equipskin_typewrong"))
		setText(findTF(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/info/unMatch/forbid_en"), i18n("equipskin_typewrong_en"))
		setText(findTF(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/add/Text"), i18n("equipskin_add"))
		setText(findTF(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/info/forbid"), i18n("equipskin_none"))
	end

	for iter_1_2 = 1, #arg_1_0.equipmentNormalTFs do
		setText(findTF(arg_1_0.equipmentNormalTFs[iter_1_2], "empty/tip"), i18n("equip_add"))
	end

	setText(findTF(arg_1_0.spweaponNormalTF, "empty/tip"), i18n("equip_add"))

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

	LeanTween.value(go(arg_5_1), var_5_2, var_5_3, var_0_1):setOnUpdate(System.Action_float(function(arg_6_0)
		var_5_0.alpha = arg_6_0

		return
	end))
	LeanTween.value(go(arg_5_2), var_5_3, var_5_2, var_0_1):setOnUpdate(System.Action_float(function(arg_7_0)
		var_5_1.alpha = arg_7_0

		return
	end))

	arg_5_2:GetComponent(typeof(CanvasGroup)).blocksRaycasts = not arg_5_0.inSkinPage
	arg_5_1:GetComponent(typeof(CanvasGroup)).blocksRaycasts = arg_5_0.inSkinPage

	;(not arg_5_0.inSkinPage and arg_5_2 or arg_5_1):SetAsLastSibling()

	return
end

function var_0_0.updateAll(arg_8_0, arg_8_1)
	if arg_8_1 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.equipmentTFs) do
			if not not table.contains(ShipEquipView.UNLOCK_EQUIPMENT_SKIN_POS, iter_8_0) then
				arg_8_0:updateEquipmentTF(arg_8_1, iter_8_0)
			end

			local var_8_0 = iter_8_1:Find("shadow")

			if var_8_0 then
				setActive(var_8_0, arg_8_0.inSkinPage)
			end
		end

		for iter_8_2, iter_8_3 in ipairs(arg_8_0.equipmentNormalTFs) do
			local var_8_1 = iter_8_3:Find("shadow")

			if var_8_1 then
				setActive(var_8_1, not arg_8_0.inSkinPage)
			end
		end
	end

	return
end

function var_0_0.updateEquipmentTF(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.shipVO = arg_9_1

	if arg_9_1 then
		removeOnButton(arg_9_0.equipmentTFs[arg_9_2])

		local var_9_0 = arg_9_1:getEquip(arg_9_2)
		local var_9_1 = arg_9_1:getEquipSkin(arg_9_2)
		local var_9_2 = arg_9_0.equipmentTFs[arg_9_2]:Find("info")

		if IsNil(var_9_2) then
			var_9_2 = cloneTplTo(arg_9_0.infoPanel, arg_9_0.equipmentTFs[arg_9_2], "info")
		end

		local var_9_3 = arg_9_0.equipmentTFs[arg_9_2]:Find("panel_title/type")

		var_9_3:GetComponent(typeof(Text)).text = EquipType.LabelToName((EquipType.Types2Title(arg_9_2, arg_9_0.shipVO.configId)))

		setActive(arg_9_0.equipmentTFs[arg_9_2]:Find("unequip"), false)

		local var_9_4 = arg_9_1:getCanEquipSkin(arg_9_2)

		setActive(var_9_2:Find("forbid"), not var_9_4)

		local var_9_5 = var_9_2:Find("equip")

		setActive(var_9_5, var_9_4)

		if var_9_4 then
			arg_9_0:updateEquipmentPanel(var_9_5, arg_9_2)
		end
	end

	return
end

function var_0_0.updateEquipmentPanel(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.shipVO:getCanEquipSkin(arg_10_2) then
		return
	end

	local var_10_0 = arg_10_0.shipVO:getEquipSkin(arg_10_2) ~= 0
	local var_10_1 = arg_10_0.shipVO:getEquip(arg_10_2)
	local var_10_2 = arg_10_0.shipVO:getEquipSkin(arg_10_2)
	local var_10_3 = false

	if var_10_2 ~= 0 then
		if var_10_1 then
			if not table.contains(pg.equip_skin_template[var_10_2].equip_type, (var_10_1:getType())) then
				var_10_3 = true
			end
		else
			var_10_3 = true
		end
	end

	local var_10_4 = arg_10_1:Find("add")
	local var_10_5 = arg_10_1:Find("info")

	setActive(var_10_5, var_10_0)
	setActive(var_10_4, not var_10_0)
	setActive(var_10_5:Find("unMatch"), var_10_3)
	setActive(var_10_5:Find("desc"), not var_10_3)

	if var_10_0 then
		arg_10_0:updateSkinInfo(var_10_5, var_10_2)
		onButton(arg_10_0, arg_10_0.equipmentTFs[arg_10_2], function()
			arg_10_0:emit(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, arg_10_2)

			return
		end, SFX_PANEL)
	else
		onButton(arg_10_0, var_10_4:Find("icon"), function()
			arg_10_0:emit(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, arg_10_2)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateSkinInfo(arg_13_0, arg_13_1, arg_13_2)
	assert(pg.equip_skin_template[arg_13_2], "miss config equip_skin_template >>" .. arg_13_2)
	setText(arg_13_1:Find("desc"), pg.equip_skin_template[arg_13_2].desc)
	setText(arg_13_1:Find("cont/name_mask/name"), shortenString(pg.equip_skin_template[arg_13_2].name, 10))
	updateDrop(arg_13_1:Find("IconTpl"), {
		type = DROP_TYPE_EQUIPMENT_SKIN,
		id = arg_13_2
	})

	return
end

return var_0_0
