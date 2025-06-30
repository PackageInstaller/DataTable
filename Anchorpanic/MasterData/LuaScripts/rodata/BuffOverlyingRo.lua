

module("BuffOverlyingRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_max = refData.max
	self.m_overVal = refData.over_val
	self.m_type = refData.type
end

function getRefID(self)
	return self.m_refID
end

function getMax(self)
	return self.m_max
end

function getOverVal(self)
	return self.m_overVal
end

function getType(self)
	return self.m_type
end

return _M
