

module("HeroBiographyDupDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_sort = refData.sort
	self.m_showDrop = refData.show_drop
	self.m_pointLine = refData.point_line
	self.m_sceneId = refData.scene_id
	self.m_nextId = refData.next_id
	self.enemyList = refData.mon
	self.formationId = refData.formation_id
	self.suggestLevel = refData.suggest_level
	self.suggestEle = refData.suggest_ele
	self.m_firstAward = refData.first_award
	self.m_dupGuardExtra = refData.dup_guard_extra
	self.m_story = refData.story
	self.m_recommendForce = refData.recommend_force
	self.m_needNum = refData.need_num
	self.m_needTid = refData.need_tid
	self.m_biographyId = refData.biography_id
	self.m_musicId = refData.music_id
	self.m_name = refData.name
	self.m_type = refData.type
end

function getRefID(self)
	return self.m_refID
end

function getSort(self)
	return self.m_sort
end

function getShowDrop(self)
	return self.m_showDrop
end

function getPointLine(self)
	return self.m_pointLine
end

function getSceneId(self)
	return self.m_sceneId
end

function getNextId(self)
	return self.m_nextId
end

function getMon(self)
	return self.enemyList
end

function getFirstAward(self)
	return self.m_firstAward
end

function getDupGuardExtra(self)
	return self.m_dupGuardExtra
end

function getStory(self)
	return self.m_story
end

function getRecommendForce(self)
	return self.m_recommendForce
end

function getNeedNum(self)
	return self.m_needNum
end

function getNeedTid(self)
	return self.m_needTid
end

function getBiographyId(self)
	return self.m_biographyId
end

function getMusicId(self)
	return self.m_musicId
end

function getName(self)
	return self.m_name
end

function getType(self)
	return self.m_type
end

return _M
