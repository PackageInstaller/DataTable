

module("EleReactionDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_eleTypeOld = refData.ele_type_old
	self.m_addBuffId = refData.add_buff_id
	self.m_eleTypeAdd = refData.ele_type_add
	self.m_oldBuffId = refData.old_buff_id
	self.m_effect = refData.effect
	self.m_spIcon = refData.sp_icon
end

function getRefID(self)
	return self.m_refID
end

function getEleTypeOld(self)
	return self.m_eleTypeOld
end

function getAddBuffId(self)
	return self.m_addBuffId
end

function getEleTypeAdd(self)
	return self.m_eleTypeAdd
end

function getOldBuffId(self)
	return self.m_oldBuffId
end

function getEffect(self)
	return self.m_effect
end

function getSpIcon(self)
	return self.m_spIcon
end

return _M
