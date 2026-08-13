class = var_0_10000

local var_0_0 = "EquipmentInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EquipmentInfoUI"
end

var_0_1.PANEL_DESTROY = "Destroy"
var_0_1.PANEL_REVERT = "Revert"
var_0_1.Left = 1
var_0_1.Middle = 2
var_0_1.Right = 3
var_0_1.pos = {
	{
		-353,
		30,
		0
	},
	{
		0,
		30,
		0
	},
	{
		353,
		30,
		0
	}
}

function var_0_1.init(arg_2_0)
	local var_2_0 = {
		"default",
		"replace",
		"display",
		"destroy",
		"revert"
	}

	arg_2_0.toggles = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		local var_2_1 = iter_2_1 .. "Panel"
		local var_2_2 = arg_2_0._tf

		arg_2_0[var_2_1] = var_8.Find(var_2_2, iter_2_1)

		local var_2_3 = arg_2_0.toggles
		local var_2_4 = iter_2_1 .. "Panel"
		local var_2_5 = arg_2_0._tf

		var_2_3[var_2_4] = var_9.Find(var_2_5, "toggle_controll/" .. iter_2_1)
	end

	local var_2_6 = arg_2_0._tf

	arg_2_0.sample = var_2.Find(var_2_6, "sample")
	setActive = var_2

	var_2(arg_2_0.sample, false)

	setActive = var_2

	local var_2_7 = arg_2_0.defaultPanel

	var_2(var_4.Find(var_2_7, "transform_tip"), false)

	findTF = var_2
	arg_2_0.txtQuickEnable = var_2(arg_2_0._tf, "txtQuickEnable")
	setText = var_2

	local var_2_8 = arg_2_0.txtQuickEnable

	i18n = var_5

	var_2(var_2_8, var_5("ship_equip_check"))

	EquipDestoryConfirmWindow = var_2
	arg_2_0.equipDestroyConfirmWindow = var_2.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_1.setEquipment(arg_3_0, arg_3_1)
	arg_3_0.equipmentVO = arg_3_1

	return
end

function var_0_1.setShip(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.shipVO = arg_4_1
	arg_4_0.oldShipVO = arg_4_2

	return
end

function var_0_1.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_1.checkOverGold(arg_6_0, arg_6_1)
	_ = var_1_10002

	local var_6_0

	if not var_1_10002.detect(arg_6_1, function(arg_7_0)
		local var_7_0 = arg_7_0.type

		DROP_TYPE_RESOURCE = var_2_10002

		return var_7_0 == var_2_10002 and arg_7_0.id == 1
	end).count then
		var_6_0 = 0
	end

	local var_6_1 = arg_6_0.player

	if var_3.GoldMax(var_6_1, var_6_0) then
		pg = var_3

		local var_6_2 = var_3.TipsMgr.GetInstance()
		local var_6_3 = var_3.ShowTips

		i18n = var_6

		local var_6_4 = var_6("gold_max_tip_title")

		i18n = var_1_10007

		var_6_3(var_6_2, var_6_4 .. var_1_10007("resource_max_tip_destroy"))

		return false
	end

	return true
end

function var_0_1.setDestroyCount(arg_8_0, arg_8_1)
	math = var_1_10002
	arg_8_1 = var_1_10002.clamp(arg_8_1, 1, arg_8_0.equipmentVO.count)

	if arg_8_0.destroyCount ~= arg_8_1 then
		arg_8_0.destroyCount = arg_8_1

		arg_8_0:updateDestroyCount()
	end

	return
end

function var_0_1.didEnter(arg_9_0)
	setActive = var_1_10001

	local var_9_0 = arg_9_0.txtQuickEnable
	local var_9_1

	if not arg_9_0.contextData.quickFlag then
		var_9_1 = false
	end

	var_1_10001(var_9_0, var_9_1)

	defaultValue = var_1_10001

	local var_9_2 = arg_9_0.contextData.type

	EquipmentInfoMediator = var_9_1

	local var_9_3 = var_1_10001(var_9_2, var_9_1.TYPE_DEFAULT)

	table = var_1_10002

	local var_9_4 = var_1_10002.contains

	EquipmentInfoMediator = var_4
	arg_9_0.isShowUnique = var_9_4(var_4.SHOW_UNIQUE, var_9_3)
	onButton = var_2

	local var_9_5 = arg_9_0
	local var_9_6 = arg_9_0._tf
	local var_9_7 = var_5.Find(var_9_6, "bg")

	local function var_9_8()
		isActive = var_2_10000

		if var_2_10000(arg_9_0.destroyPanel) then
			triggerToggle = var_0

			var_0(arg_9_0.toggles.defaultPanel, true)

			return
		end

		local var_10_0 = arg_9_0

		var_0.closeView(var_10_0)

		return
	end

	SOUND_BACK = var_9_6

	var_2(var_9_5, var_9_7, var_9_8, var_9_6)
	arg_9_0:initAndSetBtn(var_9_3)

	EquipmentInfoMediator = var_2

	if var_9_3 == var_2.TYPE_DEFAULT then
		arg_9_0:updateOperation1()
	else
		EquipmentInfoMediator = var_2

		if var_9_3 == var_2.TYPE_SHIP then
			arg_9_0:updateOperation2()
		else
			EquipmentInfoMediator = var_2

			if var_9_3 == var_2.TYPE_REPLACE then
				arg_9_0:updateOperation3()
			else
				EquipmentInfoMediator = var_2

				if var_9_3 == var_2.TYPE_DISPLAY then
					arg_9_0:updateOperation4()
				end
			end
		end
	end

	pg = var_2

	local var_9_9 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_9_9, arg_9_0._tf)

	return
