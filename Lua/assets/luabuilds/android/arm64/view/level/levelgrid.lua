local var_0_0 = class("LevelGrid", import("..base.BasePanel"))
local var_0_1 = require("Mgr/Pool/PoolPlural")

var_0_0.MapDefaultPos = Vector3(420, -1000, -1000)

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)

	arg_1_0.levelCam = GameObject.Find("LevelCamera"):GetComponent(typeof(Camera))
	GameObject.Find("LevelCamera/Canvas"):GetComponent(typeof(Canvas)).sortingOrder = ChapterConst.PriorityMin - 1
	arg_1_0.quadTws = {}
	arg_1_0.presentTws = {}
	arg_1_0.markTws = {}
	arg_1_0.tweens = {}
	arg_1_0.markQuads = {}
	arg_1_0.pools = {}
	arg_1_0.edgePools = {}
	arg_1_0.poolParent = GameObject.Find("__Pool__")
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
	arg_1_0.material_Add = LoadAny("artresource/effect/common/material/add", "", typeof(Material))
	arg_1_0.loader = AutoLoader.New()

	return
end

function var_0_0.ExtendItem(arg_2_0, arg_2_1, arg_2_2)
	if IsNil(arg_2_0[arg_2_1]) then
		arg_2_0[arg_2_1] = arg_2_2
	end

	return
end

function var_0_0.getFleetPool(arg_3_0, arg_3_1)
	local var_3_0 = "fleet_" .. arg_3_1
	local var_3_1 = arg_3_0.pools["fleet_" .. arg_3_1]

	if not arg_3_0.pools["fleet_" .. arg_3_1] then
		local var_3_2 = arg_3_0.shipTpl

		if arg_3_1 == FleetType.Submarine then
			var_3_2 = arg_3_0.subTpl
		elseif arg_3_1 == FleetType.Transport then
			var_3_2 = arg_3_0.transportTpl
		end

		var_3_1 = var_0_1.New(var_3_2.gameObject, 2)
		arg_3_0.pools[var_3_0] = var_3_1
	end

	return var_3_1
end

function var_0_0.getChampionPool(arg_4_0, arg_4_1)
	local var_4_0 = "champion_" .. arg_4_1
	local var_4_1 = arg_4_0.pools["champion_" .. arg_4_1]

	if not arg_4_0.pools["champion_" .. arg_4_1] then
		local var_4_2 = arg_4_0.championTpl

		if arg_4_1 == ChapterConst.TemplateOni then
			var_4_2 = arg_4_0.oniTpl
		elseif arg_4_1 == ChapterConst.TemplateEnemy then
			var_4_2 = arg_4_0.enemyTpl
		end

		var_4_1 = var_0_1.New(var_4_2.gameObject, 3)
		arg_4_0.pools[var_4_0] = var_4_1
	end

	return var_4_1
end

