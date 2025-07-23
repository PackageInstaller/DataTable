module("maze.MazePlayerMoveAi", Class.impl())

function ctor(self)
    self.mIsLog = false
	self:__initData()
end

function __print(self, str)
	if(self.mIsLog)then 
		print(str) 
	end
end

function __initData(self)
    self.mAnimaSpeedRate = nil
	self.mMoveSpeedRate = nil
	self.mPathList = nil
	self.mThingVo = nil
	self.mHeroCuteConfigVo = nil
end

function setData(self, cusVo)
    self.mAnimaSpeedRate = nil
	self.mMoveSpeedRate = nil
	self.mPathList = nil
    self.mThingVo = cusVo
	self.mHeroCuteConfigVo = hero.HeroCuteManager:getHeroCuteConfigVo(maze.getPlayerHeroTid())
	
	local function _checkIsCanMove(row, col)
		return maze.MazeSceneManager:checkTileIsCanPass(self.mThingVo:getMazeId(), row, col)
	end
	local function _getCostMultiplier(row, col)
		return maze.MazeSceneManager:getMoveCostMultiplier(self.mThingVo:getMazeId(), row, col)
	end
	
	local mazeConfigVo = self.mThingVo:getMazeConfigVo()
	local mazeSizeW, mazeSizeH = mazeConfigVo:getMapSize()
	maze.MazeAStar:setData(mazeConfigVo:getLayoutType(), mazeSizeW, mazeSizeH, mazeConfigVo:getRowNum(), mazeConfigVo:getColNum(), mazeConfigVo:getTileSideLen(), mazeConfigVo:getTileHalfH(), _checkIsCanMove, _getCostMultiplier)
end

-- 在指定行列格子范围内获取一条可达路径
function getPathList(self, targetTileRow, targetTileCol, range)
	if(targetTileRow == self.mThingVo:getRow() and targetTileCol == self.mThingVo:getCol())then
		print("与当前位置一致，无可达路径")
	else
		local mazeConfigVo = self.mThingVo:getMazeConfigVo()
		local mazeSizeW, mazeSizeH = mazeConfigVo:getMapSize()
		local nearList = maze.getNearRangeList(mazeConfigVo:getLayoutType(), mazeConfigVo:getRowNum(), mazeConfigVo:getColNum(), targetTileRow, targetTileCol, range)
		-- 确定当前点是否已经在目标点范围内
		for i = #nearList, 1, -1 do
			if(self.mThingVo:getRow() == nearList[i].row and self.mThingVo:getCol() == nearList[i].col)then
				local pathList = {}
				table.insert(pathList, maze.MazeAStar:getMapGrid(self.mThingVo:getRow(), self.mThingVo:getCol()))
				table.insert(pathList, maze.MazeAStar:getMapGrid(nearList[i].row, nearList[i].col))
				return pathList
			end
		end
		-- 附近多圈节点优化，按照估值函数从小到大排列
		nearList = maze.MazeAStar:optimizePathList(nearList, self.mThingVo:getRow(), self.mThingVo:getCol())
		for i = 1, #nearList do
			local result, pathList = maze.MazeAStar:findPath(self.mThingVo:getRow(), self.mThingVo:getCol(), nearList[i].row, nearList[i].col)
			if(result)then
				return pathList
			end
		end
		-- 范围内搜索不到，检测指定格子
		local result, pathList = maze.MazeAStar:findPath(self.mThingVo:getRow(), self.mThingVo:getCol(), targetTileRow, targetTileCol)
		if(result)then
			return pathList
		end
	end
	return nil
end

