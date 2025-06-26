--[[
****************************************************************************
Brief  :buffer 中的数据对象
Author :James Ou
Date   :2020-03-19
****************************************************************************
]]
module("Buff.BuffAttrVo", Class.impl())
-------------------------------
--构造函数
function ctor(self)
	-- 属性ID
	self.m_key = 0
	-- 属性值
	self.m_val = 0
	-- 0替换更新 1减少 2增加
	self.m_gainType = 0
	-- 起效的ID
	self.m_affKey = nil
	-- 最终起效值
	self.m_finalVal = nil
end

function setData(self, key, val, type, affKey)
	self.m_key = key
	self.m_val = val
	self.m_gainType = type
	self.m_affKey = affKey
end

return _M


 
--[[ 替换语言包自动生成，请勿修改！
]]
