module("fight.Move_1", Class.impl())

function setData(self,cusVo)
	self.m_l_vo = cusVo
	self.m_moveTime = 0
	self.m_moveTotalTime = 0
end

function dtor(self)
	self:clearResetTimer()
	self:clearStepTimer()
end

function moveTo(self,cusTile)
	if cusTile == nil then
		return
	end

	if self.m_targetTile ~= nil and cusTile == self.m_targetTile then
		return
	end

	if self.m_l_vo.position:equals(fight.SceneUtil.tileToPosition(cusTile)) then
		return
	end

	self:clearResetTimer()

	self.m_targetTile = cusTile:clone()
	if not table.empty(self.m_path) then
		for _,v in ipairs(self.m_path) do
			fight.FindPath:poolTileRecover(v)
		end
	end
	self.m_path = fight.FindPath:find(self.m_l_vo:tile(),cusTile,self.m_l_vo.id)

	if self.m_path == nil then
		print("no path",self.m_l_vo.id)
		self.m_resetTimer = fight.LiveLooper:setTimeout(self.m_l_vo.id, 0.3,self,self.reset)
		return
	end

	self.m_l_vo:setMovePath(self.m_path)
	self:moveNext()
end

function moveNext(self)
	local nextTile = self.m_path[1]
	local nextPos = fight.SceneUtil.tileToPosition(nextTile)

	if self.m_nextPos == nil then
		self:clearStepTimer()
		self.m_stepTimer = fight.LiveLooper:addFrame(self.m_l_vo.id, 1,0,self,self.step)
	end

	self.m_nextPos = nextPos
	self.m_currPos = self.m_l_vo.position:clone()
	self.m_moveTotalTime = self.m_nextPos:distance(self.m_l_vo.position) / self.m_l_vo:moveSpeed()
	self.m_moveTime = 0
end

function step(self)
	--判断当前状态能否移动，不能就结束
	-- do something
	--	self:reset()
	--else
		self:updatePosition()
	--end
end

function updatePosition(self)
	local tempMoveTime = math.min(self.m_moveTime + fight.LiveLooper:getDeltaTime(),self.m_moveTotalTime)
	local _nextPos = math.Vector3()

	self.m_currPos:lerp(self.m_nextPos,tempMoveTime/self.m_moveTotalTime,_nextPos)

	local isEmpty , canWait = self:checkCanMove(_nextPos)
	if isEmpty == false then
		if canWait == false then
			self:reset()
		end
		return
	end

	self.m_moveTime = tempMoveTime

	if self.m_moveTotalTime == self.m_moveTime then
		if self.m_path ~= nil and #self.m_path > 1 then
			self.m_l_vo:updatePosition(_nextPos,fight.MoveType.MOVE)
			fight.FindPath:poolTileRecover(self.m_path[1])
			table.remove( self.m_path,1 )
			self:moveNext()
		else
			self.m_l_vo:updatePosition(_nextPos,fight.MoveType.MOVE)
			self:reset()
		end
	else
		self.m_l_vo:updatePosition(_nextPos,fight.MoveType.MOVE)
	end
end

function checkCanMove(self,cusNextPos)
	local nextTile = fight.SceneUtil.positionToTile(cusNextPos)
	return fight.SceneManager:isEmptyTile(nextTile,self.m_l_vo.id)
end

function clearResetTimer(self)
	if self.m_resetTimer then
		fight.LiveLooper:removeTimerByIndex(self.m_resetTimer)
		self.m_resetTimer = nil
	end
end

function clearStepTimer(self)
	if self.m_stepTimer then
		fight.LiveLooper:removeFrameByIndex(self.m_stepTimer)
		self.m_stepTimer = nil
	end
end

function reset(self)
	self.m_targetTile = nil
	self.m_nextPos = nil
	self.m_currPos = nil
	self.m_moveTotalTime = 0
	self.m_moveTime = 0
	self:clearResetTimer()
	self.m_l_vo:stopMove(nil)
	self:clearStepTimer()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
