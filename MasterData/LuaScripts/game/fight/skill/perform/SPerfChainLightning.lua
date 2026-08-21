--[[
****************************************************************************
Brief  :SPerfLaster 链状闪电
Author :James Ou
Date   :2020-04-02
****************************************************************************
]]
module("SPerfChainLightning", Class.impl(SPerfBase))
-------------------------------
function ctor(self)
	super.ctor(self)
	-- 移动速度
	self.m_sPos = nil
	self.m_ePos = nil
end
function onStart(self, travel, ...)
	if super.onStart(self, travel, ...) then
		local liveCaster = travel:getCaster()
		if not liveCaster then return end
		local liveTarget = travel:getTarget()
		if not liveTarget then return end
		self.m_chainLightning = self.m_rootTrans:GetComponent(ty.EffectPointSet) --self.m_rootTrans:GetComponent(ty.ChainLightning)
		if self.m_chainLightning then
			-- self.m_chainLightning:SetTrans(liveCaster:getTrans(), liveTarget:getTrans())
			-- print("========",liveCaster:getCurPos(), liveTarget:getPointPos(fight.FightDef.POINT_SPINE))
			self.m_chainLightning:InitSet(liveTarget:getPointTrans(fight.FightDef.POINT_SPINE))
		end
	end
end

function onEnd(self, travel)
	if self.m_chainLightning then
		self.m_chainLightning = nil
	end
	super.onEnd(self, travel)
end
-- 暂停
function onPause(self, travel)
	-- if self.m_chainLightning then
	-- 	self.m_chainLightning:Stop()
	-- end
	super.onPause(self, travel)
end
-- 继续
function onResume(self, travel)
	super.onResume(self, travel)
	-- if self.m_chainLightning then
	-- 	self.m_chainLightning:Resume()
	-- end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
