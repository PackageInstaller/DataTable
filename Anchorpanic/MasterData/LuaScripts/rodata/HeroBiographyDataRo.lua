

module("HeroBiographyDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_biographyList = refData.biography_list
	self.type = refData.type
end

function getRefID(self)
	return self.m_refID
end

function getBiographyList(self)
	return self.m_biographyList
end

return _M
