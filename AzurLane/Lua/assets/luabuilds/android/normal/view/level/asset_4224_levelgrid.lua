class = var_0_10000

local var_0_0 = "LevelGrid"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BasePanel"))

require = var_0_0

local var_0_2 = var_0_0("Mgr/Pool/PoolPlural")

Vector3 = var_2
var_0_1.MapDefaultPos = var_2(420, -1000, -1000)

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	GameObject = var_1

	local var_1_0 = var_1.Find("LevelCamera")
	local var_1_1 = var_1.GetComponent

	typeof = var_1_10003
	Camera = var_1_10004
	arg_1_0.levelCam = var_1_1(var_1_0, var_1_10003(var_1_10004))
	GameObject = var_1

	local var_1_2 = var_1.Find("LevelCamera/Canvas")
	local var_1_3 = var_1.GetComponent

	typeof = var_3
	Canvas = var_1_10004

	local var_1_4 = var_1_3(var_1_2, var_3(var_1_10004))

	ChapterConst = var_1_2
	var_1_4.sortingOrder = var_1_2.PriorityMin - 1
	arg_1_0.quadTws = {}
	arg_1_0.presentTws = {}
	arg_1_0.markTws = {}
	arg_1_0.tweens = {}
	arg_1_0.markQuads = {}
	arg_1_0.pools = {}
	arg_1_0.edgePools = {}
	GameObject = var_2
	arg_1_0.poolParent = var_2.Find("__Pool__")
	arg_1_0.opBtns = {}
	arg_1_0.itemCells = {}
	arg_1_0.attachmentCells = {}
	arg_1_0.extraAttachmentCells = {}
	arg_1_0.weatherCells = {}
	arg_1_0.onShipStepChange = nil
	arg_1_0.onShipArrived = nil
	arg_1_0.lastSelectedId = -1
	arg_1_0.quadState = -1
	arg_1_0.subTeleportTargetLine = nil
	arg_1_0.missileStrikeTargetLine = nil
	arg_1_0.cellEdges = {}
	arg_1_0.walls = {}
	LoadAny = var_2

	local var_1_5 = "artresource/effect/common/material/add"
	local var_1_6 = ""

	typeof = var_1_10005
	Material = var_1_10006
	arg_1_0.material_Add = var_2(var_1_5, var_1_6, var_1_10005(var_1_10006))
	AutoLoader = var_2
	arg_1_0.loader = var_2.New()

	return
end

function var_0_1.ExtendItem(arg_2_0, arg_2_1, arg_2_2)
	IsNil = var_1_10003

	if var_1_10003(arg_2_0[arg_2_1]) then
		arg_2_0[arg_2_1] = arg_2_2
	end

	return
end

function var_0_1.getFleetPool(arg_3_0, arg_3_1)
	local var_3_0 = "fleet_" .. arg_3_1
	local var_3_2

	if not arg_3_0.pools[var_3_0] then
		local var_3_1 = arg_3_0.shipTpl

		FleetType = var_1_10005

		if arg_3_1 == var_1_10005.Submarine then
			var_3_1 = arg_3_0.subTpl
		else
			FleetType = var_5

			if arg_3_1 == var_5.Transport then
				var_3_1 = arg_3_0.transportTpl
			end
		end

		var_3_2 = var_0_2.New(var_3_1.gameObject, 2)
		arg_3_0.pools[var_3_0] = var_3_2
	end

	return var_3_2
end

function var_0_1.getChampionPool(arg_4_0, arg_4_1)
	local var_4_0 = "champion_" .. arg_4_1
	local var_4_2

	if not arg_4_0.pools[var_4_0] then
		local var_4_1 = arg_4_0.championTpl

		ChapterConst = var_1_10005

		if arg_4_1 == var_1_10005.TemplateOni then
			var_4_1 = arg_4_0.oniTpl
		else
			ChapterConst = var_5

			if arg_4_1 == var_5.TemplateEnemy then
				var_4_1 = arg_4_0.enemyTpl
			end
		end

		var_4_2 = var_0_2.New(var_4_1.gameObject, 3)
		arg_4_0.pools[var_4_0] = var_4_2
	end

	return var_4_2
end

function var_0_1.AddEdgePool(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_0.edgePools[arg_5_1] then
		return
	end

	GameObject = var_6

	local var_5_0 = var_6.New(arg_5_1)
	local var_5_1 = var_6.AddComponent

	typeof = var_1_10009
	Image = var_1_10010
	var_5_1(var_5_0, var_1_10009(var_1_10010)).enabled = false
	arg_5_0.edgePools[arg_5_1] = var_0_2.New(var_6, 32)

	local var_5_2

	parallelAsync = var_8

	var_8({
		function(arg_6_0)
			if not arg_5_3 then
				arg_6_0()

				return
			end

			local var_6_0 = arg_5_0.loader
			local var_6_1 = var_1.LoadReference
			local var_6_2 = arg_5_2
			local var_6_3 = arg_5_3

			typeof = var_2_10005
			Sprite = var_2_10006

			var_6_1(var_6_0, var_6_2, var_6_3, var_2_10005(var_2_10006), function(arg_7_0)
				var_5_2 = arg_7_0

				arg_6_0()

				return
			end)

			return
		end
	}, function()
		local function var_8_0(arg_9_0)
			go = var_3_10001

			local var_9_0 = var_3_10001(arg_9_0)
			local var_9_1 = var_1.GetComponent

			typeof = var_3_10003
			Image = var_3_10004

			local var_9_2 = var_9_1(var_9_0, var_3_10003(var_3_10004))

			var_9_2.enabled = true
			type = var_2

			if var_2(arg_5_4) == "table" then
				Color = var_9_3

				local var_9_3 = var_9_3.New

				unpack = var_3

				if not var_9_3(var_3(arg_5_4)) then
					Color = var_9_3
					var_9_3 = var_9_3.white
				end

				var_9_2.color = var_9_3

				local var_9_4

				if not arg_5_3 or not var_5_2 then
					var_9_4 = nil
				end

				var_9_2.sprite = var_9_4

				local var_9_5

				if not arg_5_5 then
					var_9_5 = nil
				end

				var_9_2.material = var_9_5

				return
			end
		end

		if arg_5_0.edgePools[arg_5_1].prefab then
			var_8_0(var_1.prefab)
		end

		if var_1.items then
			pairs = var_2

			for iter_8_0, iter_8_1 in var_2(var_1.items) do
				var_8_0(iter_8_1)
			end
		end

		if arg_5_0.cellEdges[arg_5_1] then
			next = var_2

			if var_2(arg_5_0.cellEdges[arg_5_1]) then
				pairs = var_2

				for iter_8_2, iter_8_3 in var_2(arg_5_0.cellEdges[arg_5_1]) do
					var_8_0(iter_8_3)
				end
			end
		end

		return
	end)

	return
end

function var_0_1.GetEdgePool(arg_10_0, arg_10_1)
	assert = var_1_10002

	var_1_10002(arg_10_1, "Missing Key")

	local var_10_0 = arg_10_0.edgePools[arg_10_1]

	assert = var_3

	var_3(var_10_0, "Must Create Pool before Using")

	return var_10_0
end

function var_0_1.initAll(arg_11_0, arg_11_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_12_0)
			local var_12_0 = arg_11_0

			var_1.initPlane(var_12_0)

			local var_12_1 = arg_11_0

			var_1.initDrag(var_12_1)

			onNextTick = var_1

			var_1(arg_12_0)

			return
		end,
		function(arg_13_0)
			if arg_11_0.exited then
				return
			end

			local var_13_0 = arg_11_0

			var_1.initTargetArrow(var_13_0)

			local var_13_1 = arg_11_0

			var_1.InitDestinationMark(var_13_1)

			onNextTick = var_1

			var_1(arg_13_0)

			return
		end,
		function(arg_14_0)
			if arg_11_0.exited then
				return
			end

			local var_14_0 = 0

			ChapterConst = var_2_10002

			for iter_14_0 = var_14_0, var_2_10002.MaxRow - 1 do
				local var_14_1 = 0

				ChapterConst = var_2_10006

				for iter_14_1 = var_14_1, var_2_10006.MaxColumn - 1 do
					local var_14_2 = arg_11_0

					var_9.initCell(var_14_2, iter_14_0, iter_14_1)
				end
			end

			local var_14_3 = arg_11_0

			var_1.UpdateItemCells(var_14_3)

			local var_14_4 = arg_11_0
			local var_14_5 = var_1.updateQuadCells

			ChapterConst = var_3

			var_14_5(var_14_4, var_3.QuadStateFrozen)

			onNextTick = var_14_5

			var_14_5(arg_14_0)

			return
		end,
		function(arg_15_0)
			if arg_11_0.exited then
				return
			end

			local var_15_0 = arg_11_0

			var_1.AddEdgePool(var_15_0, "SubmarineHunting", "ui/commonUI_atlas", "white_dot", {
				1,
				0,
				0
			}, arg_11_0.material_Add)

			local var_15_1 = arg_11_0

			var_1.updateAttachments(var_15_1)

			local var_15_2 = arg_11_0

			var_1.UpdateFloor(var_15_2)

			local var_15_3 = arg_11_0

			var_1.UpdateWeatherCells(var_15_3)

			local var_15_4 = arg_11_0

			var_1.InitWalls(var_15_4)

			local var_15_5 = arg_11_0

			var_1.InitIdolsAnim(var_15_5)

			onNextTick = var_1

			var_1(arg_15_0)

			return
		end,
		function(arg_16_0)
			if arg_11_0.exited then
				return
			end

			parallelAsync = var_1

			var_1({
				function(arg_17_0)
					local var_17_0 = arg_11_0

					var_1.initFleets(var_17_0, arg_17_0)

					return
				end,
				function(arg_18_0)
					local var_18_0 = arg_11_0

					var_1.initChampions(var_18_0, arg_18_0)

					return
				end
			}, arg_16_0)

			return
		end,
		function()
			local var_19_0 = arg_11_0

			var_0.OnChangeSubAutoAttack(var_19_0)

			local var_19_1 = arg_11_0
			local var_19_2 = var_0.updateQuadCells

			ChapterConst = var_2_10002

			var_19_2(var_19_1, var_2_10002.QuadStateNormal)

			existCall = var_19_2

			var_19_2(arg_11_1)

			return
		end
	})

	return
end

function var_0_1.clearAll(arg_20_0)
	pairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.tweens) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_20_0)
	end

	table = var_1

	var_1.clear(arg_20_0.tweens)

	local var_20_0 = arg_20_0.loader

	var_1.Clear(var_20_0)

	IsNil = var_1

	if not var_1(arg_20_0.cellRoot) then
		arg_20_0:clearFleets()
		arg_20_0:clearChampions()
		arg_20_0:clearTargetArrow()
		arg_20_0:ClearDestinationMark()
		arg_20_0:ClearIdolsAnim()

		pairs = var_1

		for iter_20_2, iter_20_3 in var_1(arg_20_0.itemCells) do
			iter_20_3:Clear()
		end

		table = var_1

		var_1.clear(arg_20_0.itemCells)

		pairs = var_1

		for iter_20_4, iter_20_5 in var_1(arg_20_0.attachmentCells) do
			iter_20_5:Clear()
		end

		table = var_1

		var_1.clear(arg_20_0.attachmentCells)

		pairs = var_1

		for iter_20_6, iter_20_7 in var_1(arg_20_0.extraAttachmentCells) do
			iter_20_7:Clear()
		end

		table = var_1

		var_1.clear(arg_20_0.extraAttachmentCells)

		pairs = var_1

		for iter_20_8, iter_20_9 in var_1(arg_20_0.weatherCells) do
			iter_20_9:Clear()
		end

		table = var_1

		var_1.clear(arg_20_0.weatherCells)

		local var_20_1 = 0

		ChapterConst = var_2

		for iter_20_10 = var_20_1, var_2.MaxRow - 1 do
			local var_20_2 = 0

			ChapterConst = var_1_10006

			for iter_20_11 = var_20_2, var_1_10006.MaxColumn - 1 do
				arg_20_0:clearCell(iter_20_10, iter_20_11)
			end
		end

		pairs = var_20_1

		for iter_20_12, iter_20_13 in var_20_1(arg_20_0.walls) do
			iter_20_13:Clear()
		end

		table = var_1

		var_1.clear(arg_20_0.walls)
		arg_20_0:clearPlane()
	end

	arg_20_0.material_Add = nil
	pairs = var_1

	for iter_20_14, iter_20_15 in var_1(arg_20_0.edgePools) do
		iter_20_15:Clear()
	end

	arg_20_0.edgePools = nil
	pairs = var_1

	for iter_20_16, iter_20_17 in var_1(arg_20_0.pools) do
		iter_20_17:ClearItems()
	end

	arg_20_0.pools = nil
	GetOrAddComponent = var_1
	var_1(arg_20_0._tf, "EventTriggerListener").enabled = false

	if arg_20_0.dragTrigger then
		ClearEventTrigger = var_2

		var_2(arg_20_0.dragTrigger)

		arg_20_0.dragTrigger = nil
	end

	LeanTween = var_2

	var_2.cancel(arg_20_0._tf)

	return
end

local var_0_3 = 640

function var_0_1.initDrag(arg_21_0)
	getSizeRate = var_1_10001

	local var_21_0, var_21_1, var_21_2 = var_1_10001()
	local var_21_3 = arg_21_0.contextData.chapterVO.theme
	local var_21_4 = var_21_2 * 0.5

	math = var_1_10007

	local var_21_5 = var_1_10007.tan

	math = var_1_10008

	local var_21_6 = var_21_4 / var_21_5(var_1_10008.deg2Rad * var_21_3.fov * 0.5)

	math = var_7

	local var_21_7 = var_7.deg2Rad * var_21_3.angle

	Vector3 = var_8

	local var_21_8 = 0

	math = var_1_10010

	local var_21_9 = -var_1_10010.sin(var_21_7)

	math = var_11

	local var_21_10 = var_8(var_21_8, var_21_9, -var_11.cos(var_21_7))

	Vector3 = var_21_8

	local var_21_11 = var_21_8(var_21_3.offsetx, var_21_3.offsety, var_21_3.offsetz) + var_0_1.MapDefaultPos

	Vector3 = var_10

	local var_21_12 = var_10.Dot(var_21_10, var_21_11)

	math = var_11

	local var_21_13 = var_21_0 * var_11.clamp((var_21_6 - var_21_12) / var_21_6, 0, 1)
	local var_21_14 = arg_21_0.plane
	local var_21_15 = var_11.Find(var_21_14, "display").anchoredPosition
	local var_21_16 = var_0_3 - var_21_11.x - var_21_15.x
	local var_21_17 = var_0_1.MapDefaultPos.y - var_21_11.y - var_21_15.y
	local var_21_18, var_21_19, var_21_20, var_21_21 = var_4:getDragExtend()

	arg_21_0.leftBound = var_21_16 - var_21_19
	arg_21_0.rightBound = var_21_16 + var_21_18
	arg_21_0.topBound = var_21_17 + var_21_21
	arg_21_0.bottomBound = var_21_17 - var_21_20

	local var_21_22 = arg_21_0._tf

	Vector2 = var_1_10020
	var_21_22.sizeDelta = var_1_10020(var_21_1 * 2, var_21_2 * 2)
	GetOrAddComponent = var_21_22
	arg_21_0.dragTrigger = var_21_22(arg_21_0._tf, "EventTriggerListener")
	arg_21_0.dragTrigger.enabled = true

	local var_21_23 = arg_21_0.dragTrigger

	var_19.AddDragFunc(var_21_23, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_21_0._tf.anchoredPosition

		math = var_2_10003
		var_22_0.x = var_2_10003.clamp(var_22_0.x + arg_22_1.delta.x * var_21_13.x, arg_21_0.leftBound, arg_21_0.rightBound)
		math = var_3

		local var_22_1 = var_3.clamp
		local var_22_2 = var_22_0.y
		local var_22_3 = arg_22_1.delta.y * var_21_13.y

		math = var_6
		var_22_0.y = var_22_1(var_22_2 + var_22_3 / var_6.cos(var_21_7), arg_21_0.bottomBound, arg_21_0.topBound)
		arg_21_0._tf.anchoredPosition = var_22_0

		return
	end)

	return
end

function var_0_1.initPlane(arg_23_0)
	local var_23_0 = arg_23_0.contextData.chapterVO.theme

	arg_23_0.levelCam.fieldOfView = var_23_0.fov

	local var_23_1

	PoolMgr = var_4

	local var_23_2 = var_4.GetInstance()

	var_4.GetPrefab(var_23_2, "chapter/plane", "", false, function(arg_24_0)
		var_23_1 = arg_24_0.transform

		return
	end)

	arg_23_0.plane = var_23_1
	ChapterConst = var_4
	var_23_1.name = var_4.PlaneName

	var_23_1:SetParent(arg_23_0._tf, false)

	Vector3 = var_4
	var_23_1.anchoredPosition3D = var_4(var_23_0.offsetx, var_23_0.offsety, var_23_0.offsetz) + var_0_1.MapDefaultPos
	arg_23_0.cellRoot = var_23_1:Find("cells")
	arg_23_0.quadRoot = var_23_1:Find("quads")
	arg_23_0.bottomMarkRoot = var_23_1:Find("buttomMarks")
	arg_23_0.topMarkRoot = var_23_1:Find("topMarks")
	arg_23_0.restrictMap = var_23_1:Find("restrictMap")
	arg_23_0.UIFXList = var_23_1:Find("UI_FX_list")

	for iter_23_0 = 1, arg_23_0.UIFXList.childCount do
		local var_23_3 = arg_23_0.UIFXList
		local var_23_4 = var_8.GetChild(var_23_3, iter_23_0 - 1)

		setActive = var_23_3

		var_23_3(var_23_4, false)
	end

	local var_23_5 = arg_23_0.UIFXList

	if var_4.Find(var_23_5, var_1:getConfig("uifx")) then
		setActive = var_23_5

		var_23_5(var_4, true)
	end

	local var_23_6 = var_1
	local var_23_7 = var_1.getConfig(var_23_6, "chapter_fx")

	type = var_23_6

	if var_23_6(var_23_7) == "table" then
		pairs = var_6

		for iter_23_1, iter_23_2 in var_6(var_23_7) do
			if #iter_23_1 <= 0 then
				return
			end

			local var_23_8 = arg_23_0.loader

			var_11.GetPrefab(var_23_8, "effect/" .. iter_23_1, iter_23_1, function(arg_25_0)
				setParent = var_2_10001

				var_2_10001(arg_25_0, arg_23_0.UIFXList)

				if iter_23_2.offset then
					tf = var_1

					local var_25_0 = var_1(arg_25_0)

					Vector3 = var_2
					unpack = var_3
					var_25_0.localPosition = var_2(var_3(iter_23_2.offset))
				end

				if iter_23_2.rotation then
					tf = var_1

					local var_25_1 = var_1(arg_25_0)

					Quaternion = var_2

					local var_25_2 = var_2.Euler

					unpack = var_3
					var_25_1.localRotation = var_25_2(var_3(iter_23_2.rotation))
				end

				return
			end)
		end
	end

	local var_23_9 = var_23_1:Find("display")
	local var_23_10 = var_6.Find(var_23_9, "mask/sea")

	GetImageSpriteFromAtlasAsync = var_23_9

	var_23_9("chapter/pic/" .. var_23_0.assetSea, var_23_0.assetSea, var_23_10)

	local var_23_11 = var_1.indexMin

	arg_23_0.indexMax = var_1.indexMax
	arg_23_0.indexMin = var_23_11
	Vector2 = var_23_11

	local var_23_12 = arg_23_0.indexMin.y

	ChapterConst = var_10

	local var_23_13 = var_23_11(var_23_12, var_10.MaxRow * 0.5 - arg_23_0.indexMax.x - 1)

	Vector2 = var_23_12

	local var_23_14 = var_23_12(arg_23_0.indexMax.y - arg_23_0.indexMin.y + 1, arg_23_0.indexMax.x - arg_23_0.indexMin.x + 1)
	local var_23_15 = var_23_0.cellSize + var_23_0.cellSpace

	Vector2 = var_11

	local var_23_16 = var_11.Scale(var_23_13, var_23_15)

	Vector2 = var_11
	var_6.anchoredPosition = var_23_16 + var_11.Scale(var_23_14, var_23_15) * 0.5
	var_6.sizeDelta = var_9
	arg_23_0.restrictMap.anchoredPosition = var_23_16 + var_9 * 0.5

	local var_23_17 = arg_23_0.restrictMap

	var_23_17.sizeDelta = var_9
	Vector2 = var_23_17
	math = var_12

	local var_23_18 = var_12.floor(var_6.sizeDelta.x / var_23_15.x)

	math = var_13

	local var_23_19 = var_23_17(var_23_18, var_13.floor(var_6.sizeDelta.y / var_23_15.y))
	local var_23_20 = var_6:Find("ABC")
	local var_23_21 = var_12.GetChild(var_23_20, 0)
	local var_23_22 = var_12
	local var_23_23 = var_12.GetComponent

	typeof = var_1_10016
	GridLayoutGroup = var_1_10017

	local var_23_24 = var_23_23(var_23_22, var_1_10016(var_1_10017))

	Vector2 = var_23_22
	var_23_24.cellSize = var_23_22(var_23_0.cellSize.x, var_23_0.cellSize.y)
	Vector2 = var_15
	var_23_24.spacing = var_15(var_23_0.cellSpace.x, var_23_0.cellSpace.y)
	var_23_24.padding.left = var_23_0.cellSpace.x

	for iter_23_3 = var_12.childCount - 1, var_23_19.x, -1 do
		Destroy = var_1_10019

		var_1_10019(var_12:GetChild(iter_23_3))
	end

	for iter_23_4 = var_12.childCount, var_23_19.x - 1 do
		Instantiate = var_1_10019
		var_1_10020 = var_1_10019(var_23_21).transform

		var_1_10019.SetParent(var_1_10020, var_12, false)
	end

	for iter_23_5 = 0, var_23_19.x - 1 do
		setText = var_1_10019

		local var_23_25 = var_12

		var_1_10020 = var_12.GetChild(var_23_25, iter_23_5)
		string = var_23_25

		local var_23_26 = var_23_25.char

		string = var_1_10022

		var_1_10019(var_1_10020, var_23_26(var_1_10022.byte("A") + iter_23_5))
	end

	local var_23_27 = var_6:Find("123")
	local var_23_28 = var_15.GetChild(var_23_27, 0)
	local var_23_29 = var_15
	local var_23_30 = var_15.GetComponent

	typeof = var_1_10019
	GridLayoutGroup = var_1_10020

	local var_23_31 = var_23_30(var_23_29, var_1_10019(var_1_10020))

	Vector2 = var_23_29
	var_23_31.cellSize = var_23_29(var_23_0.cellSize.x, var_23_0.cellSize.y)
	Vector2 = var_18
	var_23_31.spacing = var_18(var_23_0.cellSpace.x, var_23_0.cellSpace.y)
	var_23_31.padding.top = var_23_0.cellSpace.y

	for iter_23_6 = var_15.childCount - 1, var_23_19.y, -1 do
		Destroy = var_1_10022

		var_1_10022(var_15:GetChild(iter_23_6))
	end

	for iter_23_7 = var_15.childCount, var_23_19.y - 1 do
		Instantiate = var_1_10022
		var_1_10023 = var_1_10022(var_23_28).transform

		var_1_10022.SetParent(var_1_10023, var_15, false)
	end

	for iter_23_8 = 0, var_23_19.y - 1 do
		setText = var_1_10022

		var_1_10022(var_15:GetChild(iter_23_8), 1 + iter_23_8)
	end

	local var_23_32 = var_6:Find("linev")
	local var_23_33 = var_18.GetChild(var_23_32, 0)
	local var_23_34 = var_18
	local var_23_35 = var_18.GetComponent

	typeof = var_1_10022
	GridLayoutGroup = var_1_10023

	local var_23_36 = var_23_35(var_23_34, var_1_10022(var_1_10023))

	Vector2 = var_23_34
	ChapterConst = var_22
	var_23_36.cellSize = var_23_34(var_22.LineCross, var_6.sizeDelta.y)
	Vector2 = var_21

	local var_23_37 = var_23_15.x

	ChapterConst = var_23
	var_23_36.spacing = var_21(var_23_37 - var_23.LineCross, 0)

	local var_23_38 = var_23_36.padding

	math = var_22
	var_23_38.left = var_22.floor(var_23_36.spacing.x)

	local var_23_39 = var_18.childCount - 1

	math = var_22

	for iter_23_9 = var_23_39, var_22.max(var_23_19.x - 1, 0), -1 do
		if 0 < iter_23_9 then
			Destroy = var_1_10025
			var_1_10027 = var_18

			var_1_10025(var_18.GetChild(var_1_10027, iter_23_9))
		end
	end

	for iter_23_10 = var_18.childCount, var_23_19.x - 2 do
		Instantiate = var_1_10025
		var_1_10026 = var_1_10025(var_23_33).transform

		var_1_10025.SetParent(var_1_10026, var_18, false)
	end

	local var_23_40 = var_6:Find("lineh")
	local var_23_41 = var_21.GetChild(var_23_40, 0)
	local var_23_42 = var_21
	local var_23_43 = var_21.GetComponent

	typeof = var_1_10025
	GridLayoutGroup = var_1_10026

	local var_23_44 = var_23_43(var_23_42, var_1_10025(var_1_10026))

	Vector2 = var_23_42

	local var_23_45 = var_6.sizeDelta.x

	ChapterConst = var_1_10026
	var_23_44.cellSize = var_23_42(var_23_45, var_1_10026.LineCross)
	Vector2 = var_24

	local var_23_46 = 0
	local var_23_47 = var_23_15.y

	ChapterConst = var_1_10027
	var_23_44.spacing = var_24(var_23_46, var_23_47 - var_1_10027.LineCross)

	local var_23_48 = var_23_44.padding

	math = var_23_46
	var_23_48.top = var_23_46.floor(var_23_44.spacing.y)

	local var_23_49 = var_21.childCount - 1

	math = var_25

	for iter_23_11 = var_23_49, var_25.max(var_23_19.y - 1, 0), -1 do
		if 0 < iter_23_11 then
			Destroy = var_1_10028

			var_1_10028(var_21:GetChild(iter_23_11))
		end
	end

	for iter_23_12 = var_21.childCount, var_23_19.y - 2 do
		Instantiate = var_1_10028

		local var_23_50 = var_1_10028(var_23_41).transform

		var_1_10028.SetParent(var_23_50, var_21, false)
	end

	GetOrAddComponent = var_24

	local var_23_51 = var_24(var_6:Find("mask"), "RawImage")
	local var_23_52 = var_6:Find("seaBase/sea")

	if var_23_0.seaBase and var_23_0.seaBase ~= "" then
		setActive = var_26

		var_26(var_23_52, true)

		GetImageSpriteFromAtlasAsync = var_26

		var_26("chapter/pic/" .. var_23_0.seaBase, var_23_0.seaBase, var_23_52)

		var_23_51.enabled = true
		UnityEngine = var_26
		var_23_51.uvRect = var_26.Rect.New(0, 0, 1, -1)
	else
		setActive = var_26

		var_26(var_23_52, false)

		var_23_51.enabled = false
	end

	return
