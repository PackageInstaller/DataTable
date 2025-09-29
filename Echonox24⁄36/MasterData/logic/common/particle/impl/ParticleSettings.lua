-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/particle/impl/ParticleSettings.lua

module("logic.common.particle.impl.ParticleSettings", package.seeall)

local ParticleSettings = class("ParticleSettings")

function ParticleSettings:ctor(particleUnit)
	self._handleId = 0
	self._particleUnit = particleUnit
	self._currentTime = 0
	self._lifeTime = false
	self._mainGO = false
	self._parentGO = false
	self._localPosition = Vector3.New()
	self._finishHandler = Handler.New()
end

function ParticleSettings:clear()
	FrameUpdate:removeListener(self)

	self._currentTime = 0
	self._lifeTime = false
	self._mainGO = false
	self._parentGO = false

	self._localPosition:Set(0, 0, 0)
	self._finishHandler:callAndClear(self._handleId)
end

function ParticleSettings:setHandleId(handleId)
	self._handleId = handleId
end

function ParticleSettings:getHandleId()
	return self._handleId
end

function ParticleSettings:setMainGO(goInst)
	self._mainGO = goInst

	if not goutil.isNil(self._parentGO) then
		goutil.addChildToParent(goInst, self._parentGO or nil)
	end

	Astral.TransformUtil.SetLocalPos(goInst.transform, self._localPosition.x, self._localPosition.y, self._localPosition.z)

	if self._lifeTime then
		FrameUpdate:addListener(self)
	end
end

function ParticleSettings:setFinishListener(callback, callbackSelf)
	self._finishHandler:setListener(callback, callbackSelf)
end

function ParticleSettings:getParentGO()
	return self._parentGO
end

function ParticleSettings:getMainGO()
	return self._mainGO
end

function ParticleSettings:setParentGO(goParent)
	self._parentGO = goParent

	if self:isLoaded() then
		goutil.addChildToParent(self._mainGO, goParent or nil)
	end
end

function ParticleSettings:setLifeTime(lifeTime)
	self._lifeTime = lifeTime >= 0 and lifeTime or false

	if self:isLoaded() and self._lifeTime then
		if FrameUpdate:hasListener(self) then
			return
		end

		FrameUpdate:addListener(self)
	end
end

function ParticleSettings:setLocalPosition(x, y, z)
	self._localPosition:Set(x, y, z)

	if self:isLoaded() then
		Astral.TransformUtil.SetLocalPos(self._mainGO.transform, x, y, z)
	end
end

function ParticleSettings:luaUpdate(deltaTime)
	self._currentTime = self._currentTime + deltaTime

	if self._currentTime >= self._lifeTime then
		self._particleUnit:internal_onParticleFinish()
	end
end

function ParticleSettings:isLoaded()
	return self._mainGO
end

return ParticleSettings
