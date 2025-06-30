

module("HeroFormationDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_isShow = refData.is_show
	self.m_limit = refData.limit
	self.m_formationList = refData.formation_list
	self.m_dupId = refData.dupId
end

function getRefID(self)
	return self.m_refID
end

function getIsShow(self)
	return self.m_isShow
end

function getLimit(self)
	return self.m_limit
end

function getFormationList(self)
	return self.m_formationList
end

function getDupId(self)
	return self.m_dupId
end

return _M
