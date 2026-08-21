

module("HeroDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_skillList = refData.skill_list
	self.m_weight = refData.weight
	self.m_life = refData.life
	self.m_background = refData.background
	self.m_stature = refData.stature
	self.m_head = refData.head
	self.m_exterior = refData.exterior
	self.m_heroColor = refData.hero_color
	self.m_imgPainting = refData.img_painting
	self.m_ability = refData.ability
	self.m_model = refData.model
	self.m_camp = refData.camp
	self.m_attrAbility = refData.attr_ability
	self.m_voice = refData.voice
	self.m_imgBody = refData.img_body
	self.m_imgName = refData.img_name
	self.m_blood = refData.blood
	self.m_heroType = refData.hero_type
	self.m_english = refData.english
	self.m_name = refData.name
	self.m_birthday = refData.birthday
end

function getRefID(self)
	return self.m_refID
end

function getSkillList(self)
	return self.m_skillList
end

function getWeight(self)
	return self.m_weight
end

function getLife(self)
	return self.m_life
end

function getBackground(self)
	return self.m_background
end

function getStature(self)
	return self.m_stature
end

function getHead(self)
	return self.m_head
end

function getExterior(self)
	return self.m_exterior
end

function getHeroColor(self)
	return self.m_heroColor
end

function getImgPainting(self)
	return self.m_imgPainting
end

function getAbility(self)
	return self.m_ability
end

function getModel(self)
	return self.m_model
end

function getCamp(self)
	return self.m_camp
end

function getAttrAbility(self)
	return self.m_attrAbility
end

function getVoice(self)
	return self.m_voice
end

function getImgBody(self)
	return self.m_imgBody
end

function getImgName(self)
	return self.m_imgName
end

function getBlood(self)
	return self.m_blood
end

function getHeroType(self)
	return self.m_heroType
end

function getEnglish(self)
	return self.m_english
end

function getName(self)
	return self.m_name
end

function getBirthday(self)
	return self.m_birthday
end

return _M