end

function var_0_1.initAndSetBtn(arg_11_0, arg_11_1)
	EquipmentInfoMediator = var_1_10002

	if arg_11_1 ~= var_1_10002.TYPE_DEFAULT then
		EquipmentInfoMediator = var_11_1

		local var_11_1

		if arg_11_1 == var_11_1.TYPE_SHIP then
			local var_11_0 = arg_11_0.defaultPanel

			if not var_11_1.Find(var_11_0, "equipment") then
				var_11_1 = arg_11_0:cloneSampleTo(arg_11_0.defaultPanel, var_0_1.Middle, "equipment")
			end

			arg_11_0.defaultEquipTF = var_11_1

			local var_11_2 = arg_11_0.defaultPanel

			arg_11_0.defaultReplaceBtn = var_11_1.Find(var_11_2, "actions/action_button_3")

			local var_11_3 = arg_11_0.defaultPanel

			arg_11_0.defaultDestroyBtn = var_11_1.Find(var_11_3, "actions/action_button_1")

			local var_11_4 = arg_11_0.defaultPanel

			arg_11_0.defaultEnhanceBtn = var_11_1.Find(var_11_4, "actions/action_button_2")

			local var_11_5 = arg_11_0.defaultPanel

			arg_11_0.defaultUnloadBtn = var_11_1.Find(var_11_5, "actions/action_button_4")

			local var_11_6 = arg_11_0.defaultEquipTF

			arg_11_0.defaultRevertBtn = var_11_1.Find(var_11_6, "info/equip/revert_btn")

			local var_11_7 = arg_11_0.defaultEquipTF

			arg_11_0.defaultTransformTipBar = var_11_1.Find(var_11_7, "transform_tip")
			EquipmentInfoMediator = var_11_1

			if arg_11_1 == var_11_1.TYPE_DEFAULT and not arg_11_0.defaultTransformTipBar then
				local var_11_8 = arg_11_0.defaultPanel

				var_11_1 = var_11_1.Find(var_11_8, "transform_tip")
				setParent = var_1_10003

				var_1_10003(var_11_1, arg_11_0.defaultEquipTF)

				var_1_10003 = var_11_1.sizeDelta
				var_1_10003.y = 0
				var_11_1.sizeDelta = var_1_10003
				setAnchoredPosition = var_4

				local var_11_9 = var_11_1

				Vector2 = var_1_10007

				var_4(var_11_9, var_1_10007.zero)

				arg_11_0.defaultTransformTipBar = var_11_1
			end

			onButton = var_11_1

			local var_11_10 = arg_11_0
			local var_11_11 = arg_11_0.defaultReplaceBtn

			local function var_11_12()
				ShipStatus = var_2_10000

				local var_12_0, var_12_1 = var_2_10000.ShipStatusCheck("onModify", arg_11_0.shipVO)

				if not var_12_0 then
					pg = var_2

					local var_12_2 = var_2.TipsMgr.GetInstance()

					var_2.ShowTips(var_12_2, var_12_1)

					return
				end

				local var_12_3 = arg_11_0
				local var_12_4 = var_2.emit

				EquipmentInfoMediator = var_2_10005

				var_12_4(var_12_3, var_2_10005.ON_CHANGE)

				return
			end

			SFX_PANEL = var_1_10007

			var_11_1(var_11_10, var_11_11, var_11_12, var_1_10007)

			onButton = var_11_1

			local var_11_13 = arg_11_0
			local var_11_14 = arg_11_0.defaultEnhanceBtn

			local function var_11_15()
				if arg_11_0.shipVO then
					ShipStatus = var_0

					local var_13_0, var_13_1 = var_0.ShipStatusCheck("onModify", arg_11_0.shipVO)

					if not var_13_0 then
						pg = var_2

						local var_13_2 = var_2.TipsMgr.GetInstance()

						var_2.ShowTips(var_13_2, var_13_1)

						return
					end
				end

				local var_13_3 = arg_11_0
				local var_13_4 = var_0.emit

				EquipmentInfoMediator = var_2_10003

				var_13_4(var_13_3, var_2_10003.ON_INTENSIFY)

				return
			end

			SFX_PANEL = var_1_10007

			var_11_1(var_11_13, var_11_14, var_11_15, var_1_10007)

			onButton = var_11_1

			local var_11_16 = arg_11_0
			local var_11_17 = arg_11_0.defaultUnloadBtn

			local function var_11_18()
				ShipStatus = var_2_10000

				local var_14_0, var_14_1 = var_2_10000.ShipStatusCheck("onModify", arg_11_0.shipVO)

				if not var_14_0 then
					pg = var_2

					local var_14_2 = var_2.TipsMgr.GetInstance()

					var_2.ShowTips(var_14_2, var_14_1)

					return
				end

				local var_14_3 = arg_11_0
				local var_14_4 = var_2.emit

				EquipmentInfoMediator = var_2_10005

				var_14_4(var_14_3, var_2_10005.ON_UNEQUIP)

				return
			end

			SFX_UI_DOCKYARD_EQUIPOFF = var_1_10007

			var_11_1(var_11_16, var_11_17, var_11_18, var_1_10007)

			onButton = var_11_1

			local var_11_19 = arg_11_0
			local var_11_20 = arg_11_0.defaultDestroyBtn

			local function var_11_21()
				triggerToggle = var_2_10000

				var_2_10000(arg_11_0.toggles.destroyPanel, true)

				if not arg_11_0.initDestroyPanel then
					local var_15_0 = arg_11_0

					var_0.initAndSetBtn(var_15_0, var_0_1.PANEL_DESTROY)
				end

				local var_15_1 = arg_11_0

				var_0.updateEquipmentPanel(var_15_1, arg_11_0.destroyEquipTF, arg_11_0.equipmentVO)

				if arg_11_0.equipmentVO.count > 0 then
					local var_15_2 = arg_11_0

					var_0.setDestroyCount(var_15_2, 1)
				end

				return
			end

			SFX_PANEL = var_1_10007

			var_11_1(var_11_19, var_11_20, var_11_21, var_1_10007)

			onButton = var_11_1

			local var_11_22 = arg_11_0
			local var_11_23 = arg_11_0.defaultRevertBtn

			local function var_11_24()
				triggerToggle = var_2_10000

				var_2_10000(arg_11_0.toggles.revertPanel, true)

				if not arg_11_0.initRevertPanel then
					local var_16_0 = arg_11_0

					var_0.initAndSetBtn(var_16_0, var_0_1.PANEL_REVERT)
				end

				local var_16_1 = arg_11_0

				var_0.updateRevertPanel(var_16_1)

				return
			end

			SFX_PANEL = var_1_10007

			var_11_1(var_11_22, var_11_23, var_11_24, var_1_10007)
		else
			EquipmentInfoMediator = var_11_1

			local var_11_26

			if arg_11_1 == var_11_1.TYPE_REPLACE then
				local var_11_25 = arg_11_0.replacePanel

				if not var_11_26.Find(var_11_25, "equipment") then
					var_11_26 = arg_11_0:cloneSampleTo(arg_11_0.replacePanel, var_0_1.Left, "equipment")
				end

				arg_11_0.replaceSrcEquipTF = var_11_26

				local var_11_27 = arg_11_0.replacePanel

				if not var_11_26.Find(var_11_27, "equipment_on_ship") then
					var_11_26 = arg_11_0:cloneSampleTo(arg_11_0.replacePanel, var_0_1.Right, "equipment_on_ship")
				end

				arg_11_0.replaceDstEquipTF = var_11_26

				local var_11_28 = arg_11_0.replacePanel

				arg_11_0.replaceCancelBtn = var_11_26.Find(var_11_28, "actions/cancel_button")

				local var_11_29 = arg_11_0.replacePanel

				arg_11_0.replaceConfirmBtn = var_11_26.Find(var_11_29, "actions/action_button_2")
				onButton = var_11_26

				local var_11_30 = arg_11_0
				local var_11_31 = arg_11_0.replaceCancelBtn

				local function var_11_32()
					isActive = var_2_10000

					if var_2_10000(arg_11_0.destroyPanel) then
						triggerToggle = var_0

						var_0(arg_11_0.toggles.defaultPanel, true)

						return
					end

					local var_17_0 = arg_11_0

					var_0.closeView(var_17_0)

					return
				end

				SFX_CANCEL = var_1_10007

				var_11_26(var_11_30, var_11_31, var_11_32, var_1_10007)

				onButton = var_11_26

				local var_11_33 = arg_11_0
				local var_11_34 = arg_11_0.replaceConfirmBtn

				local function var_11_35()
					local var_18_0 = arg_11_0.shipVO
					local var_18_1, var_18_2 = var_0.canEquipAtPos(var_18_0, arg_11_0.equipmentVO, arg_11_0.contextData.pos)

					if not var_18_1 then
						pg = var_18_0

						local var_18_3 = var_18_0.TipsMgr.GetInstance()
						local var_18_4 = var_2.ShowTips

						i18n = var_2_10005

						var_18_4(var_18_3, var_2_10005("equipment_equipmentInfoLayer_error_canNotEquip", var_18_2))

						return
					end

					if arg_11_0.contextData.quickCallback then
						arg_11_0.contextData.quickCallback()

						local var_18_5 = arg_11_0

						var_2.closeView(var_18_5)
					else
						local var_18_6 = arg_11_0
						local var_18_7 = var_2.emit

						EquipmentInfoMediator = var_2_10005

						var_18_7(var_18_6, var_2_10005.ON_EQUIP)
					end

					return
				end

				SFX_UI_DOCKYARD_EQUIPADD = var_1_10007

				var_11_26(var_11_33, var_11_34, var_11_35, var_1_10007)
			else
				EquipmentInfoMediator = var_11_26

				if arg_11_1 == var_11_26.TYPE_DISPLAY then
					local var_11_36 = arg_11_0.displayPanel
					local var_11_37

					if not var_2.Find(var_11_36, "equipment") then
						var_11_37 = arg_11_0:cloneSampleTo(arg_11_0.displayPanel, var_0_1.Middle, "equipment")
					end

					arg_11_0.displayEquipTF = var_11_37

					local var_11_38 = arg_11_0.displayPanel

					arg_11_0.displayMoveBtn = var_2.Find(var_11_38, "actions/move_button")

					local var_11_39 = arg_11_0.displayEquipTF

					arg_11_0.defaultTransformTipBar = var_2.Find(var_11_39, "transform_tip")

					local var_11_41

					if arg_11_0.contextData.showTransformTip and not arg_11_0.defaultTransformTipBar then
						local var_11_40 = arg_11_0.defaultPanel

						var_11_41 = var_11_41.Find(var_11_40, "transform_tip")
						setParent = var_1_10003

						var_1_10003(var_11_41, arg_11_0.displayEquipTF)

						local var_11_42 = var_11_41.sizeDelta

						var_11_42.y = 0
						var_11_41.sizeDelta = var_11_42
						setAnchoredPosition = var_4

						local var_11_43 = var_11_41

						Vector2 = var_1_10007

						var_4(var_11_43, var_1_10007.zero)

						arg_11_0.defaultTransformTipBar = var_11_41
					end

					onButton = var_11_41

					var_11_41(arg_11_0, arg_11_0.displayMoveBtn, function()
						local var_19_0 = arg_11_0
						local var_19_1 = var_0.emit

						EquipmentInfoMediator = var_2_10003

						var_19_1(var_19_0, var_2_10003.ON_MOVE, arg_11_0.shipVO.id)

						return
					end)
				elseif arg_11_1 == var_0_1.PANEL_DESTROY then
					arg_11_0.initDestroyPanel = true

					local var_11_44 = arg_11_0.destroyPanel
					local var_11_45

					if not var_2.Find(var_11_44, "equipment") then
						var_11_45 = arg_11_0:cloneSampleTo(arg_11_0.destroyPanel, var_0_1.Left, "equipment")
					end

					arg_11_0.destroyEquipTF = var_11_45

					local var_11_46 = arg_11_0.destroyPanel

					arg_11_0.destroyCounter = var_2.Find(var_11_46, "destroy")

					local var_11_47 = arg_11_0.destroyCounter

					arg_11_0.destroyValue = var_2.Find(var_11_47, "count/number_panel/value")

					local var_11_48 = arg_11_0.destroyCounter

					arg_11_0.destroyLeftButton = var_2.Find(var_11_48, "count/number_panel/left")

					local var_11_49 = arg_11_0.destroyCounter

					arg_11_0.destroyRightButton = var_2.Find(var_11_49, "count/number_panel/right")

					local var_11_50 = arg_11_0.destroyCounter

					arg_11_0.destroyBonusList = var_2.Find(var_11_50, "got/list")

					local var_11_51 = arg_11_0.destroyCounter

					arg_11_0.destroyBonusItem = var_2.Find(var_11_51, "got/item")

					local var_11_52 = arg_11_0.destroyPanel

					arg_11_0.destroyCancelBtn = var_2.Find(var_11_52, "actions/cancel_button")

					local var_11_53 = arg_11_0.destroyPanel

					arg_11_0.destroyConfirmBtn = var_2.Find(var_11_53, "actions/destroy_button")
					onButton = var_2

					local var_11_54 = arg_11_0
					local var_11_55 = arg_11_0.destroyLeftButton

					local function var_11_56()
						local var_20_0 = arg_11_0

						var_0.setDestroyCount(var_20_0, arg_11_0.destroyCount - 1)

						return
					end

					SFX_PANEL = var_1_10007

					var_2(var_11_54, var_11_55, var_11_56, var_1_10007)

					onButton = var_2

					local var_11_57 = arg_11_0
					local var_11_58 = arg_11_0.destroyRightButton

					local function var_11_59()
						local var_21_0 = arg_11_0

						var_0.setDestroyCount(var_21_0, arg_11_0.destroyCount + 1)

						return
					end

					SFX_PANEL = var_1_10007

					var_2(var_11_57, var_11_58, var_11_59, var_1_10007)

					onButton = var_2

					local var_11_60 = arg_11_0

					var_1_10007 = arg_11_0.destroyCounter

					local var_11_61 = var_5.Find(var_1_10007, "count/max")

					local function var_11_62()
						local var_22_0 = arg_11_0

						var_0.setDestroyCount(var_22_0, arg_11_0.equipmentVO.count)

						return
					end

					SFX_PANEL = var_1_10007

					var_2(var_11_60, var_11_61, var_11_62, var_1_10007)

					onButton = var_2

					local var_11_63 = arg_11_0
					local var_11_64 = arg_11_0.destroyCancelBtn

					local function var_11_65()
						triggerToggle = var_2_10000

						var_2_10000(arg_11_0.toggles.defaultPanel, true)

						return
					end

					SFX_CANCEL = var_1_10007

					var_2(var_11_63, var_11_64, var_11_65, var_1_10007)

					onButton = var_2

					local var_11_66 = arg_11_0
					local var_11_67 = arg_11_0.destroyConfirmBtn

					local function var_11_68()
						local var_24_0 = arg_11_0

						if not var_0.checkOverGold(var_24_0, arg_11_0.awards) then
							return
						end

						local var_24_1 = {}
						local var_24_2 = arg_11_0.equipmentVO

						if var_1.isImportance(var_24_2) then
							table = var_1

							var_1.insert(var_24_1, function(arg_25_0)
								local var_25_0 = arg_11_0.equipDestroyConfirmWindow

								var_1.Load(var_25_0)

								local var_25_1 = arg_11_0.equipDestroyConfirmWindow
								local var_25_2 = var_1.ActionInvoke
								local var_25_3 = "Show"
								local var_25_4 = {}

								setmetatable = var_3_10006
								var_25_4[1] = var_3_10006({
									count = arg_11_0.destroyCount
								}, {
									__index = arg_11_0.equipmentVO
								})

								var_25_2(var_25_1, var_25_3, var_25_4, arg_25_0)

								return
							end)
						end

						seriesAsync = var_1

						var_1(var_24_1, function()
							local var_26_0 = arg_11_0
							local var_26_1 = var_0.emit

							EquipmentInfoMediator = var_3_10003

							var_26_1(var_26_0, var_3_10003.ON_DESTROY, arg_11_0.destroyCount)

							return
						end)

						return
					end

					SFX_UI_EQUIPMENT_RESOLVE = var_1_10007

					var_2(var_11_66, var_11_67, var_11_68, var_1_10007)
				elseif arg_11_1 == var_0_1.PANEL_REVERT then
					arg_11_0.initRevertPanel = true

					local var_11_69 = arg_11_0.revertPanel
					local var_11_70

					if not var_2.Find(var_11_69, "equipment") then
						var_11_70 = arg_11_0:cloneSampleTo(arg_11_0.revertPanel, var_0_1.Left, "equipment")
					end

					arg_11_0.revertEquipTF = var_11_70

					local var_11_71 = arg_11_0.revertPanel

					arg_11_0.revertAwardContainer = var_2.Find(var_11_71, "item_panel/got/list")

					local var_11_72 = arg_11_0.revertPanel

					arg_11_0.revertCancelBtn = var_2.Find(var_11_72, "actions/cancel_button")

					local var_11_73 = arg_11_0.revertPanel

					arg_11_0.revertConfirmBtn = var_2.Find(var_11_73, "actions/revert_button")
					arg_11_0.itemTpl = arg_11_0:getTpl("item_panel/got/item", arg_11_0.revertPanel)
					onButton = var_2

					local var_11_74 = arg_11_0
					local var_11_75 = arg_11_0.revertCancelBtn

					local function var_11_76()
						triggerToggle = var_2_10000

						var_2_10000(arg_11_0.toggles.defaultPanel, true)

						return
					end

					SFX_CANCEL = var_1_10007

					var_2(var_11_74, var_11_75, var_11_76, var_1_10007)

					onButton = var_2

					local var_11_77 = arg_11_0
					local var_11_78 = arg_11_0.revertConfirmBtn

					local function var_11_79()
						local var_28_0 = arg_11_0

						if not var_0.checkOverGold(var_28_0, arg_11_0.awards) then
							return
						end

						local var_28_1 = arg_11_0.equipmentVO
						local var_28_2 = arg_11_0
						local var_28_3 = var_1.emit

						EquipmentInfoMediator = var_2_10004

						var_28_3(var_28_2, var_2_10004.ON_REVERT, var_28_1.id)

						return
					end

					SFX_UI_EQUIPMENT_RESOLVE = var_1_10007

					var_2(var_11_77, var_11_78, var_11_79, var_1_10007)
				end
			end
		end

		return
	end
