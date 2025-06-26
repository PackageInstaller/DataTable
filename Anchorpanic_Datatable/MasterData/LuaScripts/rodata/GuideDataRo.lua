

module("GuideDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_canPass = refData.can_pass
	self.m_happenArg = refData.happen_arg
	self.m_guideGroup = refData.guide_group
	self.m_happenType = refData.happen_type
	self.m_line_id = refData.line_id
	self.m_is_pause = refData.is_pause
	self.m_award = refData.award
	self.m_dup = refData.dup
end

function getRefID(self)
	return self.m_refID
end

function getDup(self)
	return self.m_dup
end

function getIsPause(self)
	return self.m_is_pause
end

function getCanPass(self)
	return self.m_canPass
end

function getHappenArg(self)
	return self.m_happenArg
end

function getGuideGroup(self)
	return self.m_guideGroup
end

function getHappenType(self)
	return self.m_happenType
end

function getLineID(self)
	return self.m_line_id
end

function getAward(self)
	return self.m_award
end

return _M
