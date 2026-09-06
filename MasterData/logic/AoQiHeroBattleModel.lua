-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/AoQiHeroBattleModel.lua

module("logic.extensions.aoqihero.model.AoQiHeroBattleModel", package.seeall)

local AoQiHeroBattleModel = class("AoQiHeroBattleModel", BaseModel)

function AoQiHeroBattleModel:ctor()
	self:onReset()
end

function AoQiHeroBattleModel:onReset()
	self._map = {}
end

function AoQiHeroBattleModel:initMapData(activityId, creepsMasterId)
	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(activityId, creepsMasterId)

	self._map_size = Vector2.New(teamCfg.row, teamCfg.col)

	for i = 1, self._map_size.x do
		self._map[i] = self._map[i] or {}

		for j = 1, self._map_size.y do
			local gridId = (i - 1) * self._map_size.y + j

			self._map[i][j] = teamCfg.map[gridId] == 0 and AoQiHeroConst.MapEmptyIndex or AoQiHeroConst.MapBlockIndex
		end
	end
end

function AoQiHeroBattleModel:initMapSet()
	local enemyTeamInfo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.DefenceTeam)

	for k, v in pairs(enemyTeamInfo.pos) do
		local pet = AoQiHeroEntityMgr.instance:getPet(v)
		local x, y = self:grid2XY(pet.pos)
		local sizeX, sizeY = pet.sizeX, pet.sizeY

		for i = x, x + (sizeX - 1) do
			for j = y, y + (sizeY - 1) do
				if self._map[i] then
					self._map[i][j] = pet.id
				end
			end
		end
	end
end

function AoQiHeroBattleModel:grid2XY(gridId)
	local x, y

	x = math.ceil(gridId / self._map_size.y)

	return x, gridId - (x - 1) * self._map_size.y
end

function AoQiHeroBattleModel:XY2grid(x, y)
	return (x - 1) * self._map_size.y + y
end

function AoQiHeroBattleModel:getInfo(x, y)
	if self._map[x] then
		return self._map[x][y]
	end
end

function AoQiHeroBattleModel:getMapSize()
	return self._map_size
end

function AoQiHeroBattleModel:chengePos(enemyId, formId, toId)
	local enemyMo = AoQiHeroEntityMgr.instance:getPet(enemyId)
	local sizeX, sizeY = enemyMo.sizeX, enemyMo.sizeY
	local formX, formY = self:grid2XY(formId)

	for i = formX, formX + (sizeX - 1) do
		for j = formY, formY + (sizeY - 1) do
			if self._map[i] then
				self._map[i][j] = AoQiHeroConst.MapEmptyIndex
			end
		end
	end

	local toX, toY = self:grid2XY(toId)

	for i = toX, toX + (sizeX - 1) do
		for j = toY, toY + (sizeY - 1) do
			if self._map[i] then
				self._map[i][j] = enemyId
			end
		end
	end
end

function AoQiHeroBattleModel:clearPetId(enemyId)
	local enemyMo = AoQiHeroEntityMgr.instance:getPet(enemyId)
	local sizeX, sizeY = enemyMo.sizeX, enemyMo.sizeY

	if enemyMo.pos and enemyMo.pos > 0 then
		local formX, formY = self:grid2XY(enemyMo.pos)

		for i = formX, formX + (sizeX - 1) do
			for j = formY, formY + (sizeY - 1) do
				if self._map[i] and self._map[i][j] == enemyId then
					self._map[i][j] = AoQiHeroConst.MapEmptyIndex
				end
			end
		end
	end
end

function AoQiHeroBattleModel:findPathForSingle(gridId, speed, range)
	if range == 0 then
		return nil
	end

	local startX, startY = self:grid2XY(gridId)
	local path = self:_findPathByBFS({
		startX,
		startY
	}, range, true)

	path = path or self:_findPathByBFS({
		startX,
		startY
	}, range, false)

	if path then
		local posList = {}

		for i = 1, speed do
			if i > #path then
				break
			end

			local pos = self:XY2grid(path[i][1], path[i][2])

			table.insert(posList, pos)
		end

		return posList
	end

	return nil
end