end

function var_0_1.updateOperation1(arg_29_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_29_0.toggles.defaultPanel, true)
	arg_29_0:updateEquipmentPanel(arg_29_0.defaultEquipTF, arg_29_0.equipmentVO)

	setActive = var_1

	local var_29_0 = arg_29_0.defaultRevertBtn

	LOCK_EQUIP_REVERT = var_29_3

	if not var_29_3 then
		if arg_29_0.fromEquipmentView then
			local var_29_1 = arg_29_0.equipmentVO

			if var_29_3.getConfig(var_29_1, "level") > 1 then
				getProxy = var_29_3
				BagProxy = var_29_1

				local var_29_2 = var_29_3(var_29_1)
				local var_29_3 = var_29_3.getItemCountById

				Item = var_7

				if not (var_29_3(var_29_2, var_7.REVERT_EQUIPMENT_ID) > 0) then
					var_29_3 = false
				else
					var_29_3 = true
				end

				var_1(var_29_0, var_29_3)

				setActive = var_1

				var_1(arg_29_0.defaultReplaceBtn, false)

				setActive = var_1

				var_1(arg_29_0.defaultUnloadBtn, false)

				setActive = var_1

				local var_29_4 = arg_29_0.defaultDestroyBtn
				local var_29_5

				if arg_29_0.contextData.destroy then
					var_29_5 = arg_29_0.equipmentVO.count > 0
				end

				var_1(var_29_4, var_29_5)
				arg_29_0:UpdateTransformTipBar(arg_29_0.equipmentVO)

				return
			end
		end
	end
