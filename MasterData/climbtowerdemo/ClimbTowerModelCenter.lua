-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClimbTowerDemo\\ClimbTowerModelCenter.lua

local ResHero = require("ClientData/ResHero")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResRearHouse = require("ClientData/ResRearHouse")
local ResColor = require("ClientData/ResColor")
local ResItem = require("ClientData/ResItem")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResMinigameTower = require("ClimbTowerDemo/ResMinigameTower")
local ResClimbTowerScene = require("ClientData/ResClimbTowerScene")
local ResClimbTowerPart = require("ClientData/ResClimbTowerPart")
local ResClimbTower = require("ClientData/ResClimbTower")
local ResClimbTowerLevel = require("ClientData/ResClimbTowerLevel")
local ClimbTowerModelCenter = {}
local self = ClimbTowerModelCenter
local DEFAULT_MY_HERO_MODEL_ID = 11101
local MY_TOWER_INIT_LAYER = 2

function ClimbTowerModelCenter.init(dragCenter)
	self.dragCenter = dragCenter

	self.initModelData()

	self.columns = Const.MINIGAME_COLUMN
end

function ClimbTowerModelCenter.initModelData(...)
	if self.allModelData == nil then
		self.createAllModelData()
	end
end

function ClimbTowerModelCenter.createAllModelData(...)
	self.climbTowerData = {}

	for mid, data in pairs(ResRearHouse) do
		self.climbTowerData[data.type_id] = self.climbTowerData[data.type_id] or {}
		self.climbTowerData[data.type_id][data.model_id] = data
	end

	self.allModelData = {}

	for mid, data in pairs(ResRearHouse) do
		local info = self.createData(data.type_id, data.model_id)

		self.allModelData[data.model_id] = info
	end
end

function ClimbTowerModelCenter.createData(typeId, modelId)
	local data = {}

	data.count = 0
	data.totalCount = 0

	local modelData = {}
	local resData = self.climbTowerData[typeId]

	data.typeId = typeId
	data.modelId = modelId
	modelData.baseInfo = resData[modelId] or resData[11101]
	modelData.name = modelData.baseInfo.model_name

	if ResItem[modelId] and ResItem[modelId].name then
		modelData.name = ResItem[modelId].name
	end

	modelData.typeInfo = ResRearHouseLayer[typeId]
	data.modelData = modelData

	self.parseInfo(modelData)

	return data
end

function ClimbTowerModelCenter.parseHelp(list, data)
	if data and data ~= "" then
		for _, d in ipairs(data) do
			if d ~= "" then
				local t = utils.splitString(d, ",")
				local r = Vector2(tonumber(t[1]), tonumber(t[2]))

				table.insert(list, r)
			end
		end
	end
end

function ClimbTowerModelCenter.parseInfo(modelData)
	local rangeData = {}
	local posData = {}

	modelData.configPosOffset = Vector2.zero

	local _posOffset = modelData.baseInfo.pos_offset

	if _posOffset then
		modelData.configPosOffset = Vector2(_posOffset[1] or 0, _posOffset[2] or 0)
	end

	local range = modelData.baseInfo.range_info
	local _data = utils.splitString(range, "|")
	local data = utils.splitString(_data[1], ";")

	self.parseHelp(rangeData, data)

	local avalibleNum = #rangeData

	if _data[2] ~= nil then
		data = utils.splitString(_data[2], ";")

		self.parseHelp(rangeData, data)
	end

	local pos = modelData.baseInfo.pos_info
	local data = utils.splitString(pos, ";")

	self.parseHelp(posData, data)

	modelData.rangeData = rangeData
	modelData.posData = posData
	modelData.avalibleNum = avalibleNum

	local boundsInfo = {}

	boundsInfo.left = 0
	boundsInfo.right = 0
	boundsInfo.down = 0

	if #rangeData == #posData then
		if true or modelData.baseInfo.type_id == 8 then
			for i, range in ipairs(rangeData) do
				boundsInfo.right = math.max(boundsInfo.right, posData[i].x + range.x)
				boundsInfo.down = math.max(boundsInfo.down, posData[i].y + range.y)
			end
		else
			boundsInfo.right = rangeData[1].x
			boundsInfo.down = rangeData[1].y
		end

		modelData.boundsInfo = boundsInfo
	end
end

