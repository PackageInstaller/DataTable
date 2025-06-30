

module("MainStoryChapterDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_background = refData.background
	self.m_name = refData.name
	self.m_stage = refData.stage
end

function getRefID(self)
	return self.m_refID
end

function getBackground(self)
	return self.m_background
end

function getName(self)
	return self.m_name
end

function getStage(self)
	return self.m_stage
end

return _M
