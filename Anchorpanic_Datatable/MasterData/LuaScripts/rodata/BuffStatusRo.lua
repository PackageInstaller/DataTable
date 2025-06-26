

module("BuffStatusRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_action = refData.action
	self.m_behavior = refData.behavior
end

function getRefID(self)
	return self.m_refID
end

function getAction(self)
	return self.m_action
end

function getBehavior(self)
	return self.m_behavior
end

return _M
