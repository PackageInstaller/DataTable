

module("RoleShowmodeRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_playActions = refData.play_actions
	self.m_isPlayCv = refData.is_play_cv
	self.m_isPlayXz = refData.is_play_xz
	self.m_randomActions = refData.random_actions
	self.m_weapon = refData.weapon
	self.m_action = refData.action
	self.m_always = refData.always
	self.m_randomInterval = refData.random_interval
end

function getRefID(self)
	return self.m_refID
end

function getPlayActions(self)
	return self.m_playActions
end

function getIsPlayCv(self)
	return self.m_isPlayCv
end

function getIsPlayXz(self)
	return self.m_isPlayXz
end

function getRandomActions(self)
	return self.m_randomActions
end

function getWeapon(self)
	return self.m_weapon
end

function getAction(self)
	return self.m_action
end

function getAlways(self)
	return self.m_always
end

function getRandomInterval(self)
	return self.m_randomInterval
end

return _M
