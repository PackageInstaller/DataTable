-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManMapMgr.lua

module("logic.extensions.beastrichman.view.BeastRichManMapMgr", package.seeall)

local BeastRichManMapMgr = class("BeastRichManMapMgr")

function BeastRichManMapMgr:ctor()
	self._cellItemMap = {}
	self._cellPathNodeMap = {}
	self._cellEventNodeMap = {}
	self._cellEventItemMap = {}
	self._cellBgNodeMap = {}
	self._pathGridMap = {}
	self._complateInstanceMap = {}
end

function BeastRichManMapMgr:initParam(activityId, zoneId, go)
	self._mapGo = go
	self._bgGo = goutil.findChild(go, "bg")
	self._bgRoot = goutil.findChild(go, "bgRoot")
	self._pathRoot = goutil.findChild(go, "pathRoot")
	self._eventBackRoot = goutil.findChild(go, "eventBackRoot")
	self._eventFrontRoot = goutil.findChild(go, "eventFrontRoot")
	self._activityId = activityId
	self._zoneId = zoneId

	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)

	self._mapRow = zoneCfg.size[1]
	self._mapColumn = zoneCfg.size[2]

	local centerRow = (self._mapRow + 1) * 0.5
	local centerCol = (self._mapColumn + 1) * 0.5
	local halfW = zoneCfg.zoneWidth * 0.5
	local halfH = zoneCfg.zoneHeight * 0.5

	self._offsetPosX = -halfW * (centerCol - centerRow)
	self._offsetPosY = -(-halfH * (centerCol + centerRow))
end

function BeastRichManMapMgr:createMap()
	self:_getSortMapCfgs()
	self:_createAllCellBySort()
	self:_checkEventCellOcclusion()
	self:_setBgSize()
end

function BeastRichManMapMgr:_getSortMapCfgs()
	local gridCfgs = BeastRichmanConfig.instance:getGridCfgs(self._activityId, self._zoneId)
	local bossGridCfgs = BeastRichmanConfig.instance:getBossGridCfgs(self._activityId, self._zoneId)

	self._sortMapCfgs = {}
	self._sortMapType = {}
	self._sortMapParam = {}

	for i, v in ipairs(gridCfgs) do
		self._sortMapCfgs[v.uniqueId] = v
		self._sortMapType[v.uniqueId] = BeastRichManEnum.MapType.Path

		if v.eventId > 0 then
			local bindEventUniqueId = v.bindEventUniqueId

			self._sortMapParam[bindEventUniqueId] = {
				eventId = v.eventId,
				bindEventUniqueId = bindEventUniqueId
			}
			self._sortMapType[bindEventUniqueId] = BeastRichManEnum.MapType.Event
			self._sortMapCfgs[bindEventUniqueId] = bindEventUniqueId
		end
	end

	for i, v in pairs(bossGridCfgs) do
		self._sortMapCfgs[v.uniqueId] = v
		self._sortMapType[v.uniqueId] = BeastRichManEnum.MapType.Boss
	end
end

function BeastRichManMapMgr:_createAllCellBySort()
	for i = 1, self._mapColumn do
		for j = 1, self._mapRow do
			local uniqueId = (j - 1) * self._mapColumn + i
			local mapCfg = self._sortMapCfgs[uniqueId]

			if mapCfg then
				local mapType = self._sortMapType[uniqueId]

				if mapType == BeastRichManEnum.MapType.Path then
					self:_createPathCell(mapCfg)
				elseif mapType == BeastRichManEnum.MapType.Boss then
					self:_createBossCell(mapCfg.beastType, mapCfg.beastId)
				elseif mapType == BeastRichManEnum.MapType.Event then
					local params = self._sortMapParam[uniqueId]

					self:_createEventCell(params.eventId, params.bindEventUniqueId)
				end
			end
		end
	end
end

function BeastRichManMapMgr:_createBossCells()
	local bossGridCfgs = BeastRichmanConfig.instance:getBossGridCfgs(self._activityId, self._zoneId)

	for i, v in pairs(bossGridCfgs) do
		self:_createBossCell(v.beastType, v.beastId)
	end
