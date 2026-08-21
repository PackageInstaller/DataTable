--[[
****************************************************************************
Brief  :buffer 间隔连续性buff增益处理
Author :James Ou
Date   :2020-02-24
****************************************************************************
]]
module("Buff.BuffIntervalVo",  Class.impl(Buff.BuffVo))
-------------------------------
--构造函数
function ctor(self)
	super.ctor(self)
	self.m_interval = 0
	self.m_interElapsed = 0
end
-- 被回收
function onRecover(self)
	self.m_interval = 0
	self.m_interElapsed = 0
	super.onRecover(self)
end

-- function setRefID(self, refID, showTime)
-- 	super.setRefID(self, refID, showTime)
function setRo(self, ro)
	super.setRo(self, ro)
	local interval = self.m_buffRo:getInterval()
	self:setInterval(interval)
end

-- 设置触发间隔
function setInterval(self, interval)
	self.m_interval = interval
end

--返回true即buff继续有效 否则为无效
function updateTime(self, deltaTime)
	local ret = super.updateTime(self, deltaTime)
	if ret then
		self.m_interElapsed = self.m_interElapsed+deltaTime
		if (self.m_interElapsed>=self.m_interval) then
			self.m_interElapsed  = 0
			self:onInterval()
		end
	end
	return ret
end

function onInterval(self)
end

return _M


 
--[[ 替换语言包自动生成，请勿修改！
]]
