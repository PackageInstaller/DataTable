class = var_0_10000

local var_0_0 = "EquipmentTransformLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EquipmentTransformUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.layer = var_1.Find(var_2_0, "Adapt")
	arg_2_0.formulaItems = {}

	local var_2_1 = arg_2_0.formulaItems
	local var_2_2 = arg_2_0.layer

	var_2_1[1] = var_2.Find(var_2_2, "MaterialModule1")

	local var_2_3 = arg_2_0.formulaItems
	local var_2_4 = arg_2_0.layer

	var_2_3[2] = var_2.Find(var_2_4, "MaterialModule2")

	local var_2_5 = arg_2_0.formulaItems
	local var_2_6 = arg_2_0.layer

	var_2_5[3] = var_2.Find(var_2_6, "MaterialModule3")

	local var_2_7 = arg_2_0.layer

	arg_2_0.sourceEquipItem = var_1.Find(var_2_7, "SourceEquip")

	local var_2_8 = arg_2_0.layer

	arg_2_0.targetEquipItem = var_1.Find(var_2_8, "TargetEquip")

	local var_2_9 = arg_2_0.layer

	arg_2_0.consumePanel = var_1.Find(var_2_9, "ComposePanel")
	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "Adapt/TitleText")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("equipment_upgrade_title"))

	setText = var_1

	local var_2_12 = arg_2_0.consumePanel
	local var_2_13 = var_2.Find(var_2_12, "Consume")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("equipment_upgrade_coin_consume"))

	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "Adapt/InfoPanel/StoreCount/OnShip/NameText")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("equipment_upgrade_equipped_tag"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "Adapt/InfoPanel/StoreCount/Free/NameText")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("equipment_upgrade_spare_tag"))

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_1.Find(var_2_18, "Adapt/InfoPanel/Viewport/Content")
	local var_2_20 = var_1.Find(var_2_19, "attr_tpl")

	setActive = var_2_19

	var_2_19(var_2_20, false)

	setActive = var_2_19

	var_2_19(var_2_20:Find("subs"), false)

	Instantiate = var_2_19

	local var_2_21 = var_2_19(var_2_20).transform

	var_2_21.name = "attr"
	setParent = var_4

	var_4(var_2_21, var_1:Find("skill"))
	var_2_21:SetAsFirstSibling()

	Instantiate = var_4

	local var_2_22 = var_4(var_2_20).transform

	var_2_22.name = "attr"
	setParent = var_5

	var_5(var_2_22, var_1:Find("part"))
	var_2_22:SetAsFirstSibling()

	AutoLoader = var_5
	arg_2_0.loader = var_5.New()

	return
end

function var_0_1.SetEnv(arg_3_0, arg_3_1)
	arg_3_0.env = arg_3_1

	return
end

function var_0_1.UpdatePlayer(arg_4_0, arg_4_1)
	arg_4_0.player = arg_4_1

	arg_4_0:UpdateConsumeComparer()

	return
end

function var_0_1.UpdateConsumeComparer(arg_5_0)
	local var_5_0 = 0
	local var_5_1 = 0
	local var_5_2 = true
	local var_5_3

	if arg_5_0.contextData.sourceEquipmentInstance then
		EquipmentTransformUtil = var_5_3

		local var_5_4

		var_5_3, var_5_4, var_1_10006 = var_5_3.CheckTransformEnoughGold({
			arg_5_0.contextData.formulaId
		}, arg_5_0.contextData.sourceEquipmentInstance)
		var_5_1 = var_1_10006
		var_5_0 = var_5_4
		var_5_2 = var_5_3
	end

	setColorStr = var_5_3

	local var_5_5 = var_5_0

	if var_5_2 then
		COLOR_WHITE = var_1_10006

		if not var_1_10006 then
			COLOR_RED = var_1_10006
		end

		local var_5_6 = var_5_3(var_5_5, var_1_10006)

		if var_5_1 > 0 then
			local var_5_7 = var_5_6

			setColorStr = var_1_10006

			local var_5_8 = " + " .. var_5_1

			if var_5_2 then
				COLOR_GREEN = var_1_10008

				if not var_1_10008 then
					COLOR_RED = var_1_10008
				end

				var_5_6 = var_5_7 .. var_1_10006(var_5_8, var_1_10008)

				local var_5_9 = arg_5_0.consumePanel
				local var_5_10 = var_5.Find(var_5_9, "GoldText")
				local var_5_11 = var_5.GetComponent

				typeof = var_7
				Text = var_1_10008
				var_5_11(var_5_10, var_7(var_1_10008)).text = var_5_6

				return
			end
		end
	end
