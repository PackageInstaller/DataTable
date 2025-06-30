

module("ArenaActivityDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_type = refData.type
	self.m_rewards = refData.rewards
end

function getRefID(self)
	return self.m_refID
end

function getType(self)
	return self.m_type
end

function getRewards(self)
	return self.m_rewards
end

return _M
