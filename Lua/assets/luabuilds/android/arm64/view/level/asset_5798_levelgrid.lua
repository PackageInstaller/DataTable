local LevelGrid = class("LevelGrid", import("..base.BasePanel"))
local PoolPlural = require("Mgr/Pool/PoolPlural")

LevelGrid.MapDefaultPos = Vector3(420, -1000, -1000)

function LevelGrid:init()
	LevelGrid.super.init(self)

	self.levelCam = GameObject.Find("LevelCamera"):GetComponent(typeof(Camera))
	GameObject.Find("LevelCamera/Canvas"):GetComponent(typeof(Canvas)).sortingOrder = ChapterConst.PriorityMin - 1
	self.quadTws = {}
	self.presentTws = {}
	self.markTws = {}
	self.tweens = {}
	self.markQuads = {}
	self.pools = {}
	self.edgePools = {}
	self.poolParent = GameObject.Find("__Pool__")
	self.opBtns = {}
	self.itemCells = {}
	self.attachmentCells = {}
	self.extraAttachmentCells = {}
	self.weatherCells = {}
	self.onShipStepChange = nil
	self.onShipArrived = nil
	self.lastSelectedId = -1
	self.quadState = -1
	self.subTeleportTargetLine = nil
	self.missileStrikeTargetLine = nil
	self.cellEdges = {}
	self.walls = {}
	self.material_Add = LoadAny("artresource/effect/common/material/add", "", typeof(Material))
	self.loader = AutoLoader.New()

	return
end

function LevelGrid:ExtendItem(arg_2_1, arg_2_2)
	if IsNil(self[arg_2_1]) then
		self[arg_2_1] = arg_2_2
	end

	return
end

function LevelGrid:getFleetPool(arg_3_1)
	local var_3_0 = self.pools["fleet_" .. arg_3_1]

	if not self.pools["fleet_" .. arg_3_1] then
		local var_3_1 = self.shipTpl

		if arg_3_1 == FleetType.Submarine then
			var_3_1 = self.subTpl
		elseif arg_3_1 == FleetType.Transport then
			var_3_1 = self.transportTpl
		end

		var_3_0 = PoolPlural.New(var_3_1.gameObject, 2)
		self.pools["fleet_" .. arg_3_1] = var_3_0
	end

	return var_3_0
end

function LevelGrid:getChampionPool(arg_4_1)
	local var_4_0 = self.pools["champion_" .. arg_4_1]

	if not self.pools["champion_" .. arg_4_1] then
		local var_4_1 = self.championTpl

		if arg_4_1 == ChapterConst.TemplateOni then
			var_4_1 = self.oniTpl
		elseif arg_4_1 == ChapterConst.TemplateEnemy then
			var_4_1 = self.enemyTpl
		end

		var_4_0 = PoolPlural.New(var_4_1.gameObject, 3)
		self.pools["champion_" .. arg_4_1] = var_4_0
	end

	return var_4_0
end

