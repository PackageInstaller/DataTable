

module("DupDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_sort = refData.sort
	self.m_openDate = refData.open_date
	self.m_explain = refData.explain
	self.m_battleScene = refData.battle_scene
	self.m_dupGuard = refData.dup_guard
	self.m_drop = refData.drop
	self.m_showDrop = refData.show_drop
	self.m_recommendForce = refData.recommend_force
	self.m_needNum = refData.need_num
	self.m_type = refData.type
	self.m_nextId = refData.next_id
	self.m_enterLv = refData.enter_lv
	self.m_needTid = refData.need_tid
	self.m_name = refData.name
end

function getRefID(self)
	return self.m_refID
end

function getSort(self)
	return self.m_sort
end

function getOpenDate(self)
	return self.m_openDate
end

function getExplain(self)
	return self.m_explain
end

function getBattleScene(self)
	return self.m_battleScene
end

function getDupGuard(self)
	return self.m_dupGuard
end

function getDrop(self)
	return self.m_drop
end

function getShowDrop(self)
	return self.m_showDrop
end

function getRecommendForce(self)
	return self.m_recommendForce
end

function getNeedNum(self)
	return self.m_needNum
end

function getType(self)
	return self.m_type
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

function getName(self)
	return self.m_name
end

return _M