function ClimbTowerModelCenter.dataReady()
	self.setCurSceneData()
end

function ClimbTowerModelCenter.initWall()
	self.delAllObj(true, true)
end

function ClimbTowerModelCenter.posToRowCol(pos)
	if pos == nil then
		return
	end

	if self.bounds == nil then
		self.bounds = self.dragCenter.bounds
	end

	local x = self.bounds.edit.leftUpPos.x - pos[1]
	local y = self.bounds.edit.leftUpPos.y - pos[2]
	local rowIdx = math.ceil(y / Const.MINIGAME_GRID_SIZE)
	local columnIdx = math.ceil(x / Const.MINIGAME_GRID_SIZE)

	return rowIdx, columnIdx
end

function ClimbTowerModelCenter.setCurSceneData()
	self.chapter, self.stage = CurAvatar:getChapterAndStage(Const.MINI_GAME_TYPE_CLIMB_TOWER)
	self.curLevel = ResClimbTowerLevel[self.chapter][self.stage].id

	if ResClimbTower[self.curLevel] then
		self.sceneId = ResClimbTower[self.curLevel].scene_id or 1
		self.towerId = ResClimbTowerScene[self.sceneId].tower_id
		self.towerPos = ResClimbTowerScene[self.sceneId].tower_pos
		self.towerPartData = ResClimbTowerPart[self.sceneId]
		self.towerSpace = ResClimbTowerScene[self.sceneId].tower_space
		self.towerHeight = ResClimbTowerScene[self.sceneId].tower_height or 7
		self.wallNode = ResClimbTowerScene[self.sceneId].wall_node
		self.cameraMoveSpace = ResClimbTowerScene[self.sceneId].camera_move_space
		self.rowOffset = ResClimbTowerScene[self.sceneId].hero_row_offset or 1
		self.colOffset = ResClimbTowerScene[self.sceneId].hero_col_offset or 1
		self.heroScale = ResClimbTowerScene[self.sceneId].hero_scale or 1.5
	end
end

function ClimbTowerModelCenter.getHeroRowAndColOffSet()
	return self.rowOffset, self.colOffset
end

function ClimbTowerModelCenter.getTowerHeight()
	return self.towerHeight
end

function ClimbTowerModelCenter.getWallNode()
	return self.wallNode
end

function ClimbTowerModelCenter.getCameraMoveSpace()
	return self.cameraMoveSpace
end

function ClimbTowerModelCenter.getPreAndEndAvgId()
	return ResClimbTower[self.curLevel].enter_avg_id, ResClimbTower[self.curLevel].result_avg_id
end

function ClimbTowerModelCenter.resetLoad(func)
	self.dragCenter.zones[self.dragCenter.getCurWallName()]:resetLoad(func)
end

function ClimbTowerModelCenter._getModelInfo(typeId, modelId)
	local data = self.allModelData[modelId]

	if data == nil then
		data = self.createData(typeId, modelId)
		self.allModelData[modelId] = data

		if typeId == Const.REARHOUSE_TYPE_HERO then
			-- block empty
		end
	end

	return utils.copyTable(data)
end

function ClimbTowerModelCenter.createLayerModel(data)
	local layerModelData = {}
	local wallName = self.dragCenter.getZoneName(1)

	for i, dt in pairs(data.layerData or {}) do
		local initData = dt

		initData.zone = wallName

		table.insert(layerModelData, self.getData(initData.id, initData))
	end

	local hero = data.heroData

	if hero and hero.modelId ~= -1 then
		local initData = hero

		initData.zone = wallName

		local modelId = hero.modelId

		table.insert(layerModelData, self.getData(modelId, initData))
	end

	self.checkObj(layerModelData)
end

function ClimbTowerModelCenter.createWhenLoadend(...)
	self.setCurSceneData()

	local function func(...)
		local towerData = self.getInitShowData()

		for _, layerData in ipairs(towerData or {}) do
			for _, data in pairs(layerData) do
				self.createLayerModel(data)
			end
		end
	end

	self.resetLoad(func)
end

function ClimbTowerModelCenter:rowColToGridIdx(r, c)
	return (r - 1) * self.columns + c
end

function ClimbTowerModelCenter.createNewMySelfModel(initData)
	local layerModelData = {}

	if initData and initData.modelId ~= -1 and initData.modelId ~= 0 then
		local modelId = initData.modelId

		table.insert(layerModelData, self.getData(modelId, initData))
	end

	self.checkObj(layerModelData)
