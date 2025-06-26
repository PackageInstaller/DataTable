

module("GuideFlowDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_dupId = refData.dup_id
	self.m_talkLine = refData.talk_line
	self.m_talkId = refData.talk_id
	self.m_guideLine = refData.guide_line
	self.m_joinDup = refData.join_dup
end

function getRefID(self)
	return self.m_refID
end

function getDupId(self)
	return self.m_dupId
end

function getJoinDup(self)
	return self.m_joinDup
end

function getTalkLine(self)
	return self.m_talkLine
end

function getTalkId(self)
	return self.m_talkId
end

function getGuideLine(self)
	return self.m_guideLine
end

return _M