end

function var_0_1.updateOperation2(arg_30_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_30_0.toggles.defaultPanel, true)

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.updateEquipmentPanel
	local var_30_2 = arg_30_0.defaultEquipTF
	local var_30_3 = arg_30_0.shipVO

	var_30_1(var_30_0, var_30_2, var_5.getEquip(var_30_3, arg_30_0.contextData.pos))

	setActive = var_30_1

	var_30_1(arg_30_0.defaultDestroyBtn, false)

	setActive = var_30_1

	var_30_1(arg_30_0.defaultReplaceBtn, true)

	setActive = var_30_1

	var_30_1(arg_30_0.defaultUnloadBtn, true)

	setActive = var_30_1

	var_30_1(arg_30_0.defaultRevertBtn, false)

	local var_30_4 = arg_30_0.defaultEquipTF
	local var_30_5 = var_1.Find(var_30_4, "head")

	setActive = var_1_10002

	var_1_10002(var_30_5, arg_30_0.shipVO)

	if arg_30_0.shipVO then
		setImageSprite = var_2
		findTF = var_4

		local var_30_6 = var_4(var_30_5, "Image")

		LoadSprite = var_5

		local var_30_7 = "qicon/"
		local var_30_8 = arg_30_0.shipVO

		var_2(var_30_6, var_5(var_30_7 .. var_8.getPainting(var_30_8)))
	end

	if arg_30_0.defaultTransformTipBar then
		setActive = var_2

		var_2(arg_30_0.defaultTransformTipBar, false)
	end

	return