end

function var_0_1.UpdateFormula(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.contextData.formulaId then
		return
	end

	assert = var_2

	var_2(arg_6_1 and arg_6_1 > 0, "target formulaId is invalid")

	local var_6_0 = arg_6_0.contextData

	var_6_0.formulaId = arg_6_1
	pg = var_6_0

	local var_6_1 = var_6_0.equip_upgrade_data[arg_6_1]

	arg_6_0.contextData.formula = var_6_1
	arg_6_0.equipmentSourceId = var_6_1.upgrade_from
	arg_6_0.equipmentTarget = var_6_1.target_id
	arg_6_0.transformMaterials = var_6_1.material_consume

	arg_6_0:UpdateConsumeComparer()

	local var_6_2 = arg_6_0.env.tracebackHelper
	local var_6_3 = var_3.GetEquipmentTransformCandicates(var_6_2, arg_6_0.equipmentSourceId)
	local var_6_4

	if arg_6_0.contextData.sourceEquipmentInstance then
		_ = var_5
		var_6_4 = var_5.detect(var_6_3, function(arg_7_0)
			EquipmentTransformUtil = var_2_10001

			return var_2_10001.SameDrop(arg_7_0, arg_6_0.contextData.sourceEquipmentInstance)
		end)
	end

	local var_6_5 = arg_6_0.contextData

	var_6_5.sourceEquipmentInstance = var_6_4
	PlayerPrefs = var_6_5

	var_6_5.SetInt("ShowTransformTip_" .. arg_6_0.equipmentTarget, 1)

	PlayerPrefs = var_5

	var_5.Save()

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.emit

	EquipmentTransformMediator = var_7

	var_6_7(var_6_6, var_7.UPDATE_NEW_FLAG, arg_6_0.equipmentTarget)

	setActive = var_6_7

	local var_6_8 = arg_6_0.layer
	local var_6_9 = var_6.Find(var_6_8, "SwitchButton")

	EquipmentProxy = var_6_8

	var_6_7(var_6_9, #var_6_8.GetTransformSources(arg_6_0.equipmentTarget) > 1)
	arg_6_0:UpdatePage()

	return
end

function var_0_1.UpdatePage(arg_8_0)
	arg_8_0:UpdateSourceEquipmentPaths()
	arg_8_0:UpdateFormulaItems()
	arg_8_0:UpdateTargetInfo()
	arg_8_0:UpdateSourceInfo()

	return
end

function var_0_1.UpdateSourceEquipmentPaths(arg_9_0)
	local var_9_0 = arg_9_0.env.tracebackHelper
	local var_9_1 = var_1.GetSortedEquipTraceBack(var_9_0, arg_9_0.equipmentSourceId)

	_ = var_9_0
	arg_9_0.hasRoot = var_9_0.any(var_9_1, function(arg_10_0)
		if arg_10_0.candicates then
			::label_10_0::

			if #var_1 > 0 then
				EquipmentTransformUtil = var_2_10002
				var_2_10002 = var_2_10002.CheckTransformFormulasSucceed(arg_10_0.formulas, var_1[#var_1])
			else
				var_2_10002 = false
			end

			if false then
				var_2_10002 = true
			end
		end

		return var_2_10002
	end)

	local var_9_2 = arg_9_0.env.tracebackHelper
	local var_9_3 = var_2.GetEquipmentTransformCandicates(var_9_2, arg_9_0.equipmentSourceId)

	_ = var_9_2
	arg_9_0.childsCanUse = var_9_2.any(var_9_3, function(arg_11_0)
		local var_11_0 = arg_11_0.type

		DROP_TYPE_ITEM = var_2_10002

		if var_11_0 == var_2_10002 then
			local var_11_1 = arg_11_0.template.count

			return arg_11_0.composeCfg.material_num <= var_11_1
		else
			local var_11_2 = arg_11_0.type

			DROP_TYPE_EQUIP = var_2_10002

			if var_11_2 == var_2_10002 then
				return arg_11_0.template.count > 0
			end
		end

		return
	end)

	return
end

function var_0_1.CheckEnoughMaterials(arg_12_0)
	if not arg_12_0.contextData.formula then
		return
	end

	if not arg_12_0.contextData.sourceEquipmentInstance then
		return
	end

	local var_12_0 = arg_12_0.contextData.sourceEquipmentInstance

	EquipmentTransformUtil = var_1_10002

	local var_12_1, var_12_2 = var_1_10002.CheckTransformFormulasSucceed({
		arg_12_0.contextData.formulaId
	}, var_12_0)

	if not var_12_1 then
		return false, var_12_2
	end

	return true
end

function var_0_1.UpdateFormulaItems(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.formulaItems) do
		local var_13_0 = iter_13_1:Find("Item")
		local var_13_1 = arg_13_0.transformMaterials[iter_13_0]

		setActive = var_8

		var_8(iter_13_1, var_13_1)

		if var_13_1 then
			local var_13_2 = {}

			DROP_TYPE_ITEM = var_9
			var_13_2.type = var_9
			var_13_2.id = var_13_1[1]
			var_13_2.count = var_13_1[2]
			updateDrop = var_9

			var_9(var_13_0, var_13_2)

			onButton = var_9

			local var_13_3 = arg_13_0
			local var_13_4 = var_13_0

			local function var_13_5()
				local var_14_0 = arg_13_0

				var_0.emit(var_14_0, var_0_1.ON_DROP, var_13_2)

				return
			end

			SFX_PANEL = var_1_10013

			var_9(var_13_3, var_13_4, var_13_5, var_1_10013)

			getProxy = var_9
			BagProxy = var_13_3

			local var_13_6 = var_9(var_13_3)
			local var_13_7

			if not var_9.getItemCountById(var_13_6, var_13_1[1]) then
				var_13_7 = 0
			end

			setText = var_13_6

			local var_13_8 = iter_13_1
			local var_13_9 = iter_13_1.Find(var_13_8, "NumText")

			setColorStr = var_13_8
			var_1_10013 = var_13_7

			if var_13_7 < var_13_1[2] then
				COLOR_RED = var_13_10

				local var_13_10

				if not var_13_10 then
					var_13_10 = "#000F"
				end

				var_13_6(var_13_9, var_13_8(var_1_10013, var_13_10) .. "/" .. var_13_1[2])

				local var_13_11 = arg_13_0.equipmentSourceId == 0

				setActive = var_13_9
				var_1_10013 = iter_13_1

				var_13_9(iter_13_1.Find(var_1_10013, "Line"), not var_13_11)

				setActive = var_13_9
				var_1_10013 = iter_13_1

				var_13_9(iter_13_1.Find(var_1_10013, "Line2"), var_13_11)
			end
		end
	end

	return
end

function var_0_1.UpdateTargetInfo(arg_15_0)
	updateDrop = var_1_10001

	local var_15_0 = arg_15_0.targetEquipItem
	local var_15_1 = var_2.Find(var_15_0, "Item")
	local var_15_2 = {
		id = arg_15_0.equipmentTarget
	}

	DROP_TYPE_EQUIP = var_4
	var_15_2.type = var_4

	var_1_10001(var_15_1, var_15_2)

	local var_15_3 = arg_15_0.targetEquipItem
	local var_15_4 = var_1.Find(var_15_3, "Mask/NameText")
	local var_15_5 = var_1.GetComponent(var_15_4, "ScrollText")
	local var_15_6 = var_1.SetText

	Equipment = var_3

	var_15_6(var_15_5, var_3.getConfigData(arg_15_0.equipmentTarget).name)

	local var_15_7 = arg_15_0.layer
	local var_15_8 = var_1.Find(var_15_7, "InfoPanel")
	local var_15_9 = arg_15_0.env.tracebackHelper
	local var_15_10 = var_2.GetEquipmentTransformCandicates(var_15_9, arg_15_0.equipmentTarget)
	local var_15_11 = 0
	local var_15_12 = 0

	ipairs = var_1_10005

	for iter_15_0, iter_15_1 in var_1_10005(var_15_10) do
		local var_15_13 = iter_15_1.type

		DROP_TYPE_EQUIP = var_1_10011

		if var_15_13 == var_1_10011 then
			if iter_15_1.template.shipId then
				var_15_11 = var_15_11 + iter_15_1.template.count
			else
				var_15_12 = var_15_12 + iter_15_1.template.count
			end
		end
	end

	setText = var_5

	var_5(var_15_8:Find("StoreCount/OnShip/ValueText"), var_15_11)

	setText = var_5

	var_5(var_15_8:Find("StoreCount/Free/ValueText"), var_15_12)

	Equipment = var_5

	local var_15_14 = var_5.New({
		id = arg_15_0.equipmentTarget
	})
	local var_15_15 = var_15_8
	local var_15_16 = var_15_8.Find(var_15_15, "Viewport/Content")

	updateEquipInfo = var_15_15

	var_15_15(var_15_16, var_15_14:GetPropertiesInfo(), var_15_14:GetSkill())

	Canvas = var_15_15

	var_15_15.ForceUpdateCanvases()
	var_0_1.FitTextBGSize(var_15_16:Find("attrs"))
	var_0_1.FitTextBGSize(var_15_16:Find("weapon"))
	var_0_1.FitTextBGSize(var_15_16:Find("equip_info"))

	return
end

function var_0_1.FitTextBGSize(arg_16_0)
	for iter_16_0 = 0, arg_16_0.childCount - 1 do
		local var_16_0 = arg_16_0:GetChild(iter_16_0)
		local var_16_1 = var_5.Find(var_16_0, "base/NameBG").sizeDelta

		var_16_1.x = var_5:Find("base/name").rect.width + 18
		var_5:Find("base/NameBG").sizeDelta = var_16_1

		var_0_1.FitTextBGSize(var_5:Find("subs"))
	end

	return
end

function var_0_1.UpdateSourceInfo(arg_17_0)
	if not arg_17_0.contextData.sourceEquipmentInstance then
		::label_17_0::

		var_1_10002 = {
			id = arg_17_0.equipmentSourceId
		}
		DROP_TYPE_EQUIP = var_3
		var_1_10002.type = var_3
	end

	local var_17_0 = arg_17_0.equipmentSourceId == 0

	setActive = var_1_10004

	var_1_10004(arg_17_0.sourceEquipItem, not var_17_0)

	if var_17_0 then
		return
	end

	updateDrop = var_1_10004

	local var_17_1 = arg_17_0.sourceEquipItem

	var_1_10004(var_5.Find(var_17_1, "Item"), var_1_10002)

	local var_17_2 = arg_17_0.sourceEquipItem
	local var_17_3 = var_4.Find(var_17_2, "Item/icon_bg/count")
	local var_17_4 = ""

	if var_1 then
		local var_17_5 = var_1.type

		DROP_TYPE_ITEM = var_7

		if var_17_5 == var_7 then
			var_17_5 = var_1.template.count
			var_17_5 = var_1.composeCfg.material_num <= var_17_5
			setColorStr = var_7
			math = var_1_10008

			local var_17_6 = var_1_10008.min(var_1.template.count, var_1.composeCfg.material_num)

			if var_17_5 then
				COLOR_WHITE = var_9

				if not var_9 then
					COLOR_RED = var_9
				end

				var_17_4 = var_7(var_17_6, var_9)
				setText = var_17_5

				var_17_5(var_17_3, var_17_4)

				local var_17_7 = arg_17_0.sourceEquipItem
				local var_17_8 = var_6.Find(var_17_7, "Mask/NameText")
				local var_17_9 = var_6.GetComponent(var_17_8, "ScrollText")
				local var_17_10 = var_6.SetText

				Equipment = var_8

				var_17_10(var_17_9, var_8.getConfigData(arg_17_0.equipmentSourceId).name)

				setActive = var_17_10

				local var_17_11 = arg_17_0.sourceEquipItem

				var_17_10(var_7.Find(var_17_11, "craftable"), arg_17_0.hasRoot)

				onButton = var_17_10

				local var_17_12 = arg_17_0
				local var_17_13 = arg_17_0.sourceEquipItem
				local var_17_14 = var_8.Find(var_17_13, "craftable")

				local function var_17_15()
					local var_18_0 = arg_17_0
					local var_18_1 = var_0.emit

					EquipmentTransformMediator = var_2_10002

					local var_18_2 = var_2_10002.OPEN_LAYER

					Context = var_2_10003

					local var_18_3 = var_2_10003.New
					local var_18_4 = {}

					EquipmentTraceBackMediator = var_2_10005
					var_18_4.mediator = var_2_10005
					EquipmentTraceBackLayer = var_2_10005
					var_18_4.viewComponent = var_2_10005
					var_18_4.data = {
						TargetEquipmentId = arg_17_0.equipmentSourceId
					}

					var_18_1(var_18_0, var_18_2, var_18_3(var_18_4))

					return
				end

				SFX_PANEL = var_10

				var_17_10(var_17_12, var_17_14, var_17_15, var_10)

				onButton = var_17_10

				local var_17_16 = arg_17_0
				local var_17_17 = arg_17_0.sourceEquipItem
				local var_17_18 = var_8.Find(var_17_17, "Item")

				local function var_17_19()
					if arg_17_0.childsCanUse then
						local var_19_0 = arg_17_0
						local var_19_1 = var_0.emit

						EquipmentTransformMediator = var_2_10002

						var_19_1(var_19_0, var_2_10002.SELECT_TRANSFORM_FROM_STOREHOUSE, arg_17_0.equipmentSourceId)
					end

					return
				end

				SFX_PANEL = var_10

				var_17_10(var_17_16, var_17_18, var_17_19, var_10)

				local var_17_20 = arg_17_0.sourceEquipItem
				local var_17_21 = var_6.Find(var_17_20, "Status")
				local var_17_22

				if not arg_17_0.childsCanUse then
					setImageSprite = var_7
					var_17_22 = var_17_21
					LoadSprite = var_17_19

					var_7(var_17_22, var_17_19("ui/equipmenttransformui_atlas", "noown"))

					setActive = var_7

					var_7(var_17_21, true)
				elseif not var_1 then
					setImageSprite = var_7
					var_17_22 = var_17_21
					LoadSprite = var_17_19

					var_7(var_17_22, var_17_19("ui/equipmenttransformui_atlas", "unselect"))

					setActive = var_7

					var_7(var_17_21, true)
				else
					setActive = var_7

					var_7(var_17_21, false)
				end

				local var_17_23 = var_1 and var_1.template.shipId

				setActive = var_17_22

				local var_17_24 = arg_17_0.sourceEquipItem

				var_17_22(var_9.Find(var_17_24, "EquipShip"), var_17_23)

				if var_17_23 then
					getProxy = var_17_22
					BayProxy = var_9

					local var_17_25 = var_17_22(var_9)
					local var_17_26 = var_8.getShipById(var_17_25, var_17_23)
					local var_17_27 = arg_17_0.loader
					local var_17_28 = var_9.GetSprite
					local var_17_29 = "qicon/" .. var_17_26:getPainting()
					local var_17_30 = ""
					local var_17_31 = arg_17_0.sourceEquipItem

					var_17_28(var_17_27, var_17_29, var_17_30, var_13.Find(var_17_31, "EquipShip/Image"))
				end

				return
			end
		end
	end
end

function var_0_1.didEnter(arg_20_0)
	onButton = var_1_10001

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0._tf

	var_1_10001(var_20_0, var_3.Find(var_20_1, "BG"), function()
		local var_21_0 = arg_20_0

		var_0.closeView(var_21_0)

		return
	end)

	onButton = var_1_10001

	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.consumePanel
	local var_20_4 = var_3.Find(var_20_3, "ComposeBtn")

	local function var_20_5()
		local var_22_0 = arg_20_0.contextData.sourceEquipmentInstance

		if arg_20_0.equipmentSourceId ~= 0 and not var_22_0 then
			if arg_20_0.childsCanUse then
				pg = var_1

				local var_22_1 = var_1.TipsMgr.GetInstance()
				local var_22_2 = var_1.ShowTips

				i18n = var_2_10003

				var_22_2(var_22_1, var_2_10003("equipment_upgrade_quick_interface_feedback_source_chosen"))

				return
			else
				local var_22_4

				if arg_20_0.hasRoot then
					pg = var_22_4

					local var_22_3 = var_22_4.TipsMgr.GetInstance()

					var_22_4 = var_22_4.ShowTips
					i18n = var_2_10003

					var_22_4(var_22_3, var_2_10003("equipment_upgrade_feedback_equipment_can_be_produced"))

					return
				else
					pg = var_22_4

					local var_22_5 = var_22_4.TipsMgr.GetInstance()
					local var_22_6 = var_1.ShowTips

					i18n = var_2_10003

					var_22_6(var_22_5, var_2_10003("equipment_upgrade_feedback_lack_of_equipment"))

					return
				end
			end
		end

		local var_22_7 = arg_20_0

		if not var_1.CheckEnoughMaterials(var_22_7) then
			pg = var_22_7

			local var_22_8 = var_22_7.TipsMgr.GetInstance()
			local var_22_9 = var_2.ShowTips

			i18n = var_2_10004

			var_22_9(var_22_8, var_2_10004("equipment_upgrade_feedback_lack_of_materials"))

			return
		end

		local var_22_10 = arg_20_0
		local var_22_11 = var_2.emit

		EquipmentTransformMediator = var_2_10004

		var_22_11(var_22_10, var_2_10004.TRANSFORM_EQUIP, var_22_0, arg_20_0.contextData.formulaId)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_20_2, var_20_4, var_20_5, var_5)

	onButton = var_1_10001

	local var_20_6 = arg_20_0
	local var_20_7 = arg_20_0.layer
	local var_20_8 = var_3.Find(var_20_7, "OverviewBtn")

	local function var_20_9()
		local var_23_0 = arg_20_0
		local var_23_1 = var_0.emit

		EquipmentTransformMediator = var_2_10002

		var_23_1(var_23_0, var_2_10002.OPEN_TRANSFORM_TREE, arg_20_0.equipmentTarget)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_20_6, var_20_8, var_20_9, var_5)

	onButton = var_1_10001

	local var_20_10 = arg_20_0
	local var_20_11 = arg_20_0.layer
	local var_20_12 = var_3.Find(var_20_11, "SwitchButton")

	local function var_20_13()
		EquipmentProxy = var_2_10000

		local var_24_0 = var_2_10000.GetTransformSources(arg_20_0.equipmentTarget)

		table = var_1

		local var_24_1

		var_24_1 = var_1.indexof(var_24_0, arg_20_0.contextData.formulaId) and var_1 % #var_24_0 + 1 or 1
		arg_20_0.contextData.sourceEquipmentInstance = nil

		local var_24_2 = arg_20_0

		var_2.UpdateFormula(var_24_2, var_24_0[var_24_1])

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_20_10, var_20_12, var_20_13, var_5)

	onButton = var_1_10001

	local var_20_14 = arg_20_0
	local var_20_15 = arg_20_0.layer
	local var_20_16 = var_3.Find(var_20_15, "HelpBtn")

	local function var_20_17()
		pg = var_2_10000

		local var_25_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_25_1 = var_0.ShowMsgBox
		local var_25_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_25_2.type = var_2_10003
		pg = var_2_10003
		var_25_2.helps = var_2_10003.gametip.equipment_upgrade_help.tip

		var_25_1(var_25_0, var_25_2)

		return
	end

	SFX_PANEL = var_20_24

	var_1_10001(var_20_14, var_20_16, var_20_17, var_20_24)

	assert = var_1_10001

	var_1_10001(arg_20_0.contextData.formulaId)

	local var_20_18 = arg_20_0.contextData.formulaId

	arg_20_0.contextData.formulaId = nil

	local var_20_19 = arg_20_0

	arg_20_0.UpdateFormula(var_20_19, var_20_18)

	getProxy = var_2
	ContextProxy = var_20_19

	local var_20_20 = var_2(var_20_19)
	local var_20_21 = var_2.getContextByMediator

	EquipmentTransformMediator = var_20_25

	local var_20_22, var_20_23 = var_20_21(var_20_20, var_20_25)
	local var_20_24, var_20_25

	if var_20_23 then
		::label_20_0::

		pg = var_20_25
		var_20_24 = var_20_25.m02
		var_20_25 = var_20_25.retrieveMediator(var_20_24, var_20_23.mediator.__cname)
	end

	setActive = var_20_24

	local var_20_26 = arg_20_0.layer
	local var_20_27 = var_6.Find(var_20_26, "OverviewBtn")
	local var_20_28 = var_20_25.class

	EquipmentTransformTreeMediator = var_8

	var_20_24(var_20_27, var_20_28 ~= var_8)

	pg = var_20_24

	local var_20_29 = var_20_24.UIMgr.GetInstance()

	var_5.BlurPanel(var_20_29, arg_20_0._tf)

	return
end

function var_0_1.willExit(arg_26_0)
	local var_26_0 = arg_26_0.loader

	var_1.Clear(var_26_0)

	pg = var_1

	local var_26_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_26_1, arg_26_0._tf)

	return
end

return var_0_1
