

module("SystemParamRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_explain = refData.explain
	self.m_parameter = refData.parameter
end

function getRefID(self)
	return self.m_refID
end

function getExplain(self)
	return self.m_explain
end

function getParameter(self)
	return self.m_parameter
end

return _M
