-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFResLoader.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFResLoader", package.seeall)

local AQAFResLoader = class("AQAFResLoader")

function AQAFResLoader:ctor(cacheLast, loadedHandler, loadedHandlerObj)
	self._cacheLast = cacheLast
	self._loadedHandler = loadedHandler
	self._loadedHandlerObj = loadedHandlerObj
	self._lastResObject = nil
	self._resObject = nil
	self._lastAssetPath = nil
	self._assetPath = nil
end

function AQAFResLoader:setPreRecycleHandler(handler, handlerObj)
	self._preRecycleHandler = handler
	self._preRecycleHandlerObj = handlerObj
end

function AQAFResLoader:load(assetPath)
	if self._assetPath == assetPath then
		return
	end

	self:_clearLastResObject()

	if self._cacheLast then
		self._lastResObject = self._resObject
		self._lastAssetPath = self._assetPath
		self._resObject = nil
	else
		self:_clearResObject()
	end

	self._assetPath = assetPath
	self._resObject = ResCache.instance:newObject(assetPath, self._onResLoaded, self)
end

function AQAFResLoader:getResObject()
	return self._resObject
end

function AQAFResLoader:getResPath()
	return self._assetPath
end

function AQAFResLoader:getGameObject()
	if self._resObject then
		return self._resObject.go
	end
end

function AQAFResLoader:clear()
	self:_clearResObject()
	self:_clearLastResObject()
end

function AQAFResLoader:isLoaded()
	if not self._assetPath then
		return true
	end

	return self._resObject and true
end

function AQAFResLoader:isGoLoaded()
	if not self._assetPath then
		return true
	end

	return self._resObject and self._resObject.go and self._resObject.isEnabled
end

function AQAFResLoader:setParent(parent)
	if self._resObject then
		self._resObject:setParent(parent)
		self._resObject:setLocalPos(0, 0, 0)
		self._resObject:setRotation(0, 0, 0)
		self._resObject:setScale(1, 1, 1)
	end
end

function AQAFResLoader:_onResLoaded(resObject)
	if resObject == self._resObject then
		self:_clearLastResObject()

		if self._loadedHandler then
			if self._loadedHandlerObj then
				self._loadedHandler(self._loadedHandlerObj, self)
			else
				self:_loadedHandler()
			end
		end
	else
		ResCache.instance:recycleObject(resObject)
	end
end

function AQAFResLoader:_clearLastResObject()
	if self._lastResObject then
		self:_preHandleRecycle(self._lastResObject)
		ResCache.instance:recycleObject(self._lastResObject)

		self._lastResObject = nil
	end

	self._lastAssetPath = nil
end

function AQAFResLoader:_clearResObject()
	if self._resObject then
		self:_preHandleRecycle(self._resObject)
		ResCache.instance:recycleObject(self._resObject)

		self._resObject = nil
	end

	self._assetPath = nil
end

function AQAFResLoader:_preHandleRecycle(resObject)
	if self._preRecycleHandler then
		if self._preRecycleHandlerObj then
			self._preRecycleHandler(self._preRecycleHandlerObj, self, resObject)
		else
			self:_preRecycleHandler(resObject)
		end
	end
end

return AQAFResLoader
