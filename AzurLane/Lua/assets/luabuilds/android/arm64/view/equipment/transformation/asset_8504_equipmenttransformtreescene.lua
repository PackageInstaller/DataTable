class = var_0_10000

local var_0_0 = "EquipmentTransformTreeScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

require = var_0_10001

local var_0_2 = var_0_10001("Mgr/Pool/PoolPlural")
local var_0_3 = "ui/EquipmentTransformTreeUI_atlas"

function var_0_1.getUIName(arg_1_0)
	return "EquipmentTransformTreeUI"
end

var_0_1.optionsPath = {
	"blur_panel/adapt/top/option"
}
var_0_1.MODE_NORMAL = 1
var_0_1.MODE_HIDESIDE = 2

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.leftPanel = var_1.Find(var_2_0, "Adapt/Left")

	local var_2_1 = arg_2_0._tf

	arg_2_0.rightPanel = var_1.Find(var_2_1, "Adapt/Right")

	local var_2_2 = arg_2_0.leftPanel
	local var_2_3 = var_1.Find(var_2_2, "Nations")

	arg_2_0.nationToggleGroup = var_1.Find(var_2_3, "ViewPort/Content")
	setActive = var_2

	local var_2_4 = arg_2_0.nationToggleGroup

	var_2(var_4.GetChild(var_2_4, 0), false)

	local var_2_5 = arg_2_0.nationToggleGroup
	local var_2_6 = var_2.GetChild(var_2_5, 0)
	local var_2_7 = var_2.Find(var_2_6, "selectedCursor").gameObject

	var_2.SetActive(var_2_7, false)

	local var_2_8 = arg_2_0.leftPanel
	local var_2_9 = var_2.Find(var_2_8, "EquipmentTypes")

	arg_2_0.equipmentTypeToggleGroup = var_2.Find(var_2_9, "ViewPort/Content")
	setActive = var_3

	local var_2_10 = arg_2_0.equipmentTypeToggleGroup

	var_3(var_5.GetChild(var_2_10, 0), false)

	local var_2_11 = arg_2_0.equipmentTypeToggleGroup
	local var_2_12 = var_3.GetChild(var_2_11, 0)
	local var_2_13 = var_3.Find(var_2_12, "selectedframe").gameObject

	var_3.SetActive(var_2_13, false)

	local var_2_14 = arg_2_0.rightPanel

	arg_2_0.TreeCanvas = var_3.Find(var_2_14, "ViewPort/Content")
	setActive = var_3

	local var_2_15 = arg_2_0.rightPanel

	var_3(var_5.Find(var_2_15, "EquipNode"), false)

	setActive = var_3

	local var_2_16 = arg_2_0.rightPanel

	var_3(var_5.Find(var_2_16, "Link"), false)

	arg_2_0.nodes = {}
	arg_2_0.links = {}

	local var_2_17 = {}
	local var_2_18 = var_0_2.New
	local var_2_19 = arg_2_0.rightPanel

	var_2_17.EquipNode = var_2_18(var_6.Find(var_2_19, "EquipNode").gameObject, 5)

	local var_2_20 = var_0_2.New
	local var_2_21 = arg_2_0.rightPanel

	var_2_17.Link = var_2_20(var_6.Find(var_2_21, "Link").gameObject, 8)
	arg_2_0.plurals = var_2_17
	pg = var_2_17
	arg_2_0.pluralRoot = var_2_17.PoolMgr.GetInstance().root

	local var_2_22 = arg_2_0._tf

	arg_2_0.top = var_3.Find(var_2_22, "blur_panel")
	AutoLoader = var_3
	arg_2_0.loader = var_3.New()

	return
end

function var_0_1.GetEnv(arg_3_0)
	local var_3_0

	if not arg_3_0.env then
		var_3_0 = {}
	end

	arg_3_0.env = var_3_0

	return arg_3_0.env
end

function var_0_1.SetEnv(arg_4_0, arg_4_1)
	arg_4_0.env = arg_4_1

	return
end

