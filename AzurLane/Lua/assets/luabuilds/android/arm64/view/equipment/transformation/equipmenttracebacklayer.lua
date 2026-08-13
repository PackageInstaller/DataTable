class = var_0_10000

local var_0_0 = "EquipmentTraceBackLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EquipmentTraceBackUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Adapt/Left/Operation")

	arg_2_0.sortOrderBtn = var_1.Find(var_2_1, "Bar1")
	arg_2_0.orderText = var_1:Find("OrderText")
	arg_2_0.sortBarBtn = var_1:Find("Bar2")
	arg_2_0.sortImg = var_1:Find("SortImg")

	local var_2_2 = arg_2_0._tf

	arg_2_0.sortBar = var_2.Find(var_2_2, "Adapt/Left/SortBar")
	setActive = var_2

	var_2(arg_2_0.sortBar, false)

	local var_2_3 = arg_2_0._tf

	arg_2_0.equipLayout = var_2.Find(var_2_3, "Adapt/Left/Scroll View")

	local var_2_4 = arg_2_0.equipLayout

	arg_2_0.equipLayoutScroll = var_2.GetComponent(var_2_4, "LScrollRect")

	local var_2_5 = arg_2_0.equipLayout

	arg_2_0.equipLayoutContent = var_2.Find(var_2_5, "Viewport/Content")

	local var_2_6 = arg_2_0.equipLayoutContent
	local var_2_7 = var_2.GetComponent

	typeof = var_5
	GridLayoutGroup = var_1_10007
	var_2_7(var_2_6, var_5(var_1_10007)).constraintCount = 6

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "Adapt/Right")

	arg_2_0.sourceEquip = var_3.Find(var_2_9, "Source")
	arg_2_0.sourceEquipStatus = var_3:Find("Status")
	arg_2_0.formulaWire = var_3:Find("Wire")
	arg_2_0.targetEquip = var_3:Find("Target")
	arg_2_0.confirmBtn = var_3:Find("ConfirmBtn")
	arg_2_0.cancelBtn = var_3:Find("CancelBtn")
	arg_2_0.materialLayout = var_3:Find("Scroll View")

	local var_2_10 = arg_2_0.materialLayout

	arg_2_0.materialLayoutContent = var_4.Find(var_2_10, "Viewport/Content")
	arg_2_0.goldText = var_3:Find("GoldText")
	setText = var_4

	local var_2_11 = var_1:Find("Field/Text")

	i18n = var_7

	var_4(var_2_11, var_7("equipment_upgrade_quick_interface_source_chosen"))

	setText = var_4

	local var_2_12 = var_3:Find("Text")

	i18n = var_7

	var_4(var_2_12, var_7("equipment_upgrade_quick_interface_materials_consume"))

	AutoLoader = var_4
	arg_2_0.loader = var_4.New()

	return
end

var_0_1.SortType = {
	Rarity = "rarity",
	Strengthen = "level",
	Type = "type"
}

local var_0_2 = {
	var_0_1.SortType.Rarity,
	var_0_1.SortType.Type,
	var_0_1.SortType.Strengthen
}
local var_0_3 = {
	[var_0_1.SortType.Rarity] = "rarity",
	[var_0_1.SortType.Type] = "type",
	[var_0_1.SortType.Strengthen] = "strengthen"
}

var_0_1.SortOrder = {
	Descend = 0,
	Ascend = 1
}

local var_0_4 = {
	[var_0_1.SortOrder.Descend] = "word_desc",
	[var_0_1.SortOrder.Ascend] = "word_asc"
}

function var_0_1.SetEnv(arg_3_0, arg_3_1)
	arg_3_0.env = arg_3_1

	return
end

