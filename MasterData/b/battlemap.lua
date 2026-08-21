-- Instantiate = UnityEngine.GameObject.Instantiate
-- GameObject = UnityEngine.GameObject

require "class"
local BaseMap = require "BaseMap"
---@class BattleMap:BaseMap
---@field super BaseMap
---@field getBlockById fun(self:BattleMap, blockId:integer):BattleBlock
local BattleMap = class("BattleMap", BaseMap)
local BattleBlock = require "BattleBlock"
local BattleCore = require "BattleCore"


function BattleMap:ctor()
	BattleCore.ds("BattleMap ctor")
	self:init()
end

function BattleMap:clear()
	self.chooseRangeSourceBlockDic = {}
	self.super.clear(self)
end

function BattleMap:init()
	BaseMap.init(self)
	self.battleRoot = nil
	self.cameraObj = nil
	self.camera = nil
    -- 光环影响的地格effect信息，key为effectId，value为另一个字典，key为blockId，value为roleId列表
	---@type table<integer, table<integer, table<integer, integer[]>>>
    self._hasEffectBlockList = {}
end

---覆盖工厂方法：战斗地图使用 BattleBlock
---@param blockData MapBlockData
---@return BattleBlock
function BattleMap:createBlock(blockData)
	return BattleBlock:new(blockData)
end

---初始化战斗地图
---@param levelConfig PveLevelTable 关卡配置
---@param verifyMode boolean 是否验证模式或者是本地战斗模式
---@param callback function? 回调函数
function BattleMap:initMap(levelConfig, verifyMode, callback)
	BaseMap.initMap(self, levelConfig, callback)
end

---@return integer[]
function BattleMap:getFormationRange(levelConfig)
	local list = {}
	for _, cid in ipairs(levelConfig.UserPosition) do
		local blockId = self:blockCidToId(cid)
		if (blockId) then
			table.insert(list, blockId)
		end
	end
	return list
end

---获取最短路线
---@param startBlockId integer 起点地块id
---@param endBlockId integer 终点地块id
---@param pathArea table<integer, BlockData> 路线范围
---@return integer[]
function BattleMap:getShortestPath(startBlockId, endBlockId, pathArea)
	if startBlockId == endBlockId then
		return { startBlockId }
	end
	---@type BlockData
	local blockData = {
		blockId = endBlockId
	}
	return self:getShortestPathToArea(startBlockId, { [endBlockId] = blockData }, pathArea)
end

---获取通往区域的最短路线
---@param startBlockId integer 起点地块id
---@param blockList table<integer, BlockData> 目标格子列表
---@param pathArea table<integer, BlockData> 路线范围
---@return integer[]
function BattleMap:getShortestPathToArea(startBlockId, blockList, pathArea)
	local priorityQueue = {}
	local visited = {}
	local parents = {}

	table.insert(priorityQueue, {blockId = startBlockId, priority = 0, dirPriority = 0, direction = nil})  -- 添加记录当前方向的字段
	visited[startBlockId] = true

	while #priorityQueue > 0 do
		table.sort(priorityQueue, function(a, b) return a.priority == b.priority and a.dirPriority < b.dirPriority or a.priority < b.priority end)
		local current = table.remove(priorityQueue, 1)
		local currentBlockId = current.blockId
		local currentPriority = current.priority
		local currentDirPriority = current.dirPriority
		local currentDirection = current.direction  -- 获取当前方向

		if blockList[currentBlockId] ~= nil then
			local path = {}
			while currentBlockId do
				table.insert(path, 1, currentBlockId)
				currentBlockId = parents[currentBlockId]
			end
			return path
		end

		local currentBlock = self:getBlockById(currentBlockId)
		if currentBlock then
			for _, dir in ipairs(self._directions) do
				local nextRow = currentBlock.row + dir[1]
				local nextCol = currentBlock.col + dir[2]
				local nextBlockId = self:getBlockId(nextCol, nextRow)
				local nextDirection = dir  -- 记录下一个方向

				if nextBlockId > 0 and not visited[nextBlockId] and (not pathArea or pathArea[nextBlockId] ~= nil) then
					local priority = currentPriority + 1
					local dirPriority = currentDirPriority + 1
					if currentDirection and (currentDirection[1] == dir[1] and currentDirection[2] == dir[2]) then
						dirPriority = currentDirPriority
					end
					table.insert(priorityQueue, {blockId = nextBlockId, priority = priority, direction = nextDirection, dirPriority = dirPriority})
					visited[nextBlockId] = true
					parents[nextBlockId] = currentBlockId
				end
			end
		end
	end

	return {}  -- 如果找不到路径，返回空数组
end

