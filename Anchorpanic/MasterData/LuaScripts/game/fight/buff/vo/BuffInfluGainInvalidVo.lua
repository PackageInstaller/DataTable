--[[
****************************************************************************
Brief  :buffer 对指定属性增益的部分无效化
Author :James Ou
Date   :2020-02-27
****************************************************************************
]]
module("Buff.BuffInfluGainInvalidVo", Class.impl(Buff.BuffInfluenceVo))
-------------------------------
-- function setRefID(self, refID, showTime)
-- 	super.setRefID(self, refID, showTime)
function setRo(self, ro)
	super.setRo(self, ro)
	self.m_dataVal = {}
	local str = self.m_buffRo:getInfluenceVal()
	local strArr = string.split(str, ",")
	for _, subStr in ipairs(strArr) do
		self.m_dataVal[tonumber(subStr)] = true
	end
end

function isInfluencedAttr(self, attrKey)
	if self.m_dataVal[attrKey]~=nil then
		return true
	end
	return false
end

function tryInfluencedAttr(self, attrKey, attrVal)
	if attrVal>0 then
		local val = self.m_dataVal[attrKey]
		if val~=nil then
			return 0
		end
	end
	return nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