end

function BeastRichManMapMgr:_createPathCells()
	local gridCfgs = BeastRichmanConfig.instance:getGridCfgs(self._activityId, self._zoneId)

	for i, v in ipairs(gridCfgs) do
		self:_createPathCell(v)

		if v.eventId > 0 and not self._pathGridMap[v.bindEventUniqueId] then
			self:_createEventCell(v.eventId, v.bindEventUniqueId)
		end
	end
end

function BeastRichManMapMgr:_createEventCell(eventId, bindEventUniqueId)
	local eventCfg = BeastRichmanConfig.instance:getEventCfgById(self._activityId, eventId)
	local bindEventCfg = BeastRichmanConfig.instance:getEventGridCfg(self._activityId, self._zoneId, bindEventUniqueId)
	local bgComplateInstance = self._complateInstanceMap[BeastRichManEnum.MapGoType.Bg]
	local bgGo = goutil.cloneAndSetParent(bgComplateInstance, self._bgRoot.transform)

	GameUtil.SetActive(bgGo, true)

	local complateInstance = self._complateInstanceMap[BeastRichManEnum.MapGoType.Event]
	local eventGo = goutil.cloneAndSetParent(complateInstance, self._eventFrontRoot.transform)

	GameUtil.SetActive(eventGo, true)

	local item = BeastRichManEventCell.New({
		bg = bgGo,
		event = eventGo
	})

	item:init(self._activityId, self._zoneId, eventId, bindEventUniqueId, self._offsetPosX, self._offsetPosY)

	self._pathGridMap[bindEventUniqueId] = item
end

function BeastRichManMapMgr:_createBossCell(beastType, beastId)
	local bossGridCfg = BeastRichmanConfig.instance:getBossGridCfg(self._activityId, self._zoneId, beastType, beastId)
	local bgComplateInstance = self._complateInstanceMap[BeastRichManEnum.MapGoType.Bg]
	local bgGo = goutil.cloneAndSetParent(bgComplateInstance, self._bgRoot.transform)

	GameUtil.SetActive(bgGo, true)

	local complateInstance = self._complateInstanceMap[BeastRichManEnum.MapGoType.Boss]
	local eventGo = goutil.cloneAndSetParent(complateInstance, self._eventFrontRoot.transform)

	GameUtil.SetActive(eventGo, true)

	local item = BeastRichManBossCell.New({
		bg = bgGo,
		main = eventGo
	})

	item:init(self._activityId, self._zoneId, beastType, beastId, self._offsetPosX, self._offsetPosY)

	self._pathGridMap[bossGridCfg.uniqueId] = item
end

function BeastRichManMapMgr:createPlayer()
	return
end

function BeastRichManMapMgr:_createPathCell(gridCfg)
	local gridId = gridCfg.gridId
	local uniqueId = gridCfg.uniqueId
	local bgComplateInstance = self._complateInstanceMap[BeastRichManEnum.MapGoType.Bg]
	local bgGo = goutil.cloneAndSetParent(bgComplateInstance, self._bgRoot.transform)
	local pathGo
	local complateInstance = self._complateInstanceMap[BeastRichManEnum.MapGoType.Path]
	local item

	pathGo = goutil.cloneAndSetParent(complateInstance, self._pathRoot.transform)

	GameUtil.SetActive(pathGo, true)

	item = BeastRichManPathCell.New({
		bg = bgGo,
		path = pathGo
	})
	self._pathGridMap[uniqueId] = item

	GameUtil.SetActive(bgGo, true)
	item:init(self._activityId, self._zoneId, gridId, self._offsetPosX, self._offsetPosY)

	return item
end

function BeastRichManMapMgr:setComplateInstance(cellGoTag, brickInstance)
	if not brickInstance then
		printError("无对象实例，请检查是否有正确设置模板实例。 brickTag: ", cellGoTag)
	else
		GameUtil.SetActive(brickInstance, true)

		self._complateInstanceMap[cellGoTag] = brickInstance

		GameUtil.SetActive(brickInstance, false)
	end
