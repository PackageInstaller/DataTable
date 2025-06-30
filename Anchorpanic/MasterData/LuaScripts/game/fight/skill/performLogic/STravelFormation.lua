--[[
****************************************************************************
Brief  :STravelFormation 子弹类技能轨迹
Author :James Ou
Date   :2020-03-09
****************************************************************************
]]

module("STravelFormation", Class.impl(STravelBase))

-- 根据不同的轨迹 子类可重写
SPERF_CLS = SPerfFormation

-------------------------------
function ctor(self)
	super.ctor(self)
	-- 范围半径
	self.m_radius = 4
	self.m_radiusSqrt = self.m_radius*self.m_radius
end

function start(self)
	super.start(self)
	local curV3 = self:getStartPointPos()
	self:setCurPos(curV3)
	-- local v3 = self:_getTargetVec3():clone()
	-- self:setCurPos(v3)
	STravelHandle:perfHandle(self, STravelDef.PERF_START)
	STravelHandle:perfHandle(self, STravelDef.PERF_POS, curV3)
	if not self:startInjuryInterval() then
		self:onIntervalInjury(1)
	end
end

-- 触发间隔伤害 (由子类扩展)
function onIntervalInjury(self, cnt)
	local targets = self:getRangeTarget()
	if not table.empty(targets) then
		self:onHitTargetIds(targets)
	end
end

function getRangeTarget( self )
	local curPos = self:getCurPos()
	local targets =  fight.TargetManager:getDiffTeamPeople(self.m_casterID, 3, true, curPos)
	if targets then
		local ids = {}
		for _,vo in pairs(targets) do
			local dist = math.v3DistanceNoSqrt(curPos, vo:getCurPos())
			if self.m_radiusSqrt>=dist then
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
