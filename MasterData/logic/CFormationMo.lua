-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/mo/CFormationMo.lua

module("logic.extensions.common.mo.CFormationMo", package.seeall)

local CFormationMo = class("CFormationMo")

function CFormationMo:ctor()
	self._pos2raceId = {}
	self._flip = false
end

function CFormationMo:getRaceId(pos)
	return self._pos2raceId[pos] or 0
end

function CFormationMo:isFlip()
	return self._flip
end

function CFormationMo:setFlip(flip)
	self._flip = flip
end

function CFormationMo:setRaceId(pos, raceId)
	self._pos2raceId[pos] = raceId
end

function CFormationMo:setRaceIdByCreepsCfgs(creepsCfgs)
	self._pos2raceId = {}

	for _, cfg in ipairs(creepsCfgs) do
		self:setRaceId(cfg.posId, cfg.raceId)
	end
end

function CFormationMo:setData(pos2raceId, flip)
	self._pos2raceId = pos2raceId
	self._flip = flip
end

return CFormationMo
