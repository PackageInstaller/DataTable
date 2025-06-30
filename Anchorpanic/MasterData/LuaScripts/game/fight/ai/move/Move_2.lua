module("fight.Move_2", Class.impl())

function ctor( self )
	self.m_moveSpeed = 5
	self.m_jumpTimer = 0
	self.m_finishCall = nil
end

function setData(self,cusVo)
	self.m_l_vo = cusVo
	self.m_jumpTimer = 0
end

function dtor(self)
	self:clearStepTimer()
end

function _bezier(self, p0, p1, p2, t)
	local p0p1 = p0:scale(1-t) + p1:scale(t)
	local p1p2 = p1:scale(1-t) + p2:scale(t)
	return p0p1:scale(1-t) + p1p2:scale(t)
end
-- speedTime : 速度倍数
function moveTo(self, position, call, speedTime)
	if self.m_l_vo.position:equals(position) then
		return false
	end
	self.m_finishCall = call
	self.m_posStart = self.m_l_vo.position:clone()
	self.m_posEnd = position:clone()
	local curDist = math.v3Distance(self.m_posStart, self.m_posEnd)
	self.m_posBezier = self.m_posStart+(self.m_posEnd-self.m_posStart):normalize()*curDist*0.6
	self.m_posBezier.y = self.m_posBezier.y+1.2
	local speed = self.m_moveSpeed*RateLooper:getPlayRate()
	if speedTime then
		speed = speed*speedTime
	end
	self.m_totalTime = (math.v3Distance(self.m_posStart, self.m_posBezier)+math.v3Distance(self.m_posBezier, self.m_posEnd))/speed
	self:clearStepTimer()
	self.m_stepTimer = fight.LiveLooper:addFrame(self.m_l_vo.id, 1,0,self,self.step)
	-- print("moveTo===============================", self.m_posStart, self.m_totalTime, self.m_posBezier)
	return true
end

function step(self, deltaTime)
	-- 说明update有效
	if self.m_posBezier then
		self.m_jumpTimer = self.m_jumpTimer+self.m_moveSpeed*RateLooper:getPlayRate() * deltaTime
		if self.m_jumpTimer>self.m_totalTime then
			self.m_jumpTimer = 0
		end
		
		local moveVector = self:_bezier(self.m_posStart:clone(), self.m_posBezier:clone(), self.m_posEnd:clone(), self.m_jumpTimer/self.m_totalTime)
		if moveVector.y<=self.m_posStart.y then
			self.m_l_vo:updatePosition(self.m_posEnd)
			self:reset()
			return
		end
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