end

function ClimbTowerModelCenter.createMyNewLayerData(layer, towerIndex)
	local data = {}
	local layerData = {}
	local towerBody = self.getTowerPartInfo(Const.CLIMB_TOWER_TYPE_BODY, layer, towerIndex, false, true)

	table.insert(layerData, towerBody)

	data.layerData = layerData

	local heroData = self.getHeroInitData(layer, towerIndex, false, true)

	if heroData then
		data.heroData = heroData
	end

	self.createLayerModel(data)
end

function ClimbTowerModelCenter.getInitShowData(...)
	self.firstRow, self.firstCol = self.posToRowCol(self.towerPos)
	self.firstCol = self.firstCol + 15

	local resTowerLevelData = ResClimbTower[self.curLevel].tower

	if not resTowerLevelData then
		return
	end

	local initTowerIndex = 1
	local towerData = {}
	local myLayerData = {}

	for i = 1, MY_TOWER_INIT_LAYER do
		local data = {}
		local layerData = {}
		local towerBody = self.getTowerPartInfo(Const.CLIMB_TOWER_TYPE_BODY, i, initTowerIndex, true, true)

		table.insert(layerData, towerBody)

		if i == 1 then
			local towerTop = self.getTowerPartInfo(Const.CLIMB_TOWER_TYPE_TOP, i, initTowerIndex, true, true)

			table.insert(layerData, towerTop)
		elseif i == MY_TOWER_INIT_LAYER then
			local towerBase = self.getTowerPartInfo(Const.CLIMB_TOWER_TYPE_BASE, i, initTowerIndex, true, true)

			table.insert(layerData, towerBase)
		end

		data.layerData = layerData

		local heroData = self.getHeroInitData(i, initTowerIndex, true, true)

		if heroData then
			data.heroData = heroData
		end

		table.insert(myLayerData, data)
	end

	towerData[initTowerIndex] = myLayerData

	for index = 2, #resTowerLevelData do
		local resTowerIndexData = resTowerLevelData[index]
		local enemyLayerData = {}
		local modelEnemyIds = {}

		for _, id in ipairs(resTowerIndexData.model_enemy) do
			if id ~= 0 then
				table.insert(modelEnemyIds, id)
			end
		end

		for i = 1, #modelEnemyIds do
			if modelEnemyIds ~= 0 then
				local data = {}
				local layerData = {}
				local towerBody = self.getTowerPartInfo(Const.CLIMB_TOWER_TYPE_BODY, i, index, true, false)

				table.insert(layerData, towerBody)

				if i == #modelEnemyIds then
					local towerTop = self.getTowerPartInfo(Const.CLIMB_TOWER_TYPE_TOP, i, index, true, false)

					table.insert(layerData, towerTop)
				elseif i == 1 then
					local towerBase = self.getTowerPartInfo(Const.CLIMB_TOWER_TYPE_BASE, i, index, true, false)

					table.insert(layerData, towerBase)
				end

				data.layerData = layerData

				local heroData = self.getHeroInitData(i, index, true, false)

				if heroData then
					data.heroData = heroData
				end

				table.insert(enemyLayerData, data)
			end
		end

		towerData[index] = enemyLayerData
	end

	return towerData
end

function ClimbTowerModelCenter.getTowerPartInfo(partType, layerIndex, towerIndex, isInit, isSelf)
	local towerPart = {}

	towerPart.id = self.towerPartData[partType].rh_model_id

	local row = self.firstRow

	if isInit then
		if isSelf then
			row = self.firstRow - (2 - layerIndex) * self.towerHeight
		else
			row = self.firstRow - (layerIndex - 1) * self.towerHeight
		end

		if partType == Const.CLIMB_TOWER_TYPE_TOP then
			row = row - self.towerHeight
		elseif partType == Const.CLIMB_TOWER_TYPE_BASE then
			row = self.firstRow + self.rowOffset
		end
	end

	local col = self.firstCol + self.towerSpace * (towerIndex - 1)
	local gridIdx = self:rowColToGridIdx(row, col)

	towerPart.pos = gridIdx
	towerPart.layer = layerIndex
	towerPart.towerIndex = towerIndex
	towerPart.typeId = Const.REARHOUSE_TYPE_SHELF
	towerPart.partType = partType
	towerPart.resData = self.towerPartData[partType]

	return towerPart
