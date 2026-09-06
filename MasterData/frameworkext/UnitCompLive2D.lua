-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/unit/component/live2D/UnitCompLive2D.lua

module("frameworkext.unit.component.UnitCompLive2D", package.seeall)

local UnitCompLive2D = class("UnitCompLive2D", UnitComponentBase)

function UnitCompLive2D:ctor(unit)
	UnitCompLive2D.super.ctor(self, unit)

	self._prefabUrl = nil
	self._prefabLoader = PrefabLoader.Get(unit.go)
	self._prefabGO = nil
	self._isFlipX = 1
end

function UnitCompLive2D:setDirection(dir)
	local isFlipX = dir

	if self._isFlipX == isFlipX then
		return
	end

	self._isFlipX = isFlipX

	if self._prefabGO and not goutil.isNil(self._prefabGO) then
		local lsx, lsy, lsz = Framework.TransformUtil.GetLocalScale(self._prefabGO.transform, 0, 0, 0)

		Framework.TransformUtil.SetLocalScale(self._prefabGO.transform, lsx * self._isFlipX, lsy, lsz)
	end
end

function UnitCompLive2D:setBody(url)
	if self._prefabUrl == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._prefabUrl = url

	self._prefabLoader:load(url, self._onBodyLoaded, self, true)
end

function UnitCompLive2D:getInst()
	return self._prefabGO
end

function UnitCompLive2D:_onBodyLoaded(loader)
	self._prefabGO = self._prefabLoader:getInst()

	self.dispatch(self, UnitNotify.LiveLoaded, self)
end

function UnitCompLive2D:clear()
	self._prefabLoader:clear()

	self._prefabGO = nil
	self._prefabUrl = nil
end

function UnitCompLive2D:onDestroy()
	self._prefabGO = nil
	self._prefabLoader = nil
	self._prefabUrl = nil
end

return UnitCompLive2D
