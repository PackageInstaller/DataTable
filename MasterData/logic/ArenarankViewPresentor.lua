-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/view/ArenarankViewPresentor.lua

module("logic.extensions.showoff.view.ArenarankViewPresentor", package.seeall)

local ArenarankViewPresentor = class("ArenarankViewPresentor", ViewPresentor)

function ArenarankViewPresentor:ctor()
	ArenarankViewPresentor.super.ctor(self)
end

function ArenarankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenarankViewPresentor:dependWhatResources()
	return {
		"ui/views/showoff/arenarankview.prefab"
	}
end

function ArenarankViewPresentor:buildViews()
	return {
		ArenarankView.New()
	}
end

function ArenarankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ArenarankViewPresentor
