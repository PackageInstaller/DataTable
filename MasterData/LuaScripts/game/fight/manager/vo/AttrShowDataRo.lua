

module("AttrShowDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_sort = refData.sort
	self.m_showType = refData.show_type
	self.m_type = refData.type
	self.m_engName = refData.eng_name
	self.m_name = refData.name
	self.m_show = refData.show
	self.m_mainSecondaryType = refData.main_secondary_type
end

function getRefID(self)
	return self.m_refID
end

function getSort(self)
	return self.m_sort
end

function getShowType(self)
	return self.m_showType
end

function getType(self)
	return self.m_type
end

function getEngName(self)
	return self.m_engName
end

function getName(self)
	return self.m_name
end

function getShow(self)
	return self.m_show
end

function getMainSecondaryType(self)
	return self.m_mainSecondaryType
end

return _M
