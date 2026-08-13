class = var_0_10000

local var_0_0 = "ShipEquipView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

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
		local var_8_3, var_8_4 = var_8_0(var_8_1, var_3.GetShipVO(var_8_2))

		if not var_8_3 then
			pg = var_8_1

			local var_8_5 = var_8_1.TipsMgr.GetInstance()

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

		var_9_3(var_8.Find(var_9_4, "skin"), var_9_1)

		local var_9_5 = var_5
		local var_9_6 = arg_9_0.equipmentR

		var_9_5(var_8.Find(var_9_6, "equipment"), var_9_1)

		local var_9_7 = var_5
		local var_9_8 = arg_9_0.equipmentL

		var_9_7(var_8.Find(var_9_8, "skin"), var_9_0)

		local var_9_9 = var_5
		local var_9_10 = arg_9_0.equipmentL

		var_9_9(var_8.Find(var_9_10, "equipment"), var_9_0)
		var_5(arg_9_0.equipmentB, var_9_2)

		table = var_6

		local var_9_11 = var_6.insert
		local var_9_12 = var_9_0
		local var_9_13 = arg_9_0.equipmentL

		var_9_11(var_9_12, var_9.Find(var_9_13, "equipment/equipment_l1"))

		local var_9_14 = arg_9_0
		local var_9_15 = arg_9_0.OverlayPanel
		local var_9_16 = arg_9_0.equipRCon
		local var_9_17 = {
			groupDelta = -1,
			pbList = var_9_1
		}

		LayerWeightConst = var_9_13
		var_9_17.overlayType = var_9_13.OVERLAY_UI_ADAPT

		var_9_15(var_9_14, var_9_16, var_9_17)

		local var_9_18 = arg_9_0
		local var_9_19 = arg_9_0.OverlayPanel
		local var_9_20 = arg_9_0.equipLCon
		local var_9_21 = {
			groupDelta = -1,
			pbList = var_9_0
		}

		LayerWeightConst = var_11
		var_9_21.overlayType = var_11.OVERLAY_UI_ADAPT

		var_9_19(var_9_18, var_9_20, var_9_21)

		local var_9_22 = arg_9_0
		local var_9_23 = arg_9_0.OverlayPanel
		local var_9_24 = arg_9_0.equipBCon
		local var_9_25 = {
			groupDelta = -1,
			pbList = var_9_2
		}

		LayerWeightConst = var_11
		var_9_25.overlayType = var_11.OVERLAY_UI_ADAPT

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
	local var_12_0 = arg_12_1:getActiveEquipments()

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(arg_12_1.equipments) do
		local var_12_1 = var_12_0[iter_12_0]

		arg_12_0:UpdateEquipmentPanel(iter_12_0, iter_12_1, var_12_1)
	end

	if arg_12_0.equipSkinLogicPanel then
		local var_12_2 = arg_12_0.equipSkinLogicPanel

		var_3.updateAll(var_12_2, arg_12_1)
	end

	local var_12_3

	if arg_12_0.contextData.openEquipUpgrade == true then
		var_12_3 = arg_12_0.contextData
		var_12_3.openEquipUpgrade = false
		var_12_3 = 0

		local var_12_4 = arg_12_0
		local var_12_5 = arg_12_0.GetShipVO(var_12_4).equipments

		ipairs = var_12_4

		for iter_12_2, iter_12_3 in var_12_4(var_12_5) do
			if iter_12_3 then
				var_12_3 = var_12_3 + 1
			end
		end

		local var_12_7

		if 0 < var_12_3 then
			local var_12_6 = arg_12_0

			var_12_7 = arg_12_0.emit
			ShipMainMediator = iter_12_2

			var_12_7(var_12_6, iter_12_2.OPEN_EQUIP_UPGRADE, arg_12_0:GetShipVO().id)
		else
			pg = var_12_7

			local var_12_8 = var_12_7.TipsMgr.GetInstance()
			local var_12_9 = var_6.ShowTips

			i18n = iter_12_2

			var_12_9(var_12_8, iter_12_2("fightfail_noequip"))
		end
	end

	setActive = var_12_3

	local var_12_10 = arg_12_0.equipmentB
	local var_12_11

	if arg_12_1:IsSpweaponUnlock() then
		LOCK_SP_WEAPON = var_12_11
		var_12_11 = not var_12_11
	end

	var_12_3(var_12_10, var_12_11)

	local var_12_12 = arg_12_1:GetSpWeapon()

	arg_12_0:UpdateSpWeaponPanel(var_12_12)

	return