end

function ClimbTowerModelCenter.getHeroInitData(layerIndex, towerIndex, isInit, isSelf)
	local resTowerLevelData = ResClimbTower[self.curLevel].tower

	if not resTowerLevelData then
		return
	end

	local resTowerIndexData = resTowerLevelData[towerIndex]
	local modelId, num, numType, enemyType, changeModel

	if isSelf then
		modelId = resTowerIndexData.model_self[layerIndex]

		if not modelId or modelId == -1 or modelId == 0 then
			return nil
		end

		num = resTowerIndexData.num_self[layerIndex]
		numType = resTowerIndexData.type_self[layerIndex]
		changeModel = resTowerIndexData.change_model and resTowerIndexData.change_model[layerIndex] or 0
	else
		modelId = resTowerIndexData.model_enemy[layerIndex]

		if not modelId or modelId == -1 or modelId == 0 then
			return nil
		end

		num = resTowerIndexData.num_enemy[layerIndex]
		enemyType = resTowerIndexData.type_enemy[layerIndex]
	end

	local heroData = {}

	heroData.angleY = -90

	if modelId == resTowerLevelData[1].model_self[2] or modelId == DEFAULT_MY_HERO_MODEL_ID then
		heroData.isMySelf = true
	end

	heroData.modelId = modelId
	heroData.num = num
	heroData.numType = numType
	heroData.enemyType = enemyType
	heroData.changeModel = changeModel

	local row = self.firstRow

	if isInit then
		if isSelf then
			row = self.firstRow - (2 - layerIndex) * self.towerHeight
		else
			row = self.firstRow - (layerIndex - 1) * self.towerHeight
		end
	end

	local col = self.firstCol + self.towerSpace * (towerIndex - 1) + self.colOffset

	if heroData.isMySelf then
		col = self.firstCol
	end

	local gridIdx = self:rowColToGridIdx(row, col)

	heroData.pos = gridIdx
	heroData.row = row
	heroData.col = col
	heroData.layer = layerIndex
	heroData.towerIndex = towerIndex
	heroData.typeId = Const.REARHOUSE_TYPE_HERO
	heroData.scale = self.heroScale

	return heroData
end

function ClimbTowerModelCenter.checkObj(tempData)
	local tempObjs = {}

	for index, _data in ipairs(tempData) do
		local typeId = _data.typeId
		local modelId = _data.modelId
		local data = self._getModelInfo(typeId, modelId)

		if typeId ~= Const.REARHOUSE_TYPE_SHELF and data.modelData and data.modelData.rangeData then
			local rangeData = data.modelData.rangeData[1]
			local row = _data.initData.row
			local col = _data.initData.col

			if _data.initData.isMySelf then
				col = col - rangeData.x / 2
			end

			local newIndex = self:rowColToGridIdx(row - rangeData.y - self.rowOffset, col)

			_data.initData.pos = newIndex
		end

		local initData = _data.initData
		local putData = {}

		putData.data = data

		table.insert(tempObjs, {
			putData = putData,
			initData = initData
		})
	end

	self.addObjFinal(tempObjs)

	return tempObjs
end

function ClimbTowerModelCenter.addObjFinal(data)
	if #data > 0 then
		local zoneName = data[1].initData.zone

		if zoneName == nil then
			zoneName = self.dragCenter.getCurWallName()
		end

		self.dragCenter.zones[zoneName]:addObj(data)
	end
end

function ClimbTowerModelCenter.getData(modelId, initData)
	local typeId = self.getTypeId(modelId)

	return {
		typeId = typeId,
		modelId = modelId,
		initData = initData
	}
end

function ClimbTowerModelCenter.getTypeId(modelId)
	for mid, data in pairs(ResRearHouse) do
		if mid == modelId then
			return data.type_id
		end
	end

	if self.allModelData[modelId] then
		return self.allModelData[modelId].typeId
	end

	return 99
end

function ClimbTowerModelCenter.delAllObj()
	local zone = self.dragCenter.getCurZone()

	if zone then
		zone:delAllObj()
	end
end

function ClimbTowerModelCenter.destroy(...)
	self.dragCenter = nil
end

return ClimbTowerModelCenter