end

function BeastRichManMapMgr:getXIndex(index)
	return index % self._mapColumn
end

function BeastRichManMapMgr:getYIndex(index)
	return math.floor(index / self._mapColumn)
end

function BeastRichManMapMgr:getMapColumn()
	return self._mapColumn
end

function BeastRichManMapMgr:getOffsetXY()
	return self._offsetPosX, self._offsetPosY
end

function BeastRichManMapMgr:clear()
	for k, item in pairs(self._cellItemMap) do
		item:clearCell()
	end

	self._cellItemMap = {}

	for k, v in pairs(self._pathGridMap) do
		v:clearCell()
		v:destroy()
	end

	self._pathGridMap = {}

	if self._hLPlayerMgr then
		self._hLPlayerMgr:onExit()
	end

	self._hLPlayerMgr = nil

	if self._hLPlayerMgr2 then
		self._hLPlayerMgr2:onExit()
	end

	self._hLPlayerMgr2 = nil
end

function BeastRichManMapMgr:getPathCellPos(gridId)
	local gridCfg = BeastRichmanConfig.instance:getGridCfgById(self._activityId, self._zoneId, gridId)

	return self:calCellPos(self._activityId, self._zoneId, gridCfg.uniqueId)
end

function BeastRichManMapMgr:getPathCellPosAfterOffset(gridId)
	local gridCfg = BeastRichmanConfig.instance:getGridCfgById(self._activityId, self._zoneId, gridId)
	local posX, posY = self:calCellPos(self._activityId, self._zoneId, gridCfg.uniqueId)

	return posX + self._offsetPosX, posY + self._offsetPosY
end

function BeastRichManMapMgr:getPathCell(gridId)
	local gridCfg = BeastRichmanConfig.instance:getGridCfgById(self._activityId, self._zoneId, gridId)

	return self._pathGridMap[gridCfg.uniqueId]
end

function BeastRichManMapMgr:getCellByUniqueId(uniqueId)
	return self._pathGridMap[uniqueId]
end

function BeastRichManMapMgr:getClickCoordXY(posX, posY)
	return
end

function BeastRichManMapMgr:trickPathCell(activityId, gridId, isFinish)
	local item = self:getPathCell(gridId)

	if item then
		return item:trickCell(activityId, gridId, isFinish)
	end
end

function BeastRichManMapMgr:trickEventCell(activityId, zoneId, pathGridId)
	self:_updateEventCellsUI(activityId, zoneId)

	local pathCellHasFinish = BeastRichmanController.instance:curPathCellHasFinish(activityId, zoneId, pathGridId)

	if not pathCellHasFinish then
		return
	end

	local eventCellHasFinish = BeastRichmanController.instance:curEventHasFinish(activityId, zoneId)

	if eventCellHasFinish then
		return
	end

	local gridCfg = BeastRichmanConfig.instance:getGridCfg(activityId, zoneId, pathGridId)

	if gridCfg.eventId > 0 then
		local item = self:getCellByUniqueId(gridCfg.bindEventUniqueId)

		if item then
			item:trickCell()
		end
	end
end

function BeastRichManMapMgr:calCellPos(activityId, zoneId, uniqueId)
	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(activityId, zoneId)
	local height = zoneCfg.size[2]
	local row = math.ceil(uniqueId / height)
	local col = (uniqueId - 1) % height + 1
	local w, h = zoneCfg.zoneWidth, zoneCfg.zoneHeight
	local halfW = w * 0.5
	local halfH = h * 0.5

	return halfW * (col - row), -halfH * (col + row)
end

