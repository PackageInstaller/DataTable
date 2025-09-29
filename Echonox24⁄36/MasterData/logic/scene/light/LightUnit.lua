-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/light/LightUnit.lua

module("logic.scene.light.LightUnit", package.seeall)

local LightUnit = class("LightUnit", AbstractGlobalReusable)
local kLightRoot = goutil.create("Lights", false)

SceneUtil.moveGameObjectToBaseScene(kLightRoot)

function LightUnit:ctor()
	self.mainGO = goutil.create("Light", false)

	goutil.addChildToParent(self.mainGO, kLightRoot)
	self:_onBuild()
end

function LightUnit:reuse()
	self:turnOn()
end

function LightUnit:reset()
	self:turnOff()
end

function LightUnit:destroy()
	self:_onDestroy()
	goutil.destroy(self.mainGO)

	self.mainGO = nil
end

function LightUnit:_onBuild()
	self._resLoader = PrefabLoader.Get(self.mainGO)
end

function LightUnit:_onDestroy()
	self._resLoader:clear()

	self._resLoader = false
end

function LightUnit:getMainGO()
	return self.mainGO
end

function LightUnit:turnOn()
	goutil.setActive(self.mainGO, true)
end

function LightUnit:turnOff()
	goutil.setActive(self.mainGO, false)
end

function LightUnit:isTurnOn()
	return self.mainGO and self.mainGO.activeSelf or false
end

function LightUnit:load(url)
	self._resLoader:load(url)
end

function LightUnit:getInst()
	return self._resLoader:getInst()
end

return LightUnit
