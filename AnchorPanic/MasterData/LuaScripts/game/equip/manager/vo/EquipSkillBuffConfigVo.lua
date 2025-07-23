module("equip.EquipSkillBuffConfigVo", Class.impl())

function ctor(self)
end

function parseConfigData(self, cusBuffId, cusData)
	self.buffId = cusBuffId
	self.minValue = cusData.min_value
	self.maxValue = cusData.max_value
	self.m_type = cusData.type
end

function isPercent(self)
	if(self.m_type == 1)then
		return false
	elseif(self.m_type == 2)then
		return true
	end
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
