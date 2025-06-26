

module("EquipSuitDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_desc = refData.desc
	self.m_suitSkill4 = refData.suit_skill4
	self.m_name = refData.name
	self.m_suitSkill2 = refData.suit_skill2
end

function getRefID(self)
	return self.m_refID
end

function getDesc(self)
	return self.m_desc
end

function getSuitSkill4(self)
	return self.m_suitSkill4
end

function getName(self)
	return self.m_name
end

function getSuitSkill2(self)
	return self.m_suitSkill2
end

return _M
