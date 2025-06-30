

module("AlwaysEffectDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_eftGroup = refData.eft_group
	self.m_justUI = refData.justUI
end

function getRefID(self)
	return self.m_refID
end

function getEftGroup(self)
	return self.m_eftGroup
end

function getJustUI(self)
	return self.m_justUI
end

return _M
