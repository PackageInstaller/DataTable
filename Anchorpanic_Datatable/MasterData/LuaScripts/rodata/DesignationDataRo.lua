

module("DesignationDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

end

function getRefID(self)
	return self.m_refID
end

return _M
