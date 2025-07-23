--[[
****************************************************************************
Brief  :STravel_10 塞薇娅 主动技能-大招
Author :James Ou
Date   :2020-03-19
****************************************************************************
]]
module("STravel_10", Class.impl(STravelBase))
-------------------------------
function ctor(self)
	super.ctor(self)
	self:setMoveAtkData(true, false)
end

function setSpecialData(self, stayTime, moveSpeed, radius)
	-- 停留的时间
	self.m_stayTime = stayTime
	-- 移动速度
	self.m_moveSpeed = moveSpeed
	-- 范围半径
	self.m_radius = radius
	self.m_radiusSqrt = self.m_radius*self.m_radius
end

function start(self)
	super.start(self)
	self.m_isForward = true
	self.m_isStaying = false
	local liveVo = self:getCasterVo()
	local v3 = liveVo:getCurPos()
	self:setCurPos(v3)
	STravelHandle:perfHandle(self, STravelDef.PERF_START)
	STravelHandle:perfHandle(self, STravelDef.PERF_POS, v3)
	v3 = self:_getTargetVec3()
	STravelHandle:perfHandle(self, STravelDef.PERF_LOOKAT, v3)
end

-- 更新 具体由子类实现
function updateTravel(self, deltaTime)
	-- 说明update有效
	if super.updateTravel(self,deltaTime) then
		-- 停留中
		if self.m_isStaying==true then
			self.m_stayTime=self.m_stayTime-deltaTime
			if self.m_stayTime<=0 then
				self.m_isStaying = false
			end
			return
		end
		local targetV3
		if self.m_isForward==true then
			targetV3 = self:_getTargetVec3()
		else
			local liveVo = self:getCasterVo()
			if liveVo then
				targetV3 = liveVo:getCurPos()
			else
				self:onEnd()
				return
			end
		end
		local curV3 = self:getCurPos()
		local curDist = math.v3Distance(targetV3, curV3);
		local moveVector = curV3+(targetV3-curV3):normalize()*self.m_moveSpeed*deltaTime
		local newDist = math.v3Distance(targetV3, moveVector)

		if newDist<0.2 or newDist>curDist then -- 第二个情况有可能是跳帧导致
			self:setCurPos(targetV3)
			STravelHandle:perfHandle(self, STravelDef.PERF_POS, targetV3)
			if self.m_isForward==true then
				if not self:startInjuryInterval() then
					self:onIntervalInjury(1)
				end
				self.m_isStaying = true
				self.m_isForward = false
			else
				self:onEnd()
			end
			return
		end

		self:setCurPos(moveVector)
		STravelHandle:perfHandle(self, STravelDef.PERF_POS, moveVector)
		-- 检查范围内是否有其它目标
		if self.m_isMoveAtk then
			local otherTarget = self:getRangeTarget()
			if otherTarget then
				self:onHitTargetIds(otherTarget)
			end
		end
	end
end

function getRangeTarget( self )
	local curPos = self:getCurPos()
	local targets =  fight.TargetManager:getDiffTeamPeople(self.m_casterID, nil, nil, curPos)
	if targets then
		local ids = {}
		for _,vo in pairs(targets) do
			if self.m_radiusSqrt>=math.v3DistanceNoSqrt(curPos, vo:getCurPos()) then
				table.insert(ids, vo.id)
				-- print("getRangeTarget", vo.id)
			end
		end
		if not table.empty(ids) then
			return ids
		end
	end
end

-- 触发间隔伤害 (由子类扩展)
function onIntervalInjury(self, cnt)
	local targets = self:getRangeTarget()
	if not table.empty(targets) then
		self:onHitTargetIds(targets)
	end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