end

function var_0_1.updatePoisonArea(arg_26_0)
	local var_26_0 = arg_26_0._tf
	local var_26_1 = var_1.Find(var_26_0, "plane/display/mask")

	GetOrAddComponent = var_26_0

	if not var_26_0(var_26_1, "RawImage").enabled then
		return
	end

	var_2.texture = arg_26_0:getPoisonTex()

	return
end

function var_0_1.getPoisonTex(arg_27_0)
	local var_27_0 = arg_27_0.contextData.chapterVO
	local var_27_1 = arg_27_0._tf
	local var_27_2 = var_2.Find(var_27_1, "plane/display").sizeDelta.x / var_2.sizeDelta.y
	local var_27_3 = 256

	math = var_1_10005

	local var_27_4 = var_1_10005.floor(var_27_3 / var_27_2)
	local var_27_5

	if arg_27_0.preChapterId ~= var_27_0.id then
		UnityEngine = var_7
		arg_27_0.maskTexture = var_7.Texture2D.New(var_27_3, var_27_4)
		arg_27_0.preChapterId = var_27_0.id
	else
		var_27_5 = arg_27_0.maskTexture
	end

	local var_27_6 = {}
	local var_27_7 = var_27_0:getPoisonArea(var_27_3 / var_2.sizeDelta.x)

	if arg_27_0.poisonRectDir == nil then
		var_27_6 = var_27_7
	else
		pairs = var_9

		for iter_27_0, iter_27_1 in var_9(var_27_7) do
			if arg_27_0.poisonRectDir[iter_27_0] == nil then
				var_27_6[iter_27_0] = iter_27_1
			end
		end
	end

	local function var_27_8(arg_28_0)
		for iter_28_0 = arg_28_0.x, arg_28_0.w + arg_28_0.x do
			for iter_28_1 = arg_28_0.y, arg_28_0.h + arg_28_0.y do
				local var_28_0 = var_27_5
				local var_28_1 = var_9.SetPixel
				local var_28_2 = iter_28_0
				local var_28_3 = iter_28_1

				Color = var_2_10013

				var_28_1(var_28_0, var_28_2, var_28_3, var_2_10013.New(1, 1, 1, 0))
			end
		end

		return
	end

	pairs = var_10

	for iter_27_2, iter_27_3 in var_10(var_27_6) do
		var_27_8(iter_27_3)
	end

	var_27_5:Apply()

	arg_27_0.poisonRectDir = var_27_7

	return var_27_5
end

