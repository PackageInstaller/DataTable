--[[
****************************************************************************
Brief  :buffer 中 连续百分比增益
Author :James Ou
Date   :2020-02-24
****************************************************************************
]]
module("Buff.BuffIntervalPercentVo",  Class.impl(Buff.BuffIntervalVo))
-------------------------------

-- --设置buff引用ID
-- function setRefID(self, refID, showTime)
-- 	super.setRefID(self, refID, showTime)
-- 	self:startup()
-- end

-- function calculatedBuffVal(self)
-- 	local liveVo = fight.SceneManager:getThing(self.m_entity.m_livethingID)
-- 	if liveVo then
-- 		local valDict = {}
-- 		for key, val in pairs(self.m_dataVal) do
-- 			valDict[key] = liveVo:getAtt(key)*val
-- 		end
-- 		return valDict
-- 	end
-- end

function onInterval(self)
	self:onValChange()
end

return _M


 
--[[ 替换语言包自动生成，请勿修改！
]]
