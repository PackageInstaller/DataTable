local var_0_0 = class("EquipmentTransformTreeScene", import("view.base.BaseUI"))
local var_0_1 = require("Mgr/Pool/PoolPlural")
local var_0_2 = "ui/EquipmentTransformTreeUI_atlas"

function var_0_0.getUIName(arg_1_0)
	return "EquipmentTransformTreeUI"
end

var_0_0.optionsPath = {
	"blur_panel/adapt/top/option"
}
var_0_0.MODE_NORMAL = 1
var_0_0.MODE_HIDESIDE = 2

function var_0_0.init(arg_2_0)
	arg_2_0.leftPanel = arg_2_0._tf:Find("Adapt/Left")
	arg_2_0.rightPanel = arg_2_0._tf:Find("Adapt/Right")
	arg_2_0.nationToggleGroup = arg_2_0.leftPanel:Find("Nations"):Find("ViewPort/Content")

	setActive(arg_2_0.nationToggleGroup:GetChild(0), false)
	arg_2_0.nationToggleGroup:GetChild(0):Find("selectedCursor").gameObject:SetActive(false)

	arg_2_0.equipmentTypeToggleGroup = arg_2_0.leftPanel:Find("EquipmentTypes"):Find("ViewPort/Content")

	setActive(arg_2_0.equipmentTypeToggleGroup:GetChild(0), false)
	arg_2_0.equipmentTypeToggleGroup:GetChild(0):Find("selectedframe").gameObject:SetActive(false)

	arg_2_0.TreeCanvas = arg_2_0.rightPanel:Find("ViewPort/Content")

	setActive(arg_2_0.rightPanel:Find("EquipNode"), false)
	setActive(arg_2_0.rightPanel:Find("Link"), false)

	arg_2_0.nodes = {}
	arg_2_0.links = {}
	arg_2_0.plurals = {
		EquipNode = var_0_1.New(arg_2_0.rightPanel:Find("EquipNode").gameObject, 5),
		Link = var_0_1.New(arg_2_0.rightPanel:Find("Link").gameObject, 8)
	}
	arg_2_0.pluralRoot = pg.PoolMgr.GetInstance().root
	arg_2_0.top = arg_2_0._tf:Find("blur_panel")
	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.GetEnv(arg_3_0)
	arg_3_0.env = arg_3_0.env or {}

	return arg_3_0.env
end

function var_0_0.SetEnv(arg_4_0, arg_4_1)
	arg_4_0.env = arg_4_1

	return
end

function var_0_0.didEnter(arg_5_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_5_0.top)
	onButton(arg_5_0, arg_5_0.top:Find("adapt/top/back"), function()
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)

	if arg_5_0.contextData.targetEquipId then
		local var_5_0
		local var_5_1
		local var_5_2 = false

		for iter_5_0, iter_5_1 in pairs(arg_5_0.env.nationsTree) do
			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				for iter_5_4, iter_5_5 in ipairs(iter_5_3.equipments) do
					if iter_5_5[3] == arg_5_0.contextData.targetEquipId then
						var_5_1 = iter_5_2
						var_5_0 = iter_5_0
						var_5_2 = true

						break
					end
				end
			end

			if var_5_2 then
				break
			end
		end

		if var_5_2 then
			arg_5_0.contextData.nation = var_5_0
			arg_5_0.contextData.equipmentTypeIndex = var_5_1
		end

		arg_5_0.contextData.targetEquipId = nil
	end

	arg_5_0:InitPage()

	if arg_5_0.contextData.mode == var_0_0.MODE_HIDESIDE then
		setActive(arg_5_0.leftPanel, false)

		arg_5_0.rightPanel.sizeDelta.x = 0
		arg_5_0.rightPanel.sizeDelta = arg_5_0.rightPanel.sizeDelta

		setAnchoredPosition(arg_5_0.rightPanel, {
			x = 0
		})
	end

	return
end

function var_0_0.GetSortKeys(arg_7_0)
	local var_7_0 = _.keys(arg_7_0)

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0 < arg_8_1
	end)

	return var_7_0
end

