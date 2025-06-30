--[[
****************************************************************************
Brief  :SPerfLaster 镭射类技能轨迹
Author :James Ou
Date   :2020-03-26
****************************************************************************
]]
module("SPerfLaster", Class.impl(SPerfBase))
-------------------------------
function ctor(self)
	super.ctor(self)
	-- 移动速度
	self.m_sPos = nil
	self.m_ePos = nil
end
-- 由其子类扩展实现
function onOtherTravelCmd(self, cmd, travel, ...)
	if cmd==STravelDef.PERF_LASER_POS then
		local liveCaster = travel:getCaster()

		if not liveCaster then return end
		local liveTarget = travel:getTarget()
		
		if not liveTarget then return end
		local sPos = liveCaster:getCurPos()
		local ePos = liveTarget:getCurPos()
		
		if sPos==self.m_sPos and ePos==self.m_ePos then return end
		
		self.m_sPos = sPos
		self.m_ePos = ePos
		self:onLookAt(travel, ePos)
		local curDist = math.v3Distance(sPos, ePos)
		gs.TransQuick:ScaleX(self.m_rootTrans, curDist)
		self:onPos(travel, sPos)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
