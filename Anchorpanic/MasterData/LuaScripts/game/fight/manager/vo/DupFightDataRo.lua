

module("DupFightDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_fightSpeed = refData.fight_speed
	self.m_autoFight = refData.auto_fight
	self.m_attack_value = refData.attack_value
	self.m_reduce_value = refData.reduce_value
	self.m_skip_need_round = refData.skip_need_round
	self.m_prompt_id = refData.prompt_id
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

function getSkipNeedRound(self)
	return self.m_skip_need_round
end

function getPromptId(self)
	return self.m_prompt_id
end

return _M
