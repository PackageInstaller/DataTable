--[[
****************************************************************************
Brief  :STravelFull 全屏类技能轨迹
Author :James Ou
Date   :2020-03-10
****************************************************************************
]]
module("STravelFull", Class.impl(STravelBase))
-- 根据不同的轨迹 子类可重写
SPERF_CLS = SPerfFull
-------------------------------
function start(self)
	super.start(self)
	-- 应该放场景中心点
	self:setCurPos(math.Vector3.UP)
	STravelHandle:perfHandle(self, STravelDef.PERF_START)
	STravelHandle:perfHandle(self, STravelDef.PERF_POS, math.Vector3.UP)
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
	local targets =  fight.TargetManager:getDiffTeamPeople(self.m_casterID)
	if targets then
		local ids = {}
		for _,vo in pairs(targets) do
			table.insert(ids, vo.id)
		end	
		return ids
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