end

function var_0_1.updateOperation3(arg_31_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_31_0.toggles.replacePanel, true)

	local var_31_0 = arg_31_0.shipVO

	if var_1.getEquip(var_31_0, arg_31_0.contextData.pos) then
		local var_31_1 = var_1
		local var_31_2 = var_1.GetPropertiesInfo(var_31_1)
		local var_31_3 = arg_31_0.equipmentVO

		var_31_0 = var_31_0.GetPropertiesInfo(var_31_3)
		EquipType = var_31_1

		local var_31_4 = var_31_1.getCompareGroup(var_1.configId)

		EquipType = var_31_3

		if var_31_4 == var_31_3.getCompareGroup(arg_31_0.equipmentVO.configId) then
			Equipment = var_31_4

			var_31_4.InsertAttrsCompare(var_31_2.attrs, var_31_0.attrs, arg_31_0.shipVO)
		end

		arg_31_0:updateEquipmentPanel(arg_31_0.replaceSrcEquipTF, var_1, var_31_2)
		arg_31_0:updateEquipmentPanel(arg_31_0.replaceDstEquipTF, arg_31_0.equipmentVO, var_31_0)
	else
		arg_31_0:updateEquipmentPanel(arg_31_0.replaceSrcEquipTF, var_1)
		arg_31_0:updateEquipmentPanel(arg_31_0.replaceDstEquipTF, arg_31_0.equipmentVO)
	end

	local var_31_5 = arg_31_0.replaceDstEquipTF
	local var_31_6 = var_2.Find(var_31_5, "head")

	setActive = var_31_0

	var_31_0(var_31_6, arg_31_0.oldShipVO)

	if arg_31_0.oldShipVO then
		setImageSprite = var_3
		findTF = var_5

		local var_31_7 = var_5(var_31_6, "Image")

		LoadSprite = var_6

		local var_31_8 = "qicon/"
		local var_31_9 = arg_31_0.oldShipVO

		var_3(var_31_7, var_6(var_31_8 .. var_9.getPainting(var_31_9)))
	end

	return
