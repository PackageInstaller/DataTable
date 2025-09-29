-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/light/LightMgr.lua

module("logic.scene.light.LightMgr", package.seeall)

local LightMgr = class("LightMgr")
local MAX_COUNT = 5

function LightMgr:ctor()
	LightUnit:preparePool(MAX_COUNT)

	self._lightTable = {}
	self._currentCount = 0
end

function LightMgr:getTemporaryLight(lightCode)
	local lightCO = LightConfig.instance:getLightCO(lightCode)
	local light = LightUnit:createInstance()

	light:load(GameUrl.getLightUrl(lightCO.resPath))

	return light
end

function LightMgr:releaseTemporaryLight(light)
	light:returnSelf()
end

function LightMgr:turnOn(lightCode)
	local light = self._lightTable[lightCode]

	if not light then
		self:_tryRecycleLight()

		light = self:getTemporaryLight(lightCode)
		self._lightTable[lightCode] = light
		self._currentCount = self._currentCount + 1
	end

	light:turnOn()
end

function LightMgr:turnOff(lightCode)
	local light = self._lightTable[lightCode]

	if not light then
		return
	end

	light:turnOff()
end

function LightMgr:_tryRecycleLight()
	if self._currentCount < MAX_COUNT then
		return
	end

	for lightCode, light in pairs(self._lightTable) do
		if not light:isTurnOn() then
			self:releaseTemporaryLight(light)

			self._lightTable[lightCode] = false
			self._currentCount = self._currentCount - 1
		end
	end
end

LightMgr.instance = LightMgr.New()

return LightMgr