function AoQiHeroBattleModel:findPathForSize(gridId, width, speed, range)
	if range == 0 then
		return nil
	end

	local x, y = self:grid2XY(gridId)
	local moveDir = 0

	for i = y - 1, y - speed, -1 do
		if i <= 0 then
			break
		end

		local allClear = true

		for j = x, x + width - 1 do
			local info = AoQiHeroBattleModel.instance:getInfo(j, i)

			if checknumber(info) ~= 0 then
				allClear = false
			end
		end

		if allClear then
			moveDir = moveDir + 1
		else
			break
		end
	end

	local posList = {}

	if moveDir > 0 then
		for i = 1, moveDir do
			local targetGridId = AoQiHeroBattleModel.instance:XY2grid(x, y - i)

			table.insert(posList, targetGridId)
		end

		return posList
	else
		return nil
	end
end

function AoQiHeroBattleModel:isValidMoveFixEmpty(x, y)
	local rows = self._map_size.x
	local cols = self._map_size.y

	if x >= 1 and x <= rows and y >= 1 and y <= cols then
		return self._map[x][y] == AoQiHeroConst.MapEmptyIndex
	else
		return false
	end
end

function AoQiHeroBattleModel:isValidMove(x, y, start)
	local rows = self._map_size.x
	local cols = self._map_size.y

	if x >= 1 and x <= rows and y >= 1 and y <= cols then
		if math.abs(start[1] - x) + math.abs(start[2] - y) <= 1 then
			return self._map[x][y] == AoQiHeroConst.MapEmptyIndex
		else
			return self._map[x][y] ~= AoQiHeroConst.MapBlockIndex
		end
	else
		return false
	end
end

function AoQiHeroBattleModel:_findPathByBFS(start, max_y, isFixEmpty)
	local directions = {
		{
			0,
			-1
		},
		{
			-1,
			0
		},
		{
			1,
			0
		}
	}
	local queue = {
		start
	}
	local visited = {}
	local parent = {}

	visited[start[1] .. "," .. start[2]] = true
	parent[start[1] .. "," .. start[2]] = nil

	while #queue > 0 do
		local current = table.remove(queue, 1)

		if max_y >= current[2] then
			local path = {}

			while current do
				table.insert(path, 1, current)

				current = parent[current[1] .. "," .. current[2]]
			end

			table.remove(path, 1)

			local fixIndex = 0

			for i, v in ipairs(path) do
				if self:isValidMoveFixEmpty(v[1], v[2]) == true then
					fixIndex = fixIndex + 1
				else
					break
				end
			end

			local pathNum = #path

			for i = 1, pathNum - fixIndex do
				table.remove(path)
			end

			return path
		end

		for _, direction in ipairs(directions) do
			local new_x = current[1] + direction[1]
			local new_y = current[2] + direction[2]
			local new_position = {
				new_x,
				new_y
			}

			if isFixEmpty == true then
				if self:isValidMoveFixEmpty(new_x, new_y, start) and not visited[new_x .. "," .. new_y] then
					visited[new_x .. "," .. new_y] = true
					parent[new_x .. "," .. new_y] = current

					table.insert(queue, new_position)
				end
			elseif self:isValidMove(new_x, new_y, start) and not visited[new_x .. "," .. new_y] then
				visited[new_x .. "," .. new_y] = true
				parent[new_x .. "," .. new_y] = current

				table.insert(queue, new_position)
			end
		end
	end

	return nil
end

function AoQiHeroBattleModel:getActionId()
	return self._actionId
end

function AoQiHeroBattleModel:addActionId()
	self._actionId = self._actionId + 1
end

function AoQiHeroBattleModel:setReadyBattleStartInfo(msg)
	self._actionId = msg.actionId
	self._raceIds = msg.raceIds
	self._creepsMasterId = msg.creepsMasterId
end

function AoQiHeroBattleModel:setRandomClientKey()
	self._clientKey = math.random(1, 1000000)

	return self._clientKey
end

function AoQiHeroBattleModel:getClientKey()
	return self._clientKey
end

function AoQiHeroBattleModel:getServerKey()
	return self._serverKey
end

function AoQiHeroBattleModel:handleBattleStart(msg)
	self._actionId = msg.actionId
	self._serverKey = msg.serverKey
end

function AoQiHeroBattleModel:handleBattleSync(msg)
	self._actionId = msg.actionId
end

function AoQiHeroBattleModel:resetTowerInfo(msg)
	local towerMo = AoQiHeroEntityMgr.instance:getPet(AoQiHeroConst.TowerEntityId)

	towerMo.curHp = msg.leftHp
end

AoQiHeroBattleModel.instance = AoQiHeroBattleModel.New()

return AoQiHeroBattleModel
