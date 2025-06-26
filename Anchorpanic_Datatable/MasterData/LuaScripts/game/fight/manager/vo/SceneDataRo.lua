

module("SceneDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_title = refData.title
	self.m_musicId = refData.music_id
	self.m_scene = refData.scene
	self.m_scene_anima_name = refData.scene_anima_name
end

function getRefID(self)
	return self.m_refID
end


function getTitle(self)
	return self.m_title
end

function getMusicId(self)
	return self.m_musicId
end

function getSoundscapes(self)
	return self.m_soundscapes
end

function getScene(self)
	return self.m_scene
end

function getSceneAnimaNames(self)
	return self.m_scene_anima_name
end

return _M
