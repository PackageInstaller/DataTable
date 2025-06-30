

module("FunctionOpenRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_event = refData.event
	self.m_name = refData.name
	self.m_stage = refData.stage
	self.m_playerLv = refData.player_lv
end

function getRefID(self)
	return self.m_refID
end

function getEvent(self)
	return self.m_event
end

function getName(self)
	return self.m_name
end

function getStage(self)
	return self.m_stage
end

function getPlayerLv(self)
	return self.m_playerLv
end

return _M
