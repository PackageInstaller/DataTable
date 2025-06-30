--[[
****************************************************************************
Brief  :buffer 排除指定的Buff
Author :James Ou
Date   :2020-02-27
****************************************************************************
]]
module("Buff.BuffInfluExcludeVo", Class.impl(Buff.BuffInfluenceVo))
-------------------------------

-- 属性解释 (有不同的解释需求时 由子类重写)
function onParseData(self)
	self.m_dataValDict = {}
	local str = self.m_buffRo:getInfluenceVal()
	local strArr = string.split(str, ",")
	local buffRefIds = {}
	for _, subStr in ipairs(strArr) do
		table.insert(buffRefIds, tonumber(subStr))
	end
	self:setRejectionBuffRefIDs(buffRefIds)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