function var_0_0.AddEdgePool(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_0.edgePools[arg_5_1] then
		return
	end

	local var_5_0 = GameObject.New(arg_5_1)

	var_5_0:AddComponent(typeof(Image)).enabled = false
	arg_5_0.edgePools[arg_5_1] = var_0_1.New(var_5_0, 32)

	local var_5_1

	parallelAsync({
		function(arg_6_0)
			if not arg_5_3 then
				arg_6_0()

				return
			end

			arg_5_0.loader:LoadReference(arg_5_2, arg_5_3, typeof(Sprite), function(arg_7_0)
				var_5_1 = arg_7_0

				arg_6_0()

				return
			end)

			return
		end
	}, function()
		if arg_5_0.edgePools[arg_5_1].prefab then
			(function(arg_9_0)
				local var_9_0 = go(arg_9_0):GetComponent(typeof(Image))

				var_9_0.enabled = true
				var_9_0.color = type(arg_5_4) == "table" and Color.New(unpack(arg_5_4)) or Color.white

				if arg_5_3 then
					var_9_0.sprite = var_5_1 or nil
					var_9_0.material = arg_5_5 or nil

					return
				end
			end)(arg_5_0.edgePools[arg_5_1].prefab)
		end

		if arg_5_0.edgePools[arg_5_1].items then
			for iter_8_0, iter_8_1 in pairs(arg_5_0.edgePools[arg_5_1].items) do
				(function(arg_9_0)
					local var_9_0 = go(arg_9_0):GetComponent(typeof(Image))

					var_9_0.enabled = true
					var_9_0.color = type(arg_5_4) == "table" and Color.New(unpack(arg_5_4)) or Color.white

					if arg_5_3 then
						var_9_0.sprite = var_5_1 or nil
						var_9_0.material = arg_5_5 or nil

						return
					end
				end)(iter_8_1)
			end
		end

		if arg_5_0.cellEdges[arg_5_1] and next(arg_5_0.cellEdges[arg_5_1]) then
			for iter_8_2, iter_8_3 in pairs(arg_5_0.cellEdges[arg_5_1]) do
				(function(arg_9_0)
					local var_9_0 = go(arg_9_0):GetComponent(typeof(Image))

					var_9_0.enabled = true
					var_9_0.color = type(arg_5_4) == "table" and Color.New(unpack(arg_5_4)) or Color.white

					if arg_5_3 then
						var_9_0.sprite = var_5_1 or nil
						var_9_0.material = arg_5_5 or nil

						return
					end
				end)(iter_8_3)
			end
		end

		return
	end)

	return
end

function var_0_0.GetEdgePool(arg_10_0, arg_10_1)
	assert(arg_10_1, "Missing Key")
	assert(arg_10_0.edgePools[arg_10_1], "Must Create Pool before Using")

	return arg_10_0.edgePools[arg_10_1]
end

function var_0_0.initAll(arg_11_0, arg_11_1)
	seriesAsync({
		function(arg_12_0)
			arg_11_0:initPlane()
			arg_11_0:initDrag()
			onNextTick(arg_12_0)

			return
		end,
		function(arg_13_0)
			if arg_11_0.exited then
				return
			end

			arg_11_0:initTargetArrow()
			arg_11_0:InitDestinationMark()
			onNextTick(arg_13_0)

			return
		end,
		function(arg_14_0)
			if arg_11_0.exited then
				return
			end

			for iter_14_0 = 0, ChapterConst.MaxRow - 1 do
				for iter_14_1 = 0, ChapterConst.MaxColumn - 1 do
					arg_11_0:initCell(iter_14_0, iter_14_1)
				end
			end

			arg_11_0:UpdateItemCells()
			arg_11_0:updateQuadCells(ChapterConst.QuadStateFrozen)
			onNextTick(arg_14_0)

			return
		end,
		function(arg_15_0)
			if arg_11_0.exited then
				return
			end

			arg_11_0:AddEdgePool("SubmarineHunting", "ui/commonUI_atlas", "white_dot", {
				1,
				0,
				0
			}, arg_11_0.material_Add)
			arg_11_0:updateAttachments()
			arg_11_0:UpdateFloor()
			arg_11_0:UpdateWeatherCells()
			arg_11_0:InitWalls()
			arg_11_0:InitIdolsAnim()
			onNextTick(arg_15_0)

			return
		end,
		function(arg_16_0)
			if arg_11_0.exited then
				return
			end

			parallelAsync({
				function(arg_17_0)
					arg_11_0:initFleets(arg_17_0)

					return
				end,
				function(arg_18_0)
					arg_11_0:initChampions(arg_18_0)

					return
				end
			}, arg_16_0)

			return
		end,
		function()
			arg_11_0:OnChangeSubAutoAttack()
			arg_11_0:updateQuadCells(ChapterConst.QuadStateNormal)
			existCall(arg_11_1)

			return
		end
	})

	return
end

function var_0_0.clearAll(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.tweens) do
		LeanTween.cancel(iter_20_0)
	end

	table.clear(arg_20_0.tweens)
	arg_20_0.loader:Clear()

	if not IsNil(arg_20_0.cellRoot) then
		arg_20_0:clearFleets()
		arg_20_0:clearChampions()
		arg_20_0:clearTargetArrow()
		arg_20_0:ClearDestinationMark()
		arg_20_0:ClearIdolsAnim()

		for iter_20_2, iter_20_3 in pairs(arg_20_0.itemCells) do
			iter_20_3:Clear()
		end

		table.clear(arg_20_0.itemCells)

		for iter_20_4, iter_20_5 in pairs(arg_20_0.attachmentCells) do
			iter_20_5:Clear()
		end

		table.clear(arg_20_0.attachmentCells)

		for iter_20_6, iter_20_7 in pairs(arg_20_0.extraAttachmentCells) do
			iter_20_7:Clear()
		end

		table.clear(arg_20_0.extraAttachmentCells)

		for iter_20_8, iter_20_9 in pairs(arg_20_0.weatherCells) do
			iter_20_9:Clear()
		end

		table.clear(arg_20_0.weatherCells)

		for iter_20_10 = 0, ChapterConst.MaxRow - 1 do
			for iter_20_11 = 0, ChapterConst.MaxColumn - 1 do
				arg_20_0:clearCell(iter_20_10, iter_20_11)
			end
		end

		for iter_20_12, iter_20_13 in pairs(arg_20_0.walls) do
			iter_20_13:Clear()
		end

		table.clear(arg_20_0.walls)
		arg_20_0:clearPlane()
	end

	arg_20_0.material_Add = nil

	for iter_20_14, iter_20_15 in pairs(arg_20_0.edgePools) do
		iter_20_15:Clear()
	end

	arg_20_0.edgePools = nil

	for iter_20_16, iter_20_17 in pairs(arg_20_0.pools) do
		iter_20_17:ClearItems()
	end

	arg_20_0.pools = nil
	GetOrAddComponent(arg_20_0._tf, "EventTriggerListener").enabled = false

	if arg_20_0.dragTrigger then
		ClearEventTrigger(arg_20_0.dragTrigger)

		arg_20_0.dragTrigger = nil
	end

	LeanTween.cancel(arg_20_0._tf)

	return
end

local var_0_2 = 640

function var_0_0.initDrag(arg_21_0)
	local var_21_0, var_21_1, var_21_2 = getSizeRate()
	local var_21_3 = var_21_2 * 0.5 / math.tan(math.deg2Rad * arg_21_0.contextData.chapterVO.theme.fov * 0.5)
	local var_21_4 = Vector3(arg_21_0.contextData.chapterVO.theme.offsetx, arg_21_0.contextData.chapterVO.theme.offsety, arg_21_0.contextData.chapterVO.theme.offsetz) + var_0_0.MapDefaultPos
	local var_21_5 = var_21_0 * math.clamp((var_21_3 - Vector3.Dot(Vector3(0, -math.sin(math.deg2Rad * arg_21_0.contextData.chapterVO.theme.angle), -math.cos(math.deg2Rad * arg_21_0.contextData.chapterVO.theme.angle)), var_21_4)) / var_21_3, 0, 1)
	local var_21_6 = arg_21_0.plane:Find("display").anchoredPosition
	local var_21_7, var_21_8, var_21_9, var_21_10 = arg_21_0.contextData.chapterVO:getDragExtend()

	arg_21_0.leftBound = var_0_2 - var_21_4.x - var_21_6.x - var_21_8
	arg_21_0.rightBound = var_0_2 - var_21_4.x - var_21_6.x + var_21_7
	arg_21_0.topBound = var_0_0.MapDefaultPos.y - var_21_4.y - var_21_6.y + var_21_10
	arg_21_0.bottomBound = var_0_0.MapDefaultPos.y - var_21_4.y - var_21_6.y - var_21_9
	arg_21_0._tf.sizeDelta = Vector2(var_21_1 * 2, var_21_2 * 2)
	arg_21_0.dragTrigger = GetOrAddComponent(arg_21_0._tf, "EventTriggerListener")
	arg_21_0.dragTrigger.enabled = true

	arg_21_0.dragTrigger:AddDragFunc(function(arg_22_0, arg_22_1)
		arg_21_0._tf.anchoredPosition.x = math.clamp(arg_21_0._tf.anchoredPosition.x + arg_22_1.delta.x * var_21_5.x, arg_21_0.leftBound, arg_21_0.rightBound)
		arg_21_0._tf.anchoredPosition.y = math.clamp(arg_21_0._tf.anchoredPosition.y + arg_22_1.delta.y * var_21_5.y / math.cos(var_0), arg_21_0.bottomBound, arg_21_0.topBound)
		arg_21_0._tf.anchoredPosition = arg_21_0._tf.anchoredPosition

		return
	end)

	return
end

function var_0_0.initPlane(arg_23_0)
	arg_23_0.levelCam.fieldOfView = arg_23_0.contextData.chapterVO.theme.fov

	local var_23_0

	PoolMgr.GetInstance():GetPrefab("chapter/plane", "", false, function(arg_24_0)
		var_23_0 = arg_24_0.transform

		return
	end)

	arg_23_0.plane = nil
	;(nil).name = ChapterConst.PlaneName

	;(nil):SetParent(arg_23_0._tf, false)

	;(nil).anchoredPosition3D = Vector3(arg_23_0.contextData.chapterVO.theme.offsetx, arg_23_0.contextData.chapterVO.theme.offsety, arg_23_0.contextData.chapterVO.theme.offsetz) + var_0_0.MapDefaultPos
	arg_23_0.cellRoot = (nil):Find("cells")
	arg_23_0.quadRoot = (nil):Find("quads")
	arg_23_0.bottomMarkRoot = (nil):Find("buttomMarks")
	arg_23_0.topMarkRoot = (nil):Find("topMarks")
	arg_23_0.restrictMap = (nil):Find("restrictMap")
	arg_23_0.UIFXList = (nil):Find("UI_FX_list")

	for iter_23_0 = 1, arg_23_0.UIFXList.childCount do
		setActive(arg_23_0.UIFXList:GetChild(iter_23_0 - 1), false)
	end

	local var_23_1 = arg_23_0.UIFXList:Find(arg_23_0.contextData.chapterVO:getConfig("uifx"))

	if var_23_1 then
		setActive(var_23_1, true)
	end

	local var_23_2 = arg_23_0.contextData.chapterVO:getConfig("chapter_fx")

	if type(var_23_2) == "table" then
		for iter_23_1, iter_23_2 in pairs(var_23_2) do
			if #iter_23_1 <= 0 then
				return
			end

			arg_23_0.loader:GetPrefab("effect/" .. iter_23_1, iter_23_1, function(arg_25_0)
				setParent(arg_25_0, arg_23_0.UIFXList)

				if iter_23_2.offset then
					tf(arg_25_0).localPosition = Vector3(unpack(iter_23_2.offset))
				end

				if iter_23_2.rotation then
					tf(arg_25_0).localRotation = Quaternion.Euler(unpack(iter_23_2.rotation))
				end

				return
			end)
		end
	end

	local var_23_3 = (nil):Find("display")

	GetImageSpriteFromAtlasAsync("chapter/pic/" .. arg_23_0.contextData.chapterVO.theme.assetSea, arg_23_0.contextData.chapterVO.theme.assetSea, (var_23_3:Find("mask/sea")))

	arg_23_0.indexMin, arg_23_0.indexMax = arg_23_0.contextData.chapterVO.indexMin, arg_23_0.contextData.chapterVO.indexMax

	local var_23_4 = Vector2.Scale(Vector2(arg_23_0.indexMin.y, ChapterConst.MaxRow * 0.5 - arg_23_0.indexMax.x - 1), arg_23_0.contextData.chapterVO.theme.cellSize + arg_23_0.contextData.chapterVO.theme.cellSpace)
	local var_23_5 = Vector2.Scale(Vector2(arg_23_0.indexMax.y - arg_23_0.indexMin.y + 1, arg_23_0.indexMax.x - arg_23_0.indexMin.x + 1), arg_23_0.contextData.chapterVO.theme.cellSize + arg_23_0.contextData.chapterVO.theme.cellSpace)

	var_23_3.anchoredPosition = var_23_4 + var_23_5 * 0.5
	var_23_3.sizeDelta = var_23_5
	arg_23_0.restrictMap.anchoredPosition = var_23_4 + var_23_5 * 0.5
	arg_23_0.restrictMap.sizeDelta = var_23_5

	local var_23_6 = Vector2(math.floor(var_23_3.sizeDelta.x / (arg_23_0.contextData.chapterVO.theme.cellSize + arg_23_0.contextData.chapterVO.theme.cellSpace).x), math.floor(var_23_3.sizeDelta.y / (arg_23_0.contextData.chapterVO.theme.cellSize + arg_23_0.contextData.chapterVO.theme.cellSpace).y))
	local var_23_7 = var_23_3:Find("ABC")
	local var_23_8 = var_23_7:GetChild(0)
	local var_23_9 = var_23_7:GetComponent(typeof(GridLayoutGroup))

	var_23_9.cellSize = Vector2(arg_23_0.contextData.chapterVO.theme.cellSize.x, arg_23_0.contextData.chapterVO.theme.cellSize.y)
	var_23_9.spacing = Vector2(arg_23_0.contextData.chapterVO.theme.cellSpace.x, arg_23_0.contextData.chapterVO.theme.cellSpace.y)
	var_23_9.padding.left = arg_23_0.contextData.chapterVO.theme.cellSpace.x

	for iter_23_3 = var_23_7.childCount - 1, var_23_6.x, -1 do
		Destroy(var_23_7:GetChild(iter_23_3))
	end

	for iter_23_4 = var_23_7.childCount, var_23_6.x - 1 do
		Instantiate(var_23_8).transform:SetParent(var_23_7, false)
	end

	for iter_23_5 = 0, var_23_6.x - 1 do
		setText(var_23_7:GetChild(iter_23_5), string.char(string.byte("A") + iter_23_5))
	end

	local var_23_10 = var_23_3:Find("123")
	local var_23_11 = var_23_10:GetChild(0)
	local var_23_12 = var_23_10:GetComponent(typeof(GridLayoutGroup))

	var_23_12.cellSize = Vector2(arg_23_0.contextData.chapterVO.theme.cellSize.x, arg_23_0.contextData.chapterVO.theme.cellSize.y)
	var_23_12.spacing = Vector2(arg_23_0.contextData.chapterVO.theme.cellSpace.x, arg_23_0.contextData.chapterVO.theme.cellSpace.y)
	var_23_12.padding.top = arg_23_0.contextData.chapterVO.theme.cellSpace.y

	for iter_23_6 = var_23_10.childCount - 1, var_23_6.y, -1 do
		Destroy(var_23_10:GetChild(iter_23_6))
	end

	for iter_23_7 = var_23_10.childCount, var_23_6.y - 1 do
		Instantiate(var_23_11).transform:SetParent(var_23_10, false)
	end

	for iter_23_8 = 0, var_23_6.y - 1 do
		setText(var_23_10:GetChild(iter_23_8), 1 + iter_23_8)
	end

	local var_23_13 = var_23_3:Find("linev")
	local var_23_14 = var_23_13:GetChild(0)
	local var_23_15 = var_23_13:GetComponent(typeof(GridLayoutGroup))

	var_23_15.cellSize = Vector2(ChapterConst.LineCross, var_23_3.sizeDelta.y)
	var_23_15.spacing = Vector2((arg_23_0.contextData.chapterVO.theme.cellSize + arg_23_0.contextData.chapterVO.theme.cellSpace).x - ChapterConst.LineCross, 0)
	var_23_15.padding.left = math.floor(var_23_15.spacing.x)

	for iter_23_9 = var_23_13.childCount - 1, math.max(var_23_6.x - 1, 0), -1 do
		if iter_23_9 > 0 then
			Destroy(var_23_13:GetChild(iter_23_9))
		end
	end

	for iter_23_10 = var_23_13.childCount, var_23_6.x - 2 do
		Instantiate(var_23_14).transform:SetParent(var_23_13, false)
	end

	local var_23_16 = var_23_3:Find("lineh")
	local var_23_17 = var_23_16:GetChild(0)
	local var_23_18 = var_23_16:GetComponent(typeof(GridLayoutGroup))

	var_23_18.cellSize = Vector2(var_23_3.sizeDelta.x, ChapterConst.LineCross)
	var_23_18.spacing = Vector2(0, (arg_23_0.contextData.chapterVO.theme.cellSize + arg_23_0.contextData.chapterVO.theme.cellSpace).y - ChapterConst.LineCross)
	var_23_18.padding.top = math.floor(var_23_18.spacing.y)

	for iter_23_11 = var_23_16.childCount - 1, math.max(var_23_6.y - 1, 0), -1 do
		if iter_23_11 > 0 then
			Destroy(var_23_16:GetChild(iter_23_11))
		end
	end

	for iter_23_12 = var_23_16.childCount, var_23_6.y - 2 do
		Instantiate(var_23_17).transform:SetParent(var_23_16, false)
	end

	local var_23_19 = GetOrAddComponent(var_23_3:Find("mask"), "RawImage")
	local var_23_20 = var_23_3:Find("seaBase/sea")

	if arg_23_0.contextData.chapterVO.theme.seaBase and arg_23_0.contextData.chapterVO.theme.seaBase ~= "" then
		setActive(var_23_20, true)
		GetImageSpriteFromAtlasAsync("chapter/pic/" .. arg_23_0.contextData.chapterVO.theme.seaBase, arg_23_0.contextData.chapterVO.theme.seaBase, var_23_20)

		var_23_19.enabled = true
		var_23_19.uvRect = UnityEngine.Rect.New(0, 0, 1, -1)
	else
		setActive(var_23_20, false)

		var_23_19.enabled = false
	end

	return
end

function var_0_0.updatePoisonArea(arg_26_0)
	local var_26_0 = GetOrAddComponent(arg_26_0._tf:Find("plane/display/mask"), "RawImage")

	if not var_26_0.enabled then
		return
	end

	var_26_0.texture = arg_26_0:getPoisonTex()

	return
end

function var_0_0.getPoisonTex(arg_27_0)
	local var_27_0 = arg_27_0.contextData.chapterVO
	local var_27_1 = arg_27_0._tf:Find("plane/display")
	local var_27_2 = 256
	local var_27_3

	if arg_27_0.preChapterId ~= arg_27_0.contextData.chapterVO.id then
		var_27_3 = UnityEngine.Texture2D.New(var_27_2, (math.floor(var_27_2 / (var_27_1.sizeDelta.x / var_27_1.sizeDelta.y))))
		arg_27_0.maskTexture = var_27_3
		arg_27_0.preChapterId = var_27_0.id
	else
		var_27_3 = arg_27_0.maskTexture
	end

	local var_27_4 = {}
	local var_27_5 = var_27_0:getPoisonArea(var_27_2 / var_27_1.sizeDelta.x)

	if arg_27_0.poisonRectDir == nil then
		var_27_4 = var_27_5
	else
		for iter_27_0, iter_27_1 in pairs(var_27_5) do
			if arg_27_0.poisonRectDir[iter_27_0] == nil then
				var_27_4[iter_27_0] = iter_27_1
			end
		end
	end

	for iter_27_2, iter_27_3 in pairs(var_27_4) do
		var_27_6(iter_27_3)
	end

	var_27_3:Apply()

	arg_27_0.poisonRectDir = var_27_5

	return var_27_3
end

function var_0_0.showFleetPoisonDamage(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.cellFleets[arg_29_0.contextData.chapterVO.fleets[arg_29_1].id] then
		arg_29_0.cellFleets[arg_29_0.contextData.chapterVO.fleets[arg_29_1].id]:showPoisonDamage(arg_29_2)
	end

	return
end

function var_0_0.clearPlane(arg_30_0)
	arg_30_0:killQuadTws()
	arg_30_0:killPresentTws()
	arg_30_0:ClearEdges()
	arg_30_0:hideQuadMark()
	removeAllChildren(arg_30_0.cellRoot)
	removeAllChildren(arg_30_0.quadRoot)
	removeAllChildren(arg_30_0.bottomMarkRoot)
	removeAllChildren(arg_30_0.topMarkRoot)
	removeAllChildren(arg_30_0.restrictMap)

	arg_30_0.cellRoot = nil
	arg_30_0.quadRoot = nil
	arg_30_0.bottomMarkRoot = nil
	arg_30_0.topMarkRoot = nil
	arg_30_0.restrictMap = nil

	local var_30_0 = arg_30_0._tf:Find(ChapterConst.PlaneName)

	clearImageSprite((var_30_0:Find("display/seaBase/sea")))
	pg.PoolMgr.GetInstance():ReturnPrefab("chapter/plane", "", var_30_0.gameObject)

	return
end

function var_0_0.initFleets(arg_31_0, arg_31_1)
	if arg_31_0.cellFleets then
		existCall(arg_31_1)

		return
	end

	local var_31_0 = arg_31_0.contextData.chapterVO

	arg_31_0.cellFleets = {}

	table.ParallelIpairsAsync(var_31_0.fleets, function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_1:getFleetType() == FleetType.Support then
			return arg_32_2()
		end

		arg_31_0:InitFleetCell(arg_32_1.id, arg_32_2)

		return
	end, arg_31_1)

	return
end

function var_0_0.InitFleetCell(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.contextData.chapterVO
	local var_33_1 = arg_33_0.contextData.chapterVO:getFleetById(arg_33_1)

	if not var_33_1:isValid() then
		existCall(arg_33_2)

		return
	end

	local var_33_3 = arg_33_0:getFleetPool(var_33_1:getFleetType()):Dequeue()

	var_33_3.transform.localEulerAngles = Vector3(-var_33_0.theme.angle, 0, 0)

	setParent(var_33_3, arg_33_0.cellRoot, false)
	setActive(var_33_3, true)

	local var_33_4 = var_33_1:getFleetType()
	local var_33_6 = var_33_5.New(var_33_3)

	var_33_6.fleetType = var_33_4

	if var_33_4 == FleetType.Normal or var_33_4 == FleetType.Submarine then
		var_33_6:SetAction(ChapterConst.ShipIdleAction)
	end

	var_33_6.tf.localPosition = var_33_0.theme:GetLinePosition(var_33_1.line.row, var_33_1.line.column)
	arg_33_0.cellFleets[arg_33_1] = var_33_6

	arg_33_0:RefreshFleetCell(arg_33_1, arg_33_2)

	return
end

function var_0_0.RefreshFleetCells(arg_34_0, arg_34_1)
	if not arg_34_0.cellFleets then
		arg_34_0:initFleets(arg_34_1)

		return
	end

	local var_34_0 = arg_34_0.contextData.chapterVO

	for iter_34_0, iter_34_1 in pairs(arg_34_0.cellFleets) do
		if not var_34_0:getFleetById(iter_34_0) then
			table.insert({}, iter_34_0)
		end
	end

	for iter_34_2, iter_34_3 in pairs({}) do
		arg_34_0:ClearFleetCell(iter_34_3)
	end

	table.ParallelIpairsAsync(var_34_0.fleets, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_1:getFleetType() == FleetType.Support then
			return arg_35_2()
		end

		if not arg_34_0.cellFleets[arg_35_1.id] then
			arg_34_0:InitFleetCell(arg_35_1.id, arg_35_2)
		else
			arg_34_0:RefreshFleetCell(arg_35_1.id, arg_35_2)
		end

		return
	end, arg_34_1)

	return
end

function var_0_0.RefreshFleetCell(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0.contextData.chapterVO:getFleetById(arg_36_1)
	local var_36_1 = arg_36_0.cellFleets[arg_36_1]
	local var_36_2
	local var_36_3

	if var_36_0:isValid() then
		if var_36_0:getFleetType() == FleetType.Transport then
			var_36_2 = var_36_0:getPrefab()
		else
			local var_36_4 = arg_36_0.contextData.chapterVO:getMapShip(var_36_0)

			if var_36_4 then
				var_36_2 = var_36_4:getPrefab()
				var_36_3 = var_36_4:getAttachmentPrefab()
			end
		end
	end

	if not var_36_2 then
		arg_36_0:ClearFleetCell(arg_36_1)
		existCall(arg_36_2)

		return
	end

	arg_36_0.cellFleets[arg_36_1].go.name = "cell_fleet_" .. var_36_2

	arg_36_0.cellFleets[arg_36_1]:SetLine(var_36_0.line)

	if arg_36_0.cellFleets[arg_36_1].fleetType == FleetType.Transport then
		arg_36_0.cellFleets[arg_36_1]:LoadIcon(var_36_2, function()
			var_36_1:GetRotatePivot().transform.localRotation = var_36_0.rotation

			arg_36_0:updateFleet(arg_36_1, arg_36_2)

			return
		end)
	else
		arg_36_0.cellFleets[arg_36_1]:LoadSpine(var_36_2, nil, var_36_3, function()
			var_36_1:GetRotatePivot().transform.localRotation = var_36_0.rotation

			arg_36_0:updateFleet(arg_36_1, arg_36_2)

			return
		end)
	end

	return
end

function var_0_0.clearFleets(arg_39_0)
	if arg_39_0.cellFleets then
		for iter_39_0, iter_39_1 in pairs(arg_39_0.cellFleets) do
			arg_39_0:ClearFleetCell(iter_39_0)
		end

		arg_39_0.cellFleets = nil
	end

	return
end

function var_0_0.ClearFleetCell(arg_40_0, arg_40_1)
	if not arg_40_0.cellFleets[arg_40_1] then
		return
	end

	arg_40_0.cellFleets[arg_40_1]:Clear()
	LeanTween.cancel(arg_40_0.cellFleets[arg_40_1].go)
	setActive(arg_40_0.cellFleets[arg_40_1].go, false)
	setParent(arg_40_0.cellFleets[arg_40_1].go, arg_40_0.poolParent, false)
	arg_40_0:getFleetPool(arg_40_0.cellFleets[arg_40_1].fleetType):Enqueue(arg_40_0.cellFleets[arg_40_1].go, false)

	if arg_40_0.opBtns[arg_40_1] then
		Destroy(arg_40_0.opBtns[arg_40_1].gameObject)

		arg_40_0.opBtns[arg_40_1] = nil
	end

	arg_40_0.cellFleets[arg_40_1] = nil

	return
end

function var_0_0.UpdateFleets(arg_41_0, arg_41_1)
	table.ParallelIpairsAsync(arg_41_0.contextData.chapterVO.fleets, function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_1:getFleetType() == FleetType.Support then
			return arg_42_2()
		end

		arg_41_0:updateFleet(arg_42_1.id, arg_42_2)

		return
	end, arg_41_1)

	return
end

function var_0_0.updateFleet(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.contextData.chapterVO
	local var_43_1 = arg_43_0.cellFleets[arg_43_1]
	local var_43_2 = arg_43_0.contextData.chapterVO:getFleetById(arg_43_1)

	if arg_43_0.cellFleets[arg_43_1] then
		local var_43_3 = var_43_2.line
		local var_43_4 = var_43_2:isValid()

		setActive(var_43_1.go, var_43_4)
		var_43_1:RefreshLinePosition(var_43_0, var_43_3)

		local var_43_5 = var_43_2:getFleetType()

		if var_43_5 == FleetType.Normal then
			local var_43_6 = var_43_0:GetEnemy(var_43_3.row, var_43_3.column)
			local var_43_7 = tobool(var_43_6)

			if var_43_6 then
				local var_43_8 = var_43_6.attachment or nil
				local var_43_9 = var_43_0:existFleet(FleetType.Transport, var_43_3.row, var_43_3.column)

				var_43_1:SetSpineVisible(not var_43_7 and not var_43_9)

				local var_43_10 = table.indexof(var_43_0.fleets, var_43_2) == var_43_0.findex

				setActive(var_43_1.tfArrow, var_43_10)
				setActive(var_43_1.tfOp, false)

				local var_43_11 = arg_43_0.opBtns[arg_43_1]

				if not arg_43_0.opBtns[arg_43_1] then
					var_43_11 = tf(Instantiate(var_43_1.tfOp))
					var_43_11.name = "op" .. arg_43_1

					var_43_11:SetParent(arg_43_0._tf, false)

					var_43_11.localEulerAngles = Vector3(-var_43_0.theme.angle, 0, 0)

					local var_43_12 = GetOrAddComponent(var_43_11, typeof(Canvas))

					GetOrAddComponent(go(var_43_11), typeof(GraphicRaycaster))

					var_43_12.overrideSorting = true
					var_43_12.sortingOrder = ChapterConst.PriorityMax
					arg_43_0.opBtns[arg_43_1] = var_43_11

					arg_43_0:UpdateOpBtns()
				end

				var_43_11.position = var_43_1.tfOp.position

				local var_43_13 = var_43_6 and ChapterConst.IsBossCell(var_43_6)
				local var_43_14 = false

				if var_43_7 and var_43_8 == ChapterConst.AttachChampion then
					local var_43_15 = pg.expedition_data_template[var_43_0:getChampion(var_43_3.row, var_43_3.column):GetLastID()]

					if var_43_15 then
						var_43_14 = var_43_15.ai == ChapterConst.ExpeditionAILair
					end
				end

				var_43_13 = var_43_13 or var_43_14

				local var_43_16 = _.any(var_43_0.fleets, function(arg_44_0)
					return arg_44_0.id ~= var_43_2.id and arg_44_0:getFleetType() == FleetType.Normal and arg_44_0:isValid()
				end)
				local var_43_17 = var_43_10 and var_43_4 and var_43_7
				local var_43_18 = var_43_11:Find("retreat")

				setActive(var_43_18:Find("retreat"), var_43_10 and var_43_4 and var_43_7 and not var_43_13 and var_43_16)
				setActive(var_43_18:Find("escape"), var_43_17 and var_43_13)

				local var_43_19 = var_43_18:Find("retreat").gameObject.activeSelf or var_43_18:Find("escape").gameObject.activeSelf

				setActive(var_43_18, var_43_19)

				if var_43_18.gameObject.activeSelf then
					onButton(arg_43_0, var_43_18, function()
						if arg_43_0.parent:isfrozen() then
							return
						end

						if var_43_13 then
							(function()
								for iter_46_0, iter_46_1 in ipairs({
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
								}) do
									if var_43_0:considerAsStayPoint(ChapterConst.SubjectPlayer, var_43_3.row + iter_46_1[1], var_43_3.column + iter_46_1[2]) and not var_43_0:existEnemy(ChapterConst.SubjectPlayer, var_43_3.row + iter_46_1[1], var_43_3.column + iter_46_1[2]) then
										arg_43_0:emit(LevelMediator2.ON_OP, {
											type = ChapterConst.OpMove,
											id = var_43_2.id,
											arg1 = var_43_3.row + iter_46_1[1],
											arg2 = var_43_3.column + iter_46_1[2],
											ordLine = var_43_2.line
										})

										return false
									end
								end

								pg.TipsMgr.GetInstance():ShowTips(i18n("no_way_to_escape"))

								return true
							end)()
						else
							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n("levelScene_who_to_retreat", var_43_2.name),
								onYes = function()
									arg_43_0:emit(LevelMediator2.ON_OP, {
										type = ChapterConst.OpRetreat,
										id = var_43_2.id
									})

									return
								end
							})
						end

						return
					end, SFX_UI_WEIGHANCHOR_WITHDRAW)
				end

				setActive(var_43_11:Find("exchange"), false)
				setActive(var_43_1.tfAmmo, not var_43_9)

				local var_43_20, var_43_21 = var_43_0:getFleetAmmo(var_43_2)
				local var_43_22 = var_43_21 .. "/" .. var_43_20

				if var_43_21 == 0 then
					var_43_22 = setColorStr(var_43_22, COLOR_RED)
				end

				setText(var_43_1.tfAmmoText, var_43_22)

				if var_43_7 or var_43_9 then
					local var_43_23 = var_43_0:getChampion(var_43_3.row, var_43_3.column)

					if var_43_7 and var_43_8 == ChapterConst.AttachChampion and var_43_23:getPoolType() == ChapterConst.TemplateChampion then
						var_43_1.tfArrow.anchoredPosition = Vector2(0, 180)
						var_43_1.tfAmmo.anchoredPosition = Vector2(60, 100)
					else
						var_43_1.tfArrow.anchoredPosition = Vector2(0, 100)
						var_43_1.tfAmmo.anchoredPosition = Vector2(22, 56)
					end

					var_43_1.tfAmmo:SetAsLastSibling()
				else
					var_43_1.tfArrow.anchoredPosition = Vector2(0, 175)
					var_43_1.tfAmmo.anchoredPosition = Vector2(-60, 85)
				end

				if var_43_1:GetSpineRole() and var_43_10 and arg_43_0.lastSelectedId ~= var_43_2.id then
					if not var_43_7 and not var_43_9 and arg_43_0.lastSelectedId ~= -1 then
						var_43_1:TweenShining()
					end

					arg_43_0.lastSelectedId = var_43_2.id
				end

				var_43_1:SetActiveNoPassIcon((var_43_0:existBarrier(var_43_3.row, var_43_3.column)))
				var_43_1:UpdateIconRecordedFlag((table.contains(var_43_2:GetStatusStrategy(), ChapterConst.StrategyIntelligenceRecorded)))

				if false then
					if var_43_5 == FleetType.Submarine then
						local var_43_24 = var_43_0:existEnemy(ChapterConst.SubjectPlayer, var_43_3.row, var_43_3.column) or var_43_0:existAlly(var_43_2)
						local var_43_25 = var_43_0.subAutoAttack == 1

						var_43_1:SetActiveModel(not var_43_24 and var_43_25)
						setActive(var_43_1.tfAmmo, not var_43_24)

						local var_43_26, var_43_27 = var_43_0:getFleetAmmo(var_43_2)
						local var_43_28 = var_43_27 .. "/" .. var_43_26

						if var_43_27 == 0 then
							var_43_28 = setColorStr(var_43_28, COLOR_RED)
						end

						setText(var_43_1.tfAmmoText, var_43_28)
					elseif var_43_5 == FleetType.Transport then
						setText(var_43_1.tfHpText, var_43_2:getRestHp() .. "/" .. var_43_2:getTotalHp())
						GetImageSpriteFromAtlasAsync("enemies/" .. var_43_2:getPrefab(), "", var_43_1.tfIcon, true)
						setActive(var_43_1.tfFighting, (var_43_0:existEnemy(ChapterConst.SubjectPlayer, var_43_3.row, var_43_3.column)))
					end
				end

				existCall(arg_43_2)

				return
			end
		end
	end
end

function var_0_0.UpdateOpBtns(arg_48_0)
	table.Foreach(arg_48_0.opBtns, function(arg_49_0, arg_49_1)
		setActive(arg_49_1, arg_48_0.quadState == ChapterConst.QuadStateNormal)

		return
	end)

	return
end

function var_0_0.GetCellFleet(arg_50_0, arg_50_1)
	return arg_50_0.cellFleets[arg_50_1]
end

function var_0_0.initTargetArrow(arg_51_0)
	arg_51_0.arrowTarget = cloneTplTo(arg_51_0.arrowTpl, arg_51_0._tf)

	pg.ViewUtils.SetLayer(tf(arg_51_0.arrowTarget), Layer.UI)

	GetOrAddComponent(arg_51_0.arrowTarget, typeof(Canvas)).overrideSorting = true
	arg_51_0.arrowTarget.localEulerAngles = Vector3(-arg_51_0.contextData.chapterVO.theme.angle, 0, 0)

	setActive(arg_51_0.arrowTarget, false)

	return
end

function var_0_0.updateTargetArrow(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0.contextData.chapterVO

	arg_52_0.arrowTarget:SetParent((arg_52_0.cellRoot:Find((ChapterCell.Line2Name(arg_52_1.row, arg_52_1.column)))))

	local var_52_1, var_52_2 = (function()
		local var_53_0, var_53_1 = var_52_0:existEnemy(ChapterConst.SubjectPlayer, arg_52_1.row, arg_52_1.column)

		if not var_53_0 then
			return false
		end

		if var_53_1 == ChapterConst.AttachChampion then
			local var_53_2 = var_52_0:getChampion(arg_52_1.row, arg_52_1.column)

			if not var_53_2 then
				return false
			end

			return var_53_2:getPoolType() == "common", var_53_2:getScale() / 100
		elseif ChapterConst.IsEnemyAttach(var_53_1) then
			local var_53_3 = var_52_0:getChapterCell(arg_52_1.row, arg_52_1.column)
			local var_53_4

			if not var_53_3 or var_53_3.flag ~= ChapterConst.CellFlagActive then
				do return false end

				var_53_4 = pg.expedition_data_template[var_53_3.attachmentId].icon_type == 2
			end

			return var_53_4, pg.expedition_data_template[var_53_3.attachmentId].scale / 100
		end

		return
	end)()

	arg_52_0.arrowTarget.localPosition = var_52_1 and Vector3(0, 20 + 80 * var_52_2, -80 * var_52_2) or Vector3(0, 20, 0)

	local var_52_3 = arg_52_0.arrowTarget:GetComponent(typeof(Canvas))

	if var_52_3 then
		var_52_3.sortingOrder = arg_52_1.row * ChapterConst.PriorityPerRow + ChapterConst.CellPriorityTopMark
	end

	return
end

function var_0_0.clearTargetArrow(arg_54_0)
	if not IsNil(arg_54_0.arrowTarget) then
		Destroy(arg_54_0.arrowTarget)

		arg_54_0.arrowTarget = nil
	end

	return
end

function var_0_0.InitDestinationMark(arg_55_0)
	local var_55_0 = cloneTplTo(arg_55_0.destinationMarkTpl, arg_55_0._tf)

	pg.ViewUtils.SetLayer(tf(var_55_0), Layer.UI)

	GetOrAddComponent(var_55_0, typeof(Canvas)).overrideSorting = true

	setActive(var_55_0, false)

	tf(var_55_0).localEulerAngles = Vector3(-arg_55_0.contextData.chapterVO.theme.angle, 0, 0)
	arg_55_0.destinationMark = tf(var_55_0)

	return
end

function var_0_0.UpdateDestinationMark(arg_56_0, arg_56_1)
	if not arg_56_1 then
		arg_56_0.destinationMark:SetParent(arg_56_0._tf)
		setActive(go(arg_56_0.destinationMark), false)

		return
	end

	setActive(go(arg_56_0.destinationMark), true)
	arg_56_0.destinationMark:SetParent((arg_56_0.cellRoot:Find((ChapterCell.Line2Name(arg_56_1.row, arg_56_1.column)))))

	arg_56_0.destinationMark.localPosition = Vector3(0, 40, -40)

	local var_56_0 = arg_56_0.destinationMark:GetComponent(typeof(Canvas))

	if var_56_0 then
		var_56_0.sortingOrder = arg_56_1.row * ChapterConst.PriorityPerRow + ChapterConst.CellPriorityTopMark
	end

	return
end

function var_0_0.ClearDestinationMark(arg_57_0)
	if not IsNil(arg_57_0.destinationMark) then
		Destroy(arg_57_0.destinationMark)

		arg_57_0.destinationMark = nil
	end

	return
end

function var_0_0.initChampions(arg_58_0, arg_58_1)
	if arg_58_0.cellChampions then
		existCall(arg_58_1)

		return
	end

	arg_58_0.cellChampions = {}

	table.ParallelIpairsAsync(arg_58_0.contextData.chapterVO.champions, function(arg_59_0, arg_59_1, arg_59_2)
		arg_58_0.cellChampions[arg_59_0] = false

		if arg_59_1.flag ~= ChapterConst.CellFlagDisabled then
			arg_58_0:InitChampion(arg_59_0, arg_59_2)
		else
			arg_59_2()
		end

		return
	end, arg_58_1)

	return
end

function var_0_0.InitChampion(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_0.contextData.chapterVO.champions[arg_60_1]
	local var_60_1 = arg_60_0.contextData.chapterVO.champions[arg_60_1]:getPoolType()
	local var_60_2 = arg_60_0:getChampionPool(var_60_1):Dequeue()

	var_60_2.name = "cell_champion_" .. arg_60_0.contextData.chapterVO.champions[arg_60_1]:getPrefab()
	var_60_2.transform.localEulerAngles = Vector3(-arg_60_0.contextData.chapterVO.theme.angle, 0, 0)

	setParent(var_60_2, arg_60_0.cellRoot, false)
	setActive(var_60_2, true)

	local var_60_3

	if var_60_1 == ChapterConst.TemplateChampion then
		var_60_3 = DynamicChampionCellView
	elseif var_60_1 == ChapterConst.TemplateEnemy then
		var_60_3 = DynamicEggCellView
	elseif var_60_1 == ChapterConst.TemplateOni then
		var_60_3 = OniCellView
	end

	local var_60_4 = var_60_3.New(var_60_2)

	arg_60_0.cellChampions[arg_60_1] = var_60_4

	var_60_4:SetLine({
		row = var_60_0.row,
		column = var_60_0.column
	})
	var_60_4:SetPoolType(var_60_1)

	if var_60_4.GetRotatePivot then
		tf(var_60_4:GetRotatePivot()).localRotation = var_60_0.rotation
	end

	if var_60_1 == ChapterConst.TemplateChampion then
		var_60_4:SetAction(ChapterConst.ShipIdleAction)

		if var_60_0.flag == ChapterConst.CellFlagDiving then
			var_60_4:SetAction(ChapterConst.ShipSwimAction)
		end

		var_60_4:LoadSpine(var_60_0:getPrefab(), var_60_0:getScale(), var_60_0:getConfig("effect_prefab"), function()
			arg_60_0:updateChampion(arg_60_1, arg_60_2)

			return
		end)
	elseif var_60_1 == ChapterConst.TemplateEnemy then
		var_60_4:LoadIcon(var_60_0:getPrefab(), var_60_0:getConfigTable(), function()
			arg_60_0:updateChampion(arg_60_1, arg_60_2)

			return
		end)
	elseif var_60_1 == ChapterConst.TemplateOni then
		arg_60_0:updateChampion(arg_60_1, arg_60_2)
	end

	return
end

function var_0_0.updateChampions(arg_63_0, arg_63_1)
	table.ParallelIpairsAsync(arg_63_0.cellChampions, function(arg_64_0, arg_64_1, arg_64_2)
		arg_63_0:updateChampion(arg_64_0, arg_64_2)

		return
	end, arg_63_1)

	return
end

function var_0_0.updateChampion(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_0.cellChampions[arg_65_1] and arg_65_0.contextData.chapterVO.champions[arg_65_1] then
		arg_65_0.cellChampions[arg_65_1]:UpdateChampionCell(arg_65_0.contextData.chapterVO, arg_65_0.contextData.chapterVO.champions[arg_65_1], arg_65_2)
	end

	return
end

function var_0_0.updateOni(arg_66_0)
	local var_66_0

	for iter_66_0, iter_66_1 in ipairs(arg_66_0.contextData.chapterVO.champions) do
		if iter_66_1.attachment == ChapterConst.AttachOni then
			var_66_0 = iter_66_0

			break
		end
	end

	if var_66_0 then
		arg_66_0:updateChampion(var_66_0)
	end

	return
end

function var_0_0.clearChampions(arg_67_0)
	if arg_67_0.cellChampions then
		for iter_67_0, iter_67_1 in ipairs(arg_67_0.cellChampions) do
			if iter_67_1 then
				iter_67_1:Clear()
				LeanTween.cancel(iter_67_1.go)
				setActive(iter_67_1.go, false)
				setParent(iter_67_1.go, arg_67_0.poolParent, false)
				arg_67_0:getChampionPool(iter_67_1:GetPoolType()):Enqueue(iter_67_1.go, false)
			end
		end

		arg_67_0.cellChampions = nil
	end

	return
end

function var_0_0.initCell(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = arg_68_0.contextData.chapterVO:getChapterCell(arg_68_1, arg_68_2)

	if var_68_0 then
		local var_68_1

		if var_68_0:IsWalkable() then
			PoolMgr.GetInstance():GetPrefab("chapter/cell_quad", "", false, function(arg_69_0)
				var_68_1 = arg_69_0.transform

				return
			end)

			;(nil).name = ChapterCell.Line2QuadName(arg_68_1, arg_68_2)

			;(nil):SetParent(arg_68_0.quadRoot, false)

			;(nil).sizeDelta = arg_68_0.contextData.chapterVO.theme.cellSize
			;(nil).anchoredPosition = arg_68_0.contextData.chapterVO.theme:GetLinePosition(arg_68_1, arg_68_2)

			;(nil):SetAsLastSibling()
			onButton(arg_68_0, nil, function()
				if arg_68_0:isfrozen() then
					return
				end

				arg_68_0:ClickGridCell(var_68_0)

				return
			end, SFX_CONFIRM)
		end

		local var_68_2 = ChapterCell.Line2Name(arg_68_1, arg_68_2)
		local var_68_3

		PoolMgr.GetInstance():GetPrefab("chapter/cell", "", false, function(arg_71_0)
			var_68_3 = arg_71_0.transform

			return
		end)

		;(nil).name = var_68_2

		;(nil):SetParent(arg_68_0.cellRoot, false)

		;(nil).sizeDelta = arg_68_0.contextData.chapterVO.theme.cellSize
		;(nil).anchoredPosition = arg_68_0.contextData.chapterVO.theme:GetLinePosition(arg_68_1, arg_68_2)

		;(nil):SetAsLastSibling()

		local var_68_4 = (nil):Find(ChapterConst.ChildItem)

		var_68_4.localEulerAngles = Vector3(-arg_68_0.contextData.chapterVO.theme.angle, 0, 0)

		setActive(var_68_4, var_68_0.item)

		local var_68_5 = ItemCell.New(var_68_4, arg_68_1, arg_68_2)

		arg_68_0.itemCells[ChapterCell.Line2Name(arg_68_1, arg_68_2)] = var_68_5
		var_68_5.loader = arg_68_0.loader

		var_68_5:Init(var_68_0)

		;(nil):Find(ChapterConst.ChildAttachment).localEulerAngles = Vector3(-arg_68_0.contextData.chapterVO.theme.angle, 0, 0)
	end

	return
end

function var_0_0.clearCell(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = ChapterCell.Line2QuadName(arg_72_1, arg_72_2)
	local var_72_1 = arg_72_0.cellRoot:Find((ChapterCell.Line2Name(arg_72_1, arg_72_2)))
	local var_72_2 = arg_72_0.quadRoot:Find(var_72_0)

	if not IsNil(var_72_1) then
		PoolMgr.GetInstance():ReturnPrefab("chapter/cell", "", var_72_1.gameObject)
	end

	if not IsNil(var_72_2) then
		if arg_72_0.quadTws[var_72_0] then
			LeanTween.cancel(arg_72_0.quadTws[var_72_0].uniqueId)

			arg_72_0.quadTws[var_72_0] = nil
		end

		local var_72_3 = var_72_2:Find("grid"):GetComponent(typeof(Image))

		var_72_3.sprite = GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid")
		var_72_3.material = nil

		PoolMgr.GetInstance():ReturnPrefab("chapter/cell_quad", "", var_72_2.gameObject)
	end

	return
end

function var_0_0.UpdateItemCells(arg_73_0)
	if not arg_73_0.contextData.chapterVO then
		return
	end

	for iter_73_0, iter_73_1 in pairs(arg_73_0.itemCells) do
		local var_73_0 = iter_73_1:GetOriginalInfo()

		iter_73_1:UpdateAsset((ItemCell.TransformItemAsset(arg_73_0.contextData.chapterVO, var_73_0 and var_73_0.item)))
	end

	return
end

function var_0_0.updateAttachments(arg_74_0)
	for iter_74_0 = 0, ChapterConst.MaxRow - 1 do
		for iter_74_1 = 0, ChapterConst.MaxColumn - 1 do
			arg_74_0:updateAttachment(iter_74_0, iter_74_1)
		end
	end

	arg_74_0:updateExtraAttachments()
	arg_74_0:updateCoastalGunAttachArea()
	arg_74_0:displayEscapeGrid()

	return
end

function var_0_0.UpdateFloor(arg_75_0)
	for iter_75_0, iter_75_1 in pairs(arg_75_0.contextData.chapterVO.cells) do
		for iter_75_2, iter_75_3 in pairs((iter_75_1:GetFlagList())) do
			local var_75_0 = ({})[iter_75_3]

			if not ({})[iter_75_3] then
				var_75_0 = {}
			end

			;({})[iter_75_3] = var_75_0

			table.insert(({})[iter_75_3], iter_75_1)
		end
	end

	if ({})[ChapterConst.FlagBanaiAirStrike] and next(({})[ChapterConst.FlagBanaiAirStrike]) then
		arg_75_0:hideQuadMark(ChapterConst.MarkBanaiAirStrike)
		arg_75_0:showQuadMark(({})[ChapterConst.FlagBanaiAirStrike], ChapterConst.MarkBanaiAirStrike, "cell_coastal_gun", Vector2(110, 110), nil, true)
	end

	arg_75_0:updatePoisonArea()

	if ({})[ChapterConst.FlagLava] and next(({})[ChapterConst.FlagLava]) then
		arg_75_0:hideQuadMark(ChapterConst.MarkLava)
		arg_75_0:showQuadMark(({})[ChapterConst.FlagLava], ChapterConst.MarkLava, "cell_lava", Vector2(110, 110), nil, true)
	end

	if ({})[ChapterConst.FlagNightmare] and next(({})[ChapterConst.FlagNightmare]) then
		arg_75_0:hideQuadMark(ChapterConst.MarkNightMare)
		arg_75_0:hideQuadMark(ChapterConst.MarkHideNight)

		local var_75_1 = arg_75_0.contextData.chapterVO:getExtraFlags()

		if table.contains(var_75_1, ChapterConst.StatusDay) then
			arg_75_0:showQuadMark(({})[ChapterConst.FlagNightmare], ChapterConst.MarkHideNight, "cell_hidden_nightmare", Vector2(110, 110), nil, true)
		elseif table.contains(var_75_1, ChapterConst.StatusNight) then
			arg_75_0:showQuadMark(({})[ChapterConst.FlagNightmare], ChapterConst.MarkNightMare, "cell_nightmare", Vector2(110, 110), nil, true)
		end
	end

	local var_75_2 = {}

	for iter_75_4, iter_75_5 in pairs(arg_75_0.contextData.chapterVO:GetChapterCellAttachemnts()) do
		if iter_75_5.data == ChapterConst.StoryTrigger then
			assert(pg.map_event_template[iter_75_5.attachmentId], "map_event_template not exists " .. iter_75_5.attachmentId)

			if pg.map_event_template[iter_75_5.attachmentId] and pg.map_event_template[iter_75_5.attachmentId].c_type == ChapterConst.EvtType_AdditionalFloor then
				var_75_2[pg.map_event_template[iter_75_5.attachmentId].icon] = var_75_2[pg.map_event_template[iter_75_5.attachmentId].icon] or {}

				table.insert(var_75_2[pg.map_event_template[iter_75_5.attachmentId].icon], iter_75_5)
			end
		end
	end

	for iter_75_6, iter_75_7 in pairs(var_75_2) do
		arg_75_0:hideQuadMark(iter_75_6)
		arg_75_0:showQuadMark(iter_75_7, iter_75_6, iter_75_6, Vector2(110, 110), nil, true)
	end

	local var_75_3 = arg_75_0.contextData.chapterVO:getConfig("alarm_cell")

	if var_75_3 and #var_75_3 > 0 then
		arg_75_0:ClearEdges(var_75_3[3])
		arg_75_0:ClearEdges(var_75_3[3] .. "corner")
		arg_75_0:AddEdgePool(var_75_3[3], "chapter/celltexture/" .. var_75_3[3], "")
		arg_75_0:AddEdgePool(var_75_3[3] .. "_corner", "chapter/celltexture/" .. var_75_3[3] .. "_corner", "")

		local var_75_4 = _.map(var_75_3[1], function(arg_76_0)
			return {
				row = arg_76_0[1],
				column = arg_76_0[2]
			}
		end)

		arg_75_0:AddOutlines(var_75_4, nil, var_75_3[5], var_75_3[4], var_75_3[3])
		arg_75_0:hideQuadMark(var_75_3[2])
		arg_75_0:showQuadMark(var_75_4, var_75_3[2], var_75_3[2], Vector2(104, 104), nil, true)
	end

	arg_75_0:HideMissileAimingMarks()

	if ({})[ChapterConst.FlagMissleAiming] and next(({})[ChapterConst.FlagMissleAiming]) then
		arg_75_0:ShowMissileAimingMarks(({})[ChapterConst.FlagMissleAiming])
	end

	local var_75_5 = arg_75_0.contextData.chapterVO.fleet

	if arg_75_0.contextData.chapterVO:isPlayingWithBombEnemy() then
		arg_75_0:showQuadMark(_.map({
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
				row = arg_77_0[1] + var_75_5.line.row,
				column = arg_77_0[2] + var_75_5.line.column
			}
		end), ChapterConst.MarkBomb, "cell_bomb", Vector2(100, 100), nil, true)
	end

	return
end

function var_0_0.updateExtraAttachments(arg_78_0)
	for iter_78_0, iter_78_1 in pairs((arg_78_0.contextData.chapterVO:GetChapterCellAttachemnts())) do
		local var_78_0 = arg_78_0.cellRoot:Find(iter_78_0):Find(ChapterConst.ChildAttachment)
		local var_78_1

		if iter_78_1.data == ChapterConst.StoryTrigger and pg.map_event_template[iter_78_1.attachmentId].c_type ~= ChapterConst.EvtType_AdditionalFloor then
			var_78_1 = MapEventStoryTriggerCellView
		end

		local var_78_2 = arg_78_0.extraAttachmentCells[iter_78_0]

		if arg_78_0.extraAttachmentCells[iter_78_0] and var_78_2.class ~= var_78_1 then
			var_78_2:Clear()

			var_78_2 = nil
			arg_78_0.extraAttachmentCells[iter_78_0] = nil
		end

		if var_78_1 then
			if not var_78_2 then
				var_78_2 = var_78_1.New(var_78_0)
				arg_78_0.extraAttachmentCells[iter_78_0] = var_78_2
			end

			var_78_2.info = iter_78_1
			var_78_2.chapter = arg_78_0.contextData.chapterVO

			var_78_2:SetLine({
				row = iter_78_1.row,
				column = iter_78_1.column
			})
			var_78_2:Update()
		end
	end

	return
end

function var_0_0.updateAttachment(arg_79_0, arg_79_1, arg_79_2)
	local var_79_0 = arg_79_0.contextData.chapterVO
	local var_79_1 = arg_79_0.contextData.chapterVO:getChapterCell(arg_79_1, arg_79_2)

	if not var_79_1 then
		return
	end

	local var_79_2 = ChapterCell.Line2Name(arg_79_1, arg_79_2)
	local var_79_3 = arg_79_0.cellRoot:Find(var_79_2):Find(ChapterConst.ChildAttachment)
	local var_79_4
	local var_79_5 = {}

	if ChapterConst.IsEnemyAttach(var_79_1.attachment) then
		local var_79_6 = pg.expedition_data_template[var_79_1.attachmentId]

		assert(pg.expedition_data_template[var_79_1.attachmentId], "expedition_data_template not exist: " .. var_79_1.attachmentId)

		if var_79_1.flag == ChapterConst.CellFlagDisabled then
			if var_79_1.attachment ~= ChapterConst.AttachAmbush then
				var_79_4 = EnemyDeadCellView
				var_79_5.chapter = var_79_0
				var_79_5.config = var_79_6
			end
		elseif var_79_1.flag == ChapterConst.CellFlagActive then
			var_79_4 = var_79_6.icon_type == 1 and StaticEggCellView or StaticChampionCellView
			var_79_5.config = var_79_6
			var_79_5.chapter = var_79_0
			var_79_5.viewParent = arg_79_0
		end
	elseif var_79_1.attachment == ChapterConst.AttachBox then
		var_79_4 = AttachmentBoxCell
	elseif var_79_1.attachment == ChapterConst.AttachSupply then
		var_79_4 = AttachmentSupplyCell
	elseif var_79_1.attachment == ChapterConst.AttachTransport_Target then
		var_79_4 = AttachmentTransportTargetCell
	elseif var_79_1.attachment == ChapterConst.AttachStory then
		if var_79_1.data == ChapterConst.Story then
			var_79_4 = MapEventStoryCellView
		elseif var_79_1.data == ChapterConst.StoryObstacle then
			var_79_4 = MapEventStoryObstacleCellView
			var_79_5.chapter = var_79_0
		end
	elseif var_79_1.attachment == ChapterConst.AttachBomb_Enemy then
		var_79_4 = AttachmentBombEnemyCell
	elseif var_79_1.attachment == ChapterConst.AttachLandbase then
		assert(pg.land_based_template[var_79_1.attachmentId], "land_based_template not exist: " .. var_79_1.attachmentId)

		if pg.land_based_template[var_79_1.attachmentId].type == ChapterConst.LBCoastalGun then
			var_79_4 = AttachmentLBCoastalGunCell
		elseif pg.land_based_template[var_79_1.attachmentId].type == ChapterConst.LBHarbor then
			var_79_4 = AttachmentLBHarborCell
		elseif pg.land_based_template[var_79_1.attachmentId].type == ChapterConst.LBDock then
			var_79_4 = AttachmentLBDockCell
			var_79_5.chapter = var_79_0
		elseif pg.land_based_template[var_79_1.attachmentId].type == ChapterConst.LBAntiAir then
			var_79_4 = AttachmentLBAntiAirCell
			var_79_5.info = var_79_1
			var_79_5.chapter = var_79_0
			var_79_5.grid = arg_79_0
		elseif pg.land_based_template[var_79_1.attachmentId].type == ChapterConst.LBFogLightBase then
			var_79_4 = AttachmentLBFogLightBase
		elseif pg.land_based_template[var_79_1.attachmentId].type == ChapterConst.LBIdle and var_79_1.attachmentId == ChapterConst.LBIDAirport then
			var_79_4 = AttachmentLBAirport
			var_79_5.extraFlagList = var_79_0:getExtraFlags()
		end
	elseif var_79_1.attachment == ChapterConst.AttachBarrier then
		var_79_4 = AttachmentBarrierCell
	elseif var_79_1.attachment == ChapterConst.AttachNone then
		var_79_5.fadeAnim = (function()
			if not arg_79_0.attachmentCells[var_79_2] then
				return
			end

			if arg_79_0.attachmentCells[var_79_2].class ~= StaticEggCellView and arg_79_0.attachmentCells[var_79_2].class ~= StaticChampionCellView then
				return
			end

			local var_80_0 = arg_79_0.attachmentCells[var_79_2].info

			if not arg_79_0.attachmentCells[var_79_2].info then
				return
			end

			return pg.expedition_data_template[var_80_0.attachmentId].dungeon_id == 0
		end)()
	end

	if var_79_5.fadeAnim then
		arg_79_0:PlayAttachmentEffect(arg_79_1, arg_79_2, "miwuxiaosan")
	end

	local var_79_7 = arg_79_0.attachmentCells[var_79_2]

	if arg_79_0.attachmentCells[var_79_2] and var_79_7.class ~= var_79_4 then
		var_79_7:Clear()

		var_79_7 = nil
		arg_79_0.attachmentCells[var_79_2] = nil
	end

	if var_79_4 then
		if not var_79_7 then
			var_79_7 = var_79_4.New(var_79_3)

			var_79_7:SetLine({
				row = arg_79_1,
				column = arg_79_2
			})

			arg_79_0.attachmentCells[var_79_2] = var_79_7
		end

		var_79_7.info = var_79_1

		for iter_79_0, iter_79_1 in pairs(var_79_5) do
			var_79_7[iter_79_0] = iter_79_1
		end

		var_79_7:Update()
	end

	return
end

function var_0_0.InitWalls(arg_81_0)
	for iter_81_0 = arg_81_0.indexMin.x, arg_81_0.indexMax.x do
		for iter_81_1 = arg_81_0.indexMin.y, arg_81_0.indexMax.y do
			local var_81_0 = arg_81_0.contextData.chapterVO:GetRawChapterCell(iter_81_0, iter_81_1)

			if var_81_0 then
				while ChapterConst.ForbiddenUp > 0 do
					arg_81_0:InitWallDirection(var_81_0, ChapterConst.ForbiddenUp)
				end
			end
		end
	end

	for iter_81_2, iter_81_3 in pairs(arg_81_0.walls) do
		if iter_81_3.WallPrefabs then
			iter_81_3:SetAsset(iter_81_3.WallPrefabs[5 - iter_81_3.BanCount])
		end
	end

	return
end

local var_0_3 = {
	[ChapterConst.ForbiddenUp] = {
		-1,
		0
	},
	[ChapterConst.ForbiddenDown] = {
		1,
		0
	},
	[ChapterConst.ForbiddenLeft] = {
		0,
		-1
	},
	[ChapterConst.ForbiddenRight] = {
		0,
		1
	}
}

function var_0_0.InitWallDirection(arg_82_0, arg_82_1, arg_82_2)
	local var_82_0 = arg_82_0.contextData.chapterVO

	if bit.band(arg_82_1.forbiddenDirections, arg_82_2) == 0 then
		return
	end

	if arg_82_1.walkable == false then
		return
	end

	local var_82_1 = var_0_3[arg_82_2]
	local var_82_2 = 2 * arg_82_1.row + var_0_3[arg_82_2][1]
	local var_82_3 = 2 * arg_82_1.column + var_0_3[arg_82_2][2]
	local var_82_4 = var_82_0:GetRawChapterCell(arg_82_1.row + var_0_3[arg_82_2][1], arg_82_1.column + var_0_3[arg_82_2][2])
	local var_82_5 = not var_82_4 or var_82_4.walkable == false
	local var_82_6 = 2 * arg_82_1.row + var_0_3[arg_82_2][1] .. "_" .. 2 * arg_82_1.column + var_0_3[arg_82_2][2]
	local var_82_7 = arg_82_0.walls[2 * arg_82_1.row + var_0_3[arg_82_2][1] .. "_" .. 2 * arg_82_1.column + var_0_3[arg_82_2][2]]

	if not arg_82_0.walls[2 * arg_82_1.row + var_0_3[arg_82_2][1] .. "_" .. 2 * arg_82_1.column + var_0_3[arg_82_2][2]] then
		local var_82_8 = var_82_0.theme:GetLinePosition(arg_82_1.row, arg_82_1.column)

		var_82_8.x = var_82_8.x + var_82_1[2] * (var_82_0.theme.cellSize.x + var_82_0.theme.cellSpace.x) * 0.5
		var_82_8.y = var_82_8.y - var_82_1[1] * (var_82_0.theme.cellSize.y + var_82_0.theme.cellSpace.y) * 0.5

		local var_82_9 = WallCell.New(var_82_2, var_82_3, bit.band(arg_82_2, ChapterConst.ForbiddenRow) > 0, var_82_8)

		var_82_9.girdParent = arg_82_0
		arg_82_0.walls[var_82_6] = var_82_9
		var_82_7 = var_82_9

		if var_82_0.wallAssets[arg_82_1.row .. "_" .. arg_82_1.column] then
			var_82_7.WallPrefabs = var_82_0.wallAssets[arg_82_1.row .. "_" .. arg_82_1.column]
		end
	end

	var_82_7.BanCount = var_82_7.BanCount + (var_82_5 and 2 or 1)

	return
end

function var_0_0.UpdateWeatherCells(arg_83_0, arg_83_1)
	arg_83_1 = arg_83_1 or underscore.keys(arg_83_0.contextData.chapterVO.cells)

	local var_83_0 = arg_83_0.contextData.chapterVO:IsFogStage()

	for iter_83_0, iter_83_1 in ipairs(arg_83_1) do
		local var_83_1
		local var_83_2 = arg_83_0.contextData.chapterVO.cells[iter_83_1]:GetWeatherFlagList()

		if #var_83_2 > 0 then
			var_83_1 = MapWeatherCellView
		end

		local var_83_3 = arg_83_0.weatherCells[iter_83_1]

		if arg_83_0.weatherCells[iter_83_1] and var_83_3.class ~= var_83_1 then
			var_83_3:Clear()

			var_83_3 = nil
			arg_83_0.weatherCells[iter_83_1] = nil
		end

		if var_83_1 then
			if not var_83_3 then
				local var_83_4 = arg_83_0.cellRoot:Find(iter_83_1)

				var_83_3 = var_83_1.New((var_83_4:Find(ChapterConst.ChildAttachment)))

				var_83_3:SetLine({
					row = arg_83_0.contextData.chapterVO.cells[iter_83_1].row,
					column = arg_83_0.contextData.chapterVO.cells[iter_83_1].column
				})

				arg_83_0.weatherCells[iter_83_1] = var_83_3
			end

			var_83_3.info = arg_83_0.contextData.chapterVO.cells[iter_83_1]

			var_83_3:Update(var_83_2)
		end

		if var_83_0 and tobool((arg_83_0.contextData.chapterVO:GetEnemy(arg_83_0.contextData.chapterVO.cells[iter_83_1].row, arg_83_0.contextData.chapterVO.cells[iter_83_1].column))) then
			arg_83_0:updateAttachment(arg_83_0.contextData.chapterVO.cells[iter_83_1].row, arg_83_0.contextData.chapterVO.cells[iter_83_1].column)
		end
	end

	return
end

function var_0_0.updateFogCells(arg_84_0)
	for iter_84_0, iter_84_1 in pairs(arg_84_0.contextData.chapterVO.cells) do
		local var_84_0 = arg_84_0.cellRoot:Find((ChapterCell.Line2Name(iter_84_1.row, iter_84_1.column)))

		setImageAlpha(var_84_0:Find(ChapterConst.ChildVisible .. "/mask"), iter_84_1:IsVisible() and 0 or 0.4)
	end

	return
end

function var_0_0.updateQuadCells(arg_85_0, arg_85_1)
	arg_85_1 = arg_85_1 or ChapterConst.QuadStateNormal
	arg_85_0.quadState = arg_85_1

	arg_85_0:updateQuadBase()

	if arg_85_1 == ChapterConst.QuadStateNormal then
		arg_85_0:UpdateQuadStateNormal()
	elseif arg_85_1 == ChapterConst.QuadStateBarrierSetting then
		arg_85_0:UpdateQuadStateBarrierSetting()
	elseif arg_85_1 == ChapterConst.QuadStateTeleportSub then
		arg_85_0:UpdateQuadStateTeleportSub()
	elseif arg_85_1 == ChapterConst.QuadStateMissileStrike or arg_85_1 == ChapterConst.QuadStateAirSuport then
		arg_85_0:UpdateQuadStateMissileStrike()
	elseif arg_85_1 == ChapterConst.QuadStateExpel then
		arg_85_0:UpdateQuadStateAirExpel()
	end

	arg_85_0:UpdateOpBtns()

	return
end

function var_0_0.PlayQuadsParallelAnim(arg_86_0, arg_86_1)
	arg_86_0:frozen()
	table.ParallelIpairsAsync(arg_86_1, function(arg_87_0, arg_87_1, arg_87_2)
		local var_87_0 = ChapterCell.Line2QuadName(arg_87_1.row, arg_87_1.column)
		local var_87_1 = arg_86_0.quadRoot:Find(var_87_0)

		arg_86_0:cancelQuadTween(var_87_0, var_87_1)
		setImageAlpha(var_87_1, 0.4)

		;({}).uniqueId = LeanTween.scale(var_87_1, Vector3.one, 0.2):setFrom(Vector3.zero):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_87_2)).uniqueId
		arg_86_0.presentTws[var_87_0] = {}

		return
	end, function()
		arg_86_0:unfrozen()

		return
	end)

	return
end

function var_0_0.updateQuadBase(arg_89_0)
	local var_89_0 = arg_89_0.contextData.chapterVO

	if arg_89_0.contextData.chapterVO.fleet == nil then
		return
	end

	arg_89_0:killPresentTws()

	for iter_89_0, iter_89_1 in pairs(arg_89_0.contextData.chapterVO.cells) do
		(function(arg_90_0)
			if not arg_90_0 or not arg_90_0:IsWalkable() then
				return
			end

			local var_90_0 = arg_90_0.row
			local var_90_1 = ChapterCell.Line2QuadName(arg_90_0.row, arg_90_0.column)
			local var_90_2 = arg_89_0.quadRoot:Find(var_90_1)

			var_90_2.localScale = Vector3.one

			local var_90_3 = var_90_2:Find("grid"):GetComponent(typeof(Image))
			local var_90_4 = var_89_0:getChampion(var_90_0, arg_90_0.column)

			if var_90_4 and var_90_4.flag == ChapterConst.CellFlagActive and var_90_4.trait ~= ChapterConst.TraitLurk and var_89_0:getChampionVisibility(var_90_4) and not var_89_0:existFleet(FleetType.Transport, var_90_0, arg_90_0.column) then
				arg_89_0:startQuadTween(var_90_1, var_90_2)
				setImageSprite(var_90_2, GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_enemy"))
				setImageSprite(var_90_2:Find("grid"), GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_enemy_grid"))

				var_90_3.material = arg_89_0.material_Add

				return
			end

			local var_90_5 = var_89_0:GetRawChapterAttachemnt(var_90_0, arg_90_0.column)

			if var_90_5 then
				local var_90_6 = var_89_0:getQuadCellPic(var_90_5)

				if var_90_6 then
					arg_89_0:startQuadTween(var_90_1, var_90_2)
					setImageSprite(var_90_2, GetSpriteFromAtlas("chapter/pic/cellgrid", var_90_6))

					return
				end
			end

			if var_89_0:getChapterCell(var_90_0, arg_90_0.column) then
				local var_90_7 = var_89_0:getQuadCellPic(arg_90_0)

				if var_90_7 then
					arg_89_0:startQuadTween(var_90_1, var_90_2)

					if var_90_7 == "cell_enemy" then
						setImageSprite(var_90_2:Find("grid"), GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_enemy_grid"))

						var_90_3.material = arg_89_0.material_Add
					else
						setImageSprite(var_90_2:Find("grid"), GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid"))

						var_90_3.material = nil
					end

					setImageSprite(var_90_2, GetSpriteFromAtlas("chapter/pic/cellgrid", var_90_7))

					return
				end
			end

			arg_89_0:cancelQuadTween(var_90_1, var_90_2)
			setImageAlpha(var_90_2, ChapterConst.CellEaseOutAlpha)
			setImageSprite(var_90_2, GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_normal"))
			setImageSprite(var_90_2:Find("grid"), GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid"))

			var_90_3.material = nil

			return
		end)(iter_89_1)
	end

	if arg_89_0.contextData.chapterVO:isPlayingWithBombEnemy() then
		arg_89_0:hideQuadMark(ChapterConst.MarkBomb)
	end

	return
end

function var_0_0.UpdateQuadStateNormal(arg_91_0)
	local var_91_0 = arg_91_0.contextData.chapterVO
	local var_91_1 = arg_91_0.contextData.chapterVO.fleet
	local var_91_2

	if arg_91_0.contextData.chapterVO:existMoveLimit() and not arg_91_0.contextData.chapterVO:checkAnyInteractive() then
		var_91_2 = arg_91_0.contextData.chapterVO:calcWalkableCells(ChapterConst.SubjectPlayer, arg_91_0.contextData.chapterVO.fleet.line.row, arg_91_0.contextData.chapterVO.fleet.line.column, arg_91_0.contextData.chapterVO.fleet:getSpeed())
	end

	if not var_91_2 or #var_91_2 == 0 then
		return
	end

	local var_91_3 = ManhattonDist(_.min(var_91_2, function(arg_92_0)
		return ManhattonDist(arg_92_0, var_91_1.line)
	end), arg_91_0.contextData.chapterVO.fleet.line)

	_.each(var_91_2, function(arg_93_0)
		local var_93_0 = ChapterCell.Line2QuadName(arg_93_0.row, arg_93_0.column)
		local var_93_1 = arg_91_0.quadRoot:Find(var_93_0)

		arg_91_0:cancelQuadTween(var_93_0, var_93_1)
		setImageSprite(var_93_1, GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_normal"))

		local var_93_2 = var_93_1:Find("grid"):GetComponent(typeof(Image))

		var_93_2.sprite = GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid")
		var_93_2.material = nil

		setImageAlpha(var_93_1, var_91_0:getRound() == ChapterConst.RoundPlayer and 1 or ChapterConst.CellEaseOutAlpha)

		var_93_1.localScale = Vector3.zero
		;({}).uniqueId = LeanTween.scale(var_93_1, Vector3.one, 0.2):setFrom(Vector3.zero):setEase(LeanTweenType.easeInOutSine):setDelay((ManhattonDist(arg_93_0, var_91_1.line) - var_91_3) * 0.1).uniqueId
		arg_91_0.presentTws[var_93_0] = {}

		return
	end)

	return
end

function var_0_0.UpdateQuadStateBarrierSetting(arg_94_0)
	local var_94_0 = arg_94_0.contextData.chapterVO.fleet
	local var_94_1 = arg_94_0.contextData.chapterVO:calcSquareBarrierCells(arg_94_0.contextData.chapterVO.fleet.line.row, arg_94_0.contextData.chapterVO.fleet.line.column, 1)

	if not var_94_1 or #var_94_1 == 0 then
		return
	end

	local var_94_2 = ManhattonDist(_.min(var_94_1, function(arg_95_0)
		return ManhattonDist(arg_95_0, var_94_0.line)
	end), arg_94_0.contextData.chapterVO.fleet.line)

	_.each(var_94_1, function(arg_96_0)
		local var_96_0 = ChapterCell.Line2QuadName(arg_96_0.row, arg_96_0.column)
		local var_96_1 = arg_94_0.quadRoot:Find(var_96_0)

		arg_94_0:cancelQuadTween(var_96_0, var_96_1)
		setImageSprite(var_96_1, GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_barrier_select"))

		local var_96_2 = var_96_1:Find("grid"):GetComponent(typeof(Image))

		var_96_2.sprite = GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid")
		var_96_2.material = nil

		setImageAlpha(var_96_1, 1)

		var_96_1.localScale = Vector3.zero
		;({}).uniqueId = LeanTween.scale(var_96_1, Vector3.one, 0.2):setFrom(Vector3.zero):setEase(LeanTweenType.easeInOutSine):setDelay((ManhattonDist(arg_96_0, var_94_0.line) - var_94_2) * 0.1).uniqueId
		arg_94_0.presentTws[var_96_0] = {}

		return
	end)

	return
end

function var_0_0.UpdateQuadStateTeleportSub(arg_97_0)
	local var_97_0 = arg_97_0.contextData.chapterVO
	local var_97_1 = _.detect(arg_97_0.contextData.chapterVO.fleets, function(arg_98_0)
		return arg_98_0:getFleetType() == FleetType.Submarine
	end)

	if not var_97_1 then
		return
	end

	arg_97_0:PlayQuadsParallelAnim((_.filter(arg_97_0.contextData.chapterVO:calcWalkableCells(nil, var_97_1.line.row, var_97_1.line.column, ChapterConst.MaxStep), function(arg_99_0)
		return not var_97_0:getQuadCellPic(var_97_0:getChapterCell(arg_99_0.row, arg_99_0.column))
	end)))

	return
end

function var_0_0.UpdateQuadStateMissileStrike(arg_100_0)
	arg_100_0:PlayQuadsParallelAnim((_.filter(_.values(arg_100_0.contextData.chapterVO.cells), function(arg_101_0)
		return arg_101_0:IsWalkable() and not var_0:getQuadCellPic(arg_101_0)
	end)))

	return
end

function var_0_0.UpdateQuadStateAirExpel(arg_102_0)
	local var_102_0 = arg_102_0.contextData.chapterVO

	if arg_102_0.airSupportTarget then
		if not arg_102_0.airSupportTarget.source then
			arg_102_0:PlayQuadsParallelAnim((_.filter(_.values(arg_102_0.contextData.chapterVO.cells), function(arg_103_0)
				return arg_103_0:IsWalkable() and not var_102_0:getQuadCellPic(arg_103_0)
			end)))

			return
		end

		arg_102_0:PlayQuadsParallelAnim((arg_102_0.contextData.chapterVO:calcWalkableCells(ChapterConst.SubjectChampion, arg_102_0.airSupportTarget.source.row, arg_102_0.airSupportTarget.source.column, 1)))

		return
	end
end

function var_0_0.ClickGridCell(arg_104_0, arg_104_1)
	if arg_104_0.quadState == ChapterConst.QuadStateBarrierSetting then
		arg_104_0:OnBarrierSetting(arg_104_1)
	elseif arg_104_0.quadState == ChapterConst.QuadStateTeleportSub then
		arg_104_0:OnTeleportConfirm(arg_104_1)
	elseif arg_104_0.quadState == ChapterConst.QuadStateMissileStrike then
		arg_104_0:OnMissileAiming(arg_104_1)
	elseif arg_104_0.quadState == ChapterConst.QuadStateAirSuport then
		arg_104_0:OnAirSupportAiming(arg_104_1)
	elseif arg_104_0.quadState == ChapterConst.QuadStateExpel then
		arg_104_0:OnAirExpelSelect(arg_104_1)
	else
		arg_104_0:emit(LevelUIConst.ON_CLICK_GRID_QUAD, arg_104_1)
	end

	return
end

function var_0_0.OnBarrierSetting(arg_105_0, arg_105_1)
	if not _.any(arg_105_0.contextData.chapterVO:calcSquareBarrierCells(arg_105_0.contextData.chapterVO.fleet.line.row, arg_105_0.contextData.chapterVO.fleet.line.column, 1), function(arg_106_0)
		return arg_106_0.row == arg_105_1.row and arg_106_0.column == arg_105_1.column
	end) then
		return
	end

	;(function(arg_107_0, arg_107_1)
		newChapterVO = arg_105_0.contextData.chapterVO

		if not newChapterVO:existBarrier(arg_107_0, arg_107_1) and newChapterVO.modelCount <= 0 then
			return
		end

		arg_105_0:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpBarrier,
			id = newChapterVO.fleet.id,
			arg1 = arg_107_0,
			arg2 = arg_107_1
		})

		return
	end)(arg_105_1.row, arg_105_1.column)

	return
end

function var_0_0.PrepareSubTeleport(arg_108_0)
	local var_108_0 = arg_108_0.contextData.chapterVO
	local var_108_1 = arg_108_0.contextData.chapterVO:GetSubmarineFleet()
	local var_108_2 = arg_108_0.cellFleets[var_108_1.id]
	local var_108_3 = var_108_1.startPos

	for iter_108_0, iter_108_1 in pairs(arg_108_0.contextData.chapterVO.fleets) do
		if iter_108_1:getFleetType() == FleetType.Normal then
			arg_108_0:updateFleet(iter_108_1.id)
		end
	end

	local var_108_4 = var_108_0:existEnemy(ChapterConst.SubjectPlayer, var_108_3.row, var_108_3.column) or var_108_0:existFleet(FleetType.Normal, var_108_3.row, var_108_3.column)

	setActive(var_108_2.tfAmmo, not var_108_4)
	var_108_2:SetActiveModel(true)

	if var_108_0.subAutoAttack ~= 1 then
		arg_108_0:PlaySubAnimation(var_108_2, false, function()
			var_108_2:SetActiveModel(not var_108_4)

			return
		end)
	else
		var_108_2:SetActiveModel(not var_108_4)
	end

	var_108_2.tf.localPosition = var_108_0.theme:GetLinePosition(var_108_3.row, var_108_3.column)

	var_108_2:ResetCanvasOrder()

	return
end

function var_0_0.TurnOffSubTeleport(arg_110_0)
	arg_110_0.subTeleportTargetLine = nil

	local var_110_0 = arg_110_0.contextData.chapterVO

	arg_110_0:hideQuadMark(ChapterConst.MarkMovePathArrow)
	arg_110_0:hideQuadMark(ChapterConst.MarkHuntingRange)
	arg_110_0:ClearEdges("SubmarineHunting")
	arg_110_0:UpdateDestinationMark()

	local var_110_1 = var_110_0:GetSubmarineFleet()
	local var_110_2 = arg_110_0.cellFleets[var_110_1.id]
	local var_110_3 = var_110_0.subAutoAttack == 1

	arg_110_0.cellFleets[var_110_1.id]:SetActiveModel(var_110_0.subAutoAttack == 1)

	if not var_110_3 then
		arg_110_0:PlaySubAnimation(var_110_2, true, function()
			arg_110_0:updateFleet(var_110_1.id)

			return
		end)
	else
		arg_110_0:updateFleet(var_110_1.id)
	end

	arg_110_0:ShowHuntingRange()

	return
end

function var_0_0.OnTeleportConfirm(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_0.contextData.chapterVO:getChapterCell(arg_112_1.row, arg_112_1.column)

	if var_112_0 and var_112_0:IsWalkable() and not arg_112_0.contextData.chapterVO:existBarrier(arg_112_1.row, arg_112_1.column) then
		local var_112_1 = arg_112_0.contextData.chapterVO:GetSubmarineFleet()

		if var_112_1.startPos.row == arg_112_1.row and var_112_1.startPos.column == arg_112_1.column then
			return
		end

		local var_112_2, var_112_3 = arg_112_0.contextData.chapterVO:findPath(nil, var_112_1.startPos, arg_112_1)

		if var_112_2 >= PathFinding.PrioObstacle or arg_112_1.row ~= var_112_3[#var_112_3].row or arg_112_1.column ~= var_112_3[#var_112_3].column then
			return
		end

		arg_112_0:ShowTargetHuntingRange(arg_112_1)
		arg_112_0:UpdateDestinationMark(arg_112_1)

		if var_112_2 > 0 then
			arg_112_0:ShowPathInArrows(var_112_3)

			arg_112_0.subTeleportTargetLine = arg_112_1
		end
	end

	return
end

function var_0_0.ShowPathInArrows(arg_113_0, arg_113_1)
	local var_113_0 = Clone(arg_113_1)

	table.remove(var_113_0, #var_113_0)

	for iter_113_0 = #var_113_0, 1, -1 do
		local var_113_1 = arg_113_0.contextData.chapterVO:existEnemy(ChapterConst.SubjectPlayer, var_113_0[iter_113_0].row, var_113_0[iter_113_0].column) or arg_113_0.contextData.chapterVO:getFleet(FleetType.Normal, var_113_0[iter_113_0].row, var_113_0[iter_113_0].column)

		if var_113_1 then
			table.remove(var_113_0, iter_113_0)
		end
	end

	arg_113_0:hideQuadMark(ChapterConst.MarkMovePathArrow)
	arg_113_0:showQuadMark(var_113_0, ChapterConst.MarkMovePathArrow, "cell_path_arrow", Vector2(100, 100), nil, true)

	for iter_113_1 = #arg_113_1, 1, -1 do
		local var_113_2 = ChapterCell.Line2MarkName(arg_113_1[iter_113_1].row, arg_113_1[iter_113_1].column, ChapterConst.MarkMovePathArrow)
		local var_113_3 = arg_113_0.markQuads[ChapterConst.MarkMovePathArrow] and arg_113_0.markQuads[ChapterConst.MarkMovePathArrow][var_113_2]

		if arg_113_0.markQuads[ChapterConst.MarkMovePathArrow] and arg_113_0.markQuads[ChapterConst.MarkMovePathArrow][var_113_2] then
			local var_113_4 = Vector3.Normalize(Vector3(arg_113_1[iter_113_1 + 1].column - arg_113_1[iter_113_1].column, arg_113_1[iter_113_1].row - arg_113_1[iter_113_1 + 1].row, 0))

			var_113_3.localEulerAngles = Vector3(0, 0, Mathf.Acos((Vector3.Dot(var_113_4, Vector3.up))) * Mathf.Rad2Deg * (Vector3.Cross(Vector3.up, var_113_4).z > 0 and 1 or -1))
		end
	end

	return
end

function var_0_0.ShowMissileAimingMarks(arg_114_0, arg_114_1)
	_.each(arg_114_1, function(arg_115_0)
		arg_114_0.loader:GetPrefabBYGroup("ui/miaozhun02", "miaozhun02", function(arg_116_0)
			setParent(arg_116_0, arg_114_0.restrictMap)

			local var_116_0 = arg_114_0.contextData.chapterVO.theme:GetLinePosition(arg_115_0.row, arg_115_0.column)

			tf(arg_116_0).anchoredPosition = Vector2(var_116_0.x - arg_114_0.restrictMap.anchoredPosition.x, var_116_0.y - arg_114_0.restrictMap.anchoredPosition.y)

			return
		end, "MissileAimingMarks")

		return
	end)

	return
end

function var_0_0.HideMissileAimingMarks(arg_117_0)
	arg_117_0.loader:ReturnGroup("MissileAimingMarks")

	return
end

function var_0_0.ShowMissileAimingMark(arg_118_0, arg_118_1)
	arg_118_0.loader:GetPrefab("ui/miaozhun02", "miaozhun02", function(arg_119_0)
		setParent(arg_119_0, arg_118_0.restrictMap)

		local var_119_0 = arg_118_0.contextData.chapterVO.theme:GetLinePosition(arg_118_1.row, arg_118_1.column)

		tf(arg_119_0).anchoredPosition = Vector2(var_119_0.x - arg_118_0.restrictMap.anchoredPosition.x, var_119_0.y - arg_118_0.restrictMap.anchoredPosition.y)

		return
	end, "MissileAimingMark")

	return
end

function var_0_0.HideMissileAimingMark(arg_120_0)
	arg_120_0.loader:ClearRequest("MissileAimingMark")

	return
end

function var_0_0.OnMissileAiming(arg_121_0, arg_121_1)
	arg_121_0:HideMissileAimingMark()
	arg_121_0:ShowMissileAimingMark(arg_121_1)

	arg_121_0.missileStrikeTargetLine = arg_121_1

	return
end

function var_0_0.ShowAirSupportAimingMark(arg_122_0, arg_122_1)
	arg_122_0.loader:GetPrefab("ui/miaozhun03", "miaozhun03", function(arg_123_0)
		setParent(arg_123_0, arg_122_0.restrictMap)

		local var_123_0 = arg_122_0.contextData.chapterVO.theme:GetLinePosition(arg_122_1.row - 0.5, arg_122_1.column)

		tf(arg_123_0).anchoredPosition = Vector2(var_123_0.x - arg_122_0.restrictMap.anchoredPosition.x, var_123_0.y - arg_122_0.restrictMap.anchoredPosition.y)

		return
	end, "AirSupportAimingMark")

	return
end

function var_0_0.HideAirSupportAimingMark(arg_124_0)
	arg_124_0.loader:ClearRequest("AirSupportAimingMark")

	return
end

function var_0_0.OnAirSupportAiming(arg_125_0, arg_125_1)
	arg_125_0:HideAirSupportAimingMark()
	arg_125_0:ShowAirSupportAimingMark(arg_125_1)

	arg_125_0.missileStrikeTargetLine = arg_125_1

	return
end

function var_0_0.ShowAirExpelAimingMark(arg_126_0)
	local var_126_0 = arg_126_0.airSupportTarget

	if not arg_126_0.airSupportTarget or not arg_126_0.airSupportTarget.source then
		return
	end

	local var_126_1 = arg_126_0.cellRoot:Find((ChapterCell.Line2Name(arg_126_0.airSupportTarget.source.row, arg_126_0.airSupportTarget.source.column)))

	local function var_126_2(arg_127_0, arg_127_1)
		setParent(arg_127_0, var_126_1)

		GetOrAddComponent(arg_127_0, typeof(Canvas)).overrideSorting = true

		if not arg_127_1 then
			return
		end

		tf(arg_127_0).localEulerAngles = Vector3(-arg_126_0.contextData.chapterVO.theme.angle, 0, 0)

		return
	end

	arg_126_0.loader:GetPrefabBYGroup("leveluiview/tpl_airsupportmark", "tpl_airsupportmark", function(arg_128_0)
		var_126_2(arg_128_0, true)

		return
	end, "AirExpelAimingMark")
	arg_126_0.loader:GetPrefabBYGroup("leveluiview/tpl_airsupportdirection", "tpl_airsupportdirection", function(arg_129_0)
		var_126_2(arg_129_0)

		for iter_129_0 = 1, 4 do
			local var_129_0 = tf(arg_129_0):Find(iter_129_0)
			local var_129_1 = var_126_0 and arg_126_0.contextData.chapterVO:considerAsStayPoint(ChapterConst.SubjectChampion, var_0.row + ({
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
			})[iter_129_0][1], var_0.column + ({
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
			})[iter_129_0][2])

			setActive(var_129_0, var_129_1)
		end

		return
	end, "AirExpelAimingMark")

	return
end

function var_0_0.HideAirExpelAimingMark(arg_130_0)
	arg_130_0.loader:ReturnGroup("AirExpelAimingMark")

	return
end

function var_0_0.OnAirExpelSelect(arg_131_0, arg_131_1)
	arg_131_0.airSupportTarget = arg_131_0.airSupportTarget or {}

	local var_131_1 = var_131_0:GetEnemy(arg_131_1.row, arg_131_1.column)

	if var_131_1 then
		if ChapterConst.IsBossCell(var_131_1) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelscene_airexpel_select_boss"))

			return
		end

		if var_131_0:existFleet(FleetType.Normal, arg_131_1.row, arg_131_1.column) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelscene_airexpel_select_battle"))

			return
		end

		if arg_131_0.airSupportTarget.source and table.equal(arg_131_0.airSupportTarget.source:GetLine(), var_131_1:GetLine()) then
			var_131_1 = nil
		end

		arg_131_0.airSupportTarget.source = var_131_1

		;(function()
			arg_131_0:HideAirExpelAimingMark()
			arg_131_0:ShowAirExpelAimingMark()
			arg_131_0:updateQuadBase()
			arg_131_0:UpdateQuadStateAirExpel()

			return
		end)()
	elseif not arg_131_0.airSupportTarget.source then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelscene_airexpel_select_enemy"))
	elseif ManhattonDist(arg_131_0.airSupportTarget.source, arg_131_1) > 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelscene_airexpel_outrange"))
	elseif not var_131_0:considerAsStayPoint(ChapterConst.SubjectChampion, arg_131_1.row, arg_131_1.column) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelscene_airexpel_outrange"))
	else
		local var_131_2 = arg_131_0.airSupportTarget.source
		local var_131_3 = arg_131_1

		if not arg_131_0.airSupportTarget.source or not arg_131_1 then
			return
		end

		local var_131_4 = {
			arg_131_1.row - var_131_2.row,
			arg_131_1.column - var_131_2.column
		}
		local var_131_5 = {
			"up",
			"right",
			"down",
			"left"
		}
		local var_131_6
		local var_131_7

		if ({
			arg_131_1.row - var_131_2.row,
			arg_131_1.column - var_131_2.column
		})[1] ~= 0 then
			var_131_6 = var_131_4[1] + 2
		else
			var_131_6 = 3 - var_131_4[2]
			var_131_7 = var_131_0:getChapterSupportFleet()
		end

		;({}).content = i18n("levelscene_airexpel_select_confirm_" .. var_131_5[var_131_6], pg.expedition_data_template[var_131_2.attachmentId].name)
		;({}).onYes = function()
			arg_131_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_131_7.id,
				arg1 = ChapterConst.StrategyExpel,
				arg2 = var_131_2.row,
				arg3 = var_131_2.column,
				arg4 = var_131_3.row,
				arg5 = var_131_3.column
			})

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({})
	end

	return
end

function var_0_0.CleanAirSupport(arg_134_0)
	arg_134_0.airSupportTarget = nil

	return
end

function var_0_0.startQuadTween(arg_135_0, arg_135_1, arg_135_2, arg_135_3, arg_135_4)
	if arg_135_0.presentTws[arg_135_1] then
		LeanTween.cancel(arg_135_0.presentTws[arg_135_1].uniqueId)

		arg_135_0.presentTws[arg_135_1] = nil
	end

	if not arg_135_0.quadTws[arg_135_1] then
		arg_135_3 = arg_135_3 or 1
		arg_135_4 = arg_135_4 or ChapterConst.CellEaseOutAlpha

		setImageAlpha(arg_135_2, arg_135_3)

		local var_135_0 = LeanTween.alpha(arg_135_2, arg_135_4, 1):setLoopPingPong()

		arg_135_0.quadTws[arg_135_1] = {
			tw = var_135_0,
			uniqueId = var_135_0.uniqueId
		}
	end

	return
end

function var_0_0.cancelQuadTween(arg_136_0, arg_136_1, arg_136_2)
	if arg_136_0.quadTws[arg_136_1] then
		LeanTween.cancel(arg_136_0.quadTws[arg_136_1].uniqueId)

		arg_136_0.quadTws[arg_136_1] = nil
	end

	setImageAlpha(arg_136_2, ChapterConst.CellEaseOutAlpha)

	return
end

function var_0_0.killQuadTws(arg_137_0)
	for iter_137_0, iter_137_1 in pairs(arg_137_0.quadTws) do
		LeanTween.cancel(iter_137_1.uniqueId)
	end

	arg_137_0.quadTws = {}

	return
end

function var_0_0.killPresentTws(arg_138_0)
	for iter_138_0, iter_138_1 in pairs(arg_138_0.presentTws) do
		LeanTween.cancel(iter_138_1.uniqueId)
	end

	arg_138_0.presentTws = {}

	return
end

function var_0_0.startMarkTween(arg_139_0, arg_139_1, arg_139_2, arg_139_3, arg_139_4)
	if not arg_139_0.markTws[arg_139_1] then
		arg_139_3 = arg_139_3 or 1
		arg_139_4 = arg_139_4 or 0.2

		setImageAlpha(arg_139_2, arg_139_3)

		local var_139_0 = LeanTween.alpha(arg_139_2, arg_139_4, 0.7):setLoopPingPong():setEase(LeanTweenType.easeInOutSine):setDelay(1)

		arg_139_0.markTws[arg_139_1] = {
			tw = var_139_0,
			uniqueId = var_139_0.uniqueId
		}
	end

	return
end

function var_0_0.cancelMarkTween(arg_140_0, arg_140_1, arg_140_2, arg_140_3)
	if arg_140_0.markTws[arg_140_1] then
		LeanTween.cancel(arg_140_0.markTws[arg_140_1].uniqueId)

		arg_140_0.markTws[arg_140_1] = nil
	end

	setImageAlpha(arg_140_2, arg_140_3 or ChapterConst.CellEaseOutAlpha)

	return
end

function var_0_0.moveFleet(arg_141_0, arg_141_1, arg_141_2, arg_141_3, arg_141_4)
	local var_141_0 = arg_141_0.contextData.chapterVO:IsFogStage()
	local var_141_1 = arg_141_0.cellFleets[arg_141_0.contextData.chapterVO.fleet.id]

	arg_141_0.cellFleets[arg_141_0.contextData.chapterVO.fleet.id]:SetSpineVisible(true)
	setActive(arg_141_0.cellFleets[arg_141_0.contextData.chapterVO.fleet.id].tfShadow, true)
	setActive(arg_141_0.arrowTarget, true)
	arg_141_0:updateTargetArrow(arg_141_2[#arg_141_2])

	if arg_141_3 then
		arg_141_0:updateAttachment(arg_141_3.row, arg_141_3.column)
	end

	local function var_141_2(arg_142_0)
		if var_141_0 then
			arg_141_0:UpdateWeatherCells((var_0:UpdateCellsVisible(var_0, arg_142_0)))
		end

		return
	end

	arg_141_0:updateQuadCells(ChapterConst.QuadStateFrozen)
	var_141_2(arg_141_0.cellFleets[arg_141_0.contextData.chapterVO.fleet.id]:GetLine())
	arg_141_0:moveCellView(arg_141_0.cellFleets[arg_141_0.contextData.chapterVO.fleet.id], arg_141_1, arg_141_2, function(arg_143_0)
		var_0.step = var_0.step + 1

		var_141_2(arg_143_0)
		existCall(arg_141_0.onShipStepChange, arg_143_0)

		return
	end, function(arg_144_0)
		return
	end, function()
		setActive(arg_141_0.arrowTarget, false)

		if ChapterConst.NeedClearStep((var_0:getChapterCell(var_0.fleet.line.row, var_0.fleet.line.column))) then
			var_0.step = 0
		end

		var_0.rotation = var_141_1:GetRotatePivot().transform.localRotation

		arg_141_0:updateAttachment(var_0.fleet.line.row, var_0.fleet.line.column)
		arg_141_0:updateFleet(var_0)
		arg_141_0:updateOni()

		local var_145_0 = var_0:getChampionIndex(var_0.fleet.line.row, var_0.fleet.line.column)

		if var_145_0 then
			arg_141_0:updateChampion(var_145_0)
		end

		if arg_141_0.onShipArrived then
			arg_141_0.onShipArrived()
		end

		if arg_141_4 then
			arg_141_4()
		end

		return
	end)

	return
end

function var_0_0.moveSub(arg_146_0, arg_146_1, arg_146_2, arg_146_3, arg_146_4)
	local var_146_0 = arg_146_0.cellFleets[arg_146_0.contextData.chapterVO.fleets[arg_146_1].id]
	local var_146_1 = arg_146_2[#arg_146_2]

	arg_146_0:updateQuadCells(ChapterConst.QuadStateFrozen)
	arg_146_0:teleportSubView(arg_146_0.cellFleets[arg_146_0.contextData.chapterVO.fleets[arg_146_1].id], arg_146_0.cellFleets[arg_146_0.contextData.chapterVO.fleets[arg_146_1].id]:GetLine(), arg_146_2[#arg_146_2], function(arg_147_0)
		return
	end, function(arg_148_0)
		return
	end, function()
		local var_149_0 = var_0:existEnemy(ChapterConst.SubjectPlayer, var_146_1.row, var_146_1.column) or var_0:existAlly(var_0)
		local var_149_1 = var_0.subAutoAttack == 1

		var_146_0:SetActiveModel(not var_149_0 and var_149_1)

		var_0.rotation = var_146_0:GetRotatePivot().transform.localRotation

		if arg_146_4 then
			arg_146_4()
		end

		return
	end)

	return
end

function var_0_0.moveChampion(arg_150_0, arg_150_1, arg_150_2, arg_150_3, arg_150_4)
	local var_150_0 = arg_150_0.cellChampions[arg_150_1]

	if arg_150_0.contextData.chapterVO:getChampionVisibility(arg_150_0.contextData.chapterVO.champions[arg_150_1]) then
		arg_150_0:moveCellView(arg_150_0.cellChampions[arg_150_1], arg_150_2, arg_150_3, function(arg_151_0)
			return
		end, function(arg_152_0)
			return
		end, function()
			if var_150_0.GetRotatePivot then
				var_0.rotation = var_150_0:GetRotatePivot().transform.localRotation
			end

			if arg_150_4 then
				arg_150_4()
			end

			return
		end)
	else
		arg_150_0.cellChampions[arg_150_1]:RefreshLinePosition(arg_150_0.contextData.chapterVO, arg_150_2[#arg_150_2])
		;(function()
			if var_150_0.GetRotatePivot then
				var_0.rotation = var_150_0:GetRotatePivot().transform.localRotation
			end

			if arg_150_4 then
				arg_150_4()
			end

			return
		end)()
	end

	return
end

function var_0_0.moveTransport(arg_154_0, arg_154_1, arg_154_2, arg_154_3, arg_154_4)
	local var_154_0 = arg_154_0.cellFleets[arg_154_0.contextData.chapterVO.fleets[arg_154_1].id]

	arg_154_0:updateQuadCells(ChapterConst.QuadStateFrozen)
	arg_154_0:moveCellView(arg_154_0.cellFleets[arg_154_0.contextData.chapterVO.fleets[arg_154_1].id], arg_154_2, arg_154_3, function(arg_155_0)
		return
	end, function(arg_156_0)
		return
	end, function()
		var_0.rotation = var_154_0:GetRotatePivot().transform.localRotation

		arg_154_0:updateFleet(var_0.id)
		existCall(arg_154_4)

		return
	end)

	return
end

function var_0_0.moveCellView(arg_158_0, arg_158_1, arg_158_2, arg_158_3, arg_158_4, arg_158_5, arg_158_6)
	local var_158_0 = arg_158_0.contextData.chapterVO
	local var_158_1 = coroutine.create(function()
		arg_158_0:frozen()

		if var_158_0:GetQuickPlayFlag() then
			local var_160_0 = ChapterConst.ShipStepQuickPlayScale or 1
			local var_160_1 = 0.3 * var_160_0
			local var_160_2 = ChapterConst.ShipStepDuration * ChapterConst.ShipMoveTailLength * var_160_0
			local var_160_3 = 0.1 * var_160_0
			local var_160_4 = 0

			table.insert(arg_158_3, 1, arg_158_1:GetLine())
			_.each(arg_158_3, function(arg_161_0)
				local var_161_0 = var_158_0:getChapterCell(arg_161_0.row, arg_161_0.column)

				if ChapterConst.NeedEasePathCell(var_161_0) then
					local var_161_1 = ChapterCell.Line2QuadName(var_161_0.row, var_161_0.column)
					local var_161_2 = arg_158_0.quadRoot:Find(var_161_1)

					arg_158_0:cancelQuadTween(var_161_1, var_161_2)
					LeanTween.alpha(var_161_2, 1, var_160_1):setDelay(var_160_4)

					var_160_4 = var_160_4 + var_160_3
				end

				return
			end)
			_.each(arg_158_2, function(arg_162_0)
				arg_158_0:moveStep(arg_158_1, arg_162_0, arg_158_3[#arg_158_3], function()
					local var_163_0 = arg_158_1:GetLine()
					local var_163_1 = var_158_0:getChapterCell(var_163_0.row, var_163_0.column)

					if ChapterConst.NeedEasePathCell(var_163_1) then
						LeanTween.scale(arg_158_0.quadRoot:Find((ChapterCell.Line2QuadName(var_163_1.row, var_163_1.column))), Vector3.zero, var_160_2)
					end

					arg_158_4(arg_162_0)
					arg_158_1:SetLine(arg_162_0)
					arg_158_1:ResetCanvasOrder()

					return
				end, function()
					arg_158_5(arg_162_0)
					var_0()

					return
				end)
				coroutine.yield()

				return
			end)
			_.each(arg_158_3, function(arg_165_0)
				local var_165_0 = var_158_0:getChapterCell(arg_165_0.row, arg_165_0.column)

				if ChapterConst.NeedEasePathCell(var_165_0) then
					local var_165_1 = arg_158_0.quadRoot:Find((ChapterCell.Line2QuadName(var_165_0.row, var_165_0.column)))

					LeanTween.cancel(var_165_1.gameObject)
					setImageAlpha(var_165_1, ChapterConst.CellEaseOutAlpha)

					var_165_1.localScale = Vector3.one
				end

				return
			end)

			if arg_158_0.exited then
				return
			end

			if arg_158_1.GetAction then
				arg_158_1:SetAction(ChapterConst.ShipIdleAction)
			end

			arg_158_6()
			arg_158_0:unfrozen()

			return
		end
	end)

	;(function()
		if var_158_1 and coroutine.status(var_158_1) == "suspended" then
			local var_159_0, var_159_1 = coroutine.resume(var_158_1)

			assert(var_159_0, debug.traceback(var_158_1, var_159_1))
		end

		return
	end)()

	return
end

function var_0_0.moveStep(arg_166_0, arg_166_1, arg_166_2, arg_166_3, arg_166_4, arg_166_5)
	if arg_166_0.contextData.chapterVO:GetQuickPlayFlag() then
		local var_166_2

		if arg_166_1.GetRotatePivot then
			var_166_2 = arg_166_1:GetRotatePivot()
		end

		local var_166_3 = arg_166_1:GetLine()

		if arg_166_1.GetAction then
			arg_166_1:SetAction(ChapterConst.ShipMoveAction)
		end

		if not IsNil(var_166_2) and (arg_166_2.column ~= var_166_3.column or arg_166_3.column ~= var_166_3.column) then
			tf(var_166_2).localRotation = Quaternion.identity

			if arg_166_2.column < var_166_3.column or arg_166_2.column == var_166_3.column and arg_166_3.column < var_166_3.column then
				tf(var_166_2).localRotation = Quaternion.Euler(0, 180, 0)
			end
		end

		local var_166_4 = arg_166_1.tf.localPosition
		local var_166_5 = var_166_0.theme:GetLinePosition(arg_166_2.row, arg_166_2.column)
		local var_166_6 = 0

		LeanTween.value(arg_166_1.go, 0, 1, ChapterConst.ShipStepDuration * var_166_1):setOnComplete(System.Action(arg_166_5)):setOnUpdate(System.Action_float(function(arg_167_0)
			arg_166_1.tf.localPosition = Vector3.Lerp(var_166_4, var_166_5, arg_167_0)

			if var_166_6 <= 0.5 and arg_167_0 > 0.5 then
				arg_166_4()
			end

			var_166_6 = arg_167_0

			return
		end))

		return
	end
end

function var_0_0.teleportSubView(arg_168_0, arg_168_1, arg_168_2, arg_168_3, arg_168_4, arg_168_5, arg_168_6)
	local var_168_0 = arg_168_0.contextData.chapterVO

	arg_168_0:PlaySubAnimation(arg_168_1, true, function()
		arg_168_4(arg_168_3)
		arg_168_1:RefreshLinePosition(var_168_0, arg_168_3)
		arg_168_5(arg_168_3)
		arg_168_0:PlaySubAnimation(arg_168_1, false, arg_168_6)

		return
	end)

	return
end

function var_0_0.CellToScreen(arg_170_0, arg_170_1, arg_170_2)
	local var_170_0 = arg_170_0._tf:Find(ChapterConst.PlaneName .. "/cells")

	assert(var_170_0, "plane not exist.")

	local var_170_1 = arg_170_0.contextData.chapterVO.theme:GetLinePosition(arg_170_1, arg_170_2)

	var_170_1.y = var_170_1.y * math.cos(math.pi / 180 * arg_170_0.contextData.chapterVO.theme.angle)
	var_170_1.z = var_170_1.y * math.sin(math.pi / 180 * arg_170_0.contextData.chapterVO.theme.angle)

	local var_170_2 = arg_170_0.levelCam.transform:GetChild(0)
	local var_170_3 = arg_170_0.levelCam:WorldToViewportPoint(var_170_0.position + var_170_1 * var_170_0.transform.lossyScale.x)

	return Vector3(var_170_2.rect.width * (var_170_3.x - 0.5), var_170_2.rect.height * (var_170_3.y - 0.5))
end

local var_0_4 = {
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
local var_0_5 = {
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

function var_0_0.AddCellEdge(arg_171_0, arg_171_1, arg_171_2, ...)
	local var_171_0 = 0

	for iter_171_0 = 1, 4 do
		if not _.any(arg_171_1, function(arg_172_0)
			return arg_172_0.row == arg_171_2.row + var_0_4[iter_171_0][1] and arg_172_0.column == arg_171_2.column + var_0_4[iter_171_0][2]
		end) then
			var_171_0 = bit.bor(var_171_0, 1)
		end
	end

	if var_171_0 == 0 then
		return
	end

	arg_171_0:CreateEdge(var_171_0, arg_171_2, ...)

	return
end

function var_0_0.AddOutlines(arg_173_0, arg_173_1, arg_173_2, arg_173_3, arg_173_4, arg_173_5)
	for iter_173_0, iter_173_1 in ipairs(arg_173_1) do
		for iter_173_2 = 1, 4 do
			if not underscore.any(arg_173_1, function(arg_174_0)
				return arg_174_0.row == iter_173_1.row + var_0_4[iter_173_2][1] and arg_174_0.column == iter_173_1.column + var_0_4[iter_173_2][2]
			end) then
				assert(not ({})[2 * iter_173_1.row + var_0_4[iter_173_2][1] .. "_" .. 2 * iter_173_1.column + var_0_4[iter_173_2][2]], "Multiple outline")

				;({})[2 * iter_173_1.row + var_0_4[iter_173_2][1] .. "_" .. 2 * iter_173_1.column + var_0_4[iter_173_2][2]] = {
					row = 2 * iter_173_1.row + var_0_4[iter_173_2][1],
					column = 2 * iter_173_1.column + var_0_4[iter_173_2][2],
					normal = iter_173_2
				}
			end

			if not underscore.any(arg_173_1, function(arg_175_0)
				return arg_175_0.row == iter_173_1.row + var_0_5[iter_173_2][1] and arg_175_0.column == iter_173_1.column + var_0_5[iter_173_2][2]
			end) and underscore.any(arg_173_1, function(arg_176_0)
				return arg_176_0.row == iter_173_1.row and arg_176_0.column == iter_173_1.column + var_0_5[iter_173_2][2]
			end) and underscore.any(arg_173_1, function(arg_177_0)
				return arg_177_0.row == iter_173_1.row + var_0_5[iter_173_2][1] and arg_177_0.column == iter_173_1.column
			end) then
				({})[iter_173_1.row .. "_" .. iter_173_1.column .. "_" .. iter_173_2] = {
					row = iter_173_1.row,
					column = iter_173_1.column,
					corner = iter_173_2
				}
			end
		end
	end

	arg_173_0:CreateOutlines({}, arg_173_2, arg_173_3, arg_173_4, arg_173_5)
	arg_173_0:CreateOutlineCorners({}, arg_173_2, arg_173_3, arg_173_4, arg_173_5 .. "_corner")

	return
end

function var_0_0.isHuntingRangeVisible(arg_178_0)
	return arg_178_0.contextData.huntingRangeVisibility % 2 == 0
end

function var_0_0.toggleHuntingRange(arg_179_0)
	arg_179_0:hideQuadMark(ChapterConst.MarkHuntingRange)
	arg_179_0:ClearEdges("SubmarineHunting")

	if not arg_179_0:isHuntingRangeVisible() then
		arg_179_0:ShowHuntingRange()
	end

	arg_179_0.contextData.huntingRangeVisibility = 1 - arg_179_0.contextData.huntingRangeVisibility

	arg_179_0:updateAttachments()
	arg_179_0:updateChampions()

	return
end

function var_0_0.ShowHuntingRange(arg_180_0)
	local var_180_0 = arg_180_0.contextData.chapterVO:GetSubmarineFleet()

	if not var_180_0 then
		return
	end

	arg_180_0:RefreshHuntingRange(_.filter(var_180_0:getHuntingRange(), function(arg_181_0)
		local var_181_0 = var_0:getChapterCell(arg_181_0.row, arg_181_0.column)

		return var_181_0 and var_181_0:IsWalkable()
	end), false)

	return
end

function var_0_0.RefreshHuntingRange(arg_182_0, arg_182_1, arg_182_2)
	arg_182_0:showQuadMark(arg_182_1, ChapterConst.MarkHuntingRange, "cell_hunting_range", Vector2(100, 100), arg_182_0.material_Add, arg_182_2)
	_.each(arg_182_1, function(arg_183_0)
		arg_182_0:AddCellEdge(arg_182_1, arg_183_0, not arg_182_2, nil, nil, "SubmarineHunting")

		return
	end)

	return
end

function var_0_0.ShowStaticHuntingRange(arg_184_0)
	arg_184_0:hideQuadMark(ChapterConst.MarkHuntingRange)
	arg_184_0:ClearEdges("SubmarineHunting")

	if not arg_184_0:isHuntingRangeVisible() then
		arg_184_0.contextData.huntingRangeVisibility = arg_184_0.contextData.huntingRangeVisibility + 1
	end

	arg_184_0:RefreshHuntingRange(_.filter(arg_184_0.contextData.chapterVO:GetSubmarineFleet():getHuntingRange(), function(arg_185_0)
		local var_185_0 = var_0:getChapterCell(arg_185_0.row, arg_185_0.column)

		return var_185_0 and var_185_0:IsWalkable()
	end), true)

	return
end

function var_0_0.ShowTargetHuntingRange(arg_186_0, arg_186_1)
	arg_186_0:hideQuadMark(ChapterConst.MarkHuntingRange)
	arg_186_0:ClearEdges("SubmarineHunting")

	local var_186_0 = arg_186_0.contextData.chapterVO:GetSubmarineFleet()
	local var_186_1 = _.filter(var_186_0:getHuntingRange(arg_186_1), function(arg_187_0)
		local var_187_0 = var_0:getChapterCell(arg_187_0.row, arg_187_0.column)

		return var_187_0 and var_187_0:IsWalkable()
	end)

	for iter_186_0, iter_186_1 in pairs((_.filter(var_186_0:getHuntingRange(), function(arg_188_0)
		local var_188_0 = var_0:getChapterCell(arg_188_0.row, arg_188_0.column)

		return var_188_0 and var_188_0:IsWalkable()
	end))) do
		if not table.containsData(var_186_1, iter_186_1) then
			table.insert({}, iter_186_1)
		end
	end

	arg_186_0:RefreshHuntingRange({}, true)
	arg_186_0:RefreshHuntingRange(var_186_1, false)
	arg_186_0:updateAttachments()
	arg_186_0:updateChampions()

	return
end

function var_0_0.OnChangeSubAutoAttack(arg_189_0)
	local var_189_0 = arg_189_0.contextData.chapterVO
	local var_189_1 = arg_189_0.contextData.chapterVO:GetSubmarineFleet()

	if not var_189_1 then
		return
	end

	local var_189_2 = arg_189_0.cellFleets[var_189_1.id]

	if not arg_189_0.cellFleets[var_189_1.id] then
		return
	end

	local var_189_3 = var_189_0.subAutoAttack == 1

	var_189_2:SetActiveModel(not (var_189_0.subAutoAttack == 1))
	arg_189_0:PlaySubAnimation(var_189_2, not var_189_3, function()
		arg_189_0:updateFleet(var_189_1.id)

		return
	end)

	return
end

function var_0_0.displayEscapeGrid(arg_191_0)
	if not arg_191_0.contextData.chapterVO:existOni() then
		return
	end

	local var_191_0 = arg_191_0.contextData.chapterVO:getOniChapterInfo()

	arg_191_0:hideQuadMark(ChapterConst.MarkEscapeGrid)
	arg_191_0:showQuadMark(_.map(var_191_0.escape_grids, function(arg_192_0)
		return {
			row = arg_192_0[1],
			column = arg_192_0[2]
		}
	end), ChapterConst.MarkEscapeGrid, "cell_escape_grid", Vector2(105, 105))

	return
end

function var_0_0.showQuadMark(arg_193_0, arg_193_1, arg_193_2, arg_193_3, arg_193_4, arg_193_5, arg_193_6)
	arg_193_0:ShowAnyQuadMark(arg_193_1, arg_193_2, arg_193_3, arg_193_4, arg_193_5, false, arg_193_6)

	return
end

function var_0_0.ShowTopQuadMark(arg_194_0, arg_194_1, arg_194_2, arg_194_3, arg_194_4, arg_194_5, arg_194_6)
	arg_194_0:ShowAnyQuadMark(arg_194_1, arg_194_2, arg_194_3, arg_194_4, arg_194_5, true, arg_194_6)

	return
end

function var_0_0.ShowAnyQuadMark(arg_195_0, arg_195_1, arg_195_2, arg_195_3, arg_195_4, arg_195_5, arg_195_6, arg_195_7)
	local var_195_0 = arg_195_0.contextData.chapterVO

	for iter_195_0, iter_195_1 in pairs(arg_195_1) do
		local var_195_1 = var_195_0:getChapterCell(iter_195_1.row, iter_195_1.column)

		if var_195_1 and var_195_1:IsWalkable() then
			local var_195_2 = ChapterCell.Line2MarkName(iter_195_1.row, iter_195_1.column, arg_195_2)

			arg_195_0.markQuads[arg_195_2] = arg_195_0.markQuads[arg_195_2] or {}

			local var_195_3 = arg_195_0.markQuads[arg_195_2][var_195_2]

			if not arg_195_0.markQuads[arg_195_2][var_195_2] then
				PoolMgr.GetInstance():GetPrefab("chapter/cell_quad_mark", "", false, function(arg_196_0)
					var_195_3 = arg_196_0.transform
					arg_195_0.markQuads[arg_195_2][var_195_2] = var_195_3

					return
				end)
			else
				arg_195_0:cancelMarkTween(var_195_2, var_195_3, 1)
			end

			var_195_3.name = var_195_2

			local var_195_4 = var_195_3

			if arg_195_6 then
				local var_195_6 = arg_195_0.topMarkRoot or arg_195_0.bottomMarkRoot

				var_195_5(var_195_4, var_195_6, false)

				var_195_3.sizeDelta = var_195_0.theme.cellSize
				var_195_3.anchoredPosition = var_195_0.theme:GetLinePosition(iter_195_1.row, iter_195_1.column)
				var_195_3.localScale = Vector3.one

				var_195_3:SetAsLastSibling()

				local var_195_7 = var_195_3:GetComponent(typeof(Image))

				var_195_7.sprite = GetSpriteFromAtlas("chapter/pic/cellgrid", arg_195_3)
				var_195_7.material = arg_195_5
				var_195_3.sizeDelta = arg_195_4

				if not arg_195_7 then
					arg_195_0:startMarkTween(var_195_2, var_195_3)
				else
					arg_195_0:cancelMarkTween(var_195_2, var_195_3, 1)
				end
			end
		end
	end

	return
end

function var_0_0.hideQuadMark(arg_197_0, arg_197_1)
	if arg_197_1 and not arg_197_0.markQuads[arg_197_1] then
		return
	end

	for iter_197_0, iter_197_1 in pairs(arg_197_0.markQuads) do
		if not arg_197_1 or iter_197_0 == arg_197_1 then
			for iter_197_2, iter_197_3 in pairs(iter_197_1) do
				arg_197_0:cancelMarkTween(iter_197_2, iter_197_3)

				iter_197_1[iter_197_2]:GetComponent(typeof(Image)).material = nil
				iter_197_1[iter_197_2] = nil

				PoolMgr.GetInstance():ReturnPrefab("chapter/cell_quad_mark", "", iter_197_3.gameObject)
			end

			table.clear(arg_197_0.markQuads[iter_197_0])
		end
	end

	return
end

function var_0_0.CreateEdgeIndex(arg_198_0, arg_198_1, arg_198_2, arg_198_3)
	local var_198_0 = ChapterCell.Line2Name(arg_198_0, arg_198_1)

	if arg_198_3 then
		local var_198_1 = "_" .. arg_198_3 or ""

		return var_198_0 .. var_198_1 .. "_" .. arg_198_2
	end
end

function var_0_0.CreateEdge(arg_199_0, arg_199_1, arg_199_2, arg_199_3, arg_199_4, arg_199_5, arg_199_6)
	if arg_199_1 <= 0 or arg_199_1 >= 16 then
		return
	end

	local var_199_0 = arg_199_0:GetEdgePool(arg_199_6)
	local var_199_1 = arg_199_0.contextData.chapterVO.theme:GetLinePosition(arg_199_2.row, arg_199_2.column)
	local var_199_2 = arg_199_0.contextData.chapterVO.theme.cellSize

	assert(arg_199_6, "Missing key, Please PM Programmer")

	local var_199_3 = 0

	::label_199_0::

	if var_199_3 < 4 then
		repeat
			var_199_3 = var_199_3 + 1

			if bit.band(arg_199_1, 1) > 0 then
				local var_199_4 = arg_199_0.CreateEdgeIndex(arg_199_2.row, arg_199_2.column, var_199_3, arg_199_6)

				arg_199_0.cellEdges[arg_199_6] = arg_199_0.cellEdges[arg_199_6] or {}
				arg_199_0.cellEdges[arg_199_6][var_199_4] = arg_199_0.cellEdges[arg_199_6][var_199_4] or tf(var_199_0:Dequeue())

				local var_199_5 = arg_199_0.cellEdges[arg_199_6][var_199_4]

				var_199_5.name = var_199_4

				var_199_5:SetParent(arg_199_0.bottomMarkRoot, false)

				arg_199_4 = arg_199_4 or 0
				arg_199_5 = arg_199_5 or 3

				if bit.band(var_199_3, 1) == 1 then
					local var_199_6 = var_199_2.x - arg_199_4 * 2
					local var_199_7

					if not (var_199_2.x - arg_199_4 * 2) then
						var_199_6 = var_199_2.y - arg_199_4 * 2
						var_199_7 = var_199_6
					end

					var_199_5.sizeDelta = Vector2.New(var_199_6, arg_199_5)
					var_199_5.pivot = Vector2.New(0.5, 0)
					var_199_5.anchoredPosition = Vector2.New(math.cos(math.pi * 0.5 * -var_199_3) * (var_199_2.x * 0.5 - arg_199_4) + var_199_1.x, math.sin(math.pi * 0.5 * -var_199_3) * (var_199_2.y * 0.5 - arg_199_4) + var_199_1.y)
					var_199_5.localRotation = Quaternion.Euler(0, 0, (5 - var_199_3) * 90)

					if arg_199_3 then
						arg_199_0:startMarkTween(var_199_4, var_199_5)
					else
						arg_199_0:cancelMarkTween(var_199_4, var_199_5, 1)
					end

					goto label_199_0
				end
			end
		until true
	end

	return
end

function var_0_0.ClearEdge(arg_200_0, arg_200_1)
	for iter_200_0, iter_200_1 in pairs(arg_200_0.cellEdges) do
		for iter_200_2 = 1, 4 do
			local var_200_0 = arg_200_0.CreateEdgeIndex(arg_200_1.row, arg_200_1.column, iter_200_2, iter_200_0)

			if iter_200_1[var_200_0] then
				local var_200_1 = arg_200_0:GetEdgePool(iter_200_0)
				local var_200_2 = tf(iter_200_1[var_200_0])

				arg_200_0:cancelMarkTween(var_200_0, var_200_2)
				var_200_1:Enqueue(var_200_2, false)

				iter_200_1[var_200_0] = nil
			end
		end
	end

	return
end

function var_0_0.ClearEdges(arg_201_0, arg_201_1)
	if not next(arg_201_0.cellEdges) then
		return
	end

	for iter_201_0, iter_201_1 in pairs(arg_201_0.cellEdges) do
		if not arg_201_1 or arg_201_1 == iter_201_0 then
			local var_201_0 = arg_201_0:GetEdgePool(iter_201_0)

			for iter_201_2, iter_201_3 in pairs(iter_201_1) do
				arg_201_0:cancelMarkTween(iter_201_2, iter_201_3)
				var_201_0:Enqueue(go(iter_201_3), false)
			end

			arg_201_0.cellEdges[iter_201_0] = nil
		end
	end

	return
end

function var_0_0.CreateOutlines(arg_202_0, arg_202_1, arg_202_2, arg_202_3, arg_202_4, arg_202_5)
	local var_202_0 = arg_202_0.contextData.chapterVO.theme.cellSize + arg_202_0.contextData.chapterVO.theme.cellSpace

	for iter_202_0, iter_202_1 in pairs(arg_202_1) do
		local var_202_1 = arg_202_0:GetEdgePool(arg_202_5)
		local var_202_2 = arg_202_0.contextData.chapterVO.theme:GetLinePosition(iter_202_1.row / 2, iter_202_1.column / 2)

		assert(arg_202_5, "Missing key, Please PM Programmer")

		local var_202_3 = arg_202_0.CreateEdgeIndex(iter_202_1.row, iter_202_1.column, 0, arg_202_5)

		arg_202_0.cellEdges[arg_202_5] = arg_202_0.cellEdges[arg_202_5] or {}
		arg_202_0.cellEdges[arg_202_5][var_202_3] = arg_202_0.cellEdges[arg_202_5][var_202_3] or tf(var_202_1:Dequeue())

		local var_202_4 = arg_202_0.cellEdges[arg_202_5][var_202_3]

		var_202_4.name = var_202_3

		var_202_4:SetParent(arg_202_0.bottomMarkRoot, false)

		arg_202_3 = arg_202_3 or 0
		arg_202_4 = arg_202_4 or 3

		if var_0_4[iter_202_1.normal][1] ~= 0 then
			local var_202_5 = var_202_0.x or var_202_0.y
			local var_202_6 = arg_202_4
			local var_202_7 = var_202_5 * 0.5
			local var_202_8 = arg_202_1[({
				iter_202_1.row + var_0_4[iter_202_1.normal % 4 + 1][1],
				iter_202_1.column + var_0_4[iter_202_1.normal % 4 + 1][2]
			})[1] + var_0_4[iter_202_1.normal][1] .. "_" .. ({
				iter_202_1.row + var_0_4[iter_202_1.normal % 4 + 1][1],
				iter_202_1.column + var_0_4[iter_202_1.normal % 4 + 1][2]
			})[2] + var_0_4[iter_202_1.normal][2]]

			if not arg_202_1[({
				iter_202_1.row + var_0_4[iter_202_1.normal % 4 + 1][1],
				iter_202_1.column + var_0_4[iter_202_1.normal % 4 + 1][2]
			})[1] + var_0_4[iter_202_1.normal][1] .. "_" .. ({
				iter_202_1.row + var_0_4[iter_202_1.normal % 4 + 1][1],
				iter_202_1.column + var_0_4[iter_202_1.normal % 4 + 1][2]
			})[2] + var_0_4[iter_202_1.normal][2]] then
				var_202_8 = arg_202_1[({
					iter_202_1.row + var_0_4[iter_202_1.normal % 4 + 1][1],
					iter_202_1.column + var_0_4[iter_202_1.normal % 4 + 1][2]
				})[1] - var_0_4[iter_202_1.normal][1] .. "_" .. ({
					iter_202_1.row + var_0_4[iter_202_1.normal % 4 + 1][1],
					iter_202_1.column + var_0_4[iter_202_1.normal % 4 + 1][2]
				})[2] - var_0_4[iter_202_1.normal][2]]
			end

			local var_202_9 = {
				iter_202_1.row + var_0_4[(iter_202_1.normal + 2) % 4 + 1][1],
				iter_202_1.column + var_0_4[(iter_202_1.normal + 2) % 4 + 1][2]
			}
			local var_202_10 = arg_202_1[({
				iter_202_1.row + var_0_4[(iter_202_1.normal + 2) % 4 + 1][1],
				iter_202_1.column + var_0_4[(iter_202_1.normal + 2) % 4 + 1][2]
			})[1] + var_0_4[iter_202_1.normal][1] .. "_" .. ({
				iter_202_1.row + var_0_4[(iter_202_1.normal + 2) % 4 + 1][1],
				iter_202_1.column + var_0_4[(iter_202_1.normal + 2) % 4 + 1][2]
			})[2] + var_0_4[iter_202_1.normal][2]]

			if not arg_202_1[({
				iter_202_1.row + var_0_4[(iter_202_1.normal + 2) % 4 + 1][1],
				iter_202_1.column + var_0_4[(iter_202_1.normal + 2) % 4 + 1][2]
			})[1] + var_0_4[iter_202_1.normal][1] .. "_" .. ({
				iter_202_1.row + var_0_4[(iter_202_1.normal + 2) % 4 + 1][1],
				iter_202_1.column + var_0_4[(iter_202_1.normal + 2) % 4 + 1][2]
			})[2] + var_0_4[iter_202_1.normal][2]] then
				var_202_10 = arg_202_1[var_202_9[1] - var_0_4[iter_202_1.normal][1] .. "_" .. var_202_9[2] - var_0_4[iter_202_1.normal][2]]
			end

			if var_202_8 then
				local var_202_11 = iter_202_1.row + var_0_4[iter_202_1.normal][1] == var_202_8.row + var_0_4[var_202_8.normal][1] or iter_202_1.column + var_0_4[iter_202_1.normal][2] == var_202_8.column + var_0_4[var_202_8.normal][2]

				var_202_5 = (iter_202_1.row + var_0_4[iter_202_1.normal][1] == var_202_8.row + var_0_4[var_202_8.normal][1] or iter_202_1.column + var_0_4[iter_202_1.normal][2] == var_202_8.column + var_0_4[var_202_8.normal][2]) and var_202_5 + arg_202_3 or var_202_5 - arg_202_3
				var_202_7 = var_202_11 and var_202_7 + arg_202_3 or var_202_7 - arg_202_3
			end

			if var_202_10 then
				var_202_5 = (iter_202_1.row + var_0_4[iter_202_1.normal][1] == var_202_10.row + var_0_4[var_202_10.normal][1] or iter_202_1.column + var_0_4[iter_202_1.normal][2] == var_202_10.column + var_0_4[var_202_10.normal][2]) and var_202_5 + arg_202_3 or var_202_5 - arg_202_3
			end

			var_202_4.sizeDelta = Vector2.New(var_202_5, var_202_6)
			var_202_4.pivot = Vector2.New(var_202_7 / var_202_5, 0)
			var_202_4.anchoredPosition = Vector2.New(var_0_4[iter_202_1.normal][2] * -arg_202_3 + var_202_2.x, var_0_4[iter_202_1.normal][1] * arg_202_3 + var_202_2.y)
			var_202_4.localRotation = Quaternion.Euler(0, 0, (5 - iter_202_1.normal) * 90)

			if arg_202_2 then
				arg_202_0:startMarkTween(var_202_3, var_202_4)
			else
				arg_202_0:cancelMarkTween(var_202_3, var_202_4, 1)
			end
		end
	end

	return
end

function var_0_0.CreateOutlineCorners(arg_203_0, arg_203_1, arg_203_2, arg_203_3, arg_203_4, arg_203_5)
	for iter_203_0, iter_203_1 in pairs(arg_203_1) do
		local var_203_0 = arg_203_0:GetEdgePool(arg_203_5)
		local var_203_1 = arg_203_0.contextData.chapterVO.theme:GetLinePosition(iter_203_1.row + var_0_5[iter_203_1.corner][1] * 0.5, iter_203_1.column + var_0_5[iter_203_1.corner][2] * 0.5)

		assert(arg_203_5, "Missing key, Please PM Programmer")

		local var_203_2 = arg_203_0.CreateEdgeIndex(iter_203_1.row, iter_203_1.column, iter_203_1.corner, arg_203_5)

		arg_203_0.cellEdges[arg_203_5] = arg_203_0.cellEdges[arg_203_5] or {}
		arg_203_0.cellEdges[arg_203_5][var_203_2] = arg_203_0.cellEdges[arg_203_5][var_203_2] or tf(var_203_0:Dequeue())
		arg_203_0.cellEdges[arg_203_5][var_203_2].name = var_203_2

		arg_203_0.cellEdges[arg_203_5][var_203_2]:SetParent(arg_203_0.bottomMarkRoot, false)

		arg_203_3 = arg_203_3 or 0

		local var_203_3

		if not arg_203_4 then
			arg_203_4 = 3
			var_203_3 = arg_203_4
		end

		arg_203_0.cellEdges[arg_203_5][var_203_2].sizeDelta = Vector2.New(arg_203_4, arg_203_4)
		arg_203_0.cellEdges[arg_203_5][var_203_2].pivot = Vector2.New(1, 0)
		arg_203_0.cellEdges[arg_203_5][var_203_2].anchoredPosition = Vector2.New(var_0_5[iter_203_1.corner][2] * -arg_203_3 + var_203_1.x, var_0_5[iter_203_1.corner][1] * arg_203_3 + var_203_1.y)
		arg_203_0.cellEdges[arg_203_5][var_203_2].localRotation = Quaternion.Euler(0, 0, (5 - iter_203_1.corner) * 90)

		if arg_203_2 then
			arg_203_0:startMarkTween(var_203_2, arg_203_0.cellEdges[arg_203_5][var_203_2])
		else
			arg_203_0:cancelMarkTween(var_203_2, arg_203_0.cellEdges[arg_203_5][var_203_2], 1)
		end
	end

	return
end

function var_0_0.updateCoastalGunAttachArea(arg_204_0)
	arg_204_0:hideQuadMark(ChapterConst.MarkCoastalGun)
	arg_204_0:showQuadMark(arg_204_0.contextData.chapterVO:getCoastalGunArea(), ChapterConst.MarkCoastalGun, "cell_coastal_gun", Vector2(110, 110), nil, false)

	return
end

function var_0_0.InitIdolsAnim(arg_205_0)
	if not pg.chapter_pop_template[arg_205_0.contextData.chapterVO.id] then
		return
	end

	for iter_205_0, iter_205_1 in ipairs(pg.chapter_pop_template[arg_205_0.contextData.chapterVO.id].sd_location) do
		arg_205_0.idols = arg_205_0.idols or {}

		local var_205_0 = arg_205_0.cellRoot:Find(ChapterCell.Line2Name(iter_205_1[1][1], iter_205_1[1][2]) .. "/" .. ChapterConst.ChildAttachment)

		assert(var_205_0, "cant find attachment")

		local var_205_1 = AttachmentSpineAnimationCell.New(var_205_0)

		var_205_1:SetLine({
			row = iter_205_1[1][1],
			column = iter_205_1[1][2]
		})
		table.insert(arg_205_0.idols, var_205_1)
		var_205_1:Set(iter_205_1[2])
		var_205_1:SetRoutine(pg.chapter_pop_template[arg_205_0.contextData.chapterVO.id].sd_act[iter_205_0])
	end

	return
end

function var_0_0.ClearIdolsAnim(arg_206_0)
	if arg_206_0.idols then
		for iter_206_0, iter_206_1 in ipairs(arg_206_0.idols) do
			iter_206_1:Clear()
		end

		table.clear(arg_206_0.idols)

		arg_206_0.idols = nil
	end

	return
end

function var_0_0.GetEnemyCellView(arg_207_0, arg_207_1)
	return _.detect(arg_207_0.cellChampions, function(arg_208_0)
		local var_208_0 = arg_208_0:GetLine()

		return var_208_0.row == arg_207_1.row and var_208_0.column == arg_207_1.column
	end) or arg_207_0.attachmentCells[ChapterCell.Line2Name(arg_207_1.row, arg_207_1.column)]
end

function var_0_0.TransformLine2PlanePos(arg_209_0, arg_209_1)
	return string.char(string.byte("A") + arg_209_1.column - arg_209_0.indexMin.y) .. string.char(string.byte("1") + arg_209_1.row - arg_209_0.indexMin.x)
end

function var_0_0.AlignListContainer(arg_210_0, arg_210_1)
	for iter_210_0 = arg_210_1, arg_210_0.childCount - 1 do
		setActive(arg_210_0:GetChild(iter_210_0), false)
	end

	for iter_210_1 = arg_210_0.childCount, arg_210_1 - 1 do
		cloneTplTo(arg_210_0:GetChild(0), arg_210_0)
	end

	for iter_210_2 = 0, arg_210_1 - 1 do
		setActive(arg_210_0:GetChild(iter_210_2), true)
	end

	return
end

function var_0_0.frozen(arg_211_0)
	local var_211_0 = arg_211_0.forzenCount or 0

	arg_211_0.forzenCount = var_211_0 + 1

	arg_211_0.parent:frozen()

	return
end

function var_0_0.unfrozen(arg_212_0)
	if arg_212_0.exited then
		return
	end

	local var_212_0 = arg_212_0.forzenCount or 0

	arg_212_0.forzenCount = var_212_0 - 1

	arg_212_0.parent:unfrozen()

	return
end

function var_0_0.isfrozen(arg_213_0)
	return arg_213_0.parent.frozenCount > 0
end

function var_0_0.clear(arg_214_0)
	arg_214_0:clearAll()

	local var_214_0 = arg_214_0.forzenCount or 0

	if var_214_0 > 0 then
		arg_214_0.parent:unfrozen(arg_214_0.forzenCount)
	end

	return
end

return var_0_0
