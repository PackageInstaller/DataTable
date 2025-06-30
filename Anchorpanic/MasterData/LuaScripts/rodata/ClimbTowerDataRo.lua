

module("ClimbTowerDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_position = refData.position
	self.m_dupList = refData.dup_list
	self.m_name = refData.name
	self.m_background = refData.background
end

function getRefID(self)
	return self.m_refID
end

function getPosition(self)
	return self.m_position
end

function getDupList(self)
	return self.m_dupList
end

function getName(self)
	return self.m_name
end

function getBackground(self)
	return self.m_background
end

return _M
