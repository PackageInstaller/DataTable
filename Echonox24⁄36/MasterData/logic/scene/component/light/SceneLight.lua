-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/light/SceneLight.lua

module("logic.scene.component.light.SceneLight", package.seeall)

local SceneLight = class("SceneLight", SceneComponentBase)

function SceneLight:onInit()
	self._mainLightCodeList = {}
	self._performanceLightCodeList = {}
end

function SceneLight:onEnterScene(sceneId, bornX, bornZ)
	return
end

function SceneLight:onExitScene()
	self:turnOffAllMainLight()
	self:turnOffAllPerformanceLight()
end

function SceneLight:turnOnAllMainLight()
	self:_turnOnLights(self._mainLightCodeList)
end

function SceneLight:turnOffAllMainLight()
	self:_turnOffLights(self._mainLightCodeList)
end

function SceneLight:turnOnAllPerformanceLight()
	self:_turnOnLights(self._performanceLightCodeList)
end

function SceneLight:turnOffAllPerformanceLight()
	self:_turnOffLights(self._performanceLightCodeList)
end

function SceneLight:_turnOnLights(lightCodes)
	for _, lightCode in ipairs(lightCodes) do
		LightMgr.instance:turnOn(lightCode)
	end
end

function SceneLight:_turnOffLights(lightCodes)
	for _, lightCode in ipairs(lightCodes) do
		LightMgr.instance:turnOff(lightCode)
	end
end

return SceneLight
