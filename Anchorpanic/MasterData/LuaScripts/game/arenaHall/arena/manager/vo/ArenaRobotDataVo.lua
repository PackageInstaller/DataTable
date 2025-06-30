

module("ArenaRobotDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_points = refData.points
	self.m_power = refData.power
	self.m_formationId = refData.formation_id
	self.m_headIcon = refData.head_icon
	self.m_battleArray = refData.battle_array
	self.m_sceneId = refData.scene_id
	self.m_musicId = refData.music_id
	self.m_name = refData.name
	self.m_level = refData.level
end

function getRefID(self)
	return self.m_refID
end

function getPoints(self)
	return self.m_points
end

function getPower(self)
	return self.m_power
end

function getFormationId(self)
	return self.m_formationId
end

function getHeadIcon(self)
	return self.m_headIcon
end

function getBattleArray(self)
	return self.m_battleArray
end

function getSceneId(self)
	return self.m_sceneId
end

function getMusicId(self)
	return self.m_musicId
end

function getName(self)
	return self.m_name
end

function getLevel(self)
	return self.m_level
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