end

function var_0_1.UpdateEquipmentPanel(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0.equipmentPanels[arg_13_1]

	findTF = var_1_10005

	local var_13_1 = var_1_10005(var_13_0, "info")

	findTF = var_1_10006

	local var_13_2 = var_1_10006(var_13_0, "empty")

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
		var_1_10012 = var_11:GetUpgradableSkillInfo()
		ipairs = var_13_7

		for iter_13_0, iter_13_1 in var_13_7(var_1_10012) do
			if iter_13_1.unlock then
				table = var_18

				local var_13_8 = var_18.insert
				local var_13_9 = var_13_6

				iter_13_2 = var_11

				var_13_8(var_13_9, var_11.GetUpgradableSkillIds(iter_13_2)[1][1])

				local var_13_10 = iter_13_1.skillId

				ys = var_1_10019

				if var_1_10019.Battle.BattleDataFunction.GetBuffTemplate(var_13_10, iter_13_1.lv).shipInfoScene and var_1_10019.shipInfoScene.equip then
					ipairs = var_20

					for iter_13_2, iter_13_10 in var_20(var_1_10019.shipInfoScene.equip) do
						table = iter_13_11

						iter_13_11.insert(var_13_5, iter_13_10)
					end
				end
			end
		end
	end

	pairs = var_1_10012

	for iter_13_4, iter_13_5 in var_1_10012(var_13_4.skills) do
		table = iter_13_1

		if not iter_13_1.contains(var_13_6, iter_13_5.id) then
			ys = iter_13_1

			if iter_13_1.Battle.BattleDataFunction.GetBuffTemplate(iter_13_5.id, iter_13_5.level).shipInfoScene and iter_13_1.shipInfoScene.equip then
				ipairs = var_18

				for iter_13_6, iter_13_7 in var_18(iter_13_1.shipInfoScene.equip) do
					table = iter_13_2

					iter_13_2.insert(var_13_5, iter_13_7)
				end
			end
		end
	end

	local var_13_11

	if var_11 and var_11:GetEffect() ~= 0 then
		var_13_11 = var_11:GetEffect()
		ys = var_13

		if var_13.Battle.BattleDataFunction.GetBuffTemplate(var_13_11, 1).shipInfoScene and var_13.shipInfoScene.equip then
			ipairs = var_14

			for iter_13_8, iter_13_9 in var_14(var_13.shipInfoScene.equip) do
				table = var_1_10019

				var_1_10019.insert(var_13_5, iter_13_9)
			end
		end
	end

	findTF = var_13_11

	local var_13_12 = var_13_11(var_13_0, "panel_title/type")

	findTF = var_13

	if var_13(var_13_0, "skin_icon") then
		setActive = var_14

		local var_13_13 = var_13
		local var_13_14

		if arg_13_2 then
			::label_13_0::

			var_1_10019 = arg_13_2
			var_13_14 = arg_13_2.hasSkin(var_1_10019)
		end

		var_14(var_13_13, var_13_14)
	end

	EquipType = var_14

	local var_13_15 = var_14.Types2Title(arg_13_1, var_13_4.configId)

	EquipType = var_15

	local var_13_16 = var_15.LabelToName(var_13_15)
	local var_13_17 = var_13_12
	local var_13_18 = var_13_12.GetComponent

	typeof = var_1_10019
	Text = iter_13_6

	local var_13_19 = var_13_18(var_13_17, var_1_10019(iter_13_6))

	var_13_19.text = var_13_16

	if arg_13_2 then
		setActive = var_13_19

		local var_13_20 = var_13_3

		iter_13_6 = arg_13_2

		var_13_19(var_13_20, not arg_13_2.isDevice(iter_13_6))

		if not arg_13_2:isDevice() then
			pg = var_13_19
			var_13_19 = var_13_19.ship_data_statistics[var_13_4.configId]

			local var_13_21

			if not var_13_4:getEquipProficiencyByPos(arg_13_1) or not (var_17 * 100) then
				var_13_21 = 0
			end

			local var_13_22 = false

			if var_13_4:getFlag("inWorld") then
				local var_13_23 = arg_13_0.contextData.fromMediatorName

				WorldMediator = iter_13_6

				if var_13_23 == iter_13_6.__cname then
					WorldConst = var_13_23

					local var_13_24 = var_13_23.FetchWorldShip(var_13_4.id)

					var_13_23 = var_13_23.IsBroken(var_13_24)
				else
					var_13_23 = false
				end
			end

			if false then
				var_13_23 = true
			end

			if not var_13_23 then
				ipairs = iter_13_6

				for iter_13_10, iter_13_11 in iter_13_6(var_13_5) do
					print = var_1_10026

					var_1_10026(arg_13_0:equipmentCheck(iter_13_11), arg_13_0.equipmentEnhance(iter_13_11, arg_13_2))

					var_1_10028 = arg_13_0

					if arg_13_0.equipmentCheck(var_1_10028, iter_13_11) and arg_13_0.equipmentEnhance(iter_13_11, arg_13_2) then
						var_13_21 = var_13_21 + iter_13_11.number
						var_13_22 = true
					end
				end
			end

			calcFloor = iter_13_6
			iter_13_6 = var_13_21 - iter_13_6(var_13_21)
			iter_13_6 = 1e-09 < iter_13_6

			local var_13_25

			if iter_13_6 then
				string = var_13_25
				var_13_21 = var_13_25.format("%.1f", var_13_21)
				GetComponent = var_13_25
				findTF = iter_13_10
				iter_13_10 = iter_13_10(var_13_3, "Text")
				typeof = iter_13_11
				Text = var_27
				var_13_25 = var_13_25(iter_13_10, iter_13_11(var_27))
				var_13_25.fontSize = 45
			else
				GetComponent = var_13_25
				findTF = iter_13_10

				local var_13_26 = iter_13_10(var_13_3, "Text")

				typeof = iter_13_11
				Text = var_27
				var_13_25 = var_13_25(var_13_26, iter_13_11(var_27))
				var_13_25.fontSize = 50
			end

			setButtonText = var_13_25

			local var_13_27 = var_13_3

			if var_13_22 then
				setColorStr = iter_13_11

				local var_13_28 = var_13_21 .. "%"

				COLOR_GREEN = var_1_10028

				local var_13_29

				if not iter_13_11(var_13_28, var_1_10028) then
					var_13_29 = var_13_21 .. "%"
				end

				var_13_25(var_13_27, var_13_29)

				var_13_19 = var_13_1:Find("IconTpl")
				updateEquipment = var_17

				var_17(var_13_19, arg_13_2)

				local var_13_30 = arg_13_2
				local var_13_31 = arg_13_2.getConfig(var_13_30, "name")
				local var_13_32 = arg_13_2

				if arg_13_2.getConfig(var_13_32, "ammo_icon")[1] then
					setActive = var_18
					findTF = var_13_32

					var_18(var_13_32(var_13_1, "cont/icon_ammo"), true)

					setImageSprite = var_18
					findTF = var_13_32
					var_13_32 = var_13_32(var_13_1, "cont/icon_ammo")
					GetSpriteFromAtlas = iter_13_6

					var_18(var_13_32, iter_13_6("ammo", arg_13_2:getConfig("ammo_icon")[1]))
				else
					setActive = var_18
					findTF = var_13_32

					var_18(var_13_32(var_13_1, "cont/icon_ammo"), false)
				end

				setScrollText = var_18

				local var_13_33 = arg_13_0.equipmentPanels[arg_13_1]

				var_18(var_20.Find(var_13_33, "info/cont/name_mask/name"), var_13_31)

				local var_13_34 = var_13_1
				local var_13_35 = var_13_1.Find(var_13_34, "attrs")

				eachChild = var_13_30

				var_13_30(var_13_35, function(arg_14_0)
					setActive = var_2_10001

					var_2_10001(arg_14_0, false)

					return
				end)

				iter_13_6 = arg_13_2

				local var_13_36 = arg_13_2.GetPropertiesInfo(iter_13_6).attrs

				underscore = var_13_34

				local var_13_37 = var_13_34.filter(var_13_36, function(arg_15_0)
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

				if arg_13_2:getConfig("skill_id")[1] then
					iter_13_6 = var_20[1][1]
				end

				local var_13_38

				if not iter_13_6 or not arg_13_2:isDevice() or not {
					1,
					2,
					5
				} then
					var_13_38 = {
						1,
						4,
						2,
						3
					}
				end

				ipairs = var_23

				for iter_13_12, iter_13_13 in var_23(var_13_38) do
					local var_13_39 = var_13_35

					var_1_10028 = var_13_35.Find(var_13_39, "attr_" .. iter_13_13)
					findTF = var_1_10029
					var_1_10029 = var_1_10029(var_1_10028, "panel")
					findTF = var_13_39

					local var_13_40 = var_13_39(var_1_10028, "lock")

					setActive = var_31

					var_31(var_1_10028, true)

					if iter_13_13 == 5 then
						setText = var_31

						local var_13_41 = var_1_10029

						var_31(var_1_10029.Find(var_13_41, "values/value"), "")

						getSkillName = var_31

						local var_13_42 = var_31(iter_13_6)

						PLATFORM_CODE = var_13_44
						PLATFORM_US = var_33

						local var_13_44

						if var_13_44 == var_33 then
							string = var_13_44

							if var_13_44.len(var_13_42) > 15 then
								GetComponent = var_13_44

								local var_13_43 = var_1_10029:Find("values/value_1")

								typeof = var_13_41
								Text = var_37
								var_13_44 = var_13_44(var_13_43, var_13_41(var_37))
								var_13_44.fontSize = 24
							end
						end

						setText = var_13_44

						local var_13_45 = var_1_10029:Find("values/value_1")

						getSkillName = var_13_41

						var_13_44(var_13_45, var_13_41(iter_13_6))

						setActive = var_13_44

						var_13_44(var_13_40, false)
					else
						local var_13_46

						if #var_13_37 > 0 then
							table = var_13_46
							var_13_46 = var_13_46.remove(var_13_37, 1)

							local var_13_47

							if arg_13_2:isAircraft() then
								var_13_47 = var_13_46.type
								AttributeType = var_33

								if var_13_47 == var_33.CD then
									var_13_46 = var_13_4:getAircraftReloadCD()
								end
							end

							Equipment = var_13_47

							local var_13_48, var_13_49 = var_13_47.GetInfoTrans(var_13_46, var_13_4)

							setText = var_34

							var_34(var_1_10029:Find("tag"), var_13_48)

							string = var_34

							local var_13_50 = var_34.split

							tostring = var_36

							if #var_13_50(var_36(var_13_49), "/") >= 2 then
								setText = var_35

								var_35(var_1_10029:Find("values/value"), var_34[1] .. "/")

								setText = var_35

								var_35(var_1_10029:Find("values/value_1"), var_34[2])
							else
								setText = var_35

								var_35(var_1_10029:Find("values/value"), var_13_49)

								setText = var_35

								var_35(var_1_10029:Find("values/value_1"), "")
							end

							setActive = var_35

							var_35(var_13_40, false)
						else
							setText = var_13_46

							var_13_46(var_1_10029:Find("tag"), "")

							setText = var_13_46

							var_13_46(var_1_10029:Find("values/value"), "")

							setText = var_13_46

							var_13_46(var_1_10029:Find("values/value_1"), "")

							setActive = var_13_46

							var_13_46(var_13_40, true)
						end
					end
				end

				onButton = var_23

				local var_13_51 = arg_13_0
				local var_13_52 = var_13_0

				local function var_13_53()
					local var_16_0 = arg_13_0
					local var_16_1 = var_0.emit

					BaseUI = var_2_10003

					local var_16_2 = var_2_10003.ON_EQUIPMENT
					local var_16_3 = {}

					EquipmentInfoMediator = var_2_10005
					var_16_3.type = var_2_10005.TYPE_SHIP
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

				SFX_UI_DOCKYARD_EQUIPADD = var_1_10028

				var_23(var_13_51, var_13_52, var_13_53, var_1_10028)

				goto label_13_1

				onButton = var_13_19

				do
					local var_13_54 = arg_13_0
					local var_13_55 = var_13_0

					local function var_13_56()
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

							ShipMainMediator = var_2_10005

							var_18_4(var_18_3, var_2_10005.ON_SELECT_EQUIPMENT, arg_13_1)
						end

						return
					end

					SFX_UI_DOCKYARD_EQUIPADD = iter_13_6

					var_13_19(var_13_54, var_13_55, var_13_56, iter_13_6)
				end

				::label_13_1::

				return
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
			local var_19_0

			var_19_0, GetComponent = var_6:Find("info/cont/name_mask/name"), var_1_10008
			typeof = var_1_10011
			ScrollText = var_1_10013

			if var_1_10008(var_19_0, var_1_10011(var_1_10013)) then
				var_1_10011 = var_1_10008

				var_1_10008.SetVisible(var_1_10011, arg_19_1)
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

	local var_20_5 = arg_20_0
	local var_20_6 = var_1_10007(arg_20_0.GetShipVO(var_20_5).equipments)

	if var_20_1 then
		local var_20_7 = #var_20_6

		while 0 < var_20_7 do
			table = var_9

			if not var_9.contains(var_20_1, var_20_7) then
				table = var_9

				var_9.remove(var_20_6, var_20_7)
			end

			var_20_7 = var_20_7 - 1
		end
	end

	if var_20_0 then
		local var_20_8 = #var_20_6

		::label_20_0::

		if var_20_8 > 0 then
			repeat
				if var_20_6[var_20_8] then
					table = var_1_10010

					if not var_1_10010.contains(var_20_0, var_9:getConfig("type")) then
						table = var_1_10010

						var_1_10010.remove(var_20_6, var_20_8)
					end

					var_20_8 = var_20_8 - 1

					goto label_20_0
				end
			until true
		end
	end

	if var_20_2 then
		local var_20_9 = #var_20_6

		while var_20_9 > 0 do
			if var_20_6[var_20_9] then
				var_1_10010 = 1
				ipairs = var_20_5

				for iter_20_0, iter_20_1 in var_20_5(var_20_2) do
					table = var_1_10016

					if not var_1_10016.contains(var_9:getConfig("label"), iter_20_1) then
						var_1_10010 = var_1_10010 * 0
					end
				end

				if var_1_10010 == 0 then
					table = var_20_5

					var_20_5.remove(var_20_6, var_20_9)
				end
			else
				table = var_1_10010

				var_1_10010.remove(var_20_6, var_20_9)
			end

			var_20_9 = var_20_9 - 1
		end
	end

	return #var_20_6 > 0
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

	findTF = var_1_10004

	local var_22_2 = var_1_10004(var_22_0, "empty")

	setActive = var_5

	var_5(var_22_1, arg_22_1)

	setActive = var_5

	var_5(var_22_2, not arg_22_1)

	local var_22_3 = arg_22_0
	local var_22_4 = arg_22_0.GetShipVO(var_22_3)

	assert = var_22_6

	var_22_6(var_22_4)

	local var_22_6

	if arg_22_1 then
		UpdateSpWeaponSlot = var_22_6

		var_22_6(var_22_1, arg_22_1, {
			20,
			20,
			20,
			20
		})

		local var_22_5 = var_22_1

		var_22_6 = var_22_1.Find(var_22_5, "attrs")
		eachChild = var_22_3

		var_22_3(var_22_6, function(arg_23_0)
			setActive = var_2_10001

			var_2_10001(arg_23_0, false)

			return
		end)

		local var_22_7 = arg_22_1:GetPropertiesInfo().attrs

		underscore = var_22_5

		local var_22_8 = var_22_5.filter(var_22_7, function(arg_24_0)
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
			local var_22_9 = var_22_6:GetChild(iter_22_0 - 1)

			setActive = var_1_10013

			var_1_10013(var_22_9, true)

			var_1_10013 = #var_22_8

			if 0 < var_1_10013 then
				table = var_1_10013
				var_1_10013 = var_1_10013.remove(var_22_8, 1)
				Equipment = var_14

				local var_22_10, var_22_11 = var_14.GetInfoTrans(var_1_10013, var_22_4)

				setText = var_16

				var_16(var_22_9:Find("tag"), var_22_10)

				setText = var_16

				var_16(var_22_9:Find("values/value"), var_22_11)

				setText = var_16

				var_16(var_22_9:Find("values/value_1"), "")
			end
		end

		Canvas = var_8

		var_8.ForceUpdateCanvases()

		local var_22_12 = var_22_1:Find("cont")

		;(function()
			local var_25_0 = var_22_12
			local var_25_1 = var_0.GetChild(var_25_0, 0)

			setText = var_2_10001

			local var_25_2 = var_25_1:Find("tag")

			i18n = var_2_10004

			var_2_10001(var_25_2, var_2_10004("spweapon_ui_effect_tag"))

			local var_25_3 = arg_22_1
			local var_25_4 = var_1.GetEffect(var_25_3)

			setActive = var_25_0

			var_25_0(var_25_1, var_25_4 and var_25_4 > 0)

			if not var_25_4 or not (0 < var_25_4) then
				return
			end

			setScrollText = var_25_0

			local var_25_5 = var_25_1:Find("value/Text")

			getSkillName = var_5

			var_25_0(var_25_5, var_5(var_25_4))

			return
		end)()

		local function var_22_13(arg_26_0)
			local var_26_0 = var_22_12
			local var_26_1 = var_1.GetChild(var_26_0, 1)

			setText = var_2_10002

			local var_26_2 = var_26_1:Find("tag")

			i18n = var_2_10005

			var_2_10002(var_26_2, var_2_10005("spweapon_ui_skill_tag"))

			setActive = var_2_10002

			var_2_10002(var_26_1, arg_26_0 and arg_26_0 > 0)

			if not arg_26_0 or not (0 < arg_26_0) then
				return
			end

			setScrollText = var_2_10002

			local var_26_3 = var_26_1:Find("value/Text")

			getSkillName = var_5

			var_2_10002(var_26_3, var_5(arg_26_0))

			return
		end

		if #arg_22_1:GetActiveUpgradableSkillList(var_22_4) == 0 then
			setActive = var_12

			var_12(var_22_12:GetChild(1), false)
		else
			var_22_13(iter_22_0[1].mapSkillID)
		end

		onButton = var_12

		local var_22_14 = arg_22_0
		local var_22_15 = var_22_0

		local function var_22_16()
			local var_27_0 = arg_22_0
			local var_27_1 = var_0.emit

			BaseUI = var_2_10003

			local var_27_2 = var_2_10003.ON_SPWEAPON
			local var_27_3 = {}

			SpWeaponInfoLayer = var_2_10005
			var_27_3.type = var_2_10005.TYPE_SHIP
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

		SFX_UI_DOCKYARD_EQUIPADD = var_1_10017

		var_12(var_22_14, var_22_15, var_22_16, var_1_10017)
	else
		onButton = var_22_6

		local var_22_17 = arg_22_0
		local var_22_18 = var_22_0

		local function var_22_19()
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

				ShipMainMediator = var_2_10005

				var_29_4(var_29_3, var_2_10005.ON_SELECT_SPWEAPON)
			end

			return
		end

		SFX_UI_DOCKYARD_EQUIPADD = iter_22_0

		var_22_6(var_22_17, var_22_18, var_22_19, iter_22_0)
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

	var_30_2(var_3.Find(var_30_3, "unsel"), not arg_30_0.contextData.isInEquipmentSkinPage)

	setActive = var_30_2

	local var_30_4 = arg_30_0.equipSkinBtn

	var_30_2(var_3.Find(var_30_4, "sel"), arg_30_0.contextData.isInEquipmentSkinPage)

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
