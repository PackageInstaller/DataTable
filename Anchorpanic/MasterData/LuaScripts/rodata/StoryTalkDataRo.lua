

module("StoryTalkDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_msg = refData.msg
	self.m_groupId = refData.group_id
	self.m_audio = refData.audio
	self.m_nextId = refData.next_id
	self.m_exit = refData.exit
	self.m_showUp = refData.show_up
	self.m_talker = refData.talker
end

function getRefID(self)
	return self.m_refID
end

function getMsg(self)
	return self.m_msg
end

function getGroupId(self)
	return self.m_groupId
end

function getAudio(self)
	return self.m_audio
end

function getNextId(self)
	return self.m_nextId
end

function getExit(self)
	return self.m_exit
end

function getShowUp(self)
	return self.m_showUp
end

function getTalker(self)
	return self.m_talker
end

return _M