-- 按照路径列表移动
function moveByPathList(self, pathList, speed)
	if(pathList)then
		-- for i=1,#pathList do
		-- 	logAll(maze.MazeSceneManager:getTileIdByRowCol(self.mThingVo:getMazeId(),pathList[i].row,pathList[i].col))
		-- end
		if #pathList > 1 then
			local eventType_1 = maze.MazeSceneManager:getTileEventTypeByRowCol(self.mThingVo:getMazeId(),pathList[1].row, pathList[1].col)
			local eventType_2 = maze.MazeSceneManager:getTileEventTypeByRowCol(self.mThingVo:getMazeId(),pathList[2].row, pathList[2].col)
			if(eventType_1 == maze.EVENT_TYPE_ICE or eventType_1 == maze.EVENT_TYPE_ICE_AND_ONECALL) 
			and (eventType_2 == maze.EVENT_TYPE_ICE or eventType_2 == maze.EVENT_TYPE_ICE_AND_ONECALL) then                -- 冰面事件/一笔画冰面
				self.mMoveSpeedRate = sysParam.SysParamManager:getValue(SysParamType.MAZE_PLAYER_SPEED_RATE_ICE, 1) / 100
				self.mAnimaSpeedRate = 0
			end
		end

		-- 移除第一个本身坐标格子
		table.remove(pathList, 1)
		if(#pathList > 0)then
			if not self.mAnimaSpeedRate then 
				self.mAnimaSpeedRate = maze.getPlayerHeroRate(#pathList)
				self.mAnimaSpeedRate = self.mAnimaSpeedRate
			end

			if not self.mMoveSpeedRate then 
				self.mMoveSpeedRate = maze.getPlayerHeroRate(#pathList)
			end

			self.mPathList = pathList
			self.mThingVo:dispatchEvent(self.mThingVo.PLAYER_FINAL_POS_UPDATE)
			if(self.mThingVo:getIsMoving())then
				self:__print("当前正在移动中，等待移动动画完毕回调")
			else
				self:__print("当前不在移动中，尝试请求移动")
				self:tryRequestMove()
			end
			return true
		end
	end
	return false
end

-- 获取等待移动的路径列表
function getWaitPathList(self)
	return self.mPathList
end

-- 尝试移动至指定行列
function tryMoveToRowCol(self, targetTileRow, targetTileCol, range, moveTime, ease)
	local pathList = self:getPathList(targetTileRow, targetTileCol, range)
	return self:moveByPathList(pathList, moveTime, ease)
end

-- 尝试请求移动
function tryRequestMove(self)
	if(self.mPathList and #self.mPathList > 0)then
		if(not self.mThingVo:getIsMoving())then
			-- GameDispatcher:dispatchEvent(EventName.REQ_CHECK_MAZE_PLAYER_MOVE, {mazeId = self.mThingVo:getMazeId(), tileId = targetTileId})
			self:updateMovePos()
		end
	else
		self:resetMovePos()
	end
end

-- 重置掉移动坐标相关
function resetMovePos(self)
	self.mAnimaSpeedRate = nil
	self.mMoveSpeedRate = nil
	self.mPathList = nil
	self.mThingVo:setIsMoving(false)
	self.mThingVo:dispatchEvent(self.mThingVo.PLAYER_MOVE_END)
	-- self.mThingVo:dispatchEvent(self.mThingVo.PLAYER_MOVE_STOP)
end

-- 校验后端发来的可行动路径点是否为当前路径列表的第一个目标
function checkFirstPathGrid(self, firstRow, firstCol)
	if(self.mPathList)then
		local aStarGrid = self.mPathList[1]
		if(aStarGrid and aStarGrid.row == firstRow and aStarGrid.col == firstCol)then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- 更新坐标
function updateMovePos(self)
	if(self.mPathList and #self.mPathList > 0)then
		-- 校验后端发来的路径点和当前路径数组第一个节点是否一致
		local aStarGrid = table.remove(self.mPathList, 1)
		local targetTileId = maze.MazeSceneManager:getTileIdByRowCol(self.mThingVo:getMazeId(), aStarGrid.row, aStarGrid.col)
		maze.MazeSceneManager:setPlayerTileId(targetTileId)
        self.mThingVo:setTileId(targetTileId)

		self.mThingVo:setIsMoving(true)
		local function finishCall()
			self.mThingVo:setIsMoving(false)

			GameDispatcher:dispatchEvent(EventName.REQ_MAZE_PLAYER_MOVE, {mazeId = self.mThingVo:getMazeId(), tileId = self.mThingVo:getTileId()})
			if not maze.MazeEventExecutor:moveFinishCheckEvent() then
				if not self.mPathList or #self.mPathList < 1 then 
					self:__print("移动完毕回调，派发通知")

					self:resetMovePos()
					self.mThingVo:dispatchEvent(self.mThingVo.PLAYER_MOVE_FINISH)
					GameDispatcher:dispatchEvent(EventName.MAZE_FINISH_FINDPATH)
				else
					self:updateMovePos()
				end
			end
		end
		-- self:__clearTimer()
		-- self.mTimeOutIndex = LoopManager:setTimeout(self.mHeroCuteConfigVo:getMazeOnceMoveTime() * self.mMoveSpeedRate, self, finishCall)
		self.mThingVo:dispatchEvent(self.mThingVo.PLAYER_MOVE_UPDATE, {moveSpeedRate = self.mMoveSpeedRate,animaSpeed = self.mAnimaSpeedRate,callback = finishCall})
	end
end

function __clearTimer(self)
	if self.mTimeOutIndex then
		LoopManager:clearTimeout(self.mTimeOutIndex)
		self.mTimeOutIndex = nil
	end
end

function reset(self)
	self:__clearTimer()
	self:__initData()
	maze.MazeAStar:reset()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
