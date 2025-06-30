

module("HeroStarDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_heroStar = refData.hero_star
end

function getRefID(self)
	return self.m_refID
end

function getHeroStar(self)
	return self.m_heroStar
end

return _M
