

module("CollegeDelegationRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_type = refData.type
	self.m_dupName = refData.dup_name
end

function getRefID(self)
	return self.m_refID
end

function getType(self)
	return self.m_type
end

function getDupName(self)
	return self.m_dupName
end

return _M