function var_0_1.GetAllPaths(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = {
		{
			arg_4_1
		}
	}

	::label_4_0::

	local var_4_2 = #var_4_1

	if 0 < var_4_2 then
		repeat
			table = var_4_2
			var_4_2 = var_4_2.remove(var_4_1, 1)
			EquipmentProxy = var_4_3

			local var_4_3 = var_4_3.GetTransformSources(var_4_2[1])

			ipairs = var_6

			for iter_4_0, iter_4_1 in var_6(var_4_3) do
				pg = var_1_10011
				var_1_10011 = var_1_10011.equip_upgrade_data[iter_4_1].upgrade_from

				if var_4_2[2] then
					Clone = var_12

					local var_4_4

					if not var_12(var_4_2[2]) then
						var_4_4 = {}
					end

					table = var_1_10013

					var_1_10013.insert(var_4_4, 1, iter_4_1)

					table = var_1_10013

					var_1_10013.insert(var_4_1, {
						var_1_10011,
						var_4_4
					})

					local var_4_5 = arg_4_0.env.tracebackHelper

					if #var_1_10013.GetEquipmentTransformCandicates(var_4_5, var_1_10011) > 0 then
						table = var_14

						local var_4_6 = var_14.insertto
						local var_4_7 = var_4_0

						_ = var_17

						var_4_6(var_4_7, var_17.map(var_1_10013, function(arg_5_0)
							return {
								source = arg_5_0,
								formulas = var_4_4
							}
						end))
					end
				end
			end

			goto label_4_0
		until true
	end

	return var_4_0
end

function var_0_1.UpdateSourceEquipmentPaths(arg_6_0)
	arg_6_0.totalPaths = arg_6_0:GetAllPaths(arg_6_0.contextData.TargetEquipmentId)

	if arg_6_0.contextData.sourceEquipmentInstance then
		_ = var_1

		local var_6_0 = var_1.detect(arg_6_0.totalPaths, function(arg_7_0)
			EquipmentTransformUtil = var_2_10001

			return var_2_10001.SameDrop(arg_7_0.source, arg_6_0.contextData.sourceEquipmentInstance)
		end)
		local var_6_1 = arg_6_0.contextData
		local var_6_2

		if not var_6_0 or not var_6_0.source then
			var_6_2 = nil
		end

		var_6_1.sourceEquipmentInstance = var_6_2
	end

	return
end

function var_0_1.UpdateSort(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.totalPaths) do
		local var_8_0 = iter_8_1.source.type

		DROP_TYPE_ITEM = var_1_10007

		local var_8_2

		if var_8_0 == var_1_10007 then
			local var_8_1 = iter_8_1.source.template.count

			if not (iter_8_1.source.composeCfg.material_num <= var_8_1) then
				var_8_2 = false

				goto label_8_0
			end
		end

		var_8_2 = true

		::label_8_0::

		iter_8_1.isSourceEnough = var_8_2

		local var_8_3

		if iter_8_1.isSourceEnough then
			EquipmentTransformUtil = var_8_3
			var_8_3 = var_8_3.CheckTransformFormulasSucceed(iter_8_1.formulas, iter_8_1.source)
		end

		iter_8_1.isMaterialEnough = var_8_3
	end

	table = var_1

	var_1.sort(arg_8_0.totalPaths, function(arg_9_0, arg_9_1)
		if arg_9_0.isSourceEnough ~= arg_9_1.isSourceEnough then
			return arg_9_0.isSourceEnough
		end

		if arg_9_0.isMaterialEnough ~= arg_9_1.isMaterialEnough then
			return arg_9_0.isMaterialEnough
		end

		if arg_9_0.source.type ~= arg_9_1.source.type then
			return arg_9_0.source.type < arg_9_1.source.type
		end

		local var_9_0 = arg_8_0.contextData.sortType
		local var_9_1 = arg_8_0.contextData.sortOrder == var_0_1.SortOrder.Descend and 1 or -1
		local var_9_2 = arg_9_0.source.type

		DROP_TYPE_ITEM = var_2_10005

		if var_9_2 == var_2_10005 then
			return (arg_9_0.source.template.id - arg_9_1.source.template.id) * var_9_1 > 0
		end

		local var_9_3

		if not arg_9_0.source.template.shipId then
			var_9_3 = -1
		end

		local var_9_4

		if not arg_9_1.source.template.shipId then
			var_9_4 = -1
		end

		if var_9_3 ~= var_9_4 then
			return var_9_3 < var_9_4
		end

		local var_9_5 = arg_9_0.source.template
		local var_9_6 = var_6.getConfigTable(var_9_5)[var_9_0]
		local var_9_7 = arg_9_1.source.template
		local var_9_8 = var_9_6 - var_7.getConfigTable(var_9_7)[var_9_0] ~= 0 and var_9_8 or arg_9_0.source.template.id - arg_9_1.source.template.id

		return var_9_8 * var_9_1 > 0
	end)

	setText = var_1

	local var_8_4 = arg_8_0.orderText

	i18n = var_4

	var_1(var_8_4, var_4(var_0_4[arg_8_0.contextData.sortOrder]))

	local var_8_5 = arg_8_0.loader

	var_1.GetSprite(var_8_5, "ui/equipmenttracebackui_atlas", var_0_3[arg_8_0.contextData.sortType], arg_8_0.sortImg)

	return
end

function var_0_1.didEnter(arg_10_0)
	function arg_10_0.equipLayoutScroll.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = arg_10_0
		local var_11_1 = var_2.UpdateSourceListItem
		local var_11_2 = arg_11_0

		tf = var_2_10006

		var_11_1(var_11_0, var_11_2, var_2_10006(arg_11_1))

		TweenItemAlphaAndWhite = var_11_1

		var_11_1(arg_11_1)

		return
	end

	local var_10_0 = arg_10_0.equipLayoutScroll

	function var_10_0.onReturnItem(arg_12_0, arg_12_1)
		ClearTweenItemAlphaAndWhite = var_2_10002

		var_2_10002(arg_12_1)

		return
	end

	onButton = var_10_0

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.sortBarBtn

	local function var_10_3()
		isActive = var_2_10000

		local var_13_0 = var_2_10000(arg_10_0.sortBar)

		setActive = var_2_10001

		var_2_10001(arg_10_0.sortBar, not var_13_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_10_0(var_10_1, var_10_2, var_10_3, var_1_10006)

	for iter_10_0 = 1, arg_10_0.sortBar.childCount do
		local var_10_4 = arg_10_0.sortBar
		local var_10_5 = var_5.GetChild(var_10_4, iter_10_0 - 1)

		onButton = var_1_10006

		local var_10_6 = arg_10_0
		local var_10_7 = var_10_5

		local function var_10_8()
			arg_10_0.contextData.sortType = var_0_2[iter_10_0]

			local var_14_0 = arg_10_0

			var_0.UpdateSort(var_14_0)

			local var_14_1 = arg_10_0

			var_0.UpdateSourceList(var_14_1)

			setActive = var_0

			var_0(arg_10_0.sortBar, false)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_10_6, var_10_7, var_10_8, var_1_10011)
	end

	onButton = var_1

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_0.sortOrderBtn

	local function var_10_11()
		arg_10_0.contextData.sortOrder = var_0_1.SortOrder.Ascend - arg_10_0.contextData.sortOrder

		local var_15_0 = arg_10_0

		var_0.UpdateSort(var_15_0)

		local var_15_1 = arg_10_0

		var_0.UpdateSourceList(var_15_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_10_9, var_10_10, var_10_11, var_1_10006)

	onButton = var_1

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.cancelBtn

	local function var_10_14()
		local var_16_0 = arg_10_0

		var_0.closeView(var_16_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_10_12, var_10_13, var_10_14, var_1_10006)

	onButton = var_1

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_0.confirmBtn

	local function var_10_17()
		if not arg_10_0.contextData.sourceEquipmentInstance then
			pg = var_2_10001

			local var_17_0 = var_2_10001.TipsMgr.GetInstance()

			var_2_10001 = var_2_10001.ShowTips
			i18n = var_2_10004

			var_2_10001(var_17_0, var_2_10004("equipment_upgrade_quick_interface_feedback_source_chosen"))

			return
		end

		EquipmentTransformUtil = var_2_10001

		if not var_2_10001.CheckTransformFormulasSucceed(arg_10_0.contextData.sourceEquipmentFormulaList, var_0) then
			pg = var_1

			local var_17_1 = var_1.TipsMgr.GetInstance()
			local var_17_2 = var_1.ShowTips

			i18n = var_4

			var_17_2(var_17_1, var_4("equipment_upgrade_feedback_lack_of_materials"))

			return
		end

		local var_17_3 = arg_10_0
		local var_17_4 = var_1.emit

		EquipmentTraceBackMediator = var_4

		var_17_4(var_17_3, var_4.TRANSFORM_EQUIP, var_0, arg_10_0.contextData.sourceEquipmentFormulaList)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_10_15, var_10_16, var_10_17, var_1_10006)

	local var_10_18 = arg_10_0.contextData
	local var_10_19

	if not arg_10_0.contextData.sortOrder then
		var_10_19 = var_0_1.SortOrder.Descend
	end

	var_10_18.sortOrder = var_10_19

	local var_10_20 = arg_10_0.contextData
	local var_10_21

	if not arg_10_0.contextData.sortType then
		var_10_21 = var_0_1.SortType.Rarity
	end

	var_10_20.sortType = var_10_21

	arg_10_0:UpdateSourceEquipmentPaths()
	arg_10_0:UpdateSort()
	arg_10_0:UpdateSourceList()
	arg_10_0:UpdateFormula()

	updateDrop = var_1

	local var_10_22 = arg_10_0.targetEquip
	local var_10_23 = {}

	DROP_TYPE_EQUIP = var_10_17
	var_10_23.type = var_10_17
	var_10_23.id = arg_10_0.contextData.TargetEquipmentId

	var_1(var_10_22, var_10_23)

	pg = var_1

	local var_10_24 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_10_24, arg_10_0._tf, {
		staticBlur = true
	})

	return
