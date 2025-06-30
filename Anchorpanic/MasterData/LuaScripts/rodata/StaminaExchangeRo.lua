

module("StaminaExchangeRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_stamina = refData.stamina
	self.m_payJewel = refData.pay_jewel
end

function getRefID(self)
	return self.m_refID
end

function getStamina(self)
	return self.m_stamina
end

function getPayJewel(self)
	return self.m_payJewel
end

return _M