function var_0_1.didEnter(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_5_0, arg_5_0.top)

	onButton = var_1

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.top
	local var_5_3 = var_4.Find(var_5_2, "adapt/top/back")

	local function var_5_4()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_5_2

	var_1(var_5_1, var_5_3, var_5_4, var_5_2)

	if arg_5_0.contextData.targetEquipId then
		local var_5_5
		local var_5_6
		local var_5_7 = false

		pairs = var_5_3

		for iter_5_0, iter_5_1 in var_5_3(arg_5_0.env.nationsTree) do
			pairs = var_1_10009

			for iter_5_2, iter_5_3 in var_1_10009(iter_5_1) do
				ipairs = var_1_10014

				for iter_5_4, iter_5_5 in var_1_10014(iter_5_3.equipments) do
					if iter_5_5[3] == arg_5_0.contextData.targetEquipId then
						var_5_5, var_5_6 = iter_5_0, iter_5_2
						var_5_7 = true

						break
					end
				end
			end

			if var_5_7 then
				break
			end
		end

		if var_5_7 then
			arg_5_0.contextData.nation = var_5_5
			arg_5_0.contextData.equipmentTypeIndex = var_5_6
		end

		arg_5_0.contextData.targetEquipId = nil
	end

	arg_5_0:InitPage()

	if arg_5_0.contextData.mode == var_0_1.MODE_HIDESIDE then
		setActive = var_1

		var_1(arg_5_0.leftPanel, false)

		local var_5_8 = arg_5_0.rightPanel.sizeDelta

		var_5_8.x = 0

		local var_5_9 = arg_5_0.rightPanel

		var_5_9.sizeDelta = var_5_8
		setAnchoredPosition = var_5_9

		var_5_9(arg_5_0.rightPanel, {
			x = 0
		})
	end

	return
end

function var_0_1.GetSortKeys(arg_7_0)
	_ = var_1_10001

	local var_7_0 = var_1_10001.keys(arg_7_0)

	table = var_1_10002

	var_1_10002.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0 < arg_8_1
	end)

	return var_7_0
end

function var_0_1.GetSortTypes(arg_9_0)
	_ = var_1_10001

	local var_9_0 = var_1_10001.values(arg_9_0)

	table = var_1_10002

	var_1_10002.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.id < arg_10_1.id
	end)

	_ = var_2

	return var_2.map(var_9_0, function(arg_11_0)
		return arg_11_0.category2
	end)
end

function var_0_1.InitPage(arg_12_0)
	arg_12_0.firstInit = true

	local var_12_0 = arg_12_0.contextData
	local var_12_1 = arg_12_0.env
	local var_12_2

	if not var_12_0.mode then
		var_12_2 = var_0_1.MODE_NORMAL
	end

	var_12_0.mode = var_12_2

	local var_12_3 = var_12_0.nation
	local var_12_4 = var_0_1.GetSortKeys(var_12_1.nationsTree)

	if var_12_3 then
		table = var_1_10005

		if not var_1_10005.contains(var_12_4, var_12_3) then
			var_12_3 = var_12_4[1]
		end

		next = var_1_10005

		if var_1_10005(var_12_1.nationsTree[var_12_3]) == nil then
			for iter_12_0 = 2, #var_12_4 do
				next = var_1_10009

				if var_1_10009(var_12_1.nationsTree[var_12_4[iter_12_0]]) ~= nil then
					var_12_3 = var_12_4[iter_12_0]

					break
				end
			end
		end

		var_12_0.nation = nil

		arg_12_0:UpdateNations()

		table = var_5

		local var_12_5

		if not var_5.indexof(var_12_4, var_12_3) then
			var_12_5 = 1
		end

		triggerButton = var_6

		var_6(arg_12_0.nationToggles[var_12_5])

		arg_12_0.firstInit = nil

		return
	end
end

