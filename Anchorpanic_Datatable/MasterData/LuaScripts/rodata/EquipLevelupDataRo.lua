

module("EquipLevelupDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_slotpos = refData.slotpos
	self.m_levelupAttr = refData.levelup_attr
	self.m_color = refData.color
end

function getRefID(self)
	return self.m_refID
end

function getSlotpos(self)
	return self.m_slotpos
end

function getLevelupAttr(self)
	return self.m_levelupAttr
end

function getColor(self)
	return self.m_color
end

return _M
