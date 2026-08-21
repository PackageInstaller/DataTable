

module("SkillPerformDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_roleExpressionId = refData.role_expression_id
	self.m_rootEftName = refData.root_eft_name
	self.m_interval = refData.interval
	self.m_explodeEftName = refData.explode_eft_name
	self.m_perfId = refData.perf_id
	self.m_remark = refData.remark
	self.m_lifeTime = refData.life_time
	self.m_speed = refData.speed
end

function getRefID(self)
	return self.m_refID
end

function getRoleExpressionId(self)
	return self.m_roleExpressionId
end

function getRootEftName(self)
	return self.m_rootEftName
end

function getInterval(self)
	return self.m_interval
end

function getExplodeEftName(self)
	return self.m_explodeEftName
end

function getPerfId(self)
	return self.m_perfId
end

function getRemark(self)
	return self.m_remark
end

function getLifeTime(self)
	return self.m_lifeTime
end

function getSpeed(self)
	return self.m_speed
end

return _M
