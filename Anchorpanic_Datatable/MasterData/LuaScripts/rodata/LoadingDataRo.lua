

module("LoadingDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_des = refData.des
	self.m_title = refData.title
	self.m_bgDupList = refData.bg_dup_list
	self.m_background = refData.background
	self.m_dupId = refData.dupId
	self.m_level = refData.level
end

function getRefID(self)
	return self.m_refID
end

function getDes(self)
	return self.m_des
end

function getTitle(self)
	return self.m_title
end

function getBgDupList(self)
	return self.m_bgDupList
end

function getBackground(self)
	return self.m_background
end

function getDupId(self)
	return self.m_dupId
end

function getLevel(self)
	return self.m_level
end

return _M