end

function var_0_1.UpdateSourceList(arg_18_0)
	arg_18_0.lastSourceItem = nil

	local var_18_0 = arg_18_0.equipLayoutScroll

	var_1.SetTotalCount(var_18_0, #arg_18_0.totalPaths)

	return
end

function var_0_1.UpdateSourceListItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.totalPaths[arg_19_1 + 1].source.template

	updateDrop = var_1_10005

	var_1_10005(arg_19_2:Find("Item"), var_3)

	setText = var_1_10005

	var_1_10005(arg_19_2:Find("Item/icon_bg/count"), var_19_0.count)

	setActive = var_1_10005

	var_1_10005(arg_19_2:Find("EquipShip"), var_19_0.shipId)

	setActive = var_1_10005

	var_1_10005(arg_19_2:Find("Selected"), false)

	if var_3 == arg_19_0.contextData.sourceEquipmentInstance then
		arg_19_0.lastSourceItem = arg_19_2
		setActive = var_5

		var_5(arg_19_2:Find("Selected"), true)
	end

	setActive = var_5

	local var_19_1 = arg_19_2

	var_5(arg_19_2.Find(var_19_1, "Item/mask"), false)

	local var_19_2 = var_3.type

	DROP_TYPE_ITEM = var_1_10006

	if var_19_2 == var_1_10006 then
		local var_19_3 = arg_19_2
		local var_19_4 = arg_19_2.Find(var_19_3, "Item/icon_bg/count")
		local var_19_5 = var_19_0.count
		local var_19_6 = var_3.composeCfg.material_num <= var_19_5

		setColorStr = var_19_1

		local var_19_7 = var_19_5 .. "/" .. var_19_3

		if var_19_6 then
			COLOR_WHITE = var_12

			if not var_12 then
				COLOR_RED = var_12
			end

			local var_19_8 = var_19_1(var_19_7, var_12)

			setText = var_10

			var_10(var_19_4, var_19_8)

			setActive = var_10

			var_10(arg_19_2:Find("Item/mask"), not var_19_6)

			if var_19_0.shipId then
				getProxy = var_5
				BayProxy = var_19_3

				local var_19_9 = var_5(var_19_3)
				local var_19_10 = var_5.getShipById(var_19_9, var_19_0.shipId)
				local var_19_11 = arg_19_0.loader

				var_6.GetSprite(var_19_11, "qicon/" .. var_19_10:getPainting(), "", arg_19_2:Find("EquipShip/Image"))
			end

			local var_19_12 = arg_19_2:Find("Mask/NameText")
			local var_19_13 = var_5.GetComponent

			typeof = var_8
			ScrollText = var_10

			local var_19_14 = var_19_13(var_19_12, var_8(var_10))

			var_5.SetText(var_19_14, var_19_0:getConfig("name"))

			onButton = var_5

			local var_19_15 = arg_19_0
			local var_19_16 = arg_19_2
			local var_19_17 = arg_19_2.Find(var_19_16, "Item")

			local function var_19_18()
				local var_20_0 = var_0.type

				DROP_TYPE_ITEM = var_2_10001

				if var_20_0 == var_2_10001 and not (var_0.template.count >= var_0.composeCfg.material_num) then
					pg = var_2_10003

					local var_20_1 = var_2_10003.TipsMgr.GetInstance()
					local var_20_2 = var_3.ShowTips

					i18n = var_2_10006

					local var_20_3 = "equipment_upgrade_feedback_lack_of_fragment"
					local var_20_4 = var_0.template

					var_20_2(var_20_1, var_2_10006(var_20_3, var_9.getConfig(var_20_4, "name")))

					return
				end

				if arg_19_0.lastSourceItem then
					setActive = var_0

					local var_20_5 = arg_19_0.lastSourceItem

					var_0(var_2.Find(var_20_5, "Selected"), false)
				end

				local var_20_6 = arg_19_0

				var_20_6.lastSourceItem = arg_19_2
				setActive = var_20_6

				local var_20_7 = arg_19_2

				var_20_6(var_2.Find(var_20_7, "Selected"), true)

				arg_19_0.contextData.sourceEquipmentInstance = var_0
				arg_19_0.contextData.sourceEquipmentFormulaList = arg_19_0.totalPaths[arg_19_1 + 1].formulas

				local var_20_8 = arg_19_0

				var_0.UpdateFormula(var_20_8)

				return
			end

			SFX_PANEL = var_19_16

			var_5(var_19_15, var_19_17, var_19_18, var_19_16)

			return
		end
	end
end

function var_0_1.UpdatePlayer(arg_21_0, arg_21_1)
	arg_21_0.player = arg_21_1

	arg_21_0:UpdateConsumeComparer()

	return
end

function var_0_1.UpdateConsumeComparer(arg_22_0)
	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = true
	local var_22_3

	if arg_22_0.contextData.sourceEquipmentInstance then
		EquipmentTransformUtil = var_22_3

		local var_22_4, var_22_5

		var_22_3, var_22_4, var_22_5 = var_22_3.CheckTransformEnoughGold(arg_22_0.contextData.sourceEquipmentFormulaList, arg_22_0.contextData.sourceEquipmentInstance)
		var_22_1 = var_22_5
		var_22_0 = var_22_4
		var_22_2 = var_22_3
	end

	setColorStr = var_22_3

	local var_22_6 = var_22_0

	if var_22_2 then
		COLOR_WHITE = var_1_10007

		if not var_1_10007 then
			COLOR_RED = var_1_10007
		end

		local var_22_7 = var_22_3(var_22_6, var_1_10007)

		if var_22_1 > 0 then
			local var_22_8 = var_22_7

			setColorStr = var_22_6
			var_1_10008 = " + " .. var_22_1

			if var_22_2 then
				COLOR_GREEN = var_9

				if not var_9 then
					COLOR_RED = var_9
				end

				var_22_7 = var_22_8 .. var_22_6(var_1_10008, var_9)

				local var_22_9 = arg_22_0.goldText
				local var_22_10 = var_5.GetComponent

				typeof = var_1_10008
				Text = var_1_10010
				var_22_10(var_22_9, var_1_10008(var_1_10010)).text = var_22_7

				return
			end
		end
	end
end

function var_0_1.UpdateFormula(arg_23_0)
	local var_23_0 = arg_23_0.contextData.sourceEquipmentInstance

	setActive = var_1_10002

	var_1_10002(arg_23_0.sourceEquipStatus, not var_23_0)

	setActive = var_1_10002

	var_1_10002(arg_23_0.sourceEquip, var_23_0)

	setActive = var_1_10002

	var_1_10002(arg_23_0.materialLayout, var_23_0)

	if var_23_0 then
		updateDrop = var_1_10002

		var_1_10002(arg_23_0.sourceEquip, var_23_0)

		local var_23_1 = arg_23_0.sourceEquip
		local var_23_2 = var_2.Find(var_23_1, "icon_bg/count")
		local var_23_3 = ""

		if var_23_0 then
			var_23_1 = var_23_0.type
			DROP_TYPE_ITEM = var_5

			if var_23_1 == var_5 then
				var_23_3 = var_23_0.composeCfg.material_num
			end
		end

		setText = var_23_1

		var_23_1(var_23_2, var_23_3)

		local var_23_4 = not arg_23_0.contextData.sourceEquipmentFormulaList or #var_4 <= 1
		local var_23_5 = arg_23_0.loader

		var_6.GetSprite(var_23_5, "ui/equipmenttracebackui_atlas", var_23_4 and "wire" or "wire2", arg_23_0.formulaWire)
		arg_23_0:UpdateFormulaMaterials()
	else
		arg_23_0:UpdateConsumeComparer()
	end

	return
end

function var_0_1.UpdateFormulaMaterials(arg_24_0)
	if not arg_24_0.contextData.sourceEquipmentFormulaList then
		return
	end

	local var_24_0 = {}
	local var_24_1 = 0

	ipairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0.contextData.sourceEquipmentFormulaList) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.equip_upgrade_data[iter_24_1]
		ipairs = var_1_10009

		for iter_24_2, iter_24_3 in var_1_10009(var_1_10008.material_consume) do
			local var_24_2 = iter_24_3[1]
			local var_24_3

			if not var_24_0[iter_24_3[1]] then
				var_24_3 = 0
			end

			var_24_0[var_24_2] = var_24_3 + iter_24_3[2]
		end

		var_24_1 = var_24_1 + var_1_10008.coin_consume
	end

	local var_24_4 = {}

	pairs = var_4

	for iter_24_4, iter_24_5 in var_4(var_24_0) do
		table = var_1_10009

		var_1_10009.insert(var_24_4, {
			id = iter_24_4,
			count = iter_24_5
		})
	end

	table = var_4

	var_4.sort(var_24_4, function(arg_25_0, arg_25_1)
		return arg_25_0.id > arg_25_1.id
	end)

	arg_24_0.consumeMaterials = var_24_4
	UIItemList = var_4

	local var_24_5 = var_4.StaticAlign
	local var_24_6 = arg_24_0.materialLayoutContent
	local var_24_7 = arg_24_0.materialLayoutContent

	var_24_5(var_24_6, var_7.GetChild(var_24_7, 0), #arg_24_0.consumeMaterials, function(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		if arg_26_0 == var_2_10003.EventUpdate then
			local var_26_0 = arg_24_0

			var_3.UpdateFormulaMaterialItem(var_26_0, arg_26_1, arg_26_2)
		end

		return
	end)

	Canvas = var_24_5

	var_24_5.ForceUpdateCanvases()

	local var_24_8 = arg_24_0.materialLayoutContent.rect.height < arg_24_0.materialLayout.rect.height
	local var_24_9 = arg_24_0.materialLayout
	local var_24_10 = var_5.GetComponent

	typeof = var_8
	ScrollRect = var_10

	local var_24_11 = var_24_10(var_24_9, var_8(var_10))

	var_24_11.enabled = not var_24_8
	setActive = var_24_11

	local var_24_12 = arg_24_0.materialLayout

	var_24_11(var_7.Find(var_24_12, "Scrollbar"), not var_24_8)

	if var_24_8 then
		local var_24_13 = arg_24_0.materialLayoutContent

		Vector2 = var_6
		var_24_13.anchoredPosition = var_6.zero
	end

	arg_24_0:UpdateConsumeComparer()

	return