function var_0_0.GetSortTypes(arg_9_0)
	local var_9_0 = _.values(arg_9_0)

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.id < arg_10_1.id
	end)

	return _.map(var_9_0, function(arg_11_0)
		return arg_11_0.category2
	end)
end

function var_0_0.InitPage(arg_12_0)
	arg_12_0.firstInit = true

	local var_12_0 = arg_12_0.contextData
	local var_12_1 = arg_12_0.env

	var_12_0.mode = arg_12_0.contextData.mode or var_0_0.MODE_NORMAL

	local var_12_2 = var_12_0.nation
	local var_12_3 = var_0_0.GetSortKeys(var_12_1.nationsTree)

	if not var_12_0.nation or not table.contains(var_12_3, var_12_2) then
		var_12_2 = var_12_3[1]
	end

	if next(var_12_1.nationsTree[var_12_2]) == nil then
		for iter_12_0 = 2, #var_12_3 do
			if next(var_12_1.nationsTree[var_12_3[iter_12_0]]) ~= nil then
				var_12_2 = var_12_3[iter_12_0]

				break
			end
		end
	end

	var_12_0.nation = nil

	arg_12_0:UpdateNations()

	local var_12_4 = table.indexof(var_12_3, var_12_2) or 1

	triggerButton(arg_12_0.nationToggles[var_12_4])

	arg_12_0.firstInit = nil

	return
end

