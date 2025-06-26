

module("SoundDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_flesh = refData.flesh
	self.m_fmType = refData.fmType
	self.m_metal = refData.metal
end

function getRefID(self)
	return self.m_refID
end

function getFlesh(self)
	return self.m_flesh
end

function getFmType(self)
	return self.m_fmType
end

function getMetal(self)
	return self.m_metal
end

return _M
