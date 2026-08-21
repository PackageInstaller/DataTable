-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/EliminateGame\\EliminateModelCenter.lua

local ResHero = require("ClientData/ResHero")
local ResClimbTowerLevel = require("ClientData/ResClimbTowerLevel")
local ResRearHouse = require("ClientData/ResRearHouse")
local ResColor = require("ClientData/ResColor")
local ResItem = require("ClientData/ResItem")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResEliminateScene = require("ClientData/ResEliminateScene")
local ResEliminate = require("ClientData/ResEliminate")
local ResMinigameSort = require("EliminateGame/ResMinigameSort")
local ResEliminateItem = require("ClientData/ResEliminateItem")
local EliminateModelCenter = {}
local self = EliminateModelCenter

function EliminateModelCenter.init(dragCenter)
	self.dragCenter = dragCenter

	self.initModelData()

	self.columns = Const.MINIGAME_COLUMN
end

function EliminateModelCenter.initModelData(...)
	if self.allModelData == nil then
		self.createAllModelData()
	end
end

function EliminateModelCenter.setCurSceneData()
	self.chapter, self.stage = CurAvatar:getChapterAndStage(Const.MINI_GAME_TYPE_ELIMINATE)
	self.curLevel = ResClimbTowerLevel[self.chapter][self.stage].id
	self.sceneId = ResEliminate[self.curLevel].scene_id or 1
	self.shelfNum = ResEliminate[self.curLevel].shelf_num or 2
	self.wallNode = ResEliminateScene[self.sceneId].wall_node or 1
	self.shelfModelId = ResEliminateScene[self.sceneId].shelf_model_id
	self.heroOffsetY = ResEliminateScene[self.sceneId].hero_offset_y or 0
	self.heroScale = ResEliminateScene[self.sceneId].hero_scale or 1
	self.shelfSize = ResEliminateScene[self.sceneId].shelf_size or 1
	self.shelfFinishCueId = ResEliminateScene[self.sceneId].shelf_finish_cue_id
end

function EliminateModelCenter.getShelfNum()
	return self.shelfNum
end

function EliminateModelCenter.getShelfSize()
	return self.shelfSize
end

function EliminateModelCenter.getShelfFinishCueId()
	return self.shelfFinishCueId
end

function EliminateModelCenter.getHeroOffsetY()
	return self.heroOffsetY
end

function EliminateModelCenter.getWallNode()
	return self.wallNode
end

function EliminateModelCenter.getPreAndEndAvgId()
	return ResEliminate[self.curLevel].enter_avg_id, ResEliminate[self.curLevel].result_avg_id
end

function EliminateModelCenter.createAllModelData(...)
	self.EliminateData = {}

	for mid, data in pairs(ResRearHouse) do
		self.EliminateData[data.type_id] = self.EliminateData[data.type_id] or {}
		self.EliminateData[data.type_id][data.model_id] = data
	end

	self.allModelData = {}

	for mid, data in pairs(ResRearHouse) do
		local info = self.createData(data.type_id, data.model_id)

		self.allModelData[data.model_id] = info
	end
end

function EliminateModelCenter.createData(typeId, modelId)
	local data = {}

	data.count = 0
	data.totalCount = 0

	local modelData = {}
	local resData = self.EliminateData[typeId]

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

function EliminateModelCenter.parseHelp(list, data)
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

function EliminateModelCenter.parseInfo(modelData)
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

function EliminateModelCenter.dataReady(houseData)
	self.setCurSceneData()
end

function EliminateModelCenter.initWall()
	self.delAllObj(true, true)
end

function EliminateModelCenter.resetLoad(func)
	self.dragCenter.zones[self.dragCenter.getCurWallName()]:resetLoad(func)
end

function EliminateModelCenter._getModelInfo(typeId, modelId)
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

