

module("FightShowDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_dist = refData.dist
	-- self.m_backAfter = refData.back_after
	-- self.m_goBefore = refData.go_before
	self.m_weaponNode = refData.weapon_node
	-- self.m_backBefore = refData.back_before
	-- self.m_arriveAfter = refData.arrive_after
	self.m_mainOffset = refData.main_offset
	self.m_needWeapon = refData.need_weapon
	self.m_targetCameraPoint = refData.target_camera_point
	self.m_targetCameraRotation = refData.target_camera_rotation
	self.m_extraDist = refData.extra_dist
	self.m_lockCamera = refData.lock_camera
end

function getRefID(self)
	return self.m_refID
end

function getMainOffset(self)
	return self.m_mainOffset
end

function getDist(self)
	return self.m_dist
end

-- function getBackAfter(self)
-- 	return self.m_backAfter
-- end

-- function getGoBefore(self)
-- 	return self.m_goBefore
-- end

function getWeaponNode(self)
	return self.m_weaponNode
end

-- function getBackBefore(self)
-- 	return self.m_backBefore
-- end

-- function getArriveAfter(self)
-- 	return self.m_arriveAfter
-- end

function getNeedWeapon(self)
	return self.m_needWeapon
end

function getTargetCameraPonit(self)
	return self.m_targetCameraPoint
end

function getTargetCameraRotation(self)
	return self.m_targetCameraRotation
end

function getExtraDist(self)
	return self.m_extraDist
end

function getLockCamera(self)
	return self.m_lockCamera
end

return _M
