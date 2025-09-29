-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/particle/ParticleCollection.lua

module("logic.common.particle.ParticleCollection", package.seeall)

local ParticleCollection = class("ParticleCollection")

function ParticleCollection:ctor()
	self._handleIdList = {}
end

function ParticleCollection:addParticle(particle)
	table.insert(self._handleIdList, particle.settings:getHandleId())
	particle.settings:setFinishListener(self._onParticleFinish, self)
end

function ParticleCollection:clear()
	for _, handleId in pairs(self._handleIdList) do
		BattleParticleUtil.remove(handleId)
	end

	BattleTableUtil.clearTable(self._handleIdList)
end

function ParticleCollection:_onParticleFinish(handleId)
	table.removebyvalue(self._handleIdList, handleId)
end

return ParticleCollection
