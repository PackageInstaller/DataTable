

module("DupFightDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_fightSpeed = refData.fight_speed
	self.m_autoFight = refData.auto_fight
	self.m_attack_value = refData.attack_value
	self.m_reduce_value = refData.reduce_value
end

function getRefID(self)
	return self.m_refID
end

function getFightSpeed(self)
	return self.m_fightSpeed
end

function getAutoFight(self)
	return self.m_autoFight
end

function getAttackValue(self)
	return self.m_attack_value
end

function getReduceValue(self)
	return self.m_reduce_value
end

return _M