end

function var_0_1.updateOperation4(arg_32_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_32_0.toggles.displayPanel, true)
	arg_32_0:updateEquipmentPanel(arg_32_0.displayEquipTF, arg_32_0.equipmentVO)

	setActive = var_1

	var_1(arg_32_0.displayMoveBtn, arg_32_0.shipVO)

	local var_32_0 = arg_32_0.displayEquipTF
	local var_32_1 = var_1.Find(var_32_0, "head")

	setActive = var_1_10002

	var_1_10002(var_32_1, arg_32_0.shipVO)

	if arg_32_0.shipVO then
		setImageSprite = var_2
		findTF = var_4

		local var_32_2 = var_4(var_32_1, "Image")

		LoadSprite = var_5

		local var_32_3 = "qicon/"
		local var_32_4 = arg_32_0.shipVO

		var_2(var_32_2, var_5(var_32_3 .. var_8.getPainting(var_32_4)))
	end

	arg_32_0:UpdateTransformTipBar(arg_32_0.equipmentVO)

	return
end

function var_0_1.updateRevertPanel(arg_33_0)
	local var_33_0 = arg_33_0.equipmentVO
	local var_33_1 = var_1.GetRootEquipment(var_33_0)
	local var_33_2 = arg_33_0.equipmentVO
	local var_33_3 = var_2.GetPropertiesInfo(var_33_2)
	local var_33_4 = var_33_1:GetPropertiesInfo()

	Equipment = var_33_2

	var_33_2.InsertAttrsCompare(var_33_3.attrs, var_33_4.attrs, arg_33_0.shipVO)

	local var_33_5 = arg_33_0
	local var_33_6 = arg_33_0.updateEquipmentPanel
	local var_33_7 = arg_33_0.revertEquipTF
	local var_33_8 = var_33_1
	local var_33_9 = var_33_4
	local var_33_10 = arg_33_0.equipmentVO

	var_33_6(var_33_5, var_33_7, var_33_8, var_33_9, var_10.getConfig(var_33_10, "level"))

	local var_33_11 = arg_33_0
	local var_33_12 = arg_33_0.updateOperationAward
	local var_33_13 = arg_33_0.revertAwardContainer
	local var_33_14 = arg_33_0.itemTpl
	local var_33_15 = arg_33_0.equipmentVO

	var_33_12(var_33_11, var_33_13, var_33_14, var_9.getRevertAwards(var_33_15))

	return
end

function var_0_1.updateDestroyCount(arg_34_0)
	local var_34_0 = arg_34_0.destroyCount

	setText = var_1_10002

	var_1_10002(arg_34_0.destroyValue, var_34_0)

	local var_34_1 = {}
	local var_34_2 = 0
	local var_34_3 = arg_34_0.equipmentVO
	local var_34_4

	if not var_4.getConfig(var_34_3, "destory_item") then
		var_34_4 = {}
	end

	local var_34_5 = arg_34_0.equipmentVO
	local var_34_6

	if not var_5.getConfig(var_34_5, "destory_gold") then
		var_34_6 = 0
	end

	local var_34_7 = var_34_2 + var_34_6 * var_34_0

	ipairs = var_6

	for iter_34_0, iter_34_1 in var_6(var_34_4) do
		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_34_8 = var_34_1
		local var_34_9 = {}

		DROP_TYPE_ITEM = var_1_10015
		var_34_9.type = var_1_10015
		var_34_9.id = iter_34_1[1]
		var_34_9.count = iter_34_1[2] * var_34_0

		var_1_10011(var_34_8, var_34_9)
	end

	table = var_6

	local var_34_10 = var_6.insert
	local var_34_11 = var_34_1
	local var_34_12 = {
		id = 1
	}

	DROP_TYPE_RESOURCE = iter_34_1
	var_34_12.type = iter_34_1
	var_34_12.count = var_34_7

	var_34_10(var_34_11, var_34_12)
	arg_34_0:updateOperationAward(arg_34_0.destroyBonusList, arg_34_0.destroyBonusItem, var_34_1)

	return
end