function var_0_1.UpdateNations(arg_13_0)
	local var_13_0 = var_0_1.GetSortKeys(arg_13_0.env.nationsTree)

	CustomIndexLayer = var_1_10002
	arg_13_0.nationToggles = var_1_10002.Clone2Full(arg_13_0.nationToggleGroup, #var_13_0)

	for iter_13_0 = 1, #arg_13_0.nationToggles do
		local var_13_1 = arg_13_0.nationToggles[iter_13_0]
		local var_13_2 = var_13_0[iter_13_0]
		local var_13_3 = arg_13_0.loader

		var_8.GetSprite(var_13_3, var_0_3, "nation" .. var_13_2 .. "_disable", var_13_1:Find("selectedIcon"))

		setActive = var_8

		var_8(var_13_1:Find("selectedCursor"), false)

		onButton = var_8

		local var_13_4 = arg_13_0
		local var_13_5 = var_13_1

		local function var_13_6()
			if arg_13_0.contextData.nation ~= var_13_2 then
				next = var_0

				if var_0(arg_13_0.env.nationsTree[var_13_2]) == nil then
					pg = var_0

					local var_14_0 = var_0.TipsMgr.GetInstance()
					local var_14_1 = var_0.ShowTips

					i18n = var_3

					var_14_1(var_14_0, var_3("word_comingSoon"))

					return
				end

				local var_14_2 = arg_13_0.loader
				local var_14_3 = var_0.GetSprite
				local var_14_4 = var_0_3
				local var_14_5 = "nation" .. var_13_2
				local var_14_6 = var_13_1

				var_14_3(var_14_2, var_14_4, var_14_5, var_5.Find(var_14_6, "selectedIcon"))

				if arg_13_0.contextData.nation then
					table = var_0

					local var_14_7 = var_0.indexof(var_13_0, arg_13_0.contextData.nation)

					setActive = var_1

					local var_14_8 = arg_13_0.nationToggles[var_14_7]

					var_1(var_3.Find(var_14_8, "selectedCursor"), false)

					local var_14_9 = arg_13_0.loader
					local var_14_10 = var_1.GetSprite
					local var_14_11 = var_0_3
					local var_14_12 = "nation" .. arg_13_0.contextData.nation .. "_disable"
					local var_14_13 = arg_13_0.nationToggles[var_14_7]

					var_14_10(var_14_9, var_14_11, var_14_12, var_6.Find(var_14_13, "selectedIcon"))
				end

				arg_13_0.contextData.nation = var_13_2

				local var_14_14 = arg_13_0

				var_0.UpdateEquipmentTypes(var_14_14)

				local var_14_15 = var_0_1.GetSortTypes(arg_13_0.env.nationsTree[var_13_2])[1]

				if arg_13_0.firstInit and arg_13_0.contextData.equipmentTypeIndex then
					table = var_3

					if var_3.contains(var_0, var_2) then
						var_14_15 = var_2
					end
				end

				local var_14_16 = arg_13_0.contextData

				var_14_16.equipmentTypeIndex = nil
				table = var_14_16

				local var_14_17

				if not var_14_16.indexof(var_0, var_14_15) then
					var_14_17 = 1
				end

				triggerToggle = var_3

				var_3(arg_13_0.equipmentTypeToggles[var_14_17], true)
			end

			return
		end

		SFX_UI_TAG = var_13

		var_8(var_13_4, var_13_5, var_13_6, var_13)
	end

	return
end

function var_0_1.UpdateEquipmentTypes(arg_15_0)
	local var_15_0 = var_0_1.GetSortTypes(arg_15_0.env.nationsTree[arg_15_0.contextData.nation])

	CustomIndexLayer = var_1_10002
	arg_15_0.equipmentTypeToggles = var_1_10002.Clone2Full(arg_15_0.equipmentTypeToggleGroup, #var_15_0)

	for iter_15_0 = 1, #arg_15_0.equipmentTypeToggles do
		local var_15_1 = arg_15_0.equipmentTypeToggles[iter_15_0]

		var_1_10007 = var_6.GetComponent
		typeof = var_1_10010
		Toggle = var_1_10012
		var_1_10007 = var_1_10007(var_15_1, var_1_10010(var_1_10012))
		var_1_10007.isOn = false
		var_1_10007 = var_15_0[iter_15_0]
		var_1_10010 = arg_15_0.loader

		var_8.GetSprite(var_1_10010, var_0_3, "equipmentType" .. var_1_10007, var_6:Find("itemName"), true)

		setActive = var_8
		var_1_10012 = var_6

		var_8(var_6.Find(var_1_10012, "selectedframe"), false)

		onToggle = var_8
		var_1_10010 = arg_15_0

		local var_15_2 = var_6

		function var_1_10012(arg_16_0)
			if arg_16_0 and arg_15_0.contextData.equipmentTypeIndex ~= var_1_10007 then
				var_2_10001 = arg_15_0.contextData
				var_2_10001.equipmentTypeIndex = var_1_10007

				local var_16_0 = arg_15_0

				var_2_10001.ResetCanvas(var_16_0)
			end

			setActive = var_2_10001

			local var_16_1 = var_0

			var_2_10001(var_3.Find(var_16_1, "selectedframe"), arg_16_0)

			return
		end

		SFX_UI_TAG = var_13

		var_8(var_1_10010, var_15_2, var_1_10012, var_13)
	end

	local var_15_3 = arg_15_0.equipmentTypeToggleGroup

	Vector2 = var_3
	var_15_3.anchoredPosition = var_3.zero

	local var_15_4 = arg_15_0.leftPanel
	local var_15_5 = var_2.Find(var_15_4, "EquipmentTypes")
	local var_15_6 = var_2.GetComponent

	typeof = var_5
	ScrollRect = var_1_10007

	local var_15_7 = var_15_6(var_15_5, var_5(var_1_10007))

	Vector2 = var_3
	var_15_7.velocity = var_3.zero

	return
end

local var_0_4 = {
	15,
	-4,
	15,
	6
}

function var_0_1.ResetCanvas(arg_17_0)
	EquipmentProxy = var_1_10001

	local var_17_0 = var_1_10001.EquipmentTransformTreeTemplate[arg_17_0.contextData.nation][arg_17_0.contextData.equipmentTypeIndex]

	assert = var_2

	var_2(var_17_0, "can't find Equip_upgrade_template Nation: " .. arg_17_0.contextData.nation .. " Type: " .. arg_17_0.contextData.equipmentTypeIndex)

	local var_17_1 = arg_17_0.TreeCanvas

	Vector2 = var_1_10003
	unpack = var_5
	var_17_1.sizeDelta = var_1_10003(var_5(var_17_0.canvasSize))

	local var_17_2 = arg_17_0.TreeCanvas

	Vector2 = var_3
	var_17_2.anchoredPosition = var_3.zero

	local var_17_3 = arg_17_0.rightPanel
	local var_17_4 = var_2.GetComponent

	typeof = var_5
	ScrollRect = var_7

	local var_17_5 = var_17_4(var_17_3, var_5(var_7))

	Vector2 = var_3
	var_17_5.velocity = var_3.zero

	arg_17_0:ReturnCanvasItems()

	ipairs = var_3

	for iter_17_0, iter_17_1 in var_3(var_17_0.equipments) do
		local var_17_6 = arg_17_0.plurals.EquipNode
		local var_17_7 = var_8.Dequeue(var_17_6)

		setActive = var_1_10009

		var_1_10009(var_17_7, true)

		setParent = var_1_10009

		var_1_10009(var_17_7, arg_17_0.TreeCanvas)

		table = var_1_10009

		var_1_10009.insert(arg_17_0.nodes, {
			id = iter_17_1[3],
			cfg = iter_17_1,
			go = var_17_7
		})

		var_17_7.name = iter_17_1[3]

		local var_17_8 = arg_17_0

		var_1_10009 = arg_17_0.UpdateItemNode
		tf = var_12

		var_1_10009(var_17_8, var_12(var_17_7), iter_17_1)
	end

	ipairs = var_3

	for iter_17_2, iter_17_3 in var_3(var_17_0.links) do
		for iter_17_4 = 1, #iter_17_3 - 1 do
			local var_17_9 = iter_17_3[iter_17_4]
			local var_17_10 = iter_17_3[iter_17_4 + 1]
			local var_17_11 = {
				var_17_10[1] - var_17_9[1],
				var_17_9[2] - var_17_10[2]
			}

			math = var_15

			local var_17_12 = var_15.abs(var_17_11[1])

			math = var_16

			if var_16.abs(var_17_11[2]) < var_17_12 then
				math = var_17_13

				local var_17_13

				if not var_17_13.abs(var_17_11[1]) then
					math = var_17_13
					var_17_13 = var_17_13.abs(var_17_11[2])
				end

				if var_15 then
					var_17_11[2] = 0
				else
					var_17_11[1] = 0
				end

				math = var_17

				local var_17_14

				if 1 - var_17.sign(var_17_11[1]) == 1 or not var_17_14 then
					math = var_18
					var_17_14 = 2 - var_18.sign(var_17_11[2])
				end

				math = var_18

				local var_17_15 = var_18.deg2Rad * 90 * var_17_14

				if #iter_17_3 == 2 then
					local var_17_16 = arg_17_0.plurals.Link
					local var_17_17 = var_19.Dequeue(var_17_16)

					table = var_1_10020
					var_1_10020 = var_1_10020.insert

					local var_17_18 = arg_17_0.links

					go = var_1_10023

					var_1_10020(var_17_18, var_1_10023(var_17_17))

					setActive = var_1_10020

					var_1_10020(var_17_17, true)

					setParent = var_1_10020

					var_1_10020(var_17_17, arg_17_0.TreeCanvas)

					local var_17_19 = arg_17_0.loader

					var_1_10020.GetSprite(var_17_19, var_0_3, var_17_11[2] == 0 and "wirehead" or "wireline", var_17_17)

					tf = var_1_10020
					var_1_10020 = var_1_10020(var_17_17)
					Vector2 = var_17_16
					var_1_10020.sizeDelta = var_17_16(28, 26)
					tf = var_1_10020
					var_1_10020 = var_1_10020(var_17_17)
					Vector2 = var_21
					var_1_10020.pivot = var_21(0.5, 0.5)
					tf = var_1_10020
					var_1_10020 = var_1_10020(var_17_17)
					Quaternion = var_21
					var_1_10020.localRotation = var_21.Euler(0, 0, var_17_14 * 90)
					Vector2 = var_1_10020
					math = var_22

					local var_17_20 = var_22.cos(var_17_15)

					math = var_1_10023
					var_1_10020 = var_1_10020(var_17_20, var_1_10023.sin(var_17_15)) * var_0_4[(var_17_14 - 1) % 4 + 1]
					tf = var_21

					local var_17_21 = var_21(var_17_17)

					Vector2 = var_22
					var_17_21.anchoredPosition = var_22(var_17_9[1] + var_1_10020.x, -var_17_9[2] + var_1_10020.y)
					var_1_10023 = arg_17_0.plurals.Link

					local var_17_22 = var_21.Dequeue(var_1_10023)

					table = var_21

					local var_17_23 = var_21.insert

					var_1_10023 = arg_17_0.links
					go = var_24

					var_17_23(var_1_10023, var_24(var_17_22))

					setActive = var_17_23

					var_17_23(var_17_22, true)

					setParent = var_17_23

					var_17_23(var_17_22, arg_17_0.TreeCanvas)

					var_1_10023 = arg_17_0.loader

					var_21.GetSprite(var_1_10023, var_0_3, "wiretail", var_17_22)

					tf = var_21

					local var_17_24 = var_21(var_17_22)

					Vector2 = var_22
					var_17_24.sizeDelta = var_22(28, 26)
					tf = var_17_24

					local var_17_25 = var_17_24(var_17_22)

					Vector2 = var_22
					var_17_25.pivot = var_22(0.5, 0.5)
					tf = var_17_25

					local var_17_26 = var_17_25(var_17_22)

					Quaternion = var_22
					var_17_26.localRotation = var_22.Euler(0, 0, var_17_14 * 90)
					Vector2 = var_17_26
					math = var_1_10023
					var_1_10023 = var_1_10023.cos(var_17_15)
					math = var_24

					local var_17_27 = var_17_26(var_1_10023, var_24.sin(var_17_15)) * -var_0_4[(var_17_14 + 1) % 4 + 1]

					tf = var_22

					local var_17_28 = var_22(var_17_22)

					Vector2 = var_1_10023
					var_17_28.anchoredPosition = var_1_10023(var_17_10[1] + var_17_27.x, -var_17_10[2] + var_17_27.y)

					local var_17_29 = arg_17_0.plurals.Link
					local var_17_30 = var_22.Dequeue(var_17_29)

					table = var_22

					local var_17_31 = var_22.insert
					local var_17_32 = arg_17_0.links

					go = var_25

					var_17_31(var_17_32, var_25(var_17_30))

					setActive = var_17_31

					var_17_31(var_17_30, true)

					setParent = var_17_31

					var_17_31(var_17_30, arg_17_0.TreeCanvas)

					local var_17_33 = arg_17_0.loader

					var_22.GetSprite(var_17_33, var_0_3, "wireline", var_17_30)

					tf = var_22

					local var_17_34 = var_22(var_17_30)

					Vector2 = var_1_10023
					math = var_25
					var_17_34.sizeDelta = var_1_10023(var_25.max(0, var_17_13 - var_0_4[(var_17_14 - 1) % 4 + 1] - var_0_4[(var_17_14 + 1) % 4 + 1] - 28), 16)
					tf = var_17_34

					local var_17_35 = var_17_34(var_17_30)

					Vector2 = var_1_10023
					var_17_35.pivot = var_1_10023(0, 0.5)
					tf = var_17_35

					local var_17_36 = var_17_35(var_17_30)

					Quaternion = var_1_10023
					var_17_36.localRotation = var_1_10023.Euler(0, 0, var_17_14 * 90)
					Vector2 = var_17_36
					math = var_24

					local var_17_37 = var_24.cos(var_17_15)

					math = var_25

					local var_17_38 = var_17_36(var_17_37, var_25.sin(var_17_15)) * 14

					tf = var_1_10023
					var_1_10023 = var_1_10023(var_17_30)
					Vector2 = var_17_37
					var_1_10023.anchoredPosition = var_17_37(var_17_9[1] + var_1_10020.x, -var_17_9[2] + var_1_10020.y) + var_17_38

					break
				end

				local var_17_39 = arg_17_0.plurals.Link
				local var_17_40 = var_19.Dequeue(var_17_39)

				table = var_1_10020
				var_1_10020 = var_1_10020.insert

				local var_17_41 = arg_17_0.links

				go = var_1_10023

				var_1_10020(var_17_41, var_1_10023(var_17_40))

				setActive = var_1_10020

				var_1_10020(var_17_40, true)

				setParent = var_1_10020

				var_1_10020(var_17_40, arg_17_0.TreeCanvas)

				var_1_10020 = 1

				if iter_17_4 == 1 then
					var_1_10023 = arg_17_0.loader

					var_21.GetSprite(var_1_10023, var_0_3, var_17_11[2] == 0 and "wirehead" or "wireline", var_17_40)

					local var_17_42 = var_17_13 + 14 + var_1_10020 - var_0_4[(var_17_14 - 1) % 4 + 1]

					tf = var_22

					local var_17_43 = var_22(var_17_40)

					Vector2 = var_1_10023
					var_17_43.sizeDelta = var_1_10023(var_17_42, 26)
					tf = var_17_43

					local var_17_44 = var_17_43(var_17_40)

					Vector2 = var_1_10023
					var_17_44.pivot = var_1_10023((var_17_42 - var_1_10020) / var_17_42, 0.5)
					tf = var_17_44

					local var_17_45 = var_17_44(var_17_40)

					Quaternion = var_1_10023
					var_17_45.localRotation = var_1_10023.Euler(0, 0, var_17_14 * 90)
					tf = var_17_45

					local var_17_46 = var_17_45(var_17_40)

					Vector2 = var_1_10023
					var_17_46.anchoredPosition = var_1_10023(var_17_10[1], -var_17_10[2])
				elseif iter_17_4 + 1 == #iter_17_3 then
					var_1_10023 = arg_17_0.loader

					var_21.GetSprite(var_1_10023, var_0_3, "wiretail", var_17_40)

					tf = var_21

					local var_17_47 = var_21(var_17_40)

					Vector2 = var_22
					var_17_47.sizeDelta = var_22(var_17_13 + 14 + var_1_10020 - var_0_4[(var_17_14 + 1) % 4 + 1], 26)
					tf = var_17_47

					local var_17_48 = var_17_47(var_17_40)

					Vector2 = var_22
					var_17_48.pivot = var_22(var_1_10020 / (var_17_13 + 14 + var_1_10020 - var_0_4[(var_17_14 + 1) % 4 + 1]), 0.5)
					tf = var_17_48

					local var_17_49 = var_17_48(var_17_40)

					Quaternion = var_22
					var_17_49.localRotation = var_22.Euler(0, 0, var_17_14 * 90)
					tf = var_17_49

					local var_17_50 = var_17_49(var_17_40)

					Vector2 = var_22
					var_17_50.anchoredPosition = var_22(var_17_9[1], -var_17_9[2])
				else
					var_1_10023 = arg_17_0.loader

					var_21.GetSprite(var_1_10023, var_0_3, "wireline", var_17_40)

					tf = var_21

					local var_17_51 = var_21(var_17_40)

					Vector2 = var_22
					var_17_51.sizeDelta = var_22(var_17_13 + var_1_10020 * 2, 16)
					tf = var_17_51

					local var_17_52 = var_17_51(var_17_40)

					Vector2 = var_22
					var_17_52.pivot = var_22(var_1_10020 / (var_17_13 + var_1_10020 * 2), 0.5)
					tf = var_17_52

					local var_17_53 = var_17_52(var_17_40)

					Quaternion = var_22
					var_17_53.localRotation = var_22.Euler(0, 0, var_17_14 * 90)
					tf = var_17_53

					local var_17_54 = var_17_53(var_17_40)

					Vector2 = var_22
					var_17_54.anchoredPosition = var_22(var_17_9[1], -var_17_9[2])
				end
			end
		end
	end

	return
end

function var_0_1.UpdateItemNode(arg_18_0, arg_18_1, arg_18_2)
	tf = var_1_10003
	arg_18_1 = var_1_10003(arg_18_1)
	Vector2 = var_3
	arg_18_1.anchoredPosition = var_3(arg_18_2[1], -arg_18_2[2])
	updateDrop = var_3

	local var_18_0 = arg_18_1:Find("Item")
	local var_18_1 = {
		id = arg_18_2[3]
	}

	DROP_TYPE_EQUIP = var_7
	var_18_1.type = var_7

	var_3(var_18_0, var_18_1)

	onButton = var_3

	local var_18_2 = arg_18_0
	local var_18_3 = arg_18_1
	local var_18_4 = arg_18_1.Find(var_18_3, "Item")

	local function var_18_5()
		EquipmentProxy = var_2_10000

		if not var_2_10000.GetTransformSources(arg_18_2[3])[1] then
			pg = var_2_10001

			local var_19_0 = var_2_10001.TipsMgr.GetInstance()
			local var_19_1 = var_1.ShowTips

			i18n = var_2_10004

			var_19_1(var_19_0, var_2_10004("equipment_upgrade_initial_node"))

			return
		end

		local var_19_2 = arg_18_0
		local var_19_3 = var_1.emit

		EquipmentTransformTreeMediator = var_2_10004

		local var_19_4 = var_2_10004.OPEN_LAYER

		Context = var_2_10005

		local var_19_5 = var_2_10005.New
		local var_19_6 = {}

		EquipmentTransformMediator = var_2_10008
		var_19_6.mediator = var_2_10008
		EquipmentTransformLayer = var_2_10008
		var_19_6.viewComponent = var_2_10008
		var_19_6.data = {
			formulaId = var_0
		}

		var_19_3(var_19_2, var_19_4, var_19_5(var_19_6))

		return
	end

	SFX_PANEL = var_18_3

	var_3(var_18_2, var_18_4, var_18_5, var_18_3)

	local var_18_6 = arg_18_1:Find("Mask/NameText")
	local var_18_7 = var_3.GetComponent(var_18_6, "ScrollText")
	local var_18_8 = var_3.SetText

	Equipment = var_6

	var_18_8(var_18_7, var_6.getConfigData(arg_18_2[3]).name)

	local var_18_9 = arg_18_0.env.tracebackHelper
	local var_18_10 = var_3.GetSortedEquipTraceBack(var_18_9, arg_18_2[3])

	_ = var_1_10004

	local var_18_11 = var_1_10004.any(var_18_10, function(arg_20_0)
		if arg_20_0.candicates then
			::label_20_0::

			if #var_1 > 0 then
				EquipmentTransformUtil = var_2_10002
				var_2_10002 = var_2_10002.CheckTransformFormulasSucceed(arg_20_0.formulas, var_1[#var_1])
			else
				var_2_10002 = false
			end

			if false then
				var_2_10002 = true
			end
		end

		return var_2_10002
	end)

	setActive = var_18_9

	var_18_9(arg_18_1:Find("cratfable"), var_18_11)

	onButton = var_18_9

	var_18_9(arg_18_0, arg_18_1:Find("cratfable"), function()
		local var_21_0 = arg_18_0
		local var_21_1 = var_0.emit

		EquipmentTransformTreeMediator = var_2_10003

		local var_21_2 = var_2_10003.OPEN_LAYER

		Context = var_2_10004

		local var_21_3 = var_2_10004.New
		local var_21_4 = {}

		EquipmentTraceBackMediator = var_2_10007
		var_21_4.mediator = var_2_10007
		EquipmentTraceBackLayer = var_2_10007
		var_21_4.viewComponent = var_2_10007
		var_21_4.data = {
			TargetEquipmentId = arg_18_2[3]
		}

		var_21_1(var_21_0, var_21_2, var_21_3(var_21_4))

		return
	end)

	local var_18_12

	if arg_18_2[4] then
		PlayerPrefs = var_18_12
		var_18_12 = var_18_12.GetInt("ShowTransformTip_" .. arg_18_2[3], 0) == 0
	end

	setActive = var_6

	var_6(arg_18_1:Find("Item/new"), var_18_12)

	return
end

function var_0_1.UpdateItemNodes(arg_22_0)
	ipairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.nodes) do
		arg_22_0:UpdateItemNode(iter_22_1.go, iter_22_1.cfg)
	end

	return
end

function var_0_1.UpdateItemNodeByID(arg_23_0, arg_23_1)
	ipairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.nodes) do
		if arg_23_1 == iter_23_1.id then
			arg_23_0:UpdateItemNode(iter_23_1.go, iter_23_1.cfg)

			break
		end
	end

	return
end

function var_0_1.ReturnCanvasItems(arg_24_0, arg_24_1)
	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.nodes) do
		local var_24_0 = arg_24_0.plurals.EquipNode

		if not var_7.Enqueue(var_24_0, iter_24_1.go, arg_24_1) then
			setParent = var_1_10008

			var_1_10008(iter_24_1.go, arg_24_0.pluralRoot)
		end
	end

	table = var_2

	var_2.clean(arg_24_0.nodes)

	ipairs = var_2

	for iter_24_2, iter_24_3 in var_2(arg_24_0.links) do
		local var_24_1 = arg_24_0.plurals.Link

		if not var_7.Enqueue(var_24_1, iter_24_3, arg_24_1) then
			setParent = var_1_10008

			var_1_10008(iter_24_3, arg_24_0.pluralRoot)
		end
	end

	table = var_2

	var_2.clean(arg_24_0.links)

	return
end

function var_0_1.willExit(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_25_0, arg_25_0.top, arg_25_0._tf)
	arg_25_0:ReturnCanvasItems(true)

	pairs = var_1

	for iter_25_0, iter_25_1 in var_1(arg_25_0.plurals) do
		iter_25_1:Clear()
	end

	local var_25_1 = arg_25_0.loader

	var_1.Clear(var_25_1)

	return
end

return var_0_1
