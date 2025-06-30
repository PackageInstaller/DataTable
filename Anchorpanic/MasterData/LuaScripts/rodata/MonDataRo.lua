

module("MonDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_tid = refData.tid
end

function getRefID(self)
	return self.m_refID
end

function getTid(self)
	return self.m_tid
end

return _M