function var_0_1.showFleetPoisonDamage(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.contextData.chapterVO.fleets[arg_29_1].id

	if arg_29_0.cellFleets[var_29_0] then
		var_5:showPoisonDamage(arg_29_2)
	end

	return
end

function var_0_1.clearPlane(arg_30_0)
	arg_30_0:killQuadTws()
	arg_30_0:killPresentTws()
	arg_30_0:ClearEdges()
	arg_30_0:hideQuadMark()

	removeAllChildren = var_1

	var_1(arg_30_0.cellRoot)

	removeAllChildren = var_1

	var_1(arg_30_0.quadRoot)

	removeAllChildren = var_1

	var_1(arg_30_0.bottomMarkRoot)

	removeAllChildren = var_1

	var_1(arg_30_0.topMarkRoot)

	removeAllChildren = var_1

	var_1(arg_30_0.restrictMap)

	arg_30_0.cellRoot = nil
	arg_30_0.quadRoot = nil
	arg_30_0.bottomMarkRoot = nil
	arg_30_0.topMarkRoot = nil
	arg_30_0.restrictMap = nil

	local var_30_0 = arg_30_0._tf
	local var_30_1 = var_1.Find

	ChapterConst = var_1_10003

	local var_30_2 = var_30_1(var_30_0, var_1_10003.PlaneName)
	local var_30_3 = var_1.Find(var_30_2, "display/seaBase/sea")

	clearImageSprite = var_30_2

	var_30_2(var_30_3)

	pg = var_30_2

	local var_30_4 = var_30_2.PoolMgr.GetInstance()

	var_3.ReturnPrefab(var_30_4, "chapter/plane", "", var_1.gameObject)

	return
end

function var_0_1.initFleets(arg_31_0, arg_31_1)
	if arg_31_0.cellFleets then
		existCall = var_2

		var_2(arg_31_1)

		return
	end

	local var_31_0 = arg_31_0.contextData.chapterVO

	arg_31_0.cellFleets = {}
	table = var_3

	var_3.ParallelIpairsAsync(var_31_0.fleets, function(arg_32_0, arg_32_1, arg_32_2)
		local var_32_0 = arg_32_1
		local var_32_1 = arg_32_1.getFleetType(var_32_0)

		FleetType = var_32_0

		if var_32_1 == var_32_0.Support then
			return arg_32_2()
		end

		local var_32_2 = arg_31_0

		var_3.InitFleetCell(var_32_2, arg_32_1.id, arg_32_2)

		return
	end, arg_31_1)

	return
end

function var_0_1.InitFleetCell(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.contextData.chapterVO
	local var_33_1 = var_3.getFleetById(var_33_0, arg_33_1)

	if not var_4.isValid(var_33_1) then
		existCall = var_5

		var_5(arg_33_2)

		return
	end

	local var_33_2
	local var_33_3 = arg_33_0
	local var_33_4 = arg_33_0.getFleetPool
	local var_33_5 = var_4
	local var_33_6 = var_33_4(var_33_3, var_4.getFleetType(var_33_5))
	local var_33_7 = var_6.Dequeue(var_33_6).transform

	Vector3 = var_33_5
	var_33_7.localEulerAngles = var_33_5(-var_3.theme.angle, 0, 0)
	setParent = var_33_7

	var_33_7(var_7, arg_33_0.cellRoot, false)

	setActive = var_33_7

	var_33_7(var_7, true)

	local var_33_8 = var_4:getFleetType()
	local var_33_9

	FleetType = var_10

	if var_33_8 == var_10.Transport then
		TransportCellView = var_33_9
	else
		FleetType = var_10

		if var_33_8 == var_10.Submarine then
			SubCellView = var_33_9
		else
			FleetCellView = var_33_9
		end
	end

	local var_33_10 = var_33_9.New(var_7)

	var_33_10.fleetType = var_33_8
	FleetType = var_10

	if var_33_8 ~= var_10.Normal then
		FleetType = var_10

		if var_33_8 == var_10.Submarine then
			local var_33_11 = var_33_10
			local var_33_12 = var_33_10.SetAction

			ChapterConst = var_12

			var_33_12(var_33_11, var_12.ShipIdleAction)
		end

		local var_33_13 = var_33_10.tf
		local var_33_14 = var_3.theme

		var_33_13.localPosition = var_11.GetLinePosition(var_33_14, var_4.line.row, var_4.line.column)
		arg_33_0.cellFleets[arg_33_1] = var_33_10

		arg_33_0:RefreshFleetCell(arg_33_1, arg_33_2)

		return
	end
end

function var_0_1.RefreshFleetCells(arg_34_0, arg_34_1)
	if not arg_34_0.cellFleets then
		arg_34_0:initFleets(arg_34_1)

		return
	end

	local var_34_0 = arg_34_0.contextData.chapterVO
	local var_34_1 = {}

	pairs = var_1_10004

	for iter_34_0, iter_34_1 in var_1_10004(arg_34_0.cellFleets) do
		if not var_34_0:getFleetById(iter_34_0) then
			table = var_9

			var_9.insert(var_34_1, iter_34_0)
		end
	end

	pairs = var_4

	for iter_34_2, iter_34_3 in var_4(var_34_1) do
		arg_34_0:ClearFleetCell(iter_34_3)
	end

	table = var_4

	var_4.ParallelIpairsAsync(var_34_0.fleets, function(arg_35_0, arg_35_1, arg_35_2)
		local var_35_0 = arg_35_1
		local var_35_1 = arg_35_1.getFleetType(var_35_0)

		FleetType = var_35_0

		if var_35_1 == var_35_0.Support then
			return arg_35_2()
		end

		if not arg_34_0.cellFleets[arg_35_1.id] then
			local var_35_2 = arg_34_0

			var_3.InitFleetCell(var_35_2, arg_35_1.id, arg_35_2)
		else
			local var_35_3 = arg_34_0

			var_3.RefreshFleetCell(var_35_3, arg_35_1.id, arg_35_2)
		end

		return
	end, arg_34_1)

	return
end

function var_0_1.RefreshFleetCell(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0.contextData.chapterVO
	local var_36_1 = var_3.getFleetById(var_36_0, arg_36_1)
	local var_36_2 = arg_36_0.cellFleets[arg_36_1]
	local var_36_3
	local var_36_4

	if var_36_1:isValid() then
		local var_36_5 = var_36_1
		local var_36_6 = var_36_1.getFleetType(var_36_5)

		FleetType = var_36_5

		if var_36_6 == var_36_5.Transport then
			var_36_3 = var_36_1:getPrefab()
		elseif var_3:getMapShip(var_36_1) then
			var_36_3 = var_8:getPrefab()
			var_36_4 = var_8:getAttachmentPrefab()
		end
	end

	if not var_36_3 then
		arg_36_0:ClearFleetCell(arg_36_1)

		existCall = var_8

		var_8(arg_36_2)

		return
	end

	var_36_2.go.name = "cell_fleet_" .. var_36_3

	local var_36_7 = var_36_2

	var_36_2.SetLine(var_36_7, var_36_1.line)

	local var_36_8 = var_36_2.fleetType

	FleetType = var_36_7

	if var_36_8 == var_36_7.Transport then
		var_36_2:LoadIcon(var_36_3, function()
			local var_37_0 = var_36_2

			var_0.GetRotatePivot(var_37_0).transform.localRotation = var_36_1.rotation

			local var_37_1 = arg_36_0

			var_0.updateFleet(var_37_1, arg_36_1, arg_36_2)

			return
		end)
	else
		var_36_2:LoadSpine(var_36_3, nil, var_36_4, function()
			local var_38_0 = var_36_2

			var_0.GetRotatePivot(var_38_0).transform.localRotation = var_36_1.rotation

			local var_38_1 = arg_36_0

			var_0.updateFleet(var_38_1, arg_36_1, arg_36_2)

			return
		end)
	end

	return
end

function var_0_1.clearFleets(arg_39_0)
	if arg_39_0.cellFleets then
		pairs = var_1

		for iter_39_0, iter_39_1 in var_1(arg_39_0.cellFleets) do
			arg_39_0:ClearFleetCell(iter_39_0)
		end

		arg_39_0.cellFleets = nil
	end

	return
end

function var_0_1.ClearFleetCell(arg_40_0, arg_40_1)
	if not arg_40_0.cellFleets[arg_40_1] then
		return
	end

	var_2:Clear()

	LeanTween = var_3

	var_3.cancel(var_2.go)

	setActive = var_3

	var_3(var_2.go, false)

	setParent = var_3

	var_3(var_2.go, arg_40_0.poolParent, false)

	local var_40_0 = arg_40_0:getFleetPool(var_2.fleetType)

	var_3.Enqueue(var_40_0, var_2.go, false)

	if arg_40_0.opBtns[arg_40_1] then
		Destroy = var_4

		var_4(arg_40_0.opBtns[arg_40_1].gameObject)

		arg_40_0.opBtns[arg_40_1] = nil
	end

	arg_40_0.cellFleets[arg_40_1] = nil

	return
end

function var_0_1.UpdateFleets(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.contextData.chapterVO

	table = var_1_10003

	var_1_10003.ParallelIpairsAsync(var_41_0.fleets, function(arg_42_0, arg_42_1, arg_42_2)
		local var_42_0 = arg_42_1
		local var_42_1 = arg_42_1.getFleetType(var_42_0)

		FleetType = var_42_0

		if var_42_1 == var_42_0.Support then
			return arg_42_2()
		end

		local var_42_2 = arg_41_0

		var_3.updateFleet(var_42_2, arg_42_1.id, arg_42_2)

		return
	end, arg_41_1)

	return
end

function var_0_1.updateFleet(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.contextData.chapterVO
	local var_43_1 = arg_43_0.cellFleets[arg_43_1]
	local var_43_2 = var_43_0
	local var_43_3 = var_43_0.getFleetById(var_43_2, arg_43_1)

	if var_43_1 then
		var_43_2 = var_43_3.line

		local var_43_4 = var_43_3
		local var_43_5 = var_43_3.isValid(var_43_4)

		setActive = var_43_4

		var_43_4(var_43_1.go, var_43_5)
		var_43_1:RefreshLinePosition(var_43_0, var_43_2)

		local var_43_6 = var_43_3
		local var_43_7 = var_43_3.getFleetType(var_43_6)

		FleetType = var_43_6

		local var_43_9, var_43_11

		if var_43_7 == var_43_6.Normal then
			local var_43_8 = var_43_0

			var_43_9 = var_43_0.GetEnemy(var_43_8, var_43_2.row, var_43_2.column)
			tobool = var_43_8

			local var_43_10 = var_43_8(var_43_9)

			if not var_43_9 or not var_43_9.attachment then
				var_43_11 = nil
			end

			local var_43_12 = var_43_0
			local var_43_13 = var_43_0.existFleet

			FleetType = var_1_10014

			local var_43_14 = var_43_13(var_43_12, var_1_10014.Transport, var_43_2.row, var_43_2.column)

			var_43_1:SetSpineVisible(not var_43_10 and not var_43_14)

			table = var_13

			local var_43_15 = var_13.indexof(var_43_0.fleets, var_43_3) == var_43_0.findex

			setActive = var_14

			var_14(var_43_1.tfArrow, var_43_15)

			setActive = var_14

			var_14(var_43_1.tfOp, false)

			local var_43_16

			if not arg_43_0.opBtns[arg_43_1] then
				tf = var_15
				Instantiate = var_1_10016
				var_43_16 = var_15(var_1_10016(var_43_1.tfOp))
				var_43_16.name = "op" .. arg_43_1
				var_1_10016 = var_43_16

				var_43_16.SetParent(var_1_10016, arg_43_0._tf, false)

				Vector3 = var_15
				var_43_16.localEulerAngles = var_15(-var_43_0.theme.angle, 0, 0)
				GetOrAddComponent = var_15
				var_1_10016 = var_43_16
				typeof = var_1_10017
				Canvas = var_18

				local var_43_17 = var_15(var_1_10016, var_1_10017(var_18))

				GetOrAddComponent = var_1_10016
				go = var_1_10017
				var_1_10017 = var_1_10017(var_43_16)
				typeof = var_18
				GraphicRaycaster = var_1_10019

				var_1_10016(var_1_10017, var_18(var_1_10019))

				var_43_17.overrideSorting = true
				ChapterConst = var_1_10016
				var_43_17.sortingOrder = var_1_10016.PriorityMax
				var_1_10016 = arg_43_0.opBtns
				var_1_10016[arg_43_1] = var_43_16
				var_1_10017 = arg_43_0

				arg_43_0.UpdateOpBtns(var_1_10017)
			end

			var_43_16.position = var_43_1.tfOp.position

			local var_43_18

			if var_43_9 then
				::label_43_0::

				ChapterConst = var_43_18
				var_43_18 = var_43_18.IsBossCell(var_43_9)
			end

			var_1_10016 = false

			if var_43_10 then
				ChapterConst = var_1_10017

				if var_43_11 == var_1_10017.AttachChampion then
					local var_43_19 = var_43_0:getChampion(var_43_2.row, var_43_2.column)
					local var_43_20 = var_1_10017.GetLastID(var_43_19)

					pg = var_43_19

					if var_43_19.expedition_data_template[var_43_20] then
						local var_43_21 = var_19.ai

						ChapterConst = var_1_10021
						var_1_10016 = var_43_21 == var_1_10021.ExpeditionAILair
					end
				end
			end

			var_43_18 = var_43_18 or var_1_10016
			_ = var_1_10017

			local var_43_22 = var_1_10017.any(var_43_0.fleets, function(arg_44_0)
				local var_44_2

				if arg_44_0.id ~= var_43_3.id then
					local var_44_0 = arg_44_0
					local var_44_1 = arg_44_0.getFleetType(var_44_0)

					FleetType = var_44_0

					if var_44_1 == var_44_0.Normal then
						var_44_2 = arg_44_0:isValid()

						goto label_44_0
					end
				end

				var_44_2 = false

				if false then
					var_44_2 = true
				end

				::label_44_0::

				return var_44_2
			end)
			local var_43_23 = var_43_15 and var_43_5 and var_43_10
			local var_43_24 = var_43_16
			local var_43_25 = var_43_16.Find(var_43_24, "retreat")

			setActive = var_43_24

			var_43_24(var_43_25:Find("retreat"), var_43_23 and not var_43_18 and var_43_22)

			setActive = var_43_24

			var_43_24(var_43_25:Find("escape"), var_43_23 and var_43_18)

			setActive = var_43_24

			local var_43_26 = var_43_25
			local var_43_27

			if not var_43_25:Find("retreat").gameObject.activeSelf then
				var_43_27 = var_43_25:Find("escape").gameObject.activeSelf
			end

			var_43_24(var_43_26, var_43_27)

			if var_43_25.gameObject.activeSelf then
				onButton = var_20

				local var_43_28 = arg_43_0
				local var_43_29 = var_43_25

				local function var_43_30()
					local var_45_0 = arg_43_0.parent

					if var_0.isfrozen(var_45_0) then
						return
					end

					if var_43_18 then
						(function()
							local var_46_0 = {
								{
									1,
									0
								},
								{
									-1,
									0
								},
								{
									0,
									1
								},
								{
									0,
									-1
								}
							}

							ipairs = var_1

							for iter_46_0, iter_46_1 in var_1(var_46_0) do
								local var_46_1 = var_43_0
								local var_46_2 = var_6.considerAsStayPoint

								ChapterConst = var_3_10008

								if var_46_2(var_46_1, var_3_10008.SubjectPlayer, var_43_2.row + iter_46_1[1], var_43_2.column + iter_46_1[2]) then
									local var_46_3 = var_43_0
									local var_46_4 = var_6.existEnemy

									ChapterConst = var_3_10008

									if not var_46_4(var_46_3, var_3_10008.SubjectPlayer, var_43_2.row + iter_46_1[1], var_43_2.column + iter_46_1[2]) then
										local var_46_5 = arg_43_0
										local var_46_6 = var_6.emit

										LevelMediator2 = var_3_10008
										var_3_10008 = var_3_10008.ON_OP

										local var_46_7 = {}

										ChapterConst = var_10
										var_46_7.type = var_10.OpMove
										var_46_7.id = var_43_3.id
										var_46_7.arg1 = var_43_2.row + iter_46_1[1]
										var_46_7.arg2 = var_43_2.column + iter_46_1[2]
										var_46_7.ordLine = var_43_3.line

										var_46_6(var_46_5, var_3_10008, var_46_7)

										return false
									end
								end
							end

							pg = var_1

							local var_46_8 = var_1.TipsMgr.GetInstance()
							local var_46_9 = var_1.ShowTips

							i18n = var_3

							var_46_9(var_46_8, var_3("no_way_to_escape"))

							return true
						end)()
					else
						pg = var_0

						local var_45_1 = var_0.MsgboxMgr.GetInstance()
						local var_45_2 = var_0.ShowMsgBox
						local var_45_3 = {}

						i18n = var_2_10003
						var_45_3.content = var_2_10003("levelScene_who_to_retreat", var_43_3.name)

						function var_45_3.onYes()
							local var_47_0 = arg_43_0
							local var_47_1 = var_0.emit

							LevelMediator2 = var_3_10002

							local var_47_2 = var_3_10002.ON_OP
							local var_47_3 = {}

							ChapterConst = var_3_10004
							var_47_3.type = var_3_10004.OpRetreat
							var_47_3.id = var_43_3.id

							var_47_1(var_47_0, var_47_2, var_47_3)

							return
						end

						var_45_2(var_45_1, var_45_3)
					end

					return
				end

				SFX_UI_WEIGHANCHOR_WITHDRAW = var_24

				var_20(var_43_28, var_43_29, var_43_30, var_24)
			end

			local var_43_31 = var_43_16
			local var_43_32 = var_43_16.Find(var_43_31, "exchange")

			setActive = var_43_31

			var_43_31(var_43_32, false)

			setActive = var_43_31

			var_43_31(var_43_1.tfAmmo, not var_43_14)

			local var_43_33, var_43_34 = var_43_0:getFleetAmmo(var_43_3)
			local var_43_35 = var_43_34 .. "/" .. var_43_33

			if var_43_34 == 0 then
				setColorStr = var_24

				local var_43_36 = var_43_35

				COLOR_RED = var_1_10026
				var_43_35 = var_24(var_43_36, var_1_10026)
			end

			setText = var_24

			var_24(var_43_1.tfAmmoText, var_43_35)

			local var_43_37

			if var_43_10 or var_43_14 then
				var_43_37 = var_43_0

				local var_43_38 = var_43_0.getChampion(var_43_37, var_43_2.row, var_43_2.column)
				local var_43_39

				if var_43_10 then
					ChapterConst = var_43_37

					if var_43_11 == var_43_37.AttachChampion then
						var_43_39 = var_43_38
						var_43_37 = var_43_38.getPoolType(var_43_39)
						ChapterConst = var_43_39

						if var_43_37 == var_43_39.TemplateChampion then
							var_43_37 = var_43_1.tfArrow
							Vector2 = var_43_39
							var_43_37.anchoredPosition = var_43_39(0, 180)
							var_43_37 = var_43_1.tfAmmo
							Vector2 = var_43_39
							var_43_37.anchoredPosition = var_43_39(60, 100)

							goto label_43_1
						end
					end
				end

				var_43_37 = var_43_1.tfArrow
				Vector2 = var_43_39
				var_43_37.anchoredPosition = var_43_39(0, 100)
				var_43_37 = var_43_1.tfAmmo
				Vector2 = var_26
				var_43_37.anchoredPosition = var_26(22, 56)

				::label_43_1::

				local var_43_40 = var_43_1.tfAmmo

				var_43_37.SetAsLastSibling(var_43_40)
			else
				local var_43_41 = var_43_1.tfArrow

				Vector2 = var_43_37
				var_43_41.anchoredPosition = var_43_37(0, 175)

				local var_43_42 = var_43_1.tfAmmo

				Vector2 = var_25
				var_43_42.anchoredPosition = var_25(-60, 85)
			end

			if var_43_1:GetSpineRole() and var_43_15 and arg_43_0.lastSelectedId ~= var_43_3.id then
				if not var_43_10 and not var_43_14 and arg_43_0.lastSelectedId ~= -1 then
					var_43_1:TweenShining()
				end

				arg_43_0.lastSelectedId = var_43_3.id
			end

			local var_43_43 = var_43_0:existBarrier(var_43_2.row, var_43_2.column)

			var_43_1:SetActiveNoPassIcon(var_43_43)

			table = var_26

			local var_43_44 = var_26.contains
			local var_43_45 = var_43_3
			local var_43_46 = var_43_3.GetStatusStrategy(var_43_45)

			ChapterConst = var_43_45

			local var_43_47 = var_43_44(var_43_46, var_43_45.StrategyIntelligenceRecorded)

			var_43_1:UpdateIconRecordedFlag(var_43_47)
		else
			FleetType = var_43_9

			local var_43_49

			if var_43_7 == var_43_9.Submarine then
				local var_43_48 = var_43_0

				var_43_49 = var_43_0.existEnemy
				ChapterConst = var_43_11

				if not var_43_49(var_43_48, var_43_11.SubjectPlayer, var_43_2.row, var_43_2.column) then
					var_43_49 = var_43_0:existAlly(var_43_3)
				end

				local var_43_50 = var_43_0.subAutoAttack == 1

				var_43_1:SetActiveModel(not var_43_49 and var_43_50)

				setActive = var_11

				var_11(var_43_1.tfAmmo, not var_43_49)

				local var_43_51, var_43_52 = var_43_0:getFleetAmmo(var_43_3)
				local var_43_53 = var_43_52 .. "/" .. var_43_51

				if var_43_52 == 0 then
					setColorStr = var_14

					local var_43_54 = var_43_53

					COLOR_RED = var_1_10016
					var_43_53 = var_14(var_43_54, var_1_10016)
				end

				setText = var_14

				var_14(var_43_1.tfAmmoText, var_43_53)
			else
				FleetType = var_43_49

				if var_43_7 == var_43_49.Transport then
					setText = var_9

					var_9(var_43_1.tfHpText, var_43_3:getRestHp() .. "/" .. var_43_3:getTotalHp())

					local var_43_55 = var_43_0
					local var_43_56 = var_43_0.existEnemy

					ChapterConst = var_11

					local var_43_57 = var_43_56(var_43_55, var_11.SubjectPlayer, var_43_2.row, var_43_2.column)

					GetImageSpriteFromAtlasAsync = var_43_55

					var_43_55("enemies/" .. var_43_3:getPrefab(), "", var_43_1.tfIcon, true)

					setActive = var_43_55

					var_43_55(var_43_1.tfFighting, var_43_57)
				end
			end
		end
	end

	existCall = var_43_2

	var_43_2(arg_43_2)

	return
end

function var_0_1.UpdateOpBtns(arg_48_0)
	table = var_1_10001

	var_1_10001.Foreach(arg_48_0.opBtns, function(arg_49_0, arg_49_1)
		setActive = var_2_10002

		local var_49_0 = arg_49_1
		local var_49_1 = arg_48_0.quadState

		ChapterConst = var_2_10005

		var_2_10002(var_49_0, var_49_1 == var_2_10005.QuadStateNormal)

		return
	end)

	return
end

function var_0_1.GetCellFleet(arg_50_0, arg_50_1)
	return arg_50_0.cellFleets[arg_50_1]
end

function var_0_1.initTargetArrow(arg_51_0)
	local var_51_0 = arg_51_0.contextData.chapterVO

	cloneTplTo = var_1_10002
	arg_51_0.arrowTarget = var_1_10002(arg_51_0.arrowTpl, arg_51_0._tf)

	local var_51_1 = arg_51_0.arrowTarget

	pg = var_3

	local var_51_2 = var_3.ViewUtils.SetLayer

	tf = var_4

	local var_51_3 = var_4(var_51_1)

	Layer = var_5

	var_51_2(var_51_3, var_5.UI)

	GetOrAddComponent = var_51_2

	local var_51_4 = var_51_1

	typeof = var_5
	Canvas = var_1_10006
	var_51_2(var_51_4, var_5(var_1_10006)).overrideSorting = true

	local var_51_5 = arg_51_0.arrowTarget

	Vector3 = var_5
	var_51_5.localEulerAngles = var_5(-var_51_0.theme.angle, 0, 0)
	setActive = var_51_5

	var_51_5(arg_51_0.arrowTarget, false)

	return
end

function var_0_1.updateTargetArrow(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0.contextData.chapterVO

	ChapterCell = var_1_10003

	local var_52_1 = var_1_10003.Line2Name(arg_52_1.row, arg_52_1.column)
	local var_52_2 = arg_52_0.cellRoot
	local var_52_3 = var_4.Find(var_52_2, var_52_1)
	local var_52_4 = arg_52_0.arrowTarget

	var_5.SetParent(var_52_4, var_52_3)

	local var_52_5, var_52_6 = (function()
		local var_53_0 = var_52_0
		local var_53_1 = var_0.existEnemy

		ChapterConst = var_2_10002

		local var_53_2, var_53_3 = var_53_1(var_53_0, var_2_10002.SubjectPlayer, arg_52_1.row, arg_52_1.column)

		if not var_53_2 then
			return false
		end

		ChapterConst = var_2

		if var_53_3 == var_2.AttachChampion then
			local var_53_4 = var_52_0

			if not var_2.getChampion(var_53_4, arg_52_1.row, arg_52_1.column) then
				return false
			end

			do return var_2:getPoolType() == "common", var_2:getScale() / 100 end

			goto label_53_0
		end

		ChapterConst = var_2

		if var_2.IsEnemyAttach(var_53_3) then
			local var_53_5 = var_52_0

			if var_2.getChapterCell(var_53_5, arg_52_1.row, arg_52_1.column) then
				var_53_5 = var_2.flag
				ChapterConst = var_4

				if var_53_5 ~= var_4.CellFlagActive then
					return false
				end

				pg = var_53_5

				do return var_53_5.expedition_data_template[var_2.attachmentId].icon_type == 2, var_3.scale / 100 end

				::label_53_0::

				return
			end
		end
	end)()

	if var_52_5 then
		local var_52_7 = arg_52_0.arrowTarget

		Vector3 = var_1_10009
		var_52_7.localPosition = var_1_10009(0, 20 + 80 * var_52_6, -80 * var_52_6)
	else
		local var_52_8 = arg_52_0.arrowTarget

		Vector3 = var_1_10009
		var_52_8.localPosition = var_1_10009(0, 20, 0)
	end

	local var_52_9 = arg_52_0.arrowTarget
	local var_52_10 = var_8.GetComponent

	typeof = var_1_10010
	Canvas = var_1_10011

	if var_52_10(var_52_9, var_1_10010(var_1_10011)) then
		local var_52_11 = arg_52_1.row

		ChapterConst = var_10

		local var_52_12 = var_52_11 * var_10.PriorityPerRow

		ChapterConst = var_10
		var_8.sortingOrder = var_52_12 + var_10.CellPriorityTopMark
	end

	return
end

function var_0_1.clearTargetArrow(arg_54_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_54_0.arrowTarget) then
		Destroy = var_1

		var_1(arg_54_0.arrowTarget)

		arg_54_0.arrowTarget = nil
	end

	return
end

function var_0_1.InitDestinationMark(arg_55_0)
	cloneTplTo = var_1_10001

	local var_55_0 = var_1_10001(arg_55_0.destinationMarkTpl, arg_55_0._tf)

	pg = var_2

	local var_55_1 = var_2.ViewUtils.SetLayer

	tf = var_3

	local var_55_2 = var_3(var_55_0)

	Layer = var_4

	var_55_1(var_55_2, var_4.UI)

	GetOrAddComponent = var_55_1

	local var_55_3 = var_55_0

	typeof = var_4
	Canvas = var_1_10005
	var_55_1(var_55_3, var_4(var_1_10005)).overrideSorting = true
	setActive = var_3

	var_3(var_55_0, false)

	local var_55_4 = arg_55_0.contextData.chapterVO

	tf = var_4

	local var_55_5 = var_4(var_55_0)

	Vector3 = var_5
	var_55_5.localEulerAngles = var_5(-var_55_4.theme.angle, 0, 0)
	tf = var_55_5
	arg_55_0.destinationMark = var_55_5(var_55_0)

	return
end

function var_0_1.UpdateDestinationMark(arg_56_0, arg_56_1)
	if not arg_56_1 then
		var_1_10003 = arg_56_0.destinationMark

		var_1_10002.SetParent(var_1_10003, arg_56_0._tf)

		setActive = var_1_10002
		go = var_1_10003

		var_1_10002(var_1_10003(arg_56_0.destinationMark), false)

		return
	end

	setActive = var_1_10002
	go = var_1_10003

	var_1_10002(var_1_10003(arg_56_0.destinationMark), true)

	ChapterCell = var_1_10002

	local var_56_0 = var_1_10002.Line2Name(arg_56_1.row, arg_56_1.column)
	local var_56_1 = arg_56_0.cellRoot
	local var_56_2 = var_3.Find(var_56_1, var_56_0)
	local var_56_3 = arg_56_0.destinationMark

	var_4.SetParent(var_56_3, var_56_2)

	local var_56_4 = arg_56_0.destinationMark

	Vector3 = var_56_3
	var_56_4.localPosition = var_56_3(0, 40, -40)

	local var_56_5 = arg_56_0.destinationMark
	local var_56_6 = var_4.GetComponent

	typeof = var_6
	Canvas = var_7

	if var_56_6(var_56_5, var_6(var_7)) then
		local var_56_7 = arg_56_1.row

		ChapterConst = var_6

		local var_56_8 = var_56_7 * var_6.PriorityPerRow

		ChapterConst = var_6
		var_4.sortingOrder = var_56_8 + var_6.CellPriorityTopMark
	end

	return
end

function var_0_1.ClearDestinationMark(arg_57_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_57_0.destinationMark) then
		Destroy = var_1

		var_1(arg_57_0.destinationMark)

		arg_57_0.destinationMark = nil
	end

	return
end

function var_0_1.initChampions(arg_58_0, arg_58_1)
	if arg_58_0.cellChampions then
		existCall = var_2

		var_2(arg_58_1)

		return
	end

	arg_58_0.cellChampions = {}

	local var_58_0 = arg_58_0.contextData.chapterVO

	table = var_1_10003

	var_1_10003.ParallelIpairsAsync(var_58_0.champions, function(arg_59_0, arg_59_1, arg_59_2)
		arg_58_0.cellChampions[arg_59_0] = false

		local var_59_0 = arg_59_1.flag

		ChapterConst = var_4

		if var_59_0 ~= var_4.CellFlagDisabled then
			local var_59_1 = arg_58_0

			var_3.InitChampion(var_59_1, arg_59_0, arg_59_2)
		else
			arg_59_2()
		end

		return
	end, arg_58_1)

	return
end

function var_0_1.InitChampion(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_0.contextData.chapterVO.champions[arg_60_1]
	local var_60_1 = var_4.getPoolType(var_60_0)
	local var_60_2 = arg_60_0:getChampionPool(var_60_1)
	local var_60_3 = var_6.Dequeue(var_60_2)

	var_60_3.name = "cell_champion_" .. var_4:getPrefab()

	local var_60_4 = var_60_3.transform

	Vector3 = var_9
	var_60_4.localEulerAngles = var_9(-var_3.theme.angle, 0, 0)
	setParent = var_60_4

	var_60_4(var_60_3, arg_60_0.cellRoot, false)

	setActive = var_60_4

	var_60_4(var_60_3, true)

	local var_60_5

	ChapterConst = var_9

	if var_60_1 == var_9.TemplateChampion then
		DynamicChampionCellView = var_60_5
	else
		ChapterConst = var_9

		if var_60_1 == var_9.TemplateEnemy then
			DynamicEggCellView = var_60_5
		else
			ChapterConst = var_9

			if var_60_1 == var_9.TemplateOni then
				OniCellView = var_60_5
			end
		end
	end

	local var_60_6 = var_60_5.New(var_60_3)

	arg_60_0.cellChampions[arg_60_1] = var_60_6

	var_60_6:SetLine({
		row = var_4.row,
		column = var_4.column
	})
	var_60_6:SetPoolType(var_60_1)

	local var_60_7, var_60_8

	if var_60_6.GetRotatePivot then
		tf = var_60_8
		var_60_7 = var_60_6
		var_60_8 = var_60_8(var_60_6.GetRotatePivot(var_60_7))
		var_60_8.localRotation = var_4.rotation
	end

	ChapterConst = var_60_8

	local var_60_10

	if var_60_1 == var_60_8.TemplateChampion then
		local var_60_9 = var_60_6

		var_60_10 = var_60_6.SetAction
		ChapterConst = var_60_7

		var_60_10(var_60_9, var_60_7.ShipIdleAction)

		var_60_10 = var_4.flag
		ChapterConst = var_60_9

		if var_60_10 == var_60_9.CellFlagDiving then
			local var_60_11 = var_60_6

			var_60_10 = var_60_6.SetAction
			ChapterConst = var_12

			var_60_10(var_60_11, var_12.ShipSwimAction)
		end

		var_60_6:LoadSpine(var_4:getPrefab(), var_4:getScale(), var_4:getConfig("effect_prefab"), function()
			local var_61_0 = arg_60_0

			var_0.updateChampion(var_61_0, arg_60_1, arg_60_2)

			return
		end)
	else
		ChapterConst = var_60_10

		if var_60_1 == var_60_10.TemplateEnemy then
			var_60_6:LoadIcon(var_4:getPrefab(), var_4:getConfigTable(), function()
				local var_62_0 = arg_60_0

				var_0.updateChampion(var_62_0, arg_60_1, arg_60_2)

				return
			end)
		else
			ChapterConst = var_10

			if var_60_1 == var_10.TemplateOni then
				arg_60_0:updateChampion(arg_60_1, arg_60_2)
			end
		end
	end

	return
end

function var_0_1.updateChampions(arg_63_0, arg_63_1)
	table = var_1_10002

	var_1_10002.ParallelIpairsAsync(arg_63_0.cellChampions, function(arg_64_0, arg_64_1, arg_64_2)
		local var_64_0 = arg_63_0

		var_3.updateChampion(var_64_0, arg_64_0, arg_64_2)

		return
	end, arg_63_1)

	return
end

function var_0_1.updateChampion(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = arg_65_0.contextData.chapterVO
	local var_65_1 = arg_65_0.cellChampions[arg_65_1]
	local var_65_2 = var_65_0.champions[arg_65_1]

	if var_65_1 and var_65_2 then
		var_65_1:UpdateChampionCell(var_65_0, var_65_2, arg_65_2)
	end

	return
end

function var_0_1.updateOni(arg_66_0)
	local var_66_0 = arg_66_0.contextData.chapterVO
	local var_66_1

	ipairs = var_1_10003

	for iter_66_0, iter_66_1 in var_1_10003(var_66_0.champions) do
		local var_66_2 = iter_66_1.attachment

		ChapterConst = var_1_10009

		if var_66_2 == var_1_10009.AttachOni then
			var_66_1 = iter_66_0

			break
		end
	end

	if var_66_1 then
		arg_66_0:updateChampion(var_66_1)
	end

	return
end

function var_0_1.clearChampions(arg_67_0)
	if arg_67_0.cellChampions then
		ipairs = var_1

		for iter_67_0, iter_67_1 in var_1(arg_67_0.cellChampions) do
			if iter_67_1 then
				iter_67_1:Clear()

				LeanTween = var_6

				var_6.cancel(iter_67_1.go)

				setActive = var_6

				var_6(iter_67_1.go, false)

				setParent = var_6

				var_6(iter_67_1.go, arg_67_0.poolParent, false)

				local var_67_0 = arg_67_0:getChampionPool(iter_67_1:GetPoolType())

				var_6.Enqueue(var_67_0, iter_67_1.go, false)
			end
		end

		arg_67_0.cellChampions = nil
	end

	return
end

function var_0_1.initCell(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = arg_68_0.contextData.chapterVO

	if var_3.getChapterCell(var_68_0, arg_68_1, arg_68_2) then
		local var_68_1 = var_3.theme.cellSize

		ChapterCell = var_6

		local var_68_2 = var_6.Line2QuadName(arg_68_1, arg_68_2)
		local var_68_3

		if var_4:IsWalkable() then
			PoolMgr = var_8

			local var_68_4 = var_8.GetInstance()

			var_8.GetPrefab(var_68_4, "chapter/cell_quad", "", false, function(arg_69_0)
				var_68_3 = arg_69_0.transform

				return
			end)

			var_68_3.name = var_68_2

			var_68_3:SetParent(arg_68_0.quadRoot, false)

			var_68_3.sizeDelta = var_68_1

			local var_68_5 = var_3.theme

			var_68_3.anchoredPosition = var_8.GetLinePosition(var_68_5, arg_68_1, arg_68_2)

			var_68_3:SetAsLastSibling()

			onButton = var_8

			local var_68_6 = arg_68_0
			local var_68_7 = var_68_3

			local function var_68_8()
				local var_70_0 = arg_68_0

				if var_0.isfrozen(var_70_0) then
					return
				end

				local var_70_1 = arg_68_0

				var_0.ClickGridCell(var_70_1, var_0)

				return
			end

			SFX_CONFIRM = var_12

			var_8(var_68_6, var_68_7, var_68_8, var_12)
		end

		ChapterCell = var_8

		local var_68_9 = var_8.Line2Name(arg_68_1, arg_68_2)
		local var_68_10

		PoolMgr = var_10

		local var_68_11 = var_10.GetInstance()

		var_10.GetPrefab(var_68_11, "chapter/cell", "", false, function(arg_71_0)
			var_68_10 = arg_71_0.transform

			return
		end)

		var_68_10.name = var_68_9

		var_68_10:SetParent(arg_68_0.cellRoot, false)

		var_68_10.sizeDelta = var_68_1

		local var_68_12 = var_3.theme

		var_68_10.anchoredPosition = var_10.GetLinePosition(var_68_12, arg_68_1, arg_68_2)

		var_68_10:SetAsLastSibling()

		local var_68_13 = var_68_10
		local var_68_14 = var_68_10.Find

		ChapterConst = var_12

		local var_68_15 = var_68_14(var_68_13, var_12.ChildItem)

		Vector3 = var_68_13
		var_68_15.localEulerAngles = var_68_13(-var_3.theme.angle, 0, 0)
		setActive = var_11

		var_11(var_68_15, var_4.item)

		ItemCell = var_11

		local var_68_16 = var_11.New(var_68_15, arg_68_1, arg_68_2)
		local var_68_17 = arg_68_0.itemCells

		ChapterCell = var_13
		var_68_17[var_13.Line2Name(arg_68_1, arg_68_2)] = var_68_16
		var_68_16.loader = arg_68_0.loader

		var_68_16:Init(var_4)

		local var_68_18 = var_68_10
		local var_68_19 = var_68_10.Find

		ChapterConst = var_14

		local var_68_20 = var_68_19(var_68_18, var_14.ChildAttachment)

		Vector3 = var_68_18
		var_68_20.localEulerAngles = var_68_18(-var_3.theme.angle, 0, 0)
	end

	return
end

function var_0_1.clearCell(arg_72_0, arg_72_1, arg_72_2)
	ChapterCell = var_1_10003

	local var_72_0 = var_1_10003.Line2Name(arg_72_1, arg_72_2)

	ChapterCell = var_4

	local var_72_1 = var_4.Line2QuadName(arg_72_1, arg_72_2)
	local var_72_2 = arg_72_0.cellRoot
	local var_72_3 = var_5.Find(var_72_2, var_72_0)
	local var_72_4 = arg_72_0.quadRoot
	local var_72_5 = var_6.Find(var_72_4, var_72_1)

	IsNil = var_72_4

	if not var_72_4(var_72_3) then
		PoolMgr = var_7

		local var_72_6 = var_7.GetInstance()

		var_7.ReturnPrefab(var_72_6, "chapter/cell", "", var_72_3.gameObject)
	end

	IsNil = var_7

	if not var_7(var_72_5) then
		if arg_72_0.quadTws[var_72_1] then
			LeanTween = var_7

			var_7.cancel(arg_72_0.quadTws[var_72_1].uniqueId)

			arg_72_0.quadTws[var_72_1] = nil
		end

		local var_72_7 = var_72_5:Find("grid")
		local var_72_8 = var_7.GetComponent

		typeof = var_9
		Image = var_1_10010

		local var_72_9 = var_72_8(var_72_7, var_9(var_1_10010))

		GetSpriteFromAtlas = var_72_7
		var_72_9.sprite = var_72_7("chapter/pic/cellgrid", "cell_grid")
		var_72_9.material = nil
		PoolMgr = var_8

		local var_72_10 = var_8.GetInstance()

		var_8.ReturnPrefab(var_72_10, "chapter/cell_quad", "", var_72_5.gameObject)
	end

	return
end

function var_0_1.UpdateItemCells(arg_73_0)
	if not arg_73_0.contextData.chapterVO then
		return
	end

	pairs = var_1_10002

	for iter_73_0, iter_73_1 in var_1_10002(arg_73_0.itemCells) do
		local var_73_0 = iter_73_1:GetOriginalInfo() and var_7.item

		ItemCell = var_1_10009

		local var_73_1 = var_1_10009.TransformItemAsset(var_1, var_73_0)

		iter_73_1:UpdateAsset(var_73_1)
	end

	return
end

function var_0_1.updateAttachments(arg_74_0)
	local var_74_0 = 0

	ChapterConst = var_1_10002

	for iter_74_0 = var_74_0, var_1_10002.MaxRow - 1 do
		local var_74_1 = 0

		ChapterConst = var_1_10006

		for iter_74_1 = var_74_1, var_1_10006.MaxColumn - 1 do
			arg_74_0:updateAttachment(iter_74_0, iter_74_1)
		end
	end

	arg_74_0:updateExtraAttachments()
	arg_74_0:updateCoastalGunAttachArea()
	arg_74_0:displayEscapeGrid()

	return
end

function var_0_1.UpdateFloor(arg_75_0)
	local var_75_0 = arg_75_0.contextData.chapterVO.cells
	local var_75_1 = {}

	pairs = var_1_10004

	for iter_75_0, iter_75_1 in var_1_10004(var_75_0) do
		var_1_10010 = iter_75_1
		var_1_10009 = iter_75_1.GetFlagList(var_1_10010)
		pairs = var_1_10010

		for iter_75_2, iter_75_3 in var_1_10010(var_1_10009) do
			if not var_75_1[iter_75_3] then
				var_1_10015 = {}
			end

			var_75_1[iter_75_3] = var_1_10015
			table = var_1_10015

			var_1_10015.insert(var_75_1[iter_75_3], iter_75_1)
		end
	end

	ChapterConst = var_4

	local var_75_6

	if var_75_1[var_4.FlagBanaiAirStrike] then
		next = var_4
		ChapterConst = var_5

		if var_4(var_75_1[var_5.FlagBanaiAirStrike]) then
			local var_75_2 = arg_75_0
			local var_75_3 = arg_75_0.hideQuadMark

			ChapterConst = var_75_6

			var_75_3(var_75_2, var_75_6.MarkBanaiAirStrike)

			local var_75_4 = arg_75_0
			local var_75_5 = arg_75_0.showQuadMark

			ChapterConst = var_75_6
			var_75_6 = var_75_1[var_75_6.FlagBanaiAirStrike]
			ChapterConst = iter_75_0
			iter_75_0 = iter_75_0.MarkBanaiAirStrike
			iter_75_1 = "cell_coastal_gun"
			Vector2 = var_1_10009

			var_75_5(var_75_4, var_75_6, iter_75_0, iter_75_1, var_1_10009(110, 110), nil, true)
		end
	end

	local var_75_7 = arg_75_0

	arg_75_0.updatePoisonArea(var_75_7)

	ChapterConst = var_4

	local var_75_8

	if var_75_1[var_4.FlagLava] then
		next = var_75_8
		ChapterConst = var_75_7

		if var_75_8(var_75_1[var_75_7.FlagLava]) then
			var_75_7 = arg_75_0
			var_75_8 = arg_75_0.hideQuadMark
			ChapterConst = var_75_6

			var_75_8(var_75_7, var_75_6.MarkLava)

			var_75_7 = arg_75_0
			var_75_8 = arg_75_0.showQuadMark
			ChapterConst = var_75_6
			var_75_6 = var_75_1[var_75_6.FlagLava]
			ChapterConst = iter_75_0
			iter_75_0 = iter_75_0.MarkLava
			iter_75_1 = "cell_lava"
			Vector2 = var_1_10009

			var_75_8(var_75_7, var_75_6, iter_75_0, iter_75_1, var_1_10009(110, 110), nil, true)
		end
	end

	ChapterConst = var_75_8

	if var_75_1[var_75_8.FlagNightmare] then
		next = var_4
		ChapterConst = var_75_7

		if var_4(var_75_1[var_75_7.FlagNightmare]) then
			var_75_7 = arg_75_0

			local var_75_9 = arg_75_0.hideQuadMark

			ChapterConst = var_75_6

			var_75_9(var_75_7, var_75_6.MarkNightMare)

			var_75_7 = arg_75_0

			local var_75_10 = arg_75_0.hideQuadMark

			ChapterConst = var_6

			var_75_10(var_75_7, var_6.MarkHideNight)

			var_75_7 = var_1

			local var_75_11 = var_1.getExtraFlags(var_75_7)

			table = var_75_7
			var_75_7 = var_75_7.contains

			local var_75_12 = var_75_11

			ChapterConst = iter_75_0

			local var_75_14

			if var_75_7(var_75_12, iter_75_0.StatusDay) then
				local var_75_13 = arg_75_0

				var_75_7 = arg_75_0.showQuadMark
				ChapterConst = var_75_14
				var_75_14 = var_75_1[var_75_14.FlagNightmare]
				ChapterConst = iter_75_1
				iter_75_1 = iter_75_1.MarkHideNight

				local var_75_15 = "cell_hidden_nightmare"

				Vector2 = var_1_10010

				var_75_7(var_75_13, var_75_14, iter_75_1, var_75_15, var_1_10010(110, 110), nil, true)
			else
				table = var_75_7
				var_75_7 = var_75_7.contains

				local var_75_16 = var_75_11

				ChapterConst = var_75_14

				if var_75_7(var_75_16, var_75_14.StatusNight) then
					local var_75_17 = arg_75_0

					var_75_7 = arg_75_0.showQuadMark
					ChapterConst = var_7

					local var_75_18 = var_75_1[var_7.FlagNightmare]

					ChapterConst = iter_75_1

					local var_75_19 = iter_75_1.MarkNightMare
					local var_75_20 = "cell_nightmare"

					Vector2 = var_1_10010

					var_75_7(var_75_17, var_75_18, var_75_19, var_75_20, var_1_10010(110, 110), nil, true)
				end
			end
		end
	end

	local var_75_21 = {}

	pairs = var_75_7

	for iter_75_4, iter_75_5 in var_75_7(var_1:GetChapterCellAttachemnts()) do
		local var_75_22 = iter_75_5.data

		ChapterConst = var_1_10011

		if var_75_22 == var_1_10011.StoryTrigger then
			pg = var_75_22

			local var_75_23 = var_75_22.map_event_template[iter_75_5.attachmentId]

			assert = var_1_10011

			var_1_10011(var_75_23, "map_event_template not exists " .. iter_75_5.attachmentId)

			if var_75_23 then
				var_1_10011 = var_75_23.c_type
				ChapterConst = var_12

				if var_1_10011 == var_12.EvtType_AdditionalFloor then
					var_1_10011 = var_75_23.icon

					local var_75_24

					if not var_75_21[var_75_23.icon] then
						var_75_24 = {}
					end

					var_75_21[var_1_10011] = var_75_24
					table = var_1_10011

					var_1_10011.insert(var_75_21[var_75_23.icon], iter_75_5)
				end
			end
		end
	end

	pairs = var_5

	for iter_75_6, iter_75_7 in var_5(var_75_21) do
		var_1_10011 = arg_75_0

		arg_75_0.hideQuadMark(var_1_10011, iter_75_6)

		var_1_10011 = arg_75_0

		local var_75_25 = arg_75_0.showQuadMark
		local var_75_26 = iter_75_7

		iter_75_2 = iter_75_6

		local var_75_27 = iter_75_6

		Vector2 = var_1_10015

		var_75_25(var_1_10011, var_75_26, iter_75_2, var_75_27, var_1_10015(110, 110), nil, true)
	end

	if var_1:getConfig("alarm_cell") and #var_5 > 0 then
		local var_75_28 = var_5[3]

		iter_75_6 = arg_75_0

		arg_75_0.ClearEdges(iter_75_6, var_75_28)

		iter_75_6 = arg_75_0

		arg_75_0.ClearEdges(iter_75_6, var_75_28 .. "corner")

		iter_75_6 = arg_75_0

		arg_75_0.AddEdgePool(iter_75_6, var_75_28, "chapter/celltexture/" .. var_75_28, "")

		iter_75_6 = arg_75_0

		arg_75_0.AddEdgePool(iter_75_6, var_75_28 .. "_corner", "chapter/celltexture/" .. var_75_28 .. "_corner", "")

		_ = var_7

		local var_75_29 = var_7.map(var_5[1], function(arg_76_0)
			return {
				row = arg_76_0[1],
				column = arg_76_0[2]
			}
		end)

		arg_75_0:AddOutlines(var_75_29, nil, var_5[5], var_5[4], var_75_28)

		iter_75_6 = var_5[2]

		arg_75_0:hideQuadMark(iter_75_6)

		local var_75_30 = arg_75_0
		local var_75_31 = arg_75_0.showQuadMark

		var_1_10011 = var_75_29

		local var_75_32 = iter_75_6

		iter_75_2 = iter_75_6
		Vector2 = var_14

		var_75_31(var_75_30, var_1_10011, var_75_32, iter_75_2, var_14(104, 104), nil, true)
	end

	local var_75_33 = arg_75_0

	arg_75_0.HideMissileAimingMarks(var_75_33)

	ChapterConst = var_6

	if var_75_1[var_6.FlagMissleAiming] then
		next = var_6
		ChapterConst = var_75_33

		if var_6(var_75_1[var_75_33.FlagMissleAiming]) then
			local var_75_34 = arg_75_0
			local var_75_35 = arg_75_0.ShowMissileAimingMarks

			ChapterConst = iter_75_6

			var_75_35(var_75_34, var_75_1[iter_75_6.FlagMissleAiming])
		end
	end

	local var_75_36 = var_1.fleet

	if var_1:isPlayingWithBombEnemy() then
		_ = var_7

		local var_75_37 = var_7.map({
			{
				-1,
				0
			},
			{
				1,
				0
			},
			{
				0,
				-1
			},
			{
				0,
				1
			}
		}, function(arg_77_0)
			return {
				row = arg_77_0[1] + var_75_36.line.row,
				column = arg_77_0[2] + var_75_36.line.column
			}
		end)
		local var_75_38 = arg_75_0
		local var_75_39 = arg_75_0.showQuadMark
		local var_75_40 = var_75_37

		ChapterConst = var_1_10011

		local var_75_41 = var_1_10011.MarkBomb
		local var_75_42 = "cell_bomb"

		Vector2 = iter_75_2

		var_75_39(var_75_38, var_75_40, var_75_41, var_75_42, iter_75_2(100, 100), nil, true)
	end

	return
end

function var_0_1.updateExtraAttachments(arg_78_0)
	local var_78_0 = arg_78_0.contextData.chapterVO
	local var_78_1 = var_1.GetChapterCellAttachemnts(var_78_0)

	pairs = var_78_0

	for iter_78_0, iter_78_1 in var_78_0(var_78_1) do
		local var_78_2 = iter_78_1.row
		local var_78_3 = iter_78_1.column
		local var_78_4 = arg_78_0.cellRoot
		local var_78_5 = var_10.Find(var_78_4, iter_78_0)
		local var_78_6 = var_10.Find

		ChapterConst = var_1_10013

		local var_78_7 = var_78_6(var_78_5, var_1_10013.ChildAttachment)

		pg = var_78_5

		local var_78_8 = var_78_5.map_event_template[iter_78_1.attachmentId]

		var_1_10013 = iter_78_1.data

		local var_78_9

		ChapterConst = var_1_10015

		if var_1_10013 == var_1_10015.StoryTrigger then
			var_1_10015 = var_78_8.c_type
			ChapterConst = var_1_10016

			if var_1_10015 ~= var_1_10016.EvtType_AdditionalFloor then
				MapEventStoryTriggerCellView = var_78_9
			end
		end

		if arg_78_0.extraAttachmentCells[iter_78_0] and var_1_10015.class ~= var_78_9 then
			var_1_10015:Clear()

			var_1_10015 = nil
			var_1_10016 = arg_78_0.extraAttachmentCells
			var_1_10016[iter_78_0] = nil
		end

		if var_78_9 then
			if not var_1_10015 then
				var_1_10015 = var_78_9.New(var_78_7)
				var_1_10016 = arg_78_0.extraAttachmentCells
				var_1_10016[iter_78_0] = var_1_10015
			end

			var_1_10015.info = iter_78_1
			var_1_10015.chapter = var_1

			var_1_10015:SetLine({
				row = var_78_2,
				column = var_78_3
			})
			var_1_10015:Update()
		end
	end

	return
end

function var_0_1.updateAttachment(arg_79_0, arg_79_1, arg_79_2)
	local var_79_0 = arg_79_0.contextData.chapterVO

	if not var_3.getChapterCell(var_79_0, arg_79_1, arg_79_2) then
		return
	end

	ChapterCell = var_79_0

	local var_79_1 = var_79_0.Line2Name(arg_79_1, arg_79_2)
	local var_79_2 = arg_79_0.cellRoot
	local var_79_3 = var_6.Find(var_79_2, var_79_1)
	local var_79_4 = var_6.Find

	ChapterConst = var_1_10009

	local var_79_5 = var_79_4(var_79_3, var_1_10009.ChildAttachment)
	local var_79_6
	local var_79_7 = {}

	ChapterConst = var_1_10010

	if var_1_10010.IsEnemyAttach(var_4.attachment) then
		pg = var_10

		local var_79_8 = var_10.expedition_data_template[var_4.attachmentId]

		assert = var_79_9

		var_79_9(var_79_8, "expedition_data_template not exist: " .. var_4.attachmentId)

		local var_79_9 = var_4.flag

		ChapterConst = var_12

		if var_79_9 == var_12.CellFlagDisabled then
			var_79_9 = var_4.attachment
			ChapterConst = var_12

			if var_79_9 ~= var_12.AttachAmbush then
				EnemyDeadCellView = var_79_6
				var_79_7.chapter = var_3
				var_79_7.config = var_79_8
			end

			goto label_79_1
		end

		var_79_9 = var_4.flag
		ChapterConst = var_12

		if var_79_9 == var_12.CellFlagActive then
			if var_79_8.icon_type == 1 then
				StaticEggCellView = var_79_9

				if not var_79_9 then
					::label_79_0::

					StaticChampionCellView = var_79_6
				end

				var_79_7.config = var_79_8
				var_79_7.chapter = var_3
				var_79_7.viewParent = arg_79_0

				goto label_79_1

				do
					local var_79_10 = var_4.attachment

					ChapterConst = var_79_9

					if var_79_10 == var_79_9.AttachBox then
						AttachmentBoxCell = var_79_6
					else
						local var_79_11 = var_4.attachment

						ChapterConst = var_79_9

						if var_79_11 == var_79_9.AttachSupply then
							AttachmentSupplyCell = var_79_6
						else
							local var_79_12 = var_4.attachment

							ChapterConst = var_79_9

							if var_79_12 == var_79_9.AttachTransport_Target then
								AttachmentTransportTargetCell = var_79_6
							else
								local var_79_13 = var_4.attachment

								ChapterConst = var_79_9

								if var_79_13 == var_79_9.AttachStory then
									local var_79_14 = var_4.data

									ChapterConst = var_79_9

									if var_79_14 == var_79_9.Story then
										MapEventStoryCellView = var_79_6
									else
										local var_79_15 = var_4.data

										ChapterConst = var_79_9

										if var_79_15 == var_79_9.StoryObstacle then
											MapEventStoryObstacleCellView = var_79_6
											var_79_7.chapter = var_3
										end
									end
								else
									local var_79_16 = var_4.attachment

									ChapterConst = var_79_9

									if var_79_16 == var_79_9.AttachBomb_Enemy then
										AttachmentBombEnemyCell = var_79_6
									else
										local var_79_17 = var_4.attachment

										ChapterConst = var_79_9

										if var_79_17 == var_79_9.AttachLandbase then
											pg = var_79_17

											local var_79_18 = var_79_17.land_based_template[var_4.attachmentId]

											assert = var_79_9

											var_79_9(var_79_18, "land_based_template not exist: " .. var_4.attachmentId)

											var_79_9 = var_79_18.type
											ChapterConst = var_12

											if var_79_9 == var_12.LBCoastalGun then
												AttachmentLBCoastalGunCell = var_79_6
											else
												var_79_9 = var_79_18.type
												ChapterConst = var_12

												if var_79_9 == var_12.LBHarbor then
													AttachmentLBHarborCell = var_79_6
												else
													var_79_9 = var_79_18.type
													ChapterConst = var_12

													if var_79_9 == var_12.LBDock then
														AttachmentLBDockCell = var_79_6
														var_79_7.chapter = var_3
													else
														var_79_9 = var_79_18.type
														ChapterConst = var_12

														if var_79_9 == var_12.LBAntiAir then
															AttachmentLBAntiAirCell = var_79_6
															var_79_7.info = var_4
															var_79_7.chapter = var_3
															var_79_7.grid = arg_79_0
														else
															var_79_9 = var_79_18.type
															ChapterConst = var_12

															if var_79_9 == var_12.LBFogLightBase then
																AttachmentLBFogLightBase = var_79_6
															else
																var_79_9 = var_79_18.type
																ChapterConst = var_12

																if var_79_9 == var_12.LBIdle then
																	var_79_9 = var_4.attachmentId
																	ChapterConst = var_12

																	if var_79_9 == var_12.LBIDAirport then
																		AttachmentLBAirport = var_79_6
																		var_79_7.extraFlagList = var_3:getExtraFlags()
																	end
																end
															end
														end
													end
												end
											end
										else
											local var_79_19 = var_4.attachment

											ChapterConst = var_79_9

											if var_79_19 == var_79_9.AttachBarrier then
												AttachmentBarrierCell = var_79_6
											else
												local var_79_20 = var_4.attachment

												ChapterConst = var_79_9

												if var_79_20 == var_79_9.AttachNone then
													var_79_7.fadeAnim = (function()
														if not arg_79_0.attachmentCells[var_79_1] then
															return
														end

														local var_80_0 = var_0.class

														StaticEggCellView = var_2_10002

														if var_80_0 ~= var_2_10002 then
															local var_80_1 = var_0.class

															StaticChampionCellView = var_2_10002

															if var_80_1 ~= var_2_10002 then
																return
															end
														end

														if not var_0.info then
															return
														end

														pg = var_2_10002

														return var_2_10002.expedition_data_template[var_1.attachmentId].dungeon_id == 0
													end)()
												end
											end
										end
									end
								end
							end
						end
					end
				end

				::label_79_1::

				if var_79_7.fadeAnim then
					var_79_9 = arg_79_0

					arg_79_0.PlayAttachmentEffect(var_79_9, arg_79_1, arg_79_2, "miwuxiaosan")
				end

				local var_79_21

				if arg_79_0.attachmentCells[var_79_1] and var_79_21.class ~= var_79_6 then
					var_79_21:Clear()

					var_79_21 = nil
					var_79_9 = arg_79_0.attachmentCells
					var_79_9[var_79_1] = nil
				end

				if var_79_6 then
					if not var_79_21 then
						local var_79_22 = var_79_6.New(var_79_5)

						var_79_21.SetLine(var_79_22, {
							row = arg_79_1,
							column = arg_79_2
						})

						var_79_9 = arg_79_0.attachmentCells
						var_79_9[var_79_1] = var_79_21
					end

					var_79_21.info = var_4
					pairs = var_79_9

					for iter_79_0, iter_79_1 in var_79_9(var_79_7) do
						var_79_21[iter_79_0] = iter_79_1
					end

					var_79_21:Update()
				end

				return
			end
		end
	end
end

function var_0_1.InitWalls(arg_81_0)
	local var_81_0 = arg_81_0.contextData.chapterVO

	for iter_81_0 = arg_81_0.indexMin.x, arg_81_0.indexMax.x do
		for iter_81_1 = arg_81_0.indexMin.y, arg_81_0.indexMax.y do
			local var_81_1 = var_81_0

			if var_81_0.GetRawChapterCell(var_81_1, iter_81_0, iter_81_1) then
				ChapterConst = var_81_1

				local var_81_2 = var_81_1.ForbiddenUp

				while var_81_2 > 0 do
					arg_81_0:InitWallDirection(var_10, var_81_2)

					var_81_2 = var_81_2 / 2
				end
			end
		end
	end

	pairs = var_2

	for iter_81_2, iter_81_3 in var_2(arg_81_0.walls) do
		if iter_81_3.WallPrefabs then
			iter_81_3:SetAsset(iter_81_3.WallPrefabs[5 - iter_81_3.BanCount])
		end
	end

	return
end

local var_0_4 = {}

ChapterConst = var_4
var_0_4[var_4.ForbiddenUp] = {
	-1,
	0
}
ChapterConst = var_4
var_0_4[var_4.ForbiddenDown] = {
	1,
	0
}
ChapterConst = var_4
var_0_4[var_4.ForbiddenLeft] = {
	0,
	-1
}
ChapterConst = var_4
var_0_4[var_4.ForbiddenRight] = {
	0,
	1
}

function var_0_1.InitWallDirection(arg_82_0, arg_82_1, arg_82_2)
	local var_82_0 = arg_82_0.contextData.chapterVO

	bit = var_1_10004

	if var_1_10004.band(arg_82_1.forbiddenDirections, arg_82_2) == 0 then
		return
	end

	if arg_82_1.walkable == false then
		return
	end

	local var_82_1 = var_0_4[arg_82_2]
	local var_82_2 = 2 * arg_82_1.row + var_82_1[1]
	local var_82_3 = 2 * arg_82_1.column + var_82_1[2]
	local var_82_4 = not var_82_0:GetRawChapterCell(arg_82_1.row + var_82_1[1], arg_82_1.column + var_82_1[2]) or var_7.walkable == false
	local var_82_5 = var_82_2 .. "_" .. var_82_3
	local var_82_13

	if not arg_82_0.walls[var_82_5] then
		local var_82_6 = var_82_0.theme

		var_11.x = var_11.GetLinePosition(var_82_6, arg_82_1.row, arg_82_1.column).x + var_82_1[2] * (var_82_0.theme.cellSize.x + var_82_0.theme.cellSpace.x) * 0.5
		var_11.y = var_11.y - var_82_1[1] * (var_82_0.theme.cellSize.y + var_82_0.theme.cellSpace.y) * 0.5
		WallCell = var_12

		local var_82_7 = var_12.New
		local var_82_8 = var_82_2
		local var_82_9 = var_82_3

		bit = var_15

		local var_82_10 = var_15.band
		local var_82_11 = arg_82_2

		ChapterConst = var_1_10017

		local var_82_12 = var_82_7(var_82_8, var_82_9, var_82_10(var_82_11, var_1_10017.ForbiddenRow) > 0, var_11)

		var_82_12.girdParent = arg_82_0
		arg_82_0.walls[var_82_5] = var_82_12
		var_82_13 = var_82_12

		if var_82_0.wallAssets[arg_82_1.row .. "_" .. arg_82_1.column] then
			var_82_13.WallPrefabs = var_13
		end
	end

	var_82_13.BanCount = var_82_13.BanCount + (var_82_4 and 2 or 1)

	return
end

function var_0_1.UpdateWeatherCells(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0.contextData.chapterVO

	if not arg_83_1 then
		underscore = var_1_10003
		arg_83_1 = var_1_10003.keys(var_83_0.cells)
	end

	local var_83_1 = var_83_0
	local var_83_2 = var_83_0.IsFogStage(var_83_1)

	ipairs = var_83_1

	for iter_83_0, iter_83_1 in var_83_1(arg_83_1) do
		local var_83_3 = var_83_0.cells[iter_83_1]
		local var_83_4

		if #var_83_3:GetWeatherFlagList() > 0 then
			MapWeatherCellView = var_83_4
		end

		local var_83_5

		if arg_83_0.weatherCells[iter_83_1] and var_83_5.class ~= var_83_4 then
			var_83_5:Clear()

			var_83_5 = nil
			arg_83_0.weatherCells[iter_83_1] = nil
		end

		if var_83_4 then
			if not var_83_5 then
				local var_83_6 = arg_83_0.cellRoot
				local var_83_7 = var_13.Find(var_83_6, iter_83_1)
				local var_83_8 = var_13.Find

				ChapterConst = var_1_10016

				local var_83_9 = var_83_8(var_83_7, var_1_10016.ChildAttachment)

				var_1_10016 = var_83_4.New(var_83_9)

				var_83_5.SetLine(var_1_10016, {
					row = var_83_3.row,
					column = var_83_3.column
				})

				arg_83_0.weatherCells[iter_83_1] = var_83_5
			end

			var_83_5.info = var_83_3

			var_83_5:Update(var_11)
		end

		if var_83_2 then
			local var_83_10 = var_83_0
			local var_83_11 = var_83_0.GetEnemy(var_83_10, var_83_3.row, var_83_3.column)

			tobool = var_83_10

			if var_83_10(var_83_11) then
				arg_83_0:updateAttachment(var_83_3.row, var_83_3.column)
			end
		end
	end

	return
end

function var_0_1.updateFogCells(arg_84_0)
	local var_84_0 = arg_84_0.contextData.chapterVO

	pairs = var_1_10002

	for iter_84_0, iter_84_1 in var_1_10002(var_84_0.cells) do
		ChapterCell = var_1_10007
		var_1_10007 = var_1_10007.Line2Name(iter_84_1.row, iter_84_1.column)

		local var_84_1 = arg_84_0.cellRoot
		local var_84_2 = var_8.Find(var_84_1, var_1_10007)

		setImageAlpha = var_84_1

		local var_84_3 = var_84_2
		local var_84_4 = var_84_2.Find

		ChapterConst = var_1_10012

		local var_84_5 = var_84_4(var_84_3, var_1_10012.ChildVisible .. "/mask")

		var_1_10012 = iter_84_1

		var_84_1(var_84_5, iter_84_1.IsVisible(var_1_10012) and 0 or 0.4)
	end

	return
end

function var_0_1.updateQuadCells(arg_85_0, arg_85_1)
	if not arg_85_1 then
		ChapterConst = var_1_10002
		arg_85_1 = var_1_10002.QuadStateNormal
	end

	arg_85_0.quadState = arg_85_1

	arg_85_0:updateQuadBase()

	ChapterConst = var_2

	if arg_85_1 == var_2.QuadStateNormal then
		arg_85_0:UpdateQuadStateNormal()

		goto label_85_0
	end

	ChapterConst = var_2

	if arg_85_1 == var_2.QuadStateBarrierSetting then
		arg_85_0:UpdateQuadStateBarrierSetting()

		goto label_85_0
	end

	ChapterConst = var_2

	if arg_85_1 == var_2.QuadStateTeleportSub then
		arg_85_0:UpdateQuadStateTeleportSub()

		goto label_85_0
	end

	ChapterConst = var_2

	if arg_85_1 ~= var_2.QuadStateMissileStrike then
		ChapterConst = var_2

		if arg_85_1 == var_2.QuadStateAirSuport then
			arg_85_0:UpdateQuadStateMissileStrike()
		else
			ChapterConst = var_2

			if arg_85_1 == var_2.QuadStateExpel then
				arg_85_0:UpdateQuadStateAirExpel()
			end
		end

		::label_85_0::

		arg_85_0:UpdateOpBtns()

		return
	end
end

function var_0_1.PlayQuadsParallelAnim(arg_86_0, arg_86_1)
	arg_86_0:frozen()

	table = var_2

	var_2.ParallelIpairsAsync(arg_86_1, function(arg_87_0, arg_87_1, arg_87_2)
		ChapterCell = var_2_10003

		local var_87_0 = var_2_10003.Line2QuadName(arg_87_1.row, arg_87_1.column)
		local var_87_1 = arg_86_0.quadRoot
		local var_87_2 = var_4.Find(var_87_1, var_87_0)
		local var_87_3 = arg_86_0

		var_5.cancelQuadTween(var_87_3, var_87_0, var_87_2)

		setImageAlpha = var_5

		var_5(var_87_2, 0.4)

		LeanTween = var_5

		local var_87_4 = var_5.scale
		local var_87_5 = var_87_2

		Vector3 = var_7

		local var_87_6 = var_87_4(var_87_5, var_7.one, 0.2)
		local var_87_7 = var_5.setFrom

		Vector3 = var_7

		local var_87_8 = var_87_7(var_87_6, var_7.zero)
		local var_87_9 = var_5.setEase

		LeanTweenType = var_7

		local var_87_10 = var_87_9(var_87_8, var_7.easeInOutSine)
		local var_87_11 = var_5.setOnComplete

		System = var_7

		local var_87_12 = var_87_11(var_87_10, var_7.Action(arg_87_2))

		arg_86_0.presentTws[var_87_0] = {
			uniqueId = var_87_12.uniqueId
		}

		return
	end, function()
		local var_88_0 = arg_86_0

		var_0.unfrozen(var_88_0)

		return
	end)

	return
end

function var_0_1.updateQuadBase(arg_89_0)
	if arg_89_0.contextData.chapterVO.fleet == nil then
		return
	end

	local var_89_0 = arg_89_0

	arg_89_0.killPresentTws(var_89_0)

	local function var_89_1(arg_90_0)
		if not arg_90_0 or not arg_90_0:IsWalkable() then
			return
		end

		local var_90_0 = arg_90_0.row
		local var_90_1 = arg_90_0.column

		ChapterCell = var_2_10003

		local var_90_2 = var_2_10003.Line2QuadName(var_90_0, var_90_1)
		local var_90_3 = arg_89_0.quadRoot
		local var_90_4 = var_4.Find(var_90_3, var_90_2)

		Vector3 = var_90_3
		var_90_4.localScale = var_90_3.one

		local var_90_5 = var_90_4:Find("grid")
		local var_90_6 = var_5.GetComponent

		typeof = var_7
		Image = var_2_10008

		local var_90_7 = var_90_6(var_90_5, var_7(var_2_10008))
		local var_90_8 = var_0

		if var_6.getChampion(var_90_8, var_90_0, var_90_1) then
			local var_90_9 = var_6.flag

			ChapterConst = var_8

			if var_90_9 == var_8.CellFlagActive then
				local var_90_10 = var_6.trait

				ChapterConst = var_8

				if var_90_10 ~= var_8.TraitLurk then
					local var_90_11 = var_0

					if var_7.getChampionVisibility(var_90_11, var_6) then
						local var_90_12 = var_0
						local var_90_13 = var_7.existFleet

						FleetType = var_9

						if not var_90_13(var_90_12, var_9.Transport, var_90_0, var_90_1) then
							local var_90_14 = arg_89_0

							var_7.startQuadTween(var_90_14, var_90_2, var_90_4)

							setImageSprite = var_7

							local var_90_15 = var_90_4

							GetSpriteFromAtlas = var_9

							var_7(var_90_15, var_9("chapter/pic/cellgrid", "cell_enemy"))

							setImageSprite = var_7

							local var_90_16 = var_90_4
							local var_90_17 = var_90_4.Find(var_90_16, "grid")

							GetSpriteFromAtlas = var_90_16

							var_7(var_90_17, var_90_16("chapter/pic/cellgrid", "cell_enemy_grid"))

							var_90_7.material = arg_89_0.material_Add

							return
						end
					end
				end
			end
		end

		local var_90_18 = var_0

		if var_7.GetRawChapterAttachemnt(var_90_18, var_90_0, var_90_1) then
			local var_90_19 = var_0

			if var_8.getQuadCellPic(var_90_19, var_7) then
				local var_90_20 = arg_89_0

				var_9.startQuadTween(var_90_20, var_90_2, var_90_4)

				setImageSprite = var_9

				local var_90_21 = var_90_4

				GetSpriteFromAtlas = var_11

				var_9(var_90_21, var_11("chapter/pic/cellgrid", var_8))

				return
			end
		end

		local var_90_22 = var_0

		if var_8.getChapterCell(var_90_22, var_90_0, var_90_1) then
			local var_90_23 = var_0

			if var_9.getQuadCellPic(var_90_23, arg_90_0) then
				local var_90_24 = arg_89_0

				var_10.startQuadTween(var_90_24, var_90_2, var_90_4)

				local var_90_25

				if var_9 == "cell_enemy" then
					setImageSprite = var_10
					var_90_25 = var_90_4

					local var_90_26 = var_90_4.Find(var_90_25, "grid")

					GetSpriteFromAtlas = var_90_25

					var_10(var_90_26, var_90_25("chapter/pic/cellgrid", "cell_enemy_grid"))

					var_90_7.material = arg_89_0.material_Add
				else
					setImageSprite = var_10
					var_90_25 = var_90_4

					local var_90_27 = var_90_4.Find(var_90_25, "grid")

					GetSpriteFromAtlas = var_90_25

					var_10(var_90_27, var_90_25("chapter/pic/cellgrid", "cell_grid"))

					var_90_7.material = nil
				end

				setImageSprite = var_10

				local var_90_28 = var_90_4

				GetSpriteFromAtlas = var_90_25

				var_10(var_90_28, var_90_25("chapter/pic/cellgrid", var_9))

				return
			end
		end

		local var_90_29 = arg_89_0

		var_9.cancelQuadTween(var_90_29, var_90_2, var_90_4)

		setImageAlpha = var_9

		local var_90_30 = var_90_4

		ChapterConst = var_11

		var_9(var_90_30, var_11.CellEaseOutAlpha)

		setImageSprite = var_9

		local var_90_31 = var_90_4

		GetSpriteFromAtlas = var_11

		var_9(var_90_31, var_11("chapter/pic/cellgrid", "cell_normal"))

		setImageSprite = var_9

		local var_90_32 = var_90_4
		local var_90_33 = var_90_4.Find(var_90_32, "grid")

		GetSpriteFromAtlas = var_90_32

		var_9(var_90_33, var_90_32("chapter/pic/cellgrid", "cell_grid"))

		var_90_7.material = nil

		return
	end

	pairs = var_89_0

	for iter_89_0, iter_89_1 in var_89_0(var_1.cells) do
		var_89_1(iter_89_1)
	end

	if var_1:isPlayingWithBombEnemy() then
		local var_89_2 = arg_89_0
		local var_89_3 = arg_89_0.hideQuadMark

		ChapterConst = var_6

		var_89_3(var_89_2, var_6.MarkBomb)
	end

	return
end

function var_0_1.UpdateQuadStateNormal(arg_91_0)
	local var_91_0 = arg_91_0.contextData.chapterVO.fleet
	local var_91_1
	local var_91_3

	if var_1:existMoveLimit() and not var_1:checkAnyInteractive() then
		local var_91_2 = var_1

		var_91_3 = var_1.calcWalkableCells
		ChapterConst = var_1_10006
		var_91_1 = var_91_3(var_91_2, var_1_10006.SubjectPlayer, var_91_0.line.row, var_91_0.line.column, var_91_0:getSpeed())
	end

	if not var_91_1 or #var_91_1 == 0 then
		return
	end

	_ = var_91_3

	local var_91_4 = var_91_3.min(var_91_1, function(arg_92_0)
		ManhattonDist = var_2_10001

		return var_2_10001(arg_92_0, var_91_0.line)
	end)

	ManhattonDist = var_5

	local var_91_5 = var_5(var_91_4, var_91_0.line)

	_ = var_6

	var_6.each(var_91_1, function(arg_93_0)
		ChapterCell = var_2_10001

		local var_93_0 = var_2_10001.Line2QuadName(arg_93_0.row, arg_93_0.column)
		local var_93_1 = arg_91_0.quadRoot
		local var_93_2 = var_2.Find(var_93_1, var_93_0)
		local var_93_3 = arg_91_0

		var_3.cancelQuadTween(var_93_3, var_93_0, var_93_2)

		setImageSprite = var_3

		local var_93_4 = var_93_2

		GetSpriteFromAtlas = var_5

		var_3(var_93_4, var_5("chapter/pic/cellgrid", "cell_normal"))

		local var_93_5 = var_93_2:Find("grid")
		local var_93_6 = var_3.GetComponent

		typeof = var_5
		Image = var_6

		local var_93_7 = var_93_6(var_93_5, var_5(var_6))

		GetSpriteFromAtlas = var_93_5
		var_93_7.sprite = var_93_5("chapter/pic/cellgrid", "cell_grid")
		var_93_7.material = nil

		local var_93_8 = var_0
		local var_93_9 = var_4.getRound(var_93_8)

		ChapterConst = var_93_8

		local var_93_10 = var_93_9 == var_93_8.RoundPlayer

		setImageAlpha = var_5

		local var_93_11 = var_93_2
		local var_93_12

		if var_93_10 then
			var_93_12 = 1
		else
			ChapterConst = var_93_12
			var_93_12 = var_93_12.CellEaseOutAlpha
		end

		var_5(var_93_11, var_93_12)

		Vector3 = var_5
		var_93_2.localScale = var_5.zero
		LeanTween = var_5

		local var_93_13 = var_5.scale
		local var_93_14 = var_93_2

		Vector3 = var_93_12

		local var_93_15 = var_93_13(var_93_14, var_93_12.one, 0.2)
		local var_93_16 = var_5.setFrom

		Vector3 = var_7

		local var_93_17 = var_93_16(var_93_15, var_7.zero)
		local var_93_18 = var_5.setEase

		LeanTweenType = var_7

		local var_93_19 = var_93_18(var_93_17, var_7.easeInOutSine)
		local var_93_20 = var_5.setDelay

		ManhattonDist = var_7

		local var_93_21 = var_93_20(var_93_19, (var_7(arg_93_0, var_91_0.line) - var_91_5) * 0.1)

		arg_91_0.presentTws[var_93_0] = {
			uniqueId = var_93_21.uniqueId
		}

		return
	end)

	return
end

function var_0_1.UpdateQuadStateBarrierSetting(arg_94_0)
	local var_94_0 = 1
	local var_94_1 = arg_94_0.contextData.chapterVO.fleet.line
	local var_94_2 = var_2

	if not var_2.calcSquareBarrierCells(var_94_2, var_94_1.row, var_94_1.column, var_94_0) or #var_5 == 0 then
		return
	end

	_ = var_94_2

	local var_94_3 = var_94_2.min(var_5, function(arg_95_0)
		ManhattonDist = var_2_10001

		return var_2_10001(arg_95_0, var_0.line)
	end)

	ManhattonDist = var_7

	local var_94_4 = var_7(var_94_3, var_3.line)

	_ = var_8

	var_8.each(var_5, function(arg_96_0)
		ChapterCell = var_2_10001

		local var_96_0 = var_2_10001.Line2QuadName(arg_96_0.row, arg_96_0.column)
		local var_96_1 = arg_94_0.quadRoot
		local var_96_2 = var_2.Find(var_96_1, var_96_0)
		local var_96_3 = arg_94_0

		var_3.cancelQuadTween(var_96_3, var_96_0, var_96_2)

		setImageSprite = var_3

		local var_96_4 = var_96_2

		GetSpriteFromAtlas = var_5

		var_3(var_96_4, var_5("chapter/pic/cellgrid", "cell_barrier_select"))

		local var_96_5 = var_96_2:Find("grid")
		local var_96_6 = var_3.GetComponent

		typeof = var_5
		Image = var_6

		local var_96_7 = var_96_6(var_96_5, var_5(var_6))

		GetSpriteFromAtlas = var_96_5
		var_96_7.sprite = var_96_5("chapter/pic/cellgrid", "cell_grid")
		var_96_7.material = nil
		setImageAlpha = var_4

		var_4(var_96_2, 1)

		Vector3 = var_4
		var_96_2.localScale = var_4.zero
		LeanTween = var_4

		local var_96_8 = var_4.scale
		local var_96_9 = var_96_2

		Vector3 = var_6

		local var_96_10 = var_96_8(var_96_9, var_6.one, 0.2)
		local var_96_11 = var_4.setFrom

		Vector3 = var_6

		local var_96_12 = var_96_11(var_96_10, var_6.zero)
		local var_96_13 = var_4.setEase

		LeanTweenType = var_6

		local var_96_14 = var_96_13(var_96_12, var_6.easeInOutSine)
		local var_96_15 = var_4.setDelay

		ManhattonDist = var_6

		local var_96_16 = var_96_15(var_96_14, (var_6(arg_96_0, var_0.line) - var_94_4) * 0.1)

		arg_94_0.presentTws[var_96_0] = {
			uniqueId = var_96_16.uniqueId
		}

		return
	end)

	return
end

function var_0_1.UpdateQuadStateTeleportSub(arg_97_0)
	local var_97_0 = arg_97_0.contextData.chapterVO

	_ = var_1_10002

	if not var_1_10002.detect(var_97_0.fleets, function(arg_98_0)
		local var_98_0 = arg_98_0
		local var_98_1 = arg_98_0.getFleetType(var_98_0)

		FleetType = var_98_0

		return var_98_1 == var_98_0.Submarine
	end) then
		return
	end

	local var_97_1 = var_97_0
	local var_97_2 = var_97_0.calcWalkableCells
	local var_97_3
	local var_97_4 = var_2.line.row
	local var_97_5 = var_2.line.column

	ChapterConst = var_1_10008

	local var_97_6 = var_97_2(var_97_1, var_97_3, var_97_4, var_97_5, var_1_10008.MaxStep)

	_ = var_97_1

	local var_97_7 = var_97_1.filter(var_97_6, function(arg_99_0)
		local var_99_0 = var_97_0
		local var_99_1 = var_1.getQuadCellPic
		local var_99_2 = var_97_0

		return not var_99_1(var_99_0, var_3.getChapterCell(var_99_2, arg_99_0.row, arg_99_0.column))
	end)

	arg_97_0:PlayQuadsParallelAnim(var_97_7)

	return
end

function var_0_1.UpdateQuadStateMissileStrike(arg_100_0)
	local var_100_0 = arg_100_0.contextData.chapterVO

	_ = var_1_10002

	local var_100_1 = var_1_10002.filter

	_ = var_1_10003

	local var_100_2 = var_100_1(var_1_10003.values(var_100_0.cells), function(arg_101_0)
		local var_101_1

		if arg_101_0:IsWalkable() then
			local var_101_0 = var_100_0

			var_101_1 = not var_1.getQuadCellPic(var_101_0, arg_101_0)
		end

		return var_101_1
	end)

	arg_100_0:PlayQuadsParallelAnim(var_100_2)

	return
end

function var_0_1.UpdateQuadStateAirExpel(arg_102_0)
	local var_102_0 = arg_102_0.contextData.chapterVO

	if not arg_102_0.airSupportTarget or not var_2.source then
		_ = var_1_10003

		local var_102_1 = var_1_10003.filter

		_ = var_1_10004

		local var_102_2 = var_102_1(var_1_10004.values(var_102_0.cells), function(arg_103_0)
			local var_103_1

			if arg_103_0:IsWalkable() then
				local var_103_0 = var_102_0

				var_103_1 = not var_1.getQuadCellPic(var_103_0, arg_103_0)
			end

			return var_103_1
		end)

		arg_102_0:PlayQuadsParallelAnim(var_102_2)

		return
	end

	local var_102_3 = var_2.source
	local var_102_4 = var_102_0
	local var_102_5 = var_102_0.calcWalkableCells

	ChapterConst = var_1_10006

	local var_102_6 = var_102_5(var_102_4, var_1_10006.SubjectChampion, var_102_3.row, var_102_3.column, 1)

	arg_102_0:PlayQuadsParallelAnim(var_102_6)

	return
end

function var_0_1.ClickGridCell(arg_104_0, arg_104_1)
	local var_104_0 = arg_104_0.quadState

	ChapterConst = var_1_10003

	local var_104_1

	if var_104_0 == var_1_10003.QuadStateBarrierSetting then
		var_104_1 = arg_104_0

		arg_104_0.OnBarrierSetting(var_104_1, arg_104_1)
	else
		local var_104_2 = arg_104_0.quadState

		ChapterConst = var_104_1

		local var_104_3

		if var_104_2 == var_104_1.QuadStateTeleportSub then
			var_104_3 = arg_104_0

			arg_104_0.OnTeleportConfirm(var_104_3, arg_104_1)
		else
			local var_104_4 = arg_104_0.quadState

			ChapterConst = var_104_3

			local var_104_5

			if var_104_4 == var_104_3.QuadStateMissileStrike then
				var_104_5 = arg_104_0

				arg_104_0.OnMissileAiming(var_104_5, arg_104_1)
			else
				local var_104_6 = arg_104_0.quadState

				ChapterConst = var_104_5

				local var_104_7

				if var_104_6 == var_104_5.QuadStateAirSuport then
					var_104_7 = arg_104_0

					arg_104_0.OnAirSupportAiming(var_104_7, arg_104_1)
				else
					local var_104_8 = arg_104_0.quadState

					ChapterConst = var_104_7

					if var_104_8 == var_104_7.QuadStateExpel then
						arg_104_0:OnAirExpelSelect(arg_104_1)
					else
						local var_104_9 = arg_104_0
						local var_104_10 = arg_104_0.emit

						LevelUIConst = var_1_10004

						var_104_10(var_104_9, var_1_10004.ON_CLICK_GRID_QUAD, arg_104_1)
					end
				end
			end
		end
	end

	return
end

function var_0_1.OnBarrierSetting(arg_105_0, arg_105_1)
	local var_105_0 = 1
	local var_105_1 = arg_105_0.contextData.chapterVO.fleet.line
	local var_105_2 = var_3
	local var_105_3 = var_3.calcSquareBarrierCells(var_105_2, var_105_1.row, var_105_1.column, var_105_0)

	_ = var_105_2

	if not var_105_2.any(var_105_3, function(arg_106_0)
		return arg_106_0.row == arg_105_1.row and arg_106_0.column == arg_105_1.column
	end) then
		return
	end

	;(function(arg_107_0, arg_107_1)
		local var_107_0 = arg_105_0.contextData.chapterVO

		newChapterVO = newChapterVO

		if not var_2:existBarrier(arg_107_0, arg_107_1) then
			newChapterVO = var_2

			if var_2.modelCount <= 0 then
				return
			end
		end

		local var_107_1 = arg_105_0
		local var_107_2 = var_2.emit

		LevelMediator2 = var_4

		local var_107_3 = var_4.ON_OP
		local var_107_4 = {}

		ChapterConst = var_2_10006
		var_107_4.type = var_2_10006.OpBarrier
		newChapterVO = var_6
		var_107_4.id = var_6.fleet.id
		var_107_4.arg1 = arg_107_0
		var_107_4.arg2 = arg_107_1

		var_107_2(var_107_1, var_107_3, var_107_4)

		return
	end)(arg_105_1.row, arg_105_1.column)

	return
end

function var_0_1.PrepareSubTeleport(arg_108_0)
	local var_108_0 = arg_108_0.contextData.chapterVO
	local var_108_1 = var_1.GetSubmarineFleet(var_108_0)
	local var_108_2 = arg_108_0.cellFleets[var_108_1.id]
	local var_108_3 = var_108_1.startPos

	pairs = var_1_10005

	for iter_108_0, iter_108_1 in var_1_10005(var_1.fleets) do
		local var_108_4 = iter_108_1
		local var_108_5 = iter_108_1.getFleetType(var_108_4)

		FleetType = var_108_4

		if var_108_5 == var_108_4.Normal then
			arg_108_0:updateFleet(iter_108_1.id)
		end
	end

	local var_108_6 = var_1
	local var_108_7 = var_1.existEnemy

	ChapterConst = var_7

	local var_108_8

	if not var_108_7(var_108_6, var_7.SubjectPlayer, var_108_3.row, var_108_3.column) then
		var_108_6 = var_1
		var_108_8 = var_1.existFleet
		FleetType = var_7
		var_108_8 = var_108_8(var_108_6, var_7.Normal, var_108_3.row, var_108_3.column)
	end

	setActive = var_108_6

	var_108_6(var_108_2.tfAmmo, not var_108_8)
	var_108_2:SetActiveModel(true)

	if not (var_1.subAutoAttack == 1) then
		arg_108_0:PlaySubAnimation(var_108_2, false, function()
			local var_109_0 = var_108_2

			var_0.SetActiveModel(var_109_0, not var_108_8)

			return
		end)
	else
		var_108_2:SetActiveModel(not var_108_8)
	end

	local var_108_9 = var_108_2.tf
	local var_108_10 = var_1.theme

	var_108_9.localPosition = var_8.GetLinePosition(var_108_10, var_108_3.row, var_108_3.column)

	var_108_2:ResetCanvasOrder()

	return
end

function var_0_1.TurnOffSubTeleport(arg_110_0)
	arg_110_0.subTeleportTargetLine = nil

	local var_110_0 = arg_110_0.contextData.chapterVO
	local var_110_1 = arg_110_0
	local var_110_2 = arg_110_0.hideQuadMark

	ChapterConst = var_1_10004

	var_110_2(var_110_1, var_1_10004.MarkMovePathArrow)

	local var_110_3 = arg_110_0
	local var_110_4 = arg_110_0.hideQuadMark

	ChapterConst = var_4

	var_110_4(var_110_3, var_4.MarkHuntingRange)
	arg_110_0:ClearEdges("SubmarineHunting")
	arg_110_0:UpdateDestinationMark()

	local var_110_5 = var_110_0:GetSubmarineFleet()
	local var_110_6 = arg_110_0.cellFleets[var_110_5.id]
	local var_110_7 = var_110_0.subAutoAttack == 1

	var_110_6:SetActiveModel(var_110_7)

	if not var_110_7 then
		arg_110_0:PlaySubAnimation(var_110_6, true, function()
			local var_111_0 = arg_110_0

			var_0.updateFleet(var_111_0, var_110_5.id)

			return
		end)
	else
		arg_110_0:updateFleet(var_110_5.id)
	end

	arg_110_0:ShowHuntingRange()

	return
end

function var_0_1.OnTeleportConfirm(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_0.contextData.chapterVO

	if var_2.getChapterCell(var_112_0, arg_112_1.row, arg_112_1.column) and var_3:IsWalkable() and not var_2:existBarrier(arg_112_1.row, arg_112_1.column) then
		if var_2:GetSubmarineFleet().startPos.row == arg_112_1.row and var_4.startPos.column == arg_112_1.column then
			return
		end

		local var_112_1, var_112_2 = var_2:findPath(nil, var_4.startPos, arg_112_1)

		PathFinding = var_7

		if var_112_1 >= var_7.PrioObstacle or arg_112_1.row ~= var_112_2[#var_112_2].row or arg_112_1.column ~= var_112_2[#var_112_2].column then
			return
		end

		arg_112_0:ShowTargetHuntingRange(arg_112_1)
		arg_112_0:UpdateDestinationMark(arg_112_1)

		if var_112_1 > 0 then
			arg_112_0:ShowPathInArrows(var_112_2)

			arg_112_0.subTeleportTargetLine = arg_112_1
		end
	end

	return
end

function var_0_1.ShowPathInArrows(arg_113_0, arg_113_1)
	local var_113_0 = arg_113_0.contextData.chapterVO

	Clone = var_1_10003

	local var_113_1 = var_1_10003(arg_113_1)

	table = var_4

	var_4.remove(var_113_1, #var_113_1)

	for iter_113_0 = #var_113_1, 1, -1 do
		local var_113_2 = var_113_1[iter_113_0]
		local var_113_3 = var_113_0

		var_1_10009 = var_113_0.existEnemy
		ChapterConst = var_1_10011

		if not var_1_10009(var_113_3, var_1_10011.SubjectPlayer, var_113_2.row, var_113_2.column) then
			var_113_3 = var_113_0
			var_1_10009 = var_113_0.getFleet
			FleetType = var_1_10011
			var_1_10009 = var_1_10009(var_113_3, var_1_10011.Normal, var_113_2.row, var_113_2.column)
		end

		if var_1_10009 then
			table = var_113_3

			var_113_3.remove(var_113_1, iter_113_0)
		end
	end

	local var_113_4 = arg_113_0
	local var_113_5 = arg_113_0.hideQuadMark

	ChapterConst = var_6

	var_113_5(var_113_4, var_6.MarkMovePathArrow)

	local var_113_6 = arg_113_0
	local var_113_7 = arg_113_0.showQuadMark
	local var_113_8 = var_113_1

	ChapterConst = iter_113_0

	local var_113_9 = iter_113_0.MarkMovePathArrow
	local var_113_10 = "cell_path_arrow"

	Vector2 = var_1_10009

	var_113_7(var_113_6, var_113_8, var_113_9, var_113_10, var_1_10009(100, 100), nil, true)

	local var_113_11 = arg_113_0.markQuads

	ChapterConst = var_113_6

	local var_113_12 = var_113_11[var_113_6.MarkMovePathArrow]

	for iter_113_1 = #arg_113_1, 1, -1 do
		local var_113_13 = arg_113_1[iter_113_1]

		ChapterCell = var_113_14

		local var_113_14 = var_113_14.Line2MarkName
		local var_113_15 = var_113_13.row
		local var_113_16 = var_113_13.column

		ChapterConst = var_1_10013
		var_113_14 = var_113_14(var_113_15, var_113_16, var_1_10013.MarkMovePathArrow)

		if var_113_12 and var_113_12[var_113_14] then
			local var_113_17 = arg_113_1[iter_113_1 + 1]

			Vector3 = var_1_10013
			var_1_10013 = var_1_10013.Normalize
			Vector3 = var_1_10014
			var_1_10013 = var_1_10013(var_1_10014(var_113_17.column - var_113_13.column, var_113_13.row - var_113_17.row, 0))
			Vector3 = var_1_10014
			var_1_10014 = var_1_10014.Dot

			local var_113_18 = var_1_10013

			Vector3 = var_16
			var_1_10014 = var_1_10014(var_113_18, var_16.up)
			Mathf = var_113_18

			local var_113_19 = var_113_18.Acos(var_1_10014)

			Mathf = var_16

			local var_113_20 = var_113_19 * var_16.Rad2Deg

			Vector3 = var_16

			local var_113_21 = var_16.Cross

			Vector3 = var_17

			local var_113_22 = var_113_21(var_17.up, var_1_10013).z
			local var_113_23 = 0 < var_113_22 and 1 or -1

			Vector3 = var_18
			var_11.localEulerAngles = var_18(0, 0, var_113_20 * var_113_23)
		end
	end

	return
end

function var_0_1.ShowMissileAimingMarks(arg_114_0, arg_114_1)
	_ = var_1_10002

	var_1_10002.each(arg_114_1, function(arg_115_0)
		local var_115_0 = arg_114_0.loader

		var_1.GetPrefabBYGroup(var_115_0, "ui/miaozhun02", "miaozhun02", function(arg_116_0)
			setParent = var_3_10001

			var_3_10001(arg_116_0, arg_114_0.restrictMap)

			local var_116_0 = arg_114_0.contextData.chapterVO.theme
			local var_116_1 = var_2.GetLinePosition(var_116_0, arg_115_0.row, arg_115_0.column)
			local var_116_2 = arg_114_0.restrictMap.anchoredPosition

			tf = var_5

			local var_116_3 = var_5(arg_116_0)

			Vector2 = var_6
			var_116_3.anchoredPosition = var_6(var_116_1.x - var_116_2.x, var_116_1.y - var_116_2.y)

			return
		end, "MissileAimingMarks")

		return
	end)

	return
end

function var_0_1.HideMissileAimingMarks(arg_117_0)
	local var_117_0 = arg_117_0.loader

	var_1.ReturnGroup(var_117_0, "MissileAimingMarks")

	return
end

function var_0_1.ShowMissileAimingMark(arg_118_0, arg_118_1)
	local var_118_0 = arg_118_0.loader

	var_2.GetPrefab(var_118_0, "ui/miaozhun02", "miaozhun02", function(arg_119_0)
		setParent = var_2_10001

		var_2_10001(arg_119_0, arg_118_0.restrictMap)

		local var_119_0 = arg_118_0.contextData.chapterVO.theme
		local var_119_1 = var_2.GetLinePosition(var_119_0, arg_118_1.row, arg_118_1.column)
		local var_119_2 = arg_118_0.restrictMap.anchoredPosition

		tf = var_4

		local var_119_3 = var_4(arg_119_0)

		Vector2 = var_5
		var_119_3.anchoredPosition = var_5(var_119_1.x - var_119_2.x, var_119_1.y - var_119_2.y)

		return
	end, "MissileAimingMark")

	return
end

function var_0_1.HideMissileAimingMark(arg_120_0)
	local var_120_0 = arg_120_0.loader

	var_1.ClearRequest(var_120_0, "MissileAimingMark")

	return
end

function var_0_1.OnMissileAiming(arg_121_0, arg_121_1)
	arg_121_0:HideMissileAimingMark()
	arg_121_0:ShowMissileAimingMark(arg_121_1)

	arg_121_0.missileStrikeTargetLine = arg_121_1

	return
end

function var_0_1.ShowAirSupportAimingMark(arg_122_0, arg_122_1)
	local var_122_0 = arg_122_0.loader

	var_2.GetPrefab(var_122_0, "ui/miaozhun03", "miaozhun03", function(arg_123_0)
		setParent = var_2_10001

		var_2_10001(arg_123_0, arg_122_0.restrictMap)

		local var_123_0 = arg_122_0.contextData.chapterVO.theme
		local var_123_1 = var_2.GetLinePosition(var_123_0, arg_122_1.row - 0.5, arg_122_1.column)
		local var_123_2 = arg_122_0.restrictMap.anchoredPosition

		tf = var_4

		local var_123_3 = var_4(arg_123_0)

		Vector2 = var_5
		var_123_3.anchoredPosition = var_5(var_123_1.x - var_123_2.x, var_123_1.y - var_123_2.y)

		return
	end, "AirSupportAimingMark")

	return
end

function var_0_1.HideAirSupportAimingMark(arg_124_0)
	local var_124_0 = arg_124_0.loader

	var_1.ClearRequest(var_124_0, "AirSupportAimingMark")

	return
end

function var_0_1.OnAirSupportAiming(arg_125_0, arg_125_1)
	arg_125_0:HideAirSupportAimingMark()
	arg_125_0:ShowAirSupportAimingMark(arg_125_1)

	arg_125_0.missileStrikeTargetLine = arg_125_1

	return
end

function var_0_1.ShowAirExpelAimingMark(arg_126_0)
	if not arg_126_0.airSupportTarget or not var_1.source then
		return
	end

	local var_126_0 = var_1.source

	ChapterCell = var_1_10003

	local var_126_1 = var_1_10003.Line2Name(var_126_0.row, var_126_0.column)
	local var_126_2 = arg_126_0.cellRoot
	local var_126_3 = var_4.Find(var_126_2, var_126_1)

	local function var_126_4(arg_127_0, arg_127_1)
		setParent = var_2_10002

		var_2_10002(arg_127_0, var_126_3)

		GetOrAddComponent = var_2_10002

		local var_127_0 = arg_127_0

		typeof = var_4
		Canvas = var_2_10005
		var_2_10002(var_127_0, var_4(var_2_10005)).overrideSorting = true

		if not arg_127_1 then
			return
		end

		local var_127_1 = arg_126_0.contextData.chapterVO

		tf = var_4

		local var_127_2 = var_4(arg_127_0)

		Vector3 = var_5
		var_127_2.localEulerAngles = var_5(-var_127_1.theme.angle, 0, 0)

		return
	end

	local var_126_5 = arg_126_0.loader

	var_6.GetPrefabBYGroup(var_126_5, "leveluiview/tpl_airsupportmark", "tpl_airsupportmark", function(arg_128_0)
		var_126_4(arg_128_0, true)

		return
	end, "AirExpelAimingMark")

	local var_126_6 = arg_126_0.loader

	var_6.GetPrefabBYGroup(var_126_6, "leveluiview/tpl_airsupportdirection", "tpl_airsupportdirection", function(arg_129_0)
		var_126_4(arg_129_0)

		local var_129_0 = arg_126_0.contextData.chapterVO
		local var_129_1 = {
			{
				-1,
				0
			},
			{
				0,
				1
			},
			{
				1,
				0
			},
			{
				0,
				-1
			}
		}

		for iter_129_0 = 1, 4 do
			tf = var_2_10007

			local var_129_2 = var_2_10007(arg_129_0)

			var_2_10007 = var_2_10007.Find(var_129_2, iter_129_0)

			local var_129_3, var_129_4

			if var_0 then
				var_129_3 = var_129_0
				var_129_4 = var_129_0.considerAsStayPoint
				ChapterConst = var_2_10010
				var_129_4 = var_129_4(var_129_3, var_2_10010.SubjectChampion, var_126_0.row + var_129_1[iter_129_0][1], var_126_0.column + var_129_1[iter_129_0][2])
			end

			setActive = var_129_3

			var_129_3(var_2_10007, var_129_4)
		end

		return
	end, "AirExpelAimingMark")

	return
end

function var_0_1.HideAirExpelAimingMark(arg_130_0)
	local var_130_0 = arg_130_0.loader

	var_1.ReturnGroup(var_130_0, "AirExpelAimingMark")

	return
end

function var_0_1.OnAirExpelSelect(arg_131_0, arg_131_1)
	local var_131_0 = arg_131_0.contextData.chapterVO

	local function var_131_1()
		local var_132_0 = arg_131_0

		var_0.HideAirExpelAimingMark(var_132_0)

		local var_132_1 = arg_131_0

		var_0.ShowAirExpelAimingMark(var_132_1)

		local var_132_2 = arg_131_0

		var_0.updateQuadBase(var_132_2)

		local var_132_3 = arg_131_0

		var_0.UpdateQuadStateAirExpel(var_132_3)

		return
	end

	local var_131_2

	if not arg_131_0.airSupportTarget then
		var_131_2 = {}
	end

	arg_131_0.airSupportTarget = var_131_2

	local var_131_3 = arg_131_0.airSupportTarget
	local var_131_4 = var_131_0
	local var_131_12

	if var_131_0.GetEnemy(var_131_4, arg_131_1.row, arg_131_1.column) then
		ChapterConst = var_131_4

		if var_131_4.IsBossCell(var_131_14) then
			pg = var_6

			local var_131_5 = var_6.TipsMgr.GetInstance()
			local var_131_6 = var_6.ShowTips

			i18n = var_131_12

			var_131_6(var_131_5, var_131_12("levelscene_airexpel_select_boss"))

			return
		end

		local var_131_7 = var_131_0
		local var_131_8 = var_131_0.existFleet

		FleetType = var_131_12

		if var_131_8(var_131_7, var_131_12.Normal, arg_131_1.row, arg_131_1.column) then
			pg = var_6

			local var_131_9 = var_6.TipsMgr.GetInstance()
			local var_131_10 = var_6.ShowTips

			i18n = var_131_12

			var_131_10(var_131_9, var_131_12("levelscene_airexpel_select_battle"))

			return
		end

		local var_131_14

		if var_131_3.source then
			table = var_6

			local var_131_11 = var_6.equal

			var_131_12 = var_131_3.source

			local var_131_13 = var_7.GetLine(var_131_12)

			var_1_10009 = var_131_14

			if var_131_11(var_131_13, var_131_14.GetLine(var_1_10009)) then
				var_131_14 = nil
			end
		end

		var_131_3.source = var_131_14

		var_131_1()
	else
		local var_131_16

		if not var_131_3.source then
			pg = var_131_16

			local var_131_15 = var_131_16.TipsMgr.GetInstance()

			var_131_16 = var_131_16.ShowTips
			i18n = var_131_12

			var_131_16(var_131_15, var_131_12("levelscene_airexpel_select_enemy"))
		else
			ManhattonDist = var_131_16

			local var_131_17 = var_131_16(var_131_3.source, arg_131_1)

			if 1 < var_131_17 then
				pg = var_7

				local var_131_18 = var_7.TipsMgr.GetInstance()
				local var_131_19 = var_7.ShowTips

				i18n = var_1_10009

				var_131_19(var_131_18, var_1_10009("levelscene_airexpel_outrange"))
			else
				local var_131_20 = var_131_0
				local var_131_21 = var_131_0.considerAsStayPoint

				ChapterConst = var_1_10009

				if not var_131_21(var_131_20, var_1_10009.SubjectChampion, arg_131_1.row, arg_131_1.column) then
					pg = var_7

					local var_131_22 = var_7.TipsMgr.GetInstance()
					local var_131_23 = var_7.ShowTips

					i18n = var_9

					var_131_23(var_131_22, var_9("levelscene_airexpel_outrange"))
				else
					local var_131_24 = arg_131_0.airSupportTarget.source
					local var_131_25 = arg_131_1

					if not var_131_24 or not var_131_25 then
						return
					end

					local var_131_26 = {
						arg_131_1.row - var_131_24.row,
						arg_131_1.column - var_131_24.column
					}
					local var_131_27 = {
						"up",
						"right",
						"down",
						"left"
					}
					local var_131_28

					if var_131_26[1] ~= 0 then
						var_131_28 = var_131_26[1] + 2
					else
						var_131_28 = 3 - var_131_26[2]
					end

					local var_131_29 = var_131_27[var_131_28]
					local var_131_30 = var_131_0:getChapterSupportFleet()

					local function var_131_31()
						local var_133_0 = arg_131_0
						local var_133_1 = var_0.emit

						LevelMediator2 = var_2_10002

						local var_133_2 = var_2_10002.ON_OP
						local var_133_3 = {}

						ChapterConst = var_2_10004
						var_133_3.type = var_2_10004.OpStrategy
						var_133_3.id = var_131_30.id
						ChapterConst = var_4
						var_133_3.arg1 = var_4.StrategyExpel
						var_133_3.arg2 = var_131_24.row
						var_133_3.arg3 = var_131_24.column
						var_133_3.arg4 = var_131_25.row
						var_133_3.arg5 = var_131_25.column

						var_133_1(var_133_0, var_133_2, var_133_3)

						return
					end

					local var_131_32 = var_131_24.attachmentId

					pg = var_1_10017

					local var_131_33 = var_1_10017.expedition_data_template[var_131_32].name

					pg = var_1_10018

					local var_131_34 = var_1_10018.MsgboxMgr.GetInstance()
					local var_131_35 = var_18.ShowMsgBox
					local var_131_36 = {}

					i18n = var_1_10021
					var_131_36.content = var_1_10021("levelscene_airexpel_select_confirm_" .. var_131_29, var_131_33)
					var_131_36.onYes = var_131_31

					var_131_35(var_131_34, var_131_36)
				end
			end
		end
	end

	return
end

function var_0_1.CleanAirSupport(arg_134_0)
	arg_134_0.airSupportTarget = nil

	return
end

function var_0_1.startQuadTween(arg_135_0, arg_135_1, arg_135_2, arg_135_3, arg_135_4)
	if arg_135_0.presentTws[arg_135_1] then
		LeanTween = var_5

		var_5.cancel(arg_135_0.presentTws[arg_135_1].uniqueId)

		arg_135_0.presentTws[arg_135_1] = nil
	end

	if not arg_135_0.quadTws[arg_135_1] then
		arg_135_3 = arg_135_3 or 1

		if not arg_135_4 then
			ChapterConst = var_5
			arg_135_4 = var_5.CellEaseOutAlpha
		end

		setImageAlpha = var_5

		var_5(arg_135_2, arg_135_3)

		LeanTween = var_5

		local var_135_0 = var_5.alpha(arg_135_2, arg_135_4, 1)
		local var_135_1 = var_5.setLoopPingPong(var_135_0)

		arg_135_0.quadTws[arg_135_1] = {
			tw = var_135_1,
			uniqueId = var_135_1.uniqueId
		}
	end

	return
end

function var_0_1.cancelQuadTween(arg_136_0, arg_136_1, arg_136_2)
	local var_136_0

	if arg_136_0.quadTws[arg_136_1] then
		LeanTween = var_136_0

		var_136_0.cancel(arg_136_0.quadTws[arg_136_1].uniqueId)

		var_136_0 = arg_136_0.quadTws
		var_136_0[arg_136_1] = nil
	end

	setImageAlpha = var_136_0

	local var_136_1 = arg_136_2

	ChapterConst = var_1_10005

	var_136_0(var_136_1, var_1_10005.CellEaseOutAlpha)

	return
end

function var_0_1.killQuadTws(arg_137_0)
	pairs = var_1_10001

	for iter_137_0, iter_137_1 in var_1_10001(arg_137_0.quadTws) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_137_1.uniqueId)
	end

	arg_137_0.quadTws = {}

	return
end

function var_0_1.killPresentTws(arg_138_0)
	pairs = var_1_10001

	for iter_138_0, iter_138_1 in var_1_10001(arg_138_0.presentTws) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_138_1.uniqueId)
	end

	arg_138_0.presentTws = {}

	return
end

function var_0_1.startMarkTween(arg_139_0, arg_139_1, arg_139_2, arg_139_3, arg_139_4)
	if not arg_139_0.markTws[arg_139_1] then
		arg_139_3 = arg_139_3 or 1
		arg_139_4 = arg_139_4 or 0.2
		setImageAlpha = var_5

		var_5(arg_139_2, arg_139_3)

		LeanTween = var_5

		local var_139_0 = var_5.alpha(arg_139_2, arg_139_4, 0.7)
		local var_139_1 = var_5.setLoopPingPong(var_139_0)
		local var_139_2 = var_5.setEase

		LeanTweenType = var_7

		local var_139_3 = var_139_2(var_139_1, var_7.easeInOutSine)
		local var_139_4 = var_5.setDelay(var_139_3, 1)

		arg_139_0.markTws[arg_139_1] = {
			tw = var_139_4,
			uniqueId = var_139_4.uniqueId
		}
	end

	return
end

function var_0_1.cancelMarkTween(arg_140_0, arg_140_1, arg_140_2, arg_140_3)
	local var_140_0

	if arg_140_0.markTws[arg_140_1] then
		LeanTween = var_140_0

		var_140_0.cancel(arg_140_0.markTws[arg_140_1].uniqueId)

		var_140_0 = arg_140_0.markTws
		var_140_0[arg_140_1] = nil
	end

	setImageAlpha = var_140_0

	local var_140_1 = arg_140_2

	if not arg_140_3 then
		::label_140_0::

		ChapterConst = var_1_10006
		var_1_10006 = var_1_10006.CellEaseOutAlpha
	end

	var_140_0(var_140_1, var_1_10006)

	return
end

function var_0_1.moveFleet(arg_141_0, arg_141_1, arg_141_2, arg_141_3, arg_141_4)
	local var_141_0 = arg_141_0.contextData.chapterVO
	local var_141_1 = var_5.IsFogStage(var_141_0)
	local var_141_2 = var_5.fleet.id
	local var_141_3 = arg_141_0.cellFleets[var_141_2]

	var_9.SetSpineVisible(var_141_3, true)

	setActive = var_10

	var_10(var_9.tfShadow, true)

	setActive = var_10

	var_10(arg_141_0.arrowTarget, true)
	arg_141_0:updateTargetArrow(arg_141_2[#arg_141_2])

	if arg_141_3 then
		arg_141_0:updateAttachment(arg_141_3.row, arg_141_3.column)
	end

	local function var_141_4(arg_142_0)
		if var_141_1 then
			local var_142_0 = var_0
			local var_142_1 = var_1.UpdateCellsVisible(var_142_0, var_0, arg_142_0)
			local var_142_2 = arg_141_0

			var_2.UpdateWeatherCells(var_142_2, var_142_1)
		end

		return
	end

	local function var_141_5(arg_143_0)
		var_0.step = var_0.step + 1

		var_141_4(arg_143_0)

		existCall = var_1

		var_1(arg_141_0.onShipStepChange, arg_143_0)

		return
	end

	local function var_141_6(arg_144_0)
		return
	end

	local function var_141_7()
		setActive = var_2_10000

		var_2_10000(arg_141_0.arrowTarget, false)

		local var_145_0 = var_0.fleet.line
		local var_145_1 = var_0
		local var_145_2 = var_1.getChapterCell(var_145_1, var_145_0.row, var_145_0.column)

		ChapterConst = var_145_1

		if var_145_1.NeedClearStep(var_145_2) then
			var_0.step = 0
		end

		local var_145_3 = var_0
		local var_145_4 = var_0

		var_145_3.rotation = var_3.GetRotatePivot(var_145_4).transform.localRotation

		local var_145_5 = arg_141_0

		var_2.updateAttachment(var_145_5, var_145_0.row, var_145_0.column)

		local var_145_6 = arg_141_0

		var_2.updateFleet(var_145_6, var_141_2)

		local var_145_7 = arg_141_0

		var_2.updateOni(var_145_7)

		local var_145_8 = var_0

		if var_2.getChampionIndex(var_145_8, var_145_0.row, var_145_0.column) then
			local var_145_9 = arg_141_0

			var_3.updateChampion(var_145_9, var_2)
		end

		if arg_141_0.onShipArrived then
			arg_141_0.onShipArrived()
		end

		if arg_141_4 then
			arg_141_4()
		end

		return
	end

	local var_141_8 = arg_141_0
	local var_141_9 = arg_141_0.updateQuadCells

	ChapterConst = var_1_10016

	var_141_9(var_141_8, var_1_10016.QuadStateFrozen)
	var_141_4(var_9:GetLine())
	arg_141_0:moveCellView(var_9, arg_141_1, arg_141_2, var_141_5, var_141_6, var_141_7)

	return
end

function var_0_1.moveSub(arg_146_0, arg_146_1, arg_146_2, arg_146_3, arg_146_4)
	local var_146_0 = arg_146_0.contextData.chapterVO.fleets[arg_146_1]
	local var_146_1 = arg_146_0.cellFleets[var_146_0.id]
	local var_146_2 = arg_146_2[#arg_146_2]

	local function var_146_3(arg_147_0)
		return
	end

	local function var_146_4(arg_148_0)
		return
	end

	local function var_146_5()
		local var_149_0 = var_0
		local var_149_1 = var_0.existEnemy

		ChapterConst = var_2_10002

		local var_149_3

		if not var_149_1(var_149_0, var_2_10002.SubjectPlayer, var_146_2.row, var_146_2.column) then
			local var_149_2 = var_0

			var_149_3 = var_0.existAlly(var_149_2, var_146_0)
		end

		local var_149_4 = var_0.subAutoAttack == 1
		local var_149_5 = var_146_1

		var_2.SetActiveModel(var_149_5, not var_149_3 and var_149_4)

		local var_149_6 = var_146_0
		local var_149_7 = var_146_1

		var_149_6.rotation = var_3.GetRotatePivot(var_149_7).transform.localRotation

		if arg_146_4 then
			arg_146_4()
		end

		return
	end

	local var_146_6 = arg_146_0
	local var_146_7 = arg_146_0.updateQuadCells

	ChapterConst = var_1_10014

	var_146_7(var_146_6, var_1_10014.QuadStateFrozen)
	arg_146_0:teleportSubView(var_146_1, var_146_1:GetLine(), var_146_2, var_146_3, var_146_4, var_146_5)

	return
end

function var_0_1.moveChampion(arg_150_0, arg_150_1, arg_150_2, arg_150_3, arg_150_4)
	local var_150_0 = arg_150_0.contextData.chapterVO.champions[arg_150_1]
	local var_150_1 = arg_150_0.cellChampions[arg_150_1]

	local function var_150_2(arg_151_0)
		return
	end

	local function var_150_3(arg_152_0)
		return
	end

	local function var_150_4()
		if var_150_1.GetRotatePivot then
			local var_153_0 = var_150_0
			local var_153_1 = var_150_1

			var_153_0.rotation = var_1.GetRotatePivot(var_153_1).transform.localRotation
		end

		if arg_150_4 then
			arg_150_4()
		end

		return
	end

	if var_5:getChampionVisibility(var_150_0) then
		arg_150_0:moveCellView(var_150_1, arg_150_2, arg_150_3, var_150_2, var_150_3, var_150_4)
	else
		local var_150_5 = arg_150_2[#arg_150_2]

		var_150_1:RefreshLinePosition(var_5, var_150_5)
		var_150_4()
	end

	return
end

function var_0_1.moveTransport(arg_154_0, arg_154_1, arg_154_2, arg_154_3, arg_154_4)
	local var_154_0 = arg_154_0.contextData.chapterVO.fleets[arg_154_1]
	local var_154_1 = arg_154_0.cellFleets[var_154_0.id]

	local function var_154_2(arg_155_0)
		return
	end

	local function var_154_3(arg_156_0)
		return
	end

	local function var_154_4()
		local var_157_0 = var_154_0
		local var_157_1 = var_154_1

		var_157_0.rotation = var_1.GetRotatePivot(var_157_1).transform.localRotation

		local var_157_2 = arg_154_0

		var_0.updateFleet(var_157_2, var_154_0.id)

		existCall = var_0

		var_0(arg_154_4)

		return
	end

	local var_154_5 = arg_154_0
	local var_154_6 = arg_154_0.updateQuadCells

	ChapterConst = var_1_10013

	var_154_6(var_154_5, var_1_10013.QuadStateFrozen)
	arg_154_0:moveCellView(var_154_1, arg_154_2, arg_154_3, var_154_2, var_154_3, var_154_4)

	return
end

function var_0_1.moveCellView(arg_158_0, arg_158_1, arg_158_2, arg_158_3, arg_158_4, arg_158_5, arg_158_6)
	local var_158_0 = arg_158_0.contextData.chapterVO
	local var_158_1

	local function var_158_2()
		if var_158_1 then
			coroutine = var_0

			if var_0.status(var_158_1) == "suspended" then
				coroutine = var_0

				local var_159_0, var_159_1 = var_0.resume(var_158_1)

				assert = var_2_10002

				local var_159_2 = var_159_0

				debug = var_2_10004

				var_2_10002(var_159_2, var_2_10004.traceback(var_158_1, var_159_1))
			end
		end

		return
	end

	coroutine = var_1_10010
	var_158_1 = var_1_10010.create(function()
		local var_160_0 = arg_158_0

		var_0.frozen(var_160_0)

		local var_160_1 = var_158_0

		if var_0.GetQuickPlayFlag(var_160_1) then
			ChapterConst = var_0

			local var_160_2

			if not var_0.ShipStepQuickPlayScale then
				var_160_2 = 1
			end

			local var_160_3 = 0.3 * var_160_2

			ChapterConst = var_2_10002

			local var_160_4 = var_2_10002.ShipStepDuration

			ChapterConst = var_2_10003

			local var_160_5 = var_160_4 * var_2_10003.ShipMoveTailLength * var_160_2
			local var_160_6 = 0.1 * var_160_2
			local var_160_7 = 0

			table = var_2_10005

			local var_160_8 = var_2_10005.insert
			local var_160_9 = arg_158_3
			local var_160_10 = 1
			local var_160_11 = arg_158_1

			var_160_8(var_160_9, var_160_10, var_8.GetLine(var_160_11))

			_ = var_160_8

			var_160_8.each(arg_158_3, function(arg_161_0)
				local var_161_0 = var_158_0
				local var_161_1 = var_1.getChapterCell(var_161_0, arg_161_0.row, arg_161_0.column)

				ChapterConst = var_161_0

				if var_161_0.NeedEasePathCell(var_161_1) then
					ChapterCell = var_2

					local var_161_2 = var_2.Line2QuadName(var_161_1.row, var_161_1.column)
					local var_161_3 = arg_158_0.quadRoot
					local var_161_4 = var_3.Find(var_161_3, var_161_2)
					local var_161_5 = arg_158_0

					var_4.cancelQuadTween(var_161_5, var_161_2, var_161_4)

					LeanTween = var_4

					local var_161_6 = var_4.alpha(var_161_4, 1, var_160_3)

					var_4.setDelay(var_161_6, var_160_7)

					var_160_7 = var_160_7 + var_160_6
				end

				return
			end)

			_ = var_5

			var_5.each(arg_158_2, function(arg_162_0)
				local var_162_0 = arg_158_0

				var_1.moveStep(var_162_0, arg_158_1, arg_162_0, arg_158_3[#arg_158_3], function()
					local var_163_0 = arg_158_1
					local var_163_1 = var_0.GetLine(var_163_0)
					local var_163_2 = var_158_0
					local var_163_3 = var_1.getChapterCell(var_163_2, var_163_1.row, var_163_1.column)

					ChapterConst = var_163_2

					if var_163_2.NeedEasePathCell(var_163_3) then
						ChapterCell = var_2

						local var_163_4 = var_2.Line2QuadName(var_163_3.row, var_163_3.column)
						local var_163_5 = arg_158_0.quadRoot
						local var_163_6 = var_3.Find(var_163_5, var_163_4)

						LeanTween = var_163_5

						local var_163_7 = var_163_5.scale
						local var_163_8 = var_163_6

						Vector3 = var_4_10006

						var_163_7(var_163_8, var_4_10006.zero, var_160_5)
					end

					arg_158_4(arg_162_0)

					local var_163_9 = arg_158_1

					var_2.SetLine(var_163_9, arg_162_0)

					local var_163_10 = arg_158_1

					var_2.ResetCanvasOrder(var_163_10)

					return
				end, function()
					arg_158_5(arg_162_0)
					var_158_2()

					return
				end)

				coroutine = var_1

				var_1.yield()

				return
			end)

			_ = var_5

			var_5.each(arg_158_3, function(arg_165_0)
				local var_165_0 = var_158_0
				local var_165_1 = var_1.getChapterCell(var_165_0, arg_165_0.row, arg_165_0.column)

				ChapterConst = var_165_0

				if var_165_0.NeedEasePathCell(var_165_1) then
					ChapterCell = var_2

					local var_165_2 = var_2.Line2QuadName(var_165_1.row, var_165_1.column)
					local var_165_3 = arg_158_0.quadRoot
					local var_165_4 = var_3.Find(var_165_3, var_165_2)

					LeanTween = var_165_3

					var_165_3.cancel(var_165_4.gameObject)

					setImageAlpha = var_4

					local var_165_5 = var_165_4

					ChapterConst = var_3_10006

					var_4(var_165_5, var_3_10006.CellEaseOutAlpha)

					Vector3 = var_4
					var_165_4.localScale = var_4.one
				end

				return
			end)

			if arg_158_0.exited then
				return
			end

			if arg_158_1.GetAction then
				local var_160_12 = arg_158_1
				local var_160_13 = var_5.SetAction

				ChapterConst = var_7

				var_160_13(var_160_12, var_7.ShipIdleAction)
			end

			arg_158_6()

			local var_160_14 = arg_158_0

			var_5.unfrozen(var_160_14)

			return
		end
	end)

	var_158_2()

	return
end

function var_0_1.moveStep(arg_166_0, arg_166_1, arg_166_2, arg_166_3, arg_166_4, arg_166_5)
	local var_166_0 = arg_166_0.contextData.chapterVO

	if var_6.GetQuickPlayFlag(var_166_0) then
		ChapterConst = var_7

		local var_166_1

		if not var_7.ShipStepQuickPlayScale then
			var_166_1 = 1
		end

		local var_166_2

		if arg_166_1.GetRotatePivot then
			var_166_2 = arg_166_1:GetRotatePivot()
		end

		local var_166_3 = arg_166_1:GetLine()
		local var_166_5

		if arg_166_1.GetAction then
			local var_166_4 = arg_166_1

			var_166_5 = arg_166_1.SetAction
			ChapterConst = var_1_10012

			var_166_5(var_166_4, var_1_10012.ShipMoveAction)
		end

		IsNil = var_166_5

		if not var_166_5(var_166_2) and (arg_166_2.column ~= var_166_3.column or arg_166_3.column ~= var_166_3.column) then
			tf = var_10

			local var_166_6 = var_10(var_166_2)

			Quaternion = var_11
			var_166_6.localRotation = var_11.identity

			if arg_166_2.column < var_166_3.column or arg_166_2.column == var_166_3.column and arg_166_3.column < var_166_3.column then
				tf = var_10

				local var_166_7 = var_10(var_166_2)

				Quaternion = var_11
				var_166_7.localRotation = var_11.Euler(0, 180, 0)
			end
		end

		local var_166_8 = arg_166_1.tf.localPosition
		local var_166_9 = var_6.theme
		local var_166_10 = var_11.GetLinePosition(var_166_9, arg_166_2.row, arg_166_2.column)
		local var_166_11 = 0

		LeanTween = var_13

		local var_166_12 = var_13.value
		local var_166_13 = arg_166_1.go
		local var_166_14 = 0
		local var_166_15 = 1

		ChapterConst = var_1_10017

		local var_166_16 = var_166_12(var_166_13, var_166_14, var_166_15, var_1_10017.ShipStepDuration * var_166_1)
		local var_166_17 = var_13.setOnComplete

		System = var_166_14

		local var_166_18 = var_166_17(var_166_16, var_166_14.Action(arg_166_5))
		local var_166_19 = var_13.setOnUpdate

		System = var_15

		var_166_19(var_166_18, var_15.Action_float(function(arg_167_0)
			local var_167_0 = arg_166_1.tf

			Vector3 = var_2_10002
			var_167_0.localPosition = var_2_10002.Lerp(var_166_8, var_166_10, arg_167_0)

			if var_166_11 <= 0.5 and arg_167_0 > 0.5 then
				arg_166_4()
			end

			var_166_11 = arg_167_0

			return
		end))

		return
	end
end

function var_0_1.teleportSubView(arg_168_0, arg_168_1, arg_168_2, arg_168_3, arg_168_4, arg_168_5, arg_168_6)
	local var_168_0 = arg_168_0.contextData.chapterVO

	local function var_168_1()
		arg_168_4(arg_168_3)

		local var_169_0 = arg_168_1

		var_0.RefreshLinePosition(var_169_0, var_168_0, arg_168_3)
		arg_168_5(arg_168_3)

		local var_169_1 = arg_168_0

		var_0.PlaySubAnimation(var_169_1, arg_168_1, false, arg_168_6)

		return
	end

	arg_168_0:PlaySubAnimation(arg_168_1, true, var_168_1)

	return
end

function var_0_1.CellToScreen(arg_170_0, arg_170_1, arg_170_2)
	local var_170_0 = arg_170_0._tf
	local var_170_1 = var_3.Find

	ChapterConst = var_1_10005

	local var_170_2 = var_170_1(var_170_0, var_1_10005.PlaneName .. "/cells")

	assert = var_170_0

	var_170_0(var_170_2, "plane not exist.")

	local var_170_3 = arg_170_0.contextData.chapterVO.theme
	local var_170_4 = var_5.GetLinePosition(var_170_3, arg_170_1, arg_170_2).y

	math = var_8

	local var_170_5 = var_8.cos

	math = var_9
	var_6.y = var_170_4 * var_170_5(var_9.pi / 180 * var_5.angle)
	math = var_8

	local var_170_6 = var_8.sin

	math = var_9
	var_6.z = var_170_4 * var_170_6(var_9.pi / 180 * var_5.angle)

	local var_170_7 = arg_170_0.levelCam.transform
	local var_170_8 = var_8.GetChild(var_170_7, 0)
	local var_170_9 = var_170_2.transform.lossyScale.x
	local var_170_10 = var_170_2.position + var_6 * var_170_9
	local var_170_11 = arg_170_0.levelCam
	local var_170_12 = var_11.WorldToViewportPoint(var_170_11, var_170_10)

	Vector3 = var_170_11

	return var_170_11(var_170_8.rect.width * (var_170_12.x - 0.5), var_170_8.rect.height * (var_170_12.y - 0.5))
end

local var_0_5 = {
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	},
	{
		0,
		1
	}
}
local var_0_6 = {
	{
		1,
		1
	},
	{
		1,
		-1
	},
	{
		-1,
		-1
	},
	{
		-1,
		1
	}
}

function var_0_1.AddCellEdge(arg_171_0, arg_171_1, arg_171_2, ...)
	local var_171_0 = 0
	local var_171_1 = 1

	for iter_171_0 = 1, 4 do
		_ = var_1_10009

		if not var_1_10009.any(arg_171_1, function(arg_172_0)
			return arg_172_0.row == arg_171_2.row + var_0_5[iter_171_0][1] and arg_172_0.column == arg_171_2.column + var_0_5[iter_171_0][2]
		end) then
			bit = var_1_10009
			var_171_0 = var_1_10009.bor(var_171_0, var_171_1)
		end

		var_171_1 = var_171_1 * 2
	end

	if var_171_0 == 0 then
		return
	end

	arg_171_0:CreateEdge(var_171_0, arg_171_2, ...)

	return
end

function var_0_1.AddOutlines(arg_173_0, arg_173_1, arg_173_2, arg_173_3, arg_173_4, arg_173_5)
	local var_173_0 = {}
	local var_173_1 = {}

	ipairs = var_1_10008

	for iter_173_0, iter_173_1 in var_1_10008(arg_173_1) do
		for iter_173_2 = 1, 4 do
			underscore = var_1_10017

			if not var_1_10017.any(arg_173_1, function(arg_174_0)
				return arg_174_0.row == iter_173_1.row + var_0_5[iter_173_2][1] and arg_174_0.column == iter_173_1.column + var_0_5[iter_173_2][2]
			end) then
				var_1_10017 = 2 * iter_173_1.row + var_0_5[iter_173_2][1]

				local var_173_2 = 2 * iter_173_1.column + var_0_5[iter_173_2][2]

				assert = var_19

				var_19(not var_173_0[var_1_10017 .. "_" .. var_173_2], "Multiple outline")

				var_173_0[var_1_10017 .. "_" .. var_173_2] = {
					row = var_1_10017,
					column = var_173_2,
					normal = iter_173_2
				}
			end

			underscore = var_1_10017

			if not var_1_10017.any(arg_173_1, function(arg_175_0)
				return arg_175_0.row == iter_173_1.row + var_0_6[iter_173_2][1] and arg_175_0.column == iter_173_1.column + var_0_6[iter_173_2][2]
			end) then
				underscore = var_1_10017

				if var_1_10017.any(arg_173_1, function(arg_176_0)
					return arg_176_0.row == iter_173_1.row and arg_176_0.column == iter_173_1.column + var_0_6[iter_173_2][2]
				end) then
					underscore = var_1_10017

					if var_1_10017.any(arg_173_1, function(arg_177_0)
						return arg_177_0.row == iter_173_1.row + var_0_6[iter_173_2][1] and arg_177_0.column == iter_173_1.column
					end) then
						var_173_1[iter_173_1.row .. "_" .. iter_173_1.column .. "_" .. iter_173_2] = {
							row = iter_173_1.row,
							column = iter_173_1.column,
							corner = iter_173_2
						}
					end
				end
			end
		end
	end

	arg_173_0:CreateOutlines(var_173_0, arg_173_2, arg_173_3, arg_173_4, arg_173_5)
	arg_173_0:CreateOutlineCorners(var_173_1, arg_173_2, arg_173_3, arg_173_4, arg_173_5 .. "_corner")

	return
end

function var_0_1.isHuntingRangeVisible(arg_178_0)
	return arg_178_0.contextData.huntingRangeVisibility % 2 == 0
end

function var_0_1.toggleHuntingRange(arg_179_0)
	local var_179_0 = arg_179_0
	local var_179_1 = arg_179_0.hideQuadMark

	ChapterConst = var_1_10003

	var_179_1(var_179_0, var_1_10003.MarkHuntingRange)
	arg_179_0:ClearEdges("SubmarineHunting")

	if not arg_179_0:isHuntingRangeVisible() then
		arg_179_0:ShowHuntingRange()
	end

	arg_179_0.contextData.huntingRangeVisibility = 1 - arg_179_0.contextData.huntingRangeVisibility

	arg_179_0:updateAttachments()
	arg_179_0:updateChampions()

	return
end

function var_0_1.ShowHuntingRange(arg_180_0)
	local var_180_0 = arg_180_0.contextData.chapterVO

	if not var_1.GetSubmarineFleet(var_180_0) then
		return
	end

	local var_180_1 = var_2
	local var_180_2 = var_2.getHuntingRange(var_180_1)

	_ = var_180_1

	local var_180_3 = var_180_1.filter(var_180_2, function(arg_181_0)
		local var_181_0 = var_0
		local var_181_1

		var_181_1 = var_1.getChapterCell(var_181_0, arg_181_0.row, arg_181_0.column) and var_1:IsWalkable()

		return var_181_1
	end)

	arg_180_0:RefreshHuntingRange(var_180_3, false)

	return
end

function var_0_1.RefreshHuntingRange(arg_182_0, arg_182_1, arg_182_2)
	local var_182_0 = arg_182_0
	local var_182_1 = arg_182_0.showQuadMark
	local var_182_2 = arg_182_1

	ChapterConst = var_1_10006

	local var_182_3 = var_1_10006.MarkHuntingRange
	local var_182_4 = "cell_hunting_range"

	Vector2 = var_1_10008

	var_182_1(var_182_0, var_182_2, var_182_3, var_182_4, var_1_10008(100, 100), arg_182_0.material_Add, arg_182_2)

	_ = var_182_1

	var_182_1.each(arg_182_1, function(arg_183_0)
		local var_183_0 = arg_182_0

		var_1.AddCellEdge(var_183_0, arg_182_1, arg_183_0, not arg_182_2, nil, nil, "SubmarineHunting")

		return
	end)

	return
end

function var_0_1.ShowStaticHuntingRange(arg_184_0)
	local var_184_0 = arg_184_0
	local var_184_1 = arg_184_0.hideQuadMark

	ChapterConst = var_1_10003

	var_184_1(var_184_0, var_1_10003.MarkHuntingRange)
	arg_184_0:ClearEdges("SubmarineHunting")

	local var_184_2 = arg_184_0.contextData.chapterVO
	local var_184_3 = var_1.GetSubmarineFleet(var_184_2)

	if not arg_184_0:isHuntingRangeVisible() then
		arg_184_0.contextData.huntingRangeVisibility = arg_184_0.contextData.huntingRangeVisibility + 1
	end

	local var_184_4 = var_184_3
	local var_184_5 = var_184_3.getHuntingRange(var_184_4)

	_ = var_184_4

	local var_184_6 = var_184_4.filter(var_184_5, function(arg_185_0)
		local var_185_0 = var_0
		local var_185_1

		var_185_1 = var_1.getChapterCell(var_185_0, arg_185_0.row, arg_185_0.column) and var_1:IsWalkable()

		return var_185_1
	end)

	arg_184_0:RefreshHuntingRange(var_184_6, true)

	return
end

function var_0_1.ShowTargetHuntingRange(arg_186_0, arg_186_1)
	local var_186_0 = arg_186_0
	local var_186_1 = arg_186_0.hideQuadMark

	ChapterConst = var_1_10004

	var_186_1(var_186_0, var_1_10004.MarkHuntingRange)
	arg_186_0:ClearEdges("SubmarineHunting")

	local var_186_2 = arg_186_0.contextData.chapterVO
	local var_186_3 = var_2.GetSubmarineFleet(var_186_2)
	local var_186_4 = var_3.getHuntingRange(var_186_3, arg_186_1)

	_ = var_186_3

	local var_186_5 = var_186_3.filter(var_186_4, function(arg_187_0)
		local var_187_0 = var_0
		local var_187_1

		var_187_1 = var_1.getChapterCell(var_187_0, arg_187_0.row, arg_187_0.column) and var_1:IsWalkable()

		return var_187_1
	end)
	local var_186_6 = var_3
	local var_186_7 = var_3.getHuntingRange(var_186_6)

	_ = var_186_6

	local var_186_8 = var_186_6.filter(var_186_7, function(arg_188_0)
		local var_188_0 = var_0
		local var_188_1

		var_188_1 = var_1.getChapterCell(var_188_0, arg_188_0.row, arg_188_0.column) and var_1:IsWalkable()

		return var_188_1
	end)
	local var_186_9 = {}

	pairs = var_7

	for iter_186_0, iter_186_1 in var_7(var_186_8) do
		table = var_1_10012

		if not var_1_10012.containsData(var_186_5, iter_186_1) then
			table = var_1_10012

			var_1_10012.insert(var_186_9, iter_186_1)
		end
	end

	arg_186_0:RefreshHuntingRange(var_186_9, true)
	arg_186_0:RefreshHuntingRange(var_186_5, false)
	arg_186_0:updateAttachments()
	arg_186_0:updateChampions()

	return
end

function var_0_1.OnChangeSubAutoAttack(arg_189_0)
	local var_189_0 = arg_189_0.contextData.chapterVO

	if not var_1.GetSubmarineFleet(var_189_0) then
		return
	end

	if not arg_189_0.cellFleets[var_2.id] then
		return
	end

	local var_189_1 = var_1.subAutoAttack == 1

	var_3:SetActiveModel(not var_189_1)
	arg_189_0:PlaySubAnimation(var_3, not var_189_1, function()
		local var_190_0 = arg_189_0

		var_0.updateFleet(var_190_0, var_0.id)

		return
	end)

	return
end

function var_0_1.displayEscapeGrid(arg_191_0)
	local var_191_0 = arg_191_0.contextData.chapterVO

	if not var_1.existOni(var_191_0) then
		return
	end

	local var_191_1 = var_1:getOniChapterInfo()
	local var_191_2 = arg_191_0
	local var_191_3 = arg_191_0.hideQuadMark

	ChapterConst = var_1_10005

	var_191_3(var_191_2, var_1_10005.MarkEscapeGrid)

	local var_191_4 = arg_191_0
	local var_191_5 = arg_191_0.showQuadMark

	_ = var_5

	local var_191_6 = var_5.map(var_191_1.escape_grids, function(arg_192_0)
		return {
			row = arg_192_0[1],
			column = arg_192_0[2]
		}
	end)

	ChapterConst = var_6

	local var_191_7 = var_6.MarkEscapeGrid
	local var_191_8 = "cell_escape_grid"

	Vector2 = var_1_10008

	var_191_5(var_191_4, var_191_6, var_191_7, var_191_8, var_1_10008(105, 105))

	return
end

function var_0_1.showQuadMark(arg_193_0, arg_193_1, arg_193_2, arg_193_3, arg_193_4, arg_193_5, arg_193_6)
	arg_193_0:ShowAnyQuadMark(arg_193_1, arg_193_2, arg_193_3, arg_193_4, arg_193_5, false, arg_193_6)

	return
end

function var_0_1.ShowTopQuadMark(arg_194_0, arg_194_1, arg_194_2, arg_194_3, arg_194_4, arg_194_5, arg_194_6)
	arg_194_0:ShowAnyQuadMark(arg_194_1, arg_194_2, arg_194_3, arg_194_4, arg_194_5, true, arg_194_6)

	return
end

function var_0_1.ShowAnyQuadMark(arg_195_0, arg_195_1, arg_195_2, arg_195_3, arg_195_4, arg_195_5, arg_195_6, arg_195_7)
	local var_195_0 = arg_195_0.contextData.chapterVO

	pairs = var_1_10009

	for iter_195_0, iter_195_1 in var_1_10009(arg_195_1) do
		if var_195_0:getChapterCell(iter_195_1.row, iter_195_1.column) and var_14:IsWalkable() then
			ChapterCell = var_15

			local var_195_1 = var_15.Line2MarkName(iter_195_1.row, iter_195_1.column, arg_195_2)
			local var_195_2 = arg_195_0.markQuads
			local var_195_3

			if not arg_195_0.markQuads[arg_195_2] then
				var_195_3 = {}
			end

			var_195_2[arg_195_2] = var_195_3

			if not arg_195_0.markQuads[arg_195_2][var_195_1] then
				PoolMgr = var_195_3

				local var_195_4 = var_195_3.GetInstance()

				var_17.GetPrefab(var_195_4, "chapter/cell_quad_mark", "", false, function(arg_196_0)
					var_0 = arg_196_0.transform
					arg_195_0.markQuads[arg_195_2][var_195_1] = var_0

					return
				end)
			else
				arg_195_0:cancelMarkTween(var_195_1, var_16, 1)
			end

			var_16.name = var_195_1

			local var_195_5 = var_16
			local var_195_6 = var_16.SetParent
			local var_195_7

			if not arg_195_6 or not arg_195_0.topMarkRoot then
				var_195_7 = arg_195_0.bottomMarkRoot
			end

			var_195_6(var_195_5, var_195_7, false)

			var_16.sizeDelta = var_195_0.theme.cellSize

			local var_195_8 = var_195_0.theme

			var_16.anchoredPosition = var_17.GetLinePosition(var_195_8, iter_195_1.row, iter_195_1.column)
			Vector3 = var_17
			var_16.localScale = var_17.one

			var_16:SetAsLastSibling()

			local var_195_9 = var_16
			local var_195_10 = var_16.GetComponent

			typeof = var_19
			Image = var_20

			local var_195_11 = var_195_10(var_195_9, var_19(var_20))

			GetSpriteFromAtlas = var_195_9
			var_195_11.sprite = var_195_9("chapter/pic/cellgrid", arg_195_3)
			var_195_11.material = arg_195_5
			var_16.sizeDelta = arg_195_4

			if not arg_195_7 then
				arg_195_0:startMarkTween(var_195_1, var_16)
			else
				arg_195_0:cancelMarkTween(var_195_1, var_16, 1)
			end
		end
	end

	return
end

function var_0_1.hideQuadMark(arg_197_0, arg_197_1)
	if arg_197_1 and not arg_197_0.markQuads[arg_197_1] then
		return
	end

	pairs = var_1_10002

	for iter_197_0, iter_197_1 in var_1_10002(arg_197_0.markQuads) do
		if not arg_197_1 or iter_197_0 == arg_197_1 then
			pairs = var_1_10007

			for iter_197_2, iter_197_3 in var_1_10007(iter_197_1) do
				arg_197_0:cancelMarkTween(iter_197_2, iter_197_3)

				local var_197_0 = iter_197_1[iter_197_2]
				local var_197_1 = var_12.GetComponent

				typeof = var_14
				Image = var_15
				var_197_1(var_197_0, var_14(var_15)).material = nil
				iter_197_1[iter_197_2] = nil
				PoolMgr = var_12

				local var_197_2 = var_12.GetInstance()

				var_12.ReturnPrefab(var_197_2, "chapter/cell_quad_mark", "", iter_197_3.gameObject)
			end

			table = var_1_10007

			var_1_10007.clear(arg_197_0.markQuads[iter_197_0])
		end
	end

	return
end

function var_0_1.CreateEdgeIndex(arg_198_0, arg_198_1, arg_198_2, arg_198_3)
	ChapterCell = var_1_10004

	local var_198_0 = var_1_10004.Line2Name(arg_198_0, arg_198_1)
	local var_198_1

	if not arg_198_3 or not ("_" .. arg_198_3) then
		var_198_1 = ""
	end

	return var_198_0 .. var_198_1 .. "_" .. arg_198_2
end

function var_0_1.CreateEdge(arg_199_0, arg_199_1, arg_199_2, arg_199_3, arg_199_4, arg_199_5, arg_199_6)
	if arg_199_1 <= 0 or arg_199_1 >= 16 then
		return
	end

	local var_199_0 = arg_199_0:GetEdgePool(arg_199_6)
	local var_199_1 = arg_199_0.contextData.chapterVO.theme
	local var_199_2 = var_9.GetLinePosition(var_199_1, arg_199_2.row, arg_199_2.column)
	local var_199_3 = var_8.theme.cellSize

	assert = var_11

	var_11(arg_199_6, "Missing key, Please PM Programmer")

	local var_199_4 = 1
	local var_199_5 = 0

	while var_199_5 < 4 do
		var_199_5 = var_199_5 + 1
		bit = var_199_6

		local var_199_6

		if var_199_6.band(arg_199_1, var_199_4) > 0 then
			var_199_6 = arg_199_0.CreateEdgeIndex(arg_199_2.row, arg_199_2.column, var_199_5, arg_199_6)

			local var_199_7 = arg_199_0.cellEdges
			local var_199_8

			if not arg_199_0.cellEdges[arg_199_6] then
				var_199_8 = {}
			end

			var_199_7[arg_199_6] = var_199_8

			local var_199_9 = arg_199_0.cellEdges[arg_199_6]
			local var_199_10

			if not arg_199_0.cellEdges[arg_199_6][var_199_6] then
				tf = var_199_10
				var_199_10 = var_199_10(var_199_0:Dequeue())
			end

			var_199_9[var_199_6] = var_199_10

			local var_199_11 = arg_199_0.cellEdges[arg_199_6][var_199_6]

			var_199_11.name = var_199_6

			var_199_11:SetParent(arg_199_0.bottomMarkRoot, false)

			arg_199_4 = arg_199_4 or 0
			arg_199_5 = arg_199_5 or 3
			bit = var_15

			local var_199_12

			if not (var_15.band(var_199_5, 1) == 1) or not (var_199_3.x - arg_199_4 * 2) then
				var_199_12 = var_199_3.y - arg_199_4 * 2
			end

			local var_199_13 = arg_199_5

			Vector2 = var_18
			var_199_11.sizeDelta = var_18.New(var_199_12, var_199_13)
			Vector2 = var_18
			var_199_11.pivot = var_18.New(0.5, 0)
			math = var_18

			local var_199_14 = var_18.pi * 0.5 * -var_199_5

			math = var_19

			local var_199_15 = var_19.cos(var_199_14) * (var_199_3.x * 0.5 - arg_199_4)

			math = var_20

			local var_199_16 = var_20.sin(var_199_14) * (var_199_3.y * 0.5 - arg_199_4)

			Vector2 = var_21
			var_199_11.anchoredPosition = var_21.New(var_199_15 + var_199_2.x, var_199_16 + var_199_2.y)
			Quaternion = var_21
			var_199_11.localRotation = var_21.Euler(0, 0, (5 - var_199_5) * 90)

			if arg_199_3 then
				arg_199_0:startMarkTween(var_199_6, var_199_11)
			else
				arg_199_0:cancelMarkTween(var_199_6, var_199_11, 1)
			end
		end

		var_199_4 = var_199_4 * 2
	end

	return
end

function var_0_1.ClearEdge(arg_200_0, arg_200_1)
	pairs = var_1_10002

	for iter_200_0, iter_200_1 in var_1_10002(arg_200_0.cellEdges) do
		for iter_200_2 = 1, 4 do
			if iter_200_1[arg_200_0.CreateEdgeIndex(arg_200_1.row, arg_200_1.column, iter_200_2, iter_200_0)] then
				local var_200_0 = arg_200_0
				local var_200_1 = arg_200_0.GetEdgePool(var_200_0, iter_200_0)

				tf = var_200_0

				local var_200_2 = var_200_0(iter_200_1[var_11])

				arg_200_0:cancelMarkTween(var_11, var_200_2)
				var_200_1:Enqueue(var_200_2, false)

				iter_200_1[var_11] = nil
			end
		end
	end

	return
end

function var_0_1.ClearEdges(arg_201_0, arg_201_1)
	next = var_1_10002

	if not var_1_10002(arg_201_0.cellEdges) then
		return
	end

	pairs = var_2

	for iter_201_0, iter_201_1 in var_2(arg_201_0.cellEdges) do
		if not arg_201_1 or arg_201_1 == iter_201_0 then
			local var_201_0 = arg_201_0
			local var_201_1 = arg_201_0.GetEdgePool(var_201_0, iter_201_0)

			pairs = var_201_0

			for iter_201_2, iter_201_3 in var_201_0(iter_201_1) do
				arg_201_0:cancelMarkTween(iter_201_2, iter_201_3)

				local var_201_2 = var_201_1
				local var_201_3 = var_201_1.Enqueue

				go = var_15

				var_201_3(var_201_2, var_15(iter_201_3), false)
			end

			arg_201_0.cellEdges[iter_201_0] = nil
		end
	end

	return
end

function var_0_1.CreateOutlines(arg_202_0, arg_202_1, arg_202_2, arg_202_3, arg_202_4, arg_202_5)
	local var_202_0 = arg_202_0.contextData.chapterVO.theme.cellSize + var_6.theme.cellSpace

	pairs = var_8

	for iter_202_0, iter_202_1 in var_8(arg_202_1) do
		local var_202_1 = arg_202_0:GetEdgePool(arg_202_5)
		local var_202_2 = var_6.theme
		local var_202_3 = var_14.GetLinePosition(var_202_2, iter_202_1.row / 2, iter_202_1.column / 2)

		assert = var_202_2

		var_202_2(arg_202_5, "Missing key, Please PM Programmer")

		local var_202_4 = arg_202_0.CreateEdgeIndex(iter_202_1.row, iter_202_1.column, 0, arg_202_5)
		local var_202_5 = arg_202_0.cellEdges
		local var_202_6

		if not arg_202_0.cellEdges[arg_202_5] then
			var_202_6 = {}
		end

		var_202_5[arg_202_5] = var_202_6

		local var_202_7 = arg_202_0.cellEdges[arg_202_5]
		local var_202_8

		if not arg_202_0.cellEdges[arg_202_5][var_202_4] then
			tf = var_202_8
			var_202_8 = var_202_8(var_202_1:Dequeue())
		end

		var_202_7[var_202_4] = var_202_8

		local var_202_9 = arg_202_0.cellEdges[arg_202_5][var_202_4]

		var_202_9.name = var_202_4

		var_202_9:SetParent(arg_202_0.bottomMarkRoot, false)

		arg_202_3 = arg_202_3 or 0
		arg_202_4 = arg_202_4 or 3

		local var_202_10

		if not (var_0_5[iter_202_1.normal][1] ~= 0) or not var_202_0.x then
			var_202_10 = var_202_0.y
		end

		local var_202_11 = arg_202_4
		local var_202_12 = var_202_10 * 0.5
		local var_202_13 = iter_202_1.normal % 4 + 1
		local var_202_14 = (iter_202_1.normal + 2) % 4 + 1
		local var_202_15

		if not arg_202_1[({
			iter_202_1.row + var_0_5[var_202_13][1],
			iter_202_1.column + var_0_5[var_202_13][2]
		})[1] + var_0_5[iter_202_1.normal][1] .. "_" .. var_23[2] + var_0_5[iter_202_1.normal][2]] then
			var_202_15 = arg_202_1[var_23[1] - var_0_5[iter_202_1.normal][1] .. "_" .. var_23[2] - var_0_5[iter_202_1.normal][2]]
		end

		local var_202_16

		if not arg_202_1[({
			iter_202_1.row + var_0_5[var_202_14][1],
			iter_202_1.column + var_0_5[var_202_14][2]
		})[1] + var_0_5[iter_202_1.normal][1] .. "_" .. var_25[2] + var_0_5[iter_202_1.normal][2]] then
			var_202_16 = arg_202_1[var_25[1] - var_0_5[iter_202_1.normal][1] .. "_" .. var_25[2] - var_0_5[iter_202_1.normal][2]]
		end

		local var_202_17

		if var_202_15 then
			var_202_17 = iter_202_1.row + var_0_5[iter_202_1.normal][1] == var_202_15.row + var_0_5[var_202_15.normal][1] or iter_202_1.column + var_0_5[iter_202_1.normal][2] == var_202_15.column + var_0_5[var_202_15.normal][2]
			var_202_10 = var_202_17 and var_202_10 + arg_202_3 or var_202_10 - arg_202_3
			var_202_12 = var_202_17 and var_202_12 + arg_202_3 or var_202_12 - arg_202_3
		end

		if var_202_16 then
			var_202_17 = iter_202_1.row + var_0_5[iter_202_1.normal][1] == var_202_16.row + var_0_5[var_202_16.normal][1] or iter_202_1.column + var_0_5[iter_202_1.normal][2] == var_202_16.column + var_0_5[var_202_16.normal][2]
			var_202_10 = var_202_17 and var_202_10 + arg_202_3 or var_202_10 - arg_202_3
		end

		Vector2 = var_202_17
		var_202_9.sizeDelta = var_202_17.New(var_202_10, var_202_11)
		Vector2 = var_27
		var_202_9.pivot = var_27.New(var_202_12 / var_202_10, 0)

		local var_202_18 = var_0_5[iter_202_1.normal][2] * -arg_202_3
		local var_202_19 = var_0_5[iter_202_1.normal][1] * arg_202_3

		Vector2 = var_29
		var_202_9.anchoredPosition = var_29.New(var_202_18 + var_202_3.x, var_202_19 + var_202_3.y)
		Quaternion = var_29
		var_202_9.localRotation = var_29.Euler(0, 0, (5 - iter_202_1.normal) * 90)

		if arg_202_2 then
			arg_202_0:startMarkTween(var_202_4, var_202_9)
		else
			arg_202_0:cancelMarkTween(var_202_4, var_202_9, 1)
		end
	end

	return
end

function var_0_1.CreateOutlineCorners(arg_203_0, arg_203_1, arg_203_2, arg_203_3, arg_203_4, arg_203_5)
	local var_203_0 = arg_203_0.contextData.chapterVO

	pairs = var_1_10007

	for iter_203_0, iter_203_1 in var_1_10007(arg_203_1) do
		local var_203_1 = arg_203_0:GetEdgePool(arg_203_5)
		local var_203_2 = var_203_0.theme
		local var_203_3 = var_13.GetLinePosition(var_203_2, iter_203_1.row + var_0_6[iter_203_1.corner][1] * 0.5, iter_203_1.column + var_0_6[iter_203_1.corner][2] * 0.5)

		assert = var_203_2

		var_203_2(arg_203_5, "Missing key, Please PM Programmer")

		local var_203_4 = arg_203_0.CreateEdgeIndex(iter_203_1.row, iter_203_1.column, iter_203_1.corner, arg_203_5)
		local var_203_5 = arg_203_0.cellEdges
		local var_203_6

		if not arg_203_0.cellEdges[arg_203_5] then
			var_203_6 = {}
		end

		var_203_5[arg_203_5] = var_203_6

		local var_203_7 = arg_203_0.cellEdges[arg_203_5]
		local var_203_8

		if not arg_203_0.cellEdges[arg_203_5][var_203_4] then
			tf = var_203_8
			var_203_8 = var_203_8(var_203_1:Dequeue())
		end

		var_203_7[var_203_4] = var_203_8

		local var_203_9 = arg_203_0.cellEdges[arg_203_5][var_203_4]

		var_203_9.name = var_203_4

		var_203_9:SetParent(arg_203_0.bottomMarkRoot, false)

		arg_203_3 = arg_203_3 or 0
		arg_203_4 = arg_203_4 or 3

		local var_203_10 = arg_203_4
		local var_203_11 = arg_203_4

		Vector2 = var_18
		var_203_9.sizeDelta = var_18.New(var_203_10, var_203_11)
		Vector2 = var_18
		var_203_9.pivot = var_18.New(1, 0)

		local var_203_12 = var_0_6[iter_203_1.corner][2] * -arg_203_3
		local var_203_13 = var_0_6[iter_203_1.corner][1] * arg_203_3

		Vector2 = var_20
		var_203_9.anchoredPosition = var_20.New(var_203_12 + var_203_3.x, var_203_13 + var_203_3.y)
		Quaternion = var_20
		var_203_9.localRotation = var_20.Euler(0, 0, (5 - iter_203_1.corner) * 90)

		if arg_203_2 then
			arg_203_0:startMarkTween(var_203_4, var_203_9)
		else
			arg_203_0:cancelMarkTween(var_203_4, var_203_9, 1)
		end
	end

	return
end

function var_0_1.updateCoastalGunAttachArea(arg_204_0)
	local var_204_0 = arg_204_0.contextData.chapterVO
	local var_204_1 = var_1.getCoastalGunArea(var_204_0)
	local var_204_2 = arg_204_0
	local var_204_3 = arg_204_0.hideQuadMark

	ChapterConst = var_1_10005

	var_204_3(var_204_2, var_1_10005.MarkCoastalGun)

	local var_204_4 = arg_204_0
	local var_204_5 = arg_204_0.showQuadMark
	local var_204_6 = var_204_1

	ChapterConst = var_1_10006

	local var_204_7 = var_1_10006.MarkCoastalGun
	local var_204_8 = "cell_coastal_gun"

	Vector2 = var_1_10008

	var_204_5(var_204_4, var_204_6, var_204_7, var_204_8, var_1_10008(110, 110), nil, false)

	return
end

function var_0_1.InitIdolsAnim(arg_205_0)
	local var_205_0 = arg_205_0.contextData.chapterVO

	pg = var_1_10002

	if not var_1_10002.chapter_pop_template[var_205_0.id] then
		return
	end

	local var_205_1 = var_2.sd_location

	ipairs = var_1_10004

	for iter_205_0, iter_205_1 in var_1_10004(var_205_1) do
		local var_205_2

		if not arg_205_0.idols then
			var_205_2 = {}
		end

		arg_205_0.idols = var_205_2
		ChapterCell = var_205_2

		local var_205_3 = var_205_2.Line2Name(iter_205_1[1][1], iter_205_1[1][2])
		local var_205_4 = arg_205_0.cellRoot
		local var_205_5 = var_10.Find
		local var_205_6 = var_205_3
		local var_205_7 = "/"

		ChapterConst = var_1_10014

		local var_205_8 = var_205_5(var_205_4, var_205_6 .. var_205_7 .. var_1_10014.ChildAttachment)

		assert = var_205_4

		var_205_4(var_205_8, "cant find attachment")

		AttachmentSpineAnimationCell = var_205_4

		local var_205_9 = var_205_4.New(var_205_8)

		var_11.SetLine(var_205_9, {
			row = iter_205_1[1][1],
			column = iter_205_1[1][2]
		})

		table = var_12

		var_12.insert(arg_205_0.idols, var_11)
		var_11:Set(iter_205_1[2])
		var_11:SetRoutine(var_2.sd_act[iter_205_0])
	end

	return
end

function var_0_1.ClearIdolsAnim(arg_206_0)
	if arg_206_0.idols then
		ipairs = var_1

		for iter_206_0, iter_206_1 in var_1(arg_206_0.idols) do
			iter_206_1:Clear()
		end

		table = var_1

		var_1.clear(arg_206_0.idols)

		arg_206_0.idols = nil
	end

	return
end

function var_0_1.GetEnemyCellView(arg_207_0, arg_207_1)
	_ = var_1_10002

	local var_207_1

	if not var_1_10002.detect(arg_207_0.cellChampions, function(arg_208_0)
		return arg_208_0:GetLine().row == arg_207_1.row and var_1.column == arg_207_1.column
	end) then
		ChapterCell = var_3

		local var_207_0 = var_3.Line2Name(arg_207_1.row, arg_207_1.column)

		var_207_1 = arg_207_0.attachmentCells[var_207_0]
	end

	return var_207_1
end

function var_0_1.TransformLine2PlanePos(arg_209_0, arg_209_1)
	string = var_1_10002

	local var_209_0 = var_1_10002.char

	string = var_1_10003

	local var_209_1 = var_209_0(var_1_10003.byte("A") + arg_209_1.column - arg_209_0.indexMin.y)

	string = var_3

	local var_209_2 = var_3.char

	string = var_4

	local var_209_3 = var_209_2(var_4.byte("1") + arg_209_1.row - arg_209_0.indexMin.x)

	return var_209_1 .. var_209_3
end

function var_0_1.AlignListContainer(arg_210_0, arg_210_1)
	local var_210_0 = arg_210_0.childCount

	for iter_210_0 = arg_210_1, var_210_0 - 1 do
		local var_210_1 = arg_210_0

		var_1_10007 = arg_210_0.GetChild(var_210_1, iter_210_0)
		setActive = var_210_1

		var_210_1(var_1_10007, false)
	end

	for iter_210_1 = var_210_0, arg_210_1 - 1 do
		cloneTplTo = var_1_10007

		var_1_10007(arg_210_0:GetChild(0), arg_210_0)
	end

	for iter_210_2 = 0, arg_210_1 - 1 do
		local var_210_2 = arg_210_0
		local var_210_3 = arg_210_0.GetChild(var_210_2, iter_210_2)

		setActive = var_210_2

		var_210_2(var_210_3, true)
	end

	return
end

function var_0_1.frozen(arg_211_0)
	local var_211_0

	if not arg_211_0.forzenCount then
		var_211_0 = 0
	end

	arg_211_0.forzenCount = var_211_0 + 1

	local var_211_1 = arg_211_0.parent

	var_1.frozen(var_211_1)

	return
end

function var_0_1.unfrozen(arg_212_0)
	if arg_212_0.exited then
		return
	end

	local var_212_0

	if not arg_212_0.forzenCount then
		var_212_0 = 0
	end

	arg_212_0.forzenCount = var_212_0 - 1

	local var_212_1 = arg_212_0.parent

	var_1.unfrozen(var_212_1)

	return
end

function var_0_1.isfrozen(arg_213_0)
	return arg_213_0.parent.frozenCount > 0
end

function var_0_1.clear(arg_214_0)
	arg_214_0:clearAll()

	local var_214_0

	if not arg_214_0.forzenCount then
		var_214_0 = 0
	end

	if var_214_0 > 0 then
		local var_214_1 = arg_214_0.parent

		var_1.unfrozen(var_214_1, arg_214_0.forzenCount)
	end

	return
end

return var_0_1
