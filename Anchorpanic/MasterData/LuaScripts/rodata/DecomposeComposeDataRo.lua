

module("DecomposeComposeDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_type = refData.type
	self.m_propList = refData.prop_list
end

function getRefID(self)
	return self.m_refID
end

function getType(self)
	return self.m_type
end

function getPropList(self)
	return self.m_propList
end

return _M