function EliminateModelCenter.createLayerModel(data)
	local layerModelData = {}
	local wallName = self.dragCenter.getZoneName(1)
	local shelf = data.shelfData

	if shelf and shelf.modelId ~= 0 then
		local initData = shelf

		initData.zone = wallName

		local modelId = shelf.modelId

		table.insert(layerModelData, self.getData(modelId, initData))
	end

	for i, hero in ipairs(data.heroData or {}) do
		if hero and hero.modelId ~= 0 then
			local initData = hero

			initData.zone = wallName

			local modelId = hero.modelId

			table.insert(layerModelData, self.getData(modelId, initData))
		end
	end

	for i, itemModel in ipairs(data.itemModelData or {}) do
		if itemModel and itemModel.modelId ~= 0 then
			local initData = itemModel

			initData.zone = wallName

			local modelId = itemModel.modelId

			table.insert(layerModelData, self.getData(modelId, initData))
		end
	end

	self.checkObj(layerModelData)
end

function EliminateModelCenter.createWhenLoadend(...)
	self.setCurSceneData()

	local function func(...)
		local showData = self.getInitShowData()

		for _, layerData in ipairs(showData or {}) do
			self.createLayerModel(layerData)
		end
	end

	self.resetLoad(func)
end

function EliminateModelCenter.getInitShowData(...)
	if not ResEliminate[self.curLevel] then
		return
	end

	local resData = ResEliminate[self.curLevel].shelf
	local layerData = {}

	for i = 1, #resData do
		local data = {}
		local shelfData = {}

		shelfData.modelId = self.shelfModelId
		shelfData.shelfIndex = i
		shelfData.typeId = Const.REARHOUSE_TYPE_SHELF
		data.shelfData = shelfData

		local heroData = {}
		local itemModelData = {}
		local models = resData[i].model
		local status = resData[i].status
		local args = resData[i].args

		Const.ELIMINATE_PUT_NUM_MAX = #models

		for j = 1, #models do
			if models[j] ~= 0 then
				local hero = {}

				hero.angleY = 0

				local modelId = models[j]

				hero.modelId = modelId
				hero.shelfIndex = i
				hero.posIndex = j
				hero.status = status[j]
				hero.statusArg = args[j]
				hero.typeId = Const.REARHOUSE_TYPE_HERO
				hero.offsetY = self.heroOffsetY
				hero.scale = self.heroScale

				table.insert(heroData, hero)

				local itemModel = self.getItemModelData(status[j], args[j], i, j)

				if itemModel then
					table.insert(itemModelData, itemModel)
				end
			end
		end

		data.heroData = heroData
		data.itemModelData = itemModelData

		table.insert(layerData, data)
	end

	return layerData
end

function EliminateModelCenter.getItemModelData(status, statusArg, shelfIndex, posIndex)
	local resItemData

	if status ~= Const.ELIMINATE_STATUS_TYPE_NONE then
		local index = statusArg

		if status == Const.ELIMINATE_STATUS_TYPE_BOOM then
			index = 1
		end

		resItemData = ResEliminateItem[status][index]
	end

	if resItemData then
		local item = {}

		item.angleY = 0

		local modelId = resItemData.model_id

		item.modelId = modelId
		item.shelfIndex = shelfIndex
		item.posIndex = posIndex
		item.typeId = Const.REARHOUSE_TYPE_PARTS
		item.resData = resItemData
		item.status = status
		item.statusArg = statusArg

		return item
	end

	return nil
end

function EliminateModelCenter.checkObj(tempData)
	local tempObjs = {}

	for index, _data in ipairs(tempData) do
		local typeId = _data.typeId
		local modelId = _data.modelId
		local data = self._getModelInfo(typeId, modelId)
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

function EliminateModelCenter.addObjFinal(data)
	if #data > 0 then
		local zoneName = data[1].initData.zone

		if zoneName == nil then
			zoneName = self.dragCenter.getCurWallName()
		end

		self.dragCenter.zones[zoneName]:addObj(data)
	end
end

function EliminateModelCenter.getData(modelId, initData)
	local typeId = self.getTypeId(modelId)

	return {
		typeId = typeId,
		modelId = modelId,
		initData = initData
	}
end

function EliminateModelCenter.getTypeId(modelId)
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

function EliminateModelCenter.delAllObj(isForceAll, isIncludeStage)
	local zone = self.dragCenter.getCurZone()

	if zone then
		zone:delAllObj(isForceAll, isIncludeStage)
	end
end

function EliminateModelCenter.destroy(...)
	self.dragCenter = nil
end

return EliminateModelCenter
