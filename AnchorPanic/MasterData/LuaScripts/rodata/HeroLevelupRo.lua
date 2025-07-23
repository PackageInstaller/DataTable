--Editor生成时间: 2020-06-05 16:39 13

module("HeroLevelupRo", Class.impl())

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
