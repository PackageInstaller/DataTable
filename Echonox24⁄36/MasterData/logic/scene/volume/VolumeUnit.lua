-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/volume/VolumeUnit.lua

module("logic.scene.volume.VolumeUnit", package.seeall)

local VolumeUnit = class("VolumeUnit", AbstractGlobalReusable)
local kVolumeRoot = goutil.create("VolumeUnits", false)

SceneUtil.moveGameObjectToBaseScene(kVolumeRoot)

function VolumeUnit:ctor()
	self.mainGO = goutil.create("Volume", false)

	goutil.addChildToParent(self.mainGO, kVolumeRoot)
	self:_onBuild()
end

function VolumeUnit:reuse()
	goutil.setActive(self.mainGO, true)
end

function VolumeUnit:reset()
	goutil.setActive(self.mainGO, false)
end

function VolumeUnit:destroy()
	self:_onDestroy()
	goutil.destroy(self.mainGO)

	self.mainGO = nil
end

function VolumeUnit:setPosition(x, y, z)
	TransformUtils.SetPosition(self.mainGO.transform, x, y, z)
end

function VolumeUnit:_onBuild()
	self._resLoader = SingleResLoader.New()
end

function VolumeUnit:_onDestroy()
	if self._volumeObj then
		goutil.destroy(self._volumeObj)
	end

	self._resLoader:clear()

	self._resLoader = false
end

function VolumeUnit:getMainGO()
	return self.mainGO
end

function VolumeUnit:load(url)
	if self._resLoader:isSameResource(url) then
		self:_doFinishCall()

		return
	end

	if self._volumeObj then
		goutil.destroy(self._volumeObj)

		self._volumeObj = false
	end

	self._resLoader:load(url, self._loadFinish, self)
end

function VolumeUnit:_loadFinish()
	self._volumeObj = self._resLoader:getResInstance()

	self:_doFinishCall()
	goutil.addChildToParent(self._volumeObj, self.mainGO)
end

function VolumeUnit:_doFinishCall()
	if self._callback then
		self._callback(self._callbackHandle, self)
	end
end

function VolumeUnit:setCallBack(func, funcHandle)
	self._callback = func
	self._callbackHandle = funcHandle
end

function VolumeUnit:getVolumeGo()
	return self._volumeObj or false
end

return VolumeUnit
