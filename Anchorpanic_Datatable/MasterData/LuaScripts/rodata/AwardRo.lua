

module("AwardRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_index = refData.index
end

function getRefID(self)
	return self.m_refID
end

function getIndex(self)
	return self.m_index
end

return _M