function var_0_1.updateOperationAward(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0.awards = arg_35_3

	if arg_35_1.childCount == 0 then
		for iter_35_0 = 1, #arg_35_3 do
			cloneTplTo = var_1_10008

			var_1_10008(arg_35_2, arg_35_1)
		end
	end

	for iter_35_1 = 1, #arg_35_3 do
		local var_35_0 = arg_35_1
		local var_35_1 = arg_35_1.GetChild(var_35_0, iter_35_1 - 1)
		local var_35_2 = arg_35_3[iter_35_1]

		updateDrop = var_35_0

		var_35_0(var_35_1, var_35_2)

		onButton = var_35_0

		local var_35_3 = arg_35_0
		local var_35_4 = var_35_1

		local function var_35_5()
			local var_36_0 = arg_35_0

			var_0.emit(var_36_0, var_0_1.ON_DROP, var_35_2)

			return
		end

		SFX_PANEL = var_1_10015

		var_35_0(var_35_3, var_35_4, var_35_5, var_1_10015)

		setText = var_35_0
		findTF = var_35_3

		local var_35_6 = var_35_3(var_35_1, "name_panel/name")

		getText = var_35_4
		findTF = var_1_10015

		var_35_0(var_35_6, var_35_4(var_1_10015(var_35_1, "name")))

		setText = var_35_0
		findTF = var_35_6

		local var_35_7 = var_35_6(var_35_1, "name_panel/number")
		local var_35_8 = " x "

		getText = var_14
		findTF = var_1_10016

		var_35_0(var_35_7, var_35_8 .. var_14(var_1_10016(var_35_1, "icon_bg/count")))

		setActive = var_35_0
		findTF = var_35_7

		var_35_0(var_35_7(var_35_1, "icon_bg/count"), false)
	end

	return
end

function var_0_1.updateEquipmentPanel(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = arg_37_1
	local var_37_1 = arg_37_1.Find(var_37_0, "info")
	local var_37_2 = arg_37_1
	local var_37_3 = arg_37_1.Find(var_37_2, "empty")

	setActive = var_37_0

	var_37_0(var_37_1, arg_37_2)

	setActive = var_37_0

	var_37_0(var_37_3, not arg_37_2)

	if arg_37_2 then
		findTF = var_37_0

		local var_37_4 = var_37_0(var_37_1, "name")

		setScrollText = var_37_2
		findTF = var_10

		var_37_2(var_10(var_37_4, "mask/Text"), arg_37_2:getConfig("name"))

		setActive = var_37_2
		findTF = var_10

		local var_37_5 = var_10(var_37_4, "unique")
		local var_37_6

		if arg_37_2:isUnique() then
			var_37_6 = arg_37_0.isShowUnique
		end

		var_37_2(var_37_5, var_37_6)

		findTF = var_37_2

		local var_37_7 = var_37_2(var_37_1, "equip")

		setImageSprite = var_9
		findTF = var_11

		local var_37_8 = var_11(var_37_7, "bg")

		GetSpriteFromAtlas = var_12

		local var_37_9 = "ui/equipmentinfoui_atlas"
		local var_37_10 = "equip_bg_"

		EquipmentRarity = var_1_10016

		var_9(var_37_8, var_12(var_37_9, var_37_10 .. var_1_10016.Rarity2Print(arg_37_2:getConfig("rarity"))))

		updateEquipment = var_9

		var_9(var_37_7, arg_37_2, {
			noIconColorful = true
		})

		setActive = var_9
		findTF = var_11

		var_9(var_11(var_37_7, "revert_btn"), false)

		setActive = var_9
		findTF = var_11

		var_9(var_11(var_37_7, "slv"), arg_37_4 or arg_37_2:getConfig("level") > 1)

		setText = var_9
		findTF = var_11

		local var_37_11 = var_11(var_37_7, "slv/Text")
		local var_37_12

		if not arg_37_4 or not (arg_37_4 - 1) then
			var_37_12 = arg_37_2:getConfig("level") - 1
		end

		var_9(var_37_11, var_37_12)

		setActive = var_9
		findTF = var_37_11

		var_9(var_37_11(var_37_7, "slv/next"), arg_37_4)

		setText = var_9
		findTF = var_11

		var_9(var_11(var_37_7, "slv/next/Text"), arg_37_2:getConfig("level") - 1)

		local var_37_13 = var_37_7
		local var_37_14 = var_37_7.Find(var_37_13, "tier")

		setActive = var_10

		var_10(var_37_14, arg_37_2)

		local var_37_15

		if not arg_37_2:getConfig("tech") then
			var_37_15 = 1
		end

		eachChild = var_37_13

		var_37_13(var_37_14, function(arg_38_0)
			setActive = var_2_10001

			local var_38_0 = arg_38_0

			tostring = var_2_10004

			var_2_10001(var_38_0, var_2_10004(var_37_15) == arg_38_0.gameObject.name)

			return
		end)

		setImageSprite = var_37_13
		findTF = var_13

		local var_37_16 = var_13(var_37_7, "title")

		GetSpriteFromAtlas = var_14

		local var_37_17 = "equiptype"

		EquipType = var_1_10017

		var_37_13(var_37_16, var_14(var_37_17, var_1_10017.type2Tag(arg_37_2:getConfig("type"))))

		setText = var_37_13

		local var_37_18 = var_37_7:Find("speciality/Text")
		local var_37_19

		if arg_37_2:getConfig("speciality") == "无" or not arg_37_2:getConfig("speciality") then
			i18n1 = var_37_19
			var_37_19 = var_37_19("—")
		end

		var_37_13(var_37_18, var_37_19)

		updateEquipInfo = var_37_13

		var_37_13(var_37_1:Find("attributes/view/content"), arg_37_3 or arg_37_2:GetPropertiesInfo(), arg_37_2:GetSkill(), arg_37_0.shipVO)
	end

	return
end

function var_0_1.UpdateTransformTipBar(arg_39_0, arg_39_1)
	if not arg_39_0.defaultTransformTipBar then
		return
	end

	pg = var_2

	local var_39_0 = var_2.SystemOpenMgr.GetInstance()
	local var_39_1 = var_2.isOpenSystem

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_39_2 = var_1_10005(var_1_10007)
	local var_39_3 = var_39_1(var_39_0, var_5.getData(var_39_2).level, "EquipmentTransformTreeMediator")

	EquipmentProxy = var_1_10003

	local var_39_4 = var_1_10003.GetTransformTargets

	Equipment = var_5

	local var_39_5 = var_39_4(var_5.GetEquipRootStatic(arg_39_1.id))

	setActive = var_39_0

	local var_39_6 = arg_39_0.defaultTransformTipBar

	LOCK_EQUIPMENT_TRANSFORM = var_7

	var_39_0(var_39_6, not var_7 and var_39_3 and #var_39_5 > 0)

	isActive = var_39_0

	if var_39_0(arg_39_0.defaultTransformTipBar) then
		pg = var_4

		local var_39_7 = var_4.equip_upgrade_data

		UIItemList = var_5

		local var_39_8 = var_5.StaticAlign
		local var_39_9 = arg_39_0.defaultTransformTipBar
		local var_39_10 = var_7.Find(var_39_9, "list")
		local var_39_11 = arg_39_0.defaultTransformTipBar

		var_39_8(var_39_10, var_8.Find(var_39_11, "list/transformTarget"), #var_39_5, function(arg_40_0, arg_40_1, arg_40_2)
			UIItemList = var_2_10003

			if arg_40_0 == var_2_10003.EventUpdate then
				setActive = var_3

				var_3(arg_40_2:Find("link"), arg_40_1 > 0)

				if not (var_39_7[var_39_5[arg_40_1 + 1]] and var_3.target_id) then
					setActive = var_5

					var_5(arg_40_2, false)

					return
				end

				updateDrop = var_5

				local var_40_0 = arg_40_2
				local var_40_1 = arg_40_2.Find(var_40_0, "item")
				local var_40_2 = {}

				DROP_TYPE_EQUIP = var_40_0
				var_40_2.type = var_40_0
				var_40_2.id = var_4

				var_5(var_40_1, var_40_2)

				onButton = var_5

				local var_40_3 = arg_39_0
				local var_40_4 = arg_40_2
				local var_40_5 = arg_40_2.Find(var_40_4, "item")

				local function var_40_6()
					CreateShell = var_3_10000

					local var_41_0 = var_3_10000(arg_39_1)

					if arg_39_0.shipVO then
						var_41_0.shipId = arg_39_0.shipVO.id
						var_41_0.shipPos = arg_39_0.contextData.pos
					end

					local var_41_1 = arg_39_0
					local var_41_2 = var_1.emit

					EquipmentInfoMediator = var_3_10004

					local var_41_3 = var_3_10004.OPEN_LAYER

					Context = var_3_10005

					local var_41_4 = var_3_10005.New
					local var_41_5 = {}

					EquipmentTransformMediator = var_3_10008
					var_41_5.mediator = var_3_10008
					EquipmentTransformLayer = var_3_10008
					var_41_5.viewComponent = var_3_10008

					local var_41_6 = {
						fromStoreHouse = true,
						formulaId = var_39_5[arg_40_1 + 1]
					}
					local var_41_7 = {}

					DROP_TYPE_EQUIP = var_10
					var_41_7.type = var_10
					var_41_7.id = arg_39_1.id
					var_41_7.template = var_41_0
					var_41_6.sourceEquipmentInstance = var_41_7
					var_41_5.data = var_41_6

					var_41_2(var_41_1, var_41_3, var_41_4(var_41_5))

					return
				end

				SFX_PANEL = var_40_4

				var_5(var_40_3, var_40_5, var_40_6, var_40_4)

				local var_40_7 = arg_40_2:Find("mask/name")
				local var_40_8 = var_5.GetComponent(var_40_7, "ScrollText")
				local var_40_9 = var_5.SetText

				Equipment = var_8

				var_40_9(var_40_8, var_8.getConfigData(var_4).name)
			end

			return
		end)
	end

	return
end

function var_0_1.cloneSampleTo(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	cloneTplTo = var_1_10005

	local var_42_0 = var_1_10005(arg_42_0.sample, arg_42_1, arg_42_3)

	Vector3 = var_1_10006
	var_42_0.localPosition = var_1_10006.New(var_0_1.pos[arg_42_2][1], var_0_1.pos[arg_42_2][2], var_0_1.pos[arg_42_2][3])

	if arg_42_4 then
		var_42_0:SetSiblingIndex(arg_42_4)
	end

	return var_42_0
end

function var_0_1.willExit(arg_43_0)
	local var_43_0 = arg_43_0.equipDestroyConfirmWindow

	var_1.Destroy(var_43_0)

	pg = var_1

	local var_43_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_43_1, arg_43_0._tf)

	return
end

function var_0_1.onBackPressed(arg_44_0)
	local var_44_0 = arg_44_0.equipDestroyConfirmWindow

	if var_1.isShowing(var_44_0) then
		local var_44_1 = arg_44_0.equipDestroyConfirmWindow

		var_1.Hide(var_44_1)

		return
	end

	isActive = var_1

	if var_1(arg_44_0.destroyPanel) then
		triggerToggle = var_1

		var_1(arg_44_0.toggles.defaultPanel, true)

		return
	end

	arg_44_0:closeView()

	return
end

return var_0_1
