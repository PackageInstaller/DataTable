

module("HeroBiographyChapterDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_name = refData.name
	self.m_deblocking = refData.deblocking
	self.m_icon = refData.icon
	self.m_chapterList = refData.chapter_list
end

function getRefID(self)
	return self.m_refID
end

function getName(self)
	return self.m_name
end

function getDeblocking(self)
	return self.m_deblocking
end

function getIcon(self)
	return self.m_icon
end

function getChapterList(self)
	return self.m_chapterList
end

return _M
