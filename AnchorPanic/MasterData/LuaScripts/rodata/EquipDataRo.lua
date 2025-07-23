

module("EquipDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_nuclearAttr = refData.nuclear_attr
	self.m_suit = refData.suit
end

function getRefID(self)
	return self.m_refID
end

function getNuclearAttr(self)
	return self.m_nuclearAttr
end

function getSuit(self)
	return self.m_suit
end

return _M