end

function var_0_1.UpdateFormulaMaterialItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.consumeMaterials[arg_27_1 + 1]
	local var_27_1 = {}

	DROP_TYPE_ITEM = var_1_10005
	var_27_1.type = var_1_10005
	var_27_1.id = var_27_0.id
	updateDrop = var_5

	local var_27_2 = arg_27_2

	var_5(arg_27_2.Find(var_27_2, "Item"), var_27_1)

	getProxy = var_5
	BagProxy = var_7

	local var_27_3 = var_5(var_7)
	local var_27_4 = var_5.getItemCountById(var_27_3, var_27_0.id)

	setText = var_1_10006

	local var_27_5 = arg_27_2:Find("Count")

	setColorStr = var_27_2

	local var_27_6 = var_27_0.count

	if var_27_0.count <= var_27_4 then
		COLOR_GREEN = var_12

		if not var_12 then
			COLOR_RED = var_12
		end

		var_1_10006(var_27_5, var_27_2(var_27_6, var_12) .. "/" .. var_27_4)

		onButton = var_1_10006

		var_1_10006(arg_27_0, arg_27_2:Find("Item"), function()
			local var_28_0 = arg_27_0

			var_0.emit(var_28_0, var_0_1.ON_DROP, var_27_1)

			return
		end)

		return
	end
end

function var_0_1.willExit(arg_29_0)
	local var_29_0 = arg_29_0.loader

	var_1.Clear(var_29_0)

	pg = var_1

	local var_29_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_29_1, arg_29_0._tf)

	return
end

return var_0_1
