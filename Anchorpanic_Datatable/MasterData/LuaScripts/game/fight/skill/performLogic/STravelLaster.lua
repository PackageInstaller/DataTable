--[[
****************************************************************************
Brief  :STravelLaster 光束
Author :James Ou
Date   :2020-03-26
****************************************************************************
]]

module("STravelLaster", Class.impl(STravelBase))

-- 根据不同的轨迹 子类可重写
SPERF_CLS = SPerfLaster

-------------------------------

function start(self)
	super.start(self)
	local v3 = self:_getTargetVec3():clone()
	self:setCurPos(v3)
	STravelHandle:perfHandle(self, STravelDef.PERF_START)
	if not self:startInjuryInterval() then
		self:onIntervalInjury(1)
	end
end

-- 更新 具体由子类实现
function updateTravel(self, deltaTime)
	-- 说明update有效
	if super.updateTravel(self,deltaTime) then
		STravelHandle:perfHandle(self, STravelDef.PERF_LASER_POS)
	end
end

-- 触发间隔伤害 (由子类扩展)
function onIntervalInjury(self, cnt)
	self:onHitTargetIds(self.m_targetID)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
