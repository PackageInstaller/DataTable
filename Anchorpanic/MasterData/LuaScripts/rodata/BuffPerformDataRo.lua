

module("BuffPerformDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_eftType = refData.eft_type
	self.m_influenceVal = refData.influence_val
	self.m_influenceType = refData.influence_type
	self.m_overlyingId = refData.overlying_id
	self.m_dataType = refData.data_type
	self.m_overEftFlag = refData.over_eft_flag
	self.m_eftName = refData.eft_name
	self.m_desc = refData.desc
	self.m_float = refData.float
	self.m_beReset = refData.be_reset
	self.m_statusId = refData.status_id
	self.m_dataVal = refData.data_val
	self.m_time = refData.time
	self.m_name = refData.name
	self.m_interval = refData.interval
end

function getRefID(self)
	return self.m_refID
end

function getEftType(self)
	return self.m_eftType
end

function getInfluenceVal(self)
	return self.m_influenceVal
end

function getInfluenceType(self)
	return self.m_influenceType
end

function getOverlyingId(self)
	return self.m_overlyingId
end

function getDataType(self)
	return self.m_dataType
end

function getOverEftFlag(self)
	return self.m_overEftFlag
end

function getEftName(self)
	return self.m_eftName
end

function getDesc(self)
	return self.m_desc
end

function getFloat(self)
	return self.m_float
end

function getBeReset(self)
	return self.m_beReset
end

function getStatusId(self)
	return self.m_statusId
end

function getDataVal(self)
	return self.m_dataVal
end

function getTime(self)
	return self.m_time
end

function getName(self)
	return self.m_name
end

function getInterval(self)
	return self.m_interval
end

return _M
