

module("RoleShowoffsetRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID
	self.m_cultivateOffset = refData.cultivate_offset
	self.m_normalUiOffset = refData.normal_ui_offset
	self.m_chipOffset = refData.chip_offset
	self.m_monsterOffset = refData.monster_offset
	self.m_formationOffset = refData.formation_offset
	self.m_overviewOffset = refData.overview_offset
	self.m_interactionOffset = refData.interaction_offset
	self.m_mainOffset = refData.main_offset
	self.m_modelScale = refData.model_scale
	self.m_modelShowScale = refData.model_show_scale
	self.m_cameraOffsetY = refData.camera_offset_y
	self.m_storyOffset = refData.story_offset
end

function getRefID(self)
	return self.m_refID
end

function getCultivateOffset(self)
	return self.m_cultivateOffset
end

function getNormalUiOffset(self)
	return self.m_normalUiOffset
end

function getChipOffset(self)
	return self.m_chipOffset
end

function getMonsterOffset(self)
	return self.m_monsterOffset
end

function getFormationOffset(self)
	return self.m_formationOffset
end

function getOverviewOffset(self)
	return self.m_overviewOffset
end

function getInteractionOffset(self)
	return self.m_interactionOffset
end

function getMainOffset(self)
	return self.m_mainOffset
end

function getModelScale(self)
	return self.m_modelScale
end

function getModelShowScale(self)
	return self.m_modelShowScale
end

function getCameraOffsetY(self)
	return self.m_cameraOffsetY
end

function getStoryOffset(self)
	return self.m_storyOffset
end

return _M
