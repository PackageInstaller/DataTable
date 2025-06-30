module("fight.Move_4", Class.impl())

function ctor( self )
	self.m_finishCall = nil
	self.m_speed = 0
	self.m_targetPos = nil
end

function setData(self,cusVo)
	self.m_l_vo = cusVo
end

function dtor(self)
end

-- speedTime : 速度倍数
function moveTo(self, position, call, duration)
	local curPos = self.m_l_vo:getCurPos()
	self.m_finishCall = call
	if curPos:equals(position) then
		if self.m_finishCall then
			self.m_finishCall()
			self.m_finishCall = nil
		end
		return false
	end
	self.m_targetPos = position
	local curDist = math.v3Distance(curPos, position)
	self.m_speed = (self.m_targetPos-curPos):normalize()*(curDist/duration)
	self:clearStepTimer()
	self.m_stepTimer = fight.LiveLooper:addFrame(self.m_l_vo.id, 1,0, self,self.step)
	return true
end

function step(self, deltaTime)
	local curPos = self.m_l_vo:getCurPos()
	-- local moveVector = curPos+(self.m_targetPos-curPos):normalize()*self.m_speed*deltaTime
	local moveVector = curPos+self.m_speed*deltaTime
	local curDist = math.v3Distance(curPos, self.m_targetPos)
	local newDist = math.v3Distance(moveVector, self.m_targetPos)

	if newDist<0.2 or newDist>curDist then -- 第二个情况有可能是跳帧导致
		self:clearStepTimer()
		self.m_l_vo:updatePosition(self.m_targetPos)
		if self.m_finishCall then
			self.m_finishCall()
			self.m_finishCall = nil
		end
	else
		-- print("step===", curPos, moveVector, self.m_speed, deltaTime, newDist, curDist)
		self.m_l_vo:updatePosition(moveVector)
	end
end

function clearStepTimer(self)
	if self.m_stepTimer then
		fight.LiveLooper:removeFrameByIndex(self.m_stepTimer)
		self.m_stepTimer = nil
	end
end

function reset(self)
	self:clearStepTimer()
	self.m_l_vo:stopMove(nil)
	if self.m_finishCall then
		self.m_finishCall()
		self.m_finishCall = nil
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
