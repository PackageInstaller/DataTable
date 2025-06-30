

module("EquipRemakeDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_payNum = refData.pay_num
	self.m_limit = refData.limit
	self.m_costList = refData.cost_list
	self.m_payId = refData.pay_id
end

function getRefID(self)
	return self.m_refID
end

function getPayNum(self)
	return self.m_payNum
end

function getLimit(self)
	return self.m_limit
end

function getCostList(self)
	return self.m_costList
end

function getPayId(self)
	return self.m_payId
end

return _M
