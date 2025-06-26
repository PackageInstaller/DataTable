

module("EffectDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_triggerType = refData.trigger_type
	self.m_desc = refData.desc
	self.m_triggerRate = refData.trigger_rate
	self.m_isEffectInc = refData.is_effect_inc
	self.m_targetRule = refData.target_rule
	self.m_triggerNum = refData.trigger_num
	self.m_damageNum = refData.damage_num
	self.m_damageArea = refData.damage_area
end

function getRefID(self)
	return self.m_refID
end

function getTriggerType(self)
	return self.m_triggerType
end

function getDesc(self)
	return self.m_desc
end

function getTriggerRate(self)
	return self.m_triggerRate
end

function getIsEffectInc(self)
	return self.m_isEffectInc
end

function getTargetRule(self)
	return self.m_targetRule
end

function getTriggerNum(self)
	return self.m_triggerNum
end

function getDamageNum(self)
	return self.m_damageNum
end

function getDamageArea(self)
	return self.m_damageArea
end

return _M
