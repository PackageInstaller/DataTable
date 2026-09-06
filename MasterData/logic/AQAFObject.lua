-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFObject.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFObject", package.seeall)

local AQAFObject = class("AQAFObject")

function AQAFObject:ctor()
	if self._resLoader then
		self._resloader:clear()
	end

	self._visible = true
	self._assetPath = nil
	self._cacheLast = self:_isCacheLast()
	self._resLoader = AQAFResLoader.New(self._cacheLast, self.loadedHandle, self)
end

function AQAFObject:_isCacheLast()
	return true
end

function AQAFObject:load(assetPath)
	if assetPath ~= nil then
		self._assetPath = assetPath

		if self:getResPath() == self._assetPath and self:isLoaded() then
			self:callBackHandle(self._resLoader)
		else
			self._resLoader:load(self._assetPath)
		end
	end
end

function AQAFObject:isLoaded()
	return self._resLoader:isLoaded()
end

function AQAFObject:isGoLoaded()
	return self._resLoader:isGoLoaded()
end

function AQAFObject:getResPath()
	return self._resLoader:getResPath()
end

function AQAFObject:loadedHandle(loader)
	self:callBackHandle(loader)
end

function AQAFObject:callBackHandle(loader)
	return
end

function AQAFObject:getResObject()
	return self._resLoader:getResObject()
end

function AQAFObject:getGameObject()
	return self._resLoader:getGameObject()
end

function AQAFObject:setVisible(visible)
	self._visible = checkbool(visible)

	local resObject = self:getGameObject()

	if resObject then
		GameUtil.SetActive(resObject, self._visible)
	end
end

function AQAFObject:destroy()
	self:setVisible(false)

	if self._resLoader then
		self._resLoader:clear()
	end

	self._assetPath = nil
end

return AQAFObject
