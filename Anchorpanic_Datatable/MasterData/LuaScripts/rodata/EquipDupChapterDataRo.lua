

module("EquipDupChapterDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_preId = refData.pre_id
	self.m_clearAward = refData.clear_award
	self.m_stage = refData.stage
	self.m_nextId = refData.next_id
	self.m_background = refData.background
	self.m_name = refData.name
end

function getRefID(self)
	return self.m_refID
end

function getPreId(self)
	return self.m_preId
end

function getClearAward(self)
	return self.m_clearAward
end

function getStage(self)
	return self.m_stage
end

function getNextId(self)
	return self.m_nextId
end

function getBackground(self)
	return self.m_background
end

function getName(self)
	return self.m_name
end

return _M
