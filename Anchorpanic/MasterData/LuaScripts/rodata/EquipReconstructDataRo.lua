

module("EquipReconstructDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_payId = refData.pay_id
	self.m_costList = refData.cost_list
	self.m_payNum = refData.pay_num
end

function getRefID(self)
	return self.m_refID
end

function getPayId(self)
	return self.m_payId
end

function getCostList(self)
	return self.m_costList
end

function getPayNum(self)
	return self.m_payNum
end

return _M