function LevelGrid:AddEdgePool(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if self.edgePools[arg_5_1] then
		return
	end

	local var_5_0 = GameObject.New(arg_5_1)

	var_5_0:AddComponent(typeof(Image)).enabled = false
	self.edgePools[arg_5_1] = PoolPlural.New(var_5_0, 32)

	local var_5_1

	parallelAsync({
		function(arg_6_0)
			if not arg_5_3 then
				arg_6_0()

				return
			end

			self.loader:LoadReference(arg_5_2, arg_5_3, typeof(Sprite), function(arg_7_0)
				var_5_1 = arg_7_0

				arg_6_0()

				return
			end)

			return
		end
	}, function()
		local function var_8_0(arg_9_0)
			local var_9_0 = go(arg_9_0):GetComponent(typeof(Image))

			var_9_0.enabled = true
			var_9_0.color = type(arg_5_4) == "table" and Color.New(unpack(arg_5_4)) or Color.white

			if arg_5_3 then
				var_9_0.sprite = var_5_1 or nil
			end

			var_9_0.material = arg_5_5 or nil

			return
		end

		if self.edgePools[arg_5_1].prefab then
			var_8_0(self.edgePools[arg_5_1].prefab)
		end

		if self.edgePools[arg_5_1].items then
			for iter_8_0, iter_8_1 in pairs(self.edgePools[arg_5_1].items) do
				var_8_0(iter_8_1)
			end
		end

		if self.cellEdges[arg_5_1] and next(self.cellEdges[arg_5_1]) then
			for iter_8_2, iter_8_3 in pairs(self.cellEdges[arg_5_1]) do
				var_8_0(iter_8_3)
			end
		end

		return
	end)

	return
end

function LevelGrid:GetEdgePool(arg_10_1)
	assert(arg_10_1, "Missing Key")
	assert(self.edgePools[arg_10_1], "Must Create Pool before Using")

	return self.edgePools[arg_10_1]
end

function LevelGrid:initAll(arg_11_1)
	seriesAsync({
		function(arg_12_0)
			self:initPlane()
			self:initDrag()
			onNextTick(arg_12_0)

			return
		end,
		function(arg_13_0)
			if self.exited then
				return
			end

			self:initTargetArrow()
			self:InitDestinationMark()
			onNextTick(arg_13_0)

			return
		end,
		function(arg_14_0)
			if self.exited then
				return
			end

			for iter_14_0 = 0, ChapterConst.MaxRow - 1 do
				for iter_14_1 = 0, ChapterConst.MaxColumn - 1 do
					self:initCell(iter_14_0, iter_14_1)
				end
			end

			self:UpdateItemCells()
			self:updateQuadCells(ChapterConst.QuadStateFrozen)
			onNextTick(arg_14_0)

			return
		end,
		function(arg_15_0)
			if self.exited then
				return
			end

			self:AddEdgePool("SubmarineHunting", "ui/commonUI_atlas", "white_dot", {
				1,
				0,
				0
			}, self.material_Add)
			self:updateAttachments()
			self:UpdateFloor()
			self:UpdateWeatherCells()
			self:InitWalls()
			self:InitIdolsAnim()
			onNextTick(arg_15_0)

			return
		end,
		function(arg_16_0)
			if self.exited then
				return
			end

			parallelAsync({
				function(arg_17_0)
					self:initFleets(arg_17_0)

					return
				end,
				function(arg_18_0)
					self:initChampions(arg_18_0)

					return
				end
			}, arg_16_0)

			return
		end,
		function()
			self:OnChangeSubAutoAttack()
			self:updateQuadCells(ChapterConst.QuadStateNormal)
			existCall(arg_11_1)

			return
		end
	})

	return
end

function LevelGrid:clearAll()
	for iter_20_0, iter_20_1 in pairs(self.tweens) do
		LeanTween.cancel(iter_20_0)
	end

	table.clear(self.tweens)
	self.loader:Clear()

	if not IsNil(self.cellRoot) then
		self:clearFleets()
		self:clearChampions()
		self:clearTargetArrow()
		self:ClearDestinationMark()
		self:ClearIdolsAnim()

		for iter_20_2, iter_20_3 in pairs(self.itemCells) do
			iter_20_3:Clear()
		end

		table.clear(self.itemCells)

		for iter_20_4, iter_20_5 in pairs(self.attachmentCells) do
			iter_20_5:Clear()
		end

		table.clear(self.attachmentCells)

		for iter_20_6, iter_20_7 in pairs(self.extraAttachmentCells) do
			iter_20_7:Clear()
		end

		table.clear(self.extraAttachmentCells)

		for iter_20_8, iter_20_9 in pairs(self.weatherCells) do
			iter_20_9:Clear()
		end

		table.clear(self.weatherCells)

		for iter_20_10 = 0, ChapterConst.MaxRow - 1 do
			for iter_20_11 = 0, ChapterConst.MaxColumn - 1 do
				self:clearCell(iter_20_10, iter_20_11)
			end
		end

		for iter_20_12, iter_20_13 in pairs(self.walls) do
			iter_20_13:Clear()
		end

		table.clear(self.walls)
		self:clearPlane()
	end

	self.material_Add = nil

	for iter_20_14, iter_20_15 in pairs(self.edgePools) do
		iter_20_15:Clear()
	end

	self.edgePools = nil

	for iter_20_16, iter_20_17 in pairs(self.pools) do
		iter_20_17:ClearItems()
	end

	self.pools = nil
	GetOrAddComponent(self._tf, "EventTriggerListener").enabled = false

	if self.dragTrigger then
		ClearEventTrigger(self.dragTrigger)

		self.dragTrigger = nil
	end

	LeanTween.cancel(self._tf)

	return
end

local var_0_2 = 640

function LevelGrid:initDrag()
	local var_21_0, var_21_1, var_21_2 = getSizeRate()
	local var_21_3 = var_21_2 * 0.5 / math.tan(math.deg2Rad * self.contextData.chapterVO.theme.fov * 0.5)
	local var_21_4 = math.deg2Rad * self.contextData.chapterVO.theme.angle
	local var_21_5 = Vector3(self.contextData.chapterVO.theme.offsetx, self.contextData.chapterVO.theme.offsety, self.contextData.chapterVO.theme.offsetz) + LevelGrid.MapDefaultPos
	local var_21_6 = var_21_0 * math.clamp((var_21_3 - Vector3.Dot(Vector3(0, -math.sin(math.deg2Rad * self.contextData.chapterVO.theme.angle), -math.cos(math.deg2Rad * self.contextData.chapterVO.theme.angle)), var_21_5)) / var_21_3, 0, 1)
	local var_21_7 = self.plane:Find("display").anchoredPosition
	local var_21_8, var_21_9, var_21_10, var_21_11 = self.contextData.chapterVO:getDragExtend()

	self.leftBound = var_0_2 - var_21_5.x - var_21_7.x - var_21_9
	self.rightBound = var_0_2 - var_21_5.x - var_21_7.x + var_21_8
	self.topBound = LevelGrid.MapDefaultPos.y - var_21_5.y - var_21_7.y + var_21_11
	self.bottomBound = LevelGrid.MapDefaultPos.y - var_21_5.y - var_21_7.y - var_21_10
	self._tf.sizeDelta = Vector2(var_21_1 * 2, var_21_2 * 2)
	self.dragTrigger = GetOrAddComponent(self._tf, "EventTriggerListener")
	self.dragTrigger.enabled = true

	self.dragTrigger:AddDragFunc(function(arg_22_0, arg_22_1)
		self._tf.anchoredPosition.x = math.clamp(self._tf.anchoredPosition.x + arg_22_1.delta.x * var_21_6.x, self.leftBound, self.rightBound)
		self._tf.anchoredPosition.y = math.clamp(self._tf.anchoredPosition.y + arg_22_1.delta.y * var_21_6.y / math.cos(var_21_4), self.bottomBound, self.topBound)
		self._tf.anchoredPosition = self._tf.anchoredPosition

		return
	end)

	return
end

function LevelGrid:initPlane()
	self.levelCam.fieldOfView = self.contextData.chapterVO.theme.fov

	local var_23_0

	PoolMgr.GetInstance():GetPrefab("chapter/plane", "", false, function(arg_24_0)
		var_23_0 = arg_24_0.transform

		return
	end)

	self.plane = nil
	;(nil).name = ChapterConst.PlaneName

	;(nil):SetParent(self._tf, false)

	;(nil).anchoredPosition3D = Vector3(self.contextData.chapterVO.theme.offsetx, self.contextData.chapterVO.theme.offsety, self.contextData.chapterVO.theme.offsetz) + LevelGrid.MapDefaultPos
	self.cellRoot = (nil):Find("cells")
	self.quadRoot = (nil):Find("quads")
	self.bottomMarkRoot = (nil):Find("buttomMarks")
	self.topMarkRoot = (nil):Find("topMarks")
	self.restrictMap = (nil):Find("restrictMap")
	self.UIFXList = (nil):Find("UI_FX_list")

	for iter_23_0 = 1, self.UIFXList.childCount do
		setActive(self.UIFXList:GetChild(iter_23_0 - 1), false)
	end

	local var_23_1 = self.UIFXList:Find(self.contextData.chapterVO:getConfig("uifx"))

	if var_23_1 then
		setActive(var_23_1, true)
	end

	local var_23_2 = self.contextData.chapterVO:getConfig("chapter_fx")

	if type(var_23_2) == "table" then
		for iter_23_1, iter_23_2 in pairs(var_23_2) do
			if #iter_23_1 <= 0 then
				return
			end

			self.loader:GetPrefab("effect/" .. iter_23_1, iter_23_1, function(arg_25_0)
				setParent(arg_25_0, self.UIFXList)

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

	GetImageSpriteFromAtlasAsync("chapter/pic/" .. self.contextData.chapterVO.theme.assetSea, self.contextData.chapterVO.theme.assetSea, (var_23_3:Find("mask/sea")))

	self.indexMin, self.indexMax = self.contextData.chapterVO.indexMin, self.contextData.chapterVO.indexMax

	local var_23_4 = Vector2.Scale(Vector2(self.indexMin.y, ChapterConst.MaxRow * 0.5 - self.indexMax.x - 1), self.contextData.chapterVO.theme.cellSize + self.contextData.chapterVO.theme.cellSpace)
	local var_23_5 = Vector2.Scale(Vector2(self.indexMax.y - self.indexMin.y + 1, self.indexMax.x - self.indexMin.x + 1), self.contextData.chapterVO.theme.cellSize + self.contextData.chapterVO.theme.cellSpace)

	var_23_3.anchoredPosition = var_23_4 + var_23_5 * 0.5
	var_23_3.sizeDelta = var_23_5
	self.restrictMap.anchoredPosition = var_23_4 + var_23_5 * 0.5
	self.restrictMap.sizeDelta = var_23_5

	local var_23_6 = Vector2(math.floor(var_23_3.sizeDelta.x / (self.contextData.chapterVO.theme.cellSize + self.contextData.chapterVO.theme.cellSpace).x), math.floor(var_23_3.sizeDelta.y / (self.contextData.chapterVO.theme.cellSize + self.contextData.chapterVO.theme.cellSpace).y))
	local var_23_7 = var_23_3:Find("ABC")
	local var_23_8 = var_23_7:GetChild(0)
	local var_23_9 = var_23_7:GetComponent(typeof(GridLayoutGroup))

	var_23_9.cellSize = Vector2(self.contextData.chapterVO.theme.cellSize.x, self.contextData.chapterVO.theme.cellSize.y)
	var_23_9.spacing = Vector2(self.contextData.chapterVO.theme.cellSpace.x, self.contextData.chapterVO.theme.cellSpace.y)
	var_23_9.padding.left = self.contextData.chapterVO.theme.cellSpace.x

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

	var_23_12.cellSize = Vector2(self.contextData.chapterVO.theme.cellSize.x, self.contextData.chapterVO.theme.cellSize.y)
	var_23_12.spacing = Vector2(self.contextData.chapterVO.theme.cellSpace.x, self.contextData.chapterVO.theme.cellSpace.y)
	var_23_12.padding.top = self.contextData.chapterVO.theme.cellSpace.y

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
	var_23_15.spacing = Vector2((self.contextData.chapterVO.theme.cellSize + self.contextData.chapterVO.theme.cellSpace).x - ChapterConst.LineCross, 0)
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
	var_23_18.spacing = Vector2(0, (self.contextData.chapterVO.theme.cellSize + self.contextData.chapterVO.theme.cellSpace).y - ChapterConst.LineCross)
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

	if self.contextData.chapterVO.theme.seaBase and self.contextData.chapterVO.theme.seaBase ~= "" then
		setActive(var_23_20, true)
		GetImageSpriteFromAtlasAsync("chapter/pic/" .. self.contextData.chapterVO.theme.seaBase, self.contextData.chapterVO.theme.seaBase, var_23_20)

		var_23_19.enabled = true
		var_23_19.uvRect = UnityEngine.Rect.New(0, 0, 1, -1)
	else
		setActive(var_23_20, false)

		var_23_19.enabled = false
	end

	return
end

function LevelGrid:updatePoisonArea()
	local var_26_0 = GetOrAddComponent(self._tf:Find("plane/display/mask"), "RawImage")

	if not var_26_0.enabled then
		return
	end

	var_26_0.texture = self:getPoisonTex()

	return
end

function LevelGrid:getPoisonTex()
	local var_27_0 = self.contextData.chapterVO
	local var_27_1 = self._tf:Find("plane/display")
	local var_27_2 = 256
	local var_27_3

	if self.preChapterId ~= self.contextData.chapterVO.id then
		var_27_3 = UnityEngine.Texture2D.New(var_27_2, (math.floor(var_27_2 / (var_27_1.sizeDelta.x / var_27_1.sizeDelta.y))))
		self.maskTexture = var_27_3
		self.preChapterId = var_27_0.id
	else
		var_27_3 = self.maskTexture
	end

	local var_27_4 = {}
	local var_27_5 = var_27_0:getPoisonArea(var_27_2 / var_27_1.sizeDelta.x)

	if self.poisonRectDir == nil then
		var_27_4 = var_27_5
	else
		for iter_27_0, iter_27_1 in pairs(var_27_5) do
			if self.poisonRectDir[iter_27_0] == nil then
				var_27_4[iter_27_0] = iter_27_1
			end
		end
	end

	local function var_27_6(arg_28_0)
		for iter_28_0 = arg_28_0.x, arg_28_0.w + arg_28_0.x do
			for iter_28_1 = arg_28_0.y, arg_28_0.h + arg_28_0.y do
				var_27_3:SetPixel(iter_28_0, iter_28_1, Color.New(1, 1, 1, 0))
			end
		end

		return
	end

	for iter_27_2, iter_27_3 in pairs(var_27_4) do
		var_27_6(iter_27_3)
	end

	var_27_3:Apply()

	self.poisonRectDir = var_27_5

	return var_27_3
end

function LevelGrid:showFleetPoisonDamage(arg_29_1, arg_29_2)
	if self.cellFleets[self.contextData.chapterVO.fleets[arg_29_1].id] then
		self.cellFleets[self.contextData.chapterVO.fleets[arg_29_1].id]:showPoisonDamage(arg_29_2)
	end

	return
end

function LevelGrid:clearPlane()
	self:killQuadTws()
	self:killPresentTws()
	self:ClearEdges()
	self:hideQuadMark()
	removeAllChildren(self.cellRoot)
	removeAllChildren(self.quadRoot)
	removeAllChildren(self.bottomMarkRoot)
	removeAllChildren(self.topMarkRoot)
	removeAllChildren(self.restrictMap)

	self.cellRoot = nil
	self.quadRoot = nil
	self.bottomMarkRoot = nil
	self.topMarkRoot = nil
	self.restrictMap = nil

	local var_30_0 = self._tf:Find(ChapterConst.PlaneName)

	clearImageSprite((var_30_0:Find("display/seaBase/sea")))
	pg.PoolMgr.GetInstance():ReturnPrefab("chapter/plane", "", var_30_0.gameObject)

	return
end

function LevelGrid:initFleets(arg_31_1)
	if self.cellFleets then
		existCall(arg_31_1)

		return
	end

	self.cellFleets = {}

	table.ParallelIpairsAsync(self.contextData.chapterVO.fleets, function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_1:getFleetType() == FleetType.Support then
			return arg_32_2()
		end

		self:InitFleetCell(arg_32_1.id, arg_32_2)

		return
	end, arg_31_1)

	return
end

function LevelGrid:InitFleetCell(arg_33_1, arg_33_2)
	local var_33_0 = self.contextData.chapterVO
	local var_33_1 = self.contextData.chapterVO:getFleetById(arg_33_1)

	if not var_33_1:isValid() then
		existCall(arg_33_2)

		return
	end

	local var_33_3 = self:getFleetPool(var_33_1:getFleetType()):Dequeue()

	var_33_3.transform.localEulerAngles = Vector3(-var_33_0.theme.angle, 0, 0)

	setParent(var_33_3, self.cellRoot, false)
	setActive(var_33_3, true)

	local var_33_4 = var_33_1:getFleetType()
	local var_33_6 = (var_33_4 == FleetType.Transport and TransportCellView or var_33_4 == FleetType.Submarine and SubCellView or FleetCellView).New(var_33_3)

	var_33_6.fleetType = var_33_4

	if var_33_4 == FleetType.Normal or var_33_4 == FleetType.Submarine then
		var_33_6:SetAction(ChapterConst.ShipIdleAction)
	end

	var_33_6.tf.localPosition = var_33_0.theme:GetLinePosition(var_33_1.line.row, var_33_1.line.column)
	self.cellFleets[arg_33_1] = var_33_6

	self:RefreshFleetCell(arg_33_1, arg_33_2)

	return
end

function LevelGrid:RefreshFleetCells(arg_34_1)
	if not self.cellFleets then
		self:initFleets(arg_34_1)

		return
	end

	local var_34_0 = self.contextData.chapterVO
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in pairs(self.cellFleets) do
		if not var_34_0:getFleetById(iter_34_0) then
			table.insert(var_34_1, iter_34_0)
		end
	end

	for iter_34_2, iter_34_3 in pairs(var_34_1) do
		self:ClearFleetCell(iter_34_3)
	end

	table.ParallelIpairsAsync(var_34_0.fleets, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_1:getFleetType() == FleetType.Support then
			return arg_35_2()
		end

		if not self.cellFleets[arg_35_1.id] then
			self:InitFleetCell(arg_35_1.id, arg_35_2)
		else
			self:RefreshFleetCell(arg_35_1.id, arg_35_2)
		end

		return
	end, arg_34_1)

	return
end

function LevelGrid:RefreshFleetCell(arg_36_1, arg_36_2)
	local var_36_0 = self.contextData.chapterVO:getFleetById(arg_36_1)
	local var_36_1 = self.cellFleets[arg_36_1]
	local var_36_2
	local var_36_3

	if var_36_0:isValid() then
		if var_36_0:getFleetType() == FleetType.Transport then
			var_36_2 = var_36_0:getPrefab()
		else
			local var_36_4 = self.contextData.chapterVO:getMapShip(var_36_0)

			if var_36_4 then
				var_36_2 = var_36_4:getPrefab()
				var_36_3 = var_36_4:getAttachmentPrefab()
			end
		end
	end

	if not var_36_2 then
		self:ClearFleetCell(arg_36_1)
		existCall(arg_36_2)

		return
	end

	self.cellFleets[arg_36_1].go.name = "cell_fleet_" .. var_36_2

	self.cellFleets[arg_36_1]:SetLine(var_36_0.line)

	if self.cellFleets[arg_36_1].fleetType == FleetType.Transport then
		self.cellFleets[arg_36_1]:LoadIcon(var_36_2, function()
			var_36_1:GetRotatePivot().transform.localRotation = var_36_0.rotation

			self:updateFleet(arg_36_1, arg_36_2)

			return
		end)
	else
		self.cellFleets[arg_36_1]:LoadSpine(var_36_2, nil, var_36_3, function()
			var_36_1:GetRotatePivot().transform.localRotation = var_36_0.rotation

			self:updateFleet(arg_36_1, arg_36_2)

			return
		end)
	end

	return
end

function LevelGrid:clearFleets()
	if self.cellFleets then
		for iter_39_0, iter_39_1 in pairs(self.cellFleets) do
			self:ClearFleetCell(iter_39_0)
		end

		self.cellFleets = nil
	end

	return
end

function LevelGrid:ClearFleetCell(arg_40_1)
	if not self.cellFleets[arg_40_1] then
		return
	end

	self.cellFleets[arg_40_1]:Clear()
	LeanTween.cancel(self.cellFleets[arg_40_1].go)
	setActive(self.cellFleets[arg_40_1].go, false)
	setParent(self.cellFleets[arg_40_1].go, self.poolParent, false)
	self:getFleetPool(self.cellFleets[arg_40_1].fleetType):Enqueue(self.cellFleets[arg_40_1].go, false)

	if self.opBtns[arg_40_1] then
		Destroy(self.opBtns[arg_40_1].gameObject)

		self.opBtns[arg_40_1] = nil
	end

	self.cellFleets[arg_40_1] = nil

	return
end

function LevelGrid:UpdateFleets(arg_41_1)
	table.ParallelIpairsAsync(self.contextData.chapterVO.fleets, function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_1:getFleetType() == FleetType.Support then
			return arg_42_2()
		end

		self:updateFleet(arg_42_1.id, arg_42_2)

		return
	end, arg_41_1)

	return
end

function LevelGrid:updateFleet(arg_43_1, arg_43_2)
	local var_43_0 = self.contextData.chapterVO
	local var_43_1 = self.cellFleets[arg_43_1]
	local var_43_2 = self.contextData.chapterVO:getFleetById(arg_43_1)

	if self.cellFleets[arg_43_1] then
		local var_43_3 = var_43_2.line
		local var_43_4 = var_43_2:isValid()

		setActive(var_43_1.go, var_43_4)
		var_43_1:RefreshLinePosition(var_43_0, var_43_3)

		local var_43_5 = var_43_2:getFleetType()

		if var_43_5 == FleetType.Normal then
			local var_43_6 = var_43_0:GetEnemy(var_43_3.row, var_43_3.column)
			local var_43_7 = tobool(var_43_6)
			local var_43_8

			if var_43_6 then
				var_43_8 = var_43_6.attachment or nil
			end

			local var_43_9 = var_43_0:existFleet(FleetType.Transport, var_43_3.row, var_43_3.column)

			var_43_1:SetSpineVisible(not var_43_7 and not var_43_9)

			local var_43_10 = table.indexof(var_43_0.fleets, var_43_2) == var_43_0.findex

			setActive(var_43_1.tfArrow, var_43_10)
			setActive(var_43_1.tfOp, false)

			local var_43_11 = self.opBtns[arg_43_1]

			if not self.opBtns[arg_43_1] then
				var_43_11 = tf(Instantiate(var_43_1.tfOp))
				var_43_11.name = "op" .. arg_43_1

				var_43_11:SetParent(self._tf, false)

				var_43_11.localEulerAngles = Vector3(-var_43_0.theme.angle, 0, 0)

				local var_43_12 = GetOrAddComponent(var_43_11, typeof(Canvas))

				GetOrAddComponent(go(var_43_11), typeof(GraphicRaycaster))

				var_43_12.overrideSorting = true
				var_43_12.sortingOrder = ChapterConst.PriorityMax
				self.opBtns[arg_43_1] = var_43_11

				self:UpdateOpBtns()
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
			setActive(var_43_18, var_43_18:Find("retreat").gameObject.activeSelf or var_43_18:Find("escape").gameObject.activeSelf)

			if var_43_18.gameObject.activeSelf then
				onButton(self, var_43_18, function()
					if self.parent:isfrozen() then
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
									self:emit(LevelMediator2.ON_OP, {
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
								self:emit(LevelMediator2.ON_OP, {
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

			local var_43_19, var_43_20 = var_43_0:getFleetAmmo(var_43_2)
			local var_43_21 = var_43_20 .. "/" .. var_43_19

			if var_43_20 == 0 then
				var_43_21 = setColorStr(var_43_21, COLOR_RED)
			end

			setText(var_43_1.tfAmmoText, var_43_21)

			if var_43_7 or var_43_9 then
				if var_43_7 and var_43_8 == ChapterConst.AttachChampion and var_43_0:getChampion(var_43_3.row, var_43_3.column):getPoolType() == ChapterConst.TemplateChampion then
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

			if var_43_1:GetSpineRole() and var_43_10 and self.lastSelectedId ~= var_43_2.id then
				if not var_43_7 and not var_43_9 and self.lastSelectedId ~= -1 then
					var_43_1:TweenShining()
				end

				self.lastSelectedId = var_43_2.id
			end

			var_43_1:SetActiveNoPassIcon((var_43_0:existBarrier(var_43_3.row, var_43_3.column)))
			var_43_1:UpdateIconRecordedFlag((table.contains(var_43_2:GetStatusStrategy(), ChapterConst.StrategyIntelligenceRecorded)))
		elseif var_43_5 == FleetType.Submarine then
			local var_43_22 = var_43_0:existEnemy(ChapterConst.SubjectPlayer, var_43_3.row, var_43_3.column) or var_43_0:existAlly(var_43_2)

			var_43_1:SetActiveModel(not var_43_22 and var_43_0.subAutoAttack == 1)
			setActive(var_43_1.tfAmmo, not var_43_22)

			local var_43_23, var_43_24 = var_43_0:getFleetAmmo(var_43_2)
			local var_43_25 = var_43_24 .. "/" .. var_43_23

			if var_43_24 == 0 then
				var_43_25 = setColorStr(var_43_25, COLOR_RED)
			end

			setText(var_43_1.tfAmmoText, var_43_25)
		elseif var_43_5 == FleetType.Transport then
			setText(var_43_1.tfHpText, var_43_2:getRestHp() .. "/" .. var_43_2:getTotalHp())
			GetImageSpriteFromAtlasAsync("enemies/" .. var_43_2:getPrefab(), "", var_43_1.tfIcon, true)
			setActive(var_43_1.tfFighting, (var_43_0:existEnemy(ChapterConst.SubjectPlayer, var_43_3.row, var_43_3.column)))
		end
	end

	existCall(arg_43_2)

	return
end

function LevelGrid:UpdateOpBtns()
	table.Foreach(self.opBtns, function(arg_49_0, arg_49_1)
		setActive(arg_49_1, self.quadState == ChapterConst.QuadStateNormal)

		return
	end)

	return
end

function LevelGrid:GetCellFleet(arg_50_1)
	return self.cellFleets[arg_50_1]
end

function LevelGrid:initTargetArrow()
	self.arrowTarget = cloneTplTo(self.arrowTpl, self._tf)

	pg.ViewUtils.SetLayer(tf(self.arrowTarget), Layer.UI)

	GetOrAddComponent(self.arrowTarget, typeof(Canvas)).overrideSorting = true
	self.arrowTarget.localEulerAngles = Vector3(-self.contextData.chapterVO.theme.angle, 0, 0)

	setActive(self.arrowTarget, false)

	return
end

function LevelGrid:updateTargetArrow(arg_52_1)
	local var_52_0 = self.contextData.chapterVO

	self.arrowTarget:SetParent((self.cellRoot:Find((ChapterCell.Line2Name(arg_52_1.row, arg_52_1.column)))))

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

	self.arrowTarget.localPosition = var_52_1 and Vector3(0, 20 + 80 * var_52_2, -80 * var_52_2) or Vector3(0, 20, 0)

	local var_52_3 = self.arrowTarget:GetComponent(typeof(Canvas))

	if var_52_3 then
		var_52_3.sortingOrder = arg_52_1.row * ChapterConst.PriorityPerRow + ChapterConst.CellPriorityTopMark
	end

	return
end

function LevelGrid:clearTargetArrow()
	if not IsNil(self.arrowTarget) then
		Destroy(self.arrowTarget)

		self.arrowTarget = nil
	end

	return
end

function LevelGrid:InitDestinationMark()
	local var_55_0 = cloneTplTo(self.destinationMarkTpl, self._tf)

	pg.ViewUtils.SetLayer(tf(var_55_0), Layer.UI)

	GetOrAddComponent(var_55_0, typeof(Canvas)).overrideSorting = true

	setActive(var_55_0, false)

	tf(var_55_0).localEulerAngles = Vector3(-self.contextData.chapterVO.theme.angle, 0, 0)
	self.destinationMark = tf(var_55_0)

	return
end

function LevelGrid:UpdateDestinationMark(arg_56_1)
	if not arg_56_1 then
		self.destinationMark:SetParent(self._tf)
		setActive(go(self.destinationMark), false)

		return
	end

	setActive(go(self.destinationMark), true)
	self.destinationMark:SetParent((self.cellRoot:Find((ChapterCell.Line2Name(arg_56_1.row, arg_56_1.column)))))

	self.destinationMark.localPosition = Vector3(0, 40, -40)

	local var_56_0 = self.destinationMark:GetComponent(typeof(Canvas))

	if var_56_0 then
		var_56_0.sortingOrder = arg_56_1.row * ChapterConst.PriorityPerRow + ChapterConst.CellPriorityTopMark
	end

	return
end

function LevelGrid:ClearDestinationMark()
	if not IsNil(self.destinationMark) then
		Destroy(self.destinationMark)

		self.destinationMark = nil
	end

	return
end

function LevelGrid:initChampions(arg_58_1)
	if self.cellChampions then
		existCall(arg_58_1)

		return
	end

	self.cellChampions = {}

	table.ParallelIpairsAsync(self.contextData.chapterVO.champions, function(arg_59_0, arg_59_1, arg_59_2)
		self.cellChampions[arg_59_0] = false

		if arg_59_1.flag ~= ChapterConst.CellFlagDisabled then
			self:InitChampion(arg_59_0, arg_59_2)
		else
			arg_59_2()
		end

		return
	end, arg_58_1)

	return
end

function LevelGrid:InitChampion(arg_60_1, arg_60_2)
	local var_60_0 = self.contextData.chapterVO.champions[arg_60_1]
	local var_60_1 = self.contextData.chapterVO.champions[arg_60_1]:getPoolType()
	local var_60_2 = self:getChampionPool(var_60_1):Dequeue()

	var_60_2.name = "cell_champion_" .. self.contextData.chapterVO.champions[arg_60_1]:getPrefab()
	var_60_2.transform.localEulerAngles = Vector3(-self.contextData.chapterVO.theme.angle, 0, 0)

	setParent(var_60_2, self.cellRoot, false)
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

	self.cellChampions[arg_60_1] = var_60_4

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
			self:updateChampion(arg_60_1, arg_60_2)

			return
		end)
	elseif var_60_1 == ChapterConst.TemplateEnemy then
		var_60_4:LoadIcon(var_60_0:getPrefab(), var_60_0:getConfigTable(), function()
			self:updateChampion(arg_60_1, arg_60_2)

			return
		end)
	elseif var_60_1 == ChapterConst.TemplateOni then
		self:updateChampion(arg_60_1, arg_60_2)
	end

	return
end

function LevelGrid:updateChampions(arg_63_1)
	table.ParallelIpairsAsync(self.cellChampions, function(arg_64_0, arg_64_1, arg_64_2)
		self:updateChampion(arg_64_0, arg_64_2)

		return
	end, arg_63_1)

	return
end

function LevelGrid:updateChampion(arg_65_1, arg_65_2)
	if self.cellChampions[arg_65_1] and self.contextData.chapterVO.champions[arg_65_1] then
		self.cellChampions[arg_65_1]:UpdateChampionCell(self.contextData.chapterVO, self.contextData.chapterVO.champions[arg_65_1], arg_65_2)
	end

	return
end

function LevelGrid:updateOni()
	local var_66_0

	for iter_66_0, iter_66_1 in ipairs(self.contextData.chapterVO.champions) do
		if iter_66_1.attachment == ChapterConst.AttachOni then
			var_66_0 = iter_66_0

			break
		end
	end

	if var_66_0 then
		self:updateChampion(var_66_0)
	end

	return
end

function LevelGrid:clearChampions()
	if self.cellChampions then
		for iter_67_0, iter_67_1 in ipairs(self.cellChampions) do
			if iter_67_1 then
				iter_67_1:Clear()
				LeanTween.cancel(iter_67_1.go)
				setActive(iter_67_1.go, false)
				setParent(iter_67_1.go, self.poolParent, false)
				self:getChampionPool(iter_67_1:GetPoolType()):Enqueue(iter_67_1.go, false)
			end
		end

		self.cellChampions = nil
	end

	return
end

function LevelGrid:initCell(arg_68_1, arg_68_2)
	local var_68_0 = self.contextData.chapterVO:getChapterCell(arg_68_1, arg_68_2)

	if var_68_0 then
		local var_68_1

		if var_68_0:IsWalkable() then
			PoolMgr.GetInstance():GetPrefab("chapter/cell_quad", "", false, function(arg_69_0)
				var_68_1 = arg_69_0.transform

				return
			end)

			;(nil).name = ChapterCell.Line2QuadName(arg_68_1, arg_68_2)

			;(nil):SetParent(self.quadRoot, false)

			;(nil).sizeDelta = self.contextData.chapterVO.theme.cellSize
			;(nil).anchoredPosition = self.contextData.chapterVO.theme:GetLinePosition(arg_68_1, arg_68_2)

			;(nil):SetAsLastSibling()
			onButton(self, nil, function()
				if self:isfrozen() then
					return
				end

				self:ClickGridCell(var_68_0)

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

		;(nil):SetParent(self.cellRoot, false)

		;(nil).sizeDelta = self.contextData.chapterVO.theme.cellSize
		;(nil).anchoredPosition = self.contextData.chapterVO.theme:GetLinePosition(arg_68_1, arg_68_2)

		;(nil):SetAsLastSibling()

		local var_68_4 = (nil):Find(ChapterConst.ChildItem)

		var_68_4.localEulerAngles = Vector3(-self.contextData.chapterVO.theme.angle, 0, 0)

		setActive(var_68_4, var_68_0.item)

		local var_68_5 = ItemCell.New(var_68_4, arg_68_1, arg_68_2)

		self.itemCells[ChapterCell.Line2Name(arg_68_1, arg_68_2)] = var_68_5
		var_68_5.loader = self.loader

		var_68_5:Init(var_68_0)

		;(nil):Find(ChapterConst.ChildAttachment).localEulerAngles = Vector3(-self.contextData.chapterVO.theme.angle, 0, 0)
	end

	return
end

function LevelGrid:clearCell(arg_72_1, arg_72_2)
	local var_72_0 = ChapterCell.Line2QuadName(arg_72_1, arg_72_2)
	local var_72_1 = self.cellRoot:Find((ChapterCell.Line2Name(arg_72_1, arg_72_2)))
	local var_72_2 = self.quadRoot:Find(var_72_0)

	if not IsNil(var_72_1) then
		PoolMgr.GetInstance():ReturnPrefab("chapter/cell", "", var_72_1.gameObject)
	end

	if not IsNil(var_72_2) then
		if self.quadTws[var_72_0] then
			LeanTween.cancel(self.quadTws[var_72_0].uniqueId)

			self.quadTws[var_72_0] = nil
		end

		local var_72_3 = var_72_2:Find("grid"):GetComponent(typeof(Image))

		var_72_3.sprite = GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid")
		var_72_3.material = nil

		PoolMgr.GetInstance():ReturnPrefab("chapter/cell_quad", "", var_72_2.gameObject)
	end

	return
end

function LevelGrid:UpdateItemCells()
	if not self.contextData.chapterVO then
		return
	end

	for iter_73_0, iter_73_1 in pairs(self.itemCells) do
		local var_73_0 = iter_73_1:GetOriginalInfo()

		iter_73_1:UpdateAsset((ItemCell.TransformItemAsset(self.contextData.chapterVO, var_73_0 and var_73_0.item)))
	end

	return
end

function LevelGrid:updateAttachments()
	for iter_74_0 = 0, ChapterConst.MaxRow - 1 do
		for iter_74_1 = 0, ChapterConst.MaxColumn - 1 do
			self:updateAttachment(iter_74_0, iter_74_1)
		end
	end

	self:updateExtraAttachments()
	self:updateCoastalGunAttachArea()
	self:displayEscapeGrid()

	return
end

function LevelGrid:UpdateFloor()
	local var_75_0 = {}

	for iter_75_0, iter_75_1 in pairs(self.contextData.chapterVO.cells) do
		for iter_75_2, iter_75_3 in pairs((iter_75_1:GetFlagList())) do
			var_75_0[iter_75_3] = var_75_0[iter_75_3] or {}

			table.insert(var_75_0[iter_75_3], iter_75_1)
		end
	end

	if var_75_0[ChapterConst.FlagBanaiAirStrike] and next(var_75_0[ChapterConst.FlagBanaiAirStrike]) then
		self:hideQuadMark(ChapterConst.MarkBanaiAirStrike)
		self:showQuadMark(var_75_0[ChapterConst.FlagBanaiAirStrike], ChapterConst.MarkBanaiAirStrike, "cell_coastal_gun", Vector2(110, 110), nil, true)
	end

	self:updatePoisonArea()

	if var_75_0[ChapterConst.FlagLava] and next(var_75_0[ChapterConst.FlagLava]) then
		self:hideQuadMark(ChapterConst.MarkLava)
		self:showQuadMark(var_75_0[ChapterConst.FlagLava], ChapterConst.MarkLava, "cell_lava", Vector2(110, 110), nil, true)
	end

	if var_75_0[ChapterConst.FlagNightmare] and next(var_75_0[ChapterConst.FlagNightmare]) then
		self:hideQuadMark(ChapterConst.MarkNightMare)
		self:hideQuadMark(ChapterConst.MarkHideNight)

		local var_75_1 = self.contextData.chapterVO:getExtraFlags()

		if table.contains(var_75_1, ChapterConst.StatusDay) then
			self:showQuadMark(var_75_0[ChapterConst.FlagNightmare], ChapterConst.MarkHideNight, "cell_hidden_nightmare", Vector2(110, 110), nil, true)
		elseif table.contains(var_75_1, ChapterConst.StatusNight) then
			self:showQuadMark(var_75_0[ChapterConst.FlagNightmare], ChapterConst.MarkNightMare, "cell_nightmare", Vector2(110, 110), nil, true)
		end
	end

	local var_75_2 = {}

	for iter_75_4, iter_75_5 in pairs(self.contextData.chapterVO:GetChapterCellAttachemnts()) do
		if iter_75_5.data == ChapterConst.StoryTrigger then
			assert(pg.map_event_template[iter_75_5.attachmentId], "map_event_template not exists " .. iter_75_5.attachmentId)

			if pg.map_event_template[iter_75_5.attachmentId] and pg.map_event_template[iter_75_5.attachmentId].c_type == ChapterConst.EvtType_AdditionalFloor then
				var_75_2[pg.map_event_template[iter_75_5.attachmentId].icon] = var_75_2[pg.map_event_template[iter_75_5.attachmentId].icon] or {}

				table.insert(var_75_2[pg.map_event_template[iter_75_5.attachmentId].icon], iter_75_5)
			end
		end
	end

	for iter_75_6, iter_75_7 in pairs(var_75_2) do
		self:hideQuadMark(iter_75_6)
		self:showQuadMark(iter_75_7, iter_75_6, iter_75_6, Vector2(110, 110), nil, true)
	end

	local var_75_3 = self.contextData.chapterVO:getConfig("alarm_cell")

	if var_75_3 and #var_75_3 > 0 then
		self:ClearEdges(var_75_3[3])
		self:ClearEdges(var_75_3[3] .. "corner")
		self:AddEdgePool(var_75_3[3], "chapter/celltexture/" .. var_75_3[3], "")
		self:AddEdgePool(var_75_3[3] .. "_corner", "chapter/celltexture/" .. var_75_3[3] .. "_corner", "")

		local var_75_4 = _.map(var_75_3[1], function(arg_76_0)
			return {
				row = arg_76_0[1],
				column = arg_76_0[2]
			}
		end)

		self:AddOutlines(var_75_4, nil, var_75_3[5], var_75_3[4], var_75_3[3])
		self:hideQuadMark(var_75_3[2])
		self:showQuadMark(var_75_4, var_75_3[2], var_75_3[2], Vector2(104, 104), nil, true)
	end

	self:HideMissileAimingMarks()

	if var_75_0[ChapterConst.FlagMissleAiming] and next(var_75_0[ChapterConst.FlagMissleAiming]) then
		self:ShowMissileAimingMarks(var_75_0[ChapterConst.FlagMissleAiming])
	end

	local var_75_5 = self.contextData.chapterVO.fleet

	if self.contextData.chapterVO:isPlayingWithBombEnemy() then
		self:showQuadMark(_.map({
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

function LevelGrid:updateExtraAttachments()
	for iter_78_0, iter_78_1 in pairs((self.contextData.chapterVO:GetChapterCellAttachemnts())) do
		local var_78_0 = self.cellRoot:Find(iter_78_0):Find(ChapterConst.ChildAttachment)
		local var_78_1

		if iter_78_1.data == ChapterConst.StoryTrigger and pg.map_event_template[iter_78_1.attachmentId].c_type ~= ChapterConst.EvtType_AdditionalFloor then
			var_78_1 = MapEventStoryTriggerCellView
		end

		local var_78_2 = self.extraAttachmentCells[iter_78_0]

		if self.extraAttachmentCells[iter_78_0] and var_78_2.class ~= var_78_1 then
			var_78_2:Clear()

			var_78_2 = nil
			self.extraAttachmentCells[iter_78_0] = nil
		end

		if var_78_1 then
			if not var_78_2 then
				var_78_2 = var_78_1.New(var_78_0)
				self.extraAttachmentCells[iter_78_0] = var_78_2
			end

			var_78_2.info = iter_78_1
			var_78_2.chapter = self.contextData.chapterVO

			var_78_2:SetLine({
				row = iter_78_1.row,
				column = iter_78_1.column
			})
			var_78_2:Update()
		end
	end

	return
end

function LevelGrid:updateAttachment(arg_79_1, arg_79_2)
	local var_79_0 = self.contextData.chapterVO
	local var_79_1 = self.contextData.chapterVO:getChapterCell(arg_79_1, arg_79_2)

	if not var_79_1 then
		return
	end

	local var_79_2 = ChapterCell.Line2Name(arg_79_1, arg_79_2)
	local var_79_3 = self.cellRoot:Find(var_79_2):Find(ChapterConst.ChildAttachment)
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
			var_79_5.viewParent = self
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
			var_79_5.grid = self
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
			if not self.attachmentCells[var_79_2] then
				return
			end

			if self.attachmentCells[var_79_2].class ~= StaticEggCellView and self.attachmentCells[var_79_2].class ~= StaticChampionCellView then
				return
			end

			local var_80_0 = self.attachmentCells[var_79_2].info

			if not self.attachmentCells[var_79_2].info then
				return
			end

			return pg.expedition_data_template[var_80_0.attachmentId].dungeon_id == 0
		end)()
	end

	if var_79_5.fadeAnim then
		self:PlayAttachmentEffect(arg_79_1, arg_79_2, "miwuxiaosan")
	end

	local var_79_7 = self.attachmentCells[var_79_2]

	if self.attachmentCells[var_79_2] and var_79_7.class ~= var_79_4 then
		var_79_7:Clear()

		var_79_7 = nil
		self.attachmentCells[var_79_2] = nil
	end

	if var_79_4 then
		if not var_79_7 then
			var_79_7 = var_79_4.New(var_79_3)

			var_79_7:SetLine({
				row = arg_79_1,
				column = arg_79_2
			})

			self.attachmentCells[var_79_2] = var_79_7
		end

		var_79_7.info = var_79_1

		for iter_79_0, iter_79_1 in pairs(var_79_5) do
			var_79_7[iter_79_0] = iter_79_1
		end

		var_79_7:Update()
	end

	return
end

function LevelGrid:InitWalls()
	for iter_81_0 = self.indexMin.x, self.indexMax.x do
		for iter_81_1 = self.indexMin.y, self.indexMax.y do
			local var_81_0 = self.contextData.chapterVO:GetRawChapterCell(iter_81_0, iter_81_1)

			if var_81_0 then
				while ChapterConst.ForbiddenUp > 0 do
					self:InitWallDirection(var_81_0, ChapterConst.ForbiddenUp)
				end
			end
		end
	end

	for iter_81_2, iter_81_3 in pairs(self.walls) do
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

function LevelGrid:InitWallDirection(arg_82_1, arg_82_2)
	local var_82_0 = self.contextData.chapterVO

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
	local var_82_7 = self.walls[var_82_6]

	if not self.walls[var_82_6] then
		local var_82_8 = var_82_0.theme:GetLinePosition(arg_82_1.row, arg_82_1.column)

		var_82_8.x = var_82_8.x + var_82_1[2] * (var_82_0.theme.cellSize.x + var_82_0.theme.cellSpace.x) * 0.5
		var_82_8.y = var_82_8.y - var_82_1[1] * (var_82_0.theme.cellSize.y + var_82_0.theme.cellSpace.y) * 0.5

		local var_82_9 = WallCell.New(var_82_2, var_82_3, bit.band(arg_82_2, ChapterConst.ForbiddenRow) > 0, var_82_8)

		var_82_9.girdParent = self
		self.walls[var_82_6] = var_82_9
		var_82_7 = var_82_9

		if var_82_0.wallAssets[arg_82_1.row .. "_" .. arg_82_1.column] then
			var_82_7.WallPrefabs = var_82_0.wallAssets[arg_82_1.row .. "_" .. arg_82_1.column]
		end
	end

	var_82_7.BanCount = var_82_7.BanCount + (var_82_5 and 2 or 1)

	return
end

function LevelGrid:UpdateWeatherCells(arg_83_1)
	arg_83_1 = arg_83_1 or underscore.keys(self.contextData.chapterVO.cells)

	local var_83_0 = self.contextData.chapterVO:IsFogStage()

	for iter_83_0, iter_83_1 in ipairs(arg_83_1) do
		local var_83_1
		local var_83_2 = self.contextData.chapterVO.cells[iter_83_1]:GetWeatherFlagList()

		if #var_83_2 > 0 then
			var_83_1 = MapWeatherCellView
		end

		local var_83_3 = self.weatherCells[iter_83_1]

		if self.weatherCells[iter_83_1] and var_83_3.class ~= var_83_1 then
			var_83_3:Clear()

			var_83_3 = nil
			self.weatherCells[iter_83_1] = nil
		end

		if var_83_1 then
			if not var_83_3 then
				var_83_3 = var_83_1.New((self.cellRoot:Find(iter_83_1):Find(ChapterConst.ChildAttachment)))

				var_83_3:SetLine({
					row = self.contextData.chapterVO.cells[iter_83_1].row,
					column = self.contextData.chapterVO.cells[iter_83_1].column
				})

				self.weatherCells[iter_83_1] = var_83_3
			end

			var_83_3.info = self.contextData.chapterVO.cells[iter_83_1]

			var_83_3:Update(var_83_2)
		end

		if var_83_0 and tobool((self.contextData.chapterVO:GetEnemy(self.contextData.chapterVO.cells[iter_83_1].row, self.contextData.chapterVO.cells[iter_83_1].column))) then
			self:updateAttachment(self.contextData.chapterVO.cells[iter_83_1].row, self.contextData.chapterVO.cells[iter_83_1].column)
		end
	end

	return
end

function LevelGrid:updateFogCells()
	for iter_84_0, iter_84_1 in pairs(self.contextData.chapterVO.cells) do
		setImageAlpha(self.cellRoot:Find((ChapterCell.Line2Name(iter_84_1.row, iter_84_1.column))):Find(ChapterConst.ChildVisible .. "/mask"), iter_84_1:IsVisible() and 0 or 0.4)
	end

	return
end

function LevelGrid:updateQuadCells(arg_85_1)
	arg_85_1 = arg_85_1 or ChapterConst.QuadStateNormal
	self.quadState = arg_85_1

	self:updateQuadBase()

	if arg_85_1 == ChapterConst.QuadStateNormal then
		self:UpdateQuadStateNormal()
	elseif arg_85_1 == ChapterConst.QuadStateBarrierSetting then
		self:UpdateQuadStateBarrierSetting()
	elseif arg_85_1 == ChapterConst.QuadStateTeleportSub then
		self:UpdateQuadStateTeleportSub()
	elseif arg_85_1 == ChapterConst.QuadStateMissileStrike or arg_85_1 == ChapterConst.QuadStateAirSuport then
		self:UpdateQuadStateMissileStrike()
	elseif arg_85_1 == ChapterConst.QuadStateExpel then
		self:UpdateQuadStateAirExpel()
	end

	self:UpdateOpBtns()

	return
end

function LevelGrid:PlayQuadsParallelAnim(arg_86_1)
	self:frozen()
	table.ParallelIpairsAsync(arg_86_1, function(arg_87_0, arg_87_1, arg_87_2)
		local var_87_0 = ChapterCell.Line2QuadName(arg_87_1.row, arg_87_1.column)
		local var_87_1 = self.quadRoot:Find(var_87_0)

		self:cancelQuadTween(var_87_0, var_87_1)
		setImageAlpha(var_87_1, 0.4)

		local var_87_2 = {}

		var_87_2.uniqueId = LeanTween.scale(var_87_1, Vector3.one, 0.2):setFrom(Vector3.zero):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_87_2)).uniqueId
		self.presentTws[var_87_0] = var_87_2

		return
	end, function()
		self:unfrozen()

		return
	end)

	return
end

function LevelGrid:updateQuadBase()
	local var_89_0 = self.contextData.chapterVO

	if self.contextData.chapterVO.fleet == nil then
		return
	end

	self:killPresentTws()

	local function var_89_1(arg_90_0)
		if not arg_90_0 or not arg_90_0:IsWalkable() then
			return
		end

		local var_90_0 = arg_90_0.row
		local var_90_1 = ChapterCell.Line2QuadName(arg_90_0.row, arg_90_0.column)
		local var_90_2 = self.quadRoot:Find(var_90_1)

		var_90_2.localScale = Vector3.one

		local var_90_3 = var_90_2:Find("grid"):GetComponent(typeof(Image))
		local var_90_4 = var_89_0:getChampion(var_90_0, arg_90_0.column)

		if var_90_4 and var_90_4.flag == ChapterConst.CellFlagActive and var_90_4.trait ~= ChapterConst.TraitLurk and var_89_0:getChampionVisibility(var_90_4) and not var_89_0:existFleet(FleetType.Transport, var_90_0, arg_90_0.column) then
			self:startQuadTween(var_90_1, var_90_2)
			setImageSprite(var_90_2, GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_enemy"))
			setImageSprite(var_90_2:Find("grid"), GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_enemy_grid"))

			var_90_3.material = self.material_Add

			return
		end

		local var_90_5 = var_89_0:GetRawChapterAttachemnt(var_90_0, arg_90_0.column)

		if var_90_5 then
			local var_90_6 = var_89_0:getQuadCellPic(var_90_5)

			if var_90_6 then
				self:startQuadTween(var_90_1, var_90_2)
				setImageSprite(var_90_2, GetSpriteFromAtlas("chapter/pic/cellgrid", var_90_6))

				return
			end
		end

		if var_89_0:getChapterCell(var_90_0, arg_90_0.column) then
			local var_90_7 = var_89_0:getQuadCellPic(arg_90_0)

			if var_90_7 then
				self:startQuadTween(var_90_1, var_90_2)

				if var_90_7 == "cell_enemy" then
					setImageSprite(var_90_2:Find("grid"), GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_enemy_grid"))

					var_90_3.material = self.material_Add
				else
					setImageSprite(var_90_2:Find("grid"), GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid"))

					var_90_3.material = nil
				end

				setImageSprite(var_90_2, GetSpriteFromAtlas("chapter/pic/cellgrid", var_90_7))

				return
			end
		end

		self:cancelQuadTween(var_90_1, var_90_2)
		setImageAlpha(var_90_2, ChapterConst.CellEaseOutAlpha)
		setImageSprite(var_90_2, GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_normal"))
		setImageSprite(var_90_2:Find("grid"), GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid"))

		var_90_3.material = nil

		return
	end

	for iter_89_0, iter_89_1 in pairs(self.contextData.chapterVO.cells) do
		var_89_1(iter_89_1)
	end

	if self.contextData.chapterVO:isPlayingWithBombEnemy() then
		self:hideQuadMark(ChapterConst.MarkBomb)
	end

	return
end

function LevelGrid:UpdateQuadStateNormal()
	local var_91_0 = self.contextData.chapterVO
	local var_91_1 = self.contextData.chapterVO.fleet
	local var_91_2

	if self.contextData.chapterVO:existMoveLimit() and not self.contextData.chapterVO:checkAnyInteractive() then
		var_91_2 = self.contextData.chapterVO:calcWalkableCells(ChapterConst.SubjectPlayer, self.contextData.chapterVO.fleet.line.row, self.contextData.chapterVO.fleet.line.column, self.contextData.chapterVO.fleet:getSpeed())
	end

	if not var_91_2 or #var_91_2 == 0 then
		return
	end

	local var_91_3 = ManhattonDist(_.min(var_91_2, function(arg_92_0)
		return ManhattonDist(arg_92_0, var_91_1.line)
	end), self.contextData.chapterVO.fleet.line)

	_.each(var_91_2, function(arg_93_0)
		local var_93_0 = ChapterCell.Line2QuadName(arg_93_0.row, arg_93_0.column)
		local var_93_1 = self.quadRoot:Find(var_93_0)

		self:cancelQuadTween(var_93_0, var_93_1)
		setImageSprite(var_93_1, GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_normal"))

		local var_93_2 = var_93_1:Find("grid"):GetComponent(typeof(Image))

		var_93_2.sprite = GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid")
		var_93_2.material = nil

		setImageAlpha(var_93_1, var_91_0:getRound() == ChapterConst.RoundPlayer and 1 or ChapterConst.CellEaseOutAlpha)

		var_93_1.localScale = Vector3.zero

		local var_93_3 = {}

		var_93_3.uniqueId = LeanTween.scale(var_93_1, Vector3.one, 0.2):setFrom(Vector3.zero):setEase(LeanTweenType.easeInOutSine):setDelay((ManhattonDist(arg_93_0, var_91_1.line) - var_91_3) * 0.1).uniqueId
		self.presentTws[var_93_0] = var_93_3

		return
	end)

	return
end

function LevelGrid:UpdateQuadStateBarrierSetting()
	local var_94_0 = self.contextData.chapterVO.fleet
	local var_94_1 = self.contextData.chapterVO:calcSquareBarrierCells(self.contextData.chapterVO.fleet.line.row, self.contextData.chapterVO.fleet.line.column, 1)

	if not var_94_1 or #var_94_1 == 0 then
		return
	end

	local var_94_2 = ManhattonDist(_.min(var_94_1, function(arg_95_0)
		return ManhattonDist(arg_95_0, var_94_0.line)
	end), self.contextData.chapterVO.fleet.line)

	_.each(var_94_1, function(arg_96_0)
		local var_96_0 = ChapterCell.Line2QuadName(arg_96_0.row, arg_96_0.column)
		local var_96_1 = self.quadRoot:Find(var_96_0)

		self:cancelQuadTween(var_96_0, var_96_1)
		setImageSprite(var_96_1, GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_barrier_select"))

		local var_96_2 = var_96_1:Find("grid"):GetComponent(typeof(Image))

		var_96_2.sprite = GetSpriteFromAtlas("chapter/pic/cellgrid", "cell_grid")
		var_96_2.material = nil

		setImageAlpha(var_96_1, 1)

		var_96_1.localScale = Vector3.zero

		local var_96_3 = {}

		var_96_3.uniqueId = LeanTween.scale(var_96_1, Vector3.one, 0.2):setFrom(Vector3.zero):setEase(LeanTweenType.easeInOutSine):setDelay((ManhattonDist(arg_96_0, var_94_0.line) - var_94_2) * 0.1).uniqueId
		self.presentTws[var_96_0] = var_96_3

		return
	end)

	return
end

function LevelGrid:UpdateQuadStateTeleportSub()
	local var_97_0 = self.contextData.chapterVO
	local var_97_1 = _.detect(self.contextData.chapterVO.fleets, function(arg_98_0)
		return arg_98_0:getFleetType() == FleetType.Submarine
	end)

	if not var_97_1 then
		return
	end

	self:PlayQuadsParallelAnim((_.filter(self.contextData.chapterVO:calcWalkableCells(nil, var_97_1.line.row, var_97_1.line.column, ChapterConst.MaxStep), function(arg_99_0)
		return not var_97_0:getQuadCellPic(var_97_0:getChapterCell(arg_99_0.row, arg_99_0.column))
	end)))

	return
end

function LevelGrid:UpdateQuadStateMissileStrike()
	local var_100_0 = self.contextData.chapterVO

	self:PlayQuadsParallelAnim((_.filter(_.values(self.contextData.chapterVO.cells), function(arg_101_0)
		return arg_101_0:IsWalkable() and not var_100_0:getQuadCellPic(arg_101_0)
	end)))

	return
end

function LevelGrid:UpdateQuadStateAirExpel()
	local var_102_0 = self.contextData.chapterVO

	if not self.airSupportTarget or not self.airSupportTarget.source then
		self:PlayQuadsParallelAnim((_.filter(_.values(self.contextData.chapterVO.cells), function(arg_103_0)
			return arg_103_0:IsWalkable() and not var_102_0:getQuadCellPic(arg_103_0)
		end)))

		return
	end

	self:PlayQuadsParallelAnim((self.contextData.chapterVO:calcWalkableCells(ChapterConst.SubjectChampion, self.airSupportTarget.source.row, self.airSupportTarget.source.column, 1)))

	return
end

function LevelGrid:ClickGridCell(arg_104_1)
	if self.quadState == ChapterConst.QuadStateBarrierSetting then
		self:OnBarrierSetting(arg_104_1)
	elseif self.quadState == ChapterConst.QuadStateTeleportSub then
		self:OnTeleportConfirm(arg_104_1)
	elseif self.quadState == ChapterConst.QuadStateMissileStrike then
		self:OnMissileAiming(arg_104_1)
	elseif self.quadState == ChapterConst.QuadStateAirSuport then
		self:OnAirSupportAiming(arg_104_1)
	elseif self.quadState == ChapterConst.QuadStateExpel then
		self:OnAirExpelSelect(arg_104_1)
	else
		self:emit(LevelUIConst.ON_CLICK_GRID_QUAD, arg_104_1)
	end

	return
end

function LevelGrid:OnBarrierSetting(arg_105_1)
	if not _.any(self.contextData.chapterVO:calcSquareBarrierCells(self.contextData.chapterVO.fleet.line.row, self.contextData.chapterVO.fleet.line.column, 1), function(arg_106_0)
		return arg_106_0.row == arg_105_1.row and arg_106_0.column == arg_105_1.column
	end) then
		return
	end

	;(function(arg_107_0, arg_107_1)
		newChapterVO = self.contextData.chapterVO

		if not newChapterVO:existBarrier(arg_107_0, arg_107_1) and newChapterVO.modelCount <= 0 then
			return
		end

		self:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpBarrier,
			id = newChapterVO.fleet.id,
			arg1 = arg_107_0,
			arg2 = arg_107_1
		})

		return
	end)(arg_105_1.row, arg_105_1.column)

	return
end

function LevelGrid:PrepareSubTeleport()
	local var_108_0 = self.contextData.chapterVO
	local var_108_1 = self.contextData.chapterVO:GetSubmarineFleet()
	local var_108_2 = self.cellFleets[var_108_1.id]
	local var_108_3 = var_108_1.startPos

	for iter_108_0, iter_108_1 in pairs(self.contextData.chapterVO.fleets) do
		if iter_108_1:getFleetType() == FleetType.Normal then
			self:updateFleet(iter_108_1.id)
		end
	end

	local var_108_4 = var_108_0:existEnemy(ChapterConst.SubjectPlayer, var_108_3.row, var_108_3.column) or var_108_0:existFleet(FleetType.Normal, var_108_3.row, var_108_3.column)

	setActive(var_108_2.tfAmmo, not var_108_4)
	var_108_2:SetActiveModel(true)

	if var_108_0.subAutoAttack ~= 1 then
		self:PlaySubAnimation(var_108_2, false, function()
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

function LevelGrid:TurnOffSubTeleport()
	self.subTeleportTargetLine = nil

	local var_110_0 = self.contextData.chapterVO

	self:hideQuadMark(ChapterConst.MarkMovePathArrow)
	self:hideQuadMark(ChapterConst.MarkHuntingRange)
	self:ClearEdges("SubmarineHunting")
	self:UpdateDestinationMark()

	local var_110_1 = var_110_0:GetSubmarineFleet()
	local var_110_2 = self.cellFleets[var_110_1.id]
	local var_110_3 = var_110_0.subAutoAttack == 1

	self.cellFleets[var_110_1.id]:SetActiveModel(var_110_0.subAutoAttack == 1)

	if not var_110_3 then
		self:PlaySubAnimation(var_110_2, true, function()
			self:updateFleet(var_110_1.id)

			return
		end)
	else
		self:updateFleet(var_110_1.id)
	end

	self:ShowHuntingRange()

	return
end

function LevelGrid:OnTeleportConfirm(arg_112_1)
	local var_112_0 = self.contextData.chapterVO:getChapterCell(arg_112_1.row, arg_112_1.column)

	if var_112_0 and var_112_0:IsWalkable() and not self.contextData.chapterVO:existBarrier(arg_112_1.row, arg_112_1.column) then
		local var_112_1 = self.contextData.chapterVO:GetSubmarineFleet()

		if var_112_1.startPos.row == arg_112_1.row and var_112_1.startPos.column == arg_112_1.column then
			return
		end

		local var_112_2, var_112_3 = self.contextData.chapterVO:findPath(nil, var_112_1.startPos, arg_112_1)

		if var_112_2 >= PathFinding.PrioObstacle or arg_112_1.row ~= var_112_3[#var_112_3].row or arg_112_1.column ~= var_112_3[#var_112_3].column then
			return
		end

		self:ShowTargetHuntingRange(arg_112_1)
		self:UpdateDestinationMark(arg_112_1)

		if var_112_2 > 0 then
			self:ShowPathInArrows(var_112_3)

			self.subTeleportTargetLine = arg_112_1
		end
	end

	return
end

function LevelGrid:ShowPathInArrows(arg_113_1)
	local var_113_0 = Clone(arg_113_1)

	table.remove(var_113_0, #var_113_0)

	for iter_113_0 = #var_113_0, 1, -1 do
		if self.contextData.chapterVO:existEnemy(ChapterConst.SubjectPlayer, var_113_0[iter_113_0].row, var_113_0[iter_113_0].column) or self.contextData.chapterVO:getFleet(FleetType.Normal, var_113_0[iter_113_0].row, var_113_0[iter_113_0].column) then
			table.remove(var_113_0, iter_113_0)
		end
	end

	self:hideQuadMark(ChapterConst.MarkMovePathArrow)
	self:showQuadMark(var_113_0, ChapterConst.MarkMovePathArrow, "cell_path_arrow", Vector2(100, 100), nil, true)

	for iter_113_1 = #arg_113_1, 1, -1 do
		if self.markQuads[ChapterConst.MarkMovePathArrow] and self.markQuads[ChapterConst.MarkMovePathArrow][ChapterCell.Line2MarkName(arg_113_1[iter_113_1].row, arg_113_1[iter_113_1].column, ChapterConst.MarkMovePathArrow)] then
			local var_113_2 = Vector3.Normalize(Vector3(arg_113_1[iter_113_1 + 1].column - arg_113_1[iter_113_1].column, arg_113_1[iter_113_1].row - arg_113_1[iter_113_1 + 1].row, 0))

			;(self.markQuads[ChapterConst.MarkMovePathArrow] and self.markQuads[ChapterConst.MarkMovePathArrow][ChapterCell.Line2MarkName(arg_113_1[iter_113_1].row, arg_113_1[iter_113_1].column, ChapterConst.MarkMovePathArrow)]).localEulerAngles = Vector3(0, 0, Mathf.Acos((Vector3.Dot(var_113_2, Vector3.up))) * Mathf.Rad2Deg * (Vector3.Cross(Vector3.up, var_113_2).z > 0 and 1 or -1))
		end
	end

	return
end

function LevelGrid:ShowMissileAimingMarks(arg_114_1)
	_.each(arg_114_1, function(arg_115_0)
		self.loader:GetPrefabBYGroup("ui/miaozhun02", "miaozhun02", function(arg_116_0)
			setParent(arg_116_0, self.restrictMap)

			local var_116_0 = self.contextData.chapterVO.theme:GetLinePosition(arg_115_0.row, arg_115_0.column)

			tf(arg_116_0).anchoredPosition = Vector2(var_116_0.x - self.restrictMap.anchoredPosition.x, var_116_0.y - self.restrictMap.anchoredPosition.y)

			return
		end, "MissileAimingMarks")

		return
	end)

	return
end

function LevelGrid:HideMissileAimingMarks()
	self.loader:ReturnGroup("MissileAimingMarks")

	return
end

function LevelGrid:ShowMissileAimingMark(arg_118_1)
	self.loader:GetPrefab("ui/miaozhun02", "miaozhun02", function(arg_119_0)
		setParent(arg_119_0, self.restrictMap)

		local var_119_0 = self.contextData.chapterVO.theme:GetLinePosition(arg_118_1.row, arg_118_1.column)

		tf(arg_119_0).anchoredPosition = Vector2(var_119_0.x - self.restrictMap.anchoredPosition.x, var_119_0.y - self.restrictMap.anchoredPosition.y)

		return
	end, "MissileAimingMark")

	return
end

function LevelGrid:HideMissileAimingMark()
	self.loader:ClearRequest("MissileAimingMark")

	return
end

function LevelGrid:OnMissileAiming(arg_121_1)
	self:HideMissileAimingMark()
	self:ShowMissileAimingMark(arg_121_1)

	self.missileStrikeTargetLine = arg_121_1

	return
end

function LevelGrid:ShowAirSupportAimingMark(arg_122_1)
	self.loader:GetPrefab("ui/miaozhun03", "miaozhun03", function(arg_123_0)
		setParent(arg_123_0, self.restrictMap)

		local var_123_0 = self.contextData.chapterVO.theme:GetLinePosition(arg_122_1.row - 0.5, arg_122_1.column)

		tf(arg_123_0).anchoredPosition = Vector2(var_123_0.x - self.restrictMap.anchoredPosition.x, var_123_0.y - self.restrictMap.anchoredPosition.y)

		return
	end, "AirSupportAimingMark")

	return
end

function LevelGrid:HideAirSupportAimingMark()
	self.loader:ClearRequest("AirSupportAimingMark")

	return
end

function LevelGrid:OnAirSupportAiming(arg_125_1)
	self:HideAirSupportAimingMark()
	self:ShowAirSupportAimingMark(arg_125_1)

	self.missileStrikeTargetLine = arg_125_1

	return
end

function LevelGrid:ShowAirExpelAimingMark()
	local var_126_0 = self.airSupportTarget

	if not self.airSupportTarget or not self.airSupportTarget.source then
		return
	end

	local var_126_1 = self.airSupportTarget.source
	local var_126_2 = self.cellRoot:Find((ChapterCell.Line2Name(self.airSupportTarget.source.row, self.airSupportTarget.source.column)))

	local function var_126_3(arg_127_0, arg_127_1)
		setParent(arg_127_0, var_126_2)

		GetOrAddComponent(arg_127_0, typeof(Canvas)).overrideSorting = true

		if not arg_127_1 then
			return
		end

		tf(arg_127_0).localEulerAngles = Vector3(-self.contextData.chapterVO.theme.angle, 0, 0)

		return
	end

	self.loader:GetPrefabBYGroup("leveluiview/tpl_airsupportmark", "tpl_airsupportmark", function(arg_128_0)
		var_126_3(arg_128_0, true)

		return
	end, "AirExpelAimingMark")
	self.loader:GetPrefabBYGroup("leveluiview/tpl_airsupportdirection", "tpl_airsupportdirection", function(arg_129_0)
		var_126_3(arg_129_0)

		local var_129_0 = {
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
			setActive(tf(arg_129_0):Find(iter_129_0), var_126_0 and self.contextData.chapterVO:considerAsStayPoint(ChapterConst.SubjectChampion, var_126_1.row + var_129_0[iter_129_0][1], var_126_1.column + var_129_0[iter_129_0][2]))
		end

		return
	end, "AirExpelAimingMark")

	return
end

function LevelGrid:HideAirExpelAimingMark()
	self.loader:ReturnGroup("AirExpelAimingMark")

	return
end

function LevelGrid:OnAirExpelSelect(arg_131_1)
	local var_131_0 = self.contextData.chapterVO

	self.airSupportTarget = self.airSupportTarget or {}

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

		if self.airSupportTarget.source and table.equal(self.airSupportTarget.source:GetLine(), var_131_1:GetLine()) then
			var_131_1 = nil
		end

		self.airSupportTarget.source = var_131_1

		;(function()
			self:HideAirExpelAimingMark()
			self:ShowAirExpelAimingMark()
			self:updateQuadBase()
			self:UpdateQuadStateAirExpel()

			return
		end)()
	elseif not self.airSupportTarget.source then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelscene_airexpel_select_enemy"))
	elseif ManhattonDist(self.airSupportTarget.source, arg_131_1) > 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelscene_airexpel_outrange"))
	elseif not var_131_0:considerAsStayPoint(ChapterConst.SubjectChampion, arg_131_1.row, arg_131_1.column) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelscene_airexpel_outrange"))
	else
		local var_131_2 = self.airSupportTarget.source
		local var_131_3 = arg_131_1

		if not self.airSupportTarget.source or not arg_131_1 then
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

		if var_131_4[1] ~= 0 then
			var_131_6 = var_131_4[1] + 2
		end

		local var_131_8

		do
			var_131_6 = 3 - var_131_4[2]

			local var_131_7 = var_131_0:getChapterSupportFleet()

			var_131_8 = {}
		end

		var_131_8.content = i18n("levelscene_airexpel_select_confirm_" .. var_131_5[var_131_6], pg.expedition_data_template[var_131_2.attachmentId].name)

		function var_131_8.onYes()
			self:emit(LevelMediator2.ON_OP, {
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

		pg.MsgboxMgr.GetInstance():ShowMsgBox(var_131_8)
	end

	return
end

function LevelGrid:CleanAirSupport()
	self.airSupportTarget = nil

	return
end

function LevelGrid:startQuadTween(arg_135_1, arg_135_2, arg_135_3, arg_135_4)
	if self.presentTws[arg_135_1] then
		LeanTween.cancel(self.presentTws[arg_135_1].uniqueId)

		self.presentTws[arg_135_1] = nil
	end

	if not self.quadTws[arg_135_1] then
		arg_135_3 = arg_135_3 or 1
		arg_135_4 = arg_135_4 or ChapterConst.CellEaseOutAlpha

		setImageAlpha(arg_135_2, arg_135_3)

		local var_135_0 = LeanTween.alpha(arg_135_2, arg_135_4, 1):setLoopPingPong()

		self.quadTws[arg_135_1] = {
			tw = var_135_0,
			uniqueId = var_135_0.uniqueId
		}
	end

	return
end

function LevelGrid:cancelQuadTween(arg_136_1, arg_136_2)
	if self.quadTws[arg_136_1] then
		LeanTween.cancel(self.quadTws[arg_136_1].uniqueId)

		self.quadTws[arg_136_1] = nil
	end

	setImageAlpha(arg_136_2, ChapterConst.CellEaseOutAlpha)

	return
end

function LevelGrid:killQuadTws()
	for iter_137_0, iter_137_1 in pairs(self.quadTws) do
		LeanTween.cancel(iter_137_1.uniqueId)
	end

	self.quadTws = {}

	return
end

function LevelGrid:killPresentTws()
	for iter_138_0, iter_138_1 in pairs(self.presentTws) do
		LeanTween.cancel(iter_138_1.uniqueId)
	end

	self.presentTws = {}

	return
end

function LevelGrid:startMarkTween(arg_139_1, arg_139_2, arg_139_3, arg_139_4)
	if not self.markTws[arg_139_1] then
		arg_139_3 = arg_139_3 or 1
		arg_139_4 = arg_139_4 or 0.2

		setImageAlpha(arg_139_2, arg_139_3)

		local var_139_0 = LeanTween.alpha(arg_139_2, arg_139_4, 0.7):setLoopPingPong():setEase(LeanTweenType.easeInOutSine):setDelay(1)

		self.markTws[arg_139_1] = {
			tw = var_139_0,
			uniqueId = var_139_0.uniqueId
		}
	end

	return
end

function LevelGrid:cancelMarkTween(arg_140_1, arg_140_2, arg_140_3)
	if self.markTws[arg_140_1] then
		LeanTween.cancel(self.markTws[arg_140_1].uniqueId)

		self.markTws[arg_140_1] = nil
	end

	setImageAlpha(arg_140_2, arg_140_3 or ChapterConst.CellEaseOutAlpha)

	return
end

function LevelGrid:moveFleet(arg_141_1, arg_141_2, arg_141_3, arg_141_4)
	local var_141_0 = self.contextData.chapterVO
	local var_141_1 = self.contextData.chapterVO:IsFogStage()
	local var_141_2 = self.contextData.chapterVO.fleet
	local var_141_3 = self.contextData.chapterVO.fleet.id
	local var_141_4 = self.cellFleets[self.contextData.chapterVO.fleet.id]

	self.cellFleets[self.contextData.chapterVO.fleet.id]:SetSpineVisible(true)
	setActive(self.cellFleets[self.contextData.chapterVO.fleet.id].tfShadow, true)
	setActive(self.arrowTarget, true)
	self:updateTargetArrow(arg_141_2[#arg_141_2])

	if arg_141_3 then
		self:updateAttachment(arg_141_3.row, arg_141_3.column)
	end

	local function var_141_5(arg_142_0)
		if var_141_1 then
			self:UpdateWeatherCells((var_141_0:UpdateCellsVisible(var_141_2, arg_142_0)))
		end

		return
	end

	self:updateQuadCells(ChapterConst.QuadStateFrozen)
	var_141_5(self.cellFleets[self.contextData.chapterVO.fleet.id]:GetLine())
	self:moveCellView(self.cellFleets[self.contextData.chapterVO.fleet.id], arg_141_1, arg_141_2, function(arg_143_0)
		var_141_2.step = var_141_2.step + 1

		var_141_5(arg_143_0)
		existCall(self.onShipStepChange, arg_143_0)

		return
	end, function(arg_144_0)
		return
	end, function()
		setActive(self.arrowTarget, false)

		if ChapterConst.NeedClearStep((var_141_0:getChapterCell(var_141_0.fleet.line.row, var_141_0.fleet.line.column))) then
			var_141_2.step = 0
		end

		var_141_2.rotation = var_141_4:GetRotatePivot().transform.localRotation

		self:updateAttachment(var_141_0.fleet.line.row, var_141_0.fleet.line.column)
		self:updateFleet(var_141_3)
		self:updateOni()

		local var_145_0 = var_141_0:getChampionIndex(var_141_0.fleet.line.row, var_141_0.fleet.line.column)

		if var_145_0 then
			self:updateChampion(var_145_0)
		end

		if self.onShipArrived then
			self.onShipArrived()
		end

		if arg_141_4 then
			arg_141_4()
		end

		return
	end)

	return
end

function LevelGrid:moveSub(arg_146_1, arg_146_2, arg_146_3, arg_146_4)
	local var_146_0 = self.contextData.chapterVO
	local var_146_1 = self.contextData.chapterVO.fleets[arg_146_1]
	local var_146_2 = self.cellFleets[self.contextData.chapterVO.fleets[arg_146_1].id]
	local var_146_3 = arg_146_2[#arg_146_2]

	self:updateQuadCells(ChapterConst.QuadStateFrozen)
	self:teleportSubView(self.cellFleets[self.contextData.chapterVO.fleets[arg_146_1].id], self.cellFleets[self.contextData.chapterVO.fleets[arg_146_1].id]:GetLine(), arg_146_2[#arg_146_2], function(arg_147_0)
		return
	end, function(arg_148_0)
		return
	end, function()
		var_146_2:SetActiveModel(not (var_146_0:existEnemy(ChapterConst.SubjectPlayer, var_146_3.row, var_146_3.column) or var_146_0:existAlly(var_146_1)) and var_146_0.subAutoAttack == 1)

		var_146_1.rotation = var_146_2:GetRotatePivot().transform.localRotation

		if arg_146_4 then
			arg_146_4()
		end

		return
	end)

	return
end

function LevelGrid:moveChampion(arg_150_1, arg_150_2, arg_150_3, arg_150_4)
	local var_150_0 = self.contextData.chapterVO.champions[arg_150_1]
	local var_150_1 = self.cellChampions[arg_150_1]

	local function var_150_2()
		if var_150_1.GetRotatePivot then
			var_150_0.rotation = var_150_1:GetRotatePivot().transform.localRotation
		end

		if arg_150_4 then
			arg_150_4()
		end

		return
	end

	if self.contextData.chapterVO:getChampionVisibility(self.contextData.chapterVO.champions[arg_150_1]) then
		self:moveCellView(self.cellChampions[arg_150_1], arg_150_2, arg_150_3, function(arg_151_0)
			return
		end, function(arg_152_0)
			return
		end, var_150_2)
	else
		self.cellChampions[arg_150_1]:RefreshLinePosition(self.contextData.chapterVO, arg_150_2[#arg_150_2])
		var_150_2()
	end

	return
end

function LevelGrid:moveTransport(arg_154_1, arg_154_2, arg_154_3, arg_154_4)
	local var_154_0 = self.contextData.chapterVO.fleets[arg_154_1]
	local var_154_1 = self.cellFleets[self.contextData.chapterVO.fleets[arg_154_1].id]

	self:updateQuadCells(ChapterConst.QuadStateFrozen)
	self:moveCellView(self.cellFleets[self.contextData.chapterVO.fleets[arg_154_1].id], arg_154_2, arg_154_3, function(arg_155_0)
		return
	end, function(arg_156_0)
		return
	end, function()
		var_154_0.rotation = var_154_1:GetRotatePivot().transform.localRotation

		self:updateFleet(var_154_0.id)
		existCall(arg_154_4)

		return
	end)

	return
end

function LevelGrid:moveCellView(arg_158_1, arg_158_2, arg_158_3, arg_158_4, arg_158_5, arg_158_6)
	local var_158_0 = self.contextData.chapterVO
	local var_158_1

	local function var_158_2()
		if var_158_1 and coroutine.status(var_158_1) == "suspended" then
			local var_159_0, var_159_1 = coroutine.resume(var_158_1)

			assert(var_159_0, debug.traceback(var_158_1, var_159_1))
		end

		return
	end

	var_158_1 = coroutine.create(function()
		self:frozen()

		local var_160_0

		if var_158_0:GetQuickPlayFlag() then
			var_160_0 = ChapterConst.ShipStepQuickPlayScale or 1
		end

		local var_160_1 = 0.3 * var_160_0
		local var_160_2 = ChapterConst.ShipStepDuration * ChapterConst.ShipMoveTailLength * var_160_0
		local var_160_3 = 0.1 * var_160_0
		local var_160_4 = 0

		table.insert(arg_158_3, 1, arg_158_1:GetLine())
		_.each(arg_158_3, function(arg_161_0)
			local var_161_0 = var_158_0:getChapterCell(arg_161_0.row, arg_161_0.column)

			if ChapterConst.NeedEasePathCell(var_161_0) then
				local var_161_1 = ChapterCell.Line2QuadName(var_161_0.row, var_161_0.column)
				local var_161_2 = self.quadRoot:Find(var_161_1)

				self:cancelQuadTween(var_161_1, var_161_2)
				LeanTween.alpha(var_161_2, 1, var_160_1):setDelay(var_160_4)

				var_160_4 = var_160_4 + var_160_3
			end

			return
		end)
		_.each(arg_158_2, function(arg_162_0)
			self:moveStep(arg_158_1, arg_162_0, arg_158_3[#arg_158_3], function()
				local var_163_0 = arg_158_1:GetLine()
				local var_163_1 = var_158_0:getChapterCell(var_163_0.row, var_163_0.column)

				if ChapterConst.NeedEasePathCell(var_163_1) then
					LeanTween.scale(self.quadRoot:Find((ChapterCell.Line2QuadName(var_163_1.row, var_163_1.column))), Vector3.zero, var_160_2)
				end

				arg_158_4(arg_162_0)
				arg_158_1:SetLine(arg_162_0)
				arg_158_1:ResetCanvasOrder()

				return
			end, function()
				arg_158_5(arg_162_0)
				var_158_2()

				return
			end)
			coroutine.yield()

			return
		end)
		_.each(arg_158_3, function(arg_165_0)
			local var_165_0 = var_158_0:getChapterCell(arg_165_0.row, arg_165_0.column)

			if ChapterConst.NeedEasePathCell(var_165_0) then
				local var_165_1 = self.quadRoot:Find((ChapterCell.Line2QuadName(var_165_0.row, var_165_0.column)))

				LeanTween.cancel(var_165_1.gameObject)
				setImageAlpha(var_165_1, ChapterConst.CellEaseOutAlpha)

				var_165_1.localScale = Vector3.one
			end

			return
		end)

		if self.exited then
			return
		end

		if arg_158_1.GetAction then
			arg_158_1:SetAction(ChapterConst.ShipIdleAction)
		end

		arg_158_6()
		self:unfrozen()

		return
	end)

	var_158_2()

	return
end

function LevelGrid:moveStep(arg_166_1, arg_166_2, arg_166_3, arg_166_4, arg_166_5)
	local var_166_0 = self.contextData.chapterVO
	local var_166_1

	if self.contextData.chapterVO:GetQuickPlayFlag() then
		var_166_1 = ChapterConst.ShipStepQuickPlayScale or 1
	end

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

function LevelGrid:teleportSubView(arg_168_1, arg_168_2, arg_168_3, arg_168_4, arg_168_5, arg_168_6)
	local var_168_0 = self.contextData.chapterVO

	self:PlaySubAnimation(arg_168_1, true, function()
		arg_168_4(arg_168_3)
		arg_168_1:RefreshLinePosition(var_168_0, arg_168_3)
		arg_168_5(arg_168_3)
		self:PlaySubAnimation(arg_168_1, false, arg_168_6)

		return
	end)

	return
end

function LevelGrid:CellToScreen(arg_170_1, arg_170_2)
	local var_170_0 = self._tf:Find(ChapterConst.PlaneName .. "/cells")

	assert(var_170_0, "plane not exist.")

	local var_170_1 = self.contextData.chapterVO.theme:GetLinePosition(arg_170_1, arg_170_2)

	var_170_1.y = var_170_1.y * math.cos(math.pi / 180 * self.contextData.chapterVO.theme.angle)
	var_170_1.z = var_170_1.y * math.sin(math.pi / 180 * self.contextData.chapterVO.theme.angle)

	local var_170_2 = self.levelCam.transform:GetChild(0)
	local var_170_3 = self.levelCam:WorldToViewportPoint(var_170_0.position + var_170_1 * var_170_0.transform.lossyScale.x)

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

function LevelGrid:AddCellEdge(arg_171_1, arg_171_2, ...)
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

	self:CreateEdge(var_171_0, arg_171_2, ...)

	return
end

function LevelGrid:AddOutlines(arg_173_1, arg_173_2, arg_173_3, arg_173_4, arg_173_5)
	local var_173_0 = {}
	local var_173_1 = {}

	for iter_173_0, iter_173_1 in ipairs(arg_173_1) do
		for iter_173_2 = 1, 4 do
			if not underscore.any(arg_173_1, function(arg_174_0)
				return arg_174_0.row == iter_173_1.row + var_0_4[iter_173_2][1] and arg_174_0.column == iter_173_1.column + var_0_4[iter_173_2][2]
			end) then
				assert(not var_173_0[2 * iter_173_1.row + var_0_4[iter_173_2][1] .. "_" .. 2 * iter_173_1.column + var_0_4[iter_173_2][2]], "Multiple outline")

				var_173_0[2 * iter_173_1.row + var_0_4[iter_173_2][1] .. "_" .. 2 * iter_173_1.column + var_0_4[iter_173_2][2]] = {
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
				var_173_1[iter_173_1.row .. "_" .. iter_173_1.column .. "_" .. iter_173_2] = {
					row = iter_173_1.row,
					column = iter_173_1.column,
					corner = iter_173_2
				}
			end
		end
	end

	self:CreateOutlines(var_173_0, arg_173_2, arg_173_3, arg_173_4, arg_173_5)
	self:CreateOutlineCorners(var_173_1, arg_173_2, arg_173_3, arg_173_4, arg_173_5 .. "_corner")

	return
end

function LevelGrid:isHuntingRangeVisible()
	return self.contextData.huntingRangeVisibility % 2 == 0
end

function LevelGrid:toggleHuntingRange()
	self:hideQuadMark(ChapterConst.MarkHuntingRange)
	self:ClearEdges("SubmarineHunting")

	if not self:isHuntingRangeVisible() then
		self:ShowHuntingRange()
	end

	self.contextData.huntingRangeVisibility = 1 - self.contextData.huntingRangeVisibility

	self:updateAttachments()
	self:updateChampions()

	return
end

function LevelGrid:ShowHuntingRange()
	local var_180_0 = self.contextData.chapterVO
	local var_180_1 = self.contextData.chapterVO:GetSubmarineFleet()

	if not var_180_1 then
		return
	end

	self:RefreshHuntingRange(_.filter(var_180_1:getHuntingRange(), function(arg_181_0)
		local var_181_0 = var_180_0:getChapterCell(arg_181_0.row, arg_181_0.column)

		return var_181_0 and var_181_0:IsWalkable()
	end), false)

	return
end

function LevelGrid:RefreshHuntingRange(arg_182_1, arg_182_2)
	self:showQuadMark(arg_182_1, ChapterConst.MarkHuntingRange, "cell_hunting_range", Vector2(100, 100), self.material_Add, arg_182_2)
	_.each(arg_182_1, function(arg_183_0)
		self:AddCellEdge(arg_182_1, arg_183_0, not arg_182_2, nil, nil, "SubmarineHunting")

		return
	end)

	return
end

function LevelGrid:ShowStaticHuntingRange()
	self:hideQuadMark(ChapterConst.MarkHuntingRange)
	self:ClearEdges("SubmarineHunting")

	local var_184_0 = self.contextData.chapterVO

	if not self:isHuntingRangeVisible() then
		self.contextData.huntingRangeVisibility = self.contextData.huntingRangeVisibility + 1
	end

	self:RefreshHuntingRange(_.filter(self.contextData.chapterVO:GetSubmarineFleet():getHuntingRange(), function(arg_185_0)
		local var_185_0 = var_184_0:getChapterCell(arg_185_0.row, arg_185_0.column)

		return var_185_0 and var_185_0:IsWalkable()
	end), true)

	return
end

function LevelGrid:ShowTargetHuntingRange(arg_186_1)
	self:hideQuadMark(ChapterConst.MarkHuntingRange)
	self:ClearEdges("SubmarineHunting")

	local var_186_0 = self.contextData.chapterVO
	local var_186_1 = self.contextData.chapterVO:GetSubmarineFleet()
	local var_186_2 = _.filter(var_186_1:getHuntingRange(arg_186_1), function(arg_187_0)
		local var_187_0 = var_186_0:getChapterCell(arg_187_0.row, arg_187_0.column)

		return var_187_0 and var_187_0:IsWalkable()
	end)
	local var_186_3 = {}

	for iter_186_0, iter_186_1 in pairs((_.filter(var_186_1:getHuntingRange(), function(arg_188_0)
		local var_188_0 = var_186_0:getChapterCell(arg_188_0.row, arg_188_0.column)

		return var_188_0 and var_188_0:IsWalkable()
	end))) do
		if not table.containsData(var_186_2, iter_186_1) then
			table.insert(var_186_3, iter_186_1)
		end
	end

	self:RefreshHuntingRange(var_186_3, true)
	self:RefreshHuntingRange(var_186_2, false)
	self:updateAttachments()
	self:updateChampions()

	return
end

function LevelGrid:OnChangeSubAutoAttack()
	local var_189_0 = self.contextData.chapterVO
	local var_189_1 = self.contextData.chapterVO:GetSubmarineFleet()

	if not var_189_1 then
		return
	end

	local var_189_2 = self.cellFleets[var_189_1.id]

	if not self.cellFleets[var_189_1.id] then
		return
	end

	local var_189_3 = var_189_0.subAutoAttack == 1

	var_189_2:SetActiveModel(not (var_189_0.subAutoAttack == 1))
	self:PlaySubAnimation(var_189_2, not var_189_3, function()
		self:updateFleet(var_189_1.id)

		return
	end)

	return
end

function LevelGrid:displayEscapeGrid()
	if not self.contextData.chapterVO:existOni() then
		return
	end

	local var_191_0 = self.contextData.chapterVO:getOniChapterInfo()

	self:hideQuadMark(ChapterConst.MarkEscapeGrid)
	self:showQuadMark(_.map(var_191_0.escape_grids, function(arg_192_0)
		return {
			row = arg_192_0[1],
			column = arg_192_0[2]
		}
	end), ChapterConst.MarkEscapeGrid, "cell_escape_grid", Vector2(105, 105))

	return
end

function LevelGrid:showQuadMark(arg_193_1, arg_193_2, arg_193_3, arg_193_4, arg_193_5, arg_193_6)
	self:ShowAnyQuadMark(arg_193_1, arg_193_2, arg_193_3, arg_193_4, arg_193_5, false, arg_193_6)

	return
end

function LevelGrid:ShowTopQuadMark(arg_194_1, arg_194_2, arg_194_3, arg_194_4, arg_194_5, arg_194_6)
	self:ShowAnyQuadMark(arg_194_1, arg_194_2, arg_194_3, arg_194_4, arg_194_5, true, arg_194_6)

	return
end

function LevelGrid:ShowAnyQuadMark(arg_195_1, arg_195_2, arg_195_3, arg_195_4, arg_195_5, arg_195_6, arg_195_7)
	local var_195_0 = self.contextData.chapterVO

	for iter_195_0, iter_195_1 in pairs(arg_195_1) do
		local var_195_1 = var_195_0:getChapterCell(iter_195_1.row, iter_195_1.column)

		if var_195_1 and var_195_1:IsWalkable() then
			local var_195_2 = ChapterCell.Line2MarkName(iter_195_1.row, iter_195_1.column, arg_195_2)

			self.markQuads[arg_195_2] = self.markQuads[arg_195_2] or {}

			local var_195_3 = self.markQuads[arg_195_2][var_195_2]

			if not self.markQuads[arg_195_2][var_195_2] then
				PoolMgr.GetInstance():GetPrefab("chapter/cell_quad_mark", "", false, function(arg_196_0)
					var_195_3 = arg_196_0.transform
					self.markQuads[arg_195_2][var_195_2] = var_195_3

					return
				end)
			else
				self:cancelMarkTween(var_195_2, var_195_3, 1)
			end

			var_195_3.name = var_195_2

			var_195_3:SetParent((arg_195_6 or nil) and (self.topMarkRoot or self.bottomMarkRoot), false)

			var_195_3.sizeDelta = var_195_0.theme.cellSize
			var_195_3.anchoredPosition = var_195_0.theme:GetLinePosition(iter_195_1.row, iter_195_1.column)
			var_195_3.localScale = Vector3.one

			var_195_3:SetAsLastSibling()

			local var_195_4 = var_195_3:GetComponent(typeof(Image))

			var_195_4.sprite = GetSpriteFromAtlas("chapter/pic/cellgrid", arg_195_3)
			var_195_4.material = arg_195_5
			var_195_3.sizeDelta = arg_195_4

			if not arg_195_7 then
				self:startMarkTween(var_195_2, var_195_3)
			else
				self:cancelMarkTween(var_195_2, var_195_3, 1)
			end
		end
	end

	return
end

function LevelGrid:hideQuadMark(arg_197_1)
	if arg_197_1 and not self.markQuads[arg_197_1] then
		return
	end

	for iter_197_0, iter_197_1 in pairs(self.markQuads) do
		if not arg_197_1 or iter_197_0 == arg_197_1 then
			for iter_197_2, iter_197_3 in pairs(iter_197_1) do
				self:cancelMarkTween(iter_197_2, iter_197_3)

				iter_197_1[iter_197_2]:GetComponent(typeof(Image)).material = nil
				iter_197_1[iter_197_2] = nil

				PoolMgr.GetInstance():ReturnPrefab("chapter/cell_quad_mark", "", iter_197_3.gameObject)
			end

			table.clear(self.markQuads[iter_197_0])
		end
	end

	return
end

function LevelGrid:CreateEdgeIndex(arg_198_1, arg_198_2, arg_198_3)
	return ChapterCell.Line2Name(self, arg_198_1) .. ((arg_198_3 or nil) and ("_" .. arg_198_3 or "")) .. "_" .. arg_198_2
end

function LevelGrid:CreateEdge(arg_199_1, arg_199_2, arg_199_3, arg_199_4, arg_199_5, arg_199_6)
	if arg_199_1 <= 0 or arg_199_1 >= 16 then
		return
	end

	local var_199_0 = self:GetEdgePool(arg_199_6)
	local var_199_1 = self.contextData.chapterVO.theme:GetLinePosition(arg_199_2.row, arg_199_2.column)
	local var_199_2 = self.contextData.chapterVO.theme.cellSize

	assert(arg_199_6, "Missing key, Please PM Programmer")

	local var_199_3 = 0

	while var_199_3 < 4 do
		var_199_3 = var_199_3 + 1

		if bit.band(arg_199_1, 1) > 0 then
			local var_199_4 = self.CreateEdgeIndex(arg_199_2.row, arg_199_2.column, var_199_3, arg_199_6)

			self.cellEdges[arg_199_6] = self.cellEdges[arg_199_6] or {}
			self.cellEdges[arg_199_6][var_199_4] = self.cellEdges[arg_199_6][var_199_4] or tf(var_199_0:Dequeue())

			local var_199_5 = self.cellEdges[arg_199_6][var_199_4]

			var_199_5.name = var_199_4

			var_199_5:SetParent(self.bottomMarkRoot, false)

			arg_199_4 = arg_199_4 or 0
			arg_199_5 = arg_199_5 or 3

			local var_199_6

			if bit.band(var_199_3, 1) == 1 then
				var_199_6 = var_199_2.x - arg_199_4 * 2

				if not (var_199_2.x - arg_199_4 * 2) then
					-- block empty
				end
			end

			var_199_5.sizeDelta = Vector2.New(var_199_6, arg_199_5)
			var_199_5.pivot = Vector2.New(0.5, 0)
			var_199_5.anchoredPosition = Vector2.New(math.cos(math.pi * 0.5 * -var_199_3) * (var_199_2.x * 0.5 - arg_199_4) + var_199_1.x, math.sin(math.pi * 0.5 * -var_199_3) * (var_199_2.y * 0.5 - arg_199_4) + var_199_1.y)
			var_199_5.localRotation = Quaternion.Euler(0, 0, (5 - var_199_3) * 90)

			if arg_199_3 then
				self:startMarkTween(var_199_4, var_199_5)
			else
				self:cancelMarkTween(var_199_4, var_199_5, 1)
			end
		end
	end

	return
end

function LevelGrid:ClearEdge(arg_200_1)
	for iter_200_0, iter_200_1 in pairs(self.cellEdges) do
		for iter_200_2 = 1, 4 do
			local var_200_0 = self.CreateEdgeIndex(arg_200_1.row, arg_200_1.column, iter_200_2, iter_200_0)

			if iter_200_1[var_200_0] then
				local var_200_1 = self:GetEdgePool(iter_200_0)
				local var_200_2 = tf(iter_200_1[var_200_0])

				self:cancelMarkTween(var_200_0, var_200_2)
				var_200_1:Enqueue(var_200_2, false)

				iter_200_1[var_200_0] = nil
			end
		end
	end

	return
end

function LevelGrid:ClearEdges(arg_201_1)
	if not next(self.cellEdges) then
		return
	end

	for iter_201_0, iter_201_1 in pairs(self.cellEdges) do
		if not arg_201_1 or arg_201_1 == iter_201_0 then
			local var_201_0 = self:GetEdgePool(iter_201_0)

			for iter_201_2, iter_201_3 in pairs(iter_201_1) do
				self:cancelMarkTween(iter_201_2, iter_201_3)
				var_201_0:Enqueue(go(iter_201_3), false)
			end

			self.cellEdges[iter_201_0] = nil
		end
	end

	return
end

function LevelGrid:CreateOutlines(arg_202_1, arg_202_2, arg_202_3, arg_202_4, arg_202_5)
	local var_202_0 = self.contextData.chapterVO.theme.cellSize + self.contextData.chapterVO.theme.cellSpace

	for iter_202_0, iter_202_1 in pairs(arg_202_1) do
		local var_202_1 = self:GetEdgePool(arg_202_5)
		local var_202_2 = self.contextData.chapterVO.theme:GetLinePosition(iter_202_1.row / 2, iter_202_1.column / 2)

		assert(arg_202_5, "Missing key, Please PM Programmer")

		local var_202_3 = self.CreateEdgeIndex(iter_202_1.row, iter_202_1.column, 0, arg_202_5)

		self.cellEdges[arg_202_5] = self.cellEdges[arg_202_5] or {}
		self.cellEdges[arg_202_5][var_202_3] = self.cellEdges[arg_202_5][var_202_3] or tf(var_202_1:Dequeue())

		local var_202_4 = self.cellEdges[arg_202_5][var_202_3]

		var_202_4.name = var_202_3

		var_202_4:SetParent(self.bottomMarkRoot, false)

		arg_202_3 = arg_202_3 or 0
		arg_202_4 = arg_202_4 or 3

		local var_202_5

		if var_0_4[iter_202_1.normal][1] ~= 0 then
			var_202_5 = var_202_0.x or var_202_0.y
		end

		local var_202_6 = var_202_5 * 0.5
		local var_202_7 = {
			iter_202_1.row + var_0_4[iter_202_1.normal % 4 + 1][1],
			iter_202_1.column + var_0_4[iter_202_1.normal % 4 + 1][2]
		}
		local var_202_8 = arg_202_1[var_202_7[1] + var_0_4[iter_202_1.normal][1] .. "_" .. var_202_7[2] + var_0_4[iter_202_1.normal][2]] or arg_202_1[var_202_7[1] - var_0_4[iter_202_1.normal][1] .. "_" .. var_202_7[2] - var_0_4[iter_202_1.normal][2]]
		local var_202_9 = {
			iter_202_1.row + var_0_4[(iter_202_1.normal + 2) % 4 + 1][1],
			iter_202_1.column + var_0_4[(iter_202_1.normal + 2) % 4 + 1][2]
		}
		local var_202_10 = arg_202_1[var_202_9[1] + var_0_4[iter_202_1.normal][1] .. "_" .. var_202_9[2] + var_0_4[iter_202_1.normal][2]] or arg_202_1[var_202_9[1] - var_0_4[iter_202_1.normal][1] .. "_" .. var_202_9[2] - var_0_4[iter_202_1.normal][2]]

		if var_202_8 then
			var_202_5 = (iter_202_1.row + var_0_4[iter_202_1.normal][1] == var_202_8.row + var_0_4[var_202_8.normal][1] or iter_202_1.column + var_0_4[iter_202_1.normal][2] == var_202_8.column + var_0_4[var_202_8.normal][2]) and var_202_5 + arg_202_3 or var_202_5 - arg_202_3
			var_202_6 = (iter_202_1.row + var_0_4[iter_202_1.normal][1] == var_202_8.row + var_0_4[var_202_8.normal][1] or iter_202_1.column + var_0_4[iter_202_1.normal][2] == var_202_8.column + var_0_4[var_202_8.normal][2]) and var_202_6 + arg_202_3 or var_202_6 - arg_202_3
		end

		if var_202_10 then
			var_202_5 = (iter_202_1.row + var_0_4[iter_202_1.normal][1] == var_202_10.row + var_0_4[var_202_10.normal][1] or iter_202_1.column + var_0_4[iter_202_1.normal][2] == var_202_10.column + var_0_4[var_202_10.normal][2]) and var_202_5 + arg_202_3 or var_202_5 - arg_202_3
		end

		var_202_4.sizeDelta = Vector2.New(var_202_5, arg_202_4)
		var_202_4.pivot = Vector2.New(var_202_6 / var_202_5, 0)
		var_202_4.anchoredPosition = Vector2.New(var_0_4[iter_202_1.normal][2] * -arg_202_3 + var_202_2.x, var_0_4[iter_202_1.normal][1] * arg_202_3 + var_202_2.y)
		var_202_4.localRotation = Quaternion.Euler(0, 0, (5 - iter_202_1.normal) * 90)

		if arg_202_2 then
			self:startMarkTween(var_202_3, var_202_4)
		else
			self:cancelMarkTween(var_202_3, var_202_4, 1)
		end
	end

	return
end

function LevelGrid:CreateOutlineCorners(arg_203_1, arg_203_2, arg_203_3, arg_203_4, arg_203_5)
	for iter_203_0, iter_203_1 in pairs(arg_203_1) do
		local var_203_0 = self:GetEdgePool(arg_203_5)
		local var_203_1 = self.contextData.chapterVO.theme:GetLinePosition(iter_203_1.row + var_0_5[iter_203_1.corner][1] * 0.5, iter_203_1.column + var_0_5[iter_203_1.corner][2] * 0.5)

		assert(arg_203_5, "Missing key, Please PM Programmer")

		local var_203_2 = self.CreateEdgeIndex(iter_203_1.row, iter_203_1.column, iter_203_1.corner, arg_203_5)

		self.cellEdges[arg_203_5] = self.cellEdges[arg_203_5] or {}
		self.cellEdges[arg_203_5][var_203_2] = self.cellEdges[arg_203_5][var_203_2] or tf(var_203_0:Dequeue())
		self.cellEdges[arg_203_5][var_203_2].name = var_203_2

		self.cellEdges[arg_203_5][var_203_2]:SetParent(self.bottomMarkRoot, false)

		arg_203_3 = arg_203_3 or 0
		arg_203_4 = arg_203_4 or 3
		self.cellEdges[arg_203_5][var_203_2].sizeDelta = Vector2.New(arg_203_4, arg_203_4)
		self.cellEdges[arg_203_5][var_203_2].pivot = Vector2.New(1, 0)
		self.cellEdges[arg_203_5][var_203_2].anchoredPosition = Vector2.New(var_0_5[iter_203_1.corner][2] * -arg_203_3 + var_203_1.x, var_0_5[iter_203_1.corner][1] * arg_203_3 + var_203_1.y)
		self.cellEdges[arg_203_5][var_203_2].localRotation = Quaternion.Euler(0, 0, (5 - iter_203_1.corner) * 90)

		if arg_203_2 then
			self:startMarkTween(var_203_2, self.cellEdges[arg_203_5][var_203_2])
		else
			self:cancelMarkTween(var_203_2, self.cellEdges[arg_203_5][var_203_2], 1)
		end
	end

	return
end

function LevelGrid:updateCoastalGunAttachArea()
	self:hideQuadMark(ChapterConst.MarkCoastalGun)
	self:showQuadMark(self.contextData.chapterVO:getCoastalGunArea(), ChapterConst.MarkCoastalGun, "cell_coastal_gun", Vector2(110, 110), nil, false)

	return
end

function LevelGrid:InitIdolsAnim()
	if not pg.chapter_pop_template[self.contextData.chapterVO.id] then
		return
	end

	for iter_205_0, iter_205_1 in ipairs(pg.chapter_pop_template[self.contextData.chapterVO.id].sd_location) do
		self.idols = self.idols or {}

		local var_205_0 = self.cellRoot:Find(ChapterCell.Line2Name(iter_205_1[1][1], iter_205_1[1][2]) .. "/" .. ChapterConst.ChildAttachment)

		assert(var_205_0, "cant find attachment")

		local var_205_1 = AttachmentSpineAnimationCell.New(var_205_0)

		var_205_1:SetLine({
			row = iter_205_1[1][1],
			column = iter_205_1[1][2]
		})
		table.insert(self.idols, var_205_1)
		var_205_1:Set(iter_205_1[2])
		var_205_1:SetRoutine(pg.chapter_pop_template[self.contextData.chapterVO.id].sd_act[iter_205_0])
	end

	return
end

function LevelGrid:ClearIdolsAnim()
	if self.idols then
		for iter_206_0, iter_206_1 in ipairs(self.idols) do
			iter_206_1:Clear()
		end

		table.clear(self.idols)

		self.idols = nil
	end

	return
end

function LevelGrid:GetEnemyCellView(arg_207_1)
	return _.detect(self.cellChampions, function(arg_208_0)
		local var_208_0 = arg_208_0:GetLine()

		return var_208_0.row == arg_207_1.row and var_208_0.column == arg_207_1.column
	end) or self.attachmentCells[ChapterCell.Line2Name(arg_207_1.row, arg_207_1.column)]
end

function LevelGrid:TransformLine2PlanePos(arg_209_1)
	return string.char(string.byte("A") + arg_209_1.column - self.indexMin.y) .. string.char(string.byte("1") + arg_209_1.row - self.indexMin.x)
end

function LevelGrid:AlignListContainer(arg_210_1)
	for iter_210_0 = arg_210_1, self.childCount - 1 do
		setActive(self:GetChild(iter_210_0), false)
	end

	for iter_210_1 = self.childCount, arg_210_1 - 1 do
		cloneTplTo(self:GetChild(0), self)
	end

	for iter_210_2 = 0, arg_210_1 - 1 do
		setActive(self:GetChild(iter_210_2), true)
	end

	return
end

function LevelGrid:frozen()
	self.forzenCount = (self.forzenCount or 0) + 1

	self.parent:frozen()

	return
end

function LevelGrid:unfrozen()
	if self.exited then
		return
	end

	self.forzenCount = (self.forzenCount or 0) - 1

	self.parent:unfrozen()

	return
end

function LevelGrid:isfrozen()
	return self.parent.frozenCount > 0
end

function LevelGrid:clear()
	self:clearAll()

	if (self.forzenCount or 0) > 0 then
		self.parent:unfrozen(self.forzenCount)
	end

	return
end

return LevelGrid
