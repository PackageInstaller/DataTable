

module("ClimbTowerDupDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_sort = refData.sort
	self.m_areaBuff = refData.area_buff
	self.m_themeType = refData.theme_type
	self.m_battleScene = refData.battle_scene
	self.m_mon = refData.mon
	self.m_chapter = refData.chapter
	self.m_storyId = refData.story_id
	self.m_recommendForce = refData.recommend_force
	self.m_pic = refData.pic
	self.m_mainExp = refData.main_exp
	self.m_supportSkill = refData.support_skill
	self.m_nextId = refData.next_id
	self.m_award = refData.award
	self.m_name = refData.name
	self.m_preId = refData.pre_id
end

function getRefID(self)
	return self.m_refID
end

function getSort(self)
	return self.m_sort
end

function getAreaBuff(self)
	return self.m_areaBuff
end

function getThemeType(self)
	return self.m_themeType
end

function getBattleScene(self)
	return self.m_battleScene
end

function getMon(self)
	return self.m_mon
end

function getChapter(self)
	return self.m_chapter
end

function getStoryId(self)
	return self.m_storyId
end

function getRecommendForce(self)
	return self.m_recommendForce
end

function getPic(self)
	return self.m_pic
end

function getMainExp(self)
	return self.m_mainExp
end

function getSupportSkill(self)
	return self.m_supportSkill
end

function getNextId(self)
	return self.m_nextId
end

function getAward(self)
	return self.m_award
end

function getName(self)
	return self.m_name
end

function getPreId(self)
	return self.m_preId
end

return _M
