

module("AvatarDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_unlockType = refData.unlock_type
	self.m_getDescription = refData.get_description
	self.m_sort = refData.sort
	self.m_resName = refData.res_name
	self.m_unlockList = refData.unlock_list
	self.m_icon = refData.icon
end

function getRefID(self)
	return self.m_refID
end

function getUnlockType(self)
	return self.m_unlockType
end

function getGetDescription(self)
	return self.m_getDescription
end

function getSort(self)
	return self.m_sort
end

function getResName(self)
	return self.m_resName
end

function getUnlockList(self)
	return self.m_unlockList
end

function getIcon(self)
	return "heroHead/"..self.m_icon
end

return _M