function var_0_0.UpdateNations(arg_13_0)
	local var_13_0 = var_0_0.GetSortKeys(arg_13_0.env.nationsTree)

	arg_13_0.nationToggles = CustomIndexLayer.Clone2Full(arg_13_0.nationToggleGroup, #var_13_0)

	for iter_13_0 = 1, #arg_13_0.nationToggles do
		local var_13_1 = arg_13_0.nationToggles[iter_13_0]

		arg_13_0.loader:GetSprite(var_0_2, "nation" .. var_13_0[iter_13_0] .. "_disable", arg_13_0.nationToggles[iter_13_0]:Find("selectedIcon"))
		setActive(arg_13_0.nationToggles[iter_13_0]:Find("selectedCursor"), false)
		onButton(arg_13_0, arg_13_0.nationToggles[iter_13_0], function()
			if arg_13_0.contextData.nation ~= var_0 then
				if next(arg_13_0.env.nationsTree[var_0]) == nil then
					pg.TipsMgr.GetInstance():ShowTips(i18n("word_comingSoon"))

					return
				end

				arg_13_0.loader:GetSprite(var_0_2, "nation" .. var_0, var_13_1:Find("selectedIcon"))

				if arg_13_0.contextData.nation then
					local var_14_0 = table.indexof(var_13_0, arg_13_0.contextData.nation)

					setActive(arg_13_0.nationToggles[var_14_0]:Find("selectedCursor"), false)
					arg_13_0.loader:GetSprite(var_0_2, "nation" .. arg_13_0.contextData.nation .. "_disable", arg_13_0.nationToggles[var_14_0]:Find("selectedIcon"))
				end

				arg_13_0.contextData.nation = var_0

				arg_13_0:UpdateEquipmentTypes()

				local var_14_1 = var_0_0.GetSortTypes(arg_13_0.env.nationsTree[var_0])
				local var_14_2 = var_14_1[1]

				if arg_13_0.firstInit then
					if arg_13_0.contextData.equipmentTypeIndex and table.contains(var_14_1, arg_13_0.contextData.equipmentTypeIndex) then
						var_14_2 = arg_13_0.contextData.equipmentTypeIndex
					end
				end

				arg_13_0.contextData.equipmentTypeIndex = nil

				local var_14_3 = table.indexof(var_14_1, var_14_2) or 1

				triggerToggle(arg_13_0.equipmentTypeToggles[var_14_3], true)
			end

			return
		end, SFX_UI_TAG)
	end

	return
end

function var_0_0.UpdateEquipmentTypes(arg_15_0)
	local var_15_0 = var_0_0.GetSortTypes(arg_15_0.env.nationsTree[arg_15_0.contextData.nation])

	arg_15_0.equipmentTypeToggles = CustomIndexLayer.Clone2Full(arg_15_0.equipmentTypeToggleGroup, #var_15_0)

	for iter_15_0 = 1, #arg_15_0.equipmentTypeToggles do
		local var_15_1 = arg_15_0.equipmentTypeToggles[iter_15_0]

		arg_15_0.equipmentTypeToggles[iter_15_0]:GetComponent(typeof(Toggle)).isOn = false

		arg_15_0.loader:GetSprite(var_0_2, "equipmentType" .. var_15_0[iter_15_0], arg_15_0.equipmentTypeToggles[iter_15_0]:Find("itemName"), true)
		setActive(arg_15_0.equipmentTypeToggles[iter_15_0]:Find("selectedframe"), false)
		onToggle(arg_15_0, arg_15_0.equipmentTypeToggles[iter_15_0], function(arg_16_0)
			if arg_16_0 and arg_15_0.contextData.equipmentTypeIndex ~= var_0 then
				arg_15_0.contextData.equipmentTypeIndex = var_0

				arg_15_0:ResetCanvas()
			end

			setActive(var_15_1:Find("selectedframe"), arg_16_0)

			return
		end, SFX_UI_TAG)
	end

	arg_15_0.equipmentTypeToggleGroup.anchoredPosition = Vector2.zero
	arg_15_0.leftPanel:Find("EquipmentTypes"):GetComponent(typeof(ScrollRect)).velocity = Vector2.zero

	return
end

local var_0_3 = {
	15,
	-4,
	15,
	6
}

function var_0_0.ResetCanvas(arg_17_0)
	assert(EquipmentProxy.EquipmentTransformTreeTemplate[arg_17_0.contextData.nation][arg_17_0.contextData.equipmentTypeIndex], "can't find Equip_upgrade_template Nation: " .. arg_17_0.contextData.nation .. " Type: " .. arg_17_0.contextData.equipmentTypeIndex)

	arg_17_0.TreeCanvas.sizeDelta = Vector2(unpack(EquipmentProxy.EquipmentTransformTreeTemplate[arg_17_0.contextData.nation][arg_17_0.contextData.equipmentTypeIndex].canvasSize))
	arg_17_0.TreeCanvas.anchoredPosition = Vector2.zero
	arg_17_0.rightPanel:GetComponent(typeof(ScrollRect)).velocity = Vector2.zero

	arg_17_0:ReturnCanvasItems()

	for iter_17_0, iter_17_1 in ipairs(EquipmentProxy.EquipmentTransformTreeTemplate[arg_17_0.contextData.nation][arg_17_0.contextData.equipmentTypeIndex].equipments) do
		local var_17_0 = arg_17_0.plurals.EquipNode:Dequeue()

		setActive(var_17_0, true)
		setParent(var_17_0, arg_17_0.TreeCanvas)
		table.insert(arg_17_0.nodes, {
			id = iter_17_1[3],
			cfg = iter_17_1,
			go = var_17_0
		})

		var_17_0.name = iter_17_1[3]

		arg_17_0:UpdateItemNode(tf(var_17_0), iter_17_1)
	end

	for iter_17_2, iter_17_3 in ipairs(EquipmentProxy.EquipmentTransformTreeTemplate[arg_17_0.contextData.nation][arg_17_0.contextData.equipmentTypeIndex].links) do
		for iter_17_4 = 1, #iter_17_3 - 1 do
			local var_17_1 = iter_17_3[iter_17_4]
			local var_17_2 = iter_17_3[iter_17_4 + 1]
			local var_17_3 = {
				iter_17_3[iter_17_4 + 1][1] - iter_17_3[iter_17_4][1],
				iter_17_3[iter_17_4][2] - iter_17_3[iter_17_4 + 1][2]
			}
			local var_17_4 = math.abs(({
				iter_17_3[iter_17_4 + 1][1] - iter_17_3[iter_17_4][1],
				iter_17_3[iter_17_4][2] - iter_17_3[iter_17_4 + 1][2]
			})[1]) > math.abs(({
				iter_17_3[iter_17_4 + 1][1] - iter_17_3[iter_17_4][1],
				iter_17_3[iter_17_4][2] - iter_17_3[iter_17_4 + 1][2]
			})[2])
			local var_17_5 = var_17_4 and math.abs(var_17_3[1]) or math.abs(var_17_3[2])

			if var_17_4 then
				var_17_3[2] = 0
			else
				var_17_3[1] = 0
			end

			local var_17_6 = 1 - math.sign(var_17_3[1])

			var_17_6 = var_17_6 ~= 1 and var_17_6 or 2 - math.sign(var_17_3[2])

			local var_17_7 = math.deg2Rad * 90 * var_17_6

			if #iter_17_3 == 2 then
				local var_17_8 = arg_17_0.plurals.Link:Dequeue()

				table.insert(arg_17_0.links, go(var_17_8))
				setActive(var_17_8, true)
				setParent(var_17_8, arg_17_0.TreeCanvas)
				arg_17_0.loader:GetSprite(var_0_2, var_17_3[2] == 0 and "wirehead" or "wireline", var_17_8)

				tf(var_17_8).sizeDelta = Vector2(28, 26)
				tf(var_17_8).pivot = Vector2(0.5, 0.5)
				tf(var_17_8).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)

				local var_17_9 = Vector2(math.cos(var_17_7), math.sin(var_17_7)) * var_0_3[(var_17_6 - 1) % 4 + 1]

				tf(var_17_8).anchoredPosition = Vector2(var_17_1[1] + var_17_9.x, -var_17_1[2] + var_17_9.y)

				local var_17_10 = arg_17_0.plurals.Link:Dequeue()

				table.insert(arg_17_0.links, go(var_17_10))
				setActive(var_17_10, true)
				setParent(var_17_10, arg_17_0.TreeCanvas)
				arg_17_0.loader:GetSprite(var_0_2, "wiretail", var_17_10)

				tf(var_17_10).sizeDelta = Vector2(28, 26)
				tf(var_17_10).pivot = Vector2(0.5, 0.5)
				tf(var_17_10).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)

				local var_17_11 = Vector2(math.cos(var_17_7), math.sin(var_17_7)) * -var_0_3[(var_17_6 + 1) % 4 + 1]

				tf(var_17_10).anchoredPosition = Vector2(var_17_2[1] + var_17_11.x, -var_17_2[2] + var_17_11.y)

				local var_17_12 = arg_17_0.plurals.Link:Dequeue()

				table.insert(arg_17_0.links, go(var_17_12))
				setActive(var_17_12, true)
				setParent(var_17_12, arg_17_0.TreeCanvas)
				arg_17_0.loader:GetSprite(var_0_2, "wireline", var_17_12)

				tf(var_17_12).sizeDelta = Vector2(math.max(0, var_17_5 - var_0_3[(var_17_6 - 1) % 4 + 1] - var_0_3[(var_17_6 + 1) % 4 + 1] - 28), 16)
				tf(var_17_12).pivot = Vector2(0, 0.5)
				tf(var_17_12).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)
				tf(var_17_12).anchoredPosition = Vector2(var_17_1[1] + var_17_9.x, -var_17_1[2] + var_17_9.y) + Vector2(math.cos(var_17_7), math.sin(var_17_7)) * 14

				break
			end

			local var_17_13 = arg_17_0.plurals.Link:Dequeue()

			table.insert(arg_17_0.links, go(var_17_13))
			setActive(var_17_13, true)
			setParent(var_17_13, arg_17_0.TreeCanvas)

			local var_17_14 = 1

			if iter_17_4 == 1 then
				arg_17_0.loader:GetSprite(var_0_2, var_17_3[2] == 0 and "wirehead" or "wireline", var_17_13)

				tf(var_17_13).sizeDelta = Vector2(var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 - 1) % 4 + 1], 26)
				tf(var_17_13).pivot = Vector2((var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 - 1) % 4 + 1] - var_17_14) / (var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 - 1) % 4 + 1]), 0.5)
				tf(var_17_13).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)
				tf(var_17_13).anchoredPosition = Vector2(var_17_2[1], -var_17_2[2])
			elseif iter_17_4 + 1 == #iter_17_3 then
				arg_17_0.loader:GetSprite(var_0_2, "wiretail", var_17_13)

				tf(var_17_13).sizeDelta = Vector2(var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 + 1) % 4 + 1], 26)
				tf(var_17_13).pivot = Vector2(var_17_14 / (var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 + 1) % 4 + 1]), 0.5)
				tf(var_17_13).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)
				tf(var_17_13).anchoredPosition = Vector2(var_17_1[1], -var_17_1[2])
			else
				arg_17_0.loader:GetSprite(var_0_2, "wireline", var_17_13)

				tf(var_17_13).sizeDelta = Vector2(var_17_5 + var_17_14 * 2, 16)
				tf(var_17_13).pivot = Vector2(var_17_14 / (var_17_5 + var_17_14 * 2), 0.5)
				tf(var_17_13).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)
				tf(var_17_13).anchoredPosition = Vector2(var_17_1[1], -var_17_1[2])
			end
		end
	end

	return
