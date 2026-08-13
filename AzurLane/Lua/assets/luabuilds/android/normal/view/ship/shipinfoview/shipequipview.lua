class = var_0_10000

local var_0_0 = "ShipEquipView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

var_0_1.UNLOCK_EQUIPMENT_SKIN_POS = {
	1,
	2,
	3,
	4,
	5
}

function var_0_1.getUIName(arg_1_0)
	return "ShipEquipView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitEquipment()

	return
end

function var_0_1.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_1.GetShipVO(arg_4_0)
	if arg_4_0.shareData and arg_4_0.shareData.shipVO then
		return arg_4_0.shareData.shipVO
	end

	return nil
end

function var_0_1.UpdateUI(arg_5_0)
	local var_5_0 = arg_5_0:GetShipVO()

	arg_5_0:UpdateEquipments(var_5_0)

	return
end

function var_0_1.InitEquipment(arg_6_0)
	arg_6_0.mainPanel = arg_6_0._parentTf.parent

	local var_6_0 = arg_6_0._parentTf

	arg_6_0.equipRCon = var_1.Find(var_6_0, "equipment_r_container")

	local var_6_1 = arg_6_0._parentTf

	arg_6_0.equipLCon = var_1.Find(var_6_1, "equipment_l_container")

	local var_6_2 = arg_6_0._parentTf

	arg_6_0.equipBCon = var_1.Find(var_6_2, "equipment_b_container")

	local var_6_3 = arg_6_0._tf

	arg_6_0.equipmentR = var_1.Find(var_6_3, "equipment_r")

	local var_6_4 = arg_6_0._tf

	arg_6_0.equipmentL = var_1.Find(var_6_4, "equipment_l")

	local var_6_5 = arg_6_0._tf

	arg_6_0.equipmentB = var_1.Find(var_6_5, "equipment_b")

	local var_6_6 = arg_6_0.equipmentR

	arg_6_0.equipmentR1 = var_1.Find(var_6_6, "equipment/equipment_r1")

	local var_6_7 = arg_6_0.equipmentR

	arg_6_0.equipmentR2 = var_1.Find(var_6_7, "equipment/equipment_r2")

	local var_6_8 = arg_6_0.equipmentR

	arg_6_0.equipmentR3 = var_1.Find(var_6_8, "equipment/equipment_r3")

	local var_6_9 = arg_6_0.equipmentL

	arg_6_0.equipmentL1 = var_1.Find(var_6_9, "equipment/equipment_l1")

	local var_6_10 = arg_6_0.equipmentL

	arg_6_0.equipmentL2 = var_1.Find(var_6_10, "equipment/equipment_l2")

	local var_6_11 = arg_6_0.equipmentR

	arg_6_0.equipSkinBtn = var_1.Find(var_6_11, "equipment_skin_btn")

	local var_6_12 = arg_6_0.equipmentB

	arg_6_0.equipmentB1 = var_1.Find(var_6_12, "equipment")

	local var_6_13 = arg_6_0._tf

	arg_6_0.resource = var_1.Find(var_6_13, "resource")
	ShipEquipSkinLogicPanel = var_1
	arg_6_0.equipSkinLogicPanel = var_1.New(arg_6_0._tf.gameObject)

	local var_6_14 = arg_6_0.equipSkinLogicPanel

	var_1.attach(var_6_14, arg_6_0)

	local var_6_15 = arg_6_0.equipSkinLogicPanel

	var_1.setLabelResource(var_6_15, arg_6_0.resource)

	setActive = var_1

	var_1(arg_6_0.equipSkinLogicPanel._go, true)

	setParent = var_1

	var_1(arg_6_0.equipmentR, arg_6_0.equipRCon)

	setParent = var_1

	var_1(arg_6_0.equipmentL, arg_6_0.equipLCon)

	setParent = var_1

	var_1(arg_6_0.equipmentB, arg_6_0.equipBCon)

	setActive = var_1

	var_1(arg_6_0.equipmentR, true)

	setActive = var_1

	var_1(arg_6_0.equipmentL, true)

	setActive = var_1

	var_1(arg_6_0.equipmentB, true)

	setActive = var_1

	var_1(arg_6_0.equipSkinBtn, true)

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

