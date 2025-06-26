

module("EmojiDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_type = refData.type
	self.m_unlockList = refData.unlock_list
	self.m_data = refData.data
	self.m_unlockType = refData.unlock_type
	self.subType=refData.subtype
end

function getRefID(self)
	return self.m_refID
end

function getType(self)
	return self.m_type
end

function getUnlockList(self)
	return self.m_unlockList
end

function getData(self)
	return self.m_data
end

function getUnlockType(self)
	return self.m_unlockType
end

function getSubType(self)
	return self.subType
end

return _M