---根据攻击目标获取最近的移动点
---@param skillConfig SkillTable
---@param sourceBlock BattleBlock
---@param moveList table<integer, BlockData>
---@return BattleBlock? nearestBlock
function BattleMap:getNearestBlockByAtkTarget(sourceBlock, targetBlock, skillConfig, moveList)
	-- local minDistance = 99
	local rangeList = {}
	local sourceRole = sourceBlock:tryGetRole()
	local skillMgr = BattleCore:getSkillMgr()
	local skillRange = skillMgr:GetSkillSelectRangeByRole(skillConfig, sourceRole)
    local list = self:getDiffuseRange(skillConfig.skillSelectType, targetBlock, skillRange, targetBlock, 0, skillConfig.deleteRange)
	for _, data in ipairs(list) do
		local blockId = data.blockId
		if moveList[blockId] ~= nil then
			local block = self:getBlockById(blockId)
			local blockRoleId = block:getTmpRoleId()
			if (not blockRoleId) or (sourceRole ~= nil and blockRoleId == sourceRole.id) then
				rangeList[blockId] = data
			end
		end
	end
	local path = self:getShortestPathToArea(sourceBlock.id, rangeList, moveList)
	local nearestBlock = self:getBlockById(path[#path])
	return nearestBlock
end

---根据移动类型获取可移动范围，需要排除敌方占据的格子
---@param moveType integer 移动类型
---@param roleCamp BattleCampType?
---@return table<integer, BlockData>
function BattleMap:getCanMoveRangeByMoveType(moveType, roleCamp)
	---@type table<integer, BlockData>
	local range = {}
	local roleMgr = BattleCore:getBattleRoleMgr()
	for _, block in pairs(self.blocks) do
		local tData = block.terrainCfgData
		local moveCost = tData.moveCost[moveType]
		if (not moveCost) then
			BattleCore.ws("BattleMap:getCanMoveRangeByMoveType wrong moveType", moveType)
			moveCost = 0
		end

		if roleCamp then
			local blockRole = block:tryGetRole()
			if blockRole and roleMgr:isEnemyCampByCamp(roleCamp, blockRole.camp) then
				moveCost = 99  -- 如果是敌方角色，则设置为不可移动
			end
		end

		if moveCost < 99 then
			local blockId = block.id
			local blockData = {
				blockId = blockId,
				lap = 0
			}
			range[blockId] = blockData
		end
	end
	return range
end

---获取路线移动力消耗
---@param moveType integer
---@param path integer[]
---@param offsetCostDic table<integer, integer>? 移动力消耗偏移
---@param sourceBlockId integer? 移动角色所处地块id
---@return integer
function BattleMap:getMoveCostByPath(moveType, path, offsetCostDic, sourceBlockId)
	local cost = 0
	for index, blockId in ipairs(path) do
		if (index > 1) then
			local block = self:getBlockById(blockId)
			local moveCost = self:getBlockMoveCost(block, moveType, offsetCostDic, sourceBlockId)
			cost = cost + moveCost
		end
	end
	return cost
end

---获取移动范围
---@param role BattleRole 角色
---@param movePowType MovePowerType
---@param fixedMovePower integer? 效果传入的固定移动力
---@return BlockData[], table<integer, BlockData> list
function BattleMap:getMoveRange(role, movePowType, fixedMovePower)
	local power = 0
	if (movePowType == GE.MovePowerType.Remain) then
		power = role:getRemainMovePower()
	elseif movePowType == GE.MovePowerType.Fixed and fixedMovePower then
		power = fixedMovePower
	elseif movePowType == GE.MovePowerType.Normal then
		power = role:getAttrib(GE.AttribType.MovePower)
	end
	local block = role.block
	local lap = 0
	local blockId = block.id
	local blockData = {
		blockId = blockId,
		lap = lap
	}

	local list = {}
	local visited = {}
	list[blockId] = blockData
	---@class RoleMoveCheckData
	---@field camp BattleCampType
	---@field moveOffsetDic table<integer, integer>
	---@field ignoreEnemyBlock boolean
	local roleData = {
		camp = role.camp,
		moveType = role.roleConfig.moveType,
		blockId = role:getShowBlock().id,
		roleId = role.id,
		moveOffsetDic = role:getMoveCostOffset(),
		ignoreEnemyBlock = role.buffController:checkHasIgnoreEnemyBlock(),
	}
	-- table.insert(list, blockData)
	self:_checkMoveRange(power, roleData, blockId, lap, list, visited, true)
	local iList = {}
	local listIndex = 1
	for _, value in pairs(list) do
		iList[listIndex] = value
		listIndex = listIndex + 1
	end
	table.sort(iList, function(a, b)
        return a.lap < b.lap
    end)
	return iList, list
end

---@param power integer
---@param roleData RoleMoveCheckData
---@param blockId integer
---@param lap integer
---@param list BlockData[]
---@param visited table<integer, integer>
---@param isStart boolean
function BattleMap:_checkMoveRange(power, roleData, blockId, lap, list, visited, isStart)
	if visited[blockId] then
		if power <= visited[blockId] then
			return
		else
			list[blockId] = nil
		end
	end

	visited[blockId] = power

	local block = self:getBlockById(blockId)
	if not block then
		return
	end

	local roleMgr = BattleCore:getBattleRoleMgr()
	local tData = block.terrainCfgData
	local blockRole = block:tryGetRole()
	if not tData.moveCost or (blockRole and roleMgr:isEnemyCampByCamp(roleData.camp, blockRole.camp) and roleData.ignoreEnemyBlock == false) then
		return
	end

	local moveType = roleData.moveType
	local offsetCostDic = roleData.moveOffsetDic
	local sourceBlockId = roleData.blockId
	if not isStart then
        local moveCost = self:getBlockMoveCost(block, moveType, offsetCostDic, sourceBlockId)
		power = power - moveCost
		if power >= 0 and (list[blockId] == nil or (blockRole and blockRole.id == roleData.roleId)) then
			local blockData = {
				blockId = blockId,
				lap = lap
			}
			list[blockId] = blockData
		end
	end

	if power >= 0 then
		for _, dir in ipairs(self._directions) do
			local nextRow = block.row + dir[1]
			local nextCol = block.col + dir[2]
			local nextBlockId = self:getBlockId(nextCol, nextRow)
			if nextBlockId > 0 then
				self:_checkMoveRange(power, roleData, nextBlockId, lap + 1, list, visited, false)
			end
		end
	end
end

---@param role BattleRole
---@param skillId integer 技能id
---@param moveList BlockData[] 移动范围
---@param needCombine boolean? 技能范围是否需要算入移动范围的影响
---@return BlockData[], table<integer, BlockData> list 格子id列表
function BattleMap:getChooseRangeByMoveRange(moveList, skillId, role, needCombine)
	---@type BattleBlock[]
	self.chooseRangeSourceBlockDic = {}
	self._chooseRangeMinDistanceDic = {}

	local skillMgr = BattleCore:getSkillMgr()
	local skillConfig = Config.GetSkillInfo(skillId)

	if not skillConfig then
		return {}, {}
	end

    local chooseRangeList = {}
	---@type table<integer, integer> 移动范围格子的id字典
	local checkList = {}
	for _, v in ipairs(moveList) do
		checkList[v.blockId] = 1
	end
	---@type table<integer,BlockData>
	local resultCheckList = {}
    if skillConfig.skillSelectType == GE.SkillRangeType.AllMap then
		local block = role:getShowBlock()
		chooseRangeList = self:getAllMapBlock(block, 0)
		for _, value in ipairs(chooseRangeList) do
			resultCheckList[value.blockId] = value
		end
    else
        local roleId = role.id
		local operateType = skillConfig.skillOperateType
		---指向类技能和对自身释放类技能需要考虑技能二次覆盖范围
		local needEffectRange = operateType == GE.SkillOperateType.Direction or operateType == GE.SkillOperateType.SelfBlock
		local skillRange = needEffectRange == false and
			skillMgr:GetSkillSelectRangeByRole(skillConfig, role) or
			skillMgr:GetSkillEffectRangeByRole(skillConfig, role)
        local neighborBlockIds = {}
		---@type table<integer, integer> 已检查格子id字典
		local hasCheckList = {}

		---@type fun(sourceBlock: BattleBlock, block: BattleBlock, skillConfig: SkillTable, blockData: BlockData, skillRange: integer[])
		local checkFunc = function (sourceBlock, block, skillConfig, blockData, skillRange)
			local blockId = sourceBlock.id
			hasCheckList[blockId] = 1
			local rangeType = needEffectRange and skillConfig.rangeSelectType or skillConfig.skillSelectType
			local list = self:getDiffuseRange(rangeType, block, skillRange, sourceBlock,
				blockData.lap, skillConfig.deleteRange)

			for _, data in ipairs(list) do
				local blockId = data.blockId
				if resultCheckList[blockId] == nil then
					resultCheckList[blockId] = data
				end
			end
		end

        for _, blockData in ipairs(moveList) do
			local blockId = blockData.blockId
            local sourceBlock = self:getBlockById(blockData.blockId)
			local blockRoleId = sourceBlock:getTmpRoleId()
			local isPass = blockRoleId == nil or blockRoleId == roleId
            if hasCheckList[blockId] == nil and isPass then
                ---判断是否最外圈
                neighborBlockIds[1] = self:getBlockId(sourceBlock.col, sourceBlock.row - 1)
                neighborBlockIds[2] = self:getBlockId(sourceBlock.col, sourceBlock.row + 1)
                neighborBlockIds[3] = self:getBlockId(sourceBlock.col - 1, sourceBlock.row)
                neighborBlockIds[4] = self:getBlockId(sourceBlock.col + 1, sourceBlock.row)

                local isOutermost = false
                for _, neighborId in ipairs(neighborBlockIds) do
					local neighborBlock = self:getBlockById(neighborId)
					if neighborBlock then
						if checkList[neighborId] == nil or neighborBlock:getTmpRoleId() ~= nil then
							isOutermost = true
							break
						end
					end
                end

                if isOutermost then
					if skillConfig.skillOperateType == GE.SkillOperateType.Direction then
						for _, neighborId in ipairs(neighborBlockIds) do
							local dirBlock = self:getBlockById(neighborId)
							if dirBlock then
								checkFunc(sourceBlock, dirBlock, skillConfig, blockData, skillRange)
							end
						end
					else
						local exceptRange = skillConfig.deleteRange or 0
						local checkRange = {}
						if exceptRange > 0 then
							local exceptSkillRange = { exceptRange, 0 }
							local diffuseRange = self:getDiffuseRange(GE.SkillRangeType.Normal, sourceBlock,
								exceptSkillRange, sourceBlock, blockData.lap)
							for _, blockD in ipairs(diffuseRange) do
								local block = self:getBlockById(blockD.blockId)
								if block then
									local curBlockId = block.id
									if hasCheckList[curBlockId] == nil and checkList[curBlockId] then
										local blockRoleId = block:getTmpRoleId()
										local isPass = blockRoleId == nil or blockRoleId == roleId
										if isPass then
											checkRange[#checkRange + 1] = block
										end
									end
								end
							end
						else
							checkRange[#checkRange + 1] = sourceBlock
						end
						for _, curentBlock in ipairs(checkRange) do
							checkFunc(curentBlock, curentBlock, skillConfig, blockData, skillRange)
						end
					end
                end
            end
        end
		if needCombine ~= false then
			for _, value in ipairs(moveList) do
				resultCheckList[value.blockId] = value
			end
		end

		local listIndex = 1
		for _, value in pairs(resultCheckList) do
            chooseRangeList[listIndex] = value
            listIndex = listIndex + 1
		end
	end
	
	return chooseRangeList, resultCheckList
end

---@return BattleBlock
function BattleMap:getChooseRangeSourceBlock(blockId)
	return self.chooseRangeSourceBlockDic[blockId]
end

---@param rangeType SkillRangeType
---@param range integer[]
---@param sourceBlock BattleBlock?
---@param lap integer?
---@param excludeRange integer? 仅一次扩散，即select需要传入
---@return BlockData[] list 格子id列表
function BattleMap:getDiffuseRange(rangeType, block, range, sourceBlock, lap, excludeRange)
	if (not lap) then
		lap = 0
	end
	excludeRange = excludeRange or 0
	if (rangeType == GE.SkillRangeType.Normal) then
		return self:getNormalDiffuseRange(block, range[1], sourceBlock, lap, excludeRange)
	elseif (rangeType == GE.SkillRangeType.Cross) then
        return self:getCrossDiffuseRange(block, range[1], sourceBlock, lap, excludeRange)
	elseif (rangeType == GE.SkillRangeType.Rectangular) then
        return self:getRectangularDiffuseRange(block, range[1], sourceBlock, lap)
    elseif (rangeType == GE.SkillRangeType.SelectDirction and sourceBlock) then
        return self:getDirectionDiffuseRange(sourceBlock, block, range, lap)
    elseif (rangeType == GE.SkillRangeType.AllMap) then
        return self:getAllMapBlock(block, lap)
	else
		BattleCore.ds("BattleMap:getDiffuseRange wrong SkillRangeType", rangeType)
		return {}
	end
end

---@class MapData
---@field blocks BattleBlock[]
---@field blockEffects table<integer, table<integer, integer[]>> 有效果的格子

---重置基本战斗信息
---@param mapData MapData
function BattleMap:resetBaseMapData(mapData)
	---@type BattleBlock[]
	self.blocks = mapData.blocks
	self._hasEffectBlockList = mapData.blockEffects
end

---获取基本战斗信息
---@return MapData
function BattleMap:getBaseMapData()
	local r = {}
	for blockId, block in pairs(self.blocks) do
		local copyBlock = tablex.copy(block)
		copyBlock:setTmpRoleId(nil)
		r[blockId] = copyBlock
	end
	local data = {
		blocks = r,
		blockEffects = tablex.copy(self._hasEffectBlockList)
	}
	return data
end

---@class BlockData
---@field blockId integer
---@field direction integer?  -- 方向, 1:左 2:右 3:上 4:下，目前仅用于选择方向释放技能的一次扩散范围显示
---@field lap integer?

---获取常规扩散范围
---@param block BattleBlock 格子
---@param range integer 效果范围
---@return BlockData[] list 格子id列表
function BattleMap:getNormalDiffuseRange(block, range, sourceBlock, lap, excludeRange)
	-- local blockId = block.row * 10 + block.col + 1
	-- local skillConfig = Config.GetSkillInfo(skillId)

	local list = {}
	-- table.insert(list, block.id)
	local maxRange = range
    self:_checkNormalDiffuseRange(maxRange, excludeRange, block, list, sourceBlock, lap)
	return list
end

---@param block BattleBlock
function BattleMap:_checkNormalDiffuseRange(range, excludeRange, block, list, sourceBlock, lap)
	-- local block = self:getBlockById(blockId)
	if (not block) then
		return
	end

	local resultCheckList = {}
	local checkFunc = function (checkBlockId, checkLap)
		if resultCheckList[checkBlockId] == nil then
            ---@type BlockData
            local blockData = {
                blockId = checkBlockId,
                lap = checkLap
            }
            list[#list + 1] = blockData
			resultCheckList[checkBlockId] = 1
            if (sourceBlock and ((not self._chooseRangeMinDistanceDic[checkBlockId]) or (range < self._chooseRangeMinDistanceDic[checkBlockId]))) then
                self.chooseRangeSourceBlockDic[checkBlockId] = sourceBlock
                self._chooseRangeMinDistanceDic[checkBlockId] = range
            end
		end
	end

	-- local tData = self.terrainData[block.terrain]
	-- if (tData.obstruct < 99) then
    -- range = range - 1
	local checkList = {1, -1}
	local startRow = block.row
	local startCol = block.col
    for i = range, 0, -1 do
        for j = 0, range - i do
			local num = i + j
            if num >= excludeRange then
                local checkIndex = i > 0 and 2 or 1
                for index = 1, checkIndex do
                    local checkValue = checkList[index]
                    local newCol = startCol + i * checkValue
                    local newRow = startRow + j
                    local block1 = self:getBlock(newCol, newRow)
                    if block1 then
                        checkFunc(block1.id, lap + num)
                    end
                    if j > 0 then
                        newRow = startRow + j * -1
                        local block1 = self:getBlock(newCol, newRow)
                        if block1 then
                            checkFunc(block1.id, lap + num)
                        end
                    end
                end
            end
		end
	end
	-- LuaLogger.ds("检查对应结果", tablex.dump(list))
	-- end
end

---获取十字形扩散范围
---@param block BattleBlock 格子
---@param range integer 效果范围
---@return table list 格子id列表
function BattleMap:getCrossDiffuseRange(block, range, sourceBlock, lap, excludeRange)
	local list = {}
	local range = range
	local curRow = block.row
	for i = curRow - range, curRow + range do
		if math.abs(i - curRow) >= excludeRange and (i >= self.minRows - 1) and (i < self.minRows - 1 + self.maxRows) then
			local blockId = self:getBlockId(block.col, i)
			-- if (not tablex.contains(list, blockId)) then
			if self.chooseRangeSourceBlockDic[blockId] == nil then
				local blockData = {
					blockId = blockId,
					lap = lap + math.abs(i - block.row)
				}
				table.insert(list, blockData)
				if (sourceBlock and (not self._chooseRangeMinDistanceDic[blockId] or range < self._chooseRangeMinDistanceDic[blockId])) then
					self.chooseRangeSourceBlockDic[blockId] = sourceBlock
					self._chooseRangeMinDistanceDic[blockId] = range
				end
			end
		end
	end

	local curCol = block.col
	for j = curCol - range, curCol + range do
		if math.abs(j - curCol) >= excludeRange and (j >= self.minCols - 1) and (j < self.minCols - 1 + self.maxCols) then
			local blockId = self:getBlockId(j, block.row)
			-- if (not tablex.contains(list, blockId)) then
			if self.chooseRangeSourceBlockDic[blockId] == nil then
				local blockData = {
					blockId = blockId,
					lap = lap + math.abs(j - block.col)
				}
				table.insert(list, blockData)
				if (sourceBlock and (not self._chooseRangeMinDistanceDic[blockId] or range < self._chooseRangeMinDistanceDic[blockId])) then
					self.chooseRangeSourceBlockDic[blockId] = sourceBlock
					self._chooseRangeMinDistanceDic[blockId] = range
				end
			end
		end
	end

	return list
end

---获取矩形扩散范围
---@param block BattleBlock 格子
---@param distance integer 效果距离
---@return table list 格子id列表
function BattleMap:getRectangularDiffuseRange(block, distance, sourceBlock, lap)
	lap = lap or 0
	distance = math.max(distance or 0, 0)
	if not block then
		return {}
	end

	local list = {}
	local minRow = self.minRows - 1
	local maxRow = self.minRows - 1 + self.maxRows - 1
	local minCol = self.minCols - 1
	local maxCol = self.minCols - 1 + self.maxCols - 1
	local startRow = math.max(minRow, block.row - distance)
	local endRow = math.min(maxRow, block.row + distance)
	local startCol = math.max(minCol, block.col - distance)
	local endCol = math.min(maxCol, block.col + distance)

	for row = startRow, endRow do
		for col = startCol, endCol do
			local blockId = self:getBlockId(col, row)
			if blockId > 0 then
				local blockData = {
					blockId = blockId,
					lap = lap + math.max(math.abs(row - block.row), math.abs(col - block.col))
				}
				list[#list + 1] = blockData
				if (sourceBlock and (not self._chooseRangeMinDistanceDic[blockId] or distance < self._chooseRangeMinDistanceDic[blockId])) then
					self.chooseRangeSourceBlockDic[blockId] = sourceBlock
					self._chooseRangeMinDistanceDic[blockId] = distance
				end
			end
		end
	end

	return list
end

---获取方向扩散范围
---@param sourceBlock BattleBlock 来源格子
---@param dirBlock BattleBlock 方向格子
---@param effectRange table 扩散范围数据
---@return BlockData[] list 格子id列表
function BattleMap:getDirectionDiffuseRange(sourceBlock, dirBlock, effectRange, lap)
	if (not lap) then
		lap = 0
	end
	local blockId = dirBlock.id

	local list = {}
	local rows = (effectRange[1] - 1) / 2
	local isHorizontal = sourceBlock.row == dirBlock.row
	local dirOffset = 0
	if (isHorizontal) then
		dirOffset = dirBlock.col - sourceBlock.col
	else
		dirOffset = dirBlock.row - sourceBlock.row
	end

	local range = effectRange[2] - 1
	local nextLap = lap + 1
	self:_checkDirectionDiffuseRange(range, blockId, isHorizontal, dirOffset, list, nextLap)
	for i = 1, rows do
		if (isHorizontal) then
			if (dirBlock.row < self.minRows + self.maxRows - 2) then
				local nextBlockId = self:getBlockId(dirBlock.col, dirBlock.row + 1)
				self:_checkDirectionDiffuseRange(range, nextBlockId, isHorizontal, dirOffset, list, nextLap)
			end

			if (dirBlock.row >= self.minRows) then
				local nextBlockId = self:getBlockId(dirBlock.col, dirBlock.row - 1)
				self:_checkDirectionDiffuseRange(range, nextBlockId, isHorizontal, dirOffset, list, nextLap)
			end
		else
			if (dirBlock.col >= self.minCols) then
				local nextBlockId = self:getBlockId(dirBlock.col - 1, dirBlock.row)
				self:_checkDirectionDiffuseRange(range, nextBlockId, isHorizontal, dirOffset, list, nextLap)
			end

			if (dirBlock.col < self.minCols + self.maxCols - 2) then
				local nextBlockId = self:getBlockId(dirBlock.col + 1, dirBlock.row)
				self:_checkDirectionDiffuseRange(range, nextBlockId, isHorizontal, dirOffset, list, nextLap)
			end
		end
	end

	return list
end

function BattleMap:_checkDirectionDiffuseRange(distance, blockId, isHorizontal, dirOffset, list, lap)
	local block = self:getBlockById(blockId)
	if (not block) then
		return
	end

	distance = distance - 1
	-- local tData = self.terrainData[block.terrain]

	-- if (not tablex.contains(list, blockId)) then-- and tData.obstruct < 99) then
	if (not tablex.any(list, function(i) return i.blockId == blockId end)) then
		local blockData = {
			blockId = blockId,
			lap = lap
		}
		table.insert(list, blockData)
	end

	if (distance >= 0) then
		local nextLap = lap + 1
		if (isHorizontal) then
			local nextCol = block.col + dirOffset
			if (nextCol >= self.minCols - 1 and nextCol < self.minCols - 1 + self.maxCols) then
				local nextBlockId = self:getBlockId(nextCol, block.row)
				self:_checkDirectionDiffuseRange(distance, nextBlockId, isHorizontal, dirOffset, list, nextLap)
			end
		else
			local nextRow = block.row + dirOffset
			if (nextRow >= self.minRows - 1 and nextRow < self.minRows - 1 + self.maxRows) then
				local nextBlockId = self:getBlockId(block.col, block.row + dirOffset)
				self:_checkDirectionDiffuseRange(distance, nextBlockId, isHorizontal, dirOffset, list, nextLap)
			end
		end
	end
end

---@param sourceBlock BattleBlock
---@param lapNum integer
---@return BlockData[]
function BattleMap:getAllMapBlock(sourceBlock, lapNum)
	---@type BlockData[]
	local result = {}
	local blockList = self:getBlocks()
    for i, v in ipairs(blockList) do
        local blockId = v.id
        local blockData = {
            blockId = blockId,
            lap = lapNum
        }
		result[i] = blockData
        self.chooseRangeSourceBlockDic[blockId] = sourceBlock
	end

	return result
end

---@param block BattleBlock
---@param moveType integer
---@param offsetCostDic table<integer, integer>? 移动消耗偏移值
---@param moveRoleBlockId integer? 移动角色所在格子id，用于计算光环效果时排除自身
---@return integer
function BattleMap:getBlockMoveCost(block, moveType, offsetCostDic, moveRoleBlockId)
	local offset = 0
    local terrainId = block.terrain
    local tData = block.terrainCfgData
    if offsetCostDic then
        offset = offsetCostDic[terrainId] or 0
    end
	-- ---@type table<integer, integer>
	-- local blockOffsetCostDic = {}
	if moveRoleBlockId then
		local effectIdList = block:getEffectGroup()
		if next(effectIdList) then
			local battleMgr = BattleCore:getBattleMgr()
			local skillMgr = battleMgr:getSkillManager()
			local roleMgr = battleMgr:getRoleManager()
			local affixHandler = skillMgr:getSkillAffixHandler()
			for effectId, effectData in pairs(effectIdList) do
				for _, roleId in ipairs(effectData) do
					local triggerConfig = Config.GetEffectTriggerInfo(effectId)
					if triggerConfig then
						local triggerType = triggerConfig.triggerType
						if triggerType and triggerType == 1 then
							local source = roleMgr:getRole(roleId)
							if source then
								local targets = {
									[1] = moveRoleBlockId
								}
								local result = skillMgr:checkEffect(effectId, source, targets, nil, true)
								if next(result) then
									for _, value in ipairs(result) do
										local affixConfig = value.effectConfig
										if value.target and affixConfig.effectAttriType == GE.SkillAffixType.BlockMoveCostChange then
											if not (affixHandler:_checkAffixImmune(value.target, affixConfig.immuneType)) then
												local param1 = affixConfig.otherParam1
												local offsetCost = param1[moveType]
												if offsetCost then
													return offsetCost
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
    local moveCost = tData.moveCost[moveType] + offset
	moveCost = math.max(moveCost, 1)
	return moveCost
end

---根据起始格子及行列数选中范围
---@param blockCid integer 起始格子cid
---@param row integer 行
---@param col integer 列
---@return integer[] list 格子id列表
function BattleMap:selectRangeByBlockIdAndTrain(blockCid, row, col)
    local idList = {}
	local block = self:getBlockByCid(blockCid)
	if (not block) then
        return idList
	end
	local blockCol = block.col
	local blockRow = block.row
	local row1 = row - 1
	local col1 = col - 1
	
	for i = 0, row1 do
		for j = 0, col1 do
			local newCol = blockCol + i
			local newRow = blockRow + j
			local newId = self:getBlockId(newCol, newRow)
			if newId >= 0 then
				table.insert(idList, newId)
			end
		end
	end
	return idList
end

---设置被光环影响的地格
---@param roleId integer
---@param blockIdList integer[]
---@param effectGroup integer[]
function BattleMap:setBlockEffectGroup(roleId, effectId, blockIdList, effectGroup)
	if self._hasEffectBlockList[roleId] == nil then
		self._hasEffectBlockList[roleId] = {}
	end
    local roleEffectData = self._hasEffectBlockList[roleId]
	if not roleEffectData[effectId] then
        roleEffectData[effectId] = {}
	end
    local effectData = roleEffectData[effectId]
	for _, blockId in ipairs(blockIdList) do
		local block = self:getBlockById(blockId)
		block:setEffectGroup(effectGroup, roleId)
        effectData[blockId] = effectGroup
	end
end

---取消当前角色的当前effectId光环地格效果
---@param roleId integer
---@param effectId integer
function BattleMap:removeBlockEffectGroup(roleId, effectId)
    local roleEffectData = self._hasEffectBlockList[roleId]
	if roleEffectData then
        local blockIdList = roleEffectData[effectId]
        if blockIdList then
			local checkList = {}
			for blockId, _ in pairs(blockIdList) do
				checkList[#checkList + 1] = blockId
			end
			table.sort(checkList, function(a, b)
				return a < b
			end)
            for _, blockId in ipairs(checkList) do
                local effectGroup = blockIdList[blockId]
                local block = self:getBlockById(blockId)
                block:removeEffectGroup(effectGroup, roleId)
            end
        end
        roleEffectData[effectId] = nil
	end
end

---取消当前角色的所有光环地格效果
---@param roleId integer
---@param expectRole boolean? 是否排除当前角色
function BattleMap:removeAllBlockEffectGroupByRoleId(roleId, expectRole)
    local roleEffectData = self._hasEffectBlockList[roleId]
    if roleEffectData then
		local effectCheckList = {}
		for effectId, _ in pairs(roleEffectData) do
			effectCheckList[#effectCheckList + 1] = effectId
		end
		table.sort(effectCheckList, function(a, b)
			return a < b
		end)
        for _, effectId in ipairs(effectCheckList) do
            local blockIdList = roleEffectData[effectId]
            local checkList = {}
            for blockId, _ in pairs(blockIdList) do
                checkList[#checkList + 1] = blockId
            end
            table.sort(checkList, function(a, b)
                return a < b
            end)
            for _, blockId in ipairs(checkList) do
                local effectGroup = blockIdList[blockId]
                local block = self:getBlockById(blockId)
				if block then
                	block:removeEffectGroup(effectGroup, roleId, expectRole)
				end
            end
		end
        self._hasEffectBlockList[roleId] = nil
    end
end

---格子存在角色时返回一个附近的格子
---@param blockCid integer
function BattleMap:getNoOneBlock(blockCid)
	local targetBlock = nil
	local noOneBlocks = {}
	for _, block in pairs(self.blocks) do
		if (not block.roleId) and (block.cid == blockCid) then
			return block
		end
		if not (block.roleId) then
			table.insert(noOneBlocks, block)
		end
		if (block.cid == blockCid) then
			targetBlock = block
		end
	end

	if not targetBlock then
		return nil
	end

	local distanceList = {}
	for _, block in pairs(noOneBlocks) do
		local distance = self:getDistance(targetBlock, block)
		table.insert(distanceList, {
			id = block.id,
			distance = distance,
		})
	end

	table.sort(distanceList, function(a, b)
        return a.distance < b.distance
    end)

	local blockId = distanceList[1].id
	return self:getBlockById(blockId)
end

---获取到最近的没有角色占据的格子
---@param checkBlock BattleBlock
---@param moveType integer 移动类型
---@param maxCheckNum integer? 当前最大的十字扩散的次数
---@return BattleBlock|nil
function BattleMap:getNearsetNoOneBlockByBlock(checkBlock, moveType, maxCheckNum)
	if checkBlock:getTmpRoleId() == nil then
		return checkBlock
	end
	local checkNnum = maxCheckNum
	if not checkNnum then
		local colNum = self.maxCols
		local rowNum = self.maxRows
		checkNnum = math.max(rowNum, colNum)
	end
	for i = 1, checkNnum, 1 do
		local deleteRange = i - 1
		local blockList = self:getNormalDiffuseRange(checkBlock, i, nil, 0, deleteRange)
		for _, blockData in ipairs(blockList) do
			local block = self:getBlockById(blockData.blockId)
			if block then
				local moveCost = self:getBlockMoveCost(block, moveType)
				if moveCost < 99 and block:getTmpRoleId() == nil then
					return block
				end
			end
		end
	end
end

---获取到最近的没有敌方占据的格子(AI用)
---@param checkBlock BattleBlock
---@param role BattleRole
---@param moveList table<integer, BlockData> 移动范围列表
---@param maxCheckNum integer? 当前最大的十字扩散的次数
---@return BattleBlock?
function BattleMap:getNearsetNoEnemyBlockByBlock(checkBlock, role, moveList, maxCheckNum)
	if checkBlock:getTmpRoleId() == nil then
		return checkBlock
	end
	local moveType = role.moveType
	local checkNnum = maxCheckNum
	if not checkNnum then
		local colNum = self.maxCols
		local rowNum = self.maxRows
		checkNnum = math.max(rowNum, colNum)
	end
	local roleMgr = BattleCore:getBattleMgr():getRoleManager()
	local sourceBlock = role:getShowBlock()
	local moveRangeKV = role:getRoleKVMoveRange()
	local offsetCostDic = role:getMoveCostOffset()

	for i = 1, checkNnum, 1 do
		---@type BattleBlock[]
		local r = {}
		local deleteRange = i - 1
		local blockList = self:getNormalDiffuseRange(checkBlock, i, nil, 0, deleteRange)
		for _, blockData in ipairs(blockList) do
			local block = self:getBlockById(blockData.blockId)
			if block then
				local moveCost = self:getBlockMoveCost(block, moveType)
				local blockRole = block:tryGetRole()
				if moveCost < 99 and (blockRole == nil or not roleMgr:isEnemyCamp(role, blockRole)) then
					table.insert(r, block)
				end
			end
		end
		if next(r) then
			local minLengthblock = nil
			local minLength = math.huge
			local canMoveBlockLength = 0
			for _, block in ipairs(r) do
				local path = self:getAStarPath(sourceBlock.id, block.id, moveList, moveType, moveRangeKV, offsetCostDic)
				local pathCount = #path
				if path and pathCount <= minLength then
					if pathCount < minLength then
						minLength = pathCount
						canMoveBlockLength = 0
					end
					local pathCanMoveLength = 0
					for _, value in ipairs(path) do
						if moveRangeKV[value] then
							pathCanMoveLength = pathCanMoveLength + 1
						end
					end
					if pathCanMoveLength > canMoveBlockLength then
						canMoveBlockLength = pathCanMoveLength
						minLengthblock = block
					end
				end
			end
			return minLengthblock
		end
	end
end

---A*寻路节点
---@class AStarNode
---@field blockId integer 地块ID
---@field gCost integer 从起点到当前节点的代价
---@field hCost integer 从当前节点到终点的预估代价
---@field fCost integer 总代价 (gCost + hCost)
---@field parent AStarNode? 父节点
---@field block BattleBlock 地块对象

---A*寻路核心算法
---@param startBlockId integer 起点地块ID
---@param targetBlockId integer 目标地块ID
---@param moveRangeKV table<integer, BlockData> 移动范围字典
---@param moveType integer? 移动类型
---@param curRoundMoveRangeKV table<integer, BlockData>? 当前回合的移动范围字典
---@param moveCostOffset table<integer, integer>? 移动消耗偏移值
---@return integer[] path 路径数组
function BattleMap:getAStarPath(startBlockId, targetBlockId, moveRangeKV, moveType, curRoundMoveRangeKV, moveCostOffset)
    if startBlockId == targetBlockId then
        return {startBlockId}
    end

    local startBlock = self:getBlockById(startBlockId)
    local targetBlock = self:getBlockById(targetBlockId)
    if not startBlock or not targetBlock then
        return {}
    end

    ---@type AStarNode[]
    local openList = {}
    ---@type table<integer, AStarNode>
    local openSet = {}
    ---@type table<integer, boolean>
    local closedSet = {}

    -- 创建起始节点
    local startNode = self:createAStarNode(startBlock, nil, 0, targetBlock)
	openList[#openList + 1] = startNode
    openSet[startBlockId] = startNode

    while #openList > 0 do
        -- 找到F值最小的节点
        local currentNode = self:getLowestFCostNode(openList)
        local currentIndex = self:findNodeIndex(openList, currentNode)

        -- 从开放列表中移除当前节点
        table.remove(openList, currentIndex)
        openSet[currentNode.blockId] = nil
        closedSet[currentNode.blockId] = true

        -- 如果到达目标
        if currentNode.blockId == targetBlockId then
            return self:reconstructPath(currentNode)
        end

        -- 检查邻居节点
        local neighbors = self:getAStarNeighbors(currentNode.block, moveRangeKV)
        for _, neighborBlock in ipairs(neighbors) do
            local neighborId = neighborBlock.id

            if not closedSet[neighborId] then
                local moveCost = self:getAStarMoveCost(neighborBlock, moveType, moveCostOffset, startBlockId)
				local moveCostOffset = 0
				---不在当前移动范围内，增加移动代价
				if curRoundMoveRangeKV then
					moveCostOffset = curRoundMoveRangeKV[neighborId] and 0 or 99
				end
				local tmpRoleId = neighborBlock:getTmpRoleId()
				if tmpRoleId then
					moveCostOffset = moveCostOffset + 20
				end
				
                local tentativeGCost = currentNode.gCost + moveCost + moveCostOffset

                local neighborNode = openSet[neighborId]
                if not neighborNode then
                    -- 创建新节点
                    neighborNode = self:createAStarNode(neighborBlock, currentNode, tentativeGCost, targetBlock)
                    openList[#openList + 1] = neighborNode
                    openSet[neighborId] = neighborNode
                elseif tentativeGCost < neighborNode.gCost then
                    -- 找到更好的路径
                    neighborNode.parent = currentNode
                    neighborNode.gCost = tentativeGCost
                    neighborNode.fCost = neighborNode.gCost + neighborNode.hCost
                end
            end
        end
    end

    return {} -- 无法找到路径
end

---创建A*节点
---@param block BattleBlock 地块
---@param parent AStarNode? 父节点
---@param gCost integer G代价
---@param targetBlock BattleBlock 目标地块
---@return AStarNode node 新创建的节点
function BattleMap:createAStarNode(block, parent, gCost, targetBlock)
    local hCost = self:checkDistanceBetweenTwoBlock(block, targetBlock)
    ---@type AStarNode
    local node = {
        blockId = block.id,
        gCost = gCost,
        hCost = hCost,
        fCost = gCost + hCost,
        parent = parent,
        block = block
    }
    return node
end

---获取F值最小的节点
---@param openList AStarNode[] 开放列表
---@return AStarNode node F值最小的节点
function BattleMap:getLowestFCostNode(openList)
    local lowestNode = openList[1]
    for _, node in ipairs(openList) do
        if node.fCost < lowestNode.fCost or 
           (node.fCost == lowestNode.fCost and node.hCost < lowestNode.hCost) then
            lowestNode = node
        end
    end
    return lowestNode
end

---在列表中找到节点的索引
---@param nodeList AStarNode[] 节点列表
---@param targetNode AStarNode 目标节点
---@return integer index 节点索引
function BattleMap:findNodeIndex(nodeList, targetNode)
    for i, node in ipairs(nodeList) do
        if node.blockId == targetNode.blockId then
            return i
        end
    end
    return -1
end

---获取A*算法中的邻居节点
---@param block BattleBlock 当前地块
---@param moveRangeKV table<integer, BlockData> 移动范围字典
---@return BattleBlock[] neighbors 邻居地块列表
function BattleMap:getAStarNeighbors(block, moveRangeKV)
	---@type BattleBlock[]
    local neighbors = {}

    for _, dir in ipairs(self._directions) do
        local nextRow = block.row + dir[1]
        local nextCol = block.col + dir[2]
        local nextBlockId = self:getBlockId(nextCol, nextRow)

        if nextBlockId > 0 and moveRangeKV[nextBlockId] then
            local nextBlock = self:getBlockById(nextBlockId)
            if nextBlock then
                table.insert(neighbors, nextBlock)
            end
        end
    end

    return neighbors
end

---获取A*算法中的移动代价
---@param toBlock BattleBlock 目标地块
---@param moveType integer? 移动类型
---@param offsetCostDic table<integer, integer>? 移动消耗偏移值
---@param moveRoleBlockId integer? 移动角色所在格子id
---@return integer cost 移动代价
function BattleMap:getAStarMoveCost(toBlock, moveType, offsetCostDic, moveRoleBlockId)
    if moveType then
        return self:getBlockMoveCost(toBlock, moveType, offsetCostDic, moveRoleBlockId)
    else
        -- 默认移动代价为1
        return 1
    end
end

---重构路径
---@param endNode AStarNode 终点节点
---@return integer[] path 路径数组
function BattleMap:reconstructPath(endNode)
    local path = {}
    local currentNode = endNode

    while currentNode do
        table.insert(path, 1, currentNode.blockId)
        currentNode = currentNode.parent
    end

    return path
end

---获取起始格子到终点格子的直线格子列表
---@param startBlock BattleBlock
---@param endBlock BattleBlock
---@return BattleBlock[]
function BattleMap:GetCalculateLine(startBlock, endBlock)
	local blockList = {}
	local x1, y1 = startBlock.col, startBlock.row
	local x2, y2 = endBlock.col, endBlock.row

	local dx = x2 - x1
	local dy = y2 - y1

	local absDx = math.abs(dx)
	local absDy = math.abs(dy)
	if absDx > absDy then
		local sx = dx > 0 and 1 or -1
		local sy = dx ~= 0 and dy/absDx or 0
		for i = 1, absDx + 1 do
			local curBlock = self:getBlock(x1, math.roundNum(y1, 0.5))
			blockList[i] = curBlock
			x1 = x1 + sx
			y1 = y1 + sy
		end
	else
		local sy = dy > 0 and 1 or -1
		local sx = dy ~= 0 and dx/absDy or 0
		for i = 1, absDy + 1 do
			local curBlock = self:getBlock(math.roundNum(x1, 0.5), y1)
			blockList[i] = curBlock
			x1 = x1 + sx
			y1 = y1 + sy
		end
	end

	return blockList
end

return BattleMap
