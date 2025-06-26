

module("MainStoryStageDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_mon = refData.mon
	self.m_firstAward = refData.first_award
	self.m_number = refData.number
	self.m_delegationId = refData.delegation_id
	self.m_nextId = refData.next_id
	self.m_cost = refData.cost
	self.m_styleType = refData.style_type
	self.m_heroExp = refData.hero_exp
	self.m_showDrop = refData.show_drop
	self.m_battleScene = refData.battle_scene
	self.m_recommendForce = refData.recommend_force
	self.m_chapter = refData.chapter
	self.m_roleExp = refData.role_exp
	self.m_story = refData.story
	self.m_pic = refData.pic
	self.m_name = refData.name
	self.m_supportSkill = refData.support_skill
	self.m_type = refData.type
	self.m_preId = refData.pre_id
	self.m_challengeAward = refData.challenge_award
	self.m_describe = refData.describe
end

function getRefID(self)
	return self.m_refID
end

function getMon(self)
	return self.m_mon
end

function getFirstAward(self)
	return self.m_firstAward
end

function getNumber(self)
	return self.m_number
end

function getDelegationId(self)
	return self.m_delegationId
end

function getNextId(self)
	return self.m_nextId
end

function getCost(self)
	return self.m_cost
end

function getStyleType(self)
	return self.m_styleType
end

function getHeroExp(self)
	return self.m_heroExp
end

function getShowDrop(self)
	return self.m_showDrop
end

function getBattleScene(self)
	return self.m_battleScene
end

function getRecommendForce(self)
	return self.m_recommendForce
end

function getChapter(self)
	return self.m_chapter
end

function getRoleExp(self)
	return self.m_roleExp
end

function getStory(self)
	return self.m_story
end

function getPic(self)
	return self.m_pic
end

function getName(self)
	return self.m_name
end

function getSupportSkill(self)
	return self.m_supportSkill
end

function getType(self)
	return self.m_type
end

function getPreId(self)
	return self.m_preId
end

function getChallengeAward(self)
	return self.m_challengeAward
end

function getDescribe(self)
	return self.m_describe
end

return _M
