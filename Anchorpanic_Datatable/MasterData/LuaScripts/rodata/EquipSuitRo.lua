--Editor生成时间: 2020-06-05 16:39 13

module("EquipSuitRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_equipSuit = refData.equip_suit
end

function getRefID(self)
	return self.m_refID
end

function getEquipSuit(self)
	return self.m_equipSuit
end

return _M
