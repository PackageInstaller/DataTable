--Editor生成时间: 2020-06-05 16:39 13

module("HeroStarRo", Class.impl())

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
