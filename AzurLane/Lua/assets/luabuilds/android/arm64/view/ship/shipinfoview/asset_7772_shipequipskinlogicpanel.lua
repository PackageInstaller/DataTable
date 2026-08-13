class = var_0_10000

local var_0_0 = "ShipEquipSkinLogicPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BasePanel"))
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

	arg_1_0.spweaponNormalTF = var_1.Find(var_1_12, "equipment_b/equipment")

	local var_1_13 = arg_1_0._tf

	arg_1_0.equipmentR = var_1.Find(var_1_13, "equipment_r/equipment")

	local var_1_14 = arg_1_0._tf

	arg_1_0.equipmentL = var_1.Find(var_1_14, "equipment_l/equipment")

	local var_1_15 = arg_1_0._tf

	arg_1_0.skinR = var_1.Find(var_1_15, "equipment_r/skin")

	local var_1_16 = arg_1_0._tf

	arg_1_0.skinL = var_1.Find(var_1_16, "equipment_l/skin")

	local var_1_17 = arg_1_0.equipmentTFs[1]

	arg_1_0.infoPanel = var_1.Find(var_1_17, "info")
	arg_1_0.inSkinPage = true

	for iter_1_0 = 1, 3 do
		findTF = var_1_18

		local var_1_18 = var_1_18(arg_1_0.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/info/unMatch/txt")

		setText = var_1_10006

		local var_1_19 = var_1_18

		i18n = var_1_10009

		var_1_10006(var_1_19, var_1_10009("equipskin_typewrong"))

		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_1_0.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/info/unMatch/forbid_en")
		setText = var_1_10007
		var_1_10009 = var_1_10006
		i18n = var_10

		var_1_10007(var_1_10009, var_10("equipskin_typewrong_en"))

		findTF = var_1_10007
		var_1_10007 = var_1_10007(arg_1_0.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/add/Text")
		setText = var_8

		local var_1_20 = var_1_10007

		i18n = var_11

		var_8(var_1_20, var_11("equipskin_add"))

		findTF = var_8

		local var_1_21

		var_1_21, setText = var_8(arg_1_0.skinR, "equipment_r" .. iter_1_0 .. "/info/forbid"), var_1_10009
		i18n = var_12

		var_1_10009(var_1_21, var_12("equipskin_none"))
	end

	for iter_1_1 = 1, 2 do
		local var_1_22 = arg_1_0.equipmentTFs[3 + iter_1_1]

		var_1_10006 = var_1_18.Find(var_1_22, "info")
		IsNil = var_1_10007

		if var_1_10007(var_1_10006) then
			cloneTplTo = var_1_10007
			var_1_10006 = var_1_10007(arg_1_0.infoPanel, var_1_18, "info")
		end

		findTF = var_1_10007
		var_1_10007 = var_1_10007(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/forbid")
		setActive = var_1_22

		var_1_22(var_1_10007, false)

		findTF = var_1_22

		local var_1_23

		var_1_23, setText = var_1_22(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/info/unMatch/txt"), var_1_10009
		i18n = var_12

		var_1_10009(var_1_23, var_12("equipskin_typewrong"))

		findTF = var_1_10009
		var_1_10009 = var_1_10009(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/info/unMatch/forbid_en")
		setText = var_10

		local var_1_24 = var_1_10009

		i18n = var_13

		var_10(var_1_24, var_13("equipskin_typewrong_en"))

		findTF = var_10

		local var_1_25

		var_1_25, setText = var_10(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/add/Text"), var_11
		i18n = var_14

		var_11(var_1_25, var_14("equipskin_add"))

		findTF = var_11

		local var_1_26

		var_1_26, setText = var_11(arg_1_0.skinL, "equipment_l" .. iter_1_1 .. "/info/forbid"), var_12
		i18n = var_15

		var_12(var_1_26, var_15("equipskin_none"))
	end

	for iter_1_2 = 1, #arg_1_0.equipmentNormalTFs do
		findTF = var_1_18
		var_1_18 = var_1_18(arg_1_0.equipmentNormalTFs[iter_1_2], "empty/tip")
		setText = var_1_10006

		local var_1_27 = var_1_18

		i18n = var_1_10009

		var_1_10006(var_1_27, var_1_10009("equip_add"))
	end

	findTF = var_1

	local var_1_28

	var_1_28, setText = var_1(arg_1_0.spweaponNormalTF, "empty/tip"), var_2
	i18n = var_1_18

	var_2(var_1_28, var_1_18("equip_add"))

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

	go = var_1_10003

	if not var_4_0(var_1_10003(arg_4_0.equipmentR)) then
		LeanTween = var_1

		local var_4_1 = var_1.isTweening

		go = var_3

		if not var_4_1(var_3(arg_4_0.skinR)) then
			LeanTween = var_1

			local var_4_2 = var_1.isTweening

			go = var_3

			if not var_4_2(var_3(arg_4_0.equipmentL)) then
				LeanTween = var_1

				local var_4_3 = var_1.isTweening

				go = var_3

				if var_4_3(var_3(arg_4_0.skinL)) then
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

	typeof = var_1_10008
	CanvasGroup = var_1_10010

	local var_5_4 = var_5_3(var_5_2, var_1_10008(var_1_10010))
	local var_5_5 = arg_5_2
	local var_5_6 = arg_5_2.GetComponent

	typeof = var_1_10009
	CanvasGroup = var_1_10011

	local var_5_7 = var_5_6(var_5_5, var_1_10009(var_1_10011))

	LeanTween = var_5_2

	local var_5_8 = var_5_2.moveLocal

	go = var_9

	var_5_8(var_9(arg_5_1), var_5_0, var_0_2)

	LeanTween = var_5_8

	local var_5_9 = var_5_8.moveLocal

	go = var_9

	var_5_9(var_9(arg_5_2), var_5_1, var_0_2)

	local var_5_10 = 0.8
	local var_5_11 = 1
	local var_5_12

	if not arg_5_0.inSkinPage then
		var_5_12 = 1
		var_5_11 = 0.8
		var_5_10 = var_5_12
	end

	LeanTween = var_5_12

	local var_5_13 = var_5_12.value

	go = var_11

	local var_5_14 = var_5_13(var_11(arg_5_1), var_5_10, var_5_11, var_0_2)
	local var_5_15 = var_9.setOnUpdate

	System = var_12

	var_5_15(var_5_14, var_12.Action_float(function(arg_6_0)
		var_5_4.alpha = arg_6_0

		return
	end))

	LeanTween = var_5_15

	local var_5_16 = var_5_15.value

	go = var_5_14

	local var_5_17 = var_5_16(var_5_14(arg_5_2), var_5_11, var_5_10, var_0_2)
	local var_5_18 = var_9.setOnUpdate

	System = var_12

	var_5_18(var_5_17, var_12.Action_float(function(arg_7_0)
		var_5_7.alpha = arg_7_0

		return
	end))

	var_5_7.blocksRaycasts = not arg_5_0.inSkinPage
	var_5_4.blocksRaycasts = arg_5_0.inSkinPage

	local var_5_19 = not arg_5_0.inSkinPage and arg_5_2 or arg_5_1

	var_9.SetAsLastSibling(var_5_19)

	return
end

function var_0_1.updateAll(arg_8_0, arg_8_1)
	if arg_8_1 then
		ipairs = var_1_10002

		for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.equipmentTFs) do
			table = var_1_10007
			var_1_10007 = var_1_10007.contains
			ShipEquipView = var_1_10009

			if not not var_1_10007(var_1_10009.UNLOCK_EQUIPMENT_SKIN_POS, iter_8_0) then
				arg_8_0:updateEquipmentTF(arg_8_1, iter_8_0)
			end

			if iter_8_1:Find("shadow") then
				setActive = var_1_10009

				var_1_10009(var_1_10008, arg_8_0.inSkinPage)
			end
		end

		ipairs = var_2

		for iter_8_2, iter_8_3 in var_2(arg_8_0.equipmentNormalTFs) do
			if iter_8_3:Find("shadow") then
				setActive = var_1_10008

				var_1_10008(var_7, not arg_8_0.inSkinPage)
			end
		end
	end

	return
end

function var_0_1.updateEquipmentTF(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.shipVO = arg_9_1

	if arg_9_1 then
		local var_9_0 = arg_9_0.equipmentTFs[arg_9_2]

		removeOnButton = var_1_10004

		var_1_10004(var_9_0)

		local var_9_1 = arg_9_1:getEquip(arg_9_2)
		local var_9_2 = arg_9_1
		local var_9_3 = arg_9_1.getEquipSkin(var_9_2, arg_9_2)
		local var_9_4 = var_9_0
		local var_9_5 = var_9_0.Find(var_9_4, "info")

		IsNil = var_9_2

		if var_9_2(var_9_5) then
			cloneTplTo = var_7
			var_9_5 = var_7(arg_9_0.infoPanel, var_9_0, "info")
		end

		local var_9_6 = var_9_0
		local var_9_7 = var_9_0.Find(var_9_6, "panel_title/type")

		EquipType = var_9_4

		local var_9_8 = var_9_4.Types2Title(arg_9_2, arg_9_0.shipVO.configId)

		EquipType = var_9_6

		local var_9_9 = var_9_6.LabelToName(var_9_8)
		local var_9_10 = var_9_7
		local var_9_11 = var_9_7.GetComponent

		typeof = var_1_10013
		Text = var_1_10015

		local var_9_12 = var_9_11(var_9_10, var_1_10013(var_1_10015))

		var_9_12.text = var_9_9
		setActive = var_9_12

		var_9_12(var_9_0:Find("unequip"), false)

		local var_9_13 = arg_9_1
		local var_9_14 = arg_9_1.getCanEquipSkin(var_9_13, arg_9_2)

		setActive = var_11

		var_11(var_9_5:Find("forbid"), not var_9_14)

		local var_9_15 = var_9_5:Find("equip")

		setActive = var_9_13

		var_9_13(var_9_15, var_9_14)

		if var_9_14 then
			arg_9_0:updateEquipmentPanel(var_9_15, arg_9_2)
		end
	end

	return
end

function var_0_1.updateEquipmentPanel(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.shipVO

	if not var_3.getCanEquipSkin(var_10_0, arg_10_2) then
		return
	end

	local var_10_1 = arg_10_0.shipVO
	local var_10_2 = var_3.getEquipSkin(var_10_1, arg_10_2) ~= 0
	local var_10_3 = arg_10_0.shipVO
	local var_10_4 = var_5.getEquip(var_10_3, arg_10_2)
	local var_10_5 = arg_10_0.shipVO
	local var_10_6 = var_6.getEquipSkin(var_10_5, arg_10_2)
	local var_10_7 = false

	if var_10_6 ~= 0 then
		if var_10_4 then
			local var_10_8 = var_10_4
			local var_10_9 = var_10_4.getType(var_10_8)

			pg = var_9

			local var_10_10 = var_9.equip_skin_template[var_10_6].equip_type

			table = var_10_8

			if not var_10_8.contains(var_10_10, var_10_9) then
				var_10_7 = true
			end
		else
			var_10_7 = true
		end
	end

	local var_10_11 = arg_10_1:Find("add")
	local var_10_12 = arg_10_1:Find("info")
	local var_10_13 = var_9.Find(var_10_12, "unMatch")
	local var_10_14 = var_9:Find("desc")

	setActive = var_10_12

	var_10_12(var_9, var_10_2)

	setActive = var_10_12

	var_10_12(var_10_11, not var_10_2)

	setActive = var_10_12

	var_10_12(var_10_13, var_10_7)

	setActive = var_10_12

	var_10_12(var_10_14, not var_10_7)

	if var_10_2 then
		arg_10_0:updateSkinInfo(var_9, var_10_6)

		onButton = var_10_12

		local var_10_15 = arg_10_0
		local var_10_16 = arg_10_0.equipmentTFs[arg_10_2]

		local function var_10_17()
			local var_11_0 = arg_10_0
			local var_11_1 = var_0.emit

			ShipMainMediator = var_2_10003

			var_11_1(var_11_0, var_2_10003.ON_SELECT_EQUIPMENT_SKIN, arg_10_2)

			return
		end

		SFX_PANEL = var_1_10017

		var_10_12(var_10_15, var_10_16, var_10_17, var_1_10017)
	else
		onButton = var_10_12

		local var_10_18 = arg_10_0
		local var_10_19 = var_10_11
		local var_10_20 = var_10_11.Find(var_10_19, "icon")

		local function var_10_21()
			local var_12_0 = arg_10_0
			local var_12_1 = var_0.emit

			ShipMainMediator = var_2_10003

			var_12_1(var_12_0, var_2_10003.ON_SELECT_EQUIPMENT_SKIN, arg_10_2)

			return
		end

		SFX_PANEL = var_10_19

		var_10_12(var_10_18, var_10_20, var_10_21, var_10_19)
	end

	return
end

function var_0_1.updateSkinInfo(arg_13_0, arg_13_1, arg_13_2)
	pg = var_1_10003

	local var_13_0 = var_1_10003.equip_skin_template[arg_13_2]

	assert = var_1_10004

	var_1_10004(var_13_0, "miss config equip_skin_template >>" .. arg_13_2)

	setText = var_1_10004

	var_1_10004(arg_13_1:Find("desc"), var_13_0.desc)

	setText = var_1_10004

	local var_13_1 = arg_13_1:Find("cont/name_mask/name")

	shortenString = var_7

	var_1_10004(var_13_1, var_7(var_13_0.name, 10))

	updateDrop = var_1_10004

	local var_13_2 = arg_13_1
	local var_13_3 = arg_13_1.Find(var_13_2, "IconTpl")
	local var_13_4 = {}

	DROP_TYPE_EQUIPMENT_SKIN = var_13_2
	var_13_4.type = var_13_2
	var_13_4.id = arg_13_2

	var_1_10004(var_13_3, var_13_4)

	return
end

return var_0_1
