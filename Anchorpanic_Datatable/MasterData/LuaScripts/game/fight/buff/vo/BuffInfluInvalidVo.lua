--[[
****************************************************************************
Brief  :buffer 对指定属性 无效化
Author :James Ou
Date   :2020-02-26
****************************************************************************
]]
module("Buff.BuffInfluInvalidVo", Class.impl(Buff.BuffInfluenceVo))
-------------------------------
-----------

-- 属性解释 (有不同的解释需求时 由子类重写)
function onParseData(self)
	self.m_dataValDict = {}
	local str = self.m_buffRo:getInfluenceVal()
	local strArr = string.split(str, ";")
	for _, subStr in ipairs(strArr) do
		local arr = string.split(subStr, ",")
		local cnt = #arr
		if cnt>=2 then
			local key = tonumber(arr[1])
			local type = tonumber(arr[2])
			local attrVo = Buff.BuffAttrVo.new()
			attrVo:setData(key, 0, type)
			self.m_dataValDict[key] = attrVo
		end
	end
end


function isInfluencedAttr(self, attrKey)
	if self.m_dataValDict[attrKey]~=nil then
		return true
	end
	return false
end

function tryInfluencedAttr(self, attrKey, attrVal)
	local val = self.m_dataValDict[attrKey]
	if val~=nil then
		return 0
	end
	return nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
