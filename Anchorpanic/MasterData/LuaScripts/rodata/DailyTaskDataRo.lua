

module("DailyTaskDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_uiCode = refData.ui_code
	self.m_title = refData.title
	self.m_time = refData.time
	self.m_type = refData.type
	self.m_taskType = refData.task_type
	self.m_describe = refData.describe
	self.m_score = refData.score
end

function getRefID(self)
	return self.m_refID
end

function getUiCode(self)
	return self.m_uiCode
end

function getTitle(self)
	return self.m_title
end

function getTime(self)
	return self.m_time
end

function getType(self)
	return self.m_type
end

function getTaskType(self)
	return self.m_taskType
end

function getDescribe(self)
	return self.m_describe
end

function getScore(self)
	return self.m_score
end

return _M
