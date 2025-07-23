--[[
****************************************************************************
Brief  :STravelArrow 弓箭类技能特效轨迹
Author :James Ou
Date   :2020-03-11
****************************************************************************
]]
module("STravelArrow", Class.impl(STravelBase))
-------------------------------
function ctor(self)
	super.ctor(self)

	-- 移动速度
	self.m_posStart = nil
	self.m_posEnd = nil
	self.m_posBezier = nil
	self.m_moveSpeed = 5
	self.m_height = 4
	self.m_totalTime = 0
	self.m_jumpTimer = 0


	-- 范围半径
	self.m_radius = 4
	self.m_radiusSqrt = self.m_radius*self.m_radius

	self.m_tmpVec3_1 = math.Vector3()
	self.m_tmpVec3_2 = math.Vector3()
	self.m_tmpVec3_3 = math.Vector3()
end


function setMoveTime( self, moveTime, height )
	self.m_totalTime = moveTime
	self.m_height = height
end

function setMoveSpeed( self, speed, height )
	if speed and speed>0 then
		self.m_moveSpeed = speed
	end
	self.m_height = height
end

function _bezier(self, p0, p1, p2, t)
	p0:scale(1-t, self.m_tmpVec3_1)
	p1:scale(t, self.m_tmpVec3_2)
	self.m_tmpVec3_1:add(self.m_tmpVec3_2)

	p1:scale(1-t,self.m_tmpVec3_2)
	p2:scale(t, self.m_tmpVec3_3)
	self.m_tmpVec3_2:add(self.m_tmpVec3_3)

	self.m_tmpVec3_1:scale(1-t, self.m_tmpVec3_1)
	self.m_tmpVec3_2:scale(t,self.m_tmpVec3_2)
	return self.m_tmpVec3_1+self.m_tmpVec3_2
	-- local p0p1 = p0:scale(1-t) + p1:scale(t)
	-- local p1p2 = p1:scale(1-t) + p2:scale(t)
	-- return p0p1:scale(1-t) + p1p2:scale(t)
end


function start(self)
	super.start(self)
	local curV3 = self:getStartPointPos()
	self:setCurPos(curV3)
	STravelHandle:perfHandle(self, STravelDef.PERF_START)
	STravelHandle:perfHandle(self, STravelDef.PERF_POS, curV3)

	self.m_posStart = curV3:clone()
	local tPos = self:getEndPointPos()
	self.m_posEnd = math.Vector3(tPos.x, tPos.y, tPos.z)

	local curDist = math.v3Distance(self.m_posStart, self.m_posEnd)
	self.m_posBezier = curV3+(self.m_posEnd-curV3):normalize()*curDist*0.6
	self.m_posBezier.y = self.m_posBezier.y+self.m_height

	-- self.m_totalTime = (math.v3Distance(self.m_posStart, self.m_posBezier)+math.v3Distance(self.m_posBezier, self.m_posEnd))/self.m_moveSpeed
	self.m_moveSpeed = (math.v3Distance(self.m_posStart, self.m_posBezier)+math.v3Distance(self.m_posBezier, self.m_posEnd))/self.m_totalTime
end

-- 更新 具体由子类实现
function updateTravel(self, deltaTime)
	-- 说明update有效
	if super.updateTravel(self,deltaTime) and self.m_posBezier then
		self.m_jumpTimer = self.m_jumpTimer+self.m_moveSpeed * deltaTime
		if self.m_jumpTimer>self.m_totalTime then
			self.m_jumpTimer = 0
		end
		
		-- local moveVector = self:_bezier(self.m_posStart:clone(), self.m_posBezier:clone(), self.m_posEnd:clone(), self.m_jumpTimer/self.m_totalTime)
		local moveVector = self:_bezier(self.m_posStart, self.m_posBezier, self.m_posEnd, self.m_jumpTimer/self.m_totalTime)
        STravelHandle:perfHandle(self, STravelDef.PERF_LOOKAT, moveVector)
		
		local targetLiveVo = self:getTargetVo()
		-- -- 是追踪的情况
		-- if self.m_isTrack and targetLiveVo then --这里应该获取targetID对应的实体
		-- 	STravelHandle:perfHandle(self, STravelDef.PERF_LOOKAT, v3)
		-- end
		if moveVector.y<=self.m_posStart.y then
			self:setCurPos(self.m_posEnd)
			STravelHandle:perfHandle(self, STravelDef.PERF_POS, self.m_posEnd)
			if targetLiveVo and self:isVoNearV3(targetLiveVo, self.m_posEnd) then
				self:onHitTargetIds(self.m_targetID)
			else
				self:onArrive()
			end
			self:onEnd()
			return
		end
		self:setCurPos(moveVector)
		STravelHandle:perfHandle(self, STravelDef.PERF_POS, moveVector)

		-- 检查范围内是否有其它目标
		if self.m_isMoveAtk then
			local otherTarget = self:getRangeTarget()
			if otherTarget then
				self:onHitTargetIds(otherTarget)
				if self.m_isMoveAtkEnd==true then
					self:onEnd()
					return
				end
			end
		end
	end
end

function getRangeTarget( self )
	local curPos = self:getCurPos()
	local targets =  fight.TargetManager:getDiffTeamPeople(self.m_casterID, 1, true, curPos)
	if targets then
		local ids = {}
		for _,vo in pairs(targets) do
			if self.m_radiusSqrt>=math.v3DistanceNoSqrt(curPos, vo:getCurPos()) then
				table.insert(ids, vo.id)
			end
		end
		if not table.empty(ids) then
			return ids
		end
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
