

module("EquipDupStageDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_sort = refData.sort
	self.m_heroExp = refData.hero_exp
	self.m_position = refData.position
	self.m_explain = refData.explain
	self.m_battleScene = refData.battle_scene
	self.m_chapter = refData.chapter
	self.m_drop = refData.drop
	self.m_showDrop = refData.show_drop
	self.m_dupGuard = refData.dup_guard
	self.m_mainExp = refData.main_exp
	self.m_name = refData.name
	self.m_nextId = refData.next_id
	self.m_enterLv = refData.enter_lv
	self.m_needTid = refData.need_tid
	self.m_needNum = refData.need_num
end

function getRefID(self)
	return self.m_refID
end

function getSort(self)
	return self.m_sort
end

function getHeroExp(self)
	return self.m_heroExp
end

function getPosition(self)
	return self.m_position
end

function getExplain(self)
	return self.m_explain
end

function getBattleScene(self)
	return self.m_battleScene
end

function getChapter(self)
	return self.m_chapter
end

function getDrop(self)
	return self.m_drop
end

function getShowDrop(self)
	return self.m_showDrop
end

function getDupGuard(self)
	return self.m_dupGuard
end

function getMainExp(self)
	return self.m_mainExp
end

function getName(self)
	return self.m_name
end

function getNextId(self)
	return self.m_nextId
end

function getEnterLv(self)
	return self.m_enterLv
end

function getNeedTid(self)
	return self.m_needTid
end

function getNeedNum(self)
	return self.m_needNum
end

return _M
