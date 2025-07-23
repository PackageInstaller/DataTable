--[[
****************************************************************************
Brief  :buffer 对指定属性增益 再进行百分比加成
Author :James Ou
Date   :2020-02-26
****************************************************************************
]]
module("Buff.BuffInfluPercentVo", Class.impl(Buff.BuffInfluenceVo))
-------------------------------

function isInfluencedAttr(self, attrKey)
	if self.m_dataValDict[attrKey]~=nil then
		return true
	end
	return false
end

function tryInfluencedAttr(self, attrKey, attrVal)
	local attrVo = self.m_dataValDict[attrKey]
	if attrVo~=nil then
		if attrVo.m_type==1 then
			return attrVal-(attrVal*attrVo.m_val)
		elseif attrVo.m_type==2 then
			return attrVal+(attrVal*attrVo.m_val)
		-- elseif attrVo.m_type==0 then --不会有这情况吧?
		end
	end
	return nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
