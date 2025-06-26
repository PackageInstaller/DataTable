

module("EquipBreakupDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_equipBreakup = refData.equip_breakup
end

function getRefID(self)
	return self.m_refID
end

function getEquipBreakup(self)
	return self.m_equipBreakup
end

return _M
