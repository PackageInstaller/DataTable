

module("MonFormationDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_formationList = refData.formation_list
end

function getRefID(self)
	return self.m_refID
end

function getFormationList(self)
	return self.m_formationList
end

return _M
