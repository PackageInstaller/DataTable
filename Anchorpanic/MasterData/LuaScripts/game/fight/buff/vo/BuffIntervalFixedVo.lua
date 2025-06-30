--[[
****************************************************************************
Brief  :buffer 中 连续固定增益
Author :James Ou
Date   :2020-02-24
****************************************************************************
]]
module("Buff.BuffIntervalFixedVo",  Class.impl(Buff.BuffIntervalVo))
-------------------------------

-- --设置buff引用ID
-- function setRefID(self, refID, showTime)
-- 	super.setRefID(self, refID, showTime)
-- 	self:startup()
-- end

function onInterval(self)
	self:onValChange()
end


return _M


 
--[[ 替换语言包自动生成，请勿修改！
]]
