--[[
****************************************************************************
Brief  :SkillBullet 子弹类技能轨迹
Author :James Ou
Date   :2020-03-10
****************************************************************************
]]
module("SkillBullet", Class.impl(STravelBase))
-------------------------------
function ctor(self)
	super.ctor(self)
	-- 移动速度 (应该由读取传入)
	self.m_moveSpeed = 12
	-- 速度系数
	self.m_speedRatio = nil
	self.m_targetPos = nil
end

function setMoveTime( self, useTime )
	self.m_moveTime = useTime
end

function setMoveSpeed( self, speed )
	if speed and speed>0 then
		self.m_moveSpeed = speed
	end
end

function start(self)
	super.start(self)
	local curV3 = self:getStartPointPos()
	self:setCurPos(curV3)
	STravelHandle:perfHandle(self, STravelDef.PERF_START)
	STravelHandle:perfHandle(self, STravelDef.PERF_POS, curV3)
	local tPos = self:getEndPointPos()
	self.m_targetPos = math.Vector3(tPos.x, tPos.y, tPos.z)

	local totalDist = math.v3Distance(curV3, self.m_targetPos)
	self.m_moveSpeed = totalDist/self.m_moveTime

	self.m_speedRatio = (self.m_targetPos-curV3):normalize()*self.m_moveSpeed
	STravelHandle:perfHandle(self, STravelDef.PERF_LOOKAT, self.m_targetPos)
end

-- 更新 具体由子类实现
function updateTravel(self, deltaTime)
	-- 说明update有效
	if super.updateTravel(self,deltaTime) then
		local curV3 = self:getCurPos()
		local curDist = math.v3Distance(self.m_targetPos, curV3);
		-- local moveVector = curV3+(self.m_targetPos-curV3):normalize()*self.m_moveSpeed*deltaTime
		local moveVector = curV3+self.m_speedRatio*deltaTime
		-- local moveVector = curV3:add((v3-curV3):normalize():scale(self.m_moveSpeed*deltaTime))
		local newDist = math.v3Distance(self.m_targetPos, moveVector)

		if newDist<0.2 or newDist>curDist then -- 第二个情况有可能是跳帧导致
			self:setCurPos(self.m_targetPos)
			STravelHandle:perfHandle(self, STravelDef.PERF_POS, self.m_targetPos)
			local targetLiveVo = self:getTargetVo()
			if targetLiveVo and self:isVoNearV3(targetLiveVo, self.m_targetPos) then
				self:onHitTargetIds(self.m_targetID)
			else
				self:onArrive()
			end
			self:onEnd()
			return
		end

		self:setCurPos(moveVector)
		STravelHandle:perfHandle(self, STravelDef.PERF_POS, moveVector)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
