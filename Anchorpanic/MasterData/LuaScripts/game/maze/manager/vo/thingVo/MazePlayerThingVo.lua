module("maze.MazePlayerThingVo", Class.impl(maze.MazeBaseEventThingVo))

-- 血量更新
PLAYER_HP_UPDATE = "PLAYER_HP_UPDATE"

-- 位置刷新
PLAYER_POS_REFRESH = "PLAYER_POS_REFRESH"

-- 更新终点
PLAYER_FINAL_POS_UPDATE = "PLAYER_FINAL_POS_UPDATE"
-- 更新移动
PLAYER_MOVE_UPDATE = "PLAYER_MOVE_UPDATE"
-- 移动完成
PLAYER_MOVE_FINISH = "PLAYER_MOVE_FINISH"
-- 移动完毕
PLAYER_MOVE_END = "PLAYER_MOVE_END"
--移动中断
PLAYER_MOVE_STOP = "PLAYER_MOVE_STOP"

function onRecover(self)
    super.onRecover(self)
    self:setIsMoving(nil)
    self.mMoveAi:reset()
end

function ctor(self)
    super.ctor(self)
    self.mMoveAi = maze.MazePlayerMoveAi.new()
end

function setData(self, mazeId, tileId)
    super.setData(self, mazeId, tileId)
    self:setIsMoving(false)
    self.mMoveAi:setData(self)
end

function getType(self)
    return maze.THING_TYPE_PLAYER
end

function setSpeed(self,speed)
    self.mMoveAi:setSpeed(speed)
end

function playAction(self, aniHash, startCall, endCall)
    self:getThing():playAction(aniHash, startCall, endCall)
end

function setAngle(self, angle, isNow)
   self:getThing():setAngle(angle, isNow)
end

-- 校验后端发来的可行动路径点是否为当前路径列表的第一个目标
function checkFirstPathGrid(self, firstRow, firstCol)
    return self.mMoveAi:checkFirstPathGrid(firstRow, firstCol)
end

-- 在指定行列格子范围内获取一条可达路径
function getPathList(self, tileRow, tileCol, range)
    return self.mMoveAi:getPathList(tileRow, tileCol, range)
end

-- 按照路径列表移动
function moveByPathList(self, pathList, speed)
    return self.mMoveAi:moveByPathList(pathList, speed)
end

-- 按照路径列表移动(点击寻路用)
function moveByPathListOne(self, pathList, speed)
    local endGrid = pathList[#pathList]
    GameDispatcher:dispatchEvent(EventName.MAZE_START_FINDPATH,{row = endGrid.row, col = endGrid.col})

    return self:moveByPathList(pathList, speed)
end

-- 获取等待移动的路径列表
function getWaitPathList(self)
	return self.mMoveAi:getWaitPathList()
end

-- 尝试移动至指定行列
function tryMoveToRowCol(self, tileRow, tileCol, range, moveTime, ease)
    return self.mMoveAi:tryMoveToRowCol(tileRow, tileCol, range, moveTime, ease)
end

-- 尝试请求移动
function tryRequestMove(self)
    return self.mMoveAi:tryRequestMove()
end

-- 更新移动位置坐标
function updateMovePos(self)
    self.mMoveAi:updateMovePos()
end

-- 重置掉移动坐标
function resetMovePos(self)
    self.mMoveAi:resetMovePos()
end

-- 刷新位置
function refreshPos(self, tweenTime)
    self:dispatchEvent(self.PLAYER_POS_REFRESH, tweenTime)
end

function setIsMoving(self, isMoving)
    self.mIsMoving = isMoving
end

function getIsMoving(self)
    return self.mIsMoving
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
