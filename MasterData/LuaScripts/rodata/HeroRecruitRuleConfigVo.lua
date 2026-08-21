

module("HeroRecruitRuleConfigVo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_type = refData.type
	self.m_ruleData = refData.rule_data
	self.rule = refData.rule
end

function getRefID(self)
	return self.m_refID
end

function getType(self)
	return self.m_type
end

function getRuleData(self)
	return self.m_ruleData
end

return _M