function var_0_1.InitEvent(arg_7_0)
	onButton = var_1_10001

	var_1_10001(arg_7_0, arg_7_0.equipSkinBtn, function()
		ShipStatus = var_2_10000

		local var_8_0 = var_2_10000.ShipStatusCheck
		local var_8_1 = "onModify"
		local var_8_2 = arg_7_0
		local var_8_3, var_8_4 = var_8_0(var_8_1, var_2.GetShipVO(var_8_2))

		if not var_8_3 then
			pg = var_2

			local var_8_5 = var_2.TipsMgr.GetInstance()

			var_2.ShowTips(var_8_5, var_8_4)

			return
		end

		local var_8_6 = arg_7_0

		var_2.switch2EquipmentSkinPage(var_8_6)

		return
	end)

	if arg_7_0.contextData.isInEquipmentSkinPage then
		local var_7_0 = arg_7_0.contextData

		var_7_0.isInEquipmentSkinPage = nil
		triggerButton = var_7_0

		var_7_0(arg_7_0.equipSkinBtn)
	end

	return
end

function var_0_1.OnSelected(arg_9_0, arg_9_1)
	if arg_9_1 then
		local var_9_0 = {}
		local var_9_1 = {}
		local var_9_2 = {}

		local function var_9_3(arg_10_0, arg_10_1)
			eachChild = var_2_10002

			var_2_10002(arg_10_0, function(arg_11_0)
				table = var_3_10001

				var_3_10001.insert(arg_10_1, arg_11_0)

				return
			end)

			return
		end

		local var_9_4 = arg_9_0.equipmentR

		var_9_3(var_7.Find(var_9_4, "skin"), var_9_1)

		local var_9_5 = var_5
		local var_9_6 = arg_9_0.equipmentR

		var_9_5(var_7.Find(var_9_6, "equipment"), var_9_1)

		local var_9_7 = var_5
		local var_9_8 = arg_9_0.equipmentL

		var_9_7(var_7.Find(var_9_8, "skin"), var_9_0)

		local var_9_9 = var_5
		local var_9_10 = arg_9_0.equipmentL

		var_9_9(var_7.Find(var_9_10, "equipment"), var_9_0)
		var_5(arg_9_0.equipmentB, var_9_2)

		table = var_6

		local var_9_11 = var_6.insert
		local var_9_12 = var_9_0
		local var_9_13 = arg_9_0.equipmentL

		var_9_11(var_9_12, var_8.Find(var_9_13, "equipment/equipment_l1"))

		local var_9_14 = arg_9_0
		local var_9_15 = arg_9_0.OverlayPanel
		local var_9_16 = arg_9_0.equipRCon
		local var_9_17 = {
			groupDelta = -1,
			pbList = var_9_1
		}

		LayerWeightConst = var_10
		var_9_17.overlayType = var_10.OVERLAY_UI_ADAPT

		var_9_15(var_9_14, var_9_16, var_9_17)

		local var_9_18 = arg_9_0
		local var_9_19 = arg_9_0.OverlayPanel
		local var_9_20 = arg_9_0.equipLCon
		local var_9_21 = {
			groupDelta = -1,
			pbList = var_9_0
		}

		LayerWeightConst = var_10
		var_9_21.overlayType = var_10.OVERLAY_UI_ADAPT

		var_9_19(var_9_18, var_9_20, var_9_21)

		local var_9_22 = arg_9_0
		local var_9_23 = arg_9_0.OverlayPanel
		local var_9_24 = arg_9_0.equipBCon
		local var_9_25 = {
			groupDelta = -1,
			pbList = var_9_2
		}

		LayerWeightConst = var_10
		var_9_25.overlayType = var_10.OVERLAY_UI_ADAPT

		var_9_23(var_9_22, var_9_24, var_9_25)
	else
		arg_9_0:UnOverlayPanel(arg_9_0.equipRCon, arg_9_0._parentTf)
		arg_9_0:UnOverlayPanel(arg_9_0.equipLCon, arg_9_0._parentTf)
		arg_9_0:UnOverlayPanel(arg_9_0.equipBCon, arg_9_0._parentTf)
	end

	arg_9_0.onSelected = arg_9_1

	return
end

