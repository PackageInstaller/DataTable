

module("MonBaseDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_skillList = refData.skill_list
	self.m_pic = refData.pic_
	self.m_painting = refData.painting
	self.m_head = refData.head
	self.m_star = refData.star
	self.m_level = refData.level
	self.m_passiveSkillList = refData.passive_skill_list
	self.m_type = refData.type
	self.m_name = refData.name
	self.m_describe = refData.describe
	self.m_model = refData.model
end

function getRefID(self)
	return self.m_refID
end

function getSkillList(self)
	return self.m_skillList
end

function getPic(self)
	return self.m_pic
end

function getPainting(self)
	return self.m_painting
end

function getHead(self)
	return self.m_head
end

function getStar(self)
	return self.m_star
end

function getLevel(self)
	return self.m_level
end

function getPassiveSkillList(self)
	return self.m_passiveSkillList
end

function getType(self)
	return self.m_type
end

function getName(self)
	return self.m_name
end

function getDescribe(self)
	return self.m_describe
end

function getModel(self)
	return self.m_model
end

return _M