end

function var_0_0.UpdateItemNode(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1 = tf(arg_18_1)
	arg_18_1.anchoredPosition = Vector2(arg_18_2[1], -arg_18_2[2])

	updateDrop(arg_18_1:Find("Item"), {
		id = arg_18_2[3],
		type = DROP_TYPE_EQUIP
	})
	onButton(arg_18_0, arg_18_1:Find("Item"), function()
		local var_19_0 = EquipmentProxy.GetTransformSources(arg_18_2[3])[1]

		if not var_19_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_initial_node"))

			return
		end

		arg_18_0:emit(EquipmentTransformTreeMediator.OPEN_LAYER, Context.New({
			mediator = EquipmentTransformMediator,
			viewComponent = EquipmentTransformLayer,
			data = {
				formulaId = var_19_0
			}
		}))

		return
	end, SFX_PANEL)
	arg_18_1:Find("Mask/NameText"):GetComponent("ScrollText"):SetText(Equipment.getConfigData(arg_18_2[3]).name)
	setActive(arg_18_1:Find("cratfable"), (_.any(arg_18_0.env.tracebackHelper:GetSortedEquipTraceBack(arg_18_2[3]), function(arg_20_0)
		return arg_20_0.candicates and #arg_20_0.candicates > 0 and EquipmentTransformUtil.CheckTransformFormulasSucceed(arg_20_0.formulas, arg_20_0.candicates[#arg_20_0.candicates])
	end)))
	onButton(arg_18_0, arg_18_1:Find("cratfable"), function()
		arg_18_0:emit(EquipmentTransformTreeMediator.OPEN_LAYER, Context.New({
			mediator = EquipmentTraceBackMediator,
			viewComponent = EquipmentTraceBackLayer,
			data = {
				TargetEquipmentId = arg_18_2[3]
			}
		}))

		return
	end)

	local var_18_0 = arg_18_2[4] and PlayerPrefs.GetInt("ShowTransformTip_" .. arg_18_2[3], 0) == 0

	setActive(arg_18_1:Find("Item/new"), var_18_0)

	return
end

function var_0_0.UpdateItemNodes(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.nodes) do
		arg_22_0:UpdateItemNode(iter_22_1.go, iter_22_1.cfg)
	end

	return
end

function var_0_0.UpdateItemNodeByID(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.nodes) do
		if arg_23_1 == iter_23_1.id then
			arg_23_0:UpdateItemNode(iter_23_1.go, iter_23_1.cfg)

			break
		end
	end

	return
end

function var_0_0.ReturnCanvasItems(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.nodes) do
		if not arg_24_0.plurals.EquipNode:Enqueue(iter_24_1.go, arg_24_1) then
			setParent(iter_24_1.go, arg_24_0.pluralRoot)
		end
	end

	table.clean(arg_24_0.nodes)

	for iter_24_2, iter_24_3 in ipairs(arg_24_0.links) do
		if not arg_24_0.plurals.Link:Enqueue(iter_24_3, arg_24_1) then
			setParent(iter_24_3, arg_24_0.pluralRoot)
		end
	end

	table.clean(arg_24_0.links)

	return
end

function var_0_0.willExit(arg_25_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_25_0.top, arg_25_0._tf)
	arg_25_0:ReturnCanvasItems(true)

	for iter_25_0, iter_25_1 in pairs(arg_25_0.plurals) do
		iter_25_1:Clear()
	end

	arg_25_0.loader:Clear()

	return
end

return var_0_0
