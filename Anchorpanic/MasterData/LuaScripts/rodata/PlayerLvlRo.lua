

module("PlayerLvlRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_needExp = refData.need_exp
	self.m_maxStamina = refData.max_stamina
end

function getRefID(self)
	return self.m_refID
end

function getNeedExp(self)
	return self.m_needExp
end

function getMaxStamina(self)
	return self.m_maxStamina
end

return _M
