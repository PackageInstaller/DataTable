

module("HeroLevelupDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_heroLevelup = refData.hero_levelup
end

function getRefID(self)
	return self.m_refID
end

function getHeroLevelup(self)
	return self.m_heroLevelup
end

return _M
