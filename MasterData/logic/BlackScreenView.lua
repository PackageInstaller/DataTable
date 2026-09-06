-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/BlackScreenView.lua

module("logic.extensions.story.view.BlackScreenView", package.seeall)

local BlackScreenView = class("BlackScreenView", ViewComponent)

function BlackScreenView:buildUI()
	self._image = self:getGo("Image"):GetComponent("Image")
	self._tween = self._image:GetComponent(UnityTweensType.UITweenFadeOut)
end

function BlackScreenView:onEnter()
	Game.ImageUtil.SetImageAlpha(self._image, 1)
	self._tween:AddListener(self._onBlackScreenFinish, self)
	self._tween:Stop()
	self._tween:Begin()
end

function BlackScreenView:onExit()
	Game.ImageUtil.SetImageAlpha(self._image, 1)
	self._tween:RemoveListener()
end

function BlackScreenView:_onBlackScreenFinish()
	self:close()
end

return BlackScreenView