function BeastRichManMapMgr:calMapSize(activityId, zoneId)
	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(activityId, zoneId)
	local _, maxY = BeastRichManMapMgr.instance:calCellPos(activityId, zoneId, 1)
	local maxX = BeastRichManMapMgr.instance:calCellPos(activityId, zoneId, zoneCfg.size[2])
	local _, minY = BeastRichManMapMgr.instance:calCellPos(activityId, zoneId, zoneCfg.size[1] * zoneCfg.size[2])
	local minX = BeastRichManMapMgr.instance:calCellPos(activityId, zoneId, (zoneCfg.size[1] - 1) * zoneCfg.size[2] + 1)
	local x = maxX - minX + zoneCfg.zoneWidth
	local y = maxY - minY + zoneCfg.zoneHeight

	return x + zoneCfg.zoneWidth * 2, y + zoneCfg.zoneHeight * 2
end

function BeastRichManMapMgr:_updateEventCellsUI(activityId, zoneId)
	local map = BeastRichmanConfig.instance:getEventGridCfgs(activityId, zoneId)

	for k, v in pairs(map) do
		local item = self:getCellByUniqueId(v.uniqueId)

		if item then
			item:updateUI()
		end
	end
end

function BeastRichManMapMgr:showServerAutoFinishPathCellItems(gridId)
	local item = self:getPathCell(gridId)

	if item and item.showServerAutoFinish then
		item:showServerAutoFinish()
	end
end

function BeastRichManMapMgr:_checkEventCellOcclusion()
	local gridCfgs = BeastRichmanConfig.instance:getGridCfgs(self._activityId, self._zoneId)

	for i, v in ipairs(gridCfgs) do
		if v.eventId > 0 and v.bindEventUniqueId > 0 then
			local eventUniqueId = v.bindEventUniqueId
			local eventItem = self._pathGridMap[eventUniqueId]

			if eventItem and eventItem.setImageAlpha then
				local hasOcclusion, occlusionInfo = self:_checkAdjacentPathCell(eventUniqueId)

				if hasOcclusion then
					eventItem:setImageAlpha(0.7)
				end
			end
		end
	end
end

function BeastRichManMapMgr:_checkAdjacentPathCell(eventUniqueId)
	local row = math.ceil(eventUniqueId / self._mapColumn)
	local col = (eventUniqueId - 1) % self._mapColumn + 1
	local checkDirections = {
		{
			colOffset = -1,
			name = "左边",
			rowOffset = 0
		},
		{
			colOffset = 0,
			name = "上边",
			rowOffset = -1
		},
		{
			colOffset = -1,
			name = "左上",
			rowOffset = -1
		}
	}
	local occlusionInfo = string.format("当前位置 row=%d col=%d uniqueId=%d | ", row, col, eventUniqueId)

	for _, dir in ipairs(checkDirections) do
		local checkRow = row + dir.rowOffset
		local checkCol = col + dir.colOffset

		if checkRow >= 1 and checkRow <= self._mapRow and checkCol >= 1 and checkCol <= self._mapColumn then
			local adjacentId = (checkRow - 1) * self._mapColumn + checkCol
			local mapType = self._sortMapType[adjacentId]
			local mapTypeName = mapType == BeastRichManEnum.MapType.Path and "Path" or mapType == BeastRichManEnum.MapType.Event and "Event" or mapType == BeastRichManEnum.MapType.Boss and "Boss" or "无"

			occlusionInfo = occlusionInfo .. string.format("%s(id=%d type=%s) ", dir.name, adjacentId, mapTypeName)

			if mapType then
				occlusionInfo = occlusionInfo .. "-> 发现遮挡!"

				return true, occlusionInfo
			end
		else
			occlusionInfo = occlusionInfo .. string.format("%s(越界) ", dir.name)
		end
	end

	return false, occlusionInfo
end

function BeastRichManMapMgr:_setBgSize()
	local x, y = BeastRichManMapMgr.instance:calMapSize(self._activityId, self._zoneId)
	local scale = x / 2048

	GameUtil.setLocalScale(self._bgGo, scale, scale, scale)
end

BeastRichManMapMgr.instance = BeastRichManMapMgr.New()

return BeastRichManMapMgr
