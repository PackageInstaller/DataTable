class = var_0_10000

local var_0_0 = "EquipmentSkinPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BasePanel"))
local var_0_2 = 0.2

function var_0_1.init(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = arg_1_0._tf

	var_1_0[1] = var_2.Find(var_1_1, "equipment_r/skin/equipment_r1")

	local var_1_2 = arg_1_0._tf

	var_1_0[2] = var_2.Find(var_1_2, "equipment_r/skin/equipment_r2")

	local var_1_3 = arg_1_0._tf

	var_1_0[3] = var_2.Find(var_1_3, "equipment_r/skin/equipment_r3")

	local var_1_4 = arg_1_0._tf

	var_1_0[4] = var_2.Find(var_1_4, "equipment_l/skin/equipment_l1")

	local var_1_5 = arg_1_0._tf

	var_1_0[5] = var_2.Find(var_1_5, "equipment_l/skin/equipment_l2")
	arg_1_0.equipmentTFs = var_1_0

	local var_1_6 = {}
	local var_1_7 = arg_1_0._tf

	var_1_6[1] = var_2.Find(var_1_7, "equipment_r/equipment/equipment_r1")

	local var_1_8 = arg_1_0._tf

	var_1_6[2] = var_2.Find(var_1_8, "equipment_r/equipment/equipment_r2")

	local var_1_9 = arg_1_0._tf

	var_1_6[3] = var_2.Find(var_1_9, "equipment_r/equipment/equipment_r3")

	local var_1_10 = arg_1_0._tf

	var_1_6[4] = var_2.Find(var_1_10, "equipment_l/equipment/equipment_l1")

	local var_1_11 = arg_1_0._tf

	var_1_6[5] = var_2.Find(var_1_11, "equipment_l/equipment/equipment_l2")
	arg_1_0.equipmentNormalTFs = var_1_6

	local var_1_12 = arg_1_0._tf

	arg_1_0.equipmentR = var_1.Find(var_1_12, "equipment_r/equipment")

	local var_1_13 = arg_1_0._tf

	arg_1_0.equipmentL = var_1.Find(var_1_13, "equipment_l/equipment")

	local var_1_14 = arg_1_0._tf

	arg_1_0.skinR = var_1.Find(var_1_14, "equipment_r/skin")

	local var_1_15 = arg_1_0._tf

	arg_1_0.skinL = var_1.Find(var_1_15, "equipment_l/skin")
	setActive = var_1

	local var_1_16 = arg_1_0.skinR

	LOCK_EQUIP_SKIN = var_3

	var_1(var_1_16, not var_3)

	setActive = var_1

	local var_1_17 = arg_1_0.skinL

	LOCK_EQUIP_SKIN = var_3

	var_1(var_1_17, not var_3)

	local var_1_18 = arg_1_0.equipmentTFs[1]

	arg_1_0.infoPanel = var_1.Find(var_1_18, "info")
	arg_1_0.inSkinPage = true

	return
end

function var_0_1.setLabelResource(arg_2_0, arg_2_1)
	arg_2_0.resource = arg_2_1

	return
end

function var_0_1.doSwitchAnim(arg_3_0, arg_3_1)
	if arg_3_0:isTweening() then
		return
	end

	arg_3_0.inSkinPage = arg_3_1

	arg_3_0:doAnim(arg_3_0.equipmentR, arg_3_0.skinR)
	arg_3_0:doAnim(arg_3_0.equipmentL, arg_3_0.skinL)

	return
end

function var_0_1.isTweening(arg_4_0)
	LeanTween = var_1_10001

	local var_4_0 = var_1_10001.isTweening

	go = var_1_10002

	if not var_4_0(var_1_10002(arg_4_0.equipmentR)) then
		LeanTween = var_1

		local var_4_1 = var_1.isTweening

		go = var_2

		if not var_4_1(var_2(arg_4_0.skinR)) then
			LeanTween = var_1

			local var_4_2 = var_1.isTweening

			go = var_2

			if not var_4_2(var_2(arg_4_0.equipmentL)) then
				LeanTween = var_1

				local var_4_3 = var_1.isTweening

				go = var_2

				if var_4_3(var_2(arg_4_0.skinL)) then
					return true
				end

				return false
			end
		end
	end
end

function var_0_1.doAnim(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2.localPosition
	local var_5_1 = arg_5_1.localPosition
	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.GetComponent

	typeof = var_1_10007
	CanvasGroup = var_1_10008

	local var_5_4 = var_5_3(var_5_2, var_1_10007(var_1_10008))
	local var_5_5 = arg_5_2
	local var_5_6 = arg_5_2.GetComponent

	typeof = var_1_10008
	CanvasGroup = var_1_10009

	local var_5_7 = var_5_6(var_5_5, var_1_10008(var_1_10009))

	LeanTween = var_5_5

	local var_5_8 = var_5_5.moveLocal

	go = var_8

	var_5_8(var_8(arg_5_1), var_5_0, var_0_2)

	LeanTween = var_5_8

	local var_5_9 = var_5_8.moveLocal

	go = var_8

	var_5_9(var_8(arg_5_2), var_5_1, var_0_2)

	local var_5_10 = 0.8
	local var_5_11 = 1
	local var_5_12

	if not arg_5_0.inSkinPage then
		var_5_12 = 1
		var_5_11 = 0.8
		var_5_10 = var_5_12
	end

	LeanTween = var_5_12

	local var_5_13 = var_5_12.alphaCanvas(var_5_4, var_5_11, var_0_2)

	var_9.setFrom(var_5_13, var_5_10)

	LeanTween = var_9

	local var_5_14 = var_9.value

	go = var_5_13

	local var_5_15 = var_5_14(var_5_13(arg_5_2), var_5_11, var_5_10, var_0_2)
	local var_5_16 = var_9.setOnUpdate

	System = var_11

	var_5_16(var_5_15, var_11.Action_float(function(arg_6_0)
		var_5_7.alpha = arg_6_0

		return
	end))

	var_5_7.blocksRaycasts = not arg_5_0.inSkinPage
	var_5_4.blocksRaycasts = arg_5_0.inSkinPage

	local var_5_17 = not arg_5_0.inSkinPage and arg_5_2 or arg_5_1

	var_9.SetAsLastSibling(var_5_17)

	return
end

function var_0_1.updateAll(arg_7_0, arg_7_1)
	if arg_7_1 then
		ipairs = var_1_10002

		for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.equipmentTFs) do
			table = var_1_10007
			var_1_10007 = var_1_10007.contains
			ShipEquipView = var_1_10008

			if not not var_1_10007(var_1_10008.UNLOCK_EQUIPMENT_SKIN_POS, iter_7_0) then
				arg_7_0:updateEquipmentTF(arg_7_1, iter_7_0)
			end

			local var_7_0 = iter_7_1

			if iter_7_1.Find(var_7_0, "shadow") then
				setActive = var_7_0

				var_7_0(var_1_10008, arg_7_0.inSkinPage)
			end
		end

		ipairs = var_2

		for iter_7_2, iter_7_3 in var_2(arg_7_0.equipmentNormalTFs) do
			local var_7_1 = iter_7_3

			if iter_7_3.Find(var_7_1, "shadow") then
				setActive = var_7_1

				var_7_1(var_7, not arg_7_0.inSkinPage)
			end
		end
	end

	return
end

function var_0_1.updateEquipmentTF(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.shipVO = arg_8_1

	if arg_8_1 then
		local var_8_0 = arg_8_0.equipmentTFs[arg_8_2]

		removeOnButton = var_1_10004

		var_1_10004(var_8_0)

		local var_8_1 = arg_8_1:getEquip(arg_8_2)
		local var_8_2 = var_8_0
		local var_8_3 = var_8_0.Find(var_8_2, "info")

		IsNil = var_8_2

		if var_8_2(var_8_3) then
			cloneTplTo = var_6
			var_8_3 = var_6(arg_8_0.infoPanel, var_8_0, "info")
		end

		local var_8_4 = var_8_0
		local var_8_5 = var_8_0.Find(var_8_4, "panel_title/type")

		EquipType = var_8_4

		local var_8_6 = var_8_4.Types2Title(arg_8_2, arg_8_0.shipVO.configId)
		local var_8_7 = arg_8_0.resource
		local var_8_8 = var_8.Find(var_8_7, var_8_6)
		local var_8_9 = var_8.GetComponent

		typeof = var_10
		Image = var_1_10011

		local var_8_10 = var_8_9(var_8_8, var_10(var_1_10011)).sprite
		local var_8_11 = var_8_5
		local var_8_12 = var_8_5.GetComponent

		typeof = var_1_10011
		Image = var_1_10012
		var_8_12(var_8_11, var_1_10011(var_1_10012)).sprite = var_8_10

		local var_8_13 = var_8_5
		local var_8_14 = var_8_5.GetComponent

		typeof = var_11
		Image = var_1_10012

		local var_8_15 = var_8_14(var_8_13, var_11(var_1_10012))

		var_9.SetNativeSize(var_8_15)

		setActive = var_9

		var_9(var_8_3, var_8_1)

		setActive = var_9

		var_9(var_8_0:Find("unequip"), not var_8_1)

		if var_8_1 then
			local var_8_16 = var_8_1
			local var_8_17 = var_8_1.canEquipSkin(var_8_16)

			setActive = var_8_16

			var_8_16(var_8_3:Find("forbid"), not var_8_17)

			local var_8_18 = var_8_3
			local var_8_19 = var_8_3.Find(var_8_18, "equip")

			setActive = var_8_18

			var_8_18(var_8_19, var_8_17)

			if var_8_17 then
				arg_8_0:updateEquipmentPanel(var_8_19, arg_8_2)
			end
		end
	end

	return
end

function var_0_1.updateEquipmentPanel(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.shipVO
	local var_9_1 = var_3.getEquip(var_9_0, arg_9_2).skinId
	local var_9_2 = var_3:hasSkin()
	local var_9_3 = arg_9_1:Find("add")
	local var_9_4 = arg_9_1
	local var_9_5 = arg_9_1.Find(var_9_4, "info")

	setActive = var_9_4

	var_9_4(var_9_5, var_9_2)

	setActive = var_9_4

	var_9_4(var_9_3, not var_9_2)

	if var_9_2 then
		arg_9_0:updateSkinInfo(var_9_5, var_9_1)

		onButton = var_9_4

		local var_9_6 = arg_9_0
		local var_9_7 = arg_9_0.equipmentTFs[arg_9_2]

		local function var_9_8()
			local var_10_0 = arg_9_0
			local var_10_1 = var_0.emit

			ShipMainMediator = var_2_10002

			var_10_1(var_10_0, var_2_10002.ON_SELECT_EQUIPMENT_SKIN, arg_9_2)

			return
		end

		SFX_PANEL = var_1_10012

		var_9_4(var_9_6, var_9_7, var_9_8, var_1_10012)
	else
		onButton = var_9_4

		local var_9_9 = arg_9_0
		local var_9_10 = var_9_3:Find("icon")

		local function var_9_11()
			local var_11_0 = arg_9_0
			local var_11_1 = var_0.emit

			ShipMainMediator = var_2_10002

			var_11_1(var_11_0, var_2_10002.ON_SELECT_EQUIPMENT_SKIN, arg_9_2)

			return
		end

		SFX_PANEL = var_12

		var_9_4(var_9_9, var_9_10, var_9_11, var_12)
	end

	return
end

function var_0_1.updateSkinInfo(arg_12_0, arg_12_1, arg_12_2)
	pg = var_1_10003

	local var_12_0 = var_1_10003.equip_skin_template[arg_12_2]

	assert = var_1_10004

	var_1_10004(var_12_0, "miss config equip_skin_template >>" .. arg_12_2)

	setText = var_1_10004

	var_1_10004(arg_12_1:Find("desc"), var_12_0.desc)

	setText = var_1_10004

	var_1_10004(arg_12_1:Find("cont/name_mask/name"), var_12_0.name)

	updateDrop = var_1_10004

	local var_12_1 = arg_12_1:Find("IconTpl")
	local var_12_2 = {}

	DROP_TYPE_EQUIPMENT_SKIN = var_7
	var_12_2.type = var_7
	var_12_2.id = arg_12_2

	var_1_10004(var_12_1, var_12_2)

	return
end

return var_0_1
