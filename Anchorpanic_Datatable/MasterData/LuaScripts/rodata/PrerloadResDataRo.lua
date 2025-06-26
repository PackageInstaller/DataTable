

module("PrerloadResDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_containResList = refData.contain_res_list
end

function getRefID(self)
	return self.m_refID
end

function getContainResList(self)
	return self.m_containResList
end

return _M
