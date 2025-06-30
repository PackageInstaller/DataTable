--[[
****************************************************************************
Brief  :STravelMissile 导弹
Author :James Ou
Date   :2020-04-02
****************************************************************************
]]

module("STravelMissile", Class.impl(STravelBase))

-- 根据不同的轨迹 子类可重写
SPERF_CLS = SPerfMissile

-------------------------------
function start(self)
	super.start(self)
	-- local v3 = self:_getTargetVec3():clone()
	-- self:setCurPos(v3)
	local curV3, root = self:getSimplePoint()
	self:setCurPos(curV3)
	STravelHandle:perfHandle(self, STravelDef.PERF_START, root)
	-- STravelHandle:perfHandle(self, STravelDef.PERF_POS, curV3)
	self:startInjuryInterval()
	self:onHitTargetIds(self.m_targetID)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