function var_0_1.UpdateEquipments(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.getActiveEquipments(var_12_0)

	ipairs = var_12_0

	for iter_12_0, iter_12_1 in var_12_0(arg_12_1.equipments) do
		local var_12_2 = var_12_1[iter_12_0]

		arg_12_0:UpdateEquipmentPanel(iter_12_0, iter_12_1, var_12_2)
	end

	if arg_12_0.equipSkinLogicPanel then
		local var_12_3 = arg_12_0.equipSkinLogicPanel

		var_3.updateAll(var_12_3, arg_12_1)
	end

	local var_12_4

	if arg_12_0.contextData.openEquipUpgrade == true then
		var_12_4 = arg_12_0.contextData
		var_12_4.openEquipUpgrade = false
		var_12_4 = 0

		local var_12_5 = arg_12_0:GetShipVO().equipments

		ipairs = iter_12_0

		for iter_12_2, iter_12_3 in iter_12_0(var_12_5) do
			if iter_12_3 then
				var_12_4 = var_12_4 + 1
			end
		end

		local var_12_7

		if 0 < var_12_4 then
			local var_12_6 = arg_12_0

			var_12_7 = arg_12_0.emit
			ShipMainMediator = var_8

			var_12_7(var_12_6, var_8.OPEN_EQUIP_UPGRADE, arg_12_0:GetShipVO().id)
		else
			pg = var_12_7

			local var_12_8 = var_12_7.TipsMgr.GetInstance()
			local var_12_9 = var_6.ShowTips

			i18n = var_8

			var_12_9(var_12_8, var_8("fightfail_noequip"))
		end
	end

	setActive = var_12_4

	local var_12_10 = arg_12_0.equipmentB
	local var_12_11

	if arg_12_1:IsSpweaponUnlock() then
		LOCK_SP_WEAPON = var_12_11
		var_12_11 = not var_12_11
	end

	var_12_4(var_12_10, var_12_11)

	local var_12_12 = arg_12_1:GetSpWeapon()

	arg_12_0:UpdateSpWeaponPanel(var_12_12)

	return
end

function var_0_1.UpdateEquipmentPanel(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0.equipmentPanels[arg_13_1]

	findTF = var_1_10005

	local var_13_1 = var_1_10005(var_13_0, "info")

	findTF = var_6

	local var_13_2 = var_6(var_13_0, "empty")

	findTF = var_7

	local var_13_3 = var_7(var_13_1, "efficiency")

	setActive = var_8

	var_8(var_13_1, arg_13_2)

	setActive = var_8

	var_8(var_13_2, not arg_13_2)

	local var_13_4 = arg_13_0:GetShipVO()
	local var_13_5 = {}
	local var_13_6 = {}
	local var_13_7 = var_13_4

	if var_13_4.GetSpWeapon(var_13_7) then
		local var_13_8 = var_11

		var_13_7 = var_11.GetUpgradableSkillInfo(var_13_8)
		ipairs = var_13_8

		for iter_13_0, iter_13_1 in var_13_8(var_13_7) do
			if iter_13_1.unlock then
				table = iter_13_9

				iter_13_9.insert(var_13_6, var_11:GetUpgradableSkillIds()[1][1])

				iter_13_9 = iter_13_1.skillId
				ys = var_1_10019

				if var_1_10019.Battle.BattleDataFunction.GetBuffTemplate(iter_13_9, iter_13_1.lv).shipInfoScene and var_1_10019.shipInfoScene.equip then
					ipairs = var_1_10020

					for iter_13_2, iter_13_10 in var_1_10020(var_1_10019.shipInfoScene.equip) do
						table = var_1_10025

						var_1_10025.insert(var_13_5, iter_13_10)
					end
				end
			end
		end
	end

	pairs = var_13_7

	for iter_13_4, iter_13_5 in var_13_7(var_13_4.skills) do
		table = iter_13_1

		if not iter_13_1.contains(var_13_6, iter_13_5.id) then
			ys = iter_13_1

			if iter_13_1.Battle.BattleDataFunction.GetBuffTemplate(iter_13_5.id, iter_13_5.level).shipInfoScene and iter_13_1.shipInfoScene.equip then
				ipairs = iter_13_9

				for iter_13_6, iter_13_7 in iter_13_9(iter_13_1.shipInfoScene.equip) do
					table = iter_13_2

					iter_13_2.insert(var_13_5, iter_13_7)
				end
			end
		end
	end

	local var_13_10

	if var_11 and var_11:GetEffect() ~= 0 then
		local var_13_9 = var_11

		var_13_10 = var_11.GetEffect(var_13_9)
		ys = var_13_9

		if var_13_9.Battle.BattleDataFunction.GetBuffTemplate(var_13_10, 1).shipInfoScene and var_13.shipInfoScene.equip then
			ipairs = var_14

			for iter_13_8, iter_13_9 in var_14(var_13.shipInfoScene.equip) do
				table = var_1_10019

				var_1_10019.insert(var_13_5, iter_13_9)
			end
		end
	end

	findTF = var_13_10

	local var_13_11 = var_13_10(var_13_0, "panel_title/type")

	findTF = var_13

	if var_13(var_13_0, "skin_icon") then
		setActive = var_14

		var_14(var_13, arg_13_2 and arg_13_2:hasSkin())
	end

	EquipType = var_14

	local var_13_12 = var_14.Types2Title(arg_13_1, var_13_4.configId)

	EquipType = var_15

	local var_13_13 = var_15.LabelToName(var_13_12)
	local var_13_14 = var_13_11
	local var_13_15 = var_13_11.GetComponent

	typeof = iter_13_9
	Text = var_1_10019

	local var_13_16 = var_13_15(var_13_14, iter_13_9(var_1_10019))

	var_13_16.text = var_13_13

	if arg_13_2 then
		setActive = var_13_16

		var_13_16(var_13_3, not arg_13_2:isDevice())

		if not arg_13_2:isDevice() then
			pg = var_13_16
			var_13_16 = var_13_16.ship_data_statistics[var_13_4.configId]

			local var_13_17

			if not var_13_4:getEquipProficiencyByPos(arg_13_1) or not (var_17 * 100) then
				var_13_17 = 0
			end

			local var_13_18 = false
			local var_13_19 = var_13_4

			if var_13_4.getFlag(var_13_19, "inWorld") then
				var_1_10020 = arg_13_0.contextData.fromMediatorName
				WorldMediator = var_13_19

				if var_1_10020 == var_13_19.__cname then
					WorldConst = var_1_10020
					var_13_19 = var_1_10020.FetchWorldShip(var_13_4.id)
					var_1_10020 = var_1_10020.IsBroken(var_13_19)
				else
					var_1_10020 = false
				end
			end

			if false then
				var_1_10020 = true
			end

			if not var_1_10020 then
				ipairs = var_13_19

				for iter_13_10, iter_13_11 in var_13_19(var_13_5) do
					print = var_1_10026

					var_1_10026(arg_13_0:equipmentCheck(iter_13_11), arg_13_0.equipmentEnhance(iter_13_11, arg_13_2))

					if arg_13_0:equipmentCheck(iter_13_11) and arg_13_0.equipmentEnhance(iter_13_11, arg_13_2) then
						var_13_17 = var_13_17 + iter_13_11.number
						var_13_18 = true
					end
				end
			end

			calcFloor = var_13_19

			local var_13_20 = var_13_17 - var_13_19(var_13_17)
			local var_13_21

			if 1e-09 < var_13_20 then
				string = var_13_21
				var_13_17 = var_13_21.format("%.1f", var_13_17)
				GetComponent = var_13_21
				findTF = iter_13_2
				iter_13_2 = iter_13_2(var_13_3, "Text")
				typeof = iter_13_10
				Text = var_25
				var_13_21 = var_13_21(iter_13_2, iter_13_10(var_25))
				var_13_21.fontSize = 45
			else
				GetComponent = var_13_21
				findTF = iter_13_2
				iter_13_2 = iter_13_2(var_13_3, "Text")
				typeof = iter_13_10
				Text = var_25
				var_13_21 = var_13_21(iter_13_2, iter_13_10(var_25))
				var_13_21.fontSize = 50
			end

			setButtonText = var_13_21
			iter_13_2 = var_13_3

			if var_13_18 then
				setColorStr = iter_13_10

				local var_13_22 = var_13_17 .. "%"

				COLOR_GREEN = var_26

				local var_13_23

				if not iter_13_10(var_13_22, var_26) then
					var_13_23 = var_13_17 .. "%"
				end

				var_13_21(iter_13_2, var_13_23)

				local var_13_24 = var_13_1

				var_13_16 = var_13_1.Find(var_13_24, "IconTpl")
				updateEquipment = var_13_24

				var_13_24(var_13_16, arg_13_2)

				local var_13_25 = arg_13_2:getConfig("name")
				local var_13_26 = arg_13_2

				if arg_13_2.getConfig(var_13_26, "ammo_icon")[1] then
					setActive = var_18
					findTF = var_13_26

					var_18(var_13_26(var_13_1, "cont/icon_ammo"), true)

					setImageSprite = var_18
					findTF = var_13_26
					var_13_26 = var_13_26(var_13_1, "cont/icon_ammo")
					GetSpriteFromAtlas = var_1_10020

					local var_13_27 = "ammo"

					iter_13_2 = arg_13_2

					var_18(var_13_26, var_1_10020(var_13_27, arg_13_2.getConfig(iter_13_2, "ammo_icon")[1]))
				else
					setActive = var_18
					findTF = var_13_26

					var_18(var_13_26(var_13_1, "cont/icon_ammo"), false)
				end

				setScrollText = var_18
				var_1_10020 = arg_13_0.equipmentPanels[arg_13_1]

				var_18(var_19.Find(var_1_10020, "info/cont/name_mask/name"), var_13_25)

				local var_13_28 = var_13_1
				local var_13_29 = var_13_1.Find(var_13_28, "attrs")

				eachChild = var_13_28

				var_13_28(var_13_29, function(arg_14_0)
					setActive = var_2_10001

					var_2_10001(arg_14_0, false)

					return
				end)

				var_1_10020 = arg_13_2

				local var_13_30 = arg_13_2.GetPropertiesInfo(var_1_10020).attrs

				underscore = var_1_10020

				local var_13_31 = var_1_10020.filter(var_13_30, function(arg_15_0)
					local var_15_1

					if arg_15_0.type then
						local var_15_0 = arg_15_0.type

						AttributeType = var_2_10002

						if var_15_0 == var_2_10002.AntiSiren then
							var_15_1 = false

							goto label_15_0
						end
					end

					var_15_1 = true

					::label_15_0::

					return var_15_1
				end)
				local var_13_32

				if arg_13_2:getConfig("skill_id")[1] then
					var_13_32 = var_1_10020[1][1]
				end

				if var_13_32 then
					iter_13_2 = arg_13_2

					local var_13_33

					if not arg_13_2.isDevice(iter_13_2) or not {
						1,
						2,
						5
					} then
						var_13_33 = {
							1,
							4,
							2,
							3
						}
					end

					ipairs = iter_13_2

					for iter_13_12, iter_13_13 in iter_13_2(var_13_33) do
						local var_13_34 = var_13_29
						local var_13_35 = var_13_29.Find(var_13_34, "attr_" .. iter_13_13)

						findTF = var_13_34

						local var_13_36 = var_13_34(var_13_35, "panel")

						findTF = var_30

						local var_13_37 = var_30(var_13_35, "lock")

						setActive = var_31

						var_31(var_13_35, true)

						if iter_13_13 == 5 then
							setText = var_31

							var_31(var_13_36:Find("values/value"), "")

							getSkillName = var_31

							local var_13_38 = var_31(var_13_32)

							PLATFORM_CODE = var_13_41
							PLATFORM_US = var_33

							local var_13_41

							if var_13_41 == var_33 then
								string = var_13_41

								if var_13_41.len(var_13_38) > 15 then
									GetComponent = var_13_41

									local var_13_39 = var_13_36
									local var_13_40 = var_13_36.Find(var_13_39, "values/value_1")

									typeof = var_13_39
									Text = var_35
									var_13_41 = var_13_41(var_13_40, var_13_39(var_35))
									var_13_41.fontSize = 24
								end
							end

							setText = var_13_41

							local var_13_42 = var_13_36
							local var_13_43 = var_13_36.Find(var_13_42, "values/value_1")

							getSkillName = var_13_42

							var_13_41(var_13_43, var_13_42(var_13_32))

							setActive = var_13_41

							var_13_41(var_13_37, false)
						else
							local var_13_44

							if #var_13_31 > 0 then
								table = var_13_44
								var_13_44 = var_13_44.remove(var_13_31, 1)

								local var_13_45 = arg_13_2
								local var_13_46

								if arg_13_2.isAircraft(var_13_45) then
									var_13_46 = var_13_44.type
									AttributeType = var_13_45

									if var_13_46 == var_13_45.CD then
										var_13_44 = var_13_4:getAircraftReloadCD()
									end
								end

								Equipment = var_13_46

								local var_13_47, var_13_48 = var_13_46.GetInfoTrans(var_13_44, var_13_4)

								setText = var_34

								var_34(var_13_36:Find("tag"), var_13_47)

								string = var_34

								local var_13_49 = var_34.split

								tostring = var_35

								if #var_13_49(var_35(var_13_48), "/") >= 2 then
									setText = var_35

									var_35(var_13_36:Find("values/value"), var_34[1] .. "/")

									setText = var_35

									var_35(var_13_36:Find("values/value_1"), var_34[2])
								else
									setText = var_35

									var_35(var_13_36:Find("values/value"), var_13_48)

									setText = var_35

									var_35(var_13_36:Find("values/value_1"), "")
								end

								setActive = var_35

								var_35(var_13_37, false)
							else
								setText = var_13_44

								var_13_44(var_13_36:Find("tag"), "")

								setText = var_13_44

								var_13_44(var_13_36:Find("values/value"), "")

								setText = var_13_44

								var_13_44(var_13_36:Find("values/value_1"), "")

								setActive = var_13_44

								var_13_44(var_13_37, true)
							end
						end
					end

					onButton = var_23

					local var_13_50 = arg_13_0
					local var_13_51 = var_13_0

					local function var_13_52()
						local var_16_0 = arg_13_0
						local var_16_1 = var_0.emit

						BaseUI = var_2_10002

						local var_16_2 = var_2_10002.ON_EQUIPMENT
						local var_16_3 = {}

						EquipmentInfoMediator = var_2_10004
						var_16_3.type = var_2_10004.TYPE_SHIP
						var_16_3.shipId = var_13_4.id
						var_16_3.pos = arg_13_1

						function var_16_3.onRemoved()
							local var_17_0 = arg_13_0

							var_0.setEquipDescVisible(var_17_0, true)

							return
						end

						var_16_1(var_16_0, var_16_2, var_16_3)

						local var_16_4 = arg_13_0

						var_0.setEquipDescVisible(var_16_4, false)

						return
					end

					SFX_UI_DOCKYARD_EQUIPADD = iter_13_13

					var_23(var_13_50, var_13_51, var_13_52, iter_13_13)

					goto label_13_0

					onButton = var_13_16

					do
						local var_13_53 = arg_13_0
						local var_13_54 = var_13_0

						local function var_13_55()
							if var_13_4 then
								ShipStatus = var_0

								local var_18_0, var_18_1 = var_0.ShipStatusCheck("onModify", var_13_4)

								if not var_18_0 then
									pg = var_2

									local var_18_2 = var_2.TipsMgr.GetInstance()

									var_2.ShowTips(var_18_2, var_18_1)

									return
								end

								local var_18_3 = arg_13_0
								local var_18_4 = var_2.emit

								ShipMainMediator = var_2_10004

								var_18_4(var_18_3, var_2_10004.ON_SELECT_EQUIPMENT, arg_13_1)
							end

							return
						end

						SFX_UI_DOCKYARD_EQUIPADD = var_1_10020

						var_13_16(var_13_53, var_13_54, var_13_55, var_1_10020)
					end

					::label_13_0::

					return
				end
			end
		end
	end
end

function var_0_1.setEquipDescVisible(arg_19_0, arg_19_1)
	if not arg_19_0.equipmentPanels then
		return
	end

	for iter_19_0 = 1, #arg_19_0.equipmentPanels do
		if arg_19_0.equipmentPanels[iter_19_0] then
			local var_19_0 = var_6
			local var_19_1

			var_19_1, GetComponent = var_6.Find(var_19_0, "info/cont/name_mask/name"), var_19_0
			typeof = var_1_10010
			ScrollText = var_1_10011

			if var_19_0(var_19_1, var_1_10010(var_1_10011)) then
				var_1_10010 = var_8

				var_8.SetVisible(var_1_10010, arg_19_1)
			end
		end
	end

	return
end

function var_0_1.equipmentCheck(arg_20_0, arg_20_1)
	if not arg_20_0:GetShipVO() then
		return false
	end

	local var_20_0 = arg_20_1.check_type
	local var_20_1 = arg_20_1.check_indexList
	local var_20_2 = arg_20_1.check_label

	if not var_20_0 and not var_20_1 and not var_20_2 then
		return true
	end

	local var_20_3 = false
	local var_20_4 = {}

	Clone = var_1_10007

	local var_20_5 = var_1_10007(arg_20_0:GetShipVO().equipments)

	if var_20_1 then
		local var_20_6 = #var_20_5

		while 0 < var_20_6 do
			table = var_9

			if not var_9.contains(var_20_1, var_20_6) then
				table = var_9

				var_9.remove(var_20_5, var_20_6)
			end

			var_20_6 = var_20_6 - 1
		end
	end

	if var_20_0 then
		local var_20_7 = #var_20_5

		::label_20_0::

		if var_20_7 > 0 then
			repeat
				if var_20_5[var_20_7] then
					table = var_1_10010

					if not var_1_10010.contains(var_20_0, var_9:getConfig("type")) then
						table = var_1_10010

						var_1_10010.remove(var_20_5, var_20_7)
					end

					var_20_7 = var_20_7 - 1

					goto label_20_0
				end
			until true
		end
	end

	if var_20_2 then
		local var_20_8 = #var_20_5

		while var_20_8 > 0 do
			if var_20_5[var_20_8] then
				var_1_10010 = 1
				ipairs = var_1_10011

				for iter_20_0, iter_20_1 in var_1_10011(var_20_2) do
					table = var_1_10016

					if not var_1_10016.contains(var_9:getConfig("label"), iter_20_1) then
						var_1_10010 = var_1_10010 * 0
					end
				end

				if var_1_10010 == 0 then
					table = var_1_10011

					var_1_10011.remove(var_20_5, var_20_8)
				end
			else
				table = var_1_10010

				var_1_10010.remove(var_20_5, var_20_8)
			end

			var_20_8 = var_20_8 - 1
		end
	end

	return #var_20_5 > 0
end

function var_0_1.equipmentEnhance(arg_21_0, arg_21_1)
	local var_21_0 = 1
	local var_21_1 = arg_21_1:getConfig("label")

	if arg_21_0.label then
		var_21_0 = 1
		ipairs = var_4

		for iter_21_0, iter_21_1 in var_4(arg_21_0.label) do
			table = var_1_10009

			if not var_1_10009.contains(var_21_1, iter_21_1) then
				var_21_0 = 0

				break
			end
		end
	end

	return var_21_0 == 1
end

function var_0_1.UpdateSpWeaponPanel(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.equipmentB1

	findTF = var_1_10003

	local var_22_1 = var_1_10003(var_22_0, "info")

	findTF = var_4

	local var_22_2 = var_4(var_22_0, "empty")

	setActive = var_5

	var_5(var_22_1, arg_22_1)

	setActive = var_5

	var_5(var_22_2, not arg_22_1)

	local var_22_3 = arg_22_0
	local var_22_4 = arg_22_0.GetShipVO(var_22_3)

	assert = var_22_3

	var_22_3(var_22_4)

	if arg_22_1 then
		UpdateSpWeaponSlot = var_22_3

		var_22_3(var_22_1, arg_22_1, {
			20,
			20,
			20,
			20
		})

		local var_22_5 = var_22_1

		var_22_3 = var_22_1.Find(var_22_5, "attrs")
		eachChild = var_22_5

		var_22_5(var_22_3, function(arg_23_0)
			setActive = var_2_10001

			var_2_10001(arg_23_0, false)

			return
		end)

		local var_22_6 = arg_22_1
		local var_22_7 = arg_22_1.GetPropertiesInfo(var_22_6).attrs

		underscore = var_22_6

		local var_22_8 = var_22_6.filter(var_22_7, function(arg_24_0)
			local var_24_1

			if arg_24_0.type then
				local var_24_0 = arg_24_0.type

				AttributeType = var_2_10002

				if var_24_0 == var_2_10002.AntiSiren then
					var_24_1 = false

					goto label_24_0
				end
			end

			var_24_1 = true

			::label_24_0::

			return var_24_1
		end)

		for iter_22_0 = 1, 2 do
			local var_22_9 = var_22_3
			local var_22_10 = var_22_3.GetChild(var_22_9, iter_22_0 - 1)

			setActive = var_22_9

			var_22_9(var_22_10, true)

			if #var_22_8 > 0 then
				table = var_13

				local var_22_11 = var_13.remove(var_22_8, 1)

				Equipment = var_14

				local var_22_12, var_22_13 = var_14.GetInfoTrans(var_22_11, var_22_4)

				setText = var_1_10016

				var_1_10016(var_22_10:Find("tag"), var_22_12)

				setText = var_1_10016

				var_1_10016(var_22_10:Find("values/value"), var_22_13)

				setText = var_1_10016

				var_1_10016(var_22_10:Find("values/value_1"), "")
			end
		end

		Canvas = var_8

		var_8.ForceUpdateCanvases()

		local var_22_14 = var_22_1:Find("cont")

		;(function()
			local var_25_0 = var_22_14
			local var_25_1 = var_0.GetChild(var_25_0, 0)

			setText = var_25_0

			local var_25_2 = var_25_1
			local var_25_3 = var_25_1.Find(var_25_2, "tag")

			i18n = var_25_2

			var_25_0(var_25_3, var_25_2("spweapon_ui_effect_tag"))

			local var_25_4 = arg_22_1
			local var_25_5 = var_1.GetEffect(var_25_4)

			setActive = var_25_4

			var_25_4(var_25_1, var_25_5 and var_25_5 > 0)

			if not var_25_5 or not (0 < var_25_5) then
				return
			end

			setScrollText = var_25_4

			local var_25_6 = var_25_1
			local var_25_7 = var_25_1.Find(var_25_6, "value/Text")

			getSkillName = var_25_6

			var_25_4(var_25_7, var_25_6(var_25_5))

			return
		end)()

		function var_1_10010(arg_26_0)
			local var_26_0 = var_22_14
			local var_26_1 = var_1.GetChild(var_26_0, 1)

			setText = var_26_0

			local var_26_2 = var_26_1
			local var_26_3 = var_26_1.Find(var_26_2, "tag")

			i18n = var_26_2

			var_26_0(var_26_3, var_26_2("spweapon_ui_skill_tag"))

			setActive = var_26_0

			var_26_0(var_26_1, arg_26_0 and arg_26_0 > 0)

			if not arg_26_0 or not (0 < arg_26_0) then
				return
			end

			setScrollText = var_26_0

			local var_26_4 = var_26_1
			local var_26_5 = var_26_1.Find(var_26_4, "value/Text")

			getSkillName = var_26_4

			var_26_0(var_26_5, var_26_4(arg_26_0))

			return
		end

		if #arg_22_1:GetActiveUpgradableSkillList(var_22_4) == 0 then
			setActive = var_12

			var_12(var_22_14:GetChild(1), false)
		else
			var_1_10010(var_11[1].mapSkillID)
		end

		onButton = var_12

		local var_22_15 = arg_22_0
		local var_22_16 = var_22_0

		local function var_22_17()
			local var_27_0 = arg_22_0
			local var_27_1 = var_0.emit

			BaseUI = var_2_10002

			local var_27_2 = var_2_10002.ON_SPWEAPON
			local var_27_3 = {}

			SpWeaponInfoLayer = var_2_10004
			var_27_3.type = var_2_10004.TYPE_SHIP
			var_27_3.shipId = var_22_4.id

			function var_27_3.onRemoved()
				local var_28_0 = arg_22_0

				var_0.setEquipDescVisible(var_28_0, true)

				return
			end

			var_27_1(var_27_0, var_27_2, var_27_3)

			local var_27_4 = arg_22_0

			var_0.setEquipDescVisible(var_27_4, false)

			return
		end

		SFX_UI_DOCKYARD_EQUIPADD = var_1_10016

		var_12(var_22_15, var_22_16, var_22_17, var_1_10016)
	else
		onButton = var_22_3

		local var_22_18 = arg_22_0
		local var_22_19 = var_22_0

		local function var_22_20()
			if var_22_4 then
				ShipStatus = var_0

				local var_29_0, var_29_1 = var_0.ShipStatusCheck("onModify", var_22_4)

				if not var_29_0 then
					pg = var_2

					local var_29_2 = var_2.TipsMgr.GetInstance()

					var_2.ShowTips(var_29_2, var_29_1)

					return
				end

				local var_29_3 = arg_22_0
				local var_29_4 = var_2.emit

				ShipMainMediator = var_2_10004

				var_29_4(var_29_3, var_2_10004.ON_SELECT_SPWEAPON)
			end

			return
		end

		SFX_UI_DOCKYARD_EQUIPADD = var_1_10010

		var_22_3(var_22_18, var_22_19, var_22_20, var_1_10010)
	end

	return
end

function var_0_1.switch2EquipmentSkinPage(arg_30_0)
	local var_30_0 = arg_30_0.equipSkinLogicPanel

	if var_1.isTweening(var_30_0) then
		return
	end

	local var_30_1 = arg_30_0.equipSkinLogicPanel

	var_1.doSwitchAnim(var_30_1, arg_30_0.contextData.isInEquipmentSkinPage)

	local var_30_2 = arg_30_0.contextData

	var_30_2.isInEquipmentSkinPage = not arg_30_0.contextData.isInEquipmentSkinPage
	setActive = var_30_2

	local var_30_3 = arg_30_0.equipSkinBtn

	var_30_2(var_2.Find(var_30_3, "unsel"), not arg_30_0.contextData.isInEquipmentSkinPage)

	setActive = var_30_2

	local var_30_4 = arg_30_0.equipSkinBtn

	var_30_2(var_2.Find(var_30_4, "sel"), arg_30_0.contextData.isInEquipmentSkinPage)

	local var_30_5 = arg_30_0.equipSkinLogicPanel

	var_1.updateAll(var_30_5, arg_30_0:GetShipVO())

	return
end

function var_0_1.OnDestroy(arg_31_0)
	setParent = var_1_10001

	var_1_10001(arg_31_0.equipmentR, arg_31_0._tf)

	setParent = var_1_10001

	var_1_10001(arg_31_0.equipmentL, arg_31_0._tf)

	setParent = var_1_10001

	var_1_10001(arg_31_0.equipmentB, arg_31_0._tf)

	arg_31_0.shareData = nil

	return
end

return var_0_1
